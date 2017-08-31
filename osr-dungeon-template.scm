(define (script-fu-osr-dungeon-template w h c)
	(let*
		(
			(i (car (gimp-image-new w h 0)))
			(background-layer (car (gimp-layer-new i w h 1 "Background" 100 0)))
			(walls-layer (car (gimp-layer-new i w h 1 "Walls" 100 0)))
			(doors-layer (car (gimp-layer-new i w h 1 "Doors" 100 0)))
			(furnishings-layer (car (gimp-layer-new i w h 1 "Furnishings" 100 0)))
			(secrets-layer (car (gimp-layer-new i w h 1 "Secrets" 100 0)))
			(labels-layer (car (gimp-layer-new i w h 1 "Labels" 100 0)))
		)
		; Add all new layers
		(gimp-image-insert-layer i background-layer 0 -1)
		(gimp-image-insert-layer i walls-layer 0 -1)
		(gimp-image-insert-layer i doors-layer 0 -1)
		(gimp-image-insert-layer i furnishings-layer 0 -1)
		(gimp-image-insert-layer i secrets-layer 0 -1)
		(gimp-image-insert-layer i labels-layer 0 -1)
		; Set up the UI grid for the user
		(gimp-image-grid-set-offset i 0 0) ; just in case
		(gimp-image-grid-set-spacing i 50 50)
		(gimp-image-grid-set-style i 1) ; 1 is intersections(crosshairs)
		; Set up colors and background
		(gimp-context-set-foreground c)
		(gimp-context-set-background '(255 255 255)) ;white
		(gimp-drawable-fill background-layer 1) ; 1 is background fill
		; Render an actual grid on the image
		(plug-in-grid 1 i background-layer 1 50 0 c 255 1 50 0 c 255 0 0 0 c 255)
		; Display it!
		(gimp-display-new i) ; reminder, only valid with a UI
		(gimp-display-flush) ; dunno if this is necessary
		(gimp-image-clean-all i) ; mark image as clean
	)
)

; Could as a pixel-base as an arg, and change the steps for W/H...
(script-fu-register
"script-fu-osr-dungeon-template"                        ;func name
"OSR Dungeon Template"                                  ;menu label
"Creates a layered dungeon template,\
in OSR old-school blue (by default)\
of specified size with a 50px base."              ;description
"James Niemira"                             ;author
"copyright 2017, James Niemira"        ;copyright notice
"August 30, 2017"                          ;date created
""                     ;image type that the script works on
SF-ADJUSTMENT "Width"  '(1000 50 10000 50 100 0 0)
SF-ADJUSTMENT "Height" '(1000 50 10000 50 100 0 0)
SF-COLOR      "Color"  '(24 118 157)     ;color variable, 24,118,157 is decimal of #18769d
)
(script-fu-menu-register "script-fu-osr-dungeon-template" "<Image>/File/Create/Dungeon")
Message-ID: <3820A90B.E0D77EDE@denise.shiny.it>
Date: Wed, 03 Nov 1999 22:28:43 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [patch] controlfb update
Content-Type: multipart/mixed;
 boundary="------------E1B7FBA721308A401B87EA84"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------E1B7FBA721308A401B87EA84
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Hi!  I've just linked this ML, so if someone already send a similar patch,
please don't shot me :)
This patch make possible to pass boot parameters to the "control" display
driver.

Bye.
--------------E1B7FBA721308A401B87EA84
Content-Type: text/plain; charset=us-ascii;
 name="control.patch.2.2.13"
Content-Disposition: inline;
 filename="control.patch.2.2.13"
Content-Transfer-Encoding: 7bit

--- drivers/video/fbmem.old	Wed Sep  1 18:50:55 1999
+++ drivers/video/fbmem.c	Wed Sep  1 18:58:34 1999
@@ -92,6 +92,8 @@
 extern void sbusfb_setup(char *options, int *ints);
 extern void valkyriefb_init(void);
 extern void valkyriefb_setup(char *options, int *ints);
+extern void control_init(void);
+extern void control_setup(char *options, int *ints);
 extern void g364fb_init(void);
 extern void fm2fb_init(void);
 extern void fm2fb_setup(char *options, int *ints);
@@ -178,6 +180,9 @@
 #endif 
 #ifdef CONFIG_FB_VALKYRIE
 	{ "valkyriefb", valkyriefb_init, valkyriefb_setup },
+#endif
+#ifdef CONFIG_FB_CONTROL
+	{ "controlfb", control_init, control_setup },
 #endif
 #ifdef CONFIG_FB_G364
 	{ "g364", g364fb_init, NULL },
--- drivers/video/controlfb.old	Wed Sep  1 18:30:38 1999
+++ drivers/video/controlfb.c	Wed Sep  1 19:44:06 1999
@@ -531,24 +531,30 @@
 
 	p->sense = read_control_sense(p);
 	printk(KERN_INFO "Monitor sense value = 0x%x, ", p->sense);
+
 	/* Try to pick a video mode out of NVRAM if we have one. */
-	par->vmode = nvram_read_byte(NV_VMODE);
-	if(par->vmode <= 0 || par->vmode > VMODE_MAX || !control_reg_init[par->vmode - 1])
-		par->vmode = VMODE_CHOOSE;
-	if(par->vmode == VMODE_CHOOSE)
-		par->vmode = mac_map_monitor_sense(p->sense);
-	if(!control_reg_init[par->vmode - 1])
-		par->vmode = VMODE_640_480_60;
+	if (default_vmode == VMODE_NVRAM){
+		par->vmode = nvram_read_byte(NV_VMODE);
+		if(par->vmode <= 0 || par->vmode > VMODE_MAX || !control_reg_init[par->vmode - 1])
+			par->vmode = VMODE_CHOOSE;
+		if(par->vmode == VMODE_CHOOSE)
+			par->vmode = mac_map_monitor_sense(p->sense);
+		if(!control_reg_init[par->vmode - 1])
+			par->vmode = VMODE_640_480_60;}
+	else
+		par->vmode=default_vmode;
 
-	par->cmode = nvram_read_byte(NV_CMODE);
-	if(par->cmode < CMODE_8 || par->cmode > CMODE_32)
-		par->cmode = CMODE_8;
-	/*
-	 * Reduce the pixel size if we don't have enough VRAM.
-	 */
+	if (default_cmode == CMODE_NVRAM){
+		par->cmode = nvram_read_byte(NV_CMODE);
+		if(par->cmode < CMODE_8 || par->cmode > CMODE_32)
+			par->cmode = CMODE_8;}
+	else
+		par->cmode=default_cmode;
+
+	/* Reduce the pixel size if we don't have enough VRAM. */
 	while(par->cmode > CMODE_8 && control_vram_reqd(par->vmode, par->cmode) > p->total_vram)
 		par->cmode--;
-	
+
 	printk("using video mode %d and color mode %d.\n", par->vmode, par->cmode);
 	
 	par->vxres = par->xres = control_reg_init[par->vmode - 1]->hres;
@@ -1176,9 +1182,9 @@
 		}
 		if (!strncmp(this_opt, "vmode:", 6)) {
 			int vmode = simple_strtoul(this_opt+6, NULL, 0);
-		if (vmode > 0 && vmode <= VMODE_MAX)
-			default_vmode = vmode;
-		} else if (!strncmp(this_opt, "cmode:", 6)) {
+			if (vmode > 0 && vmode <= VMODE_MAX)
+				default_vmode = vmode;}
+		else if (!strncmp(this_opt, "cmode:", 6)) {
 			int depth = simple_strtoul(this_opt+6, NULL, 0);
 			switch (depth) {
 			 case CMODE_8:

--------------E1B7FBA721308A401B87EA84--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

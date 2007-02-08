Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 97B51DE238
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:59:02 +1100 (EST)
Date: Thu, 8 Feb 2007 14:59:00 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/10] fbdev modedb: make more pointer parameters const
In-Reply-To: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0702081458510.19437@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

fbdev modedb: make more input and output pointer parameters const

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/console/fbcon.c          |    4 ++--
 drivers/video/console/fbcon.h          |    2 +-
 drivers/video/fbsysfs.c                |    2 +-
 drivers/video/i810/i810_main.c         |    4 ++--
 drivers/video/modedb.c                 |   33 +++++++++++++++++----------------
 drivers/video/nvidia/nvidia.c          |    8 ++++----
 drivers/video/riva/fbdev.c             |    5 +++--
 drivers/video/savage/savagefb_driver.c |   12 ++++++------
 include/linux/fb.h                     |   31 ++++++++++++++++---------------
 9 files changed, 52 insertions(+), 49 deletions(-)

--- ps3-linux-2.6.20.orig/drivers/video/console/fbcon.c
+++ ps3-linux-2.6.20/drivers/video/console/fbcon.c
@@ -2071,7 +2071,7 @@ static int fbcon_resize(struct vc_data *
 	y_diff = info->var.yres - var.yres;
 	if (x_diff < 0 || x_diff > virt_fw ||
 	    y_diff < 0 || y_diff > virt_fh) {
-		struct fb_videomode *mode;
+		const struct fb_videomode *mode;
 
 		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
 		mode = fb_find_best_mode(&var, &info->modelist);
@@ -2975,7 +2975,7 @@ static void fbcon_new_modelist(struct fb
 	int i;
 	struct vc_data *vc;
 	struct fb_var_screeninfo var;
-	struct fb_videomode *mode;
+	const struct fb_videomode *mode;
 
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (registered_fb[con2fb_map[i]] != info)
--- ps3-linux-2.6.20.orig/drivers/video/console/fbcon.h
+++ ps3-linux-2.6.20/drivers/video/console/fbcon.h
@@ -48,7 +48,7 @@ struct display {
     struct fb_bitfield green;
     struct fb_bitfield blue;
     struct fb_bitfield transp;
-    struct fb_videomode *mode;
+    const struct fb_videomode *mode;
 };
 
 struct fbcon_ops {
--- ps3-linux-2.6.20.orig/drivers/video/fbsysfs.c
+++ ps3-linux-2.6.20/drivers/video/fbsysfs.c
@@ -175,7 +175,7 @@ static ssize_t store_modes(struct device
 
 	acquire_console_sem();
 	list_splice(&fb_info->modelist, &old_list);
-	fb_videomode_to_modelist((struct fb_videomode *)buf, i,
+	fb_videomode_to_modelist((const struct fb_videomode *)buf, i,
 				 &fb_info->modelist);
 	if (fb_new_modelist(fb_info)) {
 		fb_destroy_modelist(&fb_info->modelist);
--- ps3-linux-2.6.20.orig/drivers/video/i810/i810_main.c
+++ ps3-linux-2.6.20/drivers/video/i810/i810_main.c
@@ -1049,7 +1049,7 @@ static int i810_check_params(struct fb_v
 		mode_valid = 1;
 
 	if (!mode_valid && info->monspecs.modedb_len) {
-		struct fb_videomode *mode;
+		const struct fb_videomode *mode;
 
 		mode = fb_find_best_mode(var, &info->modelist);
 		if (mode) {
@@ -1919,7 +1919,7 @@ static void __devinit i810fb_find_init_m
 	fb_videomode_to_modelist(specs->modedb, specs->modedb_len,
 				 &info->modelist);
 	if (specs->modedb != NULL) {
-		struct fb_videomode *m;
+		const struct fb_videomode *m;
 
 		if (xres && yres) {
 			if ((m = fb_find_best_mode(&var, &info->modelist))) {
--- ps3-linux-2.6.20.orig/drivers/video/modedb.c
+++ ps3-linux-2.6.20/drivers/video/modedb.c
@@ -668,7 +668,7 @@ done:
  * @var: pointer to struct fb_var_screeninfo
  */
 void fb_var_to_videomode(struct fb_videomode *mode,
-			 struct fb_var_screeninfo *var)
+			 const struct fb_var_screeninfo *var)
 {
 	u32 pixclock, hfreq, htotal, vtotal;
 
@@ -712,7 +712,7 @@ void fb_var_to_videomode(struct fb_video
  * @mode: pointer to struct fb_videomode
  */
 void fb_videomode_to_var(struct fb_var_screeninfo *var,
-			       struct fb_videomode *mode)
+			 const struct fb_videomode *mode)
 {
 	var->xres = mode->xres;
 	var->yres = mode->yres;
@@ -735,8 +735,8 @@ void fb_videomode_to_var(struct fb_var_s
  * RETURNS:
  * 1 if equal, 0 if not
  */
-int fb_mode_is_equal(struct fb_videomode *mode1,
-		     struct fb_videomode *mode2)
+int fb_mode_is_equal(const struct fb_videomode *mode1,
+		     const struct fb_videomode *mode2)
 {
 	return (mode1->xres         == mode2->xres &&
 		mode1->yres         == mode2->yres &&
@@ -768,8 +768,8 @@ int fb_mode_is_equal(struct fb_videomode
  * var->xres and var->yres.  If more than 1 videomode is found, will return
  * the videomode with the highest refresh rate
  */
-struct fb_videomode *fb_find_best_mode(struct fb_var_screeninfo *var,
-				       struct list_head *head)
+const struct fb_videomode *fb_find_best_mode(const struct fb_var_screeninfo *var,
+					     struct list_head *head)
 {
 	struct list_head *pos;
 	struct fb_modelist *modelist;
@@ -806,8 +806,8 @@ struct fb_videomode *fb_find_best_mode(s
  * If more than 1 videomode is found, will return the videomode with
  * the closest refresh rate.
  */
-struct fb_videomode *fb_find_nearest_mode(struct fb_videomode *mode,
-					  struct list_head *head)
+const struct fb_videomode *fb_find_nearest_mode(const struct fb_videomode *mode,
+					        struct list_head *head)
 {
 	struct list_head *pos;
 	struct fb_modelist *modelist;
@@ -845,8 +845,8 @@ struct fb_videomode *fb_find_nearest_mod
  * RETURNS:
  * struct fb_videomode, NULL if none found
  */
-struct fb_videomode *fb_match_mode(struct fb_var_screeninfo *var,
-				   struct list_head *head)
+const struct fb_videomode *fb_match_mode(const struct fb_var_screeninfo *var,
+					 struct list_head *head)
 {
 	struct list_head *pos;
 	struct fb_modelist *modelist;
@@ -870,7 +870,7 @@ struct fb_videomode *fb_match_mode(struc
  * NOTES:
  * Will only add unmatched mode entries
  */
-int fb_add_videomode(struct fb_videomode *mode, struct list_head *head)
+int fb_add_videomode(const struct fb_videomode *mode, struct list_head *head)
 {
 	struct list_head *pos;
 	struct fb_modelist *modelist;
@@ -905,7 +905,8 @@ int fb_add_videomode(struct fb_videomode
  * NOTES:
  * Will remove all matching mode entries
  */
-void fb_delete_videomode(struct fb_videomode *mode, struct list_head *head)
+void fb_delete_videomode(const struct fb_videomode *mode,
+			 struct list_head *head)
 {
 	struct list_head *pos, *n;
 	struct fb_modelist *modelist;
@@ -941,7 +942,7 @@ void fb_destroy_modelist(struct list_hea
  * @num: number of entries in array
  * @head: struct list_head of modelist
  */
-void fb_videomode_to_modelist(struct fb_videomode *modedb, int num,
+void fb_videomode_to_modelist(const struct fb_videomode *modedb, int num,
 			      struct list_head *head)
 {
 	int i;
@@ -954,12 +955,12 @@ void fb_videomode_to_modelist(struct fb_
 	}
 }
 
-struct fb_videomode *fb_find_best_display(struct fb_monspecs *specs,
-					  struct list_head *head)
+const struct fb_videomode *fb_find_best_display(const struct fb_monspecs *specs,
+					        struct list_head *head)
 {
 	struct list_head *pos;
 	struct fb_modelist *modelist;
-	struct fb_videomode *m, *m1 = NULL, *md = NULL, *best = NULL;
+	const struct fb_videomode *m, *m1 = NULL, *md = NULL, *best = NULL;
 	int first = 0;
 
 	if (!head->prev || !head->next || list_empty(head))
--- ps3-linux-2.6.20.orig/drivers/video/nvidia/nvidia.c
+++ ps3-linux-2.6.20/drivers/video/nvidia/nvidia.c
@@ -829,7 +829,7 @@ static int nvidiafb_check_var(struct fb_
 	}
 
 	if (!mode_valid) {
-		struct fb_videomode *mode;
+		const struct fb_videomode *mode;
 
 		mode = fb_find_best_mode(var, &info->modelist);
 		if (mode) {
@@ -1046,10 +1046,10 @@ static int __devinit nvidia_set_fbinfo(s
 	}
 
 	if (specs->modedb != NULL) {
-		struct fb_videomode *modedb;
+		const struct fb_videomode *mode;
 
-		modedb = fb_find_best_display(specs, &info->modelist);
-		fb_videomode_to_var(&nvidiafb_default_var, modedb);
+		mode = fb_find_best_display(specs, &info->modelist);
+		fb_videomode_to_var(&nvidiafb_default_var, mode);
 		nvidiafb_default_var.bits_per_pixel = bpp;
 	} else if (par->fpWidth && par->fpHeight) {
 		char buf[16];
--- ps3-linux-2.6.20.orig/drivers/video/riva/fbdev.c
+++ ps3-linux-2.6.20/drivers/video/riva/fbdev.c
@@ -894,7 +894,8 @@ out:
 	return rc;
 }
 
-static void riva_update_var(struct fb_var_screeninfo *var, struct fb_videomode *modedb)
+static void riva_update_var(struct fb_var_screeninfo *var,
+			    const struct fb_videomode *modedb)
 {
 	NVTRACE_ENTER();
 	var->xres = var->xres_virtual = modedb->xres;
@@ -1148,7 +1149,7 @@ static int rivafb_release(struct fb_info
 
 static int rivafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct fb_videomode *mode;
+	const struct fb_videomode *mode;
 	struct riva_par *par = info->par;
 	int nom, den;		/* translating from pixels->bytes */
 	int mode_valid = 0;
--- ps3-linux-2.6.20.orig/drivers/video/savage/savagefb_driver.c
+++ ps3-linux-2.6.20/drivers/video/savage/savagefb_driver.c
@@ -833,7 +833,8 @@ static void savage_set_default_par(struc
 	vga_out8(0x3d5, cr66, par);
 }
 
-static void savage_update_var(struct fb_var_screeninfo *var, struct fb_videomode *modedb)
+static void savage_update_var(struct fb_var_screeninfo *var,
+			      const struct fb_videomode *modedb)
 {
 	var->xres = var->xres_virtual = modedb->xres;
 	var->yres = modedb->yres;
@@ -902,7 +903,7 @@ static int savagefb_check_var(struct fb_
 	}
 
 	if (!mode_valid) {
-		struct fb_videomode *mode;
+		const struct fb_videomode *mode;
 
 		mode = fb_find_best_mode(var, &info->modelist);
 		if (mode) {
@@ -2206,11 +2207,10 @@ static int __devinit savagefb_probe(stru
 			     info->monspecs.modedb, info->monspecs.modedb_len,
 			     NULL, 8);
 	} else if (info->monspecs.modedb != NULL) {
-		struct fb_videomode *modedb;
+		const struct fb_videomode *mode;
 
-		modedb = fb_find_best_display(&info->monspecs,
-					      &info->modelist);
-		savage_update_var(&info->var, modedb);
+		mode = fb_find_best_display(&info->monspecs, &info->modelist);
+		savage_update_var(&info->var, mode);
 	}
 
 	/* maximize virtual vertical length */
--- ps3-linux-2.6.20.orig/include/linux/fb.h
+++ ps3-linux-2.6.20/include/linux/fb.h
@@ -945,25 +945,26 @@ extern unsigned char *fb_ddc_read(struct
 /* drivers/video/modedb.c */
 #define VESA_MODEDB_SIZE 34
 extern void fb_var_to_videomode(struct fb_videomode *mode,
-				struct fb_var_screeninfo *var);
+				const struct fb_var_screeninfo *var);
 extern void fb_videomode_to_var(struct fb_var_screeninfo *var,
-				struct fb_videomode *mode);
-extern int fb_mode_is_equal(struct fb_videomode *mode1,
-			    struct fb_videomode *mode2);
-extern int fb_add_videomode(struct fb_videomode *mode, struct list_head *head);
-extern void fb_delete_videomode(struct fb_videomode *mode,
+				const struct fb_videomode *mode);
+extern int fb_mode_is_equal(const struct fb_videomode *mode1,
+			    const struct fb_videomode *mode2);
+extern int fb_add_videomode(const struct fb_videomode *mode,
+			    struct list_head *head);
+extern void fb_delete_videomode(const struct fb_videomode *mode,
 				struct list_head *head);
-extern struct fb_videomode *fb_match_mode(struct fb_var_screeninfo *var,
-					  struct list_head *head);
-extern struct fb_videomode *fb_find_best_mode(struct fb_var_screeninfo *var,
-					      struct list_head *head);
-extern struct fb_videomode *fb_find_nearest_mode(struct fb_videomode *mode,
-						 struct list_head *head);
+extern const struct fb_videomode *fb_match_mode(const struct fb_var_screeninfo *var,
+						struct list_head *head);
+extern const struct fb_videomode *fb_find_best_mode(const struct fb_var_screeninfo *var,
+						    struct list_head *head);
+extern const struct fb_videomode *fb_find_nearest_mode(const struct fb_videomode *mode,
+						       struct list_head *head);
 extern void fb_destroy_modelist(struct list_head *head);
-extern void fb_videomode_to_modelist(struct fb_videomode *modedb, int num,
+extern void fb_videomode_to_modelist(const struct fb_videomode *modedb, int num,
 				     struct list_head *head);
-extern struct fb_videomode *fb_find_best_display(struct fb_monspecs *specs,
-						 struct list_head *head);
+extern const struct fb_videomode *fb_find_best_display(const struct fb_monspecs *specs,
+						       struct list_head *head);
 
 /* drivers/video/fbcmap.c */
 extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

Date: Tue, 27 Nov 2001 14:30:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Cc: ajoshi@unixbox.com, lethal@chaoticdreams.org, dan@debian.org,
	Martin Costabel <costabel@wanadoo.fr>
Subject: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
Message-ID: <20011127143058.R13091@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all.  The following patches make slight changes to the vmode/cmode
logic on a few fb drivers.  Now everone consistantly only tries to get
these modes from nvram if CONFIG_NVRAM is defined (otherwise a
compile-time error on everyone but atyfb).  On imsttfb I made the logic
only executed on CONFIG_ALL_PPC, and removed USE_NV_MODES (which
shouldn't be needed now).  However, I have none of this hardware, and I
remember some of these drivers being very touchy.  So could people with
this hardware apply the patch and let me know if it works still?

Maintainers, does this look right?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== drivers/video/controlfb.c 1.9 vs edited =====
--- 1.9/drivers/video/controlfb.c	Fri Nov 16 02:58:17 2001
+++ edited/drivers/video/controlfb.c	Mon Nov 26 22:52:28 2001
@@ -621,14 +621,10 @@

 	full = p->total_vram == 0x400000;

+#ifdef CONFIG_NVRAM
 	/* Try to pick a video mode out of NVRAM if we have one. */
-	if (default_cmode == CMODE_NVRAM){
+	if (default_cmode == CMODE_NVRAM)
 		cmode = nvram_read_byte(NV_CMODE);
-		if(cmode < CMODE_8 || cmode > CMODE_32)
-			cmode = CMODE_8;
-	} else
-		cmode=default_cmode;
-
 	if (default_vmode == VMODE_NVRAM) {
 		vmode = nvram_read_byte(NV_VMODE);
 		if (vmode < 1 || vmode > VMODE_MAX ||
@@ -639,15 +635,16 @@
 			if (control_mac_modes[vmode - 1].m[full] < cmode)
 				vmode = VMODE_640_480_60;
 		}
-	} else {
-		vmode=default_vmode;
-		if (control_mac_modes[vmode - 1].m[full] < cmode) {
-			if (cmode > CMODE_8)
-				cmode--;
-			else
-				vmode = VMODE_640_480_60;
-		}
 	}
+#endif
+
+	/* If we didn't get something from NVRAM, pick a
+	 * sane default.
+	 */
+	if (vmode <= 0 || vmode > VMODE_MAX)
+		vmode = VMODE_640_480_67;
+	if (cmode < CMODE_8 || cmode > CMODE_32)
+		cmode = CMODE_8;

 	if (mac_vmode_to_var(vmode, cmode, &var) < 0) {
 		/* This shouldn't happen! */
===== drivers/video/imsttfb.c 1.11 vs edited =====
--- 1.11/drivers/video/imsttfb.c	Fri Nov 16 02:58:18 2001
+++ edited/drivers/video/imsttfb.c	Mon Nov 26 22:52:11 2001
@@ -371,7 +371,6 @@
 	TVP = 1
 };

-#define USE_NV_MODES		1
 #define INIT_BPP		8
 #define INIT_XRES		640
 #define INIT_YRES		480
@@ -384,7 +383,8 @@
 static char curblink __initdata = 1;
 static char noaccel __initdata = 0;
 #if defined(CONFIG_PPC)
-static signed char init_vmode __initdata = -1, init_cmode __initdata = -1;
+static signed char init_vmode __initdata = VMODE_NVRAM;
+static signed char init_cmode __initdata = CMODE_NVRAM;
 #endif

 static struct imstt_regvals tvp_reg_init_2 = {
@@ -1804,20 +1804,25 @@
 		}
 	}

-#if USE_NV_MODES && defined(CONFIG_PPC)
+#ifdef CONFIG_ALL_PPC
 	{
 		int vmode = init_vmode, cmode = init_cmode;

-		if (vmode == -1) {
+#ifdef CONFIG_NVRAM
+		/* Attempt to read vmode/cmode from NVRAM */
+		if (vmode == VMODE_NVRAM)
 			vmode = nvram_read_byte(NV_VMODE);
-			if (vmode <= 0 || vmode > VMODE_MAX)
-				vmode = VMODE_640_480_67;
-		}
-		if (cmode == -1) {
+		if (cmode == CMODE_NVRAM)
 			cmode = nvram_read_byte(NV_CMODE);
-			if (cmode < CMODE_8 || cmode > CMODE_32)
-				cmode = CMODE_8;
-		}
+#endif
+		/* If we didn't get something from NVRAM, pick a
+		 * sane default.
+		 */
+		if (vmode <= 0 || vmode > VMODE_MAX)
+			vmode = VMODE_640_480_67;
+		if (cmode < CMODE_8 || cmode > CMODE_32)
+			cmode = CMODE_8;
+
 		if (mac_vmode_to_var(vmode, cmode, &p->disp.var)) {
 			p->disp.var.xres = p->disp.var.xres_virtual = INIT_XRES;
 			p->disp.var.yres = p->disp.var.yres_virtual = INIT_YRES;
===== drivers/video/platinumfb.c 1.5 vs edited =====
--- 1.5/drivers/video/platinumfb.c	Fri Nov 16 13:45:57 2001
+++ edited/drivers/video/platinumfb.c	Tue Nov 27 07:53:20 2001
@@ -558,19 +558,20 @@
 	sense = read_platinum_sense(info);
 	printk(KERN_INFO "Monitor sense value = 0x%x, ", sense);

+#ifdef CONFIG_NVRAM
 	if (default_vmode == VMODE_NVRAM) {
 		default_vmode = nvram_read_byte(NV_VMODE);
 		if (default_vmode <= 0 || default_vmode > VMODE_MAX ||
 		    !platinum_reg_init[default_vmode-1])
 			default_vmode = VMODE_CHOOSE;
 	}
-	if (default_vmode == VMODE_CHOOSE) {
+	if (default_cmode == CMODE_NVRAM)
+		default_cmode = nvram_read_byte(NV_CMODE);
+#endif
+	if (default_vmode == VMODE_CHOOSE)
 		default_vmode = mac_map_monitor_sense(sense);
-	}
 	if (default_vmode <= 0 || default_vmode > VMODE_MAX)
 		default_vmode = VMODE_640_480_60;
-	if (default_cmode == CMODE_NVRAM)
-		default_cmode = nvram_read_byte(NV_CMODE);
 	if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 		default_cmode = CMODE_8;
 	/*
===== drivers/video/valkyriefb.c 1.5 vs edited =====
--- 1.5/drivers/video/valkyriefb.c	Fri Nov 16 13:45:58 2001
+++ edited/drivers/video/valkyriefb.c	Tue Nov 27 07:53:44 2001
@@ -444,6 +444,7 @@
 	p->sense = read_valkyrie_sense(p);
 	printk(KERN_INFO "Monitor sense value = 0x%x, ", p->sense);

+#ifdef CONFIG_NVRAM
 	/* Try to pick a video mode out of NVRAM if we have one. */
 	if (default_vmode == VMODE_NVRAM) {
 		default_vmode = nvram_read_byte(NV_VMODE);
@@ -452,13 +453,14 @@
 		 || !valkyrie_reg_init[default_vmode - 1])
 			default_vmode = VMODE_CHOOSE;
 	}
+	if (default_cmode == CMODE_NVRAM)
+		default_cmode = nvram_read_byte(NV_CMODE);
+#endif
+
 	if (default_vmode == VMODE_CHOOSE)
 		default_vmode = mac_map_monitor_sense(p->sense);
 	if (!valkyrie_reg_init[default_vmode - 1])
 		default_vmode = VMODE_640_480_67;
-	if (default_cmode == CMODE_NVRAM)
-		default_cmode = nvram_read_byte(NV_CMODE);
-
 	/*
 	 * Reduce the pixel size if we don't have enough VRAM or bandwitdh.
 	 */
===== drivers/video/aty/atyfb_base.c 1.6 vs edited =====
--- 1.6/drivers/video/aty/atyfb_base.c	Wed Oct 31 09:09:50 2001
+++ edited/drivers/video/aty/atyfb_base.c	Mon Nov 26 22:39:15 2001
@@ -258,7 +258,7 @@
 #endif

 #ifdef CONFIG_PPC
-#ifdef CONFIG_NVRAM_NOT_DEFINED
+#ifndef CONFIG_NVRAM
 static int default_vmode __initdata = VMODE_NVRAM;
 static int default_cmode __initdata = CMODE_NVRAM;
 #else

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

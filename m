Date: Fri, 27 Oct 2000 21:02:49 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@linuxcare.com.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18pre17 again
Message-ID: <20001027210249.A15477@suse.de>
References: <14839.53124.753011.489351@argo.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
In-Reply-To: <14839.53124.753011.489351@argo.linuxcare.com.au>; from paulus@linuxcare.com.au on Thu, Oct 26, 2000 at 05:30:28PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 26, Paul Mackerras wrote:

>
> I have updated my rsync trees with some more changes to my current
> 2.2.18pre17 source, mostly to allow a range of configs to compile
> successfully.  I have also checked in the changes to the linuxppc_2_2
> bk tree.  Prep-only configs should compile ok now and as a bonus they
> no longer include all the pmac and chrp code that they used to.
>
> If anyone gets compile errors with my 2.2.18pre17 tree, or the current
> bk tree, please send me your .config.  I'm making a collection. :)
>
> My primary rsync tree for the 2.2 kernel source is now at
> ppc.linuxcare.com::linux-pmac-stable.  There is also a copy at
> penguinppc.org::linux-pmac-stable.

I synced that morning.
There is still some unresolved stuff for prep or chrp only, a common
config compiles fine.
The attached patch makes it compile, it works on a 43p 133, the TP850. A
MTX+ machine hangs with scsi resets, I will try a newer symbios logic
driver.
A B50 doesnt boot at all, it hangs after "Booting...", could be some asm
stuff.

The prep config is basicly that what I sent you a few days ago, I just
disabled the OF stuff.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pmac_stable_2.2.18pre17.dif"

diff -urN tmp/linux-pmac-stable.orig/arch/ppc/kernel/prep_pci.c linux-pmac-stable.chrp/arch/ppc/kernel/prep_pci.c
--- tmp/linux-pmac-stable.orig/arch/ppc/kernel/prep_pci.c	Wed Sep 13 01:06:23 2000
+++ linux-pmac-stable.chrp/arch/ppc/kernel/prep_pci.c	Fri Oct 27 17:01:16 2000
@@ -436,8 +436,8 @@

 static char ibm8xx_pci_IRQ_routes[] __prepdata = {
         0,      /* Line 0 - unused */
-        13,     /* Line 1 */
-        10,     /* Line 2 */
+        15,     /* Line 1 */
+        15,     /* Line 2 */
         15,     /* Line 3 */
         15,     /* Line 4 */
 };
diff -urN tmp/linux-pmac-stable.orig/arch/ppc/kernel/prep_setup.c linux-pmac-stable.chrp/arch/ppc/kernel/prep_setup.c
--- tmp/linux-pmac-stable.orig/arch/ppc/kernel/prep_setup.c	Thu Oct 26 04:56:13 2000
+++ linux-pmac-stable.chrp/arch/ppc/kernel/prep_setup.c	Fri Oct 27 17:01:16 2000
@@ -355,6 +355,8 @@
 	vgacon_remap_base = 0xf0000000;
 	/*vgacon_remap_base = ioremap(0xc0000000, 0xba000);*/
         conswitchp = &vga_con;
+#elif defined(CONFIG_DUMMY_CONSOLE)
+	conswitchp = &dummy_con;
 #endif
 }

@@ -834,7 +836,7 @@
 	else if (_prep_type == _PREP_IBM) {
 		ppc_md.set_rtc_time   = mc146818_set_rtc_time;
 		ppc_md.get_rtc_time   = mc146818_get_rtc_time;
-		ppc_md.calibrate_decr = prep_calibrate_decr;
+		ppc_md.calibrate_decr = prep_res_calibrate_decr;
 	}
 	else {
 		ppc_md.set_rtc_time   = mk48t59_set_rtc_time;
diff -urN tmp/linux-pmac-stable.orig/arch/ppc/kernel/prom.c linux-pmac-stable.chrp/arch/ppc/kernel/prom.c
--- tmp/linux-pmac-stable.orig/arch/ppc/kernel/prom.c	Wed Sep 13 01:08:58 2000
+++ linux-pmac-stable.chrp/arch/ppc/kernel/prom.c	Fri Oct 27 15:26:57 2000
@@ -2095,8 +2095,10 @@
 						(bi->dispDeviceDepth >> 3)) >> 2;
 	int i,j;

+#ifdef CONFIG_PMAC
 	pmu_suspend();
-
+#endif
+
 	for (i=0; i<(bi->dispDeviceRect[3] - bi->dispDeviceRect[1] - 16); i++)
 	{
 		unsigned long *src_ptr = src;
@@ -2114,7 +2116,9 @@
 		dst += (bi->dispDeviceRowBytes >> 2);
 	}

+#ifdef CONFIG_PMAC
 	pmu_resume();
+#endif
 }

 __pmac
diff -urN tmp/linux-pmac-stable.orig/drivers/char/mem.c linux-pmac-stable.chrp/drivers/char/mem.c
--- tmp/linux-pmac-stable.orig/drivers/char/mem.c	Thu Oct 26 07:40:21 2000
+++ linux-pmac-stable.chrp/drivers/char/mem.c	Fri Oct 27 15:32:39 2000
@@ -52,7 +52,7 @@
 #ifdef CONFIG_MDA_CONSOLE
 extern void mda_console_init(void);
 #endif
-#if defined(CONFIG_PPC) || defined(CONFIG_MAC)
+#if defined(CONFIG_PMAC) || defined(CONFIG_MAC)
 extern void adbdev_init(void);
 #endif
 #ifdef CONFIG_USB
@@ -665,7 +665,7 @@
 #ifdef CONFIG_VIDEO_BT848
 	i2c_init();
 #endif
-#if defined(CONFIG_PPC) || defined(CONFIG_MAC)
+#if defined(CONFIG_PMAC) || defined(CONFIG_MAC)
 	adbdev_init();
 #endif
 #ifdef CONFIG_VIDEO_DEV
diff -urN tmp/linux-pmac-stable.orig/drivers/char/misc.c linux-pmac-stable.chrp/drivers/char/misc.c
--- tmp/linux-pmac-stable.orig/drivers/char/misc.c	Sun Sep 24 20:37:54 2000
+++ linux-pmac-stable.chrp/drivers/char/misc.c	Fri Oct 27 15:33:46 2000
@@ -78,11 +78,15 @@
 extern int rtc_DP8570A_init(void);
 extern int rtc_MK48T08_init(void);
 extern int dsp56k_init(void);
+#ifdef CONFIG_PMAC
 extern int nvram_init(void);
+#endif
 extern int radio_init(void);
 extern void hfmodem_init(void);
 extern int pc110pad_init(void);
+#ifdef CONFIG_PMAC
 extern int pmu_device_init(void);
+#endif
 extern int tosh_init(void);
 extern int rng_init(void);

@@ -257,7 +261,7 @@
 #ifdef CONFIG_HFMODEM
 	hfmodem_init();
 #endif
-#ifdef CONFIG_NVRAM
+#if defined(CONFIG_NVRAM) && defined(CONFIG_PMAC)
 	nvram_init();
 #endif
 #ifdef CONFIG_MISC_RADIO
diff -urN tmp/linux-pmac-stable.orig/drivers/video/aty128fb.c linux-pmac-stable.chrp/drivers/video/aty128fb.c
--- tmp/linux-pmac-stable.orig/drivers/video/aty128fb.c	Wed Oct 11 23:26:41 2000
+++ linux-pmac-stable.chrp/drivers/video/aty128fb.c	Fri Oct 27 15:26:58 2000
@@ -51,11 +51,12 @@
 #include <asm/pci-bridge.h>
 #include <linux/nvram.h>
 #include <video/macmodes.h>
+#ifdef CONFIG_PMAC
 #include <asm/adb.h>
 #include <asm/pmu.h>
 #include <asm/backlight.h>
 #endif
-
+#endif
 #ifdef CONFIG_FB_COMPAT_XPMAC
 #include <asm/vc_ioctl.h>
 #endif
@@ -419,7 +420,7 @@
     aty128fb_set_cmap, aty128fb_pan_display, aty128fb_ioctl
 };

-#ifdef CONFIG_PPC
+#ifdef CONFIG_PMAC
 static int aty128_set_backlight_enable(int on, int level, void* data);
 static int aty128_set_backlight_level(int level, void* data);

@@ -427,7 +428,7 @@
 	aty128_set_backlight_enable,
 	aty128_set_backlight_level
 };
-#endif
+#endif /* CONFIG_PMAC */

     /*
      * Functions to read from/write to the mmio registers
@@ -1802,13 +1803,13 @@
     if (register_framebuffer(&info->fb_info) < 0)
 	return 0;

-#ifdef CONFIG_PPC
+#ifdef CONFIG_PMAC
     if (info->chip_gen == rage_M3)
     	register_backlight_controller(&aty128_backlight_controller, info, "ati");
-#endif
 #ifdef CONFIG_PMAC_PBOOK
     pmu_register_sleep_notifier(&aty128_sleep_notifier);
 #endif
+#endif

     printk(KERN_INFO "fb%d: %s frame buffer device on %s\n",
 	   GET_FB_IDX(info->fb_info.node), aty128fb_name, name);
@@ -2257,7 +2258,7 @@
     struct fb_info_aty128 *info = (struct fb_info_aty128 *)fb;
     u8 state = 0;

-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PMAC)
     if ((_machine == _MACH_Pmac) && blank)
     	set_backlight_enable(0);
 #endif
@@ -2271,7 +2272,7 @@

     aty_st_8(CRTC_EXT_CNTL+1, state);

-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PMAC)
     if ((_machine == _MACH_Pmac) && !blank)
     	set_backlight_enable(1);
 #endif
@@ -2412,7 +2413,7 @@
     }
 }

-#ifdef CONFIG_PPC
+#ifdef CONFIG_PMAC

 static int backlight_conv[] = {
 	0xff, 0xc0, 0xb5, 0xaa, 0x9f, 0x94, 0x89, 0x7e,
@@ -2447,7 +2448,7 @@
 	return aty128_set_backlight_enable(1, level, data);
 }

-#endif
+#endif /* CONFIG_PMAC */

     /*
      *  Accelerated functions
diff -urN tmp/linux-pmac-stable.orig/drivers/video/atyfb.c linux-pmac-stable.chrp/drivers/video/atyfb.c
--- tmp/linux-pmac-stable.orig/drivers/video/atyfb.c	Sun Sep 10 20:47:40 2000
+++ linux-pmac-stable.chrp/drivers/video/atyfb.c	Fri Oct 27 15:26:58 2000
@@ -68,10 +68,12 @@
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include <video/macmodes.h>
+#if defined(CONFIG_PMAC)
 #include <asm/adb.h>
 #include <asm/pmu.h>
 #include <asm/backlight.h>
-#endif
+#endif /* CONFIG_PMAC */
+#endif /* CONFIG_PPC */
 #ifdef __sparc__
 #include <asm/pbm.h>
 #include <asm/fbio.h>
@@ -412,7 +414,7 @@
 #endif
 };

-#ifdef CONFIG_PPC
+#ifdef CONFIG_PMAC
 static int aty_set_backlight_enable(int on, int level, void* data);
 static int aty_set_backlight_level(int level, void* data);

@@ -2787,7 +2789,7 @@
 	    info->total_vram -= GUI_RESERVE;
 	}

-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PMAC)
     if (Gx == LI_CHIP_ID && machine_is_compatible("PowerBook1,1")) {
 	/* these bits let the 101 powerbook wake up from sleep -- paulus */
 	aty_st_lcd(LCD_POWER_MANAGEMENT, aty_ld_lcd(LCD_POWER_MANAGEMENT, info)
@@ -2831,9 +2833,9 @@
 	default_cmode = CMODE_8;
     if (mac_vmode_to_var(default_vmode, default_cmode, &var))
 	var = default_var;
-#else /* !CONFIG_PPC */
+#else /* !CONFIG_PMAC */
     var = default_var;
-#endif /* !CONFIG_PPC */
+#endif /* !CONFIG_PMAC */
     if (noaccel)
         var.accel_flags &= ~FB_ACCELF_TEXT;
     else
@@ -3504,7 +3506,7 @@
     struct fb_info_aty *info = (struct fb_info_aty *)fb;
     u8 gen_cntl;

-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PMAC)
     if ((_machine == _MACH_Pmac) && blank)
     	set_backlight_enable(0);
 #endif
@@ -3529,7 +3531,7 @@
 	gen_cntl &= ~(0x4c);
     aty_st_8(CRTC_GEN_CNTL, gen_cntl, info);

-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PMAC)
     if ((_machine == _MACH_Pmac) && !blank)
     	set_backlight_enable(1);
 #endif
@@ -4227,7 +4229,7 @@
 }
 #endif /* CONFIG_PMAC_PBOOK */

-#ifdef CONFIG_PPC
+#ifdef CONFIG_PMAC
 static int backlight_conv[] = {
 	0x00, 0x3f, 0x4c, 0x59, 0x66, 0x73, 0x80, 0x8d,
 	0x9a, 0xa7, 0xb4, 0xc1, 0xcf, 0xdc, 0xe9, 0xff
@@ -4256,7 +4258,7 @@
 {
 	return aty_set_backlight_enable(1, level, data);
 }
-#endif /* CONFIG_PPC */
+#endif /* CONFIG_PMAC */


  #ifdef MODULE
diff -urN tmp/linux-pmac-stable.orig/include/asm-ppc/vga.h linux-pmac-stable.chrp/include/asm-ppc/vga.h
--- tmp/linux-pmac-stable.orig/include/asm-ppc/vga.h	Thu Oct 26 06:42:25 2000
+++ linux-pmac-stable.chrp/include/asm-ppc/vga.h	Fri Oct 27 19:11:43 2000
@@ -46,8 +46,12 @@
 #define scr_memcpyw_from memcpy
 #define scr_memcpyw_to memcpy

+#ifdef CONFIG_PREP
 extern unsigned long vgacon_remap_base;
 #define VGA_MAP_MEM(x) (x + vgacon_remap_base)
+#else
+#define VGA_MAP_MEM(x) (x)
+#endif /* CONFIG_PREP */
 #define vga_readb(x) (*(x))
 #define vga_writeb(x,y) (*(y) = (x))


--+HP7ph2BbKc20aGI--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

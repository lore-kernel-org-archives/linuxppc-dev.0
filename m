Message-Id: <199905221002.FAA22379@lists.linuxppc.org>
Date: Sat, 22 May 1999 13:35:11 +0200 (CEST)
From: laures@esiea.fr
Subject: Releasing more easy kernel patches
To: linuxppc-user@lists.linuxppc.org
cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I like to try patches on my various kernels. Unfortunately for the mid
power users like me, it's not always possible to get the bleeding edge
source tree for cvs, and anyway patches does not seem to be
always released against this tree.

As Linuxppc-pre-R5 "ships" with a kernel source that has usb and pcmcia
stuff (so it's fairly complete), I think it would be reasonable to use
this tree (which is easy to get and install as well) as a reference for
all patches released for public testing here (I'm not talking of
linuxppc-dev).

I feel this need because the new sound/brightness patch for PowerBook
didn't apply without any fuss into this kernel, mac-on-linux gives tons
of redefinition warnings (although the kernel works fairly well), there
were minor problems with latest Geert's aty patch etc etc.
I would be really more confident if the patches were released
specifically for my version of the kernel.

If hard kernel hackers don't find the time to do that by themselves,
it's ok to send me the patch and I'll try to get the "correct" patch as
soon as posible. (be prepared to questions then...)

I prepared two patches yet (PBG3 Series sound button and aty clock
probe patch, the mac-on-linux one is in preparation, but it'll be a lot
harder), see at the end.

Instructions:
- go on ftp.linuxppc.org, or any of its mirrors
- get into linuxppc-pre-R5/software/devel
- get the kernel-source and kernel-headers rpms
- install them (rpm -ivh kernel-headers... then source)
- (here my advice is to do a "cp linux-2.2.6 linux" to keep an untouched
tree as well, can be useful, but YMMV)
- cd /usr/src
- patch -p0 < path-file-selected

Note: it's ok to do that even if you're not running pre-R5 but R4.

For example, here is the patch needed to get the sound buttons working
on the PBG3 Series, as well as repetition for it and brightness (see
complete description on the list arhive).

--- linux-2.2.6/drivers/macintosh/mac_keyb.c	Fri Apr 30 18:06:14 1999
+++ linux/drivers/macintosh/mac_keyb.c	Sat May 22 12:36:17 1999
@@ -205,12 +205,18 @@
 	dont_repeat
 };
 
+/* buttons_input needs to know if shift or option key is down */
+static int shift_down;
+static int option_down;
+
+
 static void keyboard_input(unsigned char *, int, struct pt_regs *, int);
 static void input_keycode(void *, int);
 static void leds_done(struct adb_request *);
 static void mac_put_queue(int);
 
 static void buttons_input(unsigned char *, int, struct pt_regs *, int);
+static void buttons_handler(unsigned char *, int);
 
 static void init_trackpad(int id);
 static void init_trackball(int id);
@@ -321,6 +327,12 @@
 	if (keycode == 0x7e)
 		keycode = 0x7f;
 
+	/* buttons_handler() needs to know state of shift and option keys */
+	if (keycode == 0x38)
+		shift_down = !up_flag;
+	if (keycode == 0x3a)
+		option_down = !up_flag;
+
 #ifdef CONFIG_ADBMOUSE
 	/*
 	 * XXX: Add mouse button 2+3 fake codes here if mouse open.
@@ -509,9 +521,31 @@
 }
 #endif /* CONFIG_ADBMOUSE */
 
+
+/* Autorepeat delays for ADB buttons */
+#define BUTTON_DELAY0	(HZ/2)
+#define BUTTON_DELAY1	(HZ/6)
+
 /* XXX Needs to get rid of this, see comments in pmu.c */
 extern int backlight_level;
 
+/* Timer for buttons autorepeat */
+static struct timer_list button_timer;
+/* Store buttons data here between each interrupt */
+static unsigned char button_data[4];
+
+/* Interrupt handler for ADB button autorepeat */
+static void
+buttons_repeat(unsigned long x)
+{
+	unsigned long flags;
+
+	save_flags(flags);
+	cli();
+	buttons_handler(button_data, BUTTON_DELAY1);
+	restore_flags(flags);
+}
+
 static void
 buttons_input(unsigned char *data, int nb, struct pt_regs *regs, int autopoll)
 {
@@ -523,47 +557,86 @@
 	/* Ignore data from register other than 0 */
 	if ((adb_hardware != ADB_VIAPMU) || (data[0] & 0x3) || (nb < 2))
 		return;
-		
-	switch (data[1]&0xf )
+
+	buttons_handler(data, BUTTON_DELAY0);
+}
+
+static void
+buttons_handler(unsigned char *data, int repeat_delay)
+{
+	int down_flag;
+	int repeat_flag = 0;
+
+	extern int pmac_togglemute(int);
+	extern int pmac_addto_volume(int, int);
+
+	del_timer(&button_timer);
+
+	down_flag = data[1] == (data[1] & 0xf);
+	switch (data[1]&0xf)
 	{
 		/* mute */
 		case 0x8:
 			/* down event */
-			if ( data[1] == (data[1]&0xf) ) {
+			if (down_flag) {
+				if (pmu_get_model() == PMU_HEATHROW_BASED)
+					pmac_togglemute(shift_down? 2:4);
 			}
 			break;
-		/* contrast decrease */
+		/* contrast decrease (volume decrease on PowerBook G3) */
 		case 0x7:
 			/* down event */
-			if ( data[1] == (data[1]&0xf) ) {
+			if (down_flag) {
+				if (pmu_get_model() == PMU_HEATHROW_BASED)
+					pmac_addto_volume(shift_down? 2:4, option_down? -1000:-7);
+				repeat_flag = !option_down;
 			}
 			break;
-		/* contrast increase */
+		/* contrast increase (volume increase on PowerBook G3) */
 		case 0x6:
 			/* down event */
-			if ( data[1] == (data[1]&0xf) ) {
+			if (down_flag) {
+				if (pmu_get_model() == PMU_HEATHROW_BASED)
+					pmac_addto_volume(shift_down? 2:4, option_down? 1000:7);
+				repeat_flag = !option_down;
 			}
 			break;
 		/* brightness decrease */
 		case 0xa:
 			/* down event */
-			if ( data[1] == (data[1]&0xf) ) {
-				if (backlight_level > 2)
+			if (down_flag) {
+				if (!option_down && backlight_level > 2)
 					pmu_set_brightness(backlight_level-2);
 				else
-					pmu_set_brightness(0);
+					pmu_set_brightness(option_down? 1:0);
+				repeat_flag = !option_down;
 			}
 			break;
 		/* brightness increase */
 		case 0x9:
 			/* down event */
-			if ( data[1] == (data[1]&0xf) ) {
-				if (backlight_level < 0x1e)
+			if (down_flag) {
+				if (!option_down && backlight_level < 0x1e)
 					pmu_set_brightness(backlight_level+2);
 				else 
 					pmu_set_brightness(0x1f);
+				repeat_flag = !option_down;
 			}
 			break;
+		default:
+			/* another button */
+			break;
+	}
+
+	if (repeat_flag) {
+		button_data[0] = data[0];
+		button_data[1] = data[1];
+		button_data[2] = data[2];
+		button_data[3] = data[3];
+		button_timer.expires = repeat_delay + jiffies;
+		button_timer.data = 0;
+		button_timer.function = buttons_repeat;
+		add_timer(&button_timer);
 	}
 }
 
--- linux-2.2.6/drivers/sound/dmasound.c	Thu Mar 11 06:48:46 1999
+++ linux/drivers/sound/dmasound.c	Sat May 22 12:36:17 1999
@@ -243,6 +243,9 @@
 static volatile struct dbdma_cmd *beep_dbdma_cmd;
 static void (*orig_mksound)(unsigned int, unsigned int);
 
+/* Mute/unmute status */
+static int is_mute;
+
 /* Burgundy functions */
 static void awacs_burgundy_wcw(unsigned addr,unsigned newval);
 static unsigned awacs_burgundy_rcw(unsigned addr);
@@ -3143,6 +3146,7 @@
 		awacs_write((n << 12) | rn);
 		volume = awacs_get_volume(rn, lshift);
 	}
+	r1 |= is_mute;
 	if (r1 != awacs_reg[1]) {
 		awacs_reg[1] = r1;
 		awacs_write(r1 | MASK_ADDR1);
@@ -3193,6 +3197,70 @@
 	}
 	restore_flags(flags);
 }
+
+
+/* Toggle muting of headphones (n==2) or speakers (n==4) */
+int
+pmac_togglemute(int n)
+{
+	int mask;
+
+	if (n == 2)
+		mask = MASK_AMUTE;
+	else if (n == 4)
+		mask = MASK_CMUTE;
+	else
+		return 0;
+
+	is_mute ^= mask;
+	awacs_reg[1] ^= mask;
+	awacs_write(awacs_reg[1] | MASK_ADDR1);
+
+	return is_mute & mask;
+}
+
+/* Adjust volume of headphones (n==2) or speakers (n==4) */
+int
+pmac_addto_volume(int n, int incr)
+{
+	int volume, v1, v2, mask;
+
+	if (n == 2)
+		mask = MASK_AMUTE;
+	else if (n == 4)
+		mask = MASK_CMUTE;
+	else
+		return 0;
+		
+	if (is_mute & mask)
+		is_mute &= ~mask;
+	if (incr > 100)
+		volume = 0x6464;
+	else if (incr < -100)
+		volume = 0x0101;
+	else {
+		volume = awacs_get_volume(awacs_reg[n], 6);
+		v1 = ((volume >> 8) & 0x0ff) + incr;
+		v2 = (volume & 0x0ff) + incr;
+		if (v1 > 100)
+			v1 = 100;
+		if (v2 > 100)
+			v2 = 100;
+		if (v1 <= 0 && v2 <= 0) {
+			volume = 0;
+		} else {
+			if (v1 < 1)
+				v1 = 1;
+			if (v2 < 1)
+				v2 = 1;
+			volume = (v1 << 8) | v2;
+		}
+	}
+	awacs_volume_setter(volume, n, mask, 6);
+
+	return volume;
+}
+
 
 static void
 pmac_awacs_tx_intr(int irq, void *devid, struct pt_regs *regs)

This other one is a new clock probing for the aty chip found in the
PowerBooks G3 (found on linuxppc-dev)

--- linux-2.2.6/drivers/video/atyfb.c	Fri Apr 30 18:05:56 1999
+++ linux/drivers/video/atyfb.c	Sat May 22 13:05:06 1999
@@ -326,9 +326,7 @@
 static void init_engine(const struct atyfb_par *par, struct fb_info_aty *info);
 static void aty_st_514(int offset, u8 val, const struct fb_info_aty *info);
 static void aty_st_pll(int offset, u8 val, const struct fb_info_aty *info);
-#if defined(__sparc__) || defined(DEBUG)
 static u8 aty_ld_pll(int offset, const struct fb_info_aty *info);
-#endif
 static void aty_set_crtc(const struct fb_info_aty *info,
 			 const struct crtc *crtc);
 static int aty_var_to_crtc(const struct fb_info_aty *info,
@@ -405,7 +403,7 @@
 static int default_pll __initdata = 0;
 static int default_mclk __initdata = 0;
 
-static const u32 ref_clk_per = 1000000000000ULL/14318180;
+static u32 ref_clk_per;
 
 #if defined(CONFIG_PPC)
 static int default_vmode __initdata = VMODE_NVRAM;
@@ -689,7 +687,6 @@
     aty_st_8(CLOCK_CNTL + 1, (offset << 2) & ~PLL_WR_EN, info);
 }
 
-#if defined(__sparc__) || defined(DEBUG)
 static u8 aty_ld_pll(int offset, const struct fb_info_aty *info)
 {
     u8 res;
@@ -702,7 +699,6 @@
     eieio();
     return res;
 }
-#endif
 
 #if defined(CONFIG_PPC)
 
@@ -2438,11 +2434,12 @@
     int j, k;
     struct fb_var_screeninfo var;
     struct display *disp;
-    const char *chipname = NULL, *ramname = NULL;
+    const char *chipname = NULL, *ramname = NULL, *xtal;
     int pll, mclk, gtb_memsize;
 #if defined(CONFIG_PPC)
     int sense;
 #endif
+    u8 pll_ref_div;
 
     info->aty_cmap_regs = (struct aty_cmap_regs *)(info->ati_regbase+0xc0);
     chip_id = aty_ld_le32(CONFIG_CHIP_ID, info);
@@ -2530,6 +2527,25 @@
 	}
     }
 
+    ref_clk_per = 1000000000000ULL/14318180;
+    xtal = "14.31818";
+    if (!(Gx == GX_CHIP_ID || Gx == CX_CHIP_ID || Gx == CT_CHIP_ID ||
+	  Gx == ET_CHIP_ID ||
+	  ((Gx == VT_CHIP_ID || Gx == GT_CHIP_ID) && !(Rev & 0x07))) &&
+	(pll_ref_div = aty_ld_pll(PLL_REF_DIV, info))) {
+	int diff1, diff2;
+	diff1 = 510*14/pll_ref_div-pll;
+	diff2 = 510*29/pll_ref_div-pll;
+	if (diff1 < 0)
+	    diff1 = -diff1;
+	if (diff2 < 0)
+	    diff2 = -diff2;
+	if (diff2 < diff1) {
+	    ref_clk_per = 1000000000000ULL/29498928;
+	    xtal = "29.498928";
+	}
+    }
+
     i = aty_ld_le32(MEM_CNTL, info);
     gtb_memsize = !(Gx == GX_CHIP_ID || Gx == CX_CHIP_ID || Gx == CT_CHIP_ID ||
 		    Gx == ET_CHIP_ID ||
@@ -2608,9 +2624,9 @@
     if (default_mclk)
 	mclk = default_mclk;
 
-    printk("%d%c %s, %d MHz PLL, %d Mhz MCLK\n", 
+    printk("%d%c %s, %s MHz XTAL %d MHz PLL, %d Mhz MCLK\n", 
     	   info->total_vram == 0x80000 ? 512 : (info->total_vram >> 20), 
-    	   info->total_vram == 0x80000 ? 'K' : 'M', ramname, pll, mclk);
+    	   info->total_vram == 0x80000 ? 'K' : 'M', ramname, xtal, pll, mclk);
 
     if (mclk < 44)
 	info->mem_refresh_rate = 0;	/* 000 = 10 Mhz - 43 Mhz */


-- 
Guillaume Laurès - student @ ESIEA (www.esiea.fr)

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

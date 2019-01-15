Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ABEC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:59:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C8D20656
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C8D20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dymV2XswzDqbW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:59:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dxyG6ZBKzDqXG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 15:22:30 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id BFA2D29E83; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-Id: <204f2532af36aeb92b4c585d67f4c66690330acc.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 19/22] powerpc, fbdev: Use NV_CMODE and NV_VMODE only when
 CONFIG_PPC32 && CONFIG_PPC_PMAC && CONFIG_NVRAM
Date: Tue, 15 Jan 2019 15:18:56 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch addresses inconsistencies in Mac framebuffer drivers and their
use of Kconfig symbols relating to NVRAM, so PPC64 can use CONFIG_NVRAM.

The defined(CONFIG_NVRAM) condition is replaced with the weaker
IS_REACHABLE(CONFIG_NVRAM) condition, like atari_scsi.

Macintosh framebuffer drivers use default settings for color mode and
video mode that are found in NVRAM. On PCI Macs, MacOS stores display
settings in the Name Registry (NR) partition in NVRAM*. On NuBus Macs,
there is no NR partition and MacOS stores display mode settings in PRAM**.

Early-model Macs are the ones most likely to benefit from these settings,
since they are more likely to have a fixed-frequency monitor connected to
the built-in framebuffer device. Moreover, a single NV_CMODE value and
a single NV_VMODE value provide for only one display.

The NV_CMODE and NV_VMODE constants are apparently offsets into the NR
partition for Old World machines. This also suggests that these defaults
are not useful on later models. The NR partition seems to be optional on
New World machines. CONFIG_NVRAM cannot be enabled on PPC64 at present.

It is safe to say that NVRAM support in PowerMac fbdev drivers is only
applicable to CONFIG_PPC32 so make this condition explicit. This means
matroxfb driver won't crash on PPC64 when CONFIG_NVRAM becomes available
there.

For imsttfb, add the missing CONFIG_NVRAM test to prevent a build failure,
since PPC64 does not implement nvram_read_byte(). Also add a missing
machine_is(powermac) check. Change the inconsistent dependency on
CONFIG_PPC and the matching #ifdef tests to CONFIG_PPC_PMAC.

For valkyriefb, to improve clarity and consistency with the other PowerMac
fbdev drivers, test for CONFIG_PPC_PMAC instead of !CONFIG_MAC. Remove a
bogus comment regarding PRAM.

* See GetPreferredConfiguration and SavePreferredConfiguration in
"Designing PCI Cards and Drivers for Power Macintosh Computers".

** See SetDefaultMode and GetDefaultMode in "Designing Cards and Drivers
for the Macintosh Family".

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v8:
 - Replaced defined(CONFIG_NVRAM) with IS_REACHABLE(CONFIG_NVRAM) as
suggested by James Bottomley.
 - Changed #ifdef to if as suggested by Christophe Leroy.
 - Expanded the patch to include controlfb.c and platinumfb.c due to the
conversion from '#if defined(CONFIG_NVRAM)' to
'if (IS_REACHABLE(CONFIG_NVRAM))'.
---
 drivers/video/fbdev/Kconfig                |  2 +-
 drivers/video/fbdev/controlfb.c            | 42 ++++++++--------------
 drivers/video/fbdev/imsttfb.c              | 23 ++++++------
 drivers/video/fbdev/matrox/matroxfb_base.c |  5 +--
 drivers/video/fbdev/platinumfb.c           | 21 +++++------
 drivers/video/fbdev/valkyriefb.c           | 30 ++++++----------
 6 files changed, 48 insertions(+), 75 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ae7712c9687a..58a9590c9db6 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -536,7 +536,7 @@ config FB_IMSTT
 	bool "IMS Twin Turbo display support"
 	depends on (FB = y) && PCI
 	select FB_CFB_IMAGEBLIT
-	select FB_MACMODES if PPC
+	select FB_MACMODES if PPC_PMAC
 	help
 	  The IMS Twin Turbo is a PCI-based frame buffer card bundled with
 	  many Macintosh and compatible computers.
diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 9cb0ef7ac29e..7af8db28bb80 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -411,35 +411,23 @@ static int __init init_control(struct fb_info_control *p)
 	full = p->total_vram == 0x400000;
 
 	/* Try to pick a video mode out of NVRAM if we have one. */
-#ifdef CONFIG_NVRAM
-	if (default_cmode == CMODE_NVRAM) {
+	cmode = default_cmode;
+	if (IS_REACHABLE(CONFIG_NVRAM) && cmode == CMODE_NVRAM)
 		cmode = nvram_read_byte(NV_CMODE);
-		if(cmode < CMODE_8 || cmode > CMODE_32)
-			cmode = CMODE_8;
-	} else
-#endif
-		cmode=default_cmode;
-#ifdef CONFIG_NVRAM
-	if (default_vmode == VMODE_NVRAM) {
+	if (cmode < CMODE_8 || cmode > CMODE_32)
+		cmode = CMODE_8;
+
+	vmode = default_vmode;
+	if (IS_REACHABLE(CONFIG_NVRAM) && vmode == VMODE_NVRAM)
 		vmode = nvram_read_byte(NV_VMODE);
-		if (vmode < 1 || vmode > VMODE_MAX ||
-		    control_mac_modes[vmode - 1].m[full] < cmode) {
-			sense = read_control_sense(p);
-			printk("Monitor sense value = 0x%x, ", sense);
-			vmode = mac_map_monitor_sense(sense);
-			if (control_mac_modes[vmode - 1].m[full] < cmode)
-				vmode = VMODE_640_480_60;
-		}
-	} else
-#endif
-	{
-		vmode=default_vmode;
-		if (control_mac_modes[vmode - 1].m[full] < cmode) {
-			if (cmode > CMODE_8)
-				cmode--;
-			else
-				vmode = VMODE_640_480_60;
-		}
+	if (vmode < 1 || vmode > VMODE_MAX ||
+	    control_mac_modes[vmode - 1].m[full] < cmode) {
+		sense = read_control_sense(p);
+		printk(KERN_CONT "Monitor sense value = 0x%x, ", sense);
+		vmode = mac_map_monitor_sense(sense);
+		if (control_mac_modes[vmode - 1].m[full] < 0)
+			vmode = VMODE_640_480_60;
+		cmode = min(cmode, control_mac_modes[vmode - 1].m[full]);
 	}
 
 	/* Initialize info structure */
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 901ca4ed10e9..5d9670daf60e 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -30,9 +30,8 @@
 #include <asm/io.h>
 #include <linux/uaccess.h>
 
-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PPC_PMAC)
 #include <linux/nvram.h>
-#include <asm/prom.h>
 #include "macmodes.h"
 #endif
 
@@ -327,14 +326,13 @@ enum {
 	TVP = 1
 };
 
-#define USE_NV_MODES		1
 #define INIT_BPP		8
 #define INIT_XRES		640
 #define INIT_YRES		480
 
 static int inverse = 0;
 static char fontname[40] __initdata = { 0 };
-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PPC_PMAC)
 static signed char init_vmode = -1, init_cmode = -1;
 #endif
 
@@ -1390,8 +1388,8 @@ static void init_imstt(struct fb_info *info)
 		}
 	}
 
-#if USE_NV_MODES && defined(CONFIG_PPC32)
-	{
+#if defined(CONFIG_PPC_PMAC) && defined(CONFIG_PPC32)
+	if (IS_REACHABLE(CONFIG_NVRAM) && machine_is(powermac)) {
 		int vmode = init_vmode, cmode = init_cmode;
 
 		if (vmode == -1) {
@@ -1409,12 +1407,13 @@ static void init_imstt(struct fb_info *info)
 			info->var.yres = info->var.yres_virtual = INIT_YRES;
 			info->var.bits_per_pixel = INIT_BPP;
 		}
-	}
-#else
-	info->var.xres = info->var.xres_virtual = INIT_XRES;
-	info->var.yres = info->var.yres_virtual = INIT_YRES;
-	info->var.bits_per_pixel = INIT_BPP;
+	} else
 #endif
+	{
+		info->var.xres = info->var.xres_virtual = INIT_XRES;
+		info->var.yres = info->var.yres_virtual = INIT_YRES;
+		info->var.bits_per_pixel = INIT_BPP;
+	}
 
 	if ((info->var.xres * info->var.yres) * (info->var.bits_per_pixel >> 3) > info->fix.smem_len
 	    || !(compute_imstt_regvals(par, info->var.xres, info->var.yres))) {
@@ -1565,7 +1564,7 @@ imsttfb_setup(char *options)
 			inverse = 1;
 			fb_invert_cmaps();
 		}
-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PPC_PMAC)
 		else if (!strncmp(this_opt, "vmode:", 6)) {
 			int vmode = simple_strtoul(this_opt+6, NULL, 0);
 			if (vmode > 0 && vmode <= VMODE_MAX)
diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 0a4e5bad33f4..d11b5e6210ed 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -1872,10 +1872,11 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
 #ifndef MODULE
 	if (machine_is(powermac)) {
 		struct fb_var_screeninfo var;
+
 		if (default_vmode <= 0 || default_vmode > VMODE_MAX)
 			default_vmode = VMODE_640_480_60;
-#ifdef CONFIG_NVRAM
-		if (default_cmode == CMODE_NVRAM)
+#if defined(CONFIG_PPC32)
+		if (IS_REACHABLE(CONFIG_NVRAM) && default_cmode == CMODE_NVRAM)
 			default_cmode = nvram_read_byte(NV_CMODE);
 #endif
 		if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
index bf6b7fb83cf4..76f299375a00 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -345,23 +345,18 @@ static int platinum_init_fb(struct fb_info *info)
 
 	sense = read_platinum_sense(pinfo);
 	printk(KERN_INFO "platinumfb: Monitor sense value = 0x%x, ", sense);
-	if (default_vmode == VMODE_NVRAM) {
-#ifdef CONFIG_NVRAM
+
+	if (IS_REACHABLE(CONFIG_NVRAM) && default_vmode == VMODE_NVRAM)
 		default_vmode = nvram_read_byte(NV_VMODE);
-		if (default_vmode <= 0 || default_vmode > VMODE_MAX ||
-		    !platinum_reg_init[default_vmode-1])
-#endif
-			default_vmode = VMODE_CHOOSE;
-	}
-	if (default_vmode == VMODE_CHOOSE) {
+	if (default_vmode <= 0 || default_vmode > VMODE_MAX ||
+	    !platinum_reg_init[default_vmode - 1]) {
 		default_vmode = mac_map_monitor_sense(sense);
+		if (!platinum_reg_init[default_vmode - 1])
+			default_vmode = VMODE_640_480_60;
 	}
-	if (default_vmode <= 0 || default_vmode > VMODE_MAX)
-		default_vmode = VMODE_640_480_60;
-#ifdef CONFIG_NVRAM
-	if (default_cmode == CMODE_NVRAM)
+
+	if (IS_REACHABLE(CONFIG_NVRAM) && default_cmode == CMODE_NVRAM)
 		default_cmode = nvram_read_byte(NV_CMODE);
-#endif
 	if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 		default_cmode = CMODE_8;
 	/*
diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index d51c3a8009cb..e04fde9c1fcd 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -63,15 +63,8 @@
 #include "macmodes.h"
 #include "valkyriefb.h"
 
-#ifdef CONFIG_MAC
-/* We don't yet have functions to read the PRAM... perhaps we can
-   adapt them from the PPC code? */
-static int default_vmode = VMODE_CHOOSE;
-static int default_cmode = CMODE_8;
-#else
 static int default_vmode = VMODE_NVRAM;
 static int default_cmode = CMODE_NVRAM;
-#endif
 
 struct fb_par_valkyrie {
 	int	vmode, cmode;
@@ -283,24 +276,21 @@ static void __init valkyrie_choose_mode(struct fb_info_valkyrie *p)
 	printk(KERN_INFO "Monitor sense value = 0x%x\n", p->sense);
 
 	/* Try to pick a video mode out of NVRAM if we have one. */
-#if !defined(CONFIG_MAC) && defined(CONFIG_NVRAM)
-	if (default_vmode == VMODE_NVRAM) {
+#ifdef CONFIG_PPC_PMAC
+	if (IS_REACHABLE(CONFIG_NVRAM) && default_vmode == VMODE_NVRAM)
 		default_vmode = nvram_read_byte(NV_VMODE);
-		if (default_vmode <= 0
-		 || default_vmode > VMODE_MAX
-		 || !valkyrie_reg_init[default_vmode - 1])
-			default_vmode = VMODE_CHOOSE;
-	}
 #endif
-	if (default_vmode == VMODE_CHOOSE)
+	if (default_vmode <= 0 || default_vmode > VMODE_MAX ||
+	    !valkyrie_reg_init[default_vmode - 1]) {
 		default_vmode = mac_map_monitor_sense(p->sense);
-	if (!valkyrie_reg_init[default_vmode - 1])
-		default_vmode = VMODE_640_480_67;
-#if !defined(CONFIG_MAC) && defined(CONFIG_NVRAM)
-	if (default_cmode == CMODE_NVRAM)
+		if (!valkyrie_reg_init[default_vmode - 1])
+			default_vmode = VMODE_640_480_67;
+	}
+
+#ifdef CONFIG_PPC_PMAC
+	if (IS_REACHABLE(CONFIG_NVRAM) && default_cmode == CMODE_NVRAM)
 		default_cmode = nvram_read_byte(NV_CMODE);
 #endif
-
 	/*
 	 * Reduce the pixel size if we don't have enough VRAM or bandwidth.
 	 */
-- 
2.19.2


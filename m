Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 65D961A0709
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 17:56:53 +1000 (AEST)
Message-Id: <20150725074603.673303850@telegraphics.com.au>
Date: Sat, 25 Jul 2015 17:46:16 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Subject: [RFC v5 17/26] powerpc,
 fbdev: Use NV_CMODE and NV_VMODE only when CONFIG_PPC32 and
 CONFIG_PPC_PMAC and CONFIG_NVRAM
References: <20150725074559.543547894@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch addresses inconsistencies in Mac framebuffer drivers and their
use of Kconfig symbols relating to NVRAM, so PPC64 can use CONFIG_NVRAM.

Macintosh framebuffer drivers use default settings for color mode and
video mode that are found in NVRAM. On PCI Macs, MacOS stores display
settings in the Name Registry (NR) partition in NVRAM*. On NuBus Macs,
there is no NR partition and MacOS stores display mode settings in PRAM**.

Early model Macs are the ones most likely to benefit from these settings,
since they are more likely to have one display: a fixed-frequency monitor
connected to the built-in framebuffer device. Moreover, a single NV_CMODE
value and a single NV_VMODE value provide for only one display.

The NV_CMODE and NV_VMODE constants are apparently offsets into the NR
partition for Old World machines and not New World, which also suggests
that these defaults are not useful on later models.

All this argues for limiting NVRAM support in PowerMac fbdev drivers to
PPC32 and indeed this is already the case, since CONFIG_NVRAM cannot be
enabled on PPC64 at present.

For matroxfb, make the CONFIG_PPC32 condition explicit. That way the
driver won't crash on PPC64 when CONFIG_NVRAM becomes available there.

In imsttfb, add the missing CONFIG_NVRAM test to prevent a build failure,
since PPC64 does not implement nvram_read_byte(). Also add a missing
machine_is(powermac) check. Change the inconsistent CONFIG_PPC dependency
and the matching #ifdef tests to CONFIG_PPC_PMAC. Drop unused #includes.

In valkyriefb, for clarity and consistency with the other PowerMac fbdev
drivers, test for CONFIG_PPC_PMAC instead of !CONFIG_MAC. Remove a
bogus comment regarding PRAM.

* See GetPreferredConfiguration and SavePreferredConfiguration in
"Designing PCI Cards and Drivers for Power Macintosh Computers".

** See SetDefaultMode and GetDefaultMode in "Designing Cards and Drivers
for the Macintosh Family".

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/video/fbdev/Kconfig                |    2 +-
 drivers/video/fbdev/imsttfb.c              |   13 +++++--------
 drivers/video/fbdev/matrox/matroxfb_base.c |    2 +-
 drivers/video/fbdev/valkyriefb.c           |   14 ++++++--------
 4 files changed, 13 insertions(+), 18 deletions(-)

Index: linux/drivers/video/fbdev/Kconfig
===================================================================
--- linux.orig/drivers/video/fbdev/Kconfig	2015-07-25 17:42:34.000000000 +1000
+++ linux/drivers/video/fbdev/Kconfig	2015-07-25 17:45:44.000000000 +1000
@@ -544,7 +544,7 @@ config FB_IMSTT
 	bool "IMS Twin Turbo display support"
 	depends on (FB = y) && PCI
 	select FB_CFB_IMAGEBLIT
-	select FB_MACMODES if PPC
+	select FB_MACMODES if PPC_PMAC
 	help
 	  The IMS Twin Turbo is a PCI-based frame buffer card bundled with
 	  many Macintosh and compatible computers.
Index: linux/drivers/video/fbdev/imsttfb.c
===================================================================
--- linux.orig/drivers/video/fbdev/imsttfb.c	2015-07-25 17:42:34.000000000 +1000
+++ linux/drivers/video/fbdev/imsttfb.c	2015-07-25 17:45:44.000000000 +1000
@@ -30,10 +30,8 @@
 #include <asm/io.h>
 #include <linux/uaccess.h>
 
-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PPC_PMAC)
 #include <linux/nvram.h>
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
 #include "macmodes.h"
 #endif
 
@@ -328,14 +326,13 @@ enum {
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
 
@@ -1391,8 +1388,8 @@ static void init_imstt(struct fb_info *i
 		}
 	}
 
-#if USE_NV_MODES && defined(CONFIG_PPC32)
-	{
+#if defined(CONFIG_PPC_PMAC) && defined(CONFIG_PPC32) && defined(CONFIG_NVRAM)
+	if (machine_is(powermac)) {
 		int vmode = init_vmode, cmode = init_cmode;
 
 		if (vmode == -1) {
@@ -1566,7 +1563,7 @@ imsttfb_setup(char *options)
 			inverse = 1;
 			fb_invert_cmaps();
 		}
-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PPC_PMAC)
 		else if (!strncmp(this_opt, "vmode:", 6)) {
 			int vmode = simple_strtoul(this_opt+6, NULL, 0);
 			if (vmode > 0 && vmode <= VMODE_MAX)
Index: linux/drivers/video/fbdev/matrox/matroxfb_base.c
===================================================================
--- linux.orig/drivers/video/fbdev/matrox/matroxfb_base.c	2015-07-25 17:45:38.000000000 +1000
+++ linux/drivers/video/fbdev/matrox/matroxfb_base.c	2015-07-25 17:45:44.000000000 +1000
@@ -1876,7 +1876,7 @@ static int initMatrox2(struct matrox_fb_
 		struct fb_var_screeninfo var;
 		if (default_vmode <= 0 || default_vmode > VMODE_MAX)
 			default_vmode = VMODE_640_480_60;
-#ifdef CONFIG_NVRAM
+#if defined(CONFIG_PPC32) && defined(CONFIG_NVRAM)
 		if (default_cmode == CMODE_NVRAM)
 			default_cmode = nvram_read_byte(NV_CMODE);
 #endif
Index: linux/drivers/video/fbdev/valkyriefb.c
===================================================================
--- linux.orig/drivers/video/fbdev/valkyriefb.c	2015-07-25 17:42:34.000000000 +1000
+++ linux/drivers/video/fbdev/valkyriefb.c	2015-07-25 17:45:44.000000000 +1000
@@ -65,14 +65,12 @@
 #include "macmodes.h"
 #include "valkyriefb.h"
 
-#ifdef CONFIG_MAC
-/* We don't yet have functions to read the PRAM... perhaps we can
-   adapt them from the PPC code? */
-static int default_vmode = VMODE_CHOOSE;
-static int default_cmode = CMODE_8;
-#else
+#ifdef CONFIG_PPC_PMAC
 static int default_vmode = VMODE_NVRAM;
 static int default_cmode = CMODE_NVRAM;
+#else
+static int default_vmode = VMODE_CHOOSE;
+static int default_cmode = CMODE_8;
 #endif
 
 struct fb_par_valkyrie {
@@ -285,7 +283,7 @@ static void __init valkyrie_choose_mode(
 	printk(KERN_INFO "Monitor sense value = 0x%x\n", p->sense);
 
 	/* Try to pick a video mode out of NVRAM if we have one. */
-#if !defined(CONFIG_MAC) && defined(CONFIG_NVRAM)
+#if defined(CONFIG_PPC_PMAC) && defined(CONFIG_NVRAM)
 	if (default_vmode == VMODE_NVRAM) {
 		default_vmode = nvram_read_byte(NV_VMODE);
 		if (default_vmode <= 0
@@ -298,7 +296,7 @@ static void __init valkyrie_choose_mode(
 		default_vmode = mac_map_monitor_sense(p->sense);
 	if (!valkyrie_reg_init[default_vmode - 1])
 		default_vmode = VMODE_640_480_67;
-#if !defined(CONFIG_MAC) && defined(CONFIG_NVRAM)
+#if defined(CONFIG_PPC_PMAC) && defined(CONFIG_NVRAM)
 	if (default_cmode == CMODE_NVRAM)
 		default_cmode = nvram_read_byte(NV_CMODE);
 #endif

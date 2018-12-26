Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631CFC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 03:54:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6482148E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 03:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6482148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43PfGh1mHmzDqKT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 14:54:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43PfDF5PsZzDqJm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 14:51:57 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id D1D6C29529; Tue, 25 Dec 2018 19:43:56 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-Id: <88b7f55b6b27aac143c364de12d01c73afce78e9.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 19/25] powerpc, fbdev: Use NV_CMODE and NV_VMODE only when
 CONFIG_PPC32 && CONFIG_PPC_PMAC && CONFIG_NVRAM
Date: Wed, 26 Dec 2018 11:37:59 +1100
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
 drivers/video/fbdev/Kconfig                |  2 +-
 drivers/video/fbdev/imsttfb.c              | 12 +++++-------
 drivers/video/fbdev/matrox/matroxfb_base.c |  2 +-
 drivers/video/fbdev/valkyriefb.c           | 14 ++++++--------
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e413f54208f4..52453ce3040a 100644
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
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 901ca4ed10e9..8d231591ff0e 100644
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
+#if defined(CONFIG_PPC_PMAC) && defined(CONFIG_PPC32) && defined(CONFIG_NVRAM)
+	if (machine_is(powermac)) {
 		int vmode = init_vmode, cmode = init_cmode;
 
 		if (vmode == -1) {
@@ -1565,7 +1563,7 @@ imsttfb_setup(char *options)
 			inverse = 1;
 			fb_invert_cmaps();
 		}
-#if defined(CONFIG_PPC)
+#if defined(CONFIG_PPC_PMAC)
 		else if (!strncmp(this_opt, "vmode:", 6)) {
 			int vmode = simple_strtoul(this_opt+6, NULL, 0);
 			if (vmode > 0 && vmode <= VMODE_MAX)
diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 0a4e5bad33f4..cac5865d461c 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -1874,7 +1874,7 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
 		struct fb_var_screeninfo var;
 		if (default_vmode <= 0 || default_vmode > VMODE_MAX)
 			default_vmode = VMODE_640_480_60;
-#ifdef CONFIG_NVRAM
+#if defined(CONFIG_PPC32) && defined(CONFIG_NVRAM)
 		if (default_cmode == CMODE_NVRAM)
 			default_cmode = nvram_read_byte(NV_CMODE);
 #endif
diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index d51c3a8009cb..8022316ee9c9 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -63,14 +63,12 @@
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
@@ -283,7 +281,7 @@ static void __init valkyrie_choose_mode(struct fb_info_valkyrie *p)
 	printk(KERN_INFO "Monitor sense value = 0x%x\n", p->sense);
 
 	/* Try to pick a video mode out of NVRAM if we have one. */
-#if !defined(CONFIG_MAC) && defined(CONFIG_NVRAM)
+#if defined(CONFIG_PPC_PMAC) && defined(CONFIG_NVRAM)
 	if (default_vmode == VMODE_NVRAM) {
 		default_vmode = nvram_read_byte(NV_VMODE);
 		if (default_vmode <= 0
@@ -296,7 +294,7 @@ static void __init valkyrie_choose_mode(struct fb_info_valkyrie *p)
 		default_vmode = mac_map_monitor_sense(p->sense);
 	if (!valkyrie_reg_init[default_vmode - 1])
 		default_vmode = VMODE_640_480_67;
-#if !defined(CONFIG_MAC) && defined(CONFIG_NVRAM)
+#if defined(CONFIG_PPC_PMAC) && defined(CONFIG_NVRAM)
 	if (default_cmode == CMODE_NVRAM)
 		default_cmode = nvram_read_byte(NV_CMODE);
 #endif
-- 
2.19.2


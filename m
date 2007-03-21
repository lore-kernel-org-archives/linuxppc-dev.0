Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6599EDDE2E
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 23:11:24 +1100 (EST)
Subject: suspend to disk with DRI
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 21 Mar 2007 10:11:10 +0100
Message-Id: <1174468270.3769.5.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I salvaged more stuff from your old patches and this is a patch that
makes suspend to disk almost work with DRI and AGP enabled.
Unfortunately, it appears as though the card loses state.

First, ppracer died on me with:

ppracer: r300_ioctl.c:683: r300AllocDmaRegion: Assertion
`rmesa->dma.current.ptr <= rmesa->dma.current.end' failed.

That actually happened to me both without and with having suspended to
disk. In both cases, however, I restarted and exited ppracer from the
main menu, and only after suspending did the machine then lock up (when
exiting it). It would appear to me that r300 is keeping state that it
shouldn't, or we're not restoring state in DRM that we should restore?

Maybe you can make something of it, I remember talking to you about some
other AGP suspend thing but forgot what it was. If you remember, let me
know, otherwise I'll try to find the old chat log somewhere in backups
or so.

johannes

--- linux-2.6.orig/drivers/char/agp/uninorth-agp.c	2007-03-21 09:40:38.318837472 +0100
+++ linux-2.6/drivers/char/agp/uninorth-agp.c	2007-03-21 09:40:44.678837472 +0100
@@ -357,6 +357,8 @@ static int agp_uninorth_resume(struct pc
 	struct agp_bridge_data *bridge;
 	u32 command;
 
+	uninorth_configure();
+
 	bridge = agp_find_bridge(pdev);
 	if (bridge == NULL)
 		return -ENODEV;
--- linux-2.6.orig/drivers/video/aty/radeon_base.c	2007-03-21 09:41:20.378837472 +0100
+++ linux-2.6/drivers/video/aty/radeon_base.c	2007-03-21 09:41:38.368837472 +0100
@@ -1912,7 +1912,7 @@ static int __devinit radeon_set_fbinfo (
  */
 #ifdef CONFIG_PPC_OF
 #undef SET_MC_FB_FROM_APERTURE
-static void fixup_memory_mappings(struct radeonfb_info *rinfo)
+void radeon_fixup_memory_mappings(struct radeonfb_info *rinfo)
 {
 	u32 save_crtc_gen_cntl, save_crtc2_gen_cntl = 0;
 	u32 save_crtc_ext_cntl;
@@ -2244,7 +2244,7 @@ static int __devinit radeonfb_pci_regist
 	 * to cause lockups when enabling the engine. We reconfigure
 	 * the card internal memory mappings properly
 	 */
-	fixup_memory_mappings(rinfo);
+	radeon_fixup_memory_mappings(rinfo);
 #endif /* CONFIG_PPC_OF */
 
 	/* Get VRAM size and type */
--- linux-2.6.orig/drivers/video/aty/radeon_pm.c	2007-03-21 09:42:00.778837472 +0100
+++ linux-2.6/drivers/video/aty/radeon_pm.c	2007-03-21 09:43:20.798837472 +0100
@@ -2766,8 +2766,12 @@ int radeonfb_pci_resume(struct pci_dev *
 			radeon_set_suspend(rinfo, 0);
 
 		rinfo->asleep = 0;
-	} else
+	} else {
+#ifdef CONFIG_PPC_OF
+		radeon_fixup_memory_mappings(rinfo);
+#endif
 		radeon_engine_idle();
+	}
 
 	/* Restore display & engine */
 	radeon_write_mode (rinfo, &rinfo->state, 1);
--- linux-2.6.orig/drivers/video/aty/radeonfb.h	2007-03-21 09:43:32.868837472 +0100
+++ linux-2.6/drivers/video/aty/radeonfb.h	2007-03-21 09:43:45.958837472 +0100
@@ -622,6 +622,7 @@ extern void radeonfb_engine_init (struct
 extern void radeonfb_engine_reset(struct radeonfb_info *rinfo);
 
 /* Other functions */
+extern void radeon_fixup_memory_mappings(struct radeonfb_info *rinfo);
 extern int radeon_screen_blank(struct radeonfb_info *rinfo, int blank, int mode_switch);
 extern void radeon_write_mode (struct radeonfb_info *rinfo, struct radeon_regs *mode,
 			       int reg_only);

Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHhF86FmhzDvhN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 06:59:40 +1100 (AEDT)
Received: by mail-wm0-x243.google.com with SMTP id u144so18479409wmu.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 11:59:40 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: linux-fbdev@vger.kernel.org
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Mathieu Malaterre <malat@debian.org>
Subject: [PATCH v2] Fix loading of module radeonfb on PowerMac
Date: Mon, 14 Nov 2016 20:59:17 +0100
Message-Id: <1479153557-20849-1-git-send-email-malat@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the linux kernel is build with (typical kernel ship with Debian
installer):

CONFIG_FB_OF=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_FB_RADEON=m

The offb driver takes precedence over module radeonfb. It is then
impossible to load the module, error reported is:

[   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
[   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
[   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
[   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16

This patch reproduce the behavior of the module radeon, so as to make it
possible to load radeonfb when offb is first loaded.

It should be noticed that `offb_destroy` is never called which explain the
need to skip error detection on the radeon side.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Link: https://bugs.debian.org/826629#57
Link: https://bugzilla.kernel.org/show_bug.cgi?id=119741
Suggested-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
---
 drivers/video/fbdev/aty/radeon_base.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 218339a..84d634b 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2259,6 +2259,22 @@ static struct bin_attribute edid2_attr = {
 	.read	= radeon_show_edid2,
 };
 
+static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
+{
+	struct apertures_struct *ap;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return -ENOMEM;
+
+	ap->ranges[0].base = pci_resource_start(pdev, 0);
+	ap->ranges[0].size = pci_resource_len(pdev, 0);
+
+	remove_conflicting_framebuffers(ap, KBUILD_MODNAME, false);
+	kfree(ap);
+
+	return 0;
+}
 
 static int radeonfb_pci_register(struct pci_dev *pdev,
 				 const struct pci_device_id *ent)
@@ -2314,19 +2330,27 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	rinfo->fb_base_phys = pci_resource_start (pdev, 0);
 	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
 
+	ret = radeon_kick_out_firmware_fb(pdev);
+	if (ret)
+		return ret;
+
 	/* request the mem regions */
 	ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
 	if (ret < 0) {
 		printk( KERN_ERR "radeonfb (%s): cannot request region 0.\n",
 			pci_name(rinfo->pdev));
+#ifndef CONFIG_PPC
 		goto err_release_fb;
+#endif
 	}
 
 	ret = pci_request_region(pdev, 2, "radeonfb mmio");
 	if (ret < 0) {
 		printk( KERN_ERR "radeonfb (%s): cannot request region 2.\n",
 			pci_name(rinfo->pdev));
+#ifndef CONFIG_PPC
 		goto err_release_pci0;
+#endif
 	}
 
 	/* map the regions */
@@ -2511,10 +2535,12 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	iounmap(rinfo->mmio_base);
 err_release_pci2:
 	pci_release_region(pdev, 2);
+#ifndef CONFIG_PPC
 err_release_pci0:
 	pci_release_region(pdev, 0);
 err_release_fb:
         framebuffer_release(info);
+#endif
 err_disable:
 err_out:
 	return ret;
-- 
2.1.4

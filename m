Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x235.google.com (mail-yh0-x235.google.com
 [IPv6:2607:f8b0:4002:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77A6C1A0EB3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:30 +1100 (AEDT)
Received: by mail-yh0-f53.google.com with SMTP id v1so12971029yhn.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:28 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 05/15] fbdev: imsttfb: remove the dependency on PPC_OF
Date: Sat, 31 Jan 2015 21:47:35 +0800
Message-Id: <1422712065-9403-6-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Kevin Hao <haokexin@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The OF functionality has moved to a common place and be used by many
archs. So we don't need to depend on PPC_OF option any more. This is
a preparation for killing PPC_OF.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/video/fbdev/imsttfb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index aae10ce74f14..91a80bb8f988 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1470,7 +1470,6 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	unsigned long addr, size;
 	struct imstt_par *par;
 	struct fb_info *info;
-#ifdef CONFIG_PPC_OF
 	struct device_node *dp;
 	
 	dp = pci_device_to_OF_node(pdev);
@@ -1478,7 +1477,6 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		printk(KERN_INFO "%s: OF name %s\n",__func__, dp->name);
 	else
 		printk(KERN_ERR "imsttfb: no OF node for pci device\n");
-#endif /* CONFIG_PPC_OF */
 
 	info = framebuffer_alloc(sizeof(struct imstt_par), &pdev->dev);
 
@@ -1501,11 +1499,9 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	switch (pdev->device) {
 		case PCI_DEVICE_ID_IMS_TT128: /* IMS,tt128mbA */
 			par->ramdac = IBM;
-#ifdef CONFIG_PPC_OF
 			if (dp && ((strcmp(dp->name, "IMS,tt128mb8") == 0) ||
 				   (strcmp(dp->name, "IMS,tt128mb8A") == 0)))
 				par->ramdac = TVP;
-#endif /* CONFIG_PPC_OF */
 			break;
 		case PCI_DEVICE_ID_IMS_TT3D:  /* IMS,tt3d */
 			par->ramdac = TVP;
-- 
1.9.3

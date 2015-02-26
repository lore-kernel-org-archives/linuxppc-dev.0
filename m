Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22f.google.com (mail-yk0-x22f.google.com
 [IPv6:2607:f8b0:4002:c07::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB0431A00FB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 23:09:31 +1100 (AEDT)
Received: by ykp9 with SMTP id 9so3832808ykp.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 04:09:29 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 04/11] fbdev: imsttfb: remove the dependency on PPC_OF
Date: Thu, 26 Feb 2015 20:08:16 +0800
Message-Id: <1424952503-8247-5-git-send-email-haokexin@gmail.com>
In-Reply-To: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
References: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 linuxppc-dev@lists.ozlabs.org
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
v2: Only print the error log when CONFIG_OF is enabled.

 drivers/video/fbdev/imsttfb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index aae10ce74f14..9b167f7ef6c6 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1470,15 +1470,13 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	unsigned long addr, size;
 	struct imstt_par *par;
 	struct fb_info *info;
-#ifdef CONFIG_PPC_OF
 	struct device_node *dp;
 	
 	dp = pci_device_to_OF_node(pdev);
 	if(dp)
 		printk(KERN_INFO "%s: OF name %s\n",__func__, dp->name);
-	else
+	else if (IS_ENABLED(CONFIG_OF))
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

Return-Path: <rdunlap@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41TDJj50l5zF35s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jul 2018 03:37:41 +1000 (AEST)
To: USB list <linux-usb@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Felipe Balbi <balbi@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] usb/phy: fix PPC64 build errors in phy-fsl-usb.c
Message-ID: <cb618610-7c6a-68e5-e471-0d75afddf168@infradead.org>
Date: Sun, 15 Jul 2018 10:37:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors when built for PPC64:
These variables are only used on PPC32 so they don't need to be
initialized for PPC64.

../drivers/usb/phy/phy-fsl-usb.c: In function 'usb_otg_start':
../drivers/usb/phy/phy-fsl-usb.c:865:3: error: '_fsl_readl' undeclared (first use in this function); did you mean 'fsl_readl'?
   _fsl_readl = _fsl_readl_be;
../drivers/usb/phy/phy-fsl-usb.c:865:16: error: '_fsl_readl_be' undeclared (first use in this function); did you mean 'fsl_readl'?
   _fsl_readl = _fsl_readl_be;
../drivers/usb/phy/phy-fsl-usb.c:866:3: error: '_fsl_writel' undeclared (first use in this function); did you mean 'fsl_writel'?
   _fsl_writel = _fsl_writel_be;
../drivers/usb/phy/phy-fsl-usb.c:866:17: error: '_fsl_writel_be' undeclared (first use in this function); did you mean 'fsl_writel'?
   _fsl_writel = _fsl_writel_be;
../drivers/usb/phy/phy-fsl-usb.c:868:16: error: '_fsl_readl_le' undeclared (first use in this function); did you mean 'fsl_readl'?
   _fsl_readl = _fsl_readl_le;
../drivers/usb/phy/phy-fsl-usb.c:869:17: error: '_fsl_writel_le' undeclared (first use in this function); did you mean 'fsl_writel'?
   _fsl_writel = _fsl_writel_le;

and the sysfs "show" function return type should be ssize_t, not int:

../drivers/usb/phy/phy-fsl-usb.c:1042:49: error: initialization of 'ssize_t (*)(struct device *, struct device_attribute *, char *)' {aka 'long int (*)(struct device *, struct device_attribute *, char *)'} from incompatible pointer type 'int (*)(struct device *, struct device_attribute *, char *)' [-Werror=incompatible-pointer-types]
 static DEVICE_ATTR(fsl_usb2_otg_state, S_IRUGO, show_fsl_usb2_otg_state, NULL);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
Found when using Michael's patch for ppc64_book3e_allmodconfig.

 drivers/usb/phy/phy-fsl-usb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- lnx-418-rc4.orig/drivers/usb/phy/phy-fsl-usb.c
+++ lnx-418-rc4/drivers/usb/phy/phy-fsl-usb.c
@@ -861,6 +861,7 @@ int usb_otg_start(struct platform_device
 	if (pdata->init && pdata->init(pdev) != 0)
 		return -EINVAL;
 
+#ifdef CONFIG_PPC32
 	if (pdata->big_endian_mmio) {
 		_fsl_readl = _fsl_readl_be;
 		_fsl_writel = _fsl_writel_be;
@@ -868,6 +869,7 @@ int usb_otg_start(struct platform_device
 		_fsl_readl = _fsl_readl_le;
 		_fsl_writel = _fsl_writel_le;
 	}
+#endif
 
 	/* request irq */
 	p_otg->irq = platform_get_irq(pdev, 0);
@@ -958,7 +960,7 @@ int usb_otg_start(struct platform_device
 /*
  * state file in sysfs
  */
-static int show_fsl_usb2_otg_state(struct device *dev,
+static ssize_t show_fsl_usb2_otg_state(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct otg_fsm *fsm = &fsl_otg_dev->fsm;

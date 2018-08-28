Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4209tX3cpdzDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Aug 2018 00:21:56 +1000 (AEST)
Subject: Patch "usb/phy: fix PPC64 build errors in phy-fsl-usb.c" has been
 added to the 4.4-stable tree
To: alexander.levin@microsoft.com, balbi@kernel.org,
 felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, rdunlap@infradead.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 28 Aug 2018 16:11:49 +0200
Message-ID: <1535465509385@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

    usb/phy: fix PPC64 build errors in phy-fsl-usb.c

to the 4.4-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     usb-phy-fix-ppc64-build-errors-in-phy-fsl-usb.c.patch
and it can be found in the queue-4.4 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From foo@baz Tue Aug 28 16:10:37 CEST 2018
From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 15 Jul 2018 10:37:37 -0700
Subject: usb/phy: fix PPC64 build errors in phy-fsl-usb.c

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit a39ba90a1cc7010edb0a7132e1b67f3d80b994e9 ]

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
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/phy/phy-fsl-usb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/phy/phy-fsl-usb.c
+++ b/drivers/usb/phy/phy-fsl-usb.c
@@ -879,6 +879,7 @@ int usb_otg_start(struct platform_device
 	if (pdata->init && pdata->init(pdev) != 0)
 		return -EINVAL;
 
+#ifdef CONFIG_PPC32
 	if (pdata->big_endian_mmio) {
 		_fsl_readl = _fsl_readl_be;
 		_fsl_writel = _fsl_writel_be;
@@ -886,6 +887,7 @@ int usb_otg_start(struct platform_device
 		_fsl_readl = _fsl_readl_le;
 		_fsl_writel = _fsl_writel_le;
 	}
+#endif
 
 	/* request irq */
 	p_otg->irq = platform_get_irq(pdev, 0);
@@ -976,7 +978,7 @@ int usb_otg_start(struct platform_device
 /*
  * state file in sysfs
  */
-static int show_fsl_usb2_otg_state(struct device *dev,
+static ssize_t show_fsl_usb2_otg_state(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct otg_fsm *fsm = &fsl_otg_dev->fsm;


Patches currently in stable-queue which might be from rdunlap@infradead.org are

queue-4.4/usb-phy-fix-ppc64-build-errors-in-phy-fsl-usb.c.patch
queue-4.4/net-prevent-isa-drivers-from-building-on-ppc32.patch
queue-4.4/arc-fix-build-errors-in-arc-include-asm-delay.h.patch
queue-4.4/media-staging-omap4iss-include-asm-cacheflush.h-after-generic-includes.patch
queue-4.4/arc-fix-type-warnings-in-arc-mm-cache.c.patch

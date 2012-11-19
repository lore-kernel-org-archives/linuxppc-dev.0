Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 33A712C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:43:00 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 371/493] usb: remove use of __devinitconst
Date: Mon, 19 Nov 2012 13:25:20 -0500
Message-Id: <1353349642-3677-371-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Li Yang <leoli@freescale.com> 
Cc: Felipe Balbi <balbi@ti.com> 
Cc: linux-usb@vger.kernel.org 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 drivers/usb/gadget/fsl_qe_udc.c | 2 +-
 drivers/usb/host/bcma-hcd.c     | 2 +-
 drivers/usb/host/pci-quirks.c   | 2 +-
 drivers/usb/host/ssb-hcd.c      | 2 +-
 drivers/usb/musb/musb_dsps.c    | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index 8ad04a0..b13bc73 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -2710,7 +2710,7 @@ static int __devexit qe_udc_remove(struct platform_device *ofdev)
 }
 
 /*-------------------------------------------------------------------------*/
-static const struct of_device_id qe_udc_match[] __devinitconst = {
+static const struct of_device_id qe_udc_match[] = {
 	{
 		.compatible = "fsl,mpc8323-qe-usb",
 		.data = (void *)PORT_QE,
diff --git a/drivers/usb/host/bcma-hcd.c b/drivers/usb/host/bcma-hcd.c
index 8c83ed9..649780b 100644
--- a/drivers/usb/host/bcma-hcd.c
+++ b/drivers/usb/host/bcma-hcd.c
@@ -305,7 +305,7 @@ static int bcma_hcd_resume(struct bcma_device *dev)
 #define bcma_hcd_resume	NULL
 #endif /* CONFIG_PM */
 
-static const struct bcma_device_id bcma_hcd_table[] __devinitconst = {
+static const struct bcma_device_id bcma_hcd_table[] = {
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_USB20_HOST, BCMA_ANY_REV, BCMA_ANY_CLASS),
 	BCMA_CORETABLE_END
 };
diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index a018e70..15cfb06 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -533,7 +533,7 @@ static void quirk_usb_handoff_ohci(struct pci_dev *pdev)
 	iounmap(base);
 }
 
-static const struct dmi_system_id __devinitconst ehci_dmi_nohandoff_table[] = {
+static const struct dmi_system_id ehci_dmi_nohandoff_table[] = {
 	{
 		/*  Pegatron Lucid (ExoPC) */
 		.matches = {
diff --git a/drivers/usb/host/ssb-hcd.c b/drivers/usb/host/ssb-hcd.c
index 79aa958..bdb9d70 100644
--- a/drivers/usb/host/ssb-hcd.c
+++ b/drivers/usb/host/ssb-hcd.c
@@ -248,7 +248,7 @@ static int ssb_hcd_resume(struct ssb_device *dev)
 #define ssb_hcd_resume	NULL
 #endif /* CONFIG_PM */
 
-static const struct ssb_device_id ssb_hcd_table[] __devinitconst = {
+static const struct ssb_device_id ssb_hcd_table[] = {
 	SSB_DEVICE(SSB_VENDOR_BROADCOM, SSB_DEV_USB11_HOSTDEV, SSB_ANY_REV),
 	SSB_DEVICE(SSB_VENDOR_BROADCOM, SSB_DEV_USB11_HOST, SSB_ANY_REV),
 	SSB_DEVICE(SSB_VENDOR_BROADCOM, SSB_DEV_USB20_HOST, SSB_ANY_REV),
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index faeacd4..3377be8 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -715,7 +715,7 @@ static int dsps_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(dsps_pm_ops, dsps_suspend, dsps_resume);
 
-static const struct dsps_musb_wrapper ti81xx_driver_data __devinitconst = {
+static const struct dsps_musb_wrapper ti81xx_driver_data = {
 	.revision		= 0x00,
 	.control		= 0x14,
 	.status			= 0x18,
@@ -746,7 +746,7 @@ static const struct dsps_musb_wrapper ti81xx_driver_data __devinitconst = {
 	.instances		= 1,
 };
 
-static const struct platform_device_id musb_dsps_id_table[] __devinitconst = {
+static const struct platform_device_id musb_dsps_id_table[] = {
 	{
 		.name	= "musb-ti81xx",
 		.driver_data	= (kernel_ulong_t) &ti81xx_driver_data,
@@ -756,7 +756,7 @@ static const struct platform_device_id musb_dsps_id_table[] __devinitconst = {
 MODULE_DEVICE_TABLE(platform, musb_dsps_id_table);
 
 #ifdef CONFIG_OF
-static const struct of_device_id musb_dsps_of_match[] __devinitconst = {
+static const struct of_device_id musb_dsps_of_match[] = {
 	{ .compatible = "ti,musb-am33xx",
 		.data = (void *) &ti81xx_driver_data, },
 	{  },
-- 
1.8.0

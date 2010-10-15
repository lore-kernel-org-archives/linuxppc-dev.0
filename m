Return-Path: <eric@eukrea.com>
Received: from 68.mail-out.ovh.net (68.mail-out.ovh.net [91.121.185.69])
	by ozlabs.org (Postfix) with SMTP id 3C2D1B70E5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 23:37:41 +1100 (EST)
From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
To: linux-usb@vger.kernel.org
Subject: [PATCH] mxc_udc: add workaround for ENGcm09152 for i.MX35
Date: Fri, 15 Oct 2010 14:30:58 +0200
Message-Id: <1287145858-10239-1-git-send-email-eric@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: dbrownell@users.sourceforge.net, Dinh.Nguyen@freescale.com, gregkh@suse.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this patch gives the possibility to workaround bug ENGcm09152
on i.MX35 when the hardware workaround is also implemented on
the board.
It covers the workaround described on page 25 of the following Errata :
http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf 

Signed-off-by: Eric Bénard <eric@eukrea.com>
---
 arch/arm/mach-mx3/mach-cpuimx35.c |    1 +
 drivers/usb/gadget/fsl_mxc_udc.c  |   15 +++++++++++++++
 include/linux/fsl_devices.h       |    3 +++
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 6024bb9..a95ff79 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -132,6 +132,7 @@ static struct mxc_usbh_platform_data __maybe_unused usbh1_pdata = {
 static struct fsl_usb2_platform_data otg_device_pdata = {
 	.operating_mode	= FSL_USB2_DR_DEVICE,
 	.phy_mode	= FSL_USB2_PHY_UTMI,
+	.workaround	= FLS_USB2_WORKAROUND_ENGCM09152,
 };
 
 static int otg_mode_host;
diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index eafa6d2..5bdbfe6 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -22,6 +22,10 @@
 static struct clk *mxc_ahb_clk;
 static struct clk *mxc_usb_clk;
 
+/* workaround ENGcm09152 for i.MX35 */
+#define USBPHYCTRL_OTGBASE_OFFSET	0x608
+#define USBPHYCTRL_EVDO			(1 << 23)
+
 int fsl_udc_clk_init(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata;
@@ -84,6 +88,17 @@ eenahb:
 void fsl_udc_clk_finalize(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
+#if defined(CONFIG_ARCH_MX35)
+	unsigned int v;
+
+	/* workaround ENGcm09152 for i.MX35 */
+	if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
+		v = readl(MX35_IO_ADDRESS(MX35_OTG_BASE_ADDR +
+				USBPHYCTRL_OTGBASE_OFFSET));
+		writel(v | USBPHYCTRL_EVDO, MX35_IO_ADDRESS(MX35_OTG_BASE_ADDR +
+				USBPHYCTRL_OTGBASE_OFFSET));
+	}
+#endif
 
 	/* ULPI transceivers don't need usbpll */
 	if (pdata->phy_mode == FSL_USB2_PHY_ULPI) {
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 28e33fe..01a23fa 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -63,12 +63,15 @@ struct fsl_usb2_platform_data {
 	enum fsl_usb2_operating_modes	operating_mode;
 	enum fsl_usb2_phy_modes		phy_mode;
 	unsigned int			port_enables;
+	unsigned int			workaround;
 };
 
 /* Flags in fsl_usb2_mph_platform_data */
 #define FSL_USB2_PORT0_ENABLED	0x00000001
 #define FSL_USB2_PORT1_ENABLED	0x00000002
 
+#define FLS_USB2_WORKAROUND_ENGCM09152	(1 << 0)
+
 struct spi_device;
 
 struct fsl_spi_platform_data {
-- 
1.7.0.4

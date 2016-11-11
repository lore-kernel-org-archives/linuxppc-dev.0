Return-Path: <chunkeey@googlemail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFsjP142tzDvrQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 07:59:20 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id u144so8261wmu.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 12:59:20 -0800 (PST)
From: Christian Lamparter <chunkeey@googlemail.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: John Youn <johnyoun@synopsys.com>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 1/2] usb: dwc2: add amcc,dwc-otg support
Date: Fri, 11 Nov 2016 21:59:13 +0100
Message-Id: <b1ec4a4425388cdee36be081971484db2a7d048a.1478897792.git.chunkeey@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for the "amcc,usb-otg" device
which is found in the PowerPC Canyonlands' dts.

The device definition was added by:
commit c89b3458d8cc ("powerpc/44x: Add USB DWC DTS entry to Canyonlands board")'
but without any driver support as the dwc2 driver wasn't
available at that time.

Note: The system can't use the generic "snps,dwc2" compatible
because of the special ahbcfg configuration. The default
GAHBCFG_HBSTLEN_INCR4 of snps,dwc2 can cause a system hang
when the USB and SATA is used concurrently.

Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: John Youn <johnyoun@synopsys.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
v1->v2
	- moved definitons to params.c
	- removed dma_enable / host_dma parameter
	- added dma_desc_fs_enable parameter
---
 Documentation/devicetree/bindings/usb/dwc2.txt |  1 +
 drivers/usb/dwc2/params.c                      | 33 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 10a2a4b..6ccfe85 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -12,6 +12,7 @@ Required properties:
   - "lantiq,xrx200-usb": The DWC2 USB controller instance in Lantiq XRX SoCs;
   - "amlogic,meson8b-usb": The DWC2 USB controller instance in Amlogic Meson8b SoCs;
   - "amlogic,meson-gxbb-usb": The DWC2 USB controller instance in Amlogic S905 SoCs;
+  - "amcc,dwc-otg": The DWC2 USB controller instance in AMCC Canyonlands 460EX SoCs;
   - snps,dwc2: A generic DWC2 USB controller with default parameters.
 - reg : Should contain 1 register range (address and length)
 - interrupts : Should contain 1 interrupt
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 64d5c66..5d822c5 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -192,6 +192,38 @@ static const struct dwc2_core_params params_amlogic = {
 	.hibernation			= -1,
 };
 
+static const struct dwc2_core_params params_amcc_dwc_otg = {
+	.otg_cap			= DWC2_CAP_PARAM_HNP_SRP_CAPABLE,
+	.otg_ver			= -1,
+	.dma_desc_enable		= -1,
+	.dma_desc_fs_enable		= -1,
+	.speed				= -1,
+	.enable_dynamic_fifo		= -1,
+	.en_multiple_tx_fifo		= -1,
+	.host_rx_fifo_size		= -1,
+	.host_nperio_tx_fifo_size	= -1,
+	.host_perio_tx_fifo_size	= -1,
+	.max_transfer_size		= -1,
+	.max_packet_count		= -1,
+	.host_channels			= -1,
+	.phy_type			= -1,
+	.phy_utmi_width			= -1,
+	.phy_ulpi_ddr			= -1,
+	.phy_ulpi_ext_vbus		= -1,
+	.i2c_enable			= -1,
+	.ulpi_fs_ls			= -1,
+	.host_support_fs_ls_low_power	= -1,
+	.host_ls_low_power_phy_clk	= -1,
+	.ts_dline			= -1,
+	.reload_ctl			= -1,
+	/* Avoid system hang during concurrently using USB and SATA */
+	.ahbcfg				= GAHBCFG_HBSTLEN_INCR16 <<
+					  GAHBCFG_HBSTLEN_SHIFT,
+	.uframe_sched			= -1,
+	.external_id_pin_ctl		= -1,
+	.hibernation			= -1,
+};
+
 static const struct dwc2_core_params params_default = {
 	.otg_cap			= -1,
 	.otg_ver			= -1,
@@ -239,6 +271,7 @@ const struct of_device_id dwc2_of_match_table[] = {
 	{ .compatible = "samsung,s3c6400-hsotg", .data = NULL},
 	{ .compatible = "amlogic,meson8b-usb", .data = &params_amlogic },
 	{ .compatible = "amlogic,meson-gxbb-usb", .data = &params_amlogic },
+	{ .compatible = "amcc,dwc-otg", .data = &params_amcc_dwc_otg },
 	{},
 };
 MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
-- 
2.10.2

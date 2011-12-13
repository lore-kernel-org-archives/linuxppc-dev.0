Return-Path: <eric@eukrea.com>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
 by ozlabs.org (Postfix) with ESMTP id AB4441007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 17:32:04 +1100 (EST)
From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/19] mxc_udc: add workaround for ENGcm09152 for i.MX25
Date: Tue, 13 Dec 2011 07:31:33 +0100
Message-Id: <1323757911-25217-1-git-send-email-eric@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
 "open list:FREESCALE USB PER..." <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>,
 Sascha Hauer <kernel@pengutronix.de>,
 "open list:FREESCALE USB PER..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this patch gives the possibility to workaround bug ENGcm09152
on i.MX25 when the hardware workaround is also implemented on
the board.
It covers the workaround described on page 42 of the following Errata :
http://cache.freescale.com/files/dsp/doc/errata/IMX25CE.pdf

Signed-off-by: Eric Bénard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Li Yang <leoli@freescale.com>
---
 drivers/usb/gadget/fsl_mxc_udc.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index dcbc0a2..4aff05d 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -23,7 +23,7 @@
 static struct clk *mxc_ahb_clk;
 static struct clk *mxc_usb_clk;
 
-/* workaround ENGcm09152 for i.MX35 */
+/* workaround ENGcm09152 for i.MX25/35 */
 #define USBPHYCTRL_OTGBASE_OFFSET	0x608
 #define USBPHYCTRL_EVDO			(1 << 23)
 
@@ -89,16 +89,20 @@ eenahb:
 void fsl_udc_clk_finalize(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
-	if (cpu_is_mx35()) {
+	if (cpu_is_mx25() || cpu_is_mx35()) {
 		unsigned int v;
-
-		/* workaround ENGcm09152 for i.MX35 */
+		void __iomem *otgbase;
+		if (cpu_is_mx25())
+			otgbase = MX25_IO_ADDRESS(MX25_USB_BASE_ADDR +
+					USBPHYCTRL_OTGBASE_OFFSET);
+		else if (cpu_is_mx35())
+			otgbase = MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
+					USBPHYCTRL_OTGBASE_OFFSET);
+
+		/* workaround ENGcm09152 for i.MX25/35 */
 		if (pdata->workaround & FLS_USB2_WORKAROUND_ENGCM09152) {
-			v = readl(MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-					USBPHYCTRL_OTGBASE_OFFSET));
-			writel(v | USBPHYCTRL_EVDO,
-				MX35_IO_ADDRESS(MX35_USB_BASE_ADDR +
-					USBPHYCTRL_OTGBASE_OFFSET));
+			v = readl(otgbase);
+			writel(v | USBPHYCTRL_EVDO, otgbase);
 		}
 	}
 
-- 
1.7.6.4

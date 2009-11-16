Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 7DF5C100807
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 10:00:25 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: netdev@vger.kernel.org
Date: Mon, 16 Nov 2009 23:57:51 +0100
Message-Id: <1258412274-14686-9-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
References: <1258412274-14686-1-git-send-email-w.sang@pengutronix.de>
Subject: [PATCH 08/11] net/can/mpc52xx_can: improve properties and their
	description
Cc: devicetree-discuss@ozlabs.org, socketcan-core@lists.berlios.de,
	linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: devicetree-discuss@ozlabs.org
---
 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt |    9 +++++----
 drivers/net/can/mscan/mpc52xx_can.c                |    3 +--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt b/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
index b151fb1..cabc780 100644
--- a/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
@@ -181,9 +181,10 @@ External interrupts:
 fsl,mpc5200-mscan nodes
 -----------------------
 In addition to the required compatible-, reg- and interrupt-properites, you can
-also specify which clock shall be used for the bus:
+also specify which clock source shall be used for the controller:
 
-- fsl,mscan-clk-src	- a string describing the clock source. Valid values
-			  are "ip" for IP_CLK and "sys" for SYS_XTAL.
-			  "sys" is the default in case the property is not
+- fsl,mscan-clock-source- a string describing the clock source. Valid values
+			  are:	"ip" for ip bus clock
+				"ref" for reference clock (XTAL)
+			  "ref" is default in case this property is not
 			  present.
diff --git a/drivers/net/can/mscan/mpc52xx_can.c b/drivers/net/can/mscan/mpc52xx_can.c
index a915959..1de6f63 100644
--- a/drivers/net/can/mscan/mpc52xx_can.c
+++ b/drivers/net/can/mscan/mpc52xx_can.c
@@ -130,7 +130,7 @@ static int __devinit mpc5xxx_can_probe(struct of_device *ofdev,
 	 * choice as it has less jitter. For this reason, it is selected
 	 * by default.
 	 */
-	clk_src = of_get_property(np, "fsl,mscan-clk-src", NULL);
+	clk_src = of_get_property(np, "fsl,mscan-clock-source", NULL);
 	if (clk_src && strcmp(clk_src, "ip") == 0)
 		clock_src = MSCAN_CLKSRC_BUS;
 	else
@@ -227,7 +227,6 @@ static int mpc5xxx_can_resume(struct of_device *ofdev)
 
 static struct of_device_id __devinitdata mpc5xxx_can_table[] = {
 	{.compatible = "fsl,mpc5200-mscan"},
-	{.compatible = "fsl,mpc5200b-mscan"},
 	{},
 };
 
-- 
1.6.3.3

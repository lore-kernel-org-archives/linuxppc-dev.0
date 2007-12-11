Return-Path: <mgreer@mvista.com>
Date: Mon, 10 Dec 2007 17:38:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/8] powerpc: mv64x60 - Update ethernet DTS nodes
Message-ID: <20071211003839.GE4995@mag.az.mvista.com>
References: <20071211003108.GA4995@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071211003108.GA4995@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

DTS entries for mv64360 ethernet controllers should use 'reg' property
instead of the 'block-index' property.  Also, use 'multiethernet'
instead of 'ethernet' for parent node and use 'ethernet@?' instead of
'eth?' for subnodes.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/boot/dts/prpmc2800.dts |   10 +++++-----
 arch/powerpc/sysdev/mv64x60_dev.c   |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/prpmc2800.dts b/arch/powerpc/boot/dts/prpmc2800.dts
index a4a3622..1447faa 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -110,21 +110,21 @@
 			};
 		};
 
-		ethernet@2000 {
+		multiethernet@2000 {
 			reg = <0x2000 0x2000>;
-			eth0 {
+			ethernet@0 {
 				device_type = "network";
 				compatible = "marvell,mv64360-eth";
-				block-index = <0>;
+				reg = <0>;
 				interrupts = <32>;
 				interrupt-parent = <&PIC>;
 				phy = <&PHY0>;
 				local-mac-address = [ 00 00 00 00 00 00 ];
 			};
-			eth1 {
+			ethernet@1 {
 				device_type = "network";
 				compatible = "marvell,mv64360-eth";
-				block-index = <1>;
+				reg = <1>;
 				interrupts = <33>;
 				interrupt-parent = <&PIC>;
 				phy = <&PHY1>;
diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index dca205f..20cd5e3 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -248,7 +248,7 @@ static int __init mv64x60_eth_device_setup(struct device_node *np, int id)
 
 	memset(&pdata, 0, sizeof(pdata));
 
-	prop = of_get_property(np, "block-index", NULL);
+	prop = of_get_property(np, "reg", NULL);
 	if (!prop)
 		return -ENODEV;
 	pdata.port_number = *prop;

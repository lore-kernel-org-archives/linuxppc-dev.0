Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59D78DE03B
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 08:11:39 +1000 (EST)
Date: Mon, 7 Apr 2008 15:11:27 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: paulus@samba.org
Message-ID: <20080407221126.GF24979@farnsworth.org>
References: <20080407220027.GA24510@farnsworth.org>
MIME-Version: 1.0
In-Reply-To: <20080407220027.GA24510@farnsworth.org>
Subject: [PATCH 6/8 v3] [POWERPC] mv643xx_eth: prepare to support multiple
	silicon blocks
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

The mv643xx_eth driver is being modified to support multiple instances
of the ethernet silicon block on the same platform.  Each block contains
a single register bank containing the registers for up to three ports
interleaved within that bank.  This patch updates the PowerPC OF to
platform_device glue code to support multiple silicon blocks, each
with up to three ethernet ports.  The main difference is that we now
allow multiple mv64x60_shared platform_devices to be registered and
we provide each port platform_device with a pointer to its associated
shared platform_device.  The pointer will not be used until the
mv643xx_eth driver changes are committed.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Acked-by: Mark Greer <mgreer@mvista.com>

---
 arch/powerpc/boot/dts/prpmc2800.dts |   13 ++++--
 arch/powerpc/sysdev/mv64x60_dev.c   |   52 ++++++++++++++------------
 2 files changed, 37 insertions(+), 28 deletions(-)

Index: linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/prpmc2800.dts
+++ linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
@@ -91,21 +91,24 @@
 			};
 		};
 
-		ethernet@2000 {
+		ethernet-group@2000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "marvell,mv64360-eth-group";
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
Index: linux-2.6/arch/powerpc/sysdev/mv64x60_dev.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mv64x60_dev.c
+++ linux-2.6/arch/powerpc/sysdev/mv64x60_dev.c
@@ -206,30 +206,24 @@ error:
 /*
  * Create mv64x60_eth platform devices
  */
-static int __init eth_register_shared_pdev(struct device_node *np)
+static struct platform_device * __init mv64x60_eth_register_shared_pdev(
+						struct device_node *np, int id)
 {
 	struct platform_device *pdev;
 	struct resource r[1];
 	int err;
 
-	np = of_get_parent(np);
-	if (!np)
-		return -ENODEV;
-
 	err = of_address_to_resource(np, 0, &r[0]);
-	of_node_put(np);
 	if (err)
-		return err;
+		return ERR_PTR(err);
 
-	pdev = platform_device_register_simple(MV643XX_ETH_SHARED_NAME, 0,
+	pdev = platform_device_register_simple(MV643XX_ETH_SHARED_NAME, id,
 					       r, 1);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
-
-	return 0;
+	return pdev;
 }
 
-static int __init mv64x60_eth_device_setup(struct device_node *np, int id)
+static int __init mv64x60_eth_device_setup(struct device_node *np, int id,
+					   struct platform_device *shared_pdev)
 {
 	struct resource r[1];
 	struct mv643xx_eth_platform_data pdata;
@@ -240,16 +234,12 @@ static int __init mv64x60_eth_device_set
 	const phandle *ph;
 	int err;
 
-	/* only register the shared platform device the first time through */
-	if (id == 0 && (err = eth_register_shared_pdev(np)))
-		return err;
-
 	memset(r, 0, sizeof(r));
 	of_irq_to_resource(np, 0, &r[0]);
 
 	memset(&pdata, 0, sizeof(pdata));
 
-	prop = of_get_property(np, "block-index", NULL);
+	prop = of_get_property(np, "reg", NULL);
 	if (!prop)
 		return -ENODEV;
 	pdata.port_number = *prop;
@@ -302,7 +292,7 @@ static int __init mv64x60_eth_device_set
 
 	of_node_put(phy);
 
-	pdev = platform_device_alloc(MV643XX_ETH_NAME, pdata.port_number);
+	pdev = platform_device_alloc(MV643XX_ETH_NAME, id);
 	if (!pdev)
 		return -ENOMEM;
 
@@ -437,8 +427,9 @@ error:
 
 static int __init mv64x60_device_setup(void)
 {
-	struct device_node *np = NULL;
-	int id;
+	struct device_node *np, *np2;
+	struct platform_device *pdev;
+	int id, id2;
 	int err;
 
 	id = 0;
@@ -447,9 +438,24 @@ static int __init mv64x60_device_setup(v
 			goto error;
 
 	id = 0;
-	for_each_compatible_node(np, "network", "marvell,mv64360-eth")
-		if ((err = mv64x60_eth_device_setup(np, id++)))
+	id2 = 0;
+	for_each_compatible_node(np, NULL, "marvell,mv64360-eth-group") {
+		pdev = mv64x60_eth_register_shared_pdev(np, id++);
+		if (IS_ERR(pdev)) {
+			err = PTR_ERR(pdev);
 			goto error;
+		}
+		for_each_child_of_node(np, np2) {
+			if (!of_device_is_compatible(np2,
+					"marvell,mv64360-eth"))
+				continue;
+			err = mv64x60_eth_device_setup(np2, id2++, pdev);
+			if (err) {
+				of_node_put(np2);
+				goto error;
+			}
+		}
+	}
 
 	id = 0;
 	for_each_compatible_node(np, "i2c", "marvell,mv64360-i2c")

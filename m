Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 9634ADDFA7
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 10:35:06 +1000 (EST)
Date: Wed, 25 Apr 2007 17:37:48 -0700
From: Dave Jiang <djiang@mvista.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org, afleming@freescale.com
Subject: Re: [PATCH] powerpc: Add EDAC platform devices for 85xx
Message-ID: <20070426003748.GA30730@blade.az.mvista.com>
References: <20070425213700.GA8814@blade.az.mvista.com>
	<20070426000852.GA2193@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20070426000852.GA2193@localhost.localdomain>
Cc: bluesmoke-devel@lists.sourceforge.net, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add memory controller and l2-cache controller entries in the dts files for 85xx
platforms. Also adding code to create the platform devices used by EDAC drivers
to claim the resources in order to access the error registers and interrupts. 

Signed-off-by: Dave Jiang <djiang@mvista.com>

---

Removed explicit phandles as suggested by David Gibson. 

 arch/powerpc/boot/dts/mpc8540ads.dts |   19 ++++++
 arch/powerpc/boot/dts/mpc8548cds.dts |   19 ++++++
 arch/powerpc/boot/dts/mpc8560ads.dts |   21 ++++++-
 arch/powerpc/sysdev/fsl_soc.c        |  115 ++++++++++++++++++++++++++++++++++
 4 files changed, 173 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index f261d64..63c274d 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -48,6 +48,25 @@
 		reg = <e0000000 00100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
+		mem-ctrl@2000 {
+			device_type = "mem-ctrl";
+			compatible = "85xx";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache@20000 {
+			device_type = "l2-cache";
+			compatible = "85xx";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <40000>;	// L2, 256K
+			32-bit;
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		i2c@3000 {
 			device_type = "i2c";
 			compatible = "fsl-i2c";
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index b2b2200..f8a9f3f 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -48,6 +48,25 @@
 		reg = <e0000000 00100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
+		mem-ctrl@2000 {
+			device_type = "mem-ctrl";
+			compatible = "85xx";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache@20000 {
+			device_type = "l2-cache";
+			compatible = "85xx";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <40000>;	// L2, 256K
+			32-bit;
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		i2c@3000 {
 			device_type = "i2c";
 			compatible = "fsl-i2c";
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 1f2afe9..43ee847 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -48,6 +48,25 @@
 		reg = <e0000000 00000200>;
 		bus-frequency = <13ab6680>;
 
+		mem-ctrl@2000 {
+			device_type = "mem-ctrl";
+			compatible = "85xx";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache@20000 {
+			device_type = "l2-cache";
+			compatible = "85xx";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <40000>;	// L2, 256K
+			32-bit;
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		mdio@24520 {
 			device_type = "mdio";
 			compatible = "gianfar";
@@ -110,7 +129,7 @@
 			#address-cells = <3>;
 			compatible = "85xx";
 			device_type = "pci";
-			reg = <8000 400>;
+			reg = <8000 1000>;
 			clock-frequency = <3f940aa>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 8a123c7..a0beb8b 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1103,3 +1103,118 @@ err:
 arch_initcall(cpm_smc_uart_of_init);
 
 #endif /* CONFIG_8xx */
+
+/* platform device setup for EDAC */
+#ifdef CONFIG_PPC_85xx
+static int __init mpc85xx_mc_err_init(void)
+{
+	struct resource r[2];
+	struct device_node *np;
+	struct platform_device *pdev;
+	int ret = 0;
+
+	memset(r, 0, sizeof(r));
+
+	np = of_find_compatible_node(NULL, "mem-ctrl", "85xx");
+	if (!np)
+		return 0;
+
+	ret = of_address_to_resource(np, 0, &r[0]);
+	if (ret)
+		goto err;
+
+	of_irq_to_resource(np, 0, &r[1]);
+
+	of_node_put(np);
+
+	pdev = platform_device_register_simple("mpc85xx_mc_err", 0, r, 2);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
+
+err:
+	of_node_put(np);
+	printk(KERN_WARNING "mpc85xx-mem-ctrl setup failed\n");
+	return 0;
+}
+arch_initcall(mpc85xx_mc_err_init);
+
+static int __init mpc85xx_l2_err_init(void)
+{
+	struct resource r[2];
+	struct device_node *np;
+	struct platform_device *pdev;
+	int ret = 0;
+
+	memset(r, 0, sizeof(r));
+
+	np = of_find_compatible_node(NULL, "l2-cache", "85xx");
+	if (!np)
+		return 0;
+
+	ret = of_address_to_resource(np, 0, &r[0]);
+	if (ret)
+		goto err;
+	
+	/* we only need access to the error registers */
+	r[0].start += 0xe00;
+
+	of_irq_to_resource(np, 0, &r[1]);
+
+	of_node_put(np);
+
+	pdev = platform_device_register_simple("mpc85xx_l2_err", 0, r, 2);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return 0;
+
+err:
+	of_node_put(np);
+	printk(KERN_WARNING "mpc85xx-l2 setup failed\n");
+	return 0;
+}
+arch_initcall(mpc85xx_l2_err_init);
+
+static int __init mpc85xx_pci_err_init(void)
+{
+	struct resource r[2];
+	struct device_node *np = NULL;
+	struct platform_device *pdev;
+	int i;
+	int ret = 0;
+
+	for (i = 0;
+		(np = of_find_compatible_node(np, "pci", "85xx"));
+		i++) {
+		memset(r, 0, sizeof(r));
+
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			goto err;
+	
+		/* we only need access to the error registers */
+		r[0].start += 0xe00;
+
+		of_irq_to_resource(np, 0, &r[1]);
+
+		pdev = platform_device_register_simple("mpc85xx_pci_err", 
+				i, r, 2);
+		if (IS_ERR(pdev)) {
+			ret = PTR_ERR(pdev);
+			goto err;
+		}
+
+	}
+
+	return 0;
+
+err:
+	of_node_put(np);
+	printk(KERN_WARNING "mpc85xx-pci setup failed\n");
+	return ret;
+}
+arch_initcall(mpc85xx_pci_err_init);
+
+#endif /* CONFIG_PPC_85xx */

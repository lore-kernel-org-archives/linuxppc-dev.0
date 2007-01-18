Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 282EDDDE3F
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 05:27:39 +1100 (EST)
Date: Thu, 18 Jan 2007 10:54:56 -0700
From: Dave Jiang <djiang@mvista.com>
To: galak@kernel.crashing.org
Subject: Re: Re: EDAC platform device for fsl_soc
Message-ID: <20070118175456.GB7061@blade.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar,
  Will something like this work?


--- powerpc-djwork/arch/powerpc/boot/dts/mpc8560ads.dts	2007-01-18 09:10:58.000000000 -0700
+++ powerpc-8560/arch/powerpc/boot/dts/mpc8560ads.dts	2007-01-18 09:06:52.000000000 -0700
@@ -54,6 +54,27 @@
 		reg = <e0000000 00000200>;
 		bus-frequency = <13ab6680>;
 
+		memory-controller@2000 {
+			device_type = "memctlr";
+			compatible = "85xx";
+			reg = <2000 1000>;
+			linux,phandle = <2000>;
+			interrupt-parent = <40000>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache@20000 {
+			device_type = "l2";
+			compatible = "8560";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <40000>;	// L2, 256K
+			32-bit;
+			linux,phandle = <20e00>;
+			interrupt-parent = <40000>;
+			interrupts = <0 2>;
+		};
+
 		mdio@24520 {
 			device_type = "mdio";
 			compatible = "gianfar";
@@ -122,7 +143,7 @@
 			#address-cells = <3>;
 			compatible = "85xx";
 			device_type = "pci";
-			reg = <8000 400>;
+			reg = <8000 1000>;
 			clock-frequency = <3f940aa>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
@@ -200,7 +221,7 @@
 					 a800 0 0 4 40000 31 1>;
 
 			interrupt-parent = <40000>;
-			interrupts = <42 0>;
+			interrupts = <8 2>;
 			bus-range = <0 0>;
 			ranges = <02000000 0 80000000 80000000 0 20000000
 				  01000000 0 00000000 e2000000 0 01000000>;
--- powerpc-djwork/arch/powerpc/sysdev/fsl_soc.c	2007-01-18 09:10:58.000000000 -0700
+++ powerpc-8560/arch/powerpc/sysdev/fsl_soc.c	2007-01-17 16:21:00.000000000 -0700
@@ -357,6 +382,81 @@ err:
 
 arch_initcall(fsl_i2c_of_init);
 
+#if defined(CONFIG_EDAC_MPC85XX) || defined(CONFIG_EDAC_MPC85XX_MODULE)
+static const char *mpc85xx_edac_mc = "mpc85xx dram";
+static const char *mpc85xx_edac_pci = "mpc85xx pci";
+static const char *mpc85xx_edac_l2 = "mpc85xx l2 cache";
+
+static int __init mpc85xx_edac_init(void)
+{
+	struct resource r[6];
+	struct device_node *np;
+	struct platform_device *pldev;
+	int ret;
+
+	memset(r, 0, sizeof(r));
+
+	np = of_find_node_by_type(NULL, "memctlr");
+	if(!np)
+		return -ENODEV;
+
+	ret = of_address_to_resource(np, 0, &r[0]);
+	if (ret)
+		return ret;
+
+	r[0].name = mpc85xx_edac_mc;
+
+	of_irq_to_resource(np, 0, &r[1]);
+	r[1].name = mpc85xx_edac_mc;
+
+	of_node_put(np);
+
+	np = of_find_node_by_type(NULL, "pci");
+	if(!np)
+		return -ENODEV;
+
+	ret = of_address_to_resource(np, 0, &r[2]);
+	if (ret)
+		return ret;
+
+	r[2].name = mpc85xx_edac_pci;
+
+	/* we only need the error registers */
+	r[2].start += 0xe00;
+
+	of_irq_to_resource(np, 0, &r[3]);
+	r[3].name = mpc85xx_edac_pci;
+
+	of_node_put(np);
+
+	np = of_find_node_by_type(NULL, "l2");
+	if(!np)
+		return -ENODEV;
+
+	ret = of_address_to_resource(np, 0, &r[4]);
+	if (ret)
+		return ret;
+
+	r[4].name = mpc85xx_edac_l2;
+
+	/* we only need access to the error registers */
+	r[4].start += 0xe00;
+
+	of_irq_to_resource(np, 0, &r[5]);
+	r[5].name = mpc85xx_edac_l2;
+
+	of_node_put(np);
+
+	pldev = platform_device_register_simple("mpc85xx_edac", 0, r, 6);
+	if (IS_ERR(pldev)) {
+		return PTR_ERR(pldev);
+	}
+
+	return ret;
+}
+arch_initcall(mpc85xx_edac_init);
+#endif
+
 #ifdef CONFIG_PPC_83xx
 static int __init mpc83xx_wdt_init(void)
 {

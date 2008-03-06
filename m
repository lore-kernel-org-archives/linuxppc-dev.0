Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 541AEDDDF2
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 21:32:14 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m26AW5GX022116
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 03:32:06 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m26AW0Yp009156
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 04:32:01 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 2/2] Add local bus device nodes to MPC837xMDS device trees.
Date: Thu,  6 Mar 2008 18:42:35 +0800
Message-Id: <1204800155-11613-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8377_mds.dts     |   66 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8378_mds.dts     |   66 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8379_mds.dts     |   66 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc837x_mds.c |    8 +--
 4 files changed, 201 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 677a061..3aac8b7 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -47,6 +47,72 @@
 		reg = <0x00000000 0x20000000>;	// 512MB at 0
 	};
 
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8377-elbc", "fsl,elbc", "simple-bus";
+		reg = <0xe0005000 0x1000>;
+		interrupts = <77 0x8>;
+		interrupt-parent = <&ipic>;
+
+		// booting from NOR flash
+		ranges = <0 0x0 0xfe000000 0x02000000
+		          1 0x0 0xf8000000 0x00008000
+		          3 0x0 0xe0600000 0x00008000>;
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0 0x0 0x2000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			u-boot@0 {
+				reg = <0x0 0x100000>;
+				read-only;
+			};
+
+			fs@100000 {
+				reg = <0x100000 0x800000>;
+			};
+
+			kernel@1d00000 {
+				reg = <0x1d00000 0x200000>;
+			};
+
+			dtb@1f00000 {
+				reg = <0x1f00000 0x100000>;
+			};
+		};
+
+		bcsr@1,0 {
+			reg = <1 0x0 0x8000>;
+			compatible = "fsl,mpc837xmds-bcsr";
+		};
+
+		nand@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8377-fcm-nand",
+			             "fsl,elbc-fcm-nand";
+			reg = <3 0x0 0x8000>;
+
+			u-boot@0 {
+				reg = <0x0 0x100000>;
+				read-only;
+			};
+
+			kernel@100000 {
+				reg = <0x100000 0x300000>;
+			};
+
+			fs@400000 {
+				reg = <0x400000 0x1c00000>;
+			};
+		};
+	};
+
 	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 3f9e9fe..2496e19 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -47,6 +47,72 @@
 		reg = <0x00000000 0x20000000>;	// 512MB at 0
 	};
 
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8378-elbc", "fsl,elbc", "simple-bus";
+		reg = <0xe0005000 0x1000>;
+		interrupts = <77 0x8>;
+		interrupt-parent = <&ipic>;
+
+		// booting from NOR flash
+		ranges = <0 0x0 0xfe000000 0x02000000
+		          1 0x0 0xf8000000 0x00008000
+		          3 0x0 0xe0600000 0x00008000>;
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0 0x0 0x2000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			u-boot@0 {
+				reg = <0x0 0x100000>;
+				read-only;
+			};
+
+			fs@100000 {
+				reg = <0x100000 0x800000>;
+			};
+
+			kernel@1d00000 {
+				reg = <0x1d00000 0x200000>;
+			};
+
+			dtb@1f00000 {
+				reg = <0x1f00000 0x100000>;
+			};
+		};
+
+		bcsr@1,0 {
+			reg = <1 0x0 0x8000>;
+			compatible = "fsl,mpc837xmds-bcsr";
+		};
+
+		nand@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8378-fcm-nand",
+			             "fsl,elbc-fcm-nand";
+			reg = <3 0x0 0x8000>;
+
+			u-boot@0 {
+				reg = <0x0 0x100000>;
+				read-only;
+			};
+
+			kernel@100000 {
+				reg = <0x100000 0x300000>;
+			};
+
+			fs@400000 {
+				reg = <0x400000 0x1c00000>;
+			};
+		};
+	};
+
 	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index 36c1c13..5ae4644 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -47,6 +47,72 @@
 		reg = <0x00000000 0x20000000>;	// 512MB at 0
 	};
 
+	localbus@e0005000 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		compatible = "fsl,mpc8379-elbc", "fsl,elbc", "simple-bus";
+		reg = <0xe0005000 0x1000>;
+		interrupts = <77 0x8>;
+		interrupt-parent = <&ipic>;
+
+		// booting from NOR flash
+		ranges = <0 0x0 0xfe000000 0x02000000
+		          1 0x0 0xf8000000 0x00008000
+		          3 0x0 0xe0600000 0x00008000>;
+
+		flash@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0 0x0 0x2000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			u-boot@0 {
+				reg = <0x0 0x100000>;
+				read-only;
+			};
+
+			fs@100000 {
+				reg = <0x100000 0x800000>;
+			};
+
+			kernel@1d00000 {
+				reg = <0x1d00000 0x200000>;
+			};
+
+			dtb@1f00000 {
+				reg = <0x1f00000 0x100000>;
+			};
+		};
+
+		bcsr@1,0 {
+			reg = <1 0x0 0x8000>;
+			compatible = "fsl,mpc837xmds-bcsr";
+		};
+
+		nand@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc8379-fcm-nand",
+			             "fsl,elbc-fcm-nand";
+			reg = <3 0x0 0x8000>;
+
+			u-boot@0 {
+				reg = <0x0 0x100000>;
+				read-only;
+			};
+
+			kernel@100000 {
+				reg = <0x100000 0x300000>;
+			};
+
+			fs@400000 {
+				reg = <0x400000 0x1c00000>;
+			};
+		};
+	};
+
 	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 8a9c269..1f4b7e8 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -39,12 +39,9 @@ static int mpc837xmds_usb_cfg(void)
 	if (ret)
 		return ret;
 	/* Map BCSR area */
-	np = of_find_node_by_name(NULL, "bcsr");
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc837xmds-bcsr");
 	if (np) {
-		struct resource res;
-
-		of_address_to_resource(np, 0, &res);
-		bcsr_regs = ioremap(res.start, res.end - res.start + 1);
+		bcsr_regs = of_iomap(np, 0);
 		of_node_put(np);
 	}
 	if (!bcsr_regs)
@@ -96,6 +93,7 @@ static void __init mpc837x_mds_setup_arch(void)
 static struct of_device_id mpc837x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
 	{},
 };
 
-- 
1.5.4.rc4

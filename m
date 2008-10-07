Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38C34DE02F
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 06:18:41 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m97J0gJ5004679
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Oct 2008 12:00:43 -0700 (MST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc: 83xx: pci: Remove need for get_immrbase from
	mpc83xx_add_bridge.
Date: Tue,  7 Oct 2008 13:00:18 -0600
Message-Id: <1223406020-12278-2-git-send-email-jrigby@freescale.com>
In-Reply-To: <1223406020-12278-1-git-send-email-jrigby@freescale.com>
References: <1223406020-12278-1-git-send-email-jrigby@freescale.com>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Modify mpc83xx_add_bridge to get config space register base address from the device
tree instead of immr + hardcoded offset.

83xx pci nodes have this change:
    register properties now contain two address length tuples:
	First is the pci bridge register base, this has always been there.
	Second is the config base, this is new.

This is documented in Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt

The changes accomplish these things:
    mpc83xx_add_bridge no longer needs to call get_immrbase
    it uses hard coded addresses if the second register value is missing

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 .../powerpc/dts-bindings/fsl/83xx-512x-pci.txt     |   40 ++++++++++++++
 arch/powerpc/boot/dts/mpc8313erdb.dts              |    3 +-
 arch/powerpc/boot/dts/mpc8315erdb.dts              |    3 +-
 arch/powerpc/boot/dts/mpc832x_mds.dts              |    3 +-
 arch/powerpc/boot/dts/mpc832x_rdb.dts              |    3 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts             |    6 ++-
 arch/powerpc/boot/dts/mpc8349emitxgp.dts           |    3 +-
 arch/powerpc/boot/dts/mpc834x_mds.dts              |    6 ++-
 arch/powerpc/boot/dts/mpc836x_mds.dts              |    3 +-
 arch/powerpc/boot/dts/mpc836x_rdk.dts              |    3 +-
 arch/powerpc/boot/dts/mpc8377_mds.dts              |    3 +-
 arch/powerpc/boot/dts/mpc8377_rdb.dts              |    3 +-
 arch/powerpc/boot/dts/mpc8378_mds.dts              |    3 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts              |    3 +-
 arch/powerpc/boot/dts/mpc8379_mds.dts              |    3 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts              |    3 +-
 arch/powerpc/boot/dts/sbc8349.dts                  |    3 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   54 +++++++++++++-------
 18 files changed, 111 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt

diff --git a/Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt b/Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt
new file mode 100644
index 0000000..35a4653
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt
@@ -0,0 +1,40 @@
+* Freescale 83xx and 512x PCI bridges
+
+Freescale 83xx and 512x SOCs include the same pci bridge core.
+
+83xx/512x specific notes:
+- reg: should contain two address length tuples
+    The first is for the internal pci bridge registers
+    The second is for the pci config space access registers
+
+Example (MPC8313ERDB)
+	pci0: pci@e0008500 {
+		cell-index = <1>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+				/* IDSEL 0x0E -mini PCI */
+				 0x7000 0x0 0x0 0x1 &ipic 18 0x8
+				 0x7000 0x0 0x0 0x2 &ipic 18 0x8
+				 0x7000 0x0 0x0 0x3 &ipic 18 0x8
+				 0x7000 0x0 0x0 0x4 &ipic 18 0x8
+
+				/* IDSEL 0x0F - PCI slot */
+				 0x7800 0x0 0x0 0x1 &ipic 17 0x8
+				 0x7800 0x0 0x0 0x2 &ipic 18 0x8
+				 0x7800 0x0 0x0 0x3 &ipic 17 0x8
+				 0x7800 0x0 0x0 0x4 &ipic 18 0x8>;
+		interrupt-parent = <&ipic>;
+		interrupts = <66 0x8>;
+		bus-range = <0x0 0x0>;
+		ranges = <0x02000000 0x0 0x90000000 0x90000000 0x0 0x10000000
+			  0x42000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xe2000000 0x0 0x00100000>;
+		clock-frequency = <66666666>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
+		compatible = "fsl,mpc8349-pci";
+		device_type = "pci";
+	};
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 5390855..747f276 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -363,7 +363,8 @@
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			reg = <0xe0008500 0x100>;
+			reg = <0xe0008500 0x100		/* internal registers */
+			       0xe0008300 0x8>;		/* config space access registers */
 			compatible = "fsl,mpc8349-pci";
 			device_type = "pci";
 		};
diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 94c9b41..7449e54 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -318,7 +318,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 015808a..e4cc176 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -423,7 +423,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index b5b0ec2..226ff06 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -331,7 +331,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 1327a61..5cedf37 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -254,7 +254,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
@@ -280,7 +281,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008600 0x100>;
+		reg = <0xe0008600 0x100		/* internal registers */
+		       0xe0008380 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index f70d3a0..81ae1d3 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -228,7 +228,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008600 0x100>;
+		reg = <0xe0008600 0x100		/* internal registers */
+		       0xe0008380 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index e29739e..04bfde3 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -315,7 +315,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
@@ -376,7 +377,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008600 0x100>;
+		reg = <0xe0008600 0x100		/* internal registers */
+		       0xe0008380 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 49aec71..66a12d2 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -426,7 +426,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index 69c9bd2..f747747 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -409,7 +409,8 @@
 		#interrupt-cells = <1>;
 		device_type = "pci";
 		compatible = "fsl,mpc8360-pci", "fsl,mpc8349-pci";
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		ranges = <0x02000000 0 0x90000000 0x90000000 0 0x10000000
 			  0x42000000 0 0x80000000 0x80000000 0 0x10000000
 			  0x01000000 0 0xe0300000 0xe0300000 0 0x00100000>;
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 78f0f11..87314c7 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -378,7 +378,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index d46327e..53191ba 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -319,7 +319,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index c44f30f..0294191 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -364,7 +364,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index b3e3bd7..4a09153 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -305,7 +305,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index 653ed47..13a2311 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -392,7 +392,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 123c8df..bbd884a 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -333,7 +333,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index c7f411f..0f941f3 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -272,7 +272,8 @@
 		#interrupt-cells = <1>;
 		#size-cells = <2>;
 		#address-cells = <3>;
-		reg = <0xe0008500 0x100>;
+		reg = <0xe0008500 0x100		/* internal registers */
+		       0xe0008300 0x8>;		/* config space access registers */
 		compatible = "fsl,mpc8349-pci";
 		device_type = "pci";
 	};
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 61e6d77..a3f4aba 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1,7 +1,7 @@
 /*
- * MPC85xx/86xx PCI/PCIE support routing.
+ * MPC83xx/85xx/86xx PCI/PCIE support routing.
  *
- * Copyright 2007 Freescale Semiconductor, Inc
+ * Copyright 2007,2008 Freescale Semiconductor, Inc
  *
  * Initial author: Xianghua Xiao <x.xiao@freescale.com>
  * Recode: ZHANG WEI <wei.zhang@freescale.com>
@@ -256,15 +256,42 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 {
 	int len;
 	struct pci_controller *hose;
-	struct resource rsrc;
+	struct resource rsrc_reg;
+	struct resource rsrc_cfg;
 	const int *bus_range;
-	int primary = 1, has_address = 0;
-	phys_addr_t immr = get_immrbase();
+	int primary;
 
 	pr_debug("Adding PCI host bridge %s\n", dev->full_name);
 
 	/* Fetch host bridge registers address */
-	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
+	if (of_address_to_resource(dev, 0, &rsrc_reg)) {
+		printk(KERN_WARNING "Can't get pci register base!\n");
+		return -ENOMEM;
+	}
+
+	memset(&rsrc_cfg, 0, sizeof(rsrc_cfg));
+
+	if (of_address_to_resource(dev, 1, &rsrc_cfg)) {
+		printk(KERN_WARNING
+			"No pci config register base in dev tree, "
+			"using default\n");
+		/*
+		 * MPC83xx supports up to two host controllers
+		 * 	one at 0x8500 has config space registers at 0x8300
+		 * 	one at 0x8600 has config space registers at 0x8380
+		 */
+		if ((rsrc_reg.start & 0xfffff) == 0x8500)
+			rsrc_cfg.start = (rsrc_reg.start & 0xfff00000) + 0x8300;
+		else if ((rsrc_reg.start & 0xfffff) == 0x8600)
+			rsrc_cfg.start = (rsrc_reg.start & 0xfff00000) + 0x8380;
+	}
+	/*
+	 * Controller at offset 0x8500 is primary
+	 */
+	if ((rsrc_reg.start & 0xfffff) == 0x8500)
+		primary = 1;
+	else
+		primary = 0;
 
 	/* Get bus range if any */
 	bus_range = of_get_property(dev, "bus-range", &len);
@@ -281,22 +308,11 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	hose->first_busno = bus_range ? bus_range[0] : 0;
 	hose->last_busno = bus_range ? bus_range[1] : 0xff;
 
-	/* MPC83xx supports up to two host controllers one at 0x8500 from immrbar
-	 * the other at 0x8600, we consider the 0x8500 the primary controller
-	 */
-	/* PCI 1 */
-	if ((rsrc.start & 0xfffff) == 0x8500) {
-		setup_indirect_pci(hose, immr + 0x8300, immr + 0x8304, 0);
-	}
-	/* PCI 2 */
-	if ((rsrc.start & 0xfffff) == 0x8600) {
-		setup_indirect_pci(hose, immr + 0x8380, immr + 0x8384, 0);
-		primary = 0;
-	}
+	setup_indirect_pci(hose, rsrc_cfg.start, rsrc_cfg.start + 4, 0);
 
 	printk(KERN_INFO "Found MPC83xx PCI host bridge at 0x%016llx. "
 	       "Firmware bus number: %d->%d\n",
-	       (unsigned long long)rsrc.start, hose->first_busno,
+	       (unsigned long long)rsrc_reg.start, hose->first_busno,
 	       hose->last_busno);
 
 	pr_debug(" ->Hose at 0x%p, cfg_addr=0x%p,cfg_data=0x%p\n",
-- 
1.5.6.2.255.gbed62

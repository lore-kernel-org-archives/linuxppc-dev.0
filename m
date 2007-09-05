Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3ADBCE0432
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:29:39 +1000 (EST)
Date: Wed, 5 Sep 2007 14:29:22 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 09/10] mpc82xx: Update mpc8272ads,
	and factor out PCI and reset.
Message-ID: <20070905192922.GH32462@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192841.GA32441@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. PCI and reset are factored out into pq2.c.  I renamed them from m82xx
to pq2 because they won't work on the Integrated Host Processor line of
82xx chips (i.e. 8240, 8245, and such).

2. The PCI PIC, which is nominally board-specific, is used on multiple
boards, and thus is used into pq2ads-pci-pic.c.

3. The new CPM binding is used.

4. General cleanup.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig                         |    2 +-
 arch/powerpc/boot/dts/mpc8272ads.dts         |  310 +++++++------
 arch/powerpc/configs/mpc8272_ads_defconfig   |  248 +++++++----
 arch/powerpc/platforms/82xx/Kconfig          |    5 +
 arch/powerpc/platforms/82xx/Makefile         |    2 +
 arch/powerpc/platforms/82xx/mpc8272_ads.c    |  668 +++++---------------------
 arch/powerpc/platforms/82xx/pq2.c            |   82 ++++
 arch/powerpc/platforms/82xx/pq2.h            |   20 +
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c |  202 ++++++++
 arch/powerpc/platforms/82xx/pq2ads.h         |    2 -
 10 files changed, 761 insertions(+), 780 deletions(-)
 create mode 100644 arch/powerpc/platforms/82xx/pq2.c
 create mode 100644 arch/powerpc/platforms/82xx/pq2.h
 create mode 100644 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 251d0c3..6e3980b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -477,7 +477,7 @@ config PCI_8260
 
 config 8260_PCI9
 	bool "Enable workaround for MPC826x erratum PCI 9"
-	depends on PCI_8260 && !ADS8272
+	depends on PCI_8260 && !8272
 	default y
 
 choice
diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 4d09dca..153a211 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "MPC8272ADS";
-	compatible = "MPC8260ADS";
+	compatible = "fsl,mpc8272ads";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -22,181 +22,202 @@
 		PowerPC,8272@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;       // 32 bytes
-			i-cache-line-size = <20>;       // 32 bytes
-			d-cache-size = <4000>;          // L1, 16K
-			i-cache-size = <4000>;          // L1, 16K
+			d-cache-line-size = <d#32>;
+			i-cache-line-size = <d#32>;
+			d-cache-size = <d#16384>;
+			i-cache-size = <d#16384>;
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			32-bit;
 		};
 	};
 
-	pci_pic: interrupt-controller@f8200000 {
-		#address-cells = <0>;
-		#interrupt-cells = <2>;
-		interrupt-controller;
-		reg = <f8200000 f8200004>;
-		built-in;
-		device_type = "pci-pic";
+	CS: chipselect {
+		compatible = "fsl,mpc8272ads-chipselect",
+		             "fsl,mpc8272-chipselect",
+		             "fsl,pq2-chipselect";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		fsl,ctrl = <&CSCTRL>;
+
+		ranges = <0 0 fe000000 02000000
+		          1 0 f4500000 00008000
+		          3 0 f8200000 00008000>;
+
+		flash@0,0 {
+			device_type = "rom";
+			compatible = "direct-mapped";
+			reg = <0 0 2000000>;
+			probe-type = "JEDEC";
+			bank-width = <4>;
+		};
+
+		board-control@1,0 {
+			reg = <1 0 20>;
+			compatible = "fsl,mpc8272ads-bcsr";
+		};
+
+		PCI_PIC: interrupt-controller@3,0 {
+			compatible = "fsl,mpc8272ads-pci-pic",
+			             "fsl,pq2ads-pci-pic";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			reg = <3 0 8>;
+			interrupt-parent = <&PIC>;
+			interrupts = <14 8>;
+		};
 	};
 
+
 	memory {
 		device_type = "memory";
-		reg = <00000000 4000000 f4500000 00000020>;
+		reg = <0 0>;
 	};
 
-	chosen {
-		name = "chosen";
-		linux,platform = <0>;
-		interrupt-controller = <&Cpm_pic>;
-	};
-
-	soc8272@f0000000 {
+	soc@f0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
-		ranges = <00000000 f0000000 00053000>;
-		reg = <f0000000 10000>;
-
-		mdio@0 {
-			device_type = "mdio";
-			compatible = "fs_enet";
-			reg = <0 0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			phy0:ethernet-phy@0 {
-				interrupt-parent = <&Cpm_pic>;
-				interrupts = <17 4>;
-				reg = <0>;
-				bitbang = [ 12 12 13 02 02 01 ];
-				device_type = "ethernet-phy";
-			};
-
-			phy1:ethernet-phy@1 {
-				interrupt-parent = <&Cpm_pic>;
-				interrupts = <17 4>;
-				bitbang = [ 12 12 13 02 02 01 ];
-				reg = <3>;
-				device_type = "ethernet-phy";
-			};
-		};
-
-		ethernet@24000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			device_type = "network";
-			device-id = <1>;
-			compatible = "fs_enet";
-			model = "FCC";
-			reg = <11300 20 8400 100 11380 30>;
-			mac-address = [ 00 11 2F 99 43 54 ];
-			interrupts = <20 2>;
-			interrupt-parent = <&Cpm_pic>;
-			phy-handle = <&Phy0>;
-			rx-clock = <13>;
-			tx-clock = <12>;
+		compatible = "fsl,mpc8272", "fsl,pq2-soc";
+		ranges = <00000000 f0000000 00053000
+		          80000000 80000000 40000000
+		          f6000000 f6000000 02000000>;
+
+		CSCTRL: chipselect@10100 {
+			compatible = "fsl,mpc8272-chipset-ctrl",
+			             "fsl,pq2-chipselect-ctrl";
+			reg = <10100 40>;
+			fsl,bus = <&CS>;
 		};
 
-		ethernet@25000 {
-			device_type = "network";
-			device-id = <2>;
-			compatible = "fs_enet";
-			model = "FCC";
-			reg = <11320 20 8500 100 113b0 30>;
-			mac-address = [ 00 11 2F 99 44 54 ];
-			interrupts = <21 2>;
-			interrupt-parent = <&Cpm_pic>;
-			phy-handle = <&Phy1>;
-			rx-clock = <17>;
-			tx-clock = <18>;
-		};
-
-		cpm@f0000000 {
+		cpm@119c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			#interrupt-cells = <2>;
-			device_type = "cpm";
-			model = "CPM2";
-			ranges = <00000000 00000000 20000>;
-			reg = <0 20000>;
-			command-proc = <119c0>;
-			brg-frequency = <17D7840>;
-			cpm_clk = <BEBC200>;
-
-			scc@11a00 {
+			compatible = "fsl,mpc8272-cpm", "fsl,cpm2";
+			reg = <119c0 30 0 2000>;
+			ranges;
+
+			brg@119f0 {
+				compatible = "fsl,mpc8272-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <119f0 10 115f0 10>;
+			};
+
+			serial@11a00 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SCC";
-				device-id = <1>;
+				compatible = "fsl,mpc8272-scc-uart",
+				             "fsl,cpm2-scc-uart";
 				reg = <11a00 20 8000 100>;
-				current-speed = <1c200>;
-				interrupts = <28 2>;
-				interrupt-parent = <&Cpm_pic>;
-				clock-setup = <0 00ffffff>;
-				rx-clock = <1>;
-				tx-clock = <1>;
+				interrupts = <28 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <00800000>;
 			};
 
-			scc@11a60 {
+			serial@11a60 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SCC";
-				device-id = <4>;
+				compatible = "fsl,mpc8272-scc-uart",
+				             "fsl,cpm2-scc-uart";
 				reg = <11a60 20 8300 100>;
-				current-speed = <1c200>;
-				interrupts = <2b 2>;
-				interrupt-parent = <&Cpm_pic>;
-				clock-setup = <1b ffffff00>;
-				rx-clock = <4>;
-				tx-clock = <4>;
+				interrupts = <2b 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-brg = <4>;
+				fsl,cpm-command = <0ce00000>;
+			};
+
+			mdio@10d40 {
+				device_type = "mdio";
+				compatible = "fsl,mpc8272ads-mdio-bitbang",
+				             "fsl,mpc8272-mdio-bitbang",
+				             "fsl,cpm2-mdio-bitbang";
+				reg = <10d40 14>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				fsl,mdio-pin = <12>;
+				fsl,mdc-pin = <13>;
+
+				PHY0: ethernet-phy@0 {
+					interrupt-parent = <&PIC>;
+					interrupts = <17 8>;
+					reg = <0>;
+					device_type = "ethernet-phy";
+				};
+
+				PHY1: ethernet-phy@1 {
+					interrupt-parent = <&PIC>;
+					interrupts = <17 8>;
+					reg = <3>;
+					device_type = "ethernet-phy";
+				};
+			};
+
+			ethernet@11300 {
+				device_type = "network";
+				compatible = "fsl,mpc8272-fcc-enet",
+				             "fsl,cpm2-fcc-enet";
+				reg = <11300 20 8400 100 11390 1>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				interrupts = <20 8>;
+				interrupt-parent = <&PIC>;
+				phy-handle = <&PHY0>;
+				linux,network-index = <0>;
+				fsl,cpm-command = <12000300>;
+			};
+
+			ethernet@11320 {
+				device_type = "network";
+				compatible = "fsl,mpc8272-fcc-enet",
+				             "fsl,cpm2-fcc-enet";
+				reg = <11320 20 8500 100 113b0 1>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				interrupts = <21 8>;
+				interrupt-parent = <&PIC>;
+				phy-handle = <&PHY1>;
+				linux,network-index = <1>;
+				fsl,cpm-command = <16200300>;
 			};
 		};
 
-		cpm_pic:interrupt-controller@10c00 {
-			#address-cells = <0>;
+		PIC: interrupt-controller@10c00 {
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			reg = <10c00 80>;
-			built-in;
-			device_type = "cpm-pic";
-			compatible = "CPM2";
+			compatible = "fsl,mpc8272-pic", "fsl,pq2-pic";
 		};
 
-		pci@0500 {
+		pci@10800 {
+			device_type = "pci";
+			reg = <10800 10c 101ac 8 101c4 8>;
+			compatible = "fsl,mpc8272-pci", "fsl,pq2-pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			compatible = "8272";
-			device_type = "pci";
-			reg = <10430 4dc>;
-			clock-frequency = <3f940aa>;
+			clock-frequency = <d#66666666>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
-			                /* IDSEL 0x16 */
-			                 b000 0 0 1 f8200000 40 8
-			                 b000 0 0 2 f8200000 41 8
-			                 b000 0 0 3 f8200000 42 8
-			                 b000 0 0 4 f8200000 43 8
-
-			                /* IDSEL 0x17 */
-			                 b800 0 0 1 f8200000 43 8
-			                 b800 0 0 2 f8200000 40 8
-			                 b800 0 0 3 f8200000 41 8
-			                 b800 0 0 4 f8200000 42 8
-
-			                /* IDSEL 0x18 */
-			                 c000 0 0 1 f8200000 42 8
-			                 c000 0 0 2 f8200000 43 8
-			                 c000 0 0 3 f8200000 40 8
-			                 c000 0 0 4 f8200000 41 8>;
-			interrupt-parent = <&Cpm_pic>;
-			interrupts = <14 8>;
-			bus-range = <0 0>;
-			ranges = <02000000 0 80000000 80000000 0 40000000
+			                 /* IDSEL 0x16 */
+			                 b000 0 0 1 &PCI_PIC 0
+			                 b000 0 0 2 &PCI_PIC 1
+			                 b000 0 0 3 &PCI_PIC 2
+			                 b000 0 0 4 &PCI_PIC 3
+
+			                 /* IDSEL 0x17 */
+			                 b800 0 0 1 &PCI_PIC 4
+			                 b800 0 0 2 &PCI_PIC 5
+			                 b800 0 0 3 &PCI_PIC 6
+			                 b800 0 0 4 &PCI_PIC 7
+
+			                 /* IDSEL 0x18 */
+			                 c000 0 0 1 &PCI_PIC 8
+			                 c000 0 0 2 &PCI_PIC 9
+			                 c000 0 0 3 &PCI_PIC a
+			                 c000 0 0 4 &PCI_PIC b>;
+
+			interrupt-parent = <&PIC>;
+			interrupts = <12 8>;
+			ranges = <42000000 0 80000000 80000000 0 20000000
+			          02000000 0 a0000000 a0000000 0 20000000
 			          01000000 0 00000000 f6000000 0 02000000>;
 		};
 
@@ -204,10 +225,13 @@
 		crypto@30000 {
 			device_type = "crypto";
 			model = "SEC2";
-			compatible = "talitos";
+			compatible = "fsl,mpc8272-talitos-sec2",
+			             "fsl,talitos-sec2",
+			             "fsl,talitos",
+			             "talitos";
 			reg = <30000 10000>;
-			interrupts = <b 2>;
-			interrupt-parent = <&Cpm_pic>;
+			interrupts = <b 8>;
+			interrupt-parent = <&PIC>;
 			num-channels = <4>;
 			channel-fifo-len = <18>;
 			exec-units-mask = <0000007e>;
@@ -215,4 +239,8 @@
 			descriptor-types-mask = <01010ebf>;
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc/cpm/serial@11a00";
+	};
 };
diff --git a/arch/powerpc/configs/mpc8272_ads_defconfig b/arch/powerpc/configs/mpc8272_ads_defconfig
index 4b68032..6b7951e 100644
--- a/arch/powerpc/configs/mpc8272_ads_defconfig
+++ b/arch/powerpc/configs/mpc8272_ads_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.23-rc4
-# Tue Aug 28 21:24:39 2007
+# Wed Sep  5 12:43:23 2007
 #
 # CONFIG_PPC64 is not set
 
@@ -52,7 +52,7 @@ CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 # CONFIG_EXPERIMENTAL is not set
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-CONFIG_LOCALVERSION="powerpc8272"
+CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
@@ -71,7 +71,7 @@ CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_ALL=y
-CONFIG_KALLSYMS_EXTRA_PASS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
@@ -122,10 +122,11 @@ CONFIG_PPC_82xx=y
 # CONFIG_PPC_MPC5200 is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
-CONFIG_MPC82xx_ADS=y
+CONFIG_MPC8272_ADS=y
 CONFIG_PQ2ADS=y
 CONFIG_8260=y
 CONFIG_8272=y
+CONFIG_PQ2_ADS_PCI_PIC=y
 # CONFIG_MPIC is not set
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -137,7 +138,9 @@ CONFIG_8272=y
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
 CONFIG_CPM2=y
+CONFIG_PPC_CPM_NEW_BINDING=y
 # CONFIG_FSL_ULI1575 is not set
+CONFIG_CPM=y
 
 #
 # Kernel options
@@ -168,18 +171,25 @@ CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 CONFIG_SECCOMP=y
-# CONFIG_WANT_DEVICE_TREE is not set
+CONFIG_WANT_DEVICE_TREE=y
+# CONFIG_BUILD_RAW_IMAGE is not set
+CONFIG_DEVICE_TREE="mpc8272ads.dts"
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
 CONFIG_ZONE_DMA=y
+CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_FSL_SOC=y
-# CONFIG_PCI is not set
-# CONFIG_PCI_DOMAINS is not set
-# CONFIG_PCI_SYSCALL is not set
-# CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+CONFIG_PCI_8260=y
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
+# CONFIG_PCI_DEBUG is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -313,43 +323,101 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_PARTITIONS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+# CONFIG_MTD_CFI is not set
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
+CONFIG_MTD_CFI_GEOMETRY=y
+# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+# CONFIG_MTD_CFI_I1 is not set
+# CONFIG_MTD_CFI_I2 is not set
+CONFIG_MTD_CFI_I4=y
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_OTP is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_SBC8240 is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 CONFIG_OF_DEVICE=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-CONFIG_MISC_DEVICES=y
-# CONFIG_EEPROM_93CX6 is not set
-CONFIG_IDE=y
-CONFIG_IDE_MAX_HWIFS=4
-CONFIG_BLK_DEV_IDE=y
-
-#
-# Please see Documentation/ide.txt for help/info on IDE drives
-#
-# CONFIG_BLK_DEV_IDE_SATA is not set
-CONFIG_BLK_DEV_IDEDISK=y
-# CONFIG_IDEDISK_MULTI_MODE is not set
-# CONFIG_BLK_DEV_IDECD is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
-# CONFIG_IDE_TASK_IOCTL is not set
-CONFIG_IDE_PROC_FS=y
-
-#
-# IDE chipset support/bugfixes
-#
-# CONFIG_IDE_GENERIC is not set
-# CONFIG_IDEPCI_PCIBUS_ORDER is not set
-# CONFIG_IDE_ARM is not set
-# CONFIG_BLK_DEV_IDEDMA is not set
-# CONFIG_BLK_DEV_HD is not set
+# CONFIG_MISC_DEVICES is not set
+# CONFIG_IDE is not set
 
 #
 # SCSI device support
@@ -360,6 +428,21 @@ CONFIG_IDE_PROC_FS=y
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+
+#
+# An alternative FireWire stack is available with EXPERIMENTAL=y
+#
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NETDEVICES_MULTIQUEUE is not set
@@ -367,6 +450,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_BONDING is not set
 # CONFIG_EQUALIZER is not set
 CONFIG_TUN=y
+# CONFIG_ARCNET is not set
 CONFIG_PHYLIB=y
 
 #
@@ -382,13 +466,42 @@ CONFIG_DAVICOM_PHY=y
 # CONFIG_BROADCOM_PHY is not set
 # CONFIG_ICPLUS_PHY is not set
 # CONFIG_FIXED_PHY is not set
+CONFIG_MDIO_BITBANG=y
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
 CONFIG_FS_ENET=y
 # CONFIG_FS_ENET_HAS_SCC is not set
 CONFIG_FS_ENET_HAS_FCC=y
 CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_QLA3XXX is not set
 CONFIG_NETDEV_10000=y
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+# CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
+# CONFIG_MLX4_CORE is not set
+# CONFIG_TR is not set
 
 #
 # Wireless LAN
@@ -396,6 +509,7 @@ CONFIG_NETDEV_10000=y
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
 # CONFIG_WAN is not set
+# CONFIG_FDDI is not set
 CONFIG_PPP=y
 # CONFIG_PPP_FILTER is not set
 CONFIG_PPP_ASYNC=y
@@ -459,6 +573,7 @@ CONFIG_MOUSE_PS2_TRACKPOINT=y
 CONFIG_SERIO=y
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_PCIPS2 is not set
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
@@ -488,6 +603,7 @@ CONFIG_SERIAL_CPM_SCC1=y
 CONFIG_SERIAL_CPM_SCC4=y
 # CONFIG_SERIAL_CPM_SMC1 is not set
 # CONFIG_SERIAL_CPM_SMC2 is not set
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -497,7 +613,11 @@ CONFIG_HW_RANDOM=y
 # CONFIG_NVRAM is not set
 # CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
+CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 
 #
@@ -531,7 +651,7 @@ CONFIG_DAB=y
 #
 # CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=y
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
 
@@ -539,45 +659,11 @@ CONFIG_VIDEO_OUTPUT_CONTROL=y
 # Sound
 #
 # CONFIG_SOUND is not set
-CONFIG_HID_SUPPORT=y
-CONFIG_HID=y
-# CONFIG_HID_DEBUG is not set
-CONFIG_USB_SUPPORT=y
-# CONFIG_USB_ARCH_HAS_HCD is not set
-# CONFIG_USB_ARCH_HAS_OHCI is not set
-# CONFIG_USB_ARCH_HAS_EHCI is not set
-
-#
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
-#
-
-#
-# USB Gadget Support
-#
-CONFIG_USB_GADGET=y
-# CONFIG_USB_GADGET_DEBUG_FILES is not set
-CONFIG_USB_GADGET_SELECTED=y
-# CONFIG_USB_GADGET_AMD5536UDC is not set
-# CONFIG_USB_GADGET_FSL_USB2 is not set
-# CONFIG_USB_GADGET_NET2280 is not set
-# CONFIG_USB_GADGET_PXA2XX is not set
-CONFIG_USB_GADGET_M66592=y
-CONFIG_USB_M66592=y
-# CONFIG_USB_GADGET_GOKU is not set
-# CONFIG_USB_GADGET_LH7A40X is not set
-# CONFIG_USB_GADGET_OMAP is not set
-# CONFIG_USB_GADGET_S3C2410 is not set
-# CONFIG_USB_GADGET_AT91 is not set
-# CONFIG_USB_GADGET_DUMMY_HCD is not set
-CONFIG_USB_GADGET_DUALSPEED=y
-# CONFIG_USB_ZERO is not set
-CONFIG_USB_ETH=y
-# CONFIG_USB_GADGETFS is not set
-# CONFIG_USB_FILE_STORAGE is not set
-# CONFIG_USB_G_SERIAL is not set
-# CONFIG_USB_MIDI_GADGET is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_INFINIBAND is not set
 # CONFIG_RTC_CLASS is not set
 
 #
@@ -614,11 +700,7 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 CONFIG_FS_POSIX_ACL=y
-CONFIG_XFS_FS=y
-# CONFIG_XFS_QUOTA is not set
-# CONFIG_XFS_SECURITY is not set
-# CONFIG_XFS_POSIX_ACL is not set
-# CONFIG_XFS_RT is not set
+# CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -659,6 +741,7 @@ CONFIG_RAMFS=y
 # Miscellaneous filesystems
 #
 # CONFIG_HFSPLUS_FS is not set
+# CONFIG_JFFS2_FS is not set
 CONFIG_CRAMFS=y
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -680,8 +763,7 @@ CONFIG_LOCKD_V4=y
 CONFIG_NFS_ACL_SUPPORT=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-CONFIG_SMB_FS=y
-# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
@@ -775,7 +857,7 @@ CONFIG_HAS_DMA=y
 #
 # CONFIG_PRINTK_TIME is not set
 CONFIG_ENABLE_MUST_CHECK=y
-# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
@@ -793,7 +875,7 @@ CONFIG_SCHED_DEBUG=y
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
@@ -845,4 +927,4 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
-CONFIG_CRYPTO_HW=y
+# CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index f260c01..03f5aeb 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -10,6 +10,8 @@ config MPC8272_ADS
 	select 8272
 	select 8260
 	select FSL_SOC
+	select PQ2_ADS_PCI_PIC if PCI
+	select PPC_CPM_NEW_BINDING
 	help
 	  This option enables support for the MPC8272 ADS board
 
@@ -34,3 +36,6 @@ config 8272
 	help
 	  The MPC8272 CPM has a different internal dpram setup than other CPM2
 	  devices
+
+config PQ2_ADS_PCI_PIC
+	bool
diff --git a/arch/powerpc/platforms/82xx/Makefile b/arch/powerpc/platforms/82xx/Makefile
index 9b7c851..bfcb64c 100644
--- a/arch/powerpc/platforms/82xx/Makefile
+++ b/arch/powerpc/platforms/82xx/Makefile
@@ -2,3 +2,5 @@
 # Makefile for the PowerPC 82xx linux kernel.
 #
 obj-$(CONFIG_MPC8272_ADS) += mpc8272_ads.o
+obj-$(CONFIG_CPM2) += pq2.o
+obj-$(CONFIG_PQ2_ADS_PCI_PIC) += pq2ads-pci-pic.o
diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index 994a859..e2fa668 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -1,9 +1,10 @@
 /*
- * MPC8272_ads setup and early boot code plus other random bits.
+ * MPC8272 ADS board support
  *
- * Author: Vitaly Bordug <vbordug@ru.mvista.com>
- * m82xx_restart fix by Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ * Author: Scott Wood <scottwood@freescale.com>
  *
+ * Based on code by Vitaly Bordug <vbordug@ru.mvista.com>
  * Copyright (c) 2006 MontaVista Software, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -12,623 +13,184 @@
  * option) any later version.
  */
 
-#include <linux/stddef.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/reboot.h>
-#include <linux/pci.h>
 #include <linux/interrupt.h>
-#include <linux/kdev_t.h>
-#include <linux/major.h>
-#include <linux/console.h>
-#include <linux/delay.h>
-#include <linux/seq_file.h>
-#include <linux/root_dev.h>
-#include <linux/initrd.h>
-#include <linux/module.h>
 #include <linux/fsl_devices.h>
-#include <linux/fs_uart_pd.h>
+#include <linux/of_platform.h>
+#include <linux/io.h>
 
-#include <asm/system.h>
-#include <asm/pgtable.h>
-#include <asm/page.h>
-#include <asm/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/mpc8260.h>
-#include <asm/irq.h>
-#include <mm/mmu_decl.h>
-#include <asm/prom.h>
 #include <asm/cpm2.h>
 #include <asm/udbg.h>
-#include <asm/i8259.h>
-#include <linux/fs_enet_pd.h>
+#include <asm/machdep.h>
+#include <asm/time.h>
+
+#include <platforms/82xx/pq2.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/cpm2_pic.h>
 
 #include "pq2ads.h"
-
-#ifdef CONFIG_PCI
-static uint pci_clk_frq;
-static struct {
-	unsigned long *pci_int_stat_reg;
-	unsigned long *pci_int_mask_reg;
-} pci_regs;
-
-static unsigned long pci_int_base;
-static struct irq_host *pci_pic_host;
-static struct device_node *pci_pic_node;
-#endif
+#include "pq2.h"
 
 static void __init mpc8272_ads_pic_init(void)
 {
-	struct device_node *np = of_find_compatible_node(NULL, "cpm-pic", "CPM2");
-	struct resource r;
-	cpm2_map_t *cpm_reg;
-
-	if (np == NULL) {
+	struct device_node *np = of_find_compatible_node(NULL, NULL,
+	                                                 "fsl,pq2-pic");
+	if (!np) {
 		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
 		return;
 	}
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_ERR "PIC init: invalid resource\n");
-		of_node_put(np);
-		return;
-	}
+
 	cpm2_pic_init(np);
 	of_node_put(np);
 
-	/* Initialize the default interrupt mapping priorities,
-	 * in case the boot rom changed something on us.
-	 */
-	cpm_reg = (cpm2_map_t *) ioremap(get_immrbase(), sizeof(cpm2_map_t));
-	cpm_reg->im_intctl.ic_siprr = 0x05309770;
-	iounmap(cpm_reg);
-#ifdef CONFIG_PCI
 	/* Initialize stuff for the 82xx CPLD IC and install demux  */
-	m82xx_pci_init_irq();
-#endif
+	pq2ads_pci_init_irq();
 }
 
-static void init_fcc1_ioports(struct fs_platform_info *fpi)
-{
-	struct io_port *io;
-	u32 tempval;
-	cpm2_map_t *immap = ioremap(get_immrbase(), sizeof(cpm2_map_t));
-	struct device_node *np;
-	struct resource r;
-	u32 *bcsr;
-
-	np = of_find_node_by_type(NULL, "memory");
-	if (!np) {
-		printk(KERN_INFO "No memory node in device tree\n");
-		return;
-	}
-	if (of_address_to_resource(np, 1, &r)) {
-		printk(KERN_INFO "No memory reg property [1] in devicetree\n");
-		return;
-	}
-	of_node_put(np);
-	bcsr = ioremap(r.start + 4, sizeof(u32));
-	io = &immap->im_ioport;
-
-	/* Enable the PHY */
-	clrbits32(bcsr, BCSR1_FETHIEN);
-	setbits32(bcsr, BCSR1_FETH_RST);
-
-	/* FCC1 pins are on port A/C. */
-	/* Configure port A and C pins for FCC1 Ethernet. */
-
-	tempval = in_be32(&io->iop_pdira);
-	tempval &= ~PA1_DIRA0;
-	tempval |= PA1_DIRA1;
-	out_be32(&io->iop_pdira, tempval);
-
-	tempval = in_be32(&io->iop_psora);
-	tempval &= ~PA1_PSORA0;
-	tempval |= PA1_PSORA1;
-	out_be32(&io->iop_psora, tempval);
-
-	setbits32(&io->iop_ppara, PA1_DIRA0 | PA1_DIRA1);
-
-	/* Alter clocks */
-	tempval = PC_CLK(fpi->clk_tx - 8) | PC_CLK(fpi->clk_rx - 8);
-
-	clrbits32(&io->iop_psorc, tempval);
-	clrbits32(&io->iop_pdirc, tempval);
-	setbits32(&io->iop_pparc, tempval);
-
-	cpm2_clk_setup(CPM_CLK_FCC1, fpi->clk_rx, CPM_CLK_RX);
-	cpm2_clk_setup(CPM_CLK_FCC1, fpi->clk_tx, CPM_CLK_TX);
+struct cpm_pin {
+	int port, pin, flags;
+};
 
-	iounmap(bcsr);
-	iounmap(immap);
-}
+static struct cpm_pin mpc8272_ads_pins[] = {
+	/* SCC1 */
+	{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* SCC4 */
+	{3, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC1 */
+	{0, 14, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 15, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{0, 18, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 19, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 20, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 21, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{0, 26, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 27, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 28, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{0, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{0, 30, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{0, 31, CPM_PIN_INPUT | CPM_PIN_SECONDARY},
+	{2, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 22, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC2 */
+	{1, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 20, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 22, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 25, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 26, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 27, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{1, 30, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{2, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+};
 
-static void init_fcc2_ioports(struct fs_platform_info *fpi)
+static void __init init_ioports(void)
 {
-	cpm2_map_t *immap = ioremap(get_immrbase(), sizeof(cpm2_map_t));
-	struct device_node *np;
-	struct resource r;
-	u32 *bcsr;
-
-	struct io_port *io;
-	u32 tempval;
-
-	np = of_find_node_by_type(NULL, "memory");
-	if (!np) {
-		printk(KERN_INFO "No memory node in device tree\n");
-		return;
-	}
-	if (of_address_to_resource(np, 1, &r)) {
-		printk(KERN_INFO "No memory reg property [1] in devicetree\n");
-		return;
-	}
-	of_node_put(np);
-	io = &immap->im_ioport;
-	bcsr = ioremap(r.start + 12, sizeof(u32));
-
-	/* Enable the PHY */
-	clrbits32(bcsr, BCSR3_FETHIEN2);
-	setbits32(bcsr, BCSR3_FETH2_RST);
-
-	/* FCC2 are port B/C. */
-	/* Configure port A and C pins for FCC2 Ethernet. */
-
-	tempval = in_be32(&io->iop_pdirb);
-	tempval &= ~PB2_DIRB0;
-	tempval |= PB2_DIRB1;
-	out_be32(&io->iop_pdirb, tempval);
-
-	tempval = in_be32(&io->iop_psorb);
-	tempval &= ~PB2_PSORB0;
-	tempval |= PB2_PSORB1;
-	out_be32(&io->iop_psorb, tempval);
-
-	setbits32(&io->iop_pparb, PB2_DIRB0 | PB2_DIRB1);
-
-	tempval = PC_CLK(fpi->clk_tx - 8) | PC_CLK(fpi->clk_rx - 8);
-
-	/* Alter clocks */
-	clrbits32(&io->iop_psorc, tempval);
-	clrbits32(&io->iop_pdirc, tempval);
-	setbits32(&io->iop_pparc, tempval);
-
-	cpm2_clk_setup(CPM_CLK_FCC2, fpi->clk_rx, CPM_CLK_RX);
-	cpm2_clk_setup(CPM_CLK_FCC2, fpi->clk_tx, CPM_CLK_TX);
-
-	iounmap(bcsr);
-	iounmap(immap);
-}
+	int i;
 
-void init_fcc_ioports(struct fs_platform_info *fpi)
-{
-	int fcc_no = fs_get_fcc_index(fpi->fs_no);
-
-	switch (fcc_no) {
-	case 0:
-		init_fcc1_ioports(fpi);
-		break;
-	case 1:
-		init_fcc2_ioports(fpi);
-		break;
-	default:
-		printk(KERN_ERR "init_fcc_ioports: invalid FCC number\n");
-		return;
+	for (i = 0; i < ARRAY_SIZE(mpc8272_ads_pins); i++) {
+		struct cpm_pin *pin = &mpc8272_ads_pins[i];
+		cpm2_set_pin(pin->port, pin->pin, pin->flags);
 	}
-}
 
-static void init_scc1_uart_ioports(struct fs_uart_platform_info *data)
-{
-	cpm2_map_t *immap = ioremap(get_immrbase(), sizeof(cpm2_map_t));
-
-	/* SCC1 is only on port D */
-	setbits32(&immap->im_ioport.iop_ppard, 0x00000003);
-	clrbits32(&immap->im_ioport.iop_psord, 0x00000001);
-	setbits32(&immap->im_ioport.iop_psord, 0x00000002);
-	clrbits32(&immap->im_ioport.iop_pdird, 0x00000001);
-	setbits32(&immap->im_ioport.iop_pdird, 0x00000002);
-
-	clrbits32(&immap->im_cpmux.cmx_scr, (0x00000007 << (4 - data->clk_tx)));
-	clrbits32(&immap->im_cpmux.cmx_scr, (0x00000038 << (4 - data->clk_rx)));
-	setbits32(&immap->im_cpmux.cmx_scr,
-		  ((data->clk_tx - 1) << (4 - data->clk_tx)));
-	setbits32(&immap->im_cpmux.cmx_scr,
-		  ((data->clk_rx - 1) << (4 - data->clk_rx)));
-
-	iounmap(immap);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_SCC4, CPM_BRG4, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC4, CPM_BRG4, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK11, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC1, CPM_CLK10, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK15, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK16, CPM_CLK_TX);
 }
 
-static void init_scc4_uart_ioports(struct fs_uart_platform_info *data)
+static void __init mpc8272_ads_setup_arch(void)
 {
-	cpm2_map_t *immap = ioremap(get_immrbase(), sizeof(cpm2_map_t));
-
-	setbits32(&immap->im_ioport.iop_ppard, 0x00000600);
-	clrbits32(&immap->im_ioport.iop_psord, 0x00000600);
-	clrbits32(&immap->im_ioport.iop_pdird, 0x00000200);
-	setbits32(&immap->im_ioport.iop_pdird, 0x00000400);
-
-	clrbits32(&immap->im_cpmux.cmx_scr, (0x00000007 << (4 - data->clk_tx)));
-	clrbits32(&immap->im_cpmux.cmx_scr, (0x00000038 << (4 - data->clk_rx)));
-	setbits32(&immap->im_cpmux.cmx_scr,
-		  ((data->clk_tx - 1) << (4 - data->clk_tx)));
-	setbits32(&immap->im_cpmux.cmx_scr,
-		  ((data->clk_rx - 1) << (4 - data->clk_rx)));
-
-	iounmap(immap);
-}
+	struct device_node *np;
+	__be32 __iomem *bcsr;
 
-void init_scc_ioports(struct fs_uart_platform_info *data)
-{
-	int scc_no = fs_get_scc_index(data->fs_no);
-
-	switch (scc_no) {
-	case 0:
-		init_scc1_uart_ioports(data);
-		data->brg = data->clk_rx;
-		break;
-	case 3:
-		init_scc4_uart_ioports(data);
-		data->brg = data->clk_rx;
-		break;
-	default:
-		printk(KERN_ERR "init_scc_ioports: invalid SCC number\n");
-		return;
-	}
-}
+	if (ppc_md.progress)
+		ppc_md.progress("mpc8272_ads_setup_arch()", 0);
 
-void __init m82xx_board_setup(void)
-{
-	cpm2_map_t *immap = ioremap(get_immrbase(), sizeof(cpm2_map_t));
-	struct device_node *np;
-	struct resource r;
-	u32 *bcsr;
+	cpm2_reset();
 
-	np = of_find_node_by_type(NULL, "memory");
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc8272ads-bcsr");
 	if (!np) {
-		printk(KERN_INFO "No memory node in device tree\n");
+		printk(KERN_ERR "No bcsr in device tree\n");
 		return;
 	}
-	if (of_address_to_resource(np, 1, &r)) {
-		printk(KERN_INFO "No memory reg property [1] in devicetree\n");
+
+	bcsr = of_iomap(np, 0);
+	if (!bcsr) {
+		printk(KERN_ERR "Cannot map BCSR registers\n");
 		return;
 	}
-	of_node_put(np);
-	bcsr = ioremap(r.start + 4, sizeof(u32));
-	/* Enable the 2nd UART port */
-	clrbits32(bcsr, BCSR1_RS232_EN2);
-
-#ifdef CONFIG_SERIAL_CPM_SCC1
-	clrbits32((u32 *) & immap->im_scc[0].scc_sccm,
-		  UART_SCCM_TX | UART_SCCM_RX);
-	clrbits32((u32 *) & immap->im_scc[0].scc_gsmrl,
-		  SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC2
-	clrbits32((u32 *) & immap->im_scc[1].scc_sccm,
-		  UART_SCCM_TX | UART_SCCM_RX);
-	clrbits32((u32 *) & immap->im_scc[1].scc_gsmrl,
-		  SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC3
-	clrbits32((u32 *) & immap->im_scc[2].scc_sccm,
-		  UART_SCCM_TX | UART_SCCM_RX);
-	clrbits32((u32 *) & immap->im_scc[2].scc_gsmrl,
-		  SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-#endif
-
-#ifdef CONFIG_SERIAL_CPM_SCC4
-	clrbits32((u32 *) & immap->im_scc[3].scc_sccm,
-		  UART_SCCM_TX | UART_SCCM_RX);
-	clrbits32((u32 *) & immap->im_scc[3].scc_gsmrl,
-		  SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-#endif
 
-	iounmap(bcsr);
-	iounmap(immap);
-}
-
-#ifdef CONFIG_PCI
-static void m82xx_pci_mask_irq(unsigned int irq)
-{
-	int bit = irq - pci_int_base;
-
-	*pci_regs.pci_int_mask_reg |= (1 << (31 - bit));
-	return;
-}
+	of_node_put(np);
 
-static void m82xx_pci_unmask_irq(unsigned int irq)
-{
-	int bit = irq - pci_int_base;
+	clrbits32(&bcsr[1], BCSR1_RS232_EN1 | BCSR1_RS232_EN2 | BCSR1_FETHIEN);
+	setbits32(&bcsr[1], BCSR1_FETH_RST);
 
-	*pci_regs.pci_int_mask_reg &= ~(1 << (31 - bit));
-	return;
-}
-
-static void m82xx_pci_mask_and_ack(unsigned int irq)
-{
-	int bit = irq - pci_int_base;
+	clrbits32(&bcsr[3], BCSR3_FETHIEN2);
+	setbits32(&bcsr[3], BCSR3_FETH2_RST);
 
-	*pci_regs.pci_int_mask_reg |= (1 << (31 - bit));
-	return;
-}
+	iounmap(bcsr);
 
-static void m82xx_pci_end_irq(unsigned int irq)
-{
-	int bit = irq - pci_int_base;
+	init_ioports();
+	pq2_init_pci();
 
-	*pci_regs.pci_int_mask_reg &= ~(1 << (31 - bit));
-	return;
+	if (ppc_md.progress)
+		ppc_md.progress("mpc8272_ads_setup_arch(), finish", 0);
 }
 
-struct hw_interrupt_type m82xx_pci_ic = {
-	.typename = "MPC82xx ADS PCI",
-	.name = "MPC82xx ADS PCI",
-	.enable = m82xx_pci_unmask_irq,
-	.disable = m82xx_pci_mask_irq,
-	.ack = m82xx_pci_mask_and_ack,
-	.end = m82xx_pci_end_irq,
-	.mask = m82xx_pci_mask_irq,
-	.mask_ack = m82xx_pci_mask_and_ack,
-	.unmask = m82xx_pci_unmask_irq,
-	.eoi = m82xx_pci_end_irq,
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .name = "cpm", },
+	{ .compatible = "fsl,pq2-chipselect", },
+	{},
 };
 
-static void
-m82xx_pci_irq_demux(unsigned int irq, struct irq_desc *desc)
+static int __init declare_of_platform_devices(void)
 {
-	unsigned long stat, mask, pend;
-	int bit;
-
-	for (;;) {
-		stat = *pci_regs.pci_int_stat_reg;
-		mask = *pci_regs.pci_int_mask_reg;
-		pend = stat & ~mask & 0xf0000000;
-		if (!pend)
-			break;
-		for (bit = 0; pend != 0; ++bit, pend <<= 1) {
-			if (pend & 0x80000000)
-				__do_IRQ(pci_int_base + bit);
-		}
-	}
-}
+	if (!machine_is(mpc8272_ads))
+		return 0;
 
-static int pci_pic_host_match(struct irq_host *h, struct device_node *node)
-{
-	return node == pci_pic_node;
-}
-
-static int pci_pic_host_map(struct irq_host *h, unsigned int virq,
-			    irq_hw_number_t hw)
-{
-	get_irq_desc(virq)->status |= IRQ_LEVEL;
-	set_irq_chip(virq, &m82xx_pci_ic);
+	/* Publish the QE devices */
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 	return 0;
 }
-
-static void pci_host_unmap(struct irq_host *h, unsigned int virq)
-{
-	/* remove chip and handler */
-	set_irq_chip(virq, NULL);
-}
-
-static struct irq_host_ops pci_pic_host_ops = {
-	.match = pci_pic_host_match,
-	.map = pci_pic_host_map,
-	.unmap = pci_host_unmap,
-};
-
-void m82xx_pci_init_irq(void)
-{
-	int irq;
-	cpm2_map_t *immap;
-	struct device_node *np;
-	struct resource r;
-	const u32 *regs;
-	unsigned int size;
-	const u32 *irq_map;
-	int i;
-	unsigned int irq_max, irq_min;
-
-	if ((np = of_find_node_by_type(NULL, "soc")) == NULL) {
-		printk(KERN_INFO "No SOC node in device tree\n");
-		return;
-	}
-	memset(&r, 0, sizeof(r));
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_INFO "No SOC reg property in device tree\n");
-		return;
-	}
-	immap = ioremap(r.start, sizeof(*immap));
-	of_node_put(np);
-
-	/* install the demultiplexer for the PCI cascade interrupt */
-	np = of_find_node_by_type(NULL, "pci");
-	if (!np) {
-		printk(KERN_INFO "No pci node on device tree\n");
-		iounmap(immap);
-		return;
-	}
-	irq_map = of_get_property(np, "interrupt-map", &size);
-	if ((!irq_map) || (size <= 7)) {
-		printk(KERN_INFO "No interrupt-map property of pci node\n");
-		iounmap(immap);
-		return;
-	}
-	size /= sizeof(irq_map[0]);
-	for (i = 0, irq_max = 0, irq_min = 512; i < size; i += 7, irq_map += 7) {
-		if (irq_map[5] < irq_min)
-			irq_min = irq_map[5];
-		if (irq_map[5] > irq_max)
-			irq_max = irq_map[5];
-	}
-	pci_int_base = irq_min;
-	irq = irq_of_parse_and_map(np, 0);
-	set_irq_chained_handler(irq, m82xx_pci_irq_demux);
-	of_node_put(np);
-	np = of_find_node_by_type(NULL, "pci-pic");
-	if (!np) {
-		printk(KERN_INFO "No pci pic node on device tree\n");
-		iounmap(immap);
-		return;
-	}
-	pci_pic_node = of_node_get(np);
-	/* PCI interrupt controller registers: status and mask */
-	regs = of_get_property(np, "reg", &size);
-	if ((!regs) || (size <= 2)) {
-		printk(KERN_INFO "No reg property in pci pic node\n");
-		iounmap(immap);
-		return;
-	}
-	pci_regs.pci_int_stat_reg =
-	    ioremap(regs[0], sizeof(*pci_regs.pci_int_stat_reg));
-	pci_regs.pci_int_mask_reg =
-	    ioremap(regs[1], sizeof(*pci_regs.pci_int_mask_reg));
-	of_node_put(np);
-	/* configure chip select for PCI interrupt controller */
-	immap->im_memctl.memc_br3 = regs[0] | 0x00001801;
-	immap->im_memctl.memc_or3 = 0xffff8010;
-	/* make PCI IRQ level sensitive */
-	immap->im_intctl.ic_siexr &= ~(1 << (14 - (irq - SIU_INT_IRQ1)));
-
-	/* mask all PCI interrupts */
-	*pci_regs.pci_int_mask_reg |= 0xfff00000;
-	iounmap(immap);
-	pci_pic_host =
-	    irq_alloc_host(IRQ_HOST_MAP_LINEAR, irq_max - irq_min + 1,
-			   &pci_pic_host_ops, irq_max + 1);
-	return;
-}
-
-static int m82xx_pci_exclude_device(struct pci_controller *hose,
-				    u_char bus, u_char devfn)
-{
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	else
-		return PCIBIOS_SUCCESSFUL;
-}
-
-static void __init mpc82xx_add_bridge(struct device_node *np)
-{
-	int len;
-	struct pci_controller *hose;
-	struct resource r;
-	const int *bus_range;
-	const uint *ptr;
-
-	memset(&r, 0, sizeof(r));
-	if (of_address_to_resource(np, 0, &r)) {
-		printk(KERN_INFO "No PCI reg property in device tree\n");
-		return;
-	}
-	if (!(ptr = of_get_property(np, "clock-frequency", NULL))) {
-		printk(KERN_INFO "No clock-frequency property in PCI node");
-		return;
-	}
-	pci_clk_frq = *ptr;
-	of_node_put(np);
-	bus_range = of_get_property(np, "bus-range", &len);
-	if (bus_range == NULL || len < 2 * sizeof(int)) {
-		printk(KERN_WARNING "Can't get bus-range for %s, assume"
-		       " bus 0\n", np->full_name);
-	}
-
-	pci_assign_all_buses = 1;
-
-	hose = pcibios_alloc_controller(np);
-
-	if (!hose)
-		return;
-
-	hose->first_busno = bus_range ? bus_range[0] : 0;
-	hose->last_busno = bus_range ? bus_range[1] : 0xff;
-
-	setup_indirect_pci(hose,
-			   r.start + offsetof(pci_cpm2_t, pci_cfg_addr),
-			   r.start + offsetof(pci_cpm2_t, pci_cfg_data),
-			   0);
-
-	pci_process_bridge_OF_ranges(hose, np, 1);
-}
-#endif
-
-/*
- * Setup the architecture
- */
-static void __init mpc8272_ads_setup_arch(void)
-{
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
-	if (ppc_md.progress)
-		ppc_md.progress("mpc8272_ads_setup_arch()", 0);
-	cpm2_reset();
-
-	/* Map I/O region to a 256MB BAT */
-
-	m82xx_board_setup();
-
-#ifdef CONFIG_PCI
-	ppc_md.pci_exclude_device = m82xx_pci_exclude_device;
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
-		mpc82xx_add_bridge(np);
-
-	of_node_put(np);
-#endif
-
-#ifdef  CONFIG_ROOT_NFS
-	ROOT_DEV = Root_NFS;
-#else
-	ROOT_DEV = Root_HDA1;
-#endif
-
-	if (ppc_md.progress)
-		ppc_md.progress("mpc8272_ads_setup_arch(), finish", 0);
-}
+device_initcall(declare_of_platform_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
  */
 static int __init mpc8272_ads_probe(void)
 {
-	/* We always match for now, eventually we should look at
-	 * the flat dev tree to ensure this is the board we are
-	 * supposed to run on
-	 */
-	return 1;
-}
-
-#define RMR_CSRE 0x00000001
-static void m82xx_restart(char *cmd)
-{
-	__volatile__ unsigned char dummy;
-
-	local_irq_disable();
-	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= RMR_CSRE;
-
-	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
-	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
-	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
-	printk("Restart failed\n");
-	while (1) ;
+	unsigned long root = of_get_flat_dt_root();
+	return of_flat_dt_is_compatible(root, "fsl,mpc8272ads");
 }
 
 define_machine(mpc8272_ads)
 {
-	.name = "MPC8272 ADS",
+	.name = "Freescale MPC8272 ADS",
 	.probe = mpc8272_ads_probe,
 	.setup_arch = mpc8272_ads_setup_arch,
 	.init_IRQ = mpc8272_ads_pic_init,
-	.show_cpuinfo = mpc8272_ads_show_cpuinfo,
 	.get_irq = cpm2_get_irq,
 	.calibrate_decr = generic_calibrate_decr,
-	.restart = m82xx_restart,
+	.restart = pq2_restart,
+	.progress = udbg_progress,
 };
diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
new file mode 100644
index 0000000..a497cba
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -0,0 +1,82 @@
+/*
+ * Common PowerQUICC II code.
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ * Copyright (c) 2007 Freescale Semiconductor
+ *
+ * Based on code by Vitaly Bordug <vbordug@ru.mvista.com>
+ * pq2_restart fix by Wade Farnsworth <wfarnsworth@mvista.com>
+ * Copyright (c) 2006 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <asm/cpm2.h>
+#include <asm/io.h>
+#include <asm/pci-bridge.h>
+#include <asm/system.h>
+
+#include <platforms/82xx/pq2.h>
+
+#define RMR_CSRE 0x00000001
+
+void pq2_restart(char *cmd)
+{
+	local_irq_disable();
+	setbits32(&cpm2_immr->im_clkrst.car_rmr, RMR_CSRE);
+
+	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
+	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
+	in_8(&cpm2_immr->im_clkrst.res[0]);
+
+	panic("Restart failed\n");
+}
+
+#ifdef CONFIG_PCI
+static int pq2_pci_exclude_device(struct pci_controller *hose,
+                                  u_char bus, u8 devfn)
+{
+	if (bus == 0 && PCI_SLOT(devfn) == 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	else
+		return PCIBIOS_SUCCESSFUL;
+}
+
+static void __init pq2_pci_add_bridge(struct device_node *np)
+{
+	struct pci_controller *hose;
+	struct resource r;
+
+	if (of_address_to_resource(np, 0, &r) || r.end - r.start < 0x10b)
+		goto err;
+
+	pci_assign_all_buses = 1;
+
+	hose = pcibios_alloc_controller(np);
+	if (!hose)
+		return;
+
+	hose->arch_data = np;
+
+	setup_indirect_pci(hose, r.start + 0x100, r.start + 0x104, 0);
+	pci_process_bridge_OF_ranges(hose, np, 1);
+
+	return;
+
+err:
+	printk(KERN_ERR "No valid PCI reg property in device tree\n");
+}
+
+void __init pq2_init_pci(void)
+{
+	struct device_node *np = NULL;
+
+	ppc_md.pci_exclude_device = pq2_pci_exclude_device;
+
+	while ((np = of_find_compatible_node(np, NULL, "fsl,pq2-pci")))
+		pq2_pci_add_bridge(np);
+}
+#endif
diff --git a/arch/powerpc/platforms/82xx/pq2.h b/arch/powerpc/platforms/82xx/pq2.h
new file mode 100644
index 0000000..a41f84a
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/pq2.h
@@ -0,0 +1,20 @@
+#ifndef _PQ2_H
+#define _PQ2_H
+
+void pq2_restart(char *cmd);
+
+#ifdef CONFIG_PCI
+int pq2ads_pci_init_irq(void);
+void pq2_init_pci(void);
+#else
+static inline int pq2ads_pci_init_irq(void)
+{
+	return 0;
+}
+
+static inline void pq2_init_pci(void)
+{
+}
+#endif
+
+#endif
diff --git a/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
new file mode 100644
index 0000000..42c83f7
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/pq2ads-pci-pic.c
@@ -0,0 +1,202 @@
+/*
+ * PQ2 ADS-style PCI interrupt controller
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Loosely based on mpc82xx ADS support by Vitaly Bordug <vbordug@ru.mvista.com>
+ * Copyright (c) 2006 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/irq.h>
+#include <linux/types.h>
+#include <linux/bootmem.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/cpm2.h>
+
+#include "pq2.h"
+
+static DEFINE_SPINLOCK(pci_pic_lock);
+
+struct pq2ads_pci_pic {
+	struct device_node *node;
+	struct irq_host *host;
+
+	struct {
+		u32 stat;
+		u32 mask;
+	} __iomem *regs;
+};
+
+#define NUM_IRQS 32
+
+static void pq2ads_pci_mask_irq(unsigned int virq)
+{
+	struct pq2ads_pci_pic *priv = get_irq_chip_data(virq);
+	int irq = NUM_IRQS - virq_to_hw(virq) - 1;
+
+	if (irq != -1) {
+		unsigned long flags;
+		spin_lock_irqsave(&pci_pic_lock, flags);
+
+		setbits32(&priv->regs->mask, 1 << irq);
+		mb();
+
+		spin_unlock_irqrestore(&pci_pic_lock, flags);
+	}
+}
+
+static void pq2ads_pci_unmask_irq(unsigned int virq)
+{
+	struct pq2ads_pci_pic *priv = get_irq_chip_data(virq);
+	int irq = NUM_IRQS - virq_to_hw(virq) - 1;
+
+	if (irq != -1) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&pci_pic_lock, flags);
+		clrbits32(&priv->regs->mask, 1 << irq);
+		spin_unlock_irqrestore(&pci_pic_lock, flags);
+	}
+}
+
+static struct irq_chip pq2ads_pci_ic = {
+	.typename = "PQ2 ADS PCI",
+	.name = "PQ2 ADS PCI",
+	.end = pq2ads_pci_unmask_irq,
+	.mask = pq2ads_pci_mask_irq,
+	.mask_ack = pq2ads_pci_mask_irq,
+	.ack = pq2ads_pci_mask_irq,
+	.unmask = pq2ads_pci_unmask_irq,
+	.enable = pq2ads_pci_unmask_irq,
+	.disable = pq2ads_pci_mask_irq
+};
+
+static void pq2ads_pci_irq_demux(unsigned int irq, struct irq_desc *desc)
+{
+	struct pq2ads_pci_pic *priv = desc->handler_data;
+	u32 stat, mask, pend;
+	int bit;
+
+	for (;;) {
+		stat = in_be32(&priv->regs->stat);
+		mask = in_be32(&priv->regs->mask);
+
+		pend = stat & ~mask;
+
+		if (!pend)
+			break;
+
+		for (bit = 0; pend != 0; ++bit, pend <<= 1) {
+			if (pend & 0x80000000) {
+				int virq = irq_linear_revmap(priv->host, bit);
+				generic_handle_irq(virq);
+			}
+		}
+	}
+}
+
+static int pci_pic_host_match(struct irq_host *h, struct device_node *node)
+{
+	struct pq2ads_pci_pic *priv = h->host_data;
+	return node == priv->node;
+}
+
+static int pci_pic_host_map(struct irq_host *h, unsigned int virq,
+			    irq_hw_number_t hw)
+{
+	get_irq_desc(virq)->status |= IRQ_LEVEL;
+	set_irq_chip_data(virq, h->host_data);
+	set_irq_chip(virq, &pq2ads_pci_ic);
+	return 0;
+}
+
+static void pci_host_unmap(struct irq_host *h, unsigned int virq)
+{
+	/* remove chip and handler */
+	set_irq_chip_data(virq, NULL);
+	set_irq_chip(virq, NULL);
+}
+
+static struct irq_host_ops pci_pic_host_ops = {
+	.match = pci_pic_host_match,
+	.map = pci_pic_host_map,
+	.unmap = pci_host_unmap,
+};
+
+int __init pq2ads_pci_init_irq(void)
+{
+	struct pq2ads_pci_pic *priv;
+	struct irq_host *host;
+	struct device_node *np;
+	int ret = -ENODEV;
+	int irq;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,pq2ads-pci-pic");
+	if (!np) {
+		printk(KERN_ERR "No pci pic node in device tree.\n");
+		of_node_put(np);
+		goto out;
+	}
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq == NO_IRQ) {
+		printk(KERN_ERR "No interrupt in pci pic node.\n");
+		of_node_put(np);
+		goto out;
+	}
+
+	priv = alloc_bootmem(sizeof(struct pq2ads_pci_pic));
+	if (!priv) {
+		of_node_put(np);
+		ret = -ENOMEM;
+		goto out_unmap_irq;
+	}
+
+	priv->node = np;
+	of_node_put(np);
+
+	/* PCI interrupt controller registers: status and mask */
+	priv->regs = of_iomap(priv->node, 0);
+	if (!priv->regs) {
+		printk(KERN_ERR "Cannot map PCI PIC registers.\n");
+		goto out_free_bootmem;
+	}
+
+	/* mask all PCI interrupts */
+	out_be32(&priv->regs->mask, ~0);
+	mb();
+
+	host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, NUM_IRQS,
+	                      &pci_pic_host_ops, NUM_IRQS);
+	if (!host) {
+		ret = -ENOMEM;
+		goto out_unmap_regs;
+	}
+
+	host->host_data = priv;
+
+	priv->host = host;
+	host->host_data = priv;
+	set_irq_data(irq, priv);
+	set_irq_chained_handler(irq, pq2ads_pci_irq_demux);
+	return 0;
+
+out_unmap_regs:
+	iounmap(priv->regs);
+out_free_bootmem:
+	free_bootmem((unsigned long)priv,
+	             sizeof(sizeof(struct pq2ads_pci_pic)));
+out_unmap_irq:
+	irq_dispose_mapping(irq);
+out:
+	return ret;
+}
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h b/arch/powerpc/platforms/82xx/pq2ads.h
index 8b67048..984db42 100644
--- a/arch/powerpc/platforms/82xx/pq2ads.h
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -53,7 +53,5 @@
 #define SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
 #define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
 
-void m82xx_pci_init_irq(void);
-
 #endif /* __MACH_ADS8260_DEFS */
 #endif /* __KERNEL__ */
-- 
1.5.3

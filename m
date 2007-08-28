Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 833E0DEF9D
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:26:52 +1000 (EST)
Date: Tue, 28 Aug 2007 15:19:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 7/9] 8xx: mpc885ads cleanup
Message-ID: <20070828201909.GH24260@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It now uses the new CPM binding and the generic pin/clock functions, and
has assorted fixes and cleanup.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc885ads.dts          |  192 ++++++-----
 arch/powerpc/configs/mpc885_ads_defconfig    |  445 +++++++++++---------------
 arch/powerpc/platforms/8xx/Kconfig           |    1 +
 arch/powerpc/platforms/8xx/mpc885ads.h       |   38 ---
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |  455 +++++++++-----------------
 5 files changed, 455 insertions(+), 676 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index dc7ab9c..76c0a06 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -2,6 +2,7 @@
  * MPC885 ADS Device Tree Source
  *
  * Copyright 2006 MontaVista Software, Inc.
+ * Copyright 2007 Freescale Semiconductor, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -12,7 +13,7 @@
 
 / {
 	model = "MPC885ADS";
-	compatible = "mpc8xx";
+	compatible = "fsl,mpc885ads";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -23,161 +24,180 @@
 		PowerPC,885@0 {
 			device_type = "cpu";
 			reg = <0>;
-			d-cache-line-size = <20>;	// 32 bytes
-			i-cache-line-size = <20>;	// 32 bytes
-			d-cache-size = <2000>;		// L1, 8K
-			i-cache-size = <2000>;		// L1, 8K
+			d-cache-line-size = <d#16>;
+			i-cache-line-size = <d#16>;
+			d-cache-size = <d#8192>;
+			i-cache-size = <d#8192>;
 			timebase-frequency = <0>;
 			bus-frequency = <0>;
 			clock-frequency = <0>;
-			32-bit;
 			interrupts = <f 2>;	// decrementer interrupt
-			interrupt-parent = <&Mpc8xx_pic>;
+			interrupt-parent = <&PIC>;
 		};
 	};
 
 	memory {
 		device_type = "memory";
-		reg = <00000000 800000>;
+		reg = <0 0>;
 	};
 
-	soc885@ff000000 {
+	chipselect {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		flash@fe000000 {
+			device_type = "rom";
+			compatible = "direct-mapped";
+			reg = <fe000000 800000>;
+			probe-type = "JEDEC";
+			bank-width = <4>;
+		};
+
+		board-control@ff080000 {
+			reg = <ff080000 20 ff0a0300 4>;
+			compatible = "fsl,mpc885ads-bcsr";
+		};
+	};
+
+	soc@ff000000 {
+		compatible = "fsl,mpc885", "fsl,pq1-soc";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		device_type = "soc";
-		ranges = <0 ff000000 00100000>;
-		reg = <ff000000 00000200>;
+		ranges = <0 ff000000 00004000>;
 		bus-frequency = <0>;
-		mdio@e80 {
-			device_type = "mdio";
-			compatible = "fs_enet";
-			reg = <e80 8>;
+
+		mdio@e00 {
+			compatible = "fsl,mpc885-fec-mdio", "fsl,pq1-fec-mdio";
+			reg = <e00 188>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			Phy0: ethernet-phy@0 {
+
+			PHY0: ethernet-phy@0 {
 				reg = <0>;
 				device_type = "ethernet-phy";
 			};
-			Phy1: ethernet-phy@1 {
+
+			PHY1: ethernet-phy@1 {
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
-			Phy2: ethernet-phy@2 {
+
+			PHY2: ethernet-phy@2 {
 				reg = <2>;
 				device_type = "ethernet-phy";
 			};
 		};
 
-		fec@e00 {
+		ethernet@e00 {
 			device_type = "network";
-			compatible = "fs_enet";
-			model = "FEC";
-			device-id = <1>;
+			compatible = "fsl,mpc885-fec-enet",
+			             "fsl,pq1-fec-enet";
 			reg = <e00 188>;
-			mac-address = [ 00 00 0C 00 01 FD ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <3 1>;
-			interrupt-parent = <&Mpc8xx_pic>;
-			phy-handle = <&Phy1>;
+			interrupt-parent = <&PIC>;
+			phy-handle = <&PHY0>;
+			linux,network-index = <0>;
 		};
 
-		fec@1e00 {
+		ethernet@1e00 {
 			device_type = "network";
-			compatible = "fs_enet";
-			model = "FEC";
-			device-id = <2>;
+			compatible = "fsl,mpc885-fec-enet",
+			             "fsl,pq1-fec-enet";
 			reg = <1e00 188>;
-			mac-address = [ 00 00 0C 00 02 FD ];
+			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <7 1>;
-			interrupt-parent = <&Mpc8xx_pic>;
-			phy-handle = <&Phy2>;
+			interrupt-parent = <&PIC>;
+			phy-handle = <&PHY1>;
+			linux,network-index = <1>;
 		};
 
-		Mpc8xx_pic: pic@ff000000 {
+		PIC: interrupt-controller@0 {
 			interrupt-controller;
-			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			reg = <0 24>;
-			built-in;
-			device_type = "mpc8xx-pic";
-			compatible = "CPM";
+			compatible = "fsl,mpc885-pic", "fsl,pq1-pic";
 		};
 
-		pcmcia@0080 {
+		pcmcia@80 {
 			#address-cells = <3>;
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			compatible = "fsl,pq-pcmcia";
 			device_type = "pcmcia";
 			reg = <80 80>;
-			interrupt-parent = <&Mpc8xx_pic>;
+			interrupt-parent = <&PIC>;
 			interrupts = <d 1>;
 		};
 
-		cpm@ff000000 {
+		cpm@9c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			#interrupt-cells = <2>;
-			device_type = "cpm";
-			model = "CPM";
-			ranges = <0 0 4000>;
-			reg = <860 f0>;
+			compatible = "fsl,mpc885-cpm", "fsl,cpm1";
 			command-proc = <9c0>;
-			brg-frequency = <0>;
-			interrupts = <0 2>;	// cpm error interrupt
-			interrupt-parent = <&Cpm_pic>;
+			fsl,brg-frequency = <0>;
+			interrupts = <0>;	// cpm error interrupt
+			interrupt-parent = <&CPM_PIC>;
+			reg = <9c0 40 2000 1c00>;
+			ranges;
 
-			Cpm_pic: pic@930 {
+			brg@9f0 {
+				compatible = "fsl,mpc885-brg",
+				             "fsl,cpm1-brg",
+				             "fsl,cpm-brg";
+				reg = <9f0 10>;
+			};
+
+			CPM_PIC: interrupt-controller@930 {
 				interrupt-controller;
-				#address-cells = <0>;
-				#interrupt-cells = <2>;
+				#interrupt-cells = <1>;
 				interrupts = <5 2 0 2>;
-				interrupt-parent = <&Mpc8xx_pic>;
+				interrupt-parent = <&PIC>;
 				reg = <930 20>;
-				built-in;
-				device_type = "cpm-pic";
-				compatible = "CPM";
+				compatible = "fsl,mpc885-cpm-pic",
+				             "fsl,cpm1-pic";
 			};
 
-			smc@a80 {
+			serial@a80 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SMC";
-				device-id = <1>;
+				compatible = "fsl,mpc885-smc-uart",
+				             "fsl,cpm1-smc-uart";
 				reg = <a80 10 3e80 40>;
-				clock-setup = <00ffffff 0>;
-				rx-clock = <1>;
-				tx-clock = <1>;
-				current-speed = <0>;
-				interrupts = <4 3>;
-				interrupt-parent = <&Cpm_pic>;
+				interrupts = <4>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <0090>;
 			};
 
-			smc@a90 {
+			serial@a90 {
 				device_type = "serial";
-				compatible = "cpm_uart";
-				model = "SMC";
-				device-id = <2>;
-				reg = <a90 20 3f80 40>;
-				clock-setup = <ff00ffff 90000>;
-				rx-clock = <2>;
-				tx-clock = <2>;
-				current-speed = <0>;
-				interrupts = <3 3>;
-				interrupt-parent = <&Cpm_pic>;
+				compatible = "fsl,mpc885-smc-uart",
+				             "fsl,cpm1-smc-uart";
+				reg = <a90 10 3f80 40>;
+				interrupts = <3>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-brg = <2>;
+				fsl,cpm-command = <00d0>;
 			};
 
-			scc@a40 {
+			ethernet@a40 {
 				device_type = "network";
-				compatible = "fs_enet";
-				model = "SCC";
-				device-id = <3>;
-				reg = <a40 18 3e00 80>;
-				mac-address = [ 00 00 0C 00 03 FD ];
-				interrupts = <1c 3>;
-				interrupt-parent = <&Cpm_pic>;
-				phy-handle = <&Phy2>;
+				compatible = "fsl,mpc885-scc-enet",
+				             "fsl,cpm1-scc-enet";
+				reg = <a40 18 3e00 100>;
+				local-mac-address = [ 00 00 00 00 00 00 ];
+				interrupts = <1c>;
+				interrupt-parent = <&CPM_PIC>;
+				phy-handle = <&PHY2>;
+				fsl,cpm-command = <0080>;
+				linux,network-index = <2>;
 			};
 		};
 	};
+
+	chosen {
+		linux,stdout-path = "/soc/cpm/serial@a80";
+	};
 };
diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index fc4f9b7..482d99d 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -1,9 +1,22 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:57:01 2007
+# Linux kernel version: 2.6.23-rc3
+# Mon Aug 27 15:23:16 2007
 #
 # CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_6xx is not set
+# CONFIG_PPC_85xx is not set
+CONFIG_PPC_8xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_8xx=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_NOT_COHERENT_CACHE=y
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -14,56 +27,38 @@ CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_GENERIC_NVRAM=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
+CONFIG_OF=y
 # CONFIG_PPC_UDBG_16550 is not set
 # CONFIG_GENERIC_TBSYNC is not set
 CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
 # CONFIG_DEFAULT_UIMAGE is not set
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_82xx is not set
-# CONFIG_PPC_83xx is not set
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-CONFIG_PPC_8xx=y
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_8xx=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-# CONFIG_PPC_MM_SLICES is not set
-CONFIG_NOT_COHERENT_CACHE=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
@@ -75,52 +70,46 @@ CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 # CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
-# CONFIG_BUG is not set
-CONFIG_ELF_CORE=y
+CONFIG_BUG=y
+# CONFIG_ELF_CORE is not set
 # CONFIG_BASE_FULL is not set
-CONFIG_FUTEX=y
+# CONFIG_FUTEX is not set
 CONFIG_ANON_INODES=y
-# CONFIG_EPOLL is not set
+CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
 CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 # CONFIG_VM_EVENT_COUNTERS is not set
-CONFIG_SLAB=y
-# CONFIG_SLUB is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
 # CONFIG_SLOB is not set
-CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=1
-
-#
-# Loadable module support
-#
 # CONFIG_MODULES is not set
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
 
 #
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
+# CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
-# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+CONFIG_DEFAULT_DEADLINE=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_IOSCHED="deadline"
 
 #
 # Platform support
@@ -133,6 +122,7 @@ CONFIG_CPM1=y
 # CONFIG_MPC8XXFADS is not set
 # CONFIG_MPC86XADS is not set
 CONFIG_MPC885ADS=y
+# CONFIG_PPC_EP88XC is not set
 
 #
 # Freescale Ethernet driver platform-specific options
@@ -150,6 +140,7 @@ CONFIG_MPC8xx_SECOND_ETH_FEC2=y
 #
 CONFIG_8xx_COPYBACK=y
 # CONFIG_8xx_CPU6 is not set
+CONFIG_8xx_CPU15=y
 CONFIG_NO_UCODE_PATCH=y
 # CONFIG_USB_SOF_UCODE_PATCH is not set
 # CONFIG_I2C_SPI_UCODE_PATCH is not set
@@ -166,22 +157,23 @@ CONFIG_NO_UCODE_PATCH=y
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_CPM2 is not set
+CONFIG_PPC_CPM_NEW_BINDING=y
 
 #
 # Kernel options
 #
 # CONFIG_HIGHMEM is not set
-# CONFIG_HZ_100 is not set
+CONFIG_HZ_100=y
 # CONFIG_HZ_250 is not set
 # CONFIG_HZ_300 is not set
-CONFIG_HZ_1000=y
-CONFIG_HZ=1000
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-CONFIG_MATH_EMULATION=y
+# CONFIG_MATH_EMULATION is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
@@ -195,11 +187,14 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
-# CONFIG_PROC_DEVICETREE is not set
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 # CONFIG_SECCOMP is not set
-# CONFIG_WANT_DEVICE_TREE is not set
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE="mpc885ads.dts"
 CONFIG_ISA_DMA_API=y
 
 #
@@ -209,12 +204,14 @@ CONFIG_ZONE_DMA=y
 CONFIG_FSL_SOC=y
 # CONFIG_PCI is not set
 # CONFIG_PCI_DOMAINS is not set
+# CONFIG_PCI_SYSCALL is not set
 # CONFIG_PCI_QSPAN is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
+# CONFIG_PCCARD is not set
 
 #
 # Advanced setup
@@ -243,10 +240,6 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
-CONFIG_XFRM=y
-# CONFIG_XFRM_USER is not set
-# CONFIG_XFRM_SUB_POLICY is not set
-# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -266,9 +259,9 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=y
-CONFIG_INET_XFRM_MODE_TUNNEL=y
-CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -317,6 +310,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -327,40 +321,91 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
-
-#
-# Parallel port support
-#
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
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
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
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
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
+CONFIG_OF_DEVICE=y
 # CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-# CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
-# CONFIG_BLK_DEV_FD is not set
-# CONFIG_BLK_DEV_COW_COMMON is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-# CONFIG_BLK_DEV_RAM is not set
-# CONFIG_CDROM_PKTCDVD is not set
-# CONFIG_ATA_OVER_ETH is not set
-
-#
-# Misc devices
-#
-# CONFIG_BLINK is not set
+# CONFIG_BLK_DEV is not set
+# CONFIG_MISC_DEVICES is not set
 # CONFIG_IDE is not set
 
 #
@@ -368,21 +413,16 @@ CONFIG_BLK_DEV_LOOP=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 CONFIG_PHYLIB=y
@@ -398,21 +438,16 @@ CONFIG_DAVICOM_PHY=y
 # CONFIG_VITESSE_PHY is not set
 # CONFIG_SMSC_PHY is not set
 # CONFIG_BROADCOM_PHY is not set
-CONFIG_FIXED_PHY=y
-CONFIG_FIXED_MII_10_FDX=y
-# CONFIG_FIXED_MII_100_FDX is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
-# CONFIG_FEC_8XX is not set
 CONFIG_FS_ENET=y
-CONFIG_FS_ENET_HAS_SCC=y
+# CONFIG_FS_ENET_HAS_SCC is not set
 CONFIG_FS_ENET_HAS_FEC=y
-CONFIG_NETDEV_1000=y
-CONFIG_NETDEV_10000=y
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 
 #
 # Wireless LAN
@@ -426,69 +461,18 @@ CONFIG_NETDEV_10000=y
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
 # CONFIG_PHONE is not set
 
 #
 # Input device support
 #
-CONFIG_INPUT=y
-# CONFIG_INPUT_FF_MEMLESS is not set
-# CONFIG_INPUT_POLLDEV is not set
-
-#
-# Userland interfaces
-#
-CONFIG_INPUT_MOUSEDEV=y
-CONFIG_INPUT_MOUSEDEV_PSAUX=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
-# CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
-# CONFIG_INPUT_EVDEV is not set
-# CONFIG_INPUT_EVBUG is not set
-
-#
-# Input Device Drivers
-#
-CONFIG_INPUT_KEYBOARD=y
-CONFIG_KEYBOARD_ATKBD=y
-# CONFIG_KEYBOARD_SUNKBD is not set
-# CONFIG_KEYBOARD_LKKBD is not set
-# CONFIG_KEYBOARD_XTKBD is not set
-# CONFIG_KEYBOARD_NEWTON is not set
-# CONFIG_KEYBOARD_STOWAWAY is not set
-CONFIG_INPUT_MOUSE=y
-CONFIG_MOUSE_PS2=y
-CONFIG_MOUSE_PS2_ALPS=y
-CONFIG_MOUSE_PS2_LOGIPS2PP=y
-CONFIG_MOUSE_PS2_SYNAPTICS=y
-CONFIG_MOUSE_PS2_LIFEBOOK=y
-CONFIG_MOUSE_PS2_TRACKPOINT=y
-# CONFIG_MOUSE_PS2_TOUCHKIT is not set
-# CONFIG_MOUSE_SERIAL is not set
-# CONFIG_MOUSE_VSXXXAA is not set
-# CONFIG_INPUT_JOYSTICK is not set
-# CONFIG_INPUT_TABLET is not set
-# CONFIG_INPUT_TOUCHSCREEN is not set
-# CONFIG_INPUT_MISC is not set
+# CONFIG_INPUT is not set
 
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
-CONFIG_SERIO_SERPORT=y
-CONFIG_SERIO_LIBPS2=y
-# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
@@ -518,10 +502,6 @@ CONFIG_SERIAL_CPM_SMC1=y
 CONFIG_SERIAL_CPM_SMC2=y
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=y
@@ -530,10 +510,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
 
@@ -542,21 +518,9 @@ CONFIG_GEN_RTC=y
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
-CONFIG_HWMON=y
-# CONFIG_HWMON_VID is not set
-# CONFIG_SENSORS_ABITUGURU is not set
-# CONFIG_SENSORS_F71805F is not set
-# CONFIG_SENSORS_PC87427 is not set
-# CONFIG_SENSORS_SMSC47M1 is not set
-# CONFIG_SENSORS_SMSC47B397 is not set
-# CONFIG_SENSORS_VT1211 is not set
-# CONFIG_SENSORS_W83627HF is not set
-# CONFIG_HWMON_DEBUG_CHIP is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
 
 #
 # Multifunction device drivers
@@ -580,6 +544,7 @@ CONFIG_DAB=y
 #
 # CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 # CONFIG_FB is not set
 # CONFIG_FB_IBM_GXT4500 is not set
 
@@ -587,54 +552,10 @@ CONFIG_DAB=y
 # Sound
 #
 # CONFIG_SOUND is not set
-
-#
-# HID Devices
-#
-CONFIG_HID=y
-# CONFIG_HID_DEBUG is not set
-
-#
-# USB support
-#
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
-# CONFIG_USB_GADGET is not set
+# CONFIG_USB_SUPPORT is not set
 # CONFIG_MMC is not set
-
-#
-# LED devices
-#
 # CONFIG_NEW_LEDS is not set
-
-#
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-
-#
-# InfiniBand support
-#
-
-#
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
-#
-
-#
-# Real Time Clock
-#
+# CONFIG_EDAC is not set
 # CONFIG_RTC_CLASS is not set
 
 #
@@ -651,21 +572,16 @@ CONFIG_HID=y
 #
 
 #
+# Userspace I/O
+#
+# CONFIG_UIO is not set
+
+#
 # File systems
 #
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-# CONFIG_EXT2_FS_POSIX_ACL is not set
-# CONFIG_EXT2_FS_SECURITY is not set
-# CONFIG_EXT2_FS_XIP is not set
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_XATTR=y
-# CONFIG_EXT3_FS_POSIX_ACL is not set
-# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
 # CONFIG_EXT4DEV_FS is not set
-CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
-CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
@@ -674,10 +590,9 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
-CONFIG_INOTIFY=y
-CONFIG_INOTIFY_USER=y
+# CONFIG_INOTIFY is not set
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
+# CONFIG_DNOTIFY is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
@@ -718,6 +633,7 @@ CONFIG_RAMFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
 CONFIG_CRAMFS=y
 # CONFIG_VXFS_FS is not set
 # CONFIG_HPFS_FS is not set
@@ -747,7 +663,6 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -785,14 +700,13 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Library routines
 #
-CONFIG_BITREVERSE=y
-CONFIG_CRC_CCITT=y
+# CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
-CONFIG_CRC32=y
+# CONFIG_CRC32 is not set
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
-CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
@@ -807,12 +721,33 @@ CONFIG_HAS_DMA=y
 #
 # CONFIG_PRINTK_TIME is not set
 CONFIG_ENABLE_MUST_CHECK=y
-# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-# CONFIG_BOOTX_TEXT is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_DEBUGGER is not set
+# CONFIG_BDI_SWITCH is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
 #
@@ -820,8 +755,4 @@ CONFIG_ENABLE_MUST_CHECK=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 # CONFIG_CRYPTO is not set
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index b8dd515..4829378 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -25,6 +25,7 @@ config MPC86XADS
 config MPC885ADS
 	bool "MPC885ADS"
 	select CPM1
+	select PPC_CPM_NEW_BINDING
 	help
 	  Freescale Semiconductor MPC885 Application Development System (ADS).
 	  Also known as DUET.
diff --git a/arch/powerpc/platforms/8xx/mpc885ads.h b/arch/powerpc/platforms/8xx/mpc885ads.h
index a21e528..a507666 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads.h
+++ b/arch/powerpc/platforms/8xx/mpc885ads.h
@@ -17,25 +17,10 @@
 
 #include <sysdev/fsl_soc.h>
 
-/* U-Boot maps BCSR to 0xff080000 */
-#define BCSR_ADDR		((uint)0xff080000)
-#define BCSR_SIZE		((uint)32)
-#define BCSR0			((uint)(BCSR_ADDR + 0x00))
-#define BCSR1			((uint)(BCSR_ADDR + 0x04))
-#define BCSR2			((uint)(BCSR_ADDR + 0x08))
-#define BCSR3			((uint)(BCSR_ADDR + 0x0c))
-#define BCSR4			((uint)(BCSR_ADDR + 0x10))
-
-#define CFG_PHYDEV_ADDR		((uint)0xff0a0000)
-#define BCSR5			((uint)(CFG_PHYDEV_ADDR + 0x300))
-
 #define MPC8xx_CPM_OFFSET	(0x9c0)
 #define CPM_MAP_ADDR		(get_immrbase() + MPC8xx_CPM_OFFSET)
 #define CPM_IRQ_OFFSET		16     // for compability with cpm_uart driver
 
-#define PCMCIA_MEM_ADDR		((uint)0xff020000)
-#define PCMCIA_MEM_SIZE		((uint)(64 * 1024))
-
 /* Bits of interest in the BCSRs.
  */
 #define BCSR1_ETHEN		((uint)0x20000000)
@@ -64,28 +49,5 @@
 #define BCSR5_MII1_EN		0x02
 #define BCSR5_MII1_RST		0x01
 
-/* Interrupt level assignments */
-#define PHY_INTERRUPT	SIU_IRQ7	/* PHY link change interrupt */
-#define SIU_INT_FEC1	SIU_LEVEL1	/* FEC1 interrupt */
-#define SIU_INT_FEC2	SIU_LEVEL3	/* FEC2 interrupt */
-#define FEC_INTERRUPT	SIU_INT_FEC1	/* FEC interrupt */
-
-/* We don't use the 8259 */
-#define NR_8259_INTS	0
-
-/* CPM Ethernet through SCC3 */
-#define PA_ENET_RXD	((ushort)0x0040)
-#define PA_ENET_TXD	((ushort)0x0080)
-#define PE_ENET_TCLK	((uint)0x00004000)
-#define PE_ENET_RCLK	((uint)0x00008000)
-#define PE_ENET_TENA	((uint)0x00000010)
-#define PC_ENET_CLSN	((ushort)0x0400)
-#define PC_ENET_RENA	((ushort)0x0800)
-
-/* Control bits in the SICR to route TCLK (CLK5) and RCLK (CLK6) to
- * SCC3.  Also, make sure GR3 (bit 8) and SC3 (bit 9) are zero */
-#define SICR_ENET_MASK	((uint)0x00ff0000)
-#define SICR_ENET_CLKRT	((uint)0x002c0000)
-
 #endif /* __ASM_MPC885ADS_H__ */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index bb54268..f205978 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -1,11 +1,13 @@
-/*arch/powerpc/platforms/8xx/mpc885ads_setup.c
- *
+/*
  * Platform setup for the Freescale mpc885ads board
  *
  * Vitaly Bordug <vbordug@ru.mvista.com>
  *
  * Copyright 2005 MontaVista Software Inc.
  *
+ * Heavily modified by Scott Wood <scottwood@freescale.com>
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
@@ -18,7 +20,6 @@
 #include <linux/ioport.h>
 #include <linux/device.h>
 #include <linux/delay.h>
-#include <linux/root_dev.h>
 
 #include <linux/fs_enet_pd.h>
 #include <linux/fs_uart_pd.h>
@@ -36,32 +37,26 @@
 #include <asm/8xx_immap.h>
 #include <asm/commproc.h>
 #include <asm/fs_pd.h>
-#include <asm/prom.h>
+#include <asm/of_platform.h>
+#include <asm/udbg.h>
 
-static void init_smc1_uart_ioports(struct fs_uart_platform_info *fpi);
-static void init_smc2_uart_ioports(struct fs_uart_platform_info *fpi);
-static void init_scc3_ioports(struct fs_platform_info *ptr);
+#include <sysdev/cpm_common.h>
+#include <sysdev/commproc.h>
+
+static u32 __iomem *bcsr, *bcsr5;
 
 #ifdef CONFIG_PCMCIA_M8XX
 static void pcmcia_hw_setup(int slot, int enable)
 {
-	unsigned *bcsr_io;
-
-	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
 	if (enable)
-		clrbits32(bcsr_io, BCSR1_PCCEN);
+		clrbits32(&bcsr[1], BCSR1_PCCEN);
 	else
-		setbits32(bcsr_io, BCSR1_PCCEN);
-
-	iounmap(bcsr_io);
+		setbits32(&bcsr[1], BCSR1_PCCEN);
 }
 
 static int pcmcia_set_voltage(int slot, int vcc, int vpp)
 {
 	u32 reg = 0;
-	unsigned *bcsr_io;
-
-	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
 
 	switch (vcc) {
 	case 0:
@@ -96,330 +91,200 @@ static int pcmcia_set_voltage(int slot, int vcc, int vpp)
 	}
 
 	/* first, turn off all power */
-	clrbits32(bcsr_io, 0x00610000);
+	clrbits32(&bcsr[1], 0x00610000);
 
 	/* enable new powersettings */
-	setbits32(bcsr_io, reg);
+	setbits32(&bcsr[1], reg);
 
-	iounmap(bcsr_io);
 	return 0;
 }
 #endif
 
-void __init mpc885ads_board_setup(void)
-{
-	cpm8xx_t *cp;
-	unsigned int *bcsr_io;
-	u8 tmpval8;
-
-#ifdef CONFIG_FS_ENET
-	iop8xx_t *io_port;
-#endif
+struct cpm_pin {
+	int port, pin, flags;
+};
 
-	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
-	cp = (cpm8xx_t *) immr_map(im_cpm);
+static struct cpm_pin mpc885ads_pins[] = {
+	/* SMC1 */
+	{1, 24, CPM_PIN_INPUT}, /* RX */
+	{1, 25, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TX */
 
-	if (bcsr_io == NULL) {
-		printk(KERN_CRIT "Could not remap BCSR\n");
-		return;
-	}
-#ifdef CONFIG_SERIAL_CPM_SMC1
-	clrbits32(bcsr_io, BCSR1_RS232EN_1);
-	clrbits32(&cp->cp_simode, 0xe0000000 >> 17);	/* brg1 */
-	tmpval8 = in_8(&(cp->cp_smc[0].smc_smcm)) | (SMCM_RX | SMCM_TX);
-	out_8(&(cp->cp_smc[0].smc_smcm), tmpval8);
-	clrbits16(&cp->cp_smc[0].smc_smcmr, SMCMR_REN | SMCMR_TEN);	/* brg1 */
-#else
-	setbits32(bcsr_io, BCSR1_RS232EN_1);
-	out_be16(&cp->cp_smc[0].smc_smcmr, 0);
-	out_8(&cp->cp_smc[0].smc_smce, 0);
+	/* SMC2 */
+#ifndef CONFIG_MPC8xx_SECOND_ETH_FEC2
+	{4, 21, CPM_PIN_INPUT}, /* RX */
+	{4, 20, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TX */
 #endif
 
-#ifdef CONFIG_SERIAL_CPM_SMC2
-	clrbits32(bcsr_io, BCSR1_RS232EN_2);
-	clrbits32(&cp->cp_simode, 0xe0000000 >> 1);
-	setbits32(&cp->cp_simode, 0x20000000 >> 1);	/* brg2 */
-	tmpval8 = in_8(&(cp->cp_smc[1].smc_smcm)) | (SMCM_RX | SMCM_TX);
-	out_8(&(cp->cp_smc[1].smc_smcm), tmpval8);
-	clrbits16(&cp->cp_smc[1].smc_smcmr, SMCMR_REN | SMCMR_TEN);
-
-	init_smc2_uart_ioports(0);
-#else
-	setbits32(bcsr_io, BCSR1_RS232EN_2);
-	out_be16(&cp->cp_smc[1].smc_smcmr, 0);
-	out_8(&cp->cp_smc[1].smc_smce, 0);
-#endif
-	immr_unmap(cp);
-	iounmap(bcsr_io);
-
-#ifdef CONFIG_FS_ENET
-	/* use MDC for MII (common) */
-	io_port = (iop8xx_t *) immr_map(im_ioport);
-	setbits16(&io_port->iop_pdpar, 0x0080);
-	clrbits16(&io_port->iop_pddir, 0x0080);
-
-	bcsr_io = ioremap(BCSR5, sizeof(unsigned long));
-	clrbits32(bcsr_io, BCSR5_MII1_EN);
-	clrbits32(bcsr_io, BCSR5_MII1_RST);
-#ifndef CONFIG_FC_ENET_HAS_SCC
-	clrbits32(bcsr_io, BCSR5_MII2_EN);
-	clrbits32(bcsr_io, BCSR5_MII2_RST);
-
+	/* SCC3 */
+	{0, 9, CPM_PIN_INPUT}, /* RX */
+	{0, 8, CPM_PIN_INPUT}, /* TX */
+	{2, 4, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_GPIO}, /* RENA */
+	{2, 5, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_GPIO}, /* CLSN */
+	{4, 27, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TENA */
+	{4, 17, CPM_PIN_INPUT}, /* CLK5 */
+	{4, 16, CPM_PIN_INPUT}, /* CLK6 */
+
+	/* MII1 */
+	{0, 0, CPM_PIN_INPUT},
+	{0, 1, CPM_PIN_INPUT},
+	{0, 2, CPM_PIN_INPUT},
+	{0, 3, CPM_PIN_INPUT},
+	{0, 4, CPM_PIN_OUTPUT},
+	{0, 10, CPM_PIN_OUTPUT},
+	{0, 11, CPM_PIN_OUTPUT},
+	{1, 19, CPM_PIN_INPUT},
+	{1, 31, CPM_PIN_INPUT},
+	{2, 12, CPM_PIN_INPUT},
+	{2, 13, CPM_PIN_INPUT},
+	{4, 30, CPM_PIN_OUTPUT},
+	{4, 31, CPM_PIN_OUTPUT},
+
+	/* MII2 */
+#ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
+	{4, 14, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 15, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 16, CPM_PIN_OUTPUT},
+	{4, 17, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 18, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 19, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 20, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 21, CPM_PIN_OUTPUT},
+	{4, 22, CPM_PIN_OUTPUT},
+	{4, 23, CPM_PIN_OUTPUT},
+	{4, 24, CPM_PIN_OUTPUT},
+	{4, 25, CPM_PIN_OUTPUT},
+	{4, 26, CPM_PIN_OUTPUT},
+	{4, 27, CPM_PIN_OUTPUT},
+	{4, 28, CPM_PIN_OUTPUT},
+	{4, 29, CPM_PIN_OUTPUT},
 #endif
-	iounmap(bcsr_io);
-	immr_unmap(io_port);
+};
 
-#endif
-
-#ifdef CONFIG_PCMCIA_M8XX
-	/*Set up board specific hook-ups */
-	m8xx_pcmcia_ops.hw_ctrl = pcmcia_hw_setup;
-	m8xx_pcmcia_ops.voltage_set = pcmcia_set_voltage;
-#endif
-}
-
-static void init_fec1_ioports(struct fs_platform_info *ptr)
+static void __init init_ioports(void)
 {
-	cpm8xx_t *cp = (cpm8xx_t *) immr_map(im_cpm);
-	iop8xx_t *io_port = (iop8xx_t *) immr_map(im_ioport);
-
-	/* configure FEC1 pins  */
-	setbits16(&io_port->iop_papar, 0xf830);
-	setbits16(&io_port->iop_padir, 0x0830);
-	clrbits16(&io_port->iop_padir, 0xf000);
-
-	setbits32(&cp->cp_pbpar, 0x00001001);
-	clrbits32(&cp->cp_pbdir, 0x00001001);
+	int i;
 
-	setbits16(&io_port->iop_pcpar, 0x000c);
-	clrbits16(&io_port->iop_pcdir, 0x000c);
+	for (i = 0; i < ARRAY_SIZE(mpc885ads_pins); i++) {
+		struct cpm_pin *pin = &mpc885ads_pins[i];
+		cpm1_set_pin(pin->port, pin->pin, pin->flags);
+	}
 
-	setbits32(&cp->cp_pepar, 0x00000003);
-	setbits32(&cp->cp_pedir, 0x00000003);
-	clrbits32(&cp->cp_peso, 0x00000003);
-	clrbits32(&cp->cp_cptr, 0x00000100);
+	cpm1_clk_setup(CPM_CLK_SMC1, CPM_BRG1, CPM_CLK_RTX);
+	cpm1_clk_setup(CPM_CLK_SMC2, CPM_BRG2, CPM_CLK_RTX);
+	cpm1_clk_setup(CPM_CLK_SCC3, CPM_CLK5, CPM_CLK_TX);
+	cpm1_clk_setup(CPM_CLK_SCC3, CPM_CLK6, CPM_CLK_RX);
 
-	immr_unmap(io_port);
-	immr_unmap(cp);
+	/* Set FEC1 and FEC2 to MII mode */
+	clrbits32(&mpc8xx_immr->im_cpm.cp_cptr, 0x00000180);
 }
 
-static void init_fec2_ioports(struct fs_platform_info *ptr)
+static void __init mpc885ads_setup_arch(void)
 {
-	cpm8xx_t *cp = (cpm8xx_t *) immr_map(im_cpm);
-	iop8xx_t *io_port = (iop8xx_t *) immr_map(im_ioport);
-
-	/* configure FEC2 pins */
-	setbits32(&cp->cp_pepar, 0x0003fffc);
-	setbits32(&cp->cp_pedir, 0x0003fffc);
-	clrbits32(&cp->cp_peso, 0x000087fc);
-	setbits32(&cp->cp_peso, 0x00037800);
-	clrbits32(&cp->cp_cptr, 0x00000080);
-
-	immr_unmap(io_port);
-	immr_unmap(cp);
-}
+	struct device_node *np;
 
-void init_fec_ioports(struct fs_platform_info *fpi)
-{
-	int fec_no = fs_get_fec_index(fpi->fs_no);
+	cpm_reset();
+	init_ioports();
 
-	switch (fec_no) {
-	case 0:
-		init_fec1_ioports(fpi);
-		break;
-	case 1:
-		init_fec2_ioports(fpi);
-		break;
-	default:
-		printk(KERN_ERR "init_fec_ioports: invalid FEC number\n");
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc885ads-bcsr");
+	if (!np) {
+		printk(KERN_CRIT "Could not find fsl,mpc885ads-bcsr node\n");
 		return;
 	}
-}
 
-static void init_scc3_ioports(struct fs_platform_info *fpi)
-{
-	unsigned *bcsr_io;
-	iop8xx_t *io_port;
-	cpm8xx_t *cp;
+	bcsr = of_iomap(np, 0);
+	bcsr5 = of_iomap(np, 1);
+	of_node_put(np);
 
-	bcsr_io = ioremap(BCSR_ADDR, BCSR_SIZE);
-	io_port = (iop8xx_t *) immr_map(im_ioport);
-	cp = (cpm8xx_t *) immr_map(im_cpm);
-
-	if (bcsr_io == NULL) {
+	if (!bcsr || !bcsr5) {
 		printk(KERN_CRIT "Could not remap BCSR\n");
 		return;
 	}
 
-	/* Enable the PHY.
-	 */
-	clrbits32(bcsr_io + 4, BCSR4_ETH10_RST);
-	udelay(1000);
-	setbits32(bcsr_io + 4, BCSR4_ETH10_RST);
-	/* Configure port A pins for Txd and Rxd.
-	 */
-	setbits16(&io_port->iop_papar, PA_ENET_RXD | PA_ENET_TXD);
-	clrbits16(&io_port->iop_padir, PA_ENET_RXD | PA_ENET_TXD);
+	clrbits32(&bcsr[1], BCSR1_RS232EN_1);
+#ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
+	setbits32(&bcsr[1], BCSR1_RS232EN_2);
+#else
+	clrbits32(&bcsr[1], BCSR1_RS232EN_2);
+#endif
 
-	/* Configure port C pins to enable CLSN and RENA.
-	 */
-	clrbits16(&io_port->iop_pcpar, PC_ENET_CLSN | PC_ENET_RENA);
-	clrbits16(&io_port->iop_pcdir, PC_ENET_CLSN | PC_ENET_RENA);
-	setbits16(&io_port->iop_pcso, PC_ENET_CLSN | PC_ENET_RENA);
+	clrbits32(bcsr5, BCSR5_MII1_EN);
+	setbits32(bcsr5, BCSR5_MII1_RST);
+	udelay(1000);
+	clrbits32(bcsr5, BCSR5_MII1_RST);
 
-	/* Configure port E for TCLK and RCLK.
-	 */
-	setbits32(&cp->cp_pepar, PE_ENET_TCLK | PE_ENET_RCLK);
-	clrbits32(&cp->cp_pepar, PE_ENET_TENA);
-	clrbits32(&cp->cp_pedir, PE_ENET_TCLK | PE_ENET_RCLK | PE_ENET_TENA);
-	clrbits32(&cp->cp_peso, PE_ENET_TCLK | PE_ENET_RCLK);
-	setbits32(&cp->cp_peso, PE_ENET_TENA);
-
-	/* Configure Serial Interface clock routing.
-	 * First, clear all SCC bits to zero, then set the ones we want.
-	 */
-	clrbits32(&cp->cp_sicr, SICR_ENET_MASK);
-	setbits32(&cp->cp_sicr, SICR_ENET_CLKRT);
+#ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
+	clrbits32(bcsr5, BCSR5_MII2_EN);
+	setbits32(bcsr5, BCSR5_MII2_RST);
+	udelay(1000);
+	clrbits32(bcsr5, BCSR5_MII2_RST);
+#else
+	setbits32(bcsr5, BCSR5_MII2_EN);
+#endif
 
-	/* Disable Rx and Tx. SMC1 sshould be stopped if SCC3 eternet are used.
-	 */
-	clrbits16(&cp->cp_smc[0].smc_smcmr, SMCMR_REN | SMCMR_TEN);
-	/* On the MPC885ADS SCC ethernet PHY is initialized in the full duplex mode
-	 * by H/W setting after reset. SCC ethernet controller support only half duplex.
-	 * This discrepancy of modes causes a lot of carrier lost errors.
-	 */
+#ifdef CONFIG_MPC8xx_SECOND_ETH_SCC3
+	clrbits32(&bcsr[4], BCSR4_ETH10_RST);
+	udelay(1000);
+	setbits32(&bcsr[4], BCSR4_ETH10_RST);
 
-	/* In the original SCC enet driver the following code is placed at
-	   the end of the initialization */
-	setbits32(&cp->cp_pepar, PE_ENET_TENA);
-	clrbits32(&cp->cp_pedir, PE_ENET_TENA);
-	setbits32(&cp->cp_peso, PE_ENET_TENA);
+	setbits32(&bcsr[1], BCSR1_ETHEN);
 
-	setbits32(bcsr_io + 4, BCSR1_ETHEN);
-	iounmap(bcsr_io);
-	immr_unmap(io_port);
-	immr_unmap(cp);
-}
+	np = of_find_node_by_path("/soc@ff000000/cpm@9c0/serial@a80");
+#else
+	np = of_find_node_by_path("/soc@ff000000/cpm@9c0/ethernet@a40");
+#endif
 
-void init_scc_ioports(struct fs_platform_info *fpi)
-{
-	int scc_no = fs_get_scc_index(fpi->fs_no);
+	/* The SCC3 enet registers overlap the SMC1 registers, so
+	 * one of the two must be removed from the device tree.
+	 */
 
-	switch (scc_no) {
-	case 2:
-		init_scc3_ioports(fpi);
-		break;
-	default:
-		printk(KERN_ERR "init_scc_ioports: invalid SCC number\n");
-		return;
+	if (np) {
+		of_detach_node(np);
+		of_node_put(np);
 	}
-}
-
-static void init_smc1_uart_ioports(struct fs_uart_platform_info *ptr)
-{
-	unsigned *bcsr_io;
-	cpm8xx_t *cp;
-
-	cp = (cpm8xx_t *) immr_map(im_cpm);
-	setbits32(&cp->cp_pepar, 0x000000c0);
-	clrbits32(&cp->cp_pedir, 0x000000c0);
-	clrbits32(&cp->cp_peso, 0x00000040);
-	setbits32(&cp->cp_peso, 0x00000080);
-	immr_unmap(cp);
-
-	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
 
-	if (bcsr_io == NULL) {
-		printk(KERN_CRIT "Could not remap BCSR1\n");
-		return;
-	}
-	clrbits32(bcsr_io, BCSR1_RS232EN_1);
-	iounmap(bcsr_io);
+#ifdef CONFIG_PCMCIA_M8XX
+	/* Set up board specific hook-ups.*/
+	m8xx_pcmcia_ops.hw_ctrl = pcmcia_hw_setup;
+	m8xx_pcmcia_ops.voltage_set = pcmcia_set_voltage;
+#endif
 }
 
-static void init_smc2_uart_ioports(struct fs_uart_platform_info *fpi)
+static int __init mpc885ads_probe(void)
 {
-	unsigned *bcsr_io;
-	cpm8xx_t *cp;
-
-	cp = (cpm8xx_t *) immr_map(im_cpm);
-	setbits32(&cp->cp_pepar, 0x00000c00);
-	clrbits32(&cp->cp_pedir, 0x00000c00);
-	clrbits32(&cp->cp_peso, 0x00000400);
-	setbits32(&cp->cp_peso, 0x00000800);
-	immr_unmap(cp);
-
-	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
-
-	if (bcsr_io == NULL) {
-		printk(KERN_CRIT "Could not remap BCSR1\n");
-		return;
-	}
-	clrbits32(bcsr_io, BCSR1_RS232EN_2);
-	iounmap(bcsr_io);
+	unsigned long root = of_get_flat_dt_root();
+	return of_flat_dt_is_compatible(root, "fsl,mpc885ads");
 }
 
-void init_smc_ioports(struct fs_uart_platform_info *data)
-{
-	int smc_no = fs_uart_id_fsid2smc(data->fs_no);
-
-	switch (smc_no) {
-	case 0:
-		init_smc1_uart_ioports(data);
-		data->brg = data->clk_rx;
-		break;
-	case 1:
-		init_smc2_uart_ioports(data);
-		data->brg = data->clk_rx;
-		break;
-	default:
-		printk(KERN_ERR "init_scc_ioports: invalid SCC number\n");
-		return;
-	}
-}
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .name = "cpm", },
+	{ .name = "chipselect", },
+	{},
+};
 
-int platform_device_skip(const char *model, int id)
+static int __init declare_of_platform_devices(void)
 {
-#ifdef CONFIG_MPC8xx_SECOND_ETH_SCC3
-	const char *dev = "FEC";
-	int n = 2;
-#else
-	const char *dev = "SCC";
-	int n = 3;
-#endif
-
-	if (!strcmp(model, dev) && n == id)
-		return 1;
+	/* Publish the QE devices */
+	if (machine_is(mpc885_ads))
+		of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
 	return 0;
 }
-
-static void __init mpc885ads_setup_arch(void)
-{
-	cpm_reset();
-
-	mpc885ads_board_setup();
-
-	ROOT_DEV = Root_NFS;
-}
-
-static int __init mpc885ads_probe(void)
-{
-	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
-					  "model", NULL);
-	if (model == NULL)
-		return 0;
-	if (strcmp(model, "MPC885ADS"))
-		return 0;
-
-	return 1;
-}
-
-define_machine(mpc885_ads)
-{
-.name = "MPC885 ADS",.probe = mpc885ads_probe,.setup_arch =
-	    mpc885ads_setup_arch,.init_IRQ =
-	    m8xx_pic_init,.get_irq =
-	    mpc8xx_get_irq,.restart = mpc8xx_restart,.calibrate_decr =
-	    mpc8xx_calibrate_decr,.set_rtc_time =
-	    mpc8xx_set_rtc_time,.get_rtc_time = mpc8xx_get_rtc_time,};
+device_initcall(declare_of_platform_devices);
+
+define_machine(mpc885_ads) {
+	.name			= "Freescale MPC885 ADS",
+	.probe			= mpc885ads_probe,
+	.setup_arch		= mpc885ads_setup_arch,
+	.init_IRQ		= m8xx_pic_init,
+	.get_irq		= mpc8xx_get_irq,
+	.restart		= mpc8xx_restart,
+	.calibrate_decr		= mpc8xx_calibrate_decr,
+	.set_rtc_time		= mpc8xx_set_rtc_time,
+	.get_rtc_time		= mpc8xx_get_rtc_time,
+	.progress		= udbg_progress,
+};
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
+u32 __iomem *cpm_udbg_txdesc = (u32 __iomem __force *)0xff002808;
+#endif
-- 
1.5.0.3

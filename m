Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFA2DDDE2C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:51:12 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 15/25] [POWERPC] Add basic PCI/PCI Express support for 8544DS
	board
Date: Mon, 23 Jul 2007 15:50:02 -0500
Message-Id: <11852238353292-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11852238333649-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
	<11852238233066-git-send-email-galak@kernel.crashing.org>
	<11852238241475-git-send-email-galak@kernel.crashing.org>
	<11852238253550-git-send-email-galak@kernel.crashing.org>
	<11852238271141-git-send-email-galak@kernel.crashing.org>
	<11852238283648-git-send-email-galak@kernel.crashing.org>
	<1185223830411-git-send-email-galak@kernel.crashing.org>
	<11852238322319-git-send-email-galak@kernel.crashing.org>
	<11852238333649-git-send-email-galak@kernel.crashing.org>
Cc: York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Add basic support for the PCIe PHB and enable the ULI bridge.

Signed-off-by: York Sun <yorksun@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8544ds.dts       |  211 ++++++++++++++++++
 arch/powerpc/configs/mpc8544_ds_defconfig |  333 ++++++++++++++++++-----------
 arch/powerpc/platforms/85xx/Kconfig       |    1 +
 arch/powerpc/platforms/85xx/mpc8544_ds.c  |  241 +++++++++++++++++++++-
 arch/powerpc/sysdev/fsl_pci.c             |    2 +
 5 files changed, 662 insertions(+), 126 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 8285925..4a900c6 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -137,6 +137,217 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		pci@8000 {
+			compatible = "fsl,mpc8540-pci";
+			device_type = "pci";
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				/* IDSEL 0x11 J17 Slot 1 */
+				8800 0 0 1 &mpic 2 1
+				8800 0 0 2 &mpic 3 1
+				8800 0 0 3 &mpic 4 1
+				8800 0 0 4 &mpic 1 1
+
+				/* IDSEL 0x12 J16 Slot 2 */
+
+				9000 0 0 1 &mpic 3 1
+				9000 0 0 2 &mpic 4 1
+				9000 0 0 3 &mpic 2 1
+				9000 0 0 4 &mpic 1 1>;
+
+			interrupt-parent = <&mpic>;
+			interrupts = <18 2>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 80000000 80000000 0 10000000
+				  01000000 0 00000000 e2000000 0 00800000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+		};
+
+		pcie@9000 {
+			compatible = "fsl,mpc8548-pcie";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <9000 1000>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 90000000 90000000 0 10000000
+				  01000000 0 00000000 e3000000 0 00800000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <1a 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 4 1
+				0000 0 0 2 &mpic 5 1
+				0000 0 0 3 &mpic 6 1
+				0000 0 0 4 &mpic 7 1
+				>;
+		};
+
+		pcie@a000 {
+			compatible = "fsl,mpc8548-pcie";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <a000 1000>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 a0000000 a0000000 0 10000000
+				  01000000 0 00000000 e2800000 0 00800000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <19 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+				/* IDSEL 0x0 */
+				0000 0 0 1 &mpic 0 1
+				0000 0 0 2 &mpic 1 1
+				0000 0 0 3 &mpic 2 1
+				0000 0 0 4 &mpic 3 1
+				>;
+		};
+
+		pcie@b000 {
+			compatible = "fsl,mpc8548-pcie";
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <b000 1000>;
+			bus-range = <0 ff>;
+			ranges = <02000000 0 b0000000 b0000000 0 10000000
+				  01000000 0 00000000 e3800000 0 00800000>;
+			clock-frequency = <1fca055>;
+			interrupt-parent = <&mpic>;
+			interrupts = <1b 2>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+				// IDSEL 0x1a
+				d000 0 0 1 &i8259 6 2
+				d000 0 0 2 &i8259 3 2
+				d000 0 0 3 &i8259 4 2
+				d000 0 0 4 &i8259 5 2
+
+				// IDSEL 0x1b
+				d800 0 0 1 &i8259 5 2
+				d800 0 0 2 &i8259 0 0
+				d800 0 0 3 &i8259 0 0
+				d800 0 0 4 &i8259 0 0
+
+				// IDSEL 0x1c  USB
+				e000 0 0 1 &i8259 9 2
+				e000 0 0 2 &i8259 a 2
+				e000 0 0 3 &i8259 c 2
+				e000 0 0 4 &i8259 7 2
+
+				// IDSEL 0x1d  Audio
+				e800 0 0 1 &i8259 9 2
+				e800 0 0 2 &i8259 a 2
+				e800 0 0 3 &i8259 b 2
+				e800 0 0 4 &i8259 0 0
+
+				// IDSEL 0x1e Legacy
+				f000 0 0 1 &i8259 c 2
+				f000 0 0 2 &i8259 0 0
+				f000 0 0 3 &i8259 0 0
+				f000 0 0 4 &i8259 0 0
+
+				// IDSEL 0x1f IDE/SATA
+				f800 0 0 1 &i8259 6 2
+				f800 0 0 2 &i8259 0 0
+				f800 0 0 3 &i8259 0 0
+				f800 0 0 4 &i8259 0 0
+			>;
+			uli1575@0 {
+				reg = <0 0 0 0 0>;
+				#size-cells = <2>;
+				#address-cells = <3>;
+				ranges = <02000000 0 b0000000
+					  02000000 0 b0000000
+					  0 10000000
+					  01000000 0 00000000
+					  01000000 0 00000000
+					  0 00080000>;
+
+				pci_bridge@0 {
+					reg = <0 0 0 0 0>;
+					#size-cells = <2>;
+					#address-cells = <3>;
+					ranges = <02000000 0 b0000000
+						  02000000 0 b0000000
+						  0 20000000
+						  01000000 0 00000000
+						  01000000 0 00000000
+						  0 00100000>;
+
+					isa@1e {
+						device_type = "isa";
+						#interrupt-cells = <2>;
+						#size-cells = <1>;
+						#address-cells = <2>;
+						reg = <f000 0 0 0 0>;
+						ranges = <1 0 01000000 0 0
+							  00001000>;
+						interrupt-parent = <&i8259>;
+
+						i8259: interrupt-controller@20 {
+							reg = <1 20 2
+							       1 a0 2
+							       1 4d0 2>;
+							clock-frequency = <0>;
+							interrupt-controller;
+							device_type = "interrupt-controller";
+							#address-cells = <0>;
+							#interrupt-cells = <2>;
+							built-in;
+							compatible = "chrp,iic";
+							interrupts = <9 2>;
+							interrupt-parent =
+								<&mpic>;
+						};
+
+						i8042@60 {
+							#size-cells = <0>;
+							#address-cells = <1>;
+							reg = <1 60 1 1 64 1>;
+							interrupts = <1 3 c 3>;
+							interrupt-parent =
+								<&i8259>;
+
+							keyboard@0 {
+								reg = <0>;
+								compatible = "pnpPNP,303";
+							};
+
+							mouse@1 {
+								reg = <1>;
+								compatible = "pnpPNP,f03";
+							};
+						};
+
+						rtc@70 {
+							compatible =
+								"pnpPNP,b00";
+							reg = <1 70 2>;
+						};
+
+						gpio@400 {
+							reg = <1 400 80>;
+						};
+					};
+				};
+			};
+
+		};
+
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
diff --git a/arch/powerpc/configs/mpc8544_ds_defconfig b/arch/powerpc/configs/mpc8544_ds_defconfig
index c40a25a..7995231 100644
--- a/arch/powerpc/configs/mpc8544_ds_defconfig
+++ b/arch/powerpc/configs/mpc8544_ds_defconfig
@@ -1,9 +1,26 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:56:58 2007
+# Linux kernel version: 2.6.22
+# Fri Jul 20 14:09:13 2007
 #
 # CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_6xx is not set
+CONFIG_PPC_85xx=y
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_85xx=y
+CONFIG_E500=y
+CONFIG_BOOKE=y
+CONFIG_FSL_BOOKE=y
+# CONFIG_PHYS_64BIT is not set
+# CONFIG_SPE is not set
+# CONFIG_PPC_MM_SLICES is not set
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -14,6 +31,7 @@ CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_GENERIC_NVRAM=y
@@ -25,28 +43,8 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_82xx is not set
-# CONFIG_PPC_83xx is not set
-CONFIG_PPC_85xx=y
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_85xx=y
-CONFIG_E500=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-CONFIG_BOOKE=y
-CONFIG_FSL_BOOKE=y
-# CONFIG_PHYS_64BIT is not set
-# CONFIG_SPE is not set
-# CONFIG_PPC_MM_SLICES is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -63,13 +61,12 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-CONFIG_IPC_NS=y
 CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 # CONFIG_BSD_PROCESS_ACCT_V3 is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 CONFIG_AUDIT=y
 # CONFIG_AUDITSYSCALL is not set
 CONFIG_IKCONFIG=y
@@ -86,7 +83,7 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
-# CONFIG_HOTPLUG is not set
+CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
@@ -105,24 +102,17 @@ CONFIG_SLAB=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 CONFIG_LBD=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
 
 #
 # IO Schedulers
@@ -153,7 +143,7 @@ CONFIG_MPC8544_DS=y
 CONFIG_MPC85xx=y
 CONFIG_MPIC=y
 # CONFIG_MPIC_WEIRD is not set
-# CONFIG_PPC_I8259 is not set
+CONFIG_PPC_I8259=y
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
 # CONFIG_PPC_MPC106 is not set
@@ -191,6 +181,8 @@ CONFIG_FLAT_NODE_MEM_MAP=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="root=/dev/sda3 rw console=ttyS0,115200"
@@ -205,15 +197,21 @@ CONFIG_ISA_DMA_API=y
 #
 CONFIG_ZONE_DMA=y
 CONFIG_PPC_INDIRECT_PCI=y
-CONFIG_PPC_INDIRECT_PCI_BE=y
 CONFIG_FSL_SOC=y
-# CONFIG_PCI is not set
-# CONFIG_PCI_DOMAINS is not set
-# CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_FSL_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
+# CONFIG_PCI_DEBUG is not set
 
 #
 # PCCARD (PCMCIA/CardBus) support
 #
+# CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
 
 #
 # Advanced setup
@@ -254,7 +252,6 @@ CONFIG_ASK_IP_FIB_HASH=y
 CONFIG_IP_FIB_HASH=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_ROUTE_MULTIPATH=y
-# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
 CONFIG_IP_ROUTE_VERBOSE=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
@@ -330,6 +327,7 @@ CONFIG_FIB_RULES=y
 # CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -340,45 +338,35 @@ CONFIG_FIB_RULES=y
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
 # CONFIG_MTD is not set
-
-#
-# Parallel port support
-#
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
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=y
+# CONFIG_BLK_DEV_SX8 is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-
-#
-# Misc devices
-#
-# CONFIG_BLINK is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_PHANTOM is not set
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
 # CONFIG_IDE is not set
 
 #
@@ -386,6 +374,7 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
 # CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
@@ -422,25 +411,120 @@ CONFIG_SCSI_WAIT_SCAN=m
 # SCSI low-level drivers
 #
 # CONFIG_ISCSI_TCP is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ARCMSR is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_HPTIOP is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SVW is not set
+# CONFIG_ATA_PIIX is not set
+# CONFIG_SATA_MV is not set
+# CONFIG_SATA_NV is not set
+# CONFIG_PDC_ADMA is not set
+# CONFIG_SATA_QSTOR is not set
+# CONFIG_SATA_PROMISE is not set
+# CONFIG_SATA_SX4 is not set
+# CONFIG_SATA_SIL is not set
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_SIS is not set
+# CONFIG_SATA_ULI is not set
+# CONFIG_SATA_VIA is not set
+# CONFIG_SATA_VITESSE is not set
+# CONFIG_SATA_INIC162X is not set
+# CONFIG_PATA_ALI is not set
+# CONFIG_PATA_AMD is not set
+# CONFIG_PATA_ARTOP is not set
+# CONFIG_PATA_ATIIXP is not set
+# CONFIG_PATA_CMD640_PCI is not set
+# CONFIG_PATA_CMD64X is not set
+# CONFIG_PATA_CS5520 is not set
+# CONFIG_PATA_CS5530 is not set
+# CONFIG_PATA_CYPRESS is not set
+# CONFIG_PATA_EFAR is not set
+# CONFIG_ATA_GENERIC is not set
+# CONFIG_PATA_HPT366 is not set
+# CONFIG_PATA_HPT37X is not set
+# CONFIG_PATA_HPT3X2N is not set
+# CONFIG_PATA_HPT3X3 is not set
+# CONFIG_PATA_IT821X is not set
+# CONFIG_PATA_IT8213 is not set
+# CONFIG_PATA_JMICRON is not set
+# CONFIG_PATA_TRIFLEX is not set
+# CONFIG_PATA_MARVELL is not set
+# CONFIG_PATA_MPIIX is not set
+# CONFIG_PATA_OLDPIIX is not set
+# CONFIG_PATA_NETCELL is not set
+# CONFIG_PATA_NS87410 is not set
+# CONFIG_PATA_OPTI is not set
+# CONFIG_PATA_OPTIDMA is not set
+# CONFIG_PATA_PDC_OLD is not set
+# CONFIG_PATA_RADISYS is not set
+# CONFIG_PATA_RZ1000 is not set
+# CONFIG_PATA_SC1200 is not set
+# CONFIG_PATA_SERVERWORKS is not set
+# CONFIG_PATA_PDC2027X is not set
+# CONFIG_PATA_SIL680 is not set
+# CONFIG_PATA_SIS is not set
+# CONFIG_PATA_VIA is not set
+# CONFIG_PATA_WINBOND is not set
 # CONFIG_PATA_PLATFORM is not set
+# CONFIG_MD is not set
 
 #
-# Multi-device support (RAID and LVM)
+# Fusion MPT device support
 #
-# CONFIG_MD is not set
-# CONFIG_MACINTOSH_DRIVERS is not set
+# CONFIG_FUSION is not set
+# CONFIG_FUSION_SPI is not set
+# CONFIG_FUSION_FC is not set
+# CONFIG_FUSION_SAS is not set
 
 #
-# Network device support
+# IEEE 1394 (FireWire) support
 #
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_ARCNET is not set
 CONFIG_PHYLIB=y
 
 #
@@ -454,17 +538,44 @@ CONFIG_PHYLIB=y
 CONFIG_VITESSE_PHY=y
 # CONFIG_SMSC_PHY is not set
 # CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
 # CONFIG_FIXED_PHY is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
 CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
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
@@ -472,21 +583,16 @@ CONFIG_NETDEV_10000=y
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
 # CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
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
@@ -521,6 +627,7 @@ CONFIG_INPUT=y
 CONFIG_SERIO=y
 CONFIG_SERIO_I8042=y
 CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_PCIPS2 is not set
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
@@ -539,6 +646,7 @@ CONFIG_HW_CONSOLE=y
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=y
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
@@ -550,14 +658,11 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 # CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
 # CONFIG_SERIAL_OF_PLATFORM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
@@ -565,12 +670,12 @@ CONFIG_NVRAM=y
 CONFIG_GEN_RTC=y
 CONFIG_GEN_RTC_X=y
 # CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
 # CONFIG_I2C is not set
 
 #
@@ -578,11 +683,8 @@ CONFIG_GEN_RTC_X=y
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 
 #
@@ -655,19 +757,14 @@ CONFIG_DUMMY_CONSOLE=y
 # Sound
 #
 # CONFIG_SOUND is not set
-
-#
-# HID Devices
-#
+CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
-
-#
-# USB support
-#
-# CONFIG_USB_ARCH_HAS_HCD is not set
-# CONFIG_USB_ARCH_HAS_OHCI is not set
-# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+# CONFIG_USB is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -691,14 +788,7 @@ CONFIG_HID=y
 #
 # LED Triggers
 #
-
-#
-# InfiniBand support
-#
-
-#
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
-#
+# CONFIG_INFINIBAND is not set
 
 #
 # Real Time Clock
@@ -719,19 +809,13 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_TEST is not set
 
 #
-# I2C RTC drivers
-#
-
-#
-# SPI RTC drivers
-#
-
-#
 # Platform RTC drivers
 #
+# CONFIG_RTC_DRV_CMOS is not set
 # CONFIG_RTC_DRV_DS1553 is not set
 # CONFIG_RTC_DRV_DS1742 is not set
 # CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
 # CONFIG_RTC_DRV_V3020 is not set
 
 #
@@ -752,6 +836,11 @@ CONFIG_RTC_INTF_DEV=y
 #
 
 #
+# Userspace I/O
+#
+# CONFIG_UIO is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -859,7 +948,6 @@ CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -941,6 +1029,7 @@ CONFIG_BITREVERSE=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_PLIST=y
@@ -965,6 +1054,7 @@ CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
@@ -996,10 +1086,6 @@ CONFIG_FORCED_INLINING=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
@@ -1038,7 +1124,4 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_CRYPTO_HW=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 4661fcc..99bb74d 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -30,6 +30,7 @@ config MPC85xx_MDS
 
 config MPC8544_DS
 	bool "Freescale MPC8544 DS"
+	select PPC_I8259
 	select DEFAULT_UIMAGE
 	help
 	  This option enables support for the MPC8544 DS board
diff --git a/arch/powerpc/platforms/85xx/mpc8544_ds.c b/arch/powerpc/platforms/85xx/mpc8544_ds.c
index 6fb90aa..4905f6f 100644
--- a/arch/powerpc/platforms/85xx/mpc8544_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8544_ds.c
@@ -2,6 +2,8 @@
  * MPC8544 DS Board Setup
  *
  * Author Xianghua Xiao (x.xiao@freescale.com)
+ * Roy Zang <tie-fei.zang@freescale.com>
+ * 	- Add PCI/PCI Exprees support
  * Copyright 2007 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
@@ -12,13 +14,16 @@
 
 #include <linux/stddef.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
+#include <linux/interrupt.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
 #include <asm/machdep.h>
+#include <asm/pci-bridge.h>
 #include <asm/mpc85xx.h>
 #include <mm/mmu_decl.h>
 #include <asm/prom.h>
@@ -27,6 +32,7 @@
 #include <asm/i8259.h>
 
 #include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
 #include "mpc85xx.h"
 
 #undef DEBUG
@@ -37,6 +43,17 @@
 #define DBG(fmt, args...)
 #endif
 
+#ifdef CONFIG_PPC_I8259
+static void mpc8544_8259_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int cascade_irq = i8259_irq();
+
+	if (cascade_irq != NO_IRQ) {
+		generic_handle_irq(cascade_irq);
+	}
+	desc->chip->eoi(irq);
+}
+#endif	/* CONFIG_PPC_I8259 */
 
 void __init mpc8544_ds_pic_init(void)
 {
@@ -96,19 +113,240 @@ void __init mpc8544_ds_pic_init(void)
 #endif	/* CONFIG_PPC_I8259 */
 }
 
+#ifdef CONFIG_PCI
+enum pirq { PIRQA = 8, PIRQB, PIRQC, PIRQD, PIRQE, PIRQF, PIRQG, PIRQH };
+
+/*
+ * Value in  table -- IRQ number
+ */
+const unsigned char uli1575_irq_route_table[16] = {
+	0,		/* 0: Reserved */
+	0x8,
+	0,		/* 2: Reserved */
+	0x2,
+	0x4,
+	0x5,
+	0x7,
+	0x6,
+	0,		/* 8: Reserved */
+	0x1,
+	0x3,
+	0x9,
+	0xb,
+	0,		/* 13: Reserved */
+	0xd,
+	0xf,
+};
+
+static int __devinit
+get_pci_irq_from_of(struct pci_controller *hose, int slot, int pin)
+{
+	struct of_irq oirq;
+	u32 laddr[3];
+	struct device_node *hosenode = hose ? hose->arch_data : NULL;
+
+	if (!hosenode)
+		return -EINVAL;
+
+	laddr[0] = (hose->first_busno << 16) | (PCI_DEVFN(slot, 0) << 8);
+	laddr[1] = laddr[2] = 0;
+	of_irq_map_raw(hosenode, &pin, 1, laddr, &oirq);
+	DBG("mpc8544_ds: pci irq addr %x, slot %d, pin %d, irq %d\n",
+	    laddr[0], slot, pin, oirq.specifier[0]);
+	return oirq.specifier[0];
+}
+
+/*8259*/
+static void __devinit quirk_uli1575(struct pci_dev *dev)
+{
+	unsigned short temp;
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	unsigned char irq2pin[16];
+	unsigned long pirq_map_word = 0;
+	u32 irq;
+	int i;
+
+	/*
+	 * ULI1575 interrupts route setup
+	 */
+	memset(irq2pin, 0, 16);	/* Initialize default value 0 */
+
+	irq2pin[6]=PIRQA+3;	/* enabled mapping for IRQ6 to PIRQD, used by SATA */
+
+	/*
+	 * PIRQE -> PIRQF mapping set manually
+	 *
+	 * IRQ pin   IRQ#
+	 * PIRQE ---- 9
+	 * PIRQF ---- 10
+	 * PIRQG ---- 11
+	 * PIRQH ---- 12
+	 */
+	for (i = 0; i < 4; i++)
+		irq2pin[i + 9] = PIRQE + i;
+
+	/* Set IRQ-PIRQ Mapping to ULI1575 */
+	for (i = 0; i < 16; i++)
+		if (irq2pin[i])
+			pirq_map_word |= (uli1575_irq_route_table[i] & 0xf)
+			    << ((irq2pin[i] - PIRQA) * 4);
+
+	pirq_map_word |= 1<<26;	/* disable INTx in EP mode*/
+
+	/* ULI1575 IRQ mapping conf register default value is 0xb9317542 */
+	DBG("Setup ULI1575 IRQ mapping configuration register value = 0x%x\n",
+		(int)pirq_map_word);
+	pci_write_config_dword(dev, 0x48, pirq_map_word);
+
+#define ULI1575_SET_DEV_IRQ(slot, pin, reg)				\
+	do {								\
+		int irq;						\
+		irq = get_pci_irq_from_of(hose, slot, pin);		\
+		if (irq > 0 && irq < 16) 				\
+			pci_write_config_byte(dev, reg, irq2pin[irq]);	\
+		else							\
+			printk(KERN_WARNING "ULI1575 device"		\
+				"(slot %d, pin %d) irq %d is invalid.\n", \
+				slot, pin, irq);			\
+	} while(0)
+
+	/* USB 1.1 OHCI controller 1, slot 28, pin 1 */
+	ULI1575_SET_DEV_IRQ(28, 1, 0x86);
+
+	/* USB 1.1 OHCI controller 2, slot 28, pin 2 */
+	ULI1575_SET_DEV_IRQ(28, 2, 0x87);
+
+	/* USB 1.1 OHCI controller 3, slot 28, pin 3 */
+	ULI1575_SET_DEV_IRQ(28, 3, 0x88);
+
+	/* USB 2.0 controller, slot 28, pin 4 */
+	irq = get_pci_irq_from_of(hose, 28, 4);
+	if (irq >= 0 && irq <= 15)
+		pci_write_config_dword(dev, 0x74, uli1575_irq_route_table[irq]);
+
+	/* Audio controller, slot 29, pin 1 */
+	ULI1575_SET_DEV_IRQ(29, 1, 0x8a);
+
+	/* Modem controller, slot 29, pin 2 */
+	ULI1575_SET_DEV_IRQ(29, 2, 0x8b);
+
+	/* HD audio controller, slot 29, pin 3 */
+	ULI1575_SET_DEV_IRQ(29, 3, 0x8c);
+
+	/* SMB interrupt: slot 30, pin 1 */
+	ULI1575_SET_DEV_IRQ(30, 1, 0x8e);
+
+	/* PMU ACPI SCI interrupt: slot 30, pin 2 */
+	ULI1575_SET_DEV_IRQ(30, 2, 0x8f);
+
+	/* Serial ATA interrupt: slot 31, pin 1 */
+	ULI1575_SET_DEV_IRQ(31, 1, 0x8d);
+
+	/* Primary PATA IDE IRQ: 14
+	 * Secondary PATA IDE IRQ: 15
+	 */
+	pci_write_config_byte(dev, 0x44, 0x30 | uli1575_irq_route_table[14]);
+	pci_write_config_byte(dev, 0x75, uli1575_irq_route_table[15]);
+
+	/* Set IRQ14 and IRQ15 to legacy IRQs */
+	pci_read_config_word(dev, 0x46, &temp);
+	temp |= 0xc000;
+	pci_write_config_word(dev, 0x46, temp);
+
+	/* Set i8259 interrupt trigger
+	 * IRQ 3:  Level
+	 * IRQ 4:  Level
+	 * IRQ 5:  Level
+	 * IRQ 6:  Level
+	 * IRQ 7:  Level
+	 * IRQ 9:  Level
+	 * IRQ 10: Level
+	 * IRQ 11: Level
+	 * IRQ 12: Level
+	 * IRQ 14: Edge
+	 * IRQ 15: Edge
+	 */
+	outb(0xfa, 0x4d0);
+	outb(0x1e, 0x4d1);
+
+#undef ULI1575_SET_DEV_IRQ
+}
+
+/* SATA */
+static void __devinit quirk_uli5288(struct pci_dev *dev)
+{
+	unsigned char c;
+
+	pci_read_config_byte(dev, 0x83, &c);
+	c |= 0x80;		/* read/write lock */
+	pci_write_config_byte(dev, 0x83, c);
+
+	pci_write_config_byte(dev, 0x09, 0x01);	/* Base class code: storage */
+	pci_write_config_byte(dev, 0x0a, 0x06);	/* IDE disk */
+
+	pci_read_config_byte(dev, 0x83, &c);
+	c &= 0x7f;
+	pci_write_config_byte(dev, 0x83, c);
+
+	pci_read_config_byte(dev, 0x84, &c);
+	c |= 0x01;				/* emulated PATA mode enabled */
+	pci_write_config_byte(dev, 0x84, c);
+}
+
+/* PATA */
+static void __devinit quirk_uli5229(struct pci_dev *dev)
+{
+	unsigned short temp;
+	pci_write_config_word(dev, 0x04, 0x0405);	/* MEM IO MSI */
+	pci_read_config_word(dev, 0x4a, &temp);
+	temp |= 0x1000;				/* Enable Native IRQ 14/15 */
+	pci_write_config_word(dev, 0x4a, temp);
+}
+
+/*Bridge*/
+static void __devinit early_uli5249(struct pci_dev *dev)
+{
+	unsigned char temp;
+	pci_write_config_word(dev, 0x04, 0x0007);	/* mem access */
+	pci_read_config_byte(dev, 0x7c, &temp);
+	pci_write_config_byte(dev, 0x7c, 0x80);	/* R/W lock control */
+	pci_write_config_byte(dev, 0x09, 0x01);	/* set as pci-pci bridge */
+	pci_write_config_byte(dev, 0x7c, temp);	/* restore pci bus debug control */
+	dev->class |= 0x1;
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_uli1575);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
+#endif	/* CONFIG_PCI */
 
 /*
  * Setup the architecture
  */
 static void __init mpc8544_ds_setup_arch(void)
 {
+#ifdef CONFIG_PCI
+	struct device_node *np;
+#endif
+
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8544_ds_setup_arch()", 0);
 
+#ifdef CONFIG_PCI
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
+		struct resource rsrc;
+		of_address_to_resource(np, 0, &rsrc);
+		if ((rsrc.start & 0xfffff) == 0xb000)
+			fsl_add_bridge(np, 1);
+		else
+			fsl_add_bridge(np, 0);
+	}
+#endif
+
 	printk("MPC8544 DS board from Freescale Semiconductor\n");
 }
 
-
 /*
  * Called very early, device-tree isn't unflattened
  */
@@ -124,6 +362,7 @@ define_machine(mpc8544_ds) {
 	.probe			= mpc8544_ds_probe,
 	.setup_arch		= mpc8544_ds_setup_arch,
 	.init_IRQ		= mpc8544_ds_pic_init,
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.get_irq		= mpic_get_irq,
 	.restart		= mpc85xx_restart,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 1426642..f51fedf 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -226,5 +226,7 @@ DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0020, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0021, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0024, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0025, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0030, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, 0x0031, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7010, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, 0x7011, quirk_fsl_pcie_transparent);
-- 
1.5.2.2

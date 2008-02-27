Return-Path: <John.Linn@xilinx.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5EAD1DDE29
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 10:15:30 +1100 (EST)
Received: from outbound5-dub.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound5-dub-R.bigfish.com (Postfix) with ESMTP id 997541342C93
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 23:15:26 +0000 (UTC)
Received: from mail124-dub-R.bigfish.com (unknown [10.5.252.3])
	by outbound5-dub.bigfish.com (Postfix) with ESMTP id 7B69F1F0057
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 23:15:26 +0000 (UTC)
Received: from mail124-dub (localhost.localdomain [127.0.0.1])
	by mail124-dub-R.bigfish.com (Postfix) with ESMTP id D0421EE832A
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 23:15:24 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail124-dub.bigfish.com (Postfix) with ESMTP id 4673DE3006A
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 23:15:21 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com) by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <John.Linn@xilinx.com>) id 1JUVUe-0001n8-0d
	for linuxppc-dev@ozlabs.org; Wed, 27 Feb 2008 15:15:20 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: FW: [PATCH] Xilinx: BSP: Updated ML405 to match hardware used for
	testing
Date: Wed, 27 Feb 2008 16:15:18 -0700
From: "John Linn" <John.Linn@xilinx.com>
To: <linuxppc-dev@ozlabs.org>,
	"git-dev" <git-dev@xilinx.com>
Message-Id: <20080227231521.4673DE3006A@mail124-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The default config file for the ML405 and the xparameters*.h file
were updated to match the hardware used for testing. The platform
data in virtex_devices.c was updated for the LL TEMAC driver
which now uses the dcr_host field to determine if it should use
DCR for the DMA.

Signed-off-by: John Linn <john.linn>
---
 arch/ppc/configs/ml405_defconfig                   |  130 +++--
 .../platforms/4xx/xparameters/xparameters_ml405.h  |  649
+++++++++-----------
 arch/ppc/syslib/virtex_devices.c                   |    2 +-
 3 files changed, 373 insertions(+), 408 deletions(-)
 mode change 100644 =3D> 100755
arch/ppc/platforms/4xx/xparameters/xparameters_ml405.h

diff --git a/arch/ppc/configs/ml405_defconfig
b/arch/ppc/configs/ml405_defconfig
index feebe65..e5635cb 100644
--- a/arch/ppc/configs/ml405_defconfig
+++ b/arch/ppc/configs/ml405_defconfig
@@ -1,8 +1,9 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23xlnx
-# Mon Dec 17 15:41:58 2007
+# Linux kernel version: 2.6.24-rc8-xlnx
+# Tue Feb 26 15:08:13 2008
 #
+CONFIG_WORD_SIZE=3D32
 CONFIG_MMU=3Dy
 CONFIG_GENERIC_HARDIRQS=3Dy
 CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
@@ -35,9 +36,14 @@ CONFIG_BSD_PROCESS_ACCT=3Dy
 CONFIG_BSD_PROCESS_ACCT_V3=3Dy
 # CONFIG_TASKSTATS is not set
 # CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=3D14
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=3Dy
+CONFIG_FAIR_USER_SCHED=3Dy
+# CONFIG_FAIR_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=3Dy
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=3Dy
@@ -64,6 +70,7 @@ CONFIG_VM_EVENT_COUNTERS=3Dy
 CONFIG_SLAB=3Dy
 # CONFIG_SLUB is not set
 # CONFIG_SLOB is not set
+CONFIG_SLABINFO=3Dy
 CONFIG_RT_MUTEXES=3Dy
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=3D0
@@ -157,6 +164,7 @@ CONFIG_FLATMEM_MANUAL=3Dy
 CONFIG_FLATMEM=3Dy
 CONFIG_FLAT_NODE_MEM_MAP=3Dy
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_SPLIT_PTLOCK_CPUS=3D4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=3D1
@@ -165,10 +173,7 @@ CONFIG_VIRT_TO_BUS=3Dy
 CONFIG_BINFMT_ELF=3Dy
 # CONFIG_BINFMT_MISC is not set
 CONFIG_CMDLINE_BOOL=3Dy
-CONFIG_CMDLINE=3D"console=3DttyS0,9600 ip=3Ddhcp root=3D/dev/nfs rw"
-# CONFIG_PM is not set
-CONFIG_SUSPEND_UP_POSSIBLE=3Dy
-CONFIG_HIBERNATION_UP_POSSIBLE=3Dy
+CONFIG_CMDLINE=3D"console=3DttyS0,9600 ip=3Don root=3D/dev/ram"
 CONFIG_SECCOMP=3Dy
 CONFIG_ISA_DMA_API=3Dy
=20
@@ -181,10 +186,6 @@ CONFIG_ZONE_DMA=3Dy
 # CONFIG_PCI_DOMAINS is not set
 # CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
 # CONFIG_PCCARD is not set
=20
 #
@@ -239,6 +240,7 @@ CONFIG_IP_PNP_DHCP=3Dy
 CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy
 CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
 CONFIG_INET_XFRM_MODE_BEET=3Dy
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=3Dy
 CONFIG_INET_TCP_DIAG=3Dy
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -264,10 +266,6 @@ CONFIG_DEFAULT_TCP_CONG=3D"cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set
=20
 #
@@ -296,6 +294,7 @@ CONFIG_DEFAULT_TCP_CONG=3D"cubic"
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
 CONFIG_STANDALONE=3Dy
 CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
 # CONFIG_FW_LOADER is not set
@@ -321,6 +320,7 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=3D1024
 CONFIG_MISC_DEVICES=3Dy
 # CONFIG_EEPROM_93CX6 is not set
 CONFIG_XILINX_DRIVERS=3Dy
+CONFIG_NEED_XILINX_LLDMA=3Dy
 CONFIG_NEED_XILINX_IPIF=3Dy
 # CONFIG_IDE is not set
=20
@@ -341,15 +341,21 @@ CONFIG_NETDEVICES=3Dy
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 CONFIG_TUN=3Dy
+# CONFIG_VETH is not set
 # CONFIG_PHYLIB is not set
 CONFIG_NET_ETHERNET=3Dy
 # CONFIG_MII is not set
 # CONFIG_IBM_EMAC is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_B44 is not set
 CONFIG_XILINX_EMAC=3Dy
 # CONFIG_XILINX_EMACLITE is not set
 CONFIG_NETDEV_1000=3Dy
 # CONFIG_XILINX_TEMAC is not set
-# CONFIG_XILINX_LLTEMAC is not set
+CONFIG_XILINX_LLTEMAC=3Dy
 CONFIG_NETDEV_10000=3Dy
=20
 #
@@ -382,7 +388,6 @@ CONFIG_INPUT_MOUSEDEV=3Dy
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set
=20
@@ -423,13 +428,12 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
 #
 # Non-8250 serial port support
 #
+# CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=3Dy
 CONFIG_SERIAL_CORE_CONSOLE=3Dy
-# CONFIG_SERIAL_XILINX_UARTLITE is not set
 CONFIG_UNIX98_PTYS=3Dy
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=3Dm
 # CONFIG_NVRAM is not set
 # CONFIG_GEN_RTC is not set
@@ -438,7 +442,45 @@ CONFIG_HW_RANDOM=3Dm
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
+CONFIG_I2C=3Dy
+CONFIG_I2C_BOARDINFO=3Dy
+CONFIG_I2C_CHARDEV=3Dy
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+CONFIG_XILINX_IIC=3Dy
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_MPC is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_STUB is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
=20
 #
 # SPI support
@@ -448,6 +490,13 @@ CONFIG_HW_RANDOM=3Dm
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=3Dy
+# CONFIG_SSB is not set
=20
 #
 # Multifunction device drivers
@@ -464,16 +513,15 @@ CONFIG_DAB=3Dy
 #
 # Graphics support
 #
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=3Dm
+# CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
=20
 #
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
-# CONFIG_VGASTATE is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=3Dm
-# CONFIG_FB is not set
-# CONFIG_FB_IBM_GXT4500 is not set
=20
 #
 # Console display driver support
@@ -487,6 +535,7 @@ CONFIG_DUMMY_CONSOLE=3Dy
 CONFIG_HID_SUPPORT=3Dy
 CONFIG_HID=3Dy
 CONFIG_HID_DEBUG=3Dy
+# CONFIG_HIDRAW is not set
 CONFIG_USB_SUPPORT=3Dy
 # CONFIG_USB_ARCH_HAS_HCD is not set
 # CONFIG_USB_ARCH_HAS_OHCI is not set
@@ -504,19 +553,6 @@ CONFIG_USB_SUPPORT=3Dy
 # CONFIG_NEW_LEDS is not set
 # CONFIG_EDAC is not set
 # CONFIG_RTC_CLASS is not set
-
-#
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
 CONFIG_XILINX_EDK=3Dy
=20
 #
@@ -574,7 +610,6 @@ CONFIG_SYSFS=3Dy
 CONFIG_TMPFS=3Dy
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=3Dy
 # CONFIG_CONFIGFS_FS is not set
=20
 #
@@ -593,10 +628,7 @@ CONFIG_RAMFS=3Dy
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=3Dy
 CONFIG_NFS_FS=3Dy
 CONFIG_NFS_V3=3Dy
 # CONFIG_NFS_V3_ACL is not set
@@ -622,10 +654,6 @@ CONFIG_SUNRPC=3Dy
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=3Dy
-
-#
-# Native Language Support
-#
 CONFIG_NLS=3Dy
 CONFIG_NLS_DEFAULT=3D"iso8859-1"
 CONFIG_NLS_CODEPAGE_437=3Dy
@@ -666,10 +694,6 @@ CONFIG_NLS_ISO8859_1=3Dy
 # CONFIG_NLS_KOI8_R is not set
 # CONFIG_NLS_KOI8_U is not set
 CONFIG_NLS_UTF8=3Dy
-
-#
-# Distributed Lock Manager
-#
 # CONFIG_DLM is not set
=20
 #
@@ -690,12 +714,16 @@ CONFIG_PLIST=3Dy
 CONFIG_HAS_IOMEM=3Dy
 CONFIG_HAS_IOPORT=3Dy
 CONFIG_HAS_DMA=3Dy
+CONFIG_INSTRUMENTATION=3Dy
 # CONFIG_PROFILING is not set
+# CONFIG_KPROBES is not set
+# CONFIG_MARKERS is not set
=20
 #
 # Kernel hacking
 #
 CONFIG_PRINTK_TIME=3Dy
+CONFIG_ENABLE_WARN_DEPRECATED=3Dy
 CONFIG_ENABLE_MUST_CHECK=3Dy
 CONFIG_MAGIC_SYSRQ=3Dy
 # CONFIG_UNUSED_SYMBOLS is not set
@@ -719,9 +747,12 @@ CONFIG_DEBUG_BUGVERBOSE=3Dy
 CONFIG_DEBUG_INFO=3Dy
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
 CONFIG_FORCED_INLINING=3Dy
+# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
 # CONFIG_KGDB is not set
 # CONFIG_XMON is not set
 # CONFIG_BDI_SWITCH is not set
@@ -732,4 +763,5 @@ CONFIG_FORCED_INLINING=3Dy
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 # CONFIG_CRYPTO is not set
diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters_ml405.h
b/arch/ppc/platforms/4xx/xparameters/xparameters_ml405.h
old mode 100644
new mode 100755
index f1fabbd..bf41056
--- a/arch/ppc/platforms/4xx/xparameters/xparameters_ml405.h
+++ b/arch/ppc/platforms/4xx/xparameters/xparameters_ml405.h
@@ -1,358 +1,291 @@
-
-/*******************************************************************
-*
-* CAUTION: This file is automatically generated by libgen.
-* Version: Xilinx EDK 9.2 EDK_Jm.16
-* DO NOT EDIT.
-*
-* Copyright (c) 2005 Xilinx, Inc.  All rights reserved.
-*
-* Description: Driver parameters
-*
-*******************************************************************/
-
-
-/* Definitions for peripheral PLB_BRAM_IF_CNTLR_0 */
-#define XPAR_PLB_BRAM_IF_CNTLR_0_BASEADDR 0xFFFF0000
-#define XPAR_PLB_BRAM_IF_CNTLR_0_HIGHADDR 0xFFFFFFFF
-
-
-/******************************************************************/
-
-
-/* Definitions for peripheral OPB_V20_0 */
-
-
-/* Definitions for peripheral OPB_EMC_0 */
-#define XPAR_OPB_EMC_0_MEM0_BASEADDR 0x20000000
-#define XPAR_OPB_EMC_0_MEM0_HIGHADDR 0x200FFFFF
-#define XPAR_OPB_EMC_0_MEM1_BASEADDR 0x28000000
-#define XPAR_OPB_EMC_0_MEM1_HIGHADDR 0x287FFFFF
-
-
-/* Definitions for peripheral OPB_AC97_CONTROLLER_REF_0 */
-#define XPAR_OPB_AC97_CONTROLLER_REF_0_BASEADDR 0xA6000000
-#define XPAR_OPB_AC97_CONTROLLER_REF_0_HIGHADDR 0xA60000FF
-
-
-/* Definitions for peripheral OPB_EMC_USB_0 */
-#define XPAR_OPB_EMC_USB_0_MEM0_BASEADDR 0xA5000000
-#define XPAR_OPB_EMC_USB_0_MEM0_HIGHADDR 0xA50000FF
-
-
-/* Definitions for peripheral PLB_DDR_0 */
-#define XPAR_PLB_DDR_0_MEM0_BASEADDR 0x00000000
-#define XPAR_PLB_DDR_0_MEM0_HIGHADDR 0x0FFFFFFF
-
-
-/******************************************************************/
-
-/* Definitions for driver EMAC */
-#define XPAR_XEMAC_NUM_INSTANCES 1
-
-/* Definitions for peripheral OPB_ETHERNET_0 */
-#define XPAR_OPB_ETHERNET_0_DEVICE_ID 0
-#define XPAR_OPB_ETHERNET_0_BASEADDR 0x60000000
-#define XPAR_OPB_ETHERNET_0_HIGHADDR 0x60003FFF
-#define XPAR_OPB_ETHERNET_0_ERR_COUNT_EXIST 1
-#define XPAR_OPB_ETHERNET_0_DMA_PRESENT 1
-#define XPAR_OPB_ETHERNET_0_MII_EXIST 1
-#define XPAR_OPB_ETHERNET_0_CAM_EXIST 0
-#define XPAR_OPB_ETHERNET_0_JUMBO_EXIST 0
-#define XPAR_OPB_ETHERNET_0_TX_DRE_TYPE 0
-#define XPAR_OPB_ETHERNET_0_RX_DRE_TYPE 0
-#define XPAR_OPB_ETHERNET_0_TX_INCLUDE_CSUM 0
-#define XPAR_OPB_ETHERNET_0_RX_INCLUDE_CSUM 0
-
-
-/******************************************************************/
-
-
-/* Canonical definitions for peripheral OPB_ETHERNET_0 */
-#define XPAR_EMAC_0_DEVICE_ID XPAR_OPB_ETHERNET_0_DEVICE_ID
-#define XPAR_EMAC_0_BASEADDR 0x60000000
-#define XPAR_EMAC_0_HIGHADDR 0x60003FFF
-#define XPAR_EMAC_0_ERR_COUNT_EXIST 1
-#define XPAR_EMAC_0_DMA_PRESENT 1
-#define XPAR_EMAC_0_MII_EXIST 1
-#define XPAR_EMAC_0_CAM_EXIST 0
-#define XPAR_EMAC_0_JUMBO_EXIST 0
-#define XPAR_EMAC_0_TX_DRE_TYPE 0
-#define XPAR_EMAC_0_RX_DRE_TYPE 0
-#define XPAR_EMAC_0_TX_INCLUDE_CSUM 0
-#define XPAR_EMAC_0_RX_INCLUDE_CSUM 0
-
-
-/******************************************************************/
-
-/* Definitions for driver UARTNS550 */
-#define XPAR_XUARTNS550_NUM_INSTANCES 1
-#define XPAR_XUARTNS550_CLOCK_HZ 100000000
-
-/* Definitions for peripheral OPB_UART16550_0 */
-#define XPAR_OPB_UART16550_0_DEVICE_ID 0
-#define XPAR_OPB_UART16550_0_BASEADDR 0xA0000000
-#define XPAR_OPB_UART16550_0_HIGHADDR 0xA0001FFF
-
-
-/******************************************************************/
-
-
-/* Canonical definitions for peripheral OPB_UART16550_0 */
-#define XPAR_UARTNS550_0_CLOCK_FREQ_HZ 100000000
-#define XPAR_UARTNS550_0_DEVICE_ID XPAR_OPB_UART16550_0_DEVICE_ID
-#define XPAR_UARTNS550_0_BASEADDR 0xA0000000
-#define XPAR_UARTNS550_0_HIGHADDR 0xA0001FFF
-
-
-/******************************************************************/
-
-/* Definitions for driver GPIO */
-#define XPAR_XGPIO_NUM_INSTANCES 3
-
-/* Definitions for peripheral OPB_GPIO_0 */
-#define XPAR_OPB_GPIO_0_BASEADDR 0x90000000
-#define XPAR_OPB_GPIO_0_HIGHADDR 0x900001FF
-#define XPAR_OPB_GPIO_0_DEVICE_ID 0
-#define XPAR_OPB_GPIO_0_INTERRUPT_PRESENT 0
-#define XPAR_OPB_GPIO_0_IS_DUAL 1
-
-
-/* Definitions for peripheral OPB_GPIO_EXP_HDR_0 */
-#define XPAR_OPB_GPIO_EXP_HDR_0_BASEADDR 0x90001000
-#define XPAR_OPB_GPIO_EXP_HDR_0_HIGHADDR 0x900011FF
-#define XPAR_OPB_GPIO_EXP_HDR_0_DEVICE_ID 1
-#define XPAR_OPB_GPIO_EXP_HDR_0_INTERRUPT_PRESENT 0
-#define XPAR_OPB_GPIO_EXP_HDR_0_IS_DUAL 1
-
-
-/* Definitions for peripheral OPB_GPIO_CHAR_LCD_0 */
-#define XPAR_OPB_GPIO_CHAR_LCD_0_BASEADDR 0x90002000
-#define XPAR_OPB_GPIO_CHAR_LCD_0_HIGHADDR 0x900021FF
-#define XPAR_OPB_GPIO_CHAR_LCD_0_DEVICE_ID 2
-#define XPAR_OPB_GPIO_CHAR_LCD_0_INTERRUPT_PRESENT 0
-#define XPAR_OPB_GPIO_CHAR_LCD_0_IS_DUAL 0
-
-
-/******************************************************************/
-
-#define XPAR_XPS2_NUM_INSTANCES 2
-#define XPAR_OPB_PS2_DUAL_REF_0_DEVICE_ID_0 0
-#define XPAR_OPB_PS2_DUAL_REF_0_BASEADDR_0 0xA9000000
-#define XPAR_OPB_PS2_DUAL_REF_0_HIGHADDR_0 (0xA9000000+0x3F)
-#define XPAR_OPB_PS2_DUAL_REF_0_DEVICE_ID_1 1
-#define XPAR_OPB_PS2_DUAL_REF_0_BASEADDR_1 (0xA9000000+0x1000)
-#define XPAR_OPB_PS2_DUAL_REF_0_HIGHADDR_1 (0xA9000000+0x103F)
-
-/******************************************************************/
-
-/* Definitions for driver IIC */
-#define XPAR_XIIC_NUM_INSTANCES 1
-
-/* Definitions for peripheral OPB_IIC_0 */
-#define XPAR_OPB_IIC_0_DEVICE_ID 0
-#define XPAR_OPB_IIC_0_BASEADDR 0xA8000000
-#define XPAR_OPB_IIC_0_HIGHADDR 0xA80001FF
-#define XPAR_OPB_IIC_0_TEN_BIT_ADR 0
-#define XPAR_OPB_IIC_0_GPO_WIDTH 1
-
-
-/******************************************************************/
-
-
-/* Canonical definitions for peripheral OPB_IIC_0 */
-#define XPAR_IIC_0_DEVICE_ID XPAR_OPB_IIC_0_DEVICE_ID
-#define XPAR_IIC_0_BASEADDR 0xA8000000
-#define XPAR_IIC_0_HIGHADDR 0xA80001FF
-#define XPAR_IIC_0_TEN_BIT_ADR 0
-#define XPAR_IIC_0_GPO_WIDTH 1
-
-
-/******************************************************************/
-
-#define XPAR_INTC_MAX_NUM_INTR_INPUTS 10
-#define XPAR_XINTC_HAS_IPR 1
-#define XPAR_XINTC_USE_DCR 0
-/* Definitions for driver INTC */
-#define XPAR_XINTC_NUM_INSTANCES 1
-
-/* Definitions for peripheral OPB_INTC_0 */
-#define XPAR_OPB_INTC_0_DEVICE_ID 0
-#define XPAR_OPB_INTC_0_BASEADDR 0xD1000FC0
-#define XPAR_OPB_INTC_0_HIGHADDR 0xD1000FDF
-#define XPAR_OPB_INTC_0_KIND_OF_INTR 0x00000000
-
-
-/******************************************************************/
-
-#define XPAR_INTC_SINGLE_BASEADDR 0xD1000FC0
-#define XPAR_INTC_SINGLE_HIGHADDR 0xD1000FDF
-#define XPAR_INTC_SINGLE_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID
-#define XPAR_OPB_ETHERNET_0_IP2INTC_IRPT_MASK 0X000001
-#define XPAR_OPB_INTC_0_OPB_ETHERNET_0_IP2INTC_IRPT_INTR 0
-#define XPAR_SYSTEM_USB_HPI_INT_MASK 0X000002
-#define XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT_INTR 1
-#define XPAR_MISC_LOGIC_0_PHY_MII_INT_MASK 0X000004
-#define XPAR_OPB_INTC_0_MISC_LOGIC_0_PHY_MII_INT_INTR 2
-#define XPAR_OPB_SYSACE_0_SYSACE_IRQ_MASK 0X000008
-#define XPAR_OPB_INTC_0_OPB_SYSACE_0_SYSACE_IRQ_INTR 3
-#define XPAR_OPB_AC97_CONTROLLER_REF_0_RECORD_INTERRUPT_MASK 0X000010
-#define XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_0_RECORD_INTERRUPT_INTR
4
-#define XPAR_OPB_AC97_CONTROLLER_REF_0_PLAYBACK_INTERRUPT_MASK 0X000020
-#define
XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_0_PLAYBACK_INTERRUPT_INTR 5
-#define XPAR_OPB_IIC_0_IP2INTC_IRPT_MASK 0X000040
-#define XPAR_OPB_INTC_0_OPB_IIC_0_IP2INTC_IRPT_INTR 6
-#define XPAR_OPB_PS2_DUAL_REF_0_SYS_INTR2_MASK 0X000080
-#define XPAR_OPB_INTC_0_OPB_PS2_DUAL_REF_0_SYS_INTR2_INTR 7
-#define XPAR_OPB_PS2_DUAL_REF_0_SYS_INTR1_MASK 0X000100
-#define XPAR_OPB_INTC_0_OPB_PS2_DUAL_REF_0_SYS_INTR1_INTR 8
-#define XPAR_OPB_UART16550_0_IP2INTC_IRPT_MASK 0X000200
-#define XPAR_OPB_INTC_0_OPB_UART16550_0_IP2INTC_IRPT_INTR 9
-
-/******************************************************************/
-
-
-/* Canonical definitions for peripheral OPB_INTC_0 */
-#define XPAR_INTC_0_DEVICE_ID XPAR_OPB_INTC_0_DEVICE_ID
-#define XPAR_INTC_0_BASEADDR 0xD1000FC0
-#define XPAR_INTC_0_HIGHADDR 0xD1000FDF
-#define XPAR_INTC_0_KIND_OF_INTR 0
-
-#define XPAR_INTC_0_EMAC_0_VEC_ID
XPAR_OPB_INTC_0_OPB_ETHERNET_0_IP2INTC_IRPT_INTR
-#define XPAR_INTC_0_SYSACE_0_VEC_ID
XPAR_OPB_INTC_0_OPB_SYSACE_0_SYSACE_IRQ_INTR
-#define XPAR_INTC_0_IIC_0_VEC_ID
XPAR_OPB_INTC_0_OPB_IIC_0_IP2INTC_IRPT_INTR
-#define XPAR_INTC_0_PS2_1_SYS_INTR2_VEC_ID
XPAR_OPB_INTC_0_OPB_PS2_DUAL_REF_0_SYS_INTR2_INTR
-#define XPAR_INTC_0_PS2_0_SYS_INTR1_VEC_ID
XPAR_OPB_INTC_0_OPB_PS2_DUAL_REF_0_SYS_INTR1_INTR
-#define XPAR_INTC_0_UARTNS550_0_VEC_ID
XPAR_OPB_INTC_0_OPB_UART16550_0_IP2INTC_IRPT_INTR
-
-#define XPAR_INTC_0_PS2_1_VEC_ID
XPAR_OPB_INTC_0_OPB_PS2_DUAL_REF_0_SYS_INTR2_INTR
-#define XPAR_INTC_0_PS2_0_VEC_ID
XPAR_OPB_INTC_0_OPB_PS2_DUAL_REF_0_SYS_INTR1_INTR
-
-/******************************************************************/
-
-/* Definitions for driver TFT_REF */
-#define XPAR_XTFT_NUM_INSTANCES 1
-
-/* Definitions for peripheral PLB_TFT_CNTLR_REF_0 */
-#define XPAR_PLB_TFT_CNTLR_REF_0_DCR_BASEADDR 0xD0000200
-#define XPAR_PLB_TFT_CNTLR_REF_0_DCR_HIGHADDR 0xD0000207
-#define XPAR_PLB_TFT_CNTLR_REF_0_DEVICE_ID 0
-
-
-/******************************************************************/
-
-#define XPAR_XSYSACE_MEM_WIDTH 16
-/* Definitions for driver SYSACE */
-#define XPAR_XSYSACE_NUM_INSTANCES 1
-
-/* Definitions for peripheral OPB_SYSACE_0 */
-#define XPAR_OPB_SYSACE_0_DEVICE_ID 0
-#define XPAR_OPB_SYSACE_0_BASEADDR 0xCF000000
-#define XPAR_OPB_SYSACE_0_HIGHADDR 0xCF0001FF
-#define XPAR_OPB_SYSACE_0_MEM_WIDTH 16
-
-
-/******************************************************************/
-
-
-/* Canonical definitions for peripheral OPB_SYSACE_0 */
-#define XPAR_SYSACE_0_DEVICE_ID XPAR_OPB_SYSACE_0_DEVICE_ID
-#define XPAR_SYSACE_0_BASEADDR 0xCF000000
-#define XPAR_SYSACE_0_HIGHADDR 0xCF0001FF
-#define XPAR_SYSACE_0_MEM_WIDTH 16
-
-
-/******************************************************************/
-
-#define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 300000000
-
-/******************************************************************/
-
-#define XPAR_CPU_ID 0
-#define XPAR_PPC405_VIRTEX4_ID 0
-#define XPAR_PPC405_VIRTEX4_CORE_CLOCK_FREQ_HZ 300000000
-#define XPAR_PPC405_VIRTEX4_IDCR_BASEADDR 0x00000100
-#define XPAR_PPC405_VIRTEX4_IDCR_HIGHADDR 0x0000010F
-#define XPAR_PPC405_VIRTEX4_DISABLE_OPERAND_FORWARDING 1
-#define XPAR_PPC405_VIRTEX4_MMU_ENABLE 1
-#define XPAR_PPC405_VIRTEX4_DETERMINISTIC_MULT 0
-#define XPAR_PPC405_VIRTEX4_PLBSYNCBYPASS 1
-#define XPAR_PPC405_VIRTEX4_APU_CONTROL 0b1101111000000000
-#define XPAR_PPC405_VIRTEX4_APU_UDI_1 0b101000011000100110000011
-#define XPAR_PPC405_VIRTEX4_APU_UDI_2 0b101000111000100110000011
-#define XPAR_PPC405_VIRTEX4_APU_UDI_3 0b101001011000100111000011
-#define XPAR_PPC405_VIRTEX4_APU_UDI_4 0b101001111000100111000011
-#define XPAR_PPC405_VIRTEX4_APU_UDI_5 0b101010011000110000000011
-#define XPAR_PPC405_VIRTEX4_APU_UDI_6 0b101010111000110000000011
-#define XPAR_PPC405_VIRTEX4_APU_UDI_7 0b101011011000110001000011
-#define XPAR_PPC405_VIRTEX4_APU_UDI_8 0b101011111000110001000011
-#define XPAR_PPC405_VIRTEX4_PVR_HIGH 0b0000
-#define XPAR_PPC405_VIRTEX4_PVR_LOW 0b0000
-#define XPAR_PPC405_VIRTEX4_HW_VER "1.01.a"
-
-/******************************************************************/
-
-
-/******************************************************************/
-
-/* Cannonical Constant Names */
-
-/******************************************************************/
-
-#undef XPAR_UARTNS550_0_BASEADDR
-#define XPAR_UARTNS550_0_BASEADDR
(XPAR_OPB_UART16550_0_BASEADDR+0x1000)
-
-/******************************************************************/
-
-#define XPAR_GPIO_0_BASEADDR XPAR_OPB_GPIO_0_BASEADDR
-#define XPAR_GPIO_0_HIGHADDR XPAR_OPB_GPIO_0_HIGHADDR
-#define XPAR_GPIO_0_IS_DUAL XPAR_OPB_GPIO_0_IS_DUAL
-#define XPAR_GPIO_0_DEVICE_ID XPAR_OPB_GPIO_0_DEVICE_ID
-#define XPAR_GPIO_1_BASEADDR XPAR_OPB_GPIO_0_BASEADDR
-#define XPAR_GPIO_1_HIGHADDR XPAR_OPB_GPIO_0_HIGHADDR
-#define XPAR_GPIO_1_IS_DUAL XPAR_OPB_GPIO_0_IS_DUAL
-#define XPAR_GPIO_1_DEVICE_ID XPAR_OPB_GPIO_0_DEVICE_ID
-#define XPAR_GPIO_2_BASEADDR XPAR_OPB_GPIO_EXP_HDR_0_BASEADDR
-#define XPAR_GPIO_2_HIGHADDR XPAR_OPB_GPIO_EXP_HDR_0_HIGHADDR
-#define XPAR_GPIO_2_IS_DUAL XPAR_OPB_GPIO_EXP_HDR_0_IS_DUAL
-#define XPAR_GPIO_2_DEVICE_ID XPAR_OPB_GPIO_EXP_HDR_0_DEVICE_ID
-#define XPAR_GPIO_3_BASEADDR XPAR_OPB_GPIO_EXP_HDR_0_BASEADDR
-#define XPAR_GPIO_3_HIGHADDR XPAR_OPB_GPIO_EXP_HDR_0_HIGHADDR
-#define XPAR_GPIO_3_IS_DUAL XPAR_OPB_GPIO_EXP_HDR_0_IS_DUAL
-#define XPAR_GPIO_3_DEVICE_ID XPAR_OPB_GPIO_EXP_HDR_0_DEVICE_ID
-#define XPAR_GPIO_4_BASEADDR XPAR_OPB_GPIO_CHAR_LCD_0_BASEADDR
-#define XPAR_GPIO_4_HIGHADDR XPAR_OPB_GPIO_CHAR_LCD_0_HIGHADDR
-#define XPAR_GPIO_4_IS_DUAL XPAR_OPB_GPIO_CHAR_LCD_0_IS_DUAL
-#define XPAR_GPIO_4_DEVICE_ID XPAR_OPB_GPIO_CHAR_LCD_0_DEVICE_ID
-
-/******************************************************************/
-
-#define XPAR_PS2_0_BASEADDR XPAR_OPB_PS2_DUAL_REF_0_BASEADDR_0
-#define XPAR_PS2_0_HIGHADDR XPAR_OPB_PS2_DUAL_REF_0_HIGHADDR_0
-#define XPAR_PS2_0_DEVICE_ID XPAR_OPB_PS2_DUAL_REF_0_DEVICE_ID_0
-#define XPAR_PS2_1_BASEADDR XPAR_OPB_PS2_DUAL_REF_0_BASEADDR_1
-#define XPAR_PS2_1_HIGHADDR XPAR_OPB_PS2_DUAL_REF_0_HIGHADDR_1
-#define XPAR_PS2_1_DEVICE_ID XPAR_OPB_PS2_DUAL_REF_0_DEVICE_ID_1
-
-/******************************************************************/
-
-#define XPAR_TFT_0_BASEADDR XPAR_PLB_TFT_CNTLR_REF_0_DCR_BASEADDR
-
-/******************************************************************/
-
-#define XPAR_PLB_CLOCK_FREQ_HZ 100000000
-#define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ
-#define XPAR_DDR_0_SIZE 0x4000000
-
-/******************************************************************/
-
-#define XPAR_PERSISTENT_0_IIC_0_BASEADDR 1024
-#define XPAR_PERSISTENT_0_IIC_0_HIGHADDR 2047
-#define XPAR_PERSISTENT_0_IIC_0_EEPROMADDR 0xA0
-
-/******************************************************************/
-
-#define XPAR_PCI_0_CLOCK_FREQ_HZ    0
-
-/******************************************************************/
-
+
+/*******************************************************************
+*
+* CAUTION: This file is automatically generated by libgen.
+* Version: Xilinx EDK 10.1.1 EDK_K_SP1.1
+* DO NOT EDIT.
+*
+* Copyright (c) 2005 Xilinx, Inc.  All rights reserved.=20
+*=20
+* Description: Driver parameters
+*
+*******************************************************************/
+
+#define STDIN_BASEADDRESS 0x83E00000
+#define STDOUT_BASEADDRESS 0x83E00000
+
+/******************************************************************/
+
+/* Definitions for peripheral XPS_BRAM_IF_CNTLR_1 */
+#define XPAR_XPS_BRAM_IF_CNTLR_1_BASEADDR 0xFFFFE000
+#define XPAR_XPS_BRAM_IF_CNTLR_1_HIGHADDR 0xFFFFFFFF
+
+
+/******************************************************************/
+
+/* Definitions for driver UARTNS550 */
+#define XPAR_XUARTNS550_NUM_INSTANCES 1
+#define XPAR_XUARTNS550_CLOCK_HZ 100000000
+
+/* Definitions for peripheral RS232_UART */
+#define XPAR_RS232_UART_DEVICE_ID 0
+#define XPAR_RS232_UART_BASEADDR 0x83E00000
+#define XPAR_RS232_UART_HIGHADDR 0x83E0FFFF
+
+
+/******************************************************************/
+
+
+/* Canonical definitions for peripheral RS232_UART */
+#define XPAR_UARTNS550_0_CLOCK_FREQ_HZ 100000000
+#define XPAR_UARTNS550_0_DEVICE_ID XPAR_RS232_UART_DEVICE_ID
+#define XPAR_UARTNS550_0_BASEADDR 0x83E00000
+#define XPAR_UARTNS550_0_HIGHADDR 0x83E0FFFF
+#define XPAR_UARTNS550_0_SIO_CHAN -1
+
+
+/******************************************************************/
+
+/* Definitions for driver GPIO */
+#define XPAR_XGPIO_NUM_INSTANCES 1
+
+/* Definitions for peripheral LEDS_4BIT */
+#define XPAR_LEDS_4BIT_BASEADDR 0x81400000
+#define XPAR_LEDS_4BIT_HIGHADDR 0x8140FFFF
+#define XPAR_LEDS_4BIT_DEVICE_ID 0
+#define XPAR_LEDS_4BIT_INTERRUPT_PRESENT 1
+#define XPAR_LEDS_4BIT_IS_DUAL 0
+
+
+/******************************************************************/
+
+/* Definitions for driver IIC */
+#define XPAR_XIIC_NUM_INSTANCES 1
+
+/* Definitions for peripheral IIC_EEPROM */
+#define XPAR_IIC_EEPROM_DEVICE_ID 0
+#define XPAR_IIC_EEPROM_BASEADDR 0x81600000
+#define XPAR_IIC_EEPROM_HIGHADDR 0x8160FFFF
+#define XPAR_IIC_EEPROM_TEN_BIT_ADR 0
+#define XPAR_IIC_EEPROM_GPO_WIDTH 1
+
+
+/******************************************************************/
+
+
+/* Canonical definitions for peripheral IIC_EEPROM */
+#define XPAR_IIC_0_DEVICE_ID XPAR_IIC_EEPROM_DEVICE_ID
+#define XPAR_IIC_0_BASEADDR 0x81600000
+#define XPAR_IIC_0_HIGHADDR 0x8160FFFF
+#define XPAR_IIC_0_TEN_BIT_ADR 0
+#define XPAR_IIC_0_GPO_WIDTH 1
+
+
+/******************************************************************/
+
+#define XPAR_XSYSACE_MEM_WIDTH 16
+/* Definitions for driver SYSACE */
+#define XPAR_XSYSACE_NUM_INSTANCES 1
+
+/* Definitions for peripheral SYSACE_COMPACTFLASH */
+#define XPAR_SYSACE_COMPACTFLASH_DEVICE_ID 0
+#define XPAR_SYSACE_COMPACTFLASH_BASEADDR 0x83600000
+#define XPAR_SYSACE_COMPACTFLASH_HIGHADDR 0x8360FFFF
+#define XPAR_SYSACE_COMPACTFLASH_MEM_WIDTH 16
+
+
+/******************************************************************/
+
+
+/* Canonical definitions for peripheral SYSACE_COMPACTFLASH */
+#define XPAR_SYSACE_0_DEVICE_ID XPAR_SYSACE_COMPACTFLASH_DEVICE_ID
+#define XPAR_SYSACE_0_BASEADDR 0x83600000
+#define XPAR_SYSACE_0_HIGHADDR 0x8360FFFF
+#define XPAR_SYSACE_0_MEM_WIDTH 16
+
+/******************************************************************/
+
+/* Definitions for driver LLTEMAC */
+#define XPAR_XLLTEMAC_NUM_INSTANCES 1
+
+/* Definitions for peripheral TRIMODE_MAC_GMII Channel 0 */
+#define XPAR_TRIMODE_MAC_GMII_CHAN_0_DEVICE_ID 0
+#define XPAR_TRIMODE_MAC_GMII_CHAN_0_BASEADDR 0x81c00000
+#define XPAR_TRIMODE_MAC_GMII_CHAN_0_TXCSUM 0
+#define XPAR_TRIMODE_MAC_GMII_CHAN_0_RXCSUM 0
+#define XPAR_TRIMODE_MAC_GMII_CHAN_0_PHY_TYPE 1
+
+/* Canonical definitions for peripheral TRIMODE_MAC_GMII Channel 0 */
+#define XPAR_LLTEMAC_0_DEVICE_ID 0
+#define XPAR_LLTEMAC_0_BASEADDR 0x81c00000
+#define XPAR_LLTEMAC_0_TXCSUM 0
+#define XPAR_LLTEMAC_0_RXCSUM 0
+#define XPAR_LLTEMAC_0_PHY_TYPE 1
+#define XPAR_LLTEMAC_0_INTR 2
+
+
+/* LocalLink TYPE Enumerations */
+#define XPAR_LL_FIFO    1
+#define XPAR_LL_DMA     2
+
+
+/* Canonical LocalLink parameters for TRIMODE_MAC_GMII */
+#define XPAR_LLTEMAC_0_LLINK_CONNECTED_TYPE XPAR_LL_DMA
+#define XPAR_LLTEMAC_0_LLINK_CONNECTED_BASEADDR 0x84600100
+#define XPAR_LLTEMAC_0_LLINK_CONNECTED_FIFO_INTR 0xFF
+#define XPAR_LLTEMAC_0_LLINK_CONNECTED_DMARX_INTR 1
+#define XPAR_LLTEMAC_0_LLINK_CONNECTED_DMATX_INTR 0
+
+
+/******************************************************************/
+
+#define XPAR_INTC_MAX_NUM_INTR_INPUTS 7
+#define XPAR_XINTC_HAS_IPR 1
+#define XPAR_XINTC_USE_DCR 0
+/* Definitions for driver INTC */
+#define XPAR_XINTC_NUM_INSTANCES 1
+
+/* Definitions for peripheral XPS_INTC_0 */
+#define XPAR_XPS_INTC_0_DEVICE_ID 0
+#define XPAR_XPS_INTC_0_BASEADDR 0x81800000
+#define XPAR_XPS_INTC_0_HIGHADDR 0x8180FFFF
+#define XPAR_XPS_INTC_0_KIND_OF_INTR 0x00000000
+
+
+/******************************************************************/
+
+#define XPAR_INTC_SINGLE_BASEADDR 0x81800000
+#define XPAR_INTC_SINGLE_HIGHADDR 0x8180FFFF
+#define XPAR_INTC_SINGLE_DEVICE_ID XPAR_XPS_INTC_0_DEVICE_ID
+#define XPAR_DDR_SDRAM_SDMA2_TX_INTOUT_MASK 0X000001
+#define XPAR_XPS_INTC_0_DDR_SDRAM_SDMA2_TX_INTOUT_INTR 0
+#define XPAR_DDR_SDRAM_SDMA2_RX_INTOUT_MASK 0X000002
+#define XPAR_XPS_INTC_0_DDR_SDRAM_SDMA2_RX_INTOUT_INTR 1
+#define XPAR_TRIMODE_MAC_GMII_TEMACINTC0_IRPT_MASK 0X000004
+#define XPAR_XPS_INTC_0_TRIMODE_MAC_GMII_TEMACINTC0_IRPT_INTR 2
+#define XPAR_SYSACE_COMPACTFLASH_SYSACE_IRQ_MASK 0X000008
+#define XPAR_XPS_INTC_0_SYSACE_COMPACTFLASH_SYSACE_IRQ_INTR 3
+#define XPAR_IIC_EEPROM_IIC2INTC_IRPT_MASK 0X000010
+#define XPAR_XPS_INTC_0_IIC_EEPROM_IIC2INTC_IRPT_INTR 4
+#define XPAR_LEDS_4BIT_IP2INTC_IRPT_MASK 0X000020
+#define XPAR_XPS_INTC_0_LEDS_4BIT_IP2INTC_IRPT_INTR 5
+#define XPAR_RS232_UART_IP2INTC_IRPT_MASK 0X000040
+#define XPAR_XPS_INTC_0_RS232_UART_IP2INTC_IRPT_INTR 6
+
+/******************************************************************/
+
+
+/* Canonical definitions for peripheral XPS_INTC_0 */
+#define XPAR_INTC_0_DEVICE_ID XPAR_XPS_INTC_0_DEVICE_ID
+#define XPAR_INTC_0_BASEADDR 0x81800000
+#define XPAR_INTC_0_HIGHADDR 0x8180FFFF
+#define XPAR_INTC_0_KIND_OF_INTR 0x00000000
+
+#define XPAR_INTC_0_MPMC_0_SDMA2_TX_INTOUT_VEC_ID
XPAR_XPS_INTC_0_DDR_SDRAM_SDMA2_TX_INTOUT_INTR
+#define XPAR_INTC_0_MPMC_0_SDMA2_RX_INTOUT_VEC_ID
XPAR_XPS_INTC_0_DDR_SDRAM_SDMA2_RX_INTOUT_INTR
+#define XPAR_INTC_0_LLTEMAC_0_VEC_ID
XPAR_XPS_INTC_0_TRIMODE_MAC_GMII_TEMACINTC0_IRPT_INTR
+#define XPAR_INTC_0_SYSACE_0_VEC_ID
XPAR_XPS_INTC_0_SYSACE_COMPACTFLASH_SYSACE_IRQ_INTR
+#define XPAR_INTC_0_IIC_0_VEC_ID
XPAR_XPS_INTC_0_IIC_EEPROM_IIC2INTC_IRPT_INTR
+#define XPAR_INTC_0_GPIO_0_VEC_ID
XPAR_XPS_INTC_0_LEDS_4BIT_IP2INTC_IRPT_INTR
+#define XPAR_INTC_0_UARTNS550_0_VEC_ID
XPAR_XPS_INTC_0_RS232_UART_IP2INTC_IRPT_INTR
+
+/******************************************************************/
+
+/* Definitions for driver MPMC */
+#define XPAR_XMPMC_NUM_INSTANCES 1
+
+/* Definitions for peripheral DDR_SDRAM */
+#define XPAR_DDR_SDRAM_DEVICE_ID 0
+#define XPAR_DDR_SDRAM_MPMC_BASEADDR 0x00000000
+#define XPAR_DDR_SDRAM_MPMC_CTRL_BASEADDR 0xFFFFFFFF
+#define XPAR_DDR_SDRAM_INCLUDE_ECC_SUPPORT 0
+#define XPAR_DDR_SDRAM_USE_STATIC_PHY 0
+#define XPAR_DDR_SDRAM_PM_ENABLE 0
+#define XPAR_DDR_SDRAM_NUM_PORTS 3
+
+
+/******************************************************************/
+
+
+/* Definitions for peripheral DDR_SDRAM */
+#define XPAR_DDR_SDRAM_MPMC_BASEADDR 0x00000000
+#define XPAR_DDR_SDRAM_MPMC_HIGHADDR 0x07FFFFFF
+#define XPAR_DDR_SDRAM_SDMA_CTRL_BASEADDR 0x84600000
+#define XPAR_DDR_SDRAM_SDMA_CTRL_HIGHADDR 0x8460FFFF
+
+
+/******************************************************************/
+
+
+/* Canonical definitions for peripheral DDR_SDRAM */
+#define XPAR_MPMC_0_DEVICE_ID XPAR_DDR_SDRAM_DEVICE_ID
+#define XPAR_MPMC_0_MPMC_BASEADDR 0x00000000
+#define XPAR_MPMC_0_MPMC_CTRL_BASEADDR 0xFFFFFFFF
+#define XPAR_MPMC_0_INCLUDE_ECC_SUPPORT 0
+#define XPAR_MPMC_0_USE_STATIC_PHY 0
+#define XPAR_MPMC_0_PM_ENABLE 0
+#define XPAR_MPMC_0_NUM_PORTS 3
+
+
+
+/******************************************************************/
+
+#define XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ 300000000
+
+/******************************************************************/
+
+#define XPAR_CPU_ID 0
+#define XPAR_PPC405_VIRTEX4_ID 0
+#define XPAR_PPC405_VIRTEX4_CORE_CLOCK_FREQ_HZ 300000000
+#define XPAR_PPC405_VIRTEX4_DPLB0_DWIDTH 64
+#define XPAR_PPC405_VIRTEX4_DPLB0_NATIVE_DWIDTH 64
+#define XPAR_PPC405_VIRTEX4_IPLB0_DWIDTH 64
+#define XPAR_PPC405_VIRTEX4_IPLB0_NATIVE_DWIDTH 64
+#define XPAR_PPC405_VIRTEX4_DPLB1_DWIDTH 64
+#define XPAR_PPC405_VIRTEX4_DPLB1_NATIVE_DWIDTH 64
+#define XPAR_PPC405_VIRTEX4_IPLB1_DWIDTH 64
+#define XPAR_PPC405_VIRTEX4_IPLB1_NATIVE_DWIDTH 64
+#define XPAR_PPC405_VIRTEX4_DPLB1_ADDR_BASE 0x00000000
+#define XPAR_PPC405_VIRTEX4_DPLB1_ADDR_HIGH 0x07ffffff
+#define XPAR_PPC405_VIRTEX4_IPLB1_ADDR_BASE 0x00000000
+#define XPAR_PPC405_VIRTEX4_IPLB1_ADDR_HIGH 0x07ffffff
+#define XPAR_PPC405_VIRTEX4_FASTEST_PLB_CLOCK DPLB0
+#define XPAR_PPC405_VIRTEX4_GENERATE_PLB_TIMESPECS 1
+#define XPAR_PPC405_VIRTEX4_DPLB0_P2P 0
+#define XPAR_PPC405_VIRTEX4_DPLB1_P2P 1
+#define XPAR_PPC405_VIRTEX4_IPLB0_P2P 0
+#define XPAR_PPC405_VIRTEX4_IPLB1_P2P 1
+#define XPAR_PPC405_VIRTEX4_IDCR_BASEADDR 0x00000100
+#define XPAR_PPC405_VIRTEX4_IDCR_HIGHADDR 0x000001FF
+#define XPAR_PPC405_VIRTEX4_DISABLE_OPERAND_FORWARDING 1
+#define XPAR_PPC405_VIRTEX4_MMU_ENABLE 1
+#define XPAR_PPC405_VIRTEX4_DETERMINISTIC_MULT 0
+#define XPAR_PPC405_VIRTEX4_PLBSYNCBYPASS 1
+#define XPAR_PPC405_VIRTEX4_APU_CONTROL 0b1101111000000000
+#define XPAR_PPC405_VIRTEX4_APU_UDI_1 0b101000011000100110000011
+#define XPAR_PPC405_VIRTEX4_APU_UDI_2 0b101000111000100110000011
+#define XPAR_PPC405_VIRTEX4_APU_UDI_3 0b101001011000100111000011
+#define XPAR_PPC405_VIRTEX4_APU_UDI_4 0b101001111000100111000011
+#define XPAR_PPC405_VIRTEX4_APU_UDI_5 0b101010011000110000000011
+#define XPAR_PPC405_VIRTEX4_APU_UDI_6 0b101010111000110000000011
+#define XPAR_PPC405_VIRTEX4_APU_UDI_7 0b101011011000110001000011
+#define XPAR_PPC405_VIRTEX4_APU_UDI_8 0b101011111000110001000011
+#define XPAR_PPC405_VIRTEX4_PVR_HIGH 0b0000
+#define XPAR_PPC405_VIRTEX4_PVR_LOW 0b0000
+#define XPAR_PPC405_VIRTEX4_HW_VER "2.01.a"
+
+/******************************************************************/
+
+#define XPAR_PLB_CLOCK_FREQ_HZ 100000000
+#define XPAR_CORE_CLOCK_FREQ_HZ XPAR_CPU_PPC405_CORE_CLOCK_FREQ_HZ
+#define XPAR_DDR_0_SIZE 0x4000000
+
+/******************************************************************/
+
+#define XPAR_PCI_0_CLOCK_FREQ_HZ    0
+
+/******************************************************************/
+
+#define XPAR_PERSISTENT_0_IIC_0_BASEADDR 0
+#define XPAR_PERSISTENT_0_IIC_0_HIGHADDR 1024
+#define XPAR_PERSISTENT_0_IIC_0_EEPROMADDR 0xA0
diff --git a/arch/ppc/syslib/virtex_devices.c
b/arch/ppc/syslib/virtex_devices.c
index cdfc062..addf58a 100644
--- a/arch/ppc/syslib/virtex_devices.c
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -219,7 +219,7 @@
 		.tx_csum =3D XPAR_LLTEMAC_##num##_TXCSUM, \
 		.rx_csum =3D XPAR_LLTEMAC_##num##_RXCSUM, \
 		.phy_type =3D XPAR_LLTEMAC_##num##_PHY_TYPE, \
-		.dcr_host =3D 0xff, \
+		.dcr_host =3D 0x00, \
 		.ll_dev_type =3D
XPAR_LLTEMAC_##num##_LLINK_CONNECTED_TYPE, \
 		.ll_dev_baseaddress =3D
XPAR_LLTEMAC_##num##_LLINK_CONNECTED_BASEADDR, \
 		.ll_dev_dma_rx_irq =3D
XPAR_LLTEMAC_##num##_LLINK_CONNECTED_DMARX_INTR, \
--=20
1.5.2.1

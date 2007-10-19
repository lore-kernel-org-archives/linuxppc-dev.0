Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8251DE081
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 01:00:41 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9JF0cWN012578
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 11:00:38 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9JF0ckU115760
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:00:38 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9JF0cTl011103
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:00:38 -0600
Received: from [9.10.86.71] (weaponx.rchland.ibm.com [9.10.86.71])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l9JF0bsM011046
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:00:37 -0600
Message-Id: <20071019145512.875685000@linux.vnet.ibm.com>>
References: <20071019145307.978880000@linux.vnet.ibm.com>>
Date: Fri, 19 Oct 2007 09:53:12 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 4/4] 4xx: Enable EMAC on Bamboo board
In-Reply-To: <20071019145307.978880000@linux.vnet.ibm.com>>
Content-Type: text/plain
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix some device tree omissions that prevented the new EMAC driver from
setting up ethernet on the Bamboo board correctly and update the Bamboo
defconfig.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/boot/dts/bamboo.dts      |   10 ++
 arch/powerpc/configs/bamboo_defconfig |  114 ++++++++++++++++++++--------------
 arch/powerpc/platforms/44x/Kconfig    |    2 
 3 files changed, 76 insertions(+), 50 deletions(-)

--- linux-2.6.orig/arch/powerpc/platforms/44x/Kconfig
+++ linux-2.6/arch/powerpc/platforms/44x/Kconfig
@@ -43,7 +43,7 @@ config 440EP
 	bool
 	select PPC_FPU
 	select IBM440EP_ERR42
-#	select IBM_NEW_EMAC_ZMII
+	select IBM_NEW_EMAC_ZMII
 
 config 440EPX
 	bool
--- linux-2.6.orig/arch/powerpc/boot/dts/bamboo.dts
+++ linux-2.6/arch/powerpc/boot/dts/bamboo.dts
@@ -98,11 +98,13 @@
 			interrupt-parent = <&MAL0>;
 			interrupts = <0 1 2 3 4>;
 			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			#size-cells = <0>;
 			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
 					/*RXEOB*/ 1 &UIC0 b 4
 					/*SERR*/  2 &UIC1 0 4
 					/*TXDE*/  3 &UIC1 1 4
-					/*RXDE*/  4 &UIC1 3 4>;
+					/*RXDE*/  4 &UIC1 2 4>;
 		};
 
 		POB0: opb {
@@ -196,6 +198,7 @@
 			};
 
 			EMAC0: ethernet@ef600e00 {
+				linux,network-index = <0>;
 				device_type = "network";
 				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
@@ -210,12 +213,13 @@
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rmii";
-				phy-map = <00000001>;
+				phy-map = <00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
 			};
 
 			EMAC1: ethernet@ef600f00 {
+				linux,network-index = <1>;
 				device_type = "network";
 				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
@@ -230,7 +234,7 @@
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rmii";
-				phy-map = <00000001>;
+				phy-map = <00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
 			};
--- linux-2.6.orig/arch/powerpc/configs/bamboo_defconfig
+++ linux-2.6/arch/powerpc/configs/bamboo_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc1
-# Fri Aug  3 10:46:53 2007
+# Linux kernel version: 2.6.23
+# Fri Oct 19 09:01:11 2007
 #
 # CONFIG_PPC64 is not set
 
@@ -22,8 +22,13 @@ CONFIG_PHYS_64BIT=y
 # CONFIG_PPC_MM_SLICES is not set
 CONFIG_NOT_COHERENT_CACHE=y
 CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_IRQ_PER_CPU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -67,6 +72,8 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -87,7 +94,6 @@ CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
@@ -133,6 +139,7 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_PQ2ADS is not set
 CONFIG_BAMBOO=y
 # CONFIG_EBONY is not set
+# CONFIG_SEQUOIA is not set
 CONFIG_440EP=y
 CONFIG_IBM440EP_ERR42=y
 # CONFIG_MPIC is not set
@@ -146,11 +153,16 @@ CONFIG_IBM440EP_ERR42=y
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_CPM2 is not set
+# CONFIG_FSL_ULI1575 is not set
 
 #
 # Kernel options
 #
 # CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
@@ -172,6 +184,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
@@ -197,10 +210,6 @@ CONFIG_PCI_SYSCALL=y
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
 # CONFIG_PCI_DEBUG is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
 
@@ -215,7 +224,7 @@ CONFIG_ARCH_SUPPORTS_MSI=y
 CONFIG_HIGHMEM_START=0xfe000000
 CONFIG_LOWMEM_SIZE=0x30000000
 CONFIG_KERNEL_START=0xc0000000
-CONFIG_TASK_SIZE=0x80000000
+CONFIG_TASK_SIZE=0xc0000000
 CONFIG_CONSISTENT_START=0xff100000
 CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_BOOT_LOAD=0x01000000
@@ -252,6 +261,7 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -309,6 +319,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
@@ -353,10 +364,6 @@ CONFIG_MISC_DEVICES=y
 # CONFIG_SCSI_NETLINK is not set
 # CONFIG_ATA is not set
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
 # CONFIG_FUSION is not set
 
 #
@@ -375,12 +382,36 @@ CONFIG_NETDEVICES=y
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_IP1000 is not set
 # CONFIG_ARCNET is not set
-# CONFIG_NET_ETHERNET is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_IBM_NEW_EMAC=y
+CONFIG_IBM_NEW_EMAC_RXB=128
+CONFIG_IBM_NEW_EMAC_TXB=64
+CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=32
+CONFIG_IBM_NEW_EMAC_RX_COPY_THRESHOLD=256
+CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=0
+# CONFIG_IBM_NEW_EMAC_DEBUG is not set
+CONFIG_IBM_NEW_EMAC_ZMII=y
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
 CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
 # CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
@@ -388,6 +419,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -396,11 +428,14 @@ CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 # CONFIG_CHELSIO_T1 is not set
 # CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGBE is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 # CONFIG_MYRI10GE is not set
 # CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
 # CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
 # CONFIG_TR is not set
 
 #
@@ -463,14 +498,11 @@ CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
 # CONFIG_NVRAM is not set
 # CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
-# CONFIG_AGP is not set
-# CONFIG_DRM is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
@@ -484,6 +516,13 @@ CONFIG_DEVPORT=y
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
 
 #
 # Multifunction device drivers
@@ -500,16 +539,17 @@ CONFIG_DAB=y
 #
 # Graphics support
 #
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
+# CONFIG_FB is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
-# CONFIG_VGASTATE is not set
-CONFIG_VIDEO_OUTPUT_CONTROL=m
-# CONFIG_FB is not set
-# CONFIG_FB_IBM_GXT4500 is not set
 
 #
 # Sound
@@ -536,19 +576,6 @@ CONFIG_USB_ARCH_HAS_EHCI=y
 # CONFIG_RTC_CLASS is not set
 
 #
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
-
-#
 # Userspace I/O
 #
 # CONFIG_UIO is not set
@@ -600,7 +627,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -619,10 +645,7 @@ CONFIG_CRAMFS=y
 # CONFIG_QNX4FS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
@@ -648,15 +671,7 @@ CONFIG_SUNRPC=y
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 # CONFIG_NLS is not set
-
-#
-# Distributed Lock Manager
-#
 # CONFIG_DLM is not set
 # CONFIG_UCC_SLOW is not set
 
@@ -709,6 +724,7 @@ CONFIG_SCHED_DEBUG=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
@@ -728,6 +744,7 @@ CONFIG_PPC_EARLY_DEBUG=y
 # CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set
 # CONFIG_PPC_EARLY_DEBUG_BEAT is not set
 CONFIG_PPC_EARLY_DEBUG_44x=y
+# CONFIG_PPC_EARLY_DEBUG_CPM is not set
 CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW=0xef600300
 CONFIG_PPC_EARLY_DEBUG_44x_PHYSHIGH=0x0
 
@@ -736,6 +753,7 @@ CONFIG_PPC_EARLY_DEBUG_44x_PHYSHIGH=0x0
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
@@ -755,6 +773,7 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_PCBC=y
 # CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_XTS is not set
 # CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_FCRYPT is not set
@@ -768,9 +787,12 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_ARC4 is not set
 # CONFIG_CRYPTO_KHAZAD is not set
 # CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_SEED is not set
 # CONFIG_CRYPTO_DEFLATE is not set
 # CONFIG_CRYPTO_MICHAEL_MIC is not set
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO_AUTHENC is not set
 CONFIG_CRYPTO_HW=y
+# CONFIG_PPC_CLOCK is not set

-- 

Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F385DE093
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 01:00:42 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9JF0dXO008530
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 11:00:39 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9JF0clL113766
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:00:38 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9JF0bbr019092
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:00:37 -0600
Received: from [9.10.86.71] (weaponx.rchland.ibm.com [9.10.86.71])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l9JF0aDJ018888
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 09:00:36 -0600
Message-Id: <20071019145512.690962000@linux.vnet.ibm.com>>
References: <20071019145307.978880000@linux.vnet.ibm.com>>
Date: Fri, 19 Oct 2007 09:53:11 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 3/4] 4xx: Enable EMAC for PPC405 Walnut board
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

This patch enables the ibm_newemac driver for the Walnut board.  It fixes the
device tree for the walnut board to order the MAL interrupts correctly and
adds the local-mac-address property to the EMAC node.  The bootwrapper is also
updated to extract the MAC address from the OpenBIOS offset where it is stored.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/walnut.dts      |   12 +++-
 arch/powerpc/boot/treeboot-walnut.c   |    2 
 arch/powerpc/configs/walnut_defconfig |   94 +++++++++++++++++++---------------
 arch/powerpc/platforms/40x/Kconfig    |    1 
 4 files changed, 66 insertions(+), 43 deletions(-)

--- linux-2.6.orig/arch/powerpc/boot/dts/walnut.dts
+++ linux-2.6/arch/powerpc/boot/dts/walnut.dts
@@ -64,10 +64,15 @@
 		MAL: mcmal {
 			compatible = "ibm,mcmal-405gp", "ibm,mcmal";
 			dcr-reg = <180 62>;
-			num-tx-chans = <2>;
+			num-tx-chans = <1>;
 			num-rx-chans = <1>;
 			interrupt-parent = <&UIC0>;
-			interrupts = <a 4 b 4 c 4 d 4 e 4>;
+			interrupts = <
+				b 4 /* TXEOB */
+				c 4 /* RXEOB */
+				a 4 /* SERR */
+				d 4 /* TXDE */
+				e 4 /* RXDE */>;
 		};
 
 		POB0: opb {
@@ -118,9 +123,10 @@
 				compatible = "ibm,emac-405gp", "ibm,emac";
 				interrupt-parent = <&UIC0>;
 				interrupts = <9 4 f 4>;
+				local-mac-address = [000000000000]; /* Filled in by zImage */
 				reg = <ef600800 70>;
 				mal-device = <&MAL>;
-				mal-tx-channel = <0 1>;
+				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
 				max-frame-size = <5dc>;
--- linux-2.6.orig/arch/powerpc/configs/walnut_defconfig
+++ linux-2.6/arch/powerpc/configs/walnut_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.23-rc4
-# Wed Sep  5 12:06:37 2007
+# Linux kernel version: 2.6.23
+# Thu Oct 18 12:54:18 2007
 #
 # CONFIG_PPC64 is not set
 
@@ -18,8 +18,13 @@ CONFIG_4xx=y
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
@@ -63,6 +68,8 @@ CONFIG_POSIX_MQUEUE=y
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
 CONFIG_BLK_DEV_INITRD=y
@@ -83,7 +90,6 @@ CONFIG_FUTEX=y
 CONFIG_ANON_INODES=y
 CONFIG_EPOLL=y
 CONFIG_SIGNALFD=y
-CONFIG_TIMERFD=y
 CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
 CONFIG_VM_EVENT_COUNTERS=y
@@ -127,7 +133,9 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PQ2ADS is not set
+# CONFIG_KILAUEA is not set
 CONFIG_WALNUT=y
+# CONFIG_XILINX_VIRTEX_GENERIC_BOARD is not set
 CONFIG_405GP=y
 CONFIG_IBM405_ERR77=y
 CONFIG_IBM405_ERR51=y
@@ -148,6 +156,10 @@ CONFIG_IBM405_ERR51=y
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
@@ -169,6 +181,7 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
@@ -177,6 +190,8 @@ CONFIG_VIRT_TO_BUS=y
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
 CONFIG_SECCOMP=y
 CONFIG_WANT_DEVICE_TREE=y
 CONFIG_DEVICE_TREE="walnut.dts"
@@ -190,10 +205,6 @@ CONFIG_ZONE_DMA=y
 # CONFIG_PCI_DOMAINS is not set
 # CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
 # CONFIG_PCCARD is not set
 
 #
@@ -207,7 +218,7 @@ CONFIG_ZONE_DMA=y
 CONFIG_HIGHMEM_START=0xfe000000
 CONFIG_LOWMEM_SIZE=0x30000000
 CONFIG_KERNEL_START=0xc0000000
-CONFIG_TASK_SIZE=0x80000000
+CONFIG_TASK_SIZE=0xc0000000
 CONFIG_CONSISTENT_START=0xff100000
 CONFIG_CONSISTENT_SIZE=0x00200000
 CONFIG_BOOT_LOAD=0x00400000
@@ -244,6 +255,7 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
@@ -301,6 +313,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
@@ -328,6 +341,7 @@ CONFIG_MTD_BLOCK=m
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -360,7 +374,6 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
 # CONFIG_MTD_PHYSMAP is not set
 CONFIG_MTD_PHYSMAP_OF=y
-# CONFIG_MTD_WALNUT is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
@@ -419,7 +432,22 @@ CONFIG_NETDEVICES=y
 # CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-# CONFIG_NET_ETHERNET is not set
+# CONFIG_VETH is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
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
+# CONFIG_B44 is not set
 CONFIG_NETDEV_1000=y
 CONFIG_NETDEV_10000=y
 
@@ -498,6 +526,12 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_HWMON is not set
 
 #
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
 # Multifunction device drivers
 #
 # CONFIG_MFD_SM501 is not set
@@ -512,16 +546,15 @@ CONFIG_LEGACY_PTY_COUNT=256
 #
 # Graphics support
 #
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
@@ -546,19 +579,6 @@ CONFIG_USB_SUPPORT=y
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
@@ -610,7 +630,6 @@ CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set
 
 #
@@ -630,10 +649,7 @@ CONFIG_CRAMFS=y
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
@@ -659,15 +675,7 @@ CONFIG_SUNRPC=y
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
 
@@ -720,6 +728,7 @@ CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_FAULT_INJECTION is not set
 # CONFIG_DEBUG_STACKOVERFLOW is not set
@@ -734,6 +743,7 @@ CONFIG_FORCED_INLINING=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
@@ -753,6 +763,7 @@ CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_PCBC=y
 # CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_XTS is not set
 # CONFIG_CRYPTO_CRYPTD is not set
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_FCRYPT is not set
@@ -766,9 +777,12 @@ CONFIG_CRYPTO_DES=y
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
--- linux-2.6.orig/arch/powerpc/platforms/40x/Kconfig
+++ linux-2.6/arch/powerpc/platforms/40x/Kconfig
@@ -100,6 +100,7 @@ config 405GP
 	bool
 	select IBM405_ERR77
 	select IBM405_ERR51
+	select IBM_NEW_EMAC_ZMII
 
 config 405EP
 	bool
--- linux-2.6.orig/arch/powerpc/boot/treeboot-walnut.c
+++ linux-2.6/arch/powerpc/boot/treeboot-walnut.c
@@ -109,6 +109,7 @@ static void walnut_flashsel_fixup(void)
 	setprop(sram, "reg", reg_sram, sizeof(reg_sram));
 }
 
+#define WALNUT_OPENBIOS_MAC_OFF 0xfffffe0b
 static void walnut_fixups(void)
 {
 	ibm4xx_fixup_memsize();
@@ -116,6 +117,7 @@ static void walnut_fixups(void)
 	ibm4xx_quiesce_eth((u32 *)0xef600800, NULL);
 	ibm4xx_fixup_ebc_ranges("/plb/ebc");
 	walnut_flashsel_fixup();
+	dt_fixup_mac_addresses((u8 *) WALNUT_OPENBIOS_MAC_OFF);
 }
 
 void platform_init(void)

-- 

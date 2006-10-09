Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E87E67B52
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Oct 2006 13:29:58 +1000 (EST)
Subject: [PATCH] Update maple defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 13:28:59 +1000
Message-Id: <1160364539.14601.25.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This updates the Maple defconfig to 4 CPUs (along with current defaults)
to support the "tigerwood" 970MP evaluation board. 

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/configs/maple_defconfig
===================================================================
--- linux-work.orig/arch/powerpc/configs/maple_defconfig	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/configs/maple_defconfig	2006-10-09 12:06:34.000000000 +1000
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:24:55 2006
+# Linux kernel version: 2.6.18
+# Mon Oct  9 11:59:34 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -22,6 +22,7 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 CONFIG_PPC_UDBG_16550=y
 CONFIG_GENERIC_TBSYNC=y
+CONFIG_AUDIT_ARCH=y
 # CONFIG_DEFAULT_UIMAGE is not set
 
 #
@@ -34,7 +35,7 @@ CONFIG_PPC_FPU=y
 CONFIG_PPC_STD_MMU=y
 CONFIG_VIRT_CPU_ACCOUNTING=y
 CONFIG_SMP=y
-CONFIG_NR_CPUS=2
+CONFIG_NR_CPUS=4
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -51,10 +52,11 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
@@ -62,7 +64,9 @@ CONFIG_IKCONFIG_PROC=y
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -71,12 +75,12 @@ CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
 CONFIG_BASE_FULL=y
-CONFIG_RT_MUTEXES=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 CONFIG_SHMEM=y
 CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 # CONFIG_SLOB is not set
@@ -95,6 +99,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
@@ -114,16 +119,16 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # Platform support
 #
 CONFIG_PPC_MULTIPLATFORM=y
-# CONFIG_PPC_ISERIES is not set
 # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
 # CONFIG_PPC_PSERIES is not set
+# CONFIG_PPC_ISERIES is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_PPC_MAPLE=y
+# CONFIG_PPC_PASEMI is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_IBM_CELL_BLADE is not set
-# CONFIG_UDBG_RTAS_CONSOLE is not set
 CONFIG_U3_DART=y
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
@@ -157,6 +162,7 @@ CONFIG_IRQ_ALL_CPUS=y
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -184,6 +190,7 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -211,6 +218,7 @@ CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=m
+# CONFIG_XFRM_SUB_POLICY is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -232,10 +240,12 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_IPV6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
@@ -265,7 +275,6 @@ CONFIG_TCP_CONG_BIC=y
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -377,6 +386,7 @@ CONFIG_BLK_DEV_AMD74XX=y
 # CONFIG_BLK_DEV_CS5530 is not set
 # CONFIG_BLK_DEV_HPT34X is not set
 # CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_JMICRON is not set
 # CONFIG_BLK_DEV_SC1200 is not set
 # CONFIG_BLK_DEV_PIIX is not set
 # CONFIG_BLK_DEV_IT821X is not set
@@ -399,6 +409,12 @@ CONFIG_IDEDMA_AUTO=y
 #
 # CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
+# CONFIG_SCSI_NETLINK is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
 
 #
 # Multi-device support (RAID and LVM)
@@ -498,7 +514,7 @@ CONFIG_E1000=y
 # CONFIG_VIA_VELOCITY is not set
 CONFIG_TIGON3=y
 # CONFIG_BNX2 is not set
-# CONFIG_MV643XX_ETH is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -545,6 +561,7 @@ CONFIG_TIGON3=y
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -704,6 +721,7 @@ CONFIG_I2C_AMD8111=y
 #
 # Misc devices
 #
+# CONFIG_TIFM_CORE is not set
 
 #
 # Multimedia devices
@@ -779,7 +797,6 @@ CONFIG_USB_UHCI_HCD=y
 #
 # may also be needed; see USB_STORAGE Help for more information
 #
-# CONFIG_USB_STORAGE is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
@@ -802,6 +819,7 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_ATI_REMOTE2 is not set
 # CONFIG_USB_KEYSPAN_REMOTE is not set
 # CONFIG_USB_APPLETOUCH is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
 
 #
 # USB Imaging devices
@@ -828,6 +846,7 @@ CONFIG_USB_MON=y
 CONFIG_USB_SERIAL=y
 # CONFIG_USB_SERIAL_CONSOLE is not set
 CONFIG_USB_SERIAL_GENERIC=y
+# CONFIG_USB_SERIAL_AIRCABLE is not set
 # CONFIG_USB_SERIAL_AIRPRIME is not set
 # CONFIG_USB_SERIAL_ARK3116 is not set
 # CONFIG_USB_SERIAL_BELKIN is not set
@@ -862,6 +881,7 @@ CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=y
 # CONFIG_USB_SERIAL_KLSI is not set
 # CONFIG_USB_SERIAL_KOBIL_SCT is not set
 # CONFIG_USB_SERIAL_MCT_U232 is not set
+# CONFIG_USB_SERIAL_MOS7840 is not set
 # CONFIG_USB_SERIAL_NAVMAN is not set
 # CONFIG_USB_SERIAL_PL2303 is not set
 # CONFIG_USB_SERIAL_HP4X is not set
@@ -879,6 +899,7 @@ CONFIG_USB_EZUSB=y
 #
 # CONFIG_USB_EMI62 is not set
 # CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
 # CONFIG_USB_AUERSWALD is not set
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
@@ -886,9 +907,9 @@ CONFIG_USB_EZUSB=y
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
-# CONFIG_USB_PHIDGETKIT is not set
-# CONFIG_USB_PHIDGETSERVO is not set
+# CONFIG_USB_PHIDGET is not set
 # CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
 # CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
@@ -995,8 +1016,10 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 CONFIG_HUGETLBFS=y
 CONFIG_HUGETLB_PAGE=y
 CONFIG_RAMFS=y
@@ -1129,6 +1152,7 @@ CONFIG_PLIST=y
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -1148,6 +1172,7 @@ CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 # CONFIG_FORCED_INLINING is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
@@ -1169,6 +1194,9 @@ CONFIG_BOOTX_TEXT=y
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=m
+CONFIG_CRYPTO_MANAGER=m
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_MD4 is not set
@@ -1178,6 +1206,8 @@ CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set

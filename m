Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2BF8A67EAC
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 13:53:19 +1000 (EST)
Date: Fri, 6 Oct 2006 13:53:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] update iseries_defconfig
Message-Id: <20061006135312.46c07d22.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This make sure that an iseries_defconfig does not inlude
other platforms.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/configs/iseries_defconfig |   86 ++++++++++++++++++++++++++------
 1 files changed, 69 insertions(+), 17 deletions(-)

Iseries_defconfig will not build without this.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/configs/iseries_defconfig b/arch/powerpc/configs/iseries_defconfig
index d58f82f..b500550 100644
--- a/arch/powerpc/configs/iseries_defconfig
+++ b/arch/powerpc/configs/iseries_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18-rc6
-# Sun Sep 10 10:22:57 2006
+# Linux kernel version: 2.6.19-rc1
+# Fri Oct  6 13:25:04 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -22,6 +22,7 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 # CONFIG_PPC_UDBG_16550 is not set
 # CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
 # CONFIG_DEFAULT_UIMAGE is not set
 
 #
@@ -52,10 +53,11 @@ CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-CONFIG_SYSCTL=y
+# CONFIG_UTS_NS is not set
 CONFIG_AUDIT=y
 CONFIG_AUDITSYSCALL=y
 CONFIG_IKCONFIG=y
@@ -64,7 +66,9 @@ # CONFIG_CPUSETS is not set
 # CONFIG_RELAY is not set
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
 # CONFIG_EMBEDDED is not set
+# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
@@ -73,12 +77,12 @@ CONFIG_PRINTK=y
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
@@ -97,6 +101,7 @@ CONFIG_STOP_MACHINE=y
 #
 # Block layer
 #
+CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
 
 #
@@ -115,13 +120,18 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
-# CONFIG_PPC_MULTIPLATFORM is not set
-CONFIG_PPC_ISERIES=y
+CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
+# CONFIG_PPC_PSERIES is not set
+CONFIG_PPC_ISERIES=y
+# CONFIG_PPC_PMAC is not set
+# CONFIG_PPC_MAPLE is not set
+# CONFIG_PPC_PASEMI is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
-# CONFIG_UDBG_RTAS_CONSOLE is not set
+# CONFIG_PPC_IBM_CELL_BLADE is not set
+# CONFIG_U3_DART is not set
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
 CONFIG_IBMVIO=y
@@ -147,12 +157,15 @@ # CONFIG_BINFMT_MISC is not set
 CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_IOMMU_VMERGE=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_KEXEC is not set
+# CONFIG_CRASH_DUMP is not set
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_LPARCFG=y
 # CONFIG_NUMA is not set
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
@@ -179,6 +192,7 @@ # CONFIG_PPC_INDIRECT_PCI is not set
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
+# CONFIG_PCI_MULTITHREAD_PROBE is not set
 # CONFIG_PCI_DEBUG is not set
 
 #
@@ -206,6 +220,7 @@ # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 CONFIG_XFRM_USER=m
+CONFIG_XFRM_SUB_POLICY=y
 CONFIG_NET_KEY=m
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -224,10 +239,12 @@ CONFIG_INET_XFRM_TUNNEL=m
 CONFIG_INET_TUNNEL=y
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=m
 CONFIG_INET_DIAG=y
 CONFIG_INET_TCP_DIAG=y
 # CONFIG_TCP_CONG_ADVANCED is not set
-CONFIG_TCP_CONG_BIC=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
 
 #
 # IP: Virtual Server Configuration
@@ -247,6 +264,7 @@ # CONFIG_NETFILTER_NETLINK is not set
 CONFIG_NETFILTER_XTABLES=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
+CONFIG_NETFILTER_XT_TARGET_DSCP=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
 CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
 CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
@@ -255,6 +273,7 @@ CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
 CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
 CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
 # CONFIG_NETFILTER_XT_MATCH_DCCP is not set
+CONFIG_NETFILTER_XT_MATCH_DSCP=m
 # CONFIG_NETFILTER_XT_MATCH_ESP is not set
 CONFIG_NETFILTER_XT_MATCH_HELPER=m
 CONFIG_NETFILTER_XT_MATCH_LENGTH=m
@@ -294,7 +313,6 @@ CONFIG_IP_NF_MATCH_IPRANGE=m
 CONFIG_IP_NF_MATCH_TOS=m
 CONFIG_IP_NF_MATCH_RECENT=m
 CONFIG_IP_NF_MATCH_ECN=m
-CONFIG_IP_NF_MATCH_DSCP=m
 # CONFIG_IP_NF_MATCH_AH is not set
 CONFIG_IP_NF_MATCH_TTL=m
 CONFIG_IP_NF_MATCH_OWNER=m
@@ -319,7 +337,6 @@ CONFIG_IP_NF_NAT_AMANDA=m
 CONFIG_IP_NF_MANGLE=m
 CONFIG_IP_NF_TARGET_TOS=m
 CONFIG_IP_NF_TARGET_ECN=m
-CONFIG_IP_NF_TARGET_DSCP=m
 CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_TARGET_CLUSTERIP=m
 CONFIG_IP_NF_RAW=m
@@ -351,7 +368,6 @@ # CONFIG_IPX is not set
 # CONFIG_ATALK is not set
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
 
@@ -433,6 +449,7 @@ # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_NETLINK=y
 CONFIG_SCSI_PROC_FS=y
 
 #
@@ -454,12 +471,14 @@ CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_LOGGING is not set
 
 #
-# SCSI Transport Attributes
+# SCSI Transports
 #
 CONFIG_SCSI_SPI_ATTRS=y
 CONFIG_SCSI_FC_ATTRS=y
 # CONFIG_SCSI_ISCSI_ATTRS is not set
-# CONFIG_SCSI_SAS_ATTRS is not set
+CONFIG_SCSI_SAS_ATTRS=m
+CONFIG_SCSI_SAS_LIBSAS=m
+CONFIG_SCSI_SAS_LIBSAS_DEBUG=y
 
 #
 # SCSI low-level drivers
@@ -472,10 +491,11 @@ # CONFIG_SCSI_AACRAID is not set
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_ARCMSR is not set
 # CONFIG_MEGARAID_NEWGEN is not set
 # CONFIG_MEGARAID_LEGACY is not set
 # CONFIG_MEGARAID_SAS is not set
-# CONFIG_ATA is not set
 # CONFIG_SCSI_HPTIOP is not set
 # CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DMX3191D is not set
@@ -486,16 +506,22 @@ # CONFIG_SCSI_IPS is not set
 CONFIG_SCSI_IBMVSCSI=m
 # CONFIG_SCSI_INITIO is not set
 # CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_STEX is not set
 # CONFIG_SCSI_SYM53C8XX_2 is not set
-# CONFIG_SCSI_IPR is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
 # CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
 # CONFIG_SCSI_LPFC is not set
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
+
+#
 # Multi-device support (RAID and LVM)
 #
 CONFIG_MD=y
@@ -508,6 +534,7 @@ # CONFIG_MD_RAID456 is not set
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
 CONFIG_BLK_DEV_DM=y
+# CONFIG_DM_DEBUG is not set
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
@@ -573,6 +600,7 @@ # CONFIG_NET_TULIP is not set
 # CONFIG_HP100 is not set
 CONFIG_NET_PCI=y
 CONFIG_PCNET32=y
+CONFIG_PCNET32_NAPI=y
 # CONFIG_AMD8111_ETH is not set
 # CONFIG_ADAPTEC_STARFIRE is not set
 # CONFIG_B44 is not set
@@ -610,6 +638,7 @@ # CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
+# CONFIG_QLA3XXX is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -649,6 +678,7 @@ CONFIG_PPP_BSDCOMP=m
 # CONFIG_PPP_MPPE is not set
 CONFIG_PPPOE=m
 # CONFIG_SLIP is not set
+CONFIG_SLHC=m
 # CONFIG_NET_FC is not set
 # CONFIG_SHAPER is not set
 CONFIG_NETCONSOLE=y
@@ -671,6 +701,7 @@ #
 # Input device support
 #
 CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
 
 #
 # Userland interfaces
@@ -774,12 +805,12 @@ # CONFIG_HWMON_VID is not set
 #
 # Misc devices
 #
+# CONFIG_TIFM_CORE is not set
 
 #
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
-CONFIG_VIDEO_V4L2=y
 
 #
 # Digital Video Broadcasting Devices
@@ -893,6 +924,9 @@ # CONFIG_XFS_QUOTA is not set
 CONFIG_XFS_SECURITY=y
 CONFIG_XFS_POSIX_ACL=y
 # CONFIG_XFS_RT is not set
+CONFIG_GFS2_FS=m
+CONFIG_GFS2_FS_LOCKING_NOLOCK=m
+CONFIG_GFS2_FS_LOCKING_DLM=m
 # CONFIG_OCFS2_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
@@ -929,12 +963,14 @@ # Pseudo filesystems
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
-# CONFIG_CONFIGFS_FS is not set
+CONFIG_CONFIGFS_FS=m
 
 #
 # Miscellaneous filesystems
@@ -988,6 +1024,7 @@ # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
 # CONFIG_9P_FS is not set
+CONFIG_GENERIC_ACL=y
 
 #
 # Partition Types
@@ -1040,6 +1077,12 @@ # CONFIG_NLS_KOI8_U is not set
 # CONFIG_NLS_UTF8 is not set
 
 #
+# Distributed Lock Manager
+#
+CONFIG_DLM=m
+# CONFIG_DLM_DEBUG is not set
+
+#
 # iSeries device drivers
 #
 CONFIG_VIOCONS=y
@@ -1073,6 +1116,7 @@ #
 # Kernel hacking
 #
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_MUST_CHECK=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
@@ -1091,6 +1135,7 @@ # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
 # CONFIG_FORCED_INLINING is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
@@ -1109,6 +1154,10 @@ #
 # Cryptographic options
 #
 CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=m
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_MANAGER=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_NULL=m
 CONFIG_CRYPTO_MD4=m
@@ -1118,9 +1167,12 @@ CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_TGR192=m
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
+CONFIG_CRYPTO_TWOFISH_COMMON=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_AES=m
 CONFIG_CRYPTO_CAST5=m
-- 
1.4.2.1

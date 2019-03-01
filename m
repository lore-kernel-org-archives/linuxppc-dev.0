Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6D8C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 19:56:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A7620848
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 19:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Xth402W+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A7620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44B0YX0JtqzDqVW
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 06:56:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.86.75; helo=rcdn-iport-4.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="Xth402W+"; 
 dkim-atps=neutral
X-Greylist: delayed 642 seconds by postgrey-1.36 at bilbo;
 Sat, 02 Mar 2019 06:55:21 AEDT
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44B0Ws5Y3SzDq5h
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 06:55:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=12702; q=dns/txt;
 s=iport; t=1551470121; x=1552679721;
 h=from:to:cc:subject:date:message-id;
 bh=vP7r5v5r+hVEgevozqOTYs/5aZaL8r4xUEfZiuJrrJ4=;
 b=Xth402W+I29MKX6uysNrXLRQ8pcut1Vfm0o44SyHCcxOdaFab2KfcMw5
 IYqru6dG8/xmNh5GQrkCNSf98NQ7Z+pFRxo2fT/WaA9uiMt3mlvpBr8qT
 LT1eP+hfwP22/XXeH5wFmtecyDI5DE29EKvNmUV7k8lrTl6YKrgKvyXBw c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AmAAC/inlc/5NdJa1kHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBggSBayeMIqV3gXsNhGyEIyI0CQ0BAwEBAwEDAm0ohkopgRU?=
 =?us-ascii?q?TgyKBdQGsfoovFId0hEMXgUA/gRGNUiICihGZaQmCQJAvAheTIZ0mgUc4gVY?=
 =?us-ascii?q?zGggbFYMnkF0/M5BKAQE?=
X-IronPort-AV: E=Sophos;i="5.58,428,1544486400"; d="scan'208";a="526979981"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
 by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Mar 2019 19:44:39 +0000
Received: from sjc-ads-2388.cisco.com (sjc-ads-2388.cisco.com [171.70.63.76])
 by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id
 x21JiWLl018182; Fri, 1 Mar 2019 19:44:38 GMT
From: Daniel Walker <danielwa@cisco.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] powerpc: convert config files to generic cmdline
Date: Fri,  1 Mar 2019 19:44:31 +0000
Message-Id: <1551469472-53043-4-git-send-email-danielwa@cisco.com>
X-Mailer: git-send-email 2.7.4
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 171.70.63.76, sjc-ads-2388.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 xe-linux-external@cisco.com, Daniel Walker <dwalker@fifo99.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is a scripted mass convert of the config files to use
the new generic cmdline. There is a bit of a trim effect here.
It would seems that some of the config haven't been trimmed in
a while.

The script used to convert is as follows,

if [[ -z "$1" || -z "$2" ]]; then
        echo "Two arguments are needed."
        exit 1
fi
mkdir $1
cp $2 $1/.config
sed -i 's/CONFIG_CMDLINE=/CONFIG_CMDLINE_PREPEND=/g' $1/.config
make ARCH=$1 O=$1 olddefconfig
make ARCH=$1 O=$1 savedefconfig
cp $1/defconfig $2
rm -Rf $1

Cc: xe-linux-external@cisco.com
Cc: Daniel Walker <dwalker@fifo99.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 arch/powerpc/configs/44x/fsp2_defconfig       | 29 ++++++++--------
 arch/powerpc/configs/44x/iss476-smp_defconfig | 24 +++++++-------
 arch/powerpc/configs/44x/warp_defconfig       | 12 +++----
 arch/powerpc/configs/holly_defconfig          | 12 +++----
 arch/powerpc/configs/mvme5100_defconfig       | 25 +++++++-------
 arch/powerpc/configs/skiroot_defconfig        | 48 +++++++++++++--------------
 arch/powerpc/configs/storcenter_defconfig     | 15 ++++-----
 7 files changed, 80 insertions(+), 85 deletions(-)

diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index bae6b26bcfba..bafea495c9b8 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -1,8 +1,6 @@
-CONFIG_44x=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
-# CONFIG_FHANDLE is not set
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
@@ -13,25 +11,26 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
+# CONFIG_FHANDLE is not set
 CONFIG_KALLSYMS_ALL=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="ip=on rw"
+CONFIG_44x=y
 CONFIG_PPC_47x=y
 # CONFIG_EBONY is not set
 CONFIG_FSP2=y
 CONFIG_476FPE_ERR46=y
-CONFIG_SWIOTLB=y
 CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="ip=on rw"
 # CONFIG_SUSPEND is not set
 # CONFIG_PCI is not set
+CONFIG_OPROFILE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -112,6 +111,12 @@ CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_DEFAULT="n"
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_PCBC=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_HW is not set
 CONFIG_XZ_DEC=y
 CONFIG_PRINTK_TIME=y
 CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3
@@ -119,9 +124,3 @@ CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_ECB=y
-CONFIG_CRYPTO_PCBC=y
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/44x/iss476-smp_defconfig b/arch/powerpc/configs/44x/iss476-smp_defconfig
index d24bfa6ecd62..775b25178714 100644
--- a/arch/powerpc/configs/44x/iss476-smp_defconfig
+++ b/arch/powerpc/configs/44x/iss476-smp_defconfig
@@ -1,5 +1,3 @@
-CONFIG_44x=y
-CONFIG_SMP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -7,21 +5,23 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
-CONFIG_OPROFILE=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="root=/dev/issblk0"
+CONFIG_44x=y
+CONFIG_SMP=y
 CONFIG_PPC_47x=y
 # CONFIG_EBONY is not set
 CONFIG_ISS4xx=y
 CONFIG_HZ_100=y
 CONFIG_MATH_EMULATION=y
 CONFIG_IRQ_ALL_CPUS=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="root=/dev/issblk0"
 # CONFIG_PCI is not set
 CONFIG_ADVANCED_OPTIONS=y
 CONFIG_DYNAMIC_MEMSTART=y
+CONFIG_OPROFILE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -62,13 +62,13 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
-CONFIG_DEBUG_INFO=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_PPC_EARLY_DEBUG=y
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_HW is not set
+CONFIG_DEBUG_INFO=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_PPC_EARLY_DEBUG=y
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 6c02f53271cd..4b76897e323f 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -1,4 +1,3 @@
-CONFIG_44x=y
 CONFIG_LOCALVERSION="-pika"
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
@@ -7,16 +6,17 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="ip=on"
+CONFIG_44x=y
 # CONFIG_EBONY is not set
 CONFIG_WARP=y
 CONFIG_PPC4xx_GPIO=y
 CONFIG_HZ_1000=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="ip=on"
 # CONFIG_PCI is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/powerpc/configs/holly_defconfig b/arch/powerpc/configs/holly_defconfig
index 71d8d2430b6c..0f233b4f78eb 100644
--- a/arch/powerpc/configs/holly_defconfig
+++ b/arch/powerpc/configs/holly_defconfig
@@ -4,18 +4,18 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
-CONFIG_MODULES=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="console=ttyS0,115200"
 # CONFIG_PPC_CHRP is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_EMBEDDED6xx=y
 CONFIG_PPC_HOLLY=y
 CONFIG_GEN_RTC=y
-CONFIG_BINFMT_MISC=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,115200"
 # CONFIG_SECCOMP is not set
+CONFIG_MODULES=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/configs/mvme5100_defconfig
index 63e38c7220f1..29913bf3fb6e 100644
--- a/arch/powerpc/configs/mvme5100_defconfig
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -11,19 +11,19 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_NET_NS is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_COMPAT_BRK is not set
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="console=ttyS0,9600 ip=dhcp root=/dev/nfs"
 # CONFIG_PPC_CHRP is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_EMBEDDED6xx=y
 CONFIG_MVME5100=y
 CONFIG_KVM_GUEST=y
 CONFIG_HZ_100=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_COMPACTION is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,9600 ip=dhcp root=/dev/nfs"
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -46,7 +46,6 @@ CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NETFILTER_XT_MATCH_MAC=m
 CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
-CONFIG_NF_CONNTRACK_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
@@ -111,13 +110,6 @@ CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_932=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
-CONFIG_CRC_CCITT=m
-CONFIG_CRC_T10DIF=y
-CONFIG_XZ_DEC=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=20
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MD5=y
@@ -128,3 +120,10 @@ CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
+CONFIG_CRC_CCITT=m
+CONFIG_CRC_T10DIF=y
+CONFIG_XZ_DEC=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=20
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index cfdd08897a06..bf31334efbce 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -1,8 +1,3 @@
-CONFIG_PPC64=y
-CONFIG_ALTIVEC=y
-CONFIG_VSX=y
-CONFIG_NR_CPUS=2048
-CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_KERNEL_XZ=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
@@ -29,15 +24,13 @@ CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB_FREELIST_HARDENED=y
-CONFIG_JUMP_LABEL=y
-CONFIG_STRICT_KERNEL_RWX=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_SIG=y
-CONFIG_MODULE_SIG_FORCE=y
-CONFIG_MODULE_SIG_SHA512=y
-CONFIG_PARTITION_ADVANCED=y
-# CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="console=tty0 console=hvc0 ipr.fast_reboot=1 quiet"
+CONFIG_PPC64=y
+CONFIG_ALTIVEC=y
+CONFIG_VSX=y
+CONFIG_NR_CPUS=2048
+CONFIG_CPU_LITTLE_ENDIAN=y
 # CONFIG_PPC_VAS is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
@@ -47,15 +40,22 @@ CONFIG_HZ_100=y
 CONFIG_KEXEC=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_NUMA=y
-# CONFIG_COMPACTION is not set
-# CONFIG_MIGRATION is not set
-# CONFIG_BOUNCE is not set
 CONFIG_PPC_64K_PAGES=y
 CONFIG_SCHED_SMT=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=tty0 console=hvc0 ipr.fast_reboot=1 quiet"
 # CONFIG_SECCOMP is not set
 # CONFIG_PPC_MEM_KEYS is not set
+CONFIG_JUMP_LABEL=y
+CONFIG_STRICT_KERNEL_RWX=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_SIG=y
+CONFIG_MODULE_SIG_FORCE=y
+CONFIG_MODULE_SIG_SHA512=y
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_COMPACTION is not set
+# CONFIG_MIGRATION is not set
+# CONFIG_BOUNCE is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -139,7 +139,6 @@ CONFIG_ACENIC_OMIT_TIGON_I=y
 CONFIG_TIGON3=m
 CONFIG_BNX2X=m
 # CONFIG_NET_VENDOR_BROCADE is not set
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_CAVIUM is not set
 CONFIG_CHELSIO_T1=m
 # CONFIG_NET_VENDOR_CISCO is not set
@@ -155,7 +154,6 @@ CONFIG_IGB=m
 CONFIG_IXGB=m
 CONFIG_IXGBE=m
 CONFIG_I40E=m
-CONFIG_S2IO=m
 # CONFIG_NET_VENDOR_MARVELL is not set
 CONFIG_MLX4_EN=m
 # CONFIG_MLX4_CORE_GEN2 is not set
@@ -163,11 +161,11 @@ CONFIG_MLX5_CORE=m
 # CONFIG_NET_VENDOR_MICREL is not set
 CONFIG_MYRI10GE=m
 # CONFIG_NET_VENDOR_NATSEMI is not set
+CONFIG_S2IO=m
 # CONFIG_NET_VENDOR_NETRONOME is not set
 # CONFIG_NET_VENDOR_NI is not set
 # CONFIG_NET_VENDOR_NVIDIA is not set
 # CONFIG_NET_VENDOR_OKI is not set
-# CONFIG_NET_PACKET_ENGINE is not set
 CONFIG_QLGE=m
 CONFIG_NETXEN_NIC=m
 # CONFIG_NET_VENDOR_QUALCOMM is not set
@@ -268,6 +266,9 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
+CONFIG_ENCRYPTED_KEYS=y
+# CONFIG_CRYPTO_ECHAINIV is not set
+# CONFIG_CRYPTO_HW is not set
 CONFIG_CRC16=y
 CONFIG_CRC_ITU_T=y
 CONFIG_LIBCRC32C=y
@@ -289,6 +290,3 @@ CONFIG_WQ_WATCHDOG=y
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
-CONFIG_ENCRYPTED_KEYS=y
-# CONFIG_CRYPTO_ECHAINIV is not set
-# CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/storcenter_defconfig b/arch/powerpc/configs/storcenter_defconfig
index 74bca2eccd0f..8c849339bfe5 100644
--- a/arch/powerpc/configs/storcenter_defconfig
+++ b/arch/powerpc/configs/storcenter_defconfig
@@ -2,19 +2,19 @@ CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE_PREPEND="console=ttyS0,115200"
 # CONFIG_PPC_CHRP is not set
 # CONFIG_PPC_PMAC is not set
 CONFIG_EMBEDDED6xx=y
 CONFIG_STORCENTER=y
 CONFIG_HZ_100=y
-CONFIG_BINFMT_MISC=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyS0,115200"
 # CONFIG_SECCOMP is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_PACKET=m
 CONFIG_UNIX=y
@@ -81,5 +81,4 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_CRC_T10DIF=y
-# CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
-- 
2.14.1


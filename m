Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 21315DDF08
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:26:56 +1000 (EST)
Message-ID: <4818F1E0.4010609@am.sony.com>
Date: Wed, 30 Apr 2008 15:25:36 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 5/5] PS3: Update ps3_defconfig
References: <20080430215644.655638516@am.sony.com>
In-Reply-To: <20080430215644.655638516@am.sony.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update ps3_defconfig.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/configs/ps3_defconfig |  132 +++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 48 deletions(-)

--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc6
-# Thu Mar 20 11:07:04 2008
+# Linux kernel version: 2.6.25
+# Mon Apr 28 12:39:10 2008
 #
 CONFIG_PPC64=y
 
@@ -30,6 +30,9 @@ CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_HAVE_SETUP_PER_CPU_AREA=y
 CONFIG_IRQ_PER_CPU=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_ARCH_HAS_ILOG2_U64=y
@@ -73,8 +76,6 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_CGROUPS is not set
 # CONFIG_GROUP_SCHED is not set
-# CONFIG_USER_SCHED is not set
-# CONFIG_CGROUP_SCHED is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
@@ -161,7 +162,6 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_PASEMI is not set
-# CONFIG_PPC_CELLEB is not set
 CONFIG_PPC_PS3=y
 
 #
@@ -181,6 +181,7 @@ CONFIG_PS3_LPM=m
 CONFIG_PPC_CELL=y
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_IBM_CELL_BLADE is not set
+# CONFIG_PPC_CELLEB is not set
 
 #
 # Cell Broadband Engine options
@@ -205,9 +206,9 @@ CONFIG_SPU_BASE=y
 #
 # Kernel options
 #
-# CONFIG_TICK_ONESHOT is not set
+CONFIG_TICK_ONESHOT=y
 # CONFIG_NO_HZ is not set
-# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
@@ -221,7 +222,6 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_BINFMT_ELF=y
 CONFIG_COMPAT_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
-CONFIG_FORCE_MAX_ZONEORDER=13
 # CONFIG_IOMMU_VMERGE is not set
 CONFIG_IOMMU_HELPER=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
@@ -255,6 +255,7 @@ CONFIG_BOUNCE=y
 CONFIG_ARCH_MEMORY_PROBE=y
 # CONFIG_PPC_HAS_HASH_64K is not set
 # CONFIG_PPC_64K_PAGES is not set
+CONFIG_FORCE_MAX_ZONEORDER=13
 # CONFIG_SCHED_SMT is not set
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
@@ -272,7 +273,9 @@ CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 # CONFIG_PCCARD is not set
+CONFIG_PAGE_OFFSET=0xc000000000000000
 CONFIG_KERNEL_START=0xc000000000000000
+CONFIG_PHYSICAL_START=0x00000000
 
 #
 # Networking
@@ -292,7 +295,7 @@ CONFIG_XFRM=y
 # CONFIG_XFRM_STATISTICS is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
-# CONFIG_IP_MULTICAST is not set
+CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_FIB_HASH=y
 CONFIG_IP_PNP=y
@@ -301,6 +304,7 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
 # CONFIG_ARPD is not set
 # CONFIG_SYN_COOKIES is not set
 # CONFIG_INET_AH is not set
@@ -332,8 +336,10 @@ CONFIG_INET6_XFRM_MODE_TUNNEL=y
 CONFIG_INET6_XFRM_MODE_BEET=y
 # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
 CONFIG_IPV6_SIT=y
+CONFIG_IPV6_NDISC_NODETYPE=y
 # CONFIG_IPV6_TUNNEL is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
+# CONFIG_IPV6_MROUTE is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
@@ -392,8 +398,6 @@ CONFIG_IEEE80211=m
 CONFIG_IEEE80211_CRYPT_WEP=m
 CONFIG_IEEE80211_CRYPT_CCMP=m
 CONFIG_IEEE80211_CRYPT_TKIP=m
-CONFIG_IEEE80211_SOFTMAC=m
-# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
 # CONFIG_RFKILL is not set
 # CONFIG_NET_9P is not set
 
@@ -507,6 +511,7 @@ CONFIG_WLAN_80211=y
 # CONFIG_LIBERTAS is not set
 # CONFIG_USB_ZD1201 is not set
 # CONFIG_USB_NET_RNDIS_WLAN is not set
+# CONFIG_IWLWIFI_LEDS is not set
 # CONFIG_HOSTAP is not set
 
 #
@@ -578,6 +583,7 @@ CONFIG_INPUT_JOYSTICK=y
 # CONFIG_JOYSTICK_SPACEBALL is not set
 # CONFIG_JOYSTICK_STINGER is not set
 # CONFIG_JOYSTICK_TWIDJOY is not set
+# CONFIG_JOYSTICK_ZHENHUA is not set
 # CONFIG_JOYSTICK_JOYDUMP is not set
 # CONFIG_JOYSTICK_XPAD is not set
 # CONFIG_INPUT_TABLET is not set
@@ -641,6 +647,7 @@ CONFIG_SSB_POSSIBLE=y
 # Multifunction device drivers
 #
 # CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
 
 #
 # Multimedia devices
@@ -761,10 +768,6 @@ CONFIG_SND_PS3_DEFAULT_START_DELAY=2000
 # CONFIG_SND_SOC is not set
 
 #
-# SoC Audio support for SuperH
-#
-
-#
 # ALSA SoC audio for Freescale SOCs
 #
 
@@ -849,6 +852,7 @@ CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_ALAUDA is not set
 # CONFIG_USB_STORAGE_ONETOUCH is not set
 # CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
@@ -893,10 +897,6 @@ CONFIG_USB_MON=y
 # CONFIG_EDAC is not set
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
-
-#
-# Userspace I/O
-#
 # CONFIG_UIO is not set
 
 #
@@ -986,7 +986,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 CONFIG_NFS_V4=y
-# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
@@ -1059,9 +1058,10 @@ CONFIG_NLS_ISO8859_1=y
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
-# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC_ITU_T=m
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
@@ -1071,6 +1071,7 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
 
 #
 # Kernel hacking
@@ -1078,6 +1079,7 @@ CONFIG_HAS_DMA=y
 # CONFIG_PRINTK_TIME is not set
 CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=2048
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
@@ -1093,12 +1095,16 @@ CONFIG_SCHED_DEBUG=y
 # CONFIG_RT_MUTEX_TESTER is not set
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
 CONFIG_DEBUG_LIST=y
 # CONFIG_DEBUG_SG is not set
 # CONFIG_BOOT_PRINTK_DELAY is not set
@@ -1121,51 +1127,81 @@ CONFIG_IRQSTACKS=y
 # CONFIG_SECURITY is not set
 # CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_AEAD=m
 CONFIG_CRYPTO_BLKCIPHER=y
-CONFIG_CRYPTO_SEQIV=m
 CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_GF128MUL=m
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+CONFIG_CRYPTO_CCM=m
+CONFIG_CRYPTO_GCM=m
+CONFIG_CRYPTO_SEQIV=m
+
+#
+# Block modes
+#
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_CTR=m
+# CONFIG_CRYPTO_CTS is not set
+CONFIG_CRYPTO_ECB=m
+# CONFIG_CRYPTO_LRW is not set
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
 # CONFIG_CRYPTO_HMAC is not set
 # CONFIG_CRYPTO_XCBC is not set
-# CONFIG_CRYPTO_NULL is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_MICHAEL_MIC=m
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
-# CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
-CONFIG_CRYPTO_GF128MUL=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_LRW is not set
-# CONFIG_CRYPTO_XTS is not set
-CONFIG_CRYPTO_CTR=m
-CONFIG_CRYPTO_GCM=m
-CONFIG_CRYPTO_CCM=m
-# CONFIG_CRYPTO_CRYPTD is not set
-CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_FCRYPT is not set
-# CONFIG_CRYPTO_BLOWFISH is not set
-# CONFIG_CRYPTO_TWOFISH is not set
-# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
 CONFIG_CRYPTO_AES=m
+# CONFIG_CRYPTO_ANUBIS is not set
+CONFIG_CRYPTO_ARC4=m
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_CAST5 is not set
 # CONFIG_CRYPTO_CAST6 is not set
-# CONFIG_CRYPTO_TEA is not set
-CONFIG_CRYPTO_ARC4=m
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_KHAZAD is not set
-# CONFIG_CRYPTO_ANUBIS is not set
-# CONFIG_CRYPTO_SEED is not set
 CONFIG_CRYPTO_SALSA20=m
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
 # CONFIG_CRYPTO_DEFLATE is not set
-CONFIG_CRYPTO_MICHAEL_MIC=m
-# CONFIG_CRYPTO_CRC32C is not set
-# CONFIG_CRYPTO_CAMELLIA is not set
-# CONFIG_CRYPTO_TEST is not set
-# CONFIG_CRYPTO_AUTHENC is not set
 CONFIG_CRYPTO_LZO=m
 CONFIG_CRYPTO_HW=y
 # CONFIG_PPC_CLOCK is not set
+# CONFIG_VIRTUALIZATION is not set

-- 

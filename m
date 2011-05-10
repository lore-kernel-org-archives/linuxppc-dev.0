Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 21A0AB6F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 04:02:06 +1000 (EST)
Date: Tue, 10 May 2011 13:01:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc,e5500: add networking to defconfig
Message-ID: <20110510180147.GA18443@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Even though support for the p5020's on-chip ethernet is not yet upstream,
it is not appropriate to disable all networking support (including
loopback, unix domain sockets, external ethernet devices, etc) in the
defconfig.  The networking settings are taken from mpc85xx_smp_defconfig,
minus the drivers for ethernet devices not found on any current e5500
chip.

The other changes are the result of running "make savedefconfig".

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/configs/e55xx_smp_defconfig |   38 ++++++++++++++++++++++-------
 1 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/configs/e55xx_smp_defconfig b/arch/powerpc/configs/e55xx_smp_defconfig
index 9fa1613..f4c5780 100644
--- a/arch/powerpc/configs/e55xx_smp_defconfig
+++ b/arch/powerpc/configs/e55xx_smp_defconfig
@@ -6,10 +6,10 @@ CONFIG_NR_CPUS=2
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_SPARSE_IRQ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
@@ -25,8 +25,32 @@ CONFIG_P5020_DS=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BINFMT_MISC=m
-CONFIG_SPARSE_IRQ=y
 # CONFIG_PCI is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM_USER=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_NET_IPIP=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+CONFIG_ARPD=y
+CONFIG_INET_ESP=y
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_IPV6=y
+CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
@@ -34,6 +58,9 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
 CONFIG_MISC_DEVICES=y
 CONFIG_EEPROM_LEGACY=y
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=y
+CONFIG_NET_ETHERNET=y
 CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -64,7 +91,6 @@ CONFIG_NLS=y
 CONFIG_NLS_UTF8=m
 CONFIG_CRC_T10DIF=y
 CONFIG_CRC_ITU_T=m
-CONFIG_LIBCRC32C=m
 CONFIG_FRAME_WARN=1024
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
@@ -74,12 +100,6 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_RCU_CPU_STALL_DETECTOR is not set
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_VIRQ_DEBUG=y
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_DEV_TALITOS=y
-- 
1.7.4.1

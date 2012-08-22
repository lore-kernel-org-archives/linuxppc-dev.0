Return-Path: <R1AAHA@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8816F2C00B2
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2012 04:45:42 +1000 (EST)
Date: Wed, 22 Aug 2012 13:43:30 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2 v2] powerpc/fsl: fix
 "Failed to mount /dev: No such device" errors
Message-ID: <20120822134330.288990f2699569868923c23c@freescale.com>
In-Reply-To: <94E5411D-0FC7-46AF-BDE4-FC87416DF805@kernel.crashing.org>
References: <20120821172303.53d5698006b32063dca99300@freescale.com>
 <94E5411D-0FC7-46AF-BDE4-FC87416DF805@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yocto (Built by Poky 7.0) 1.2 root filesystems fail to boot,
at least over nfs, with:

Failed to mount /dev: No such device

Configuring DEVTMPFS fixes it.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
v2: separated savedefconfig updates, rebased on merge branch

 arch/powerpc/configs/85xx/p1023rds_defconfig | 1 +
 arch/powerpc/configs/corenet32_smp_defconfig | 1 +
 arch/powerpc/configs/corenet64_smp_defconfig | 1 +
 arch/powerpc/configs/mpc83xx_defconfig       | 1 +
 arch/powerpc/configs/mpc85xx_defconfig       | 1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig   | 1 +
 6 files changed, 6 insertions(+)

diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023rds_defconfig
index a79b0a9..26e541c 100644
--- a/arch/powerpc/configs/85xx/p1023rds_defconfig
+++ b/arch/powerpc/configs/85xx/p1023rds_defconfig
@@ -62,6 +62,7 @@ CONFIG_INET_ESP=y
 CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index f085699..8b3d57c 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -69,6 +69,7 @@ CONFIG_INET_IPCOMP=y
 CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index dd89de8..0516e22 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -56,6 +56,7 @@ CONFIG_INET_ESP=y
 CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index e116dc9..9352e44 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -41,6 +41,7 @@ CONFIG_INET_ESP=y
 # CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
 CONFIG_MTD_CHAR=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index a036a62..8b5bda2 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -76,6 +76,7 @@ CONFIG_INET_ESP=y
 CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 4ba5255..b0974e7 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -79,6 +79,7 @@ CONFIG_INET_ESP=y
 CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
-- 
1.7.11.4

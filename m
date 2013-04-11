Return-Path: <B19537@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1F1D72C00B2
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Apr 2013 23:53:12 +1000 (EST)
Received: from mail201-co9 (localhost [127.0.0.1])	by
 mail201-co9-R.bigfish.com (Postfix) with ESMTP id 08A1F3C0196	for
 <linuxppc-dev@ozlabs.org>; Thu, 11 Apr 2013 13:53:10 +0000 (UTC)
Received: from CO9EHSMHS004.bigfish.com (unknown [10.236.132.235])	by
 mail201-co9.bigfish.com (Postfix) with ESMTP id 1ED9B80129	for
 <linuxppc-dev@ozlabs.org>; Thu, 11 Apr 2013 13:53:08 +0000 (UTC)
From: Zhenhua Luo <zhenhua.luo@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Enable CONFIG_DEVTMPFS_MOUNT to ensure /dev can be mounted
 correctly
Date: Thu, 11 Apr 2013 21:56:30 +0800
Message-ID: <1365688591-5323-1-git-send-email-zhenhua.luo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhenhua Luo <zhenhua.luo@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using recent udev, the /dev node mount requires CONFIG_DEVTMPFS_MOUNT
is enabled in Kernel. The patch enables the option in defconfig of Freescale
QorIQ targets.

Changed defconfig list:
   arch/powerpc/configs/85xx/p1023rds_defconfig
   arch/powerpc/configs/corenet32_smp_defconfig
   arch/powerpc/configs/corenet64_smp_defconfig
   arch/powerpc/configs/mpc85xx_smp_defconfig

Signed-off-by: Zhenhua Luo <zhenhua.luo@freescale.com>
---
 arch/powerpc/configs/85xx/p1023rds_defconfig |    1 +
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/configs/corenet64_smp_defconfig |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023rds_defconfig
index b80bcc6..18badca 100644
--- a/arch/powerpc/configs/85xx/p1023rds_defconfig
+++ b/arch/powerpc/configs/85xx/p1023rds_defconfig
@@ -63,6 +63,7 @@ CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 60027c2..3dfab4c 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -70,6 +70,7 @@ CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index 3d139fa..914dd3f 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -57,6 +57,7 @@ CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 8d00ea5b..d2d5135 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -80,6 +80,7 @@ CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
-- 
1.7.5.4

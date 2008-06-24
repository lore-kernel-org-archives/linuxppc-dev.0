Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4A8FDDF68
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 07:24:11 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix ALSA options in Freescale 85xx and 86xx
	defconfigs
Date: Tue, 24 Jun 2008 16:23:53 -0500
Message-Id: <1214342633-1588-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The defconfigs for Freescale 85xx and 86xx SOCs had bad choices for some
audio related options.  In particular, OSS emulation should be enabled,
and the old ALSA API should be disabled.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Kumar, this patch is for 2.6.27.

 arch/powerpc/configs/85xx/mpc8544_ds_defconfig |    8 +++++---
 arch/powerpc/configs/85xx/mpc8572_ds_defconfig |    8 +++++---
 arch/powerpc/configs/mpc85xx_defconfig         |    8 +++++---
 arch/powerpc/configs/mpc8610_hpcd_defconfig    |    2 +-
 arch/powerpc/configs/mpc8641_hpcn_defconfig    |    8 +++++---
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/configs/85xx/mpc8544_ds_defconfig b/arch/powerpc/configs/85xx/mpc8544_ds_defconfig
index a9f113b..19d0864 100644
--- a/arch/powerpc/configs/85xx/mpc8544_ds_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8544_ds_defconfig
@@ -976,10 +976,12 @@ CONFIG_SND=y
 CONFIG_SND_TIMER=y
 CONFIG_SND_PCM=y
 # CONFIG_SND_SEQUENCER is not set
-# CONFIG_SND_MIXER_OSS is not set
-# CONFIG_SND_PCM_OSS is not set
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+CONFIG_SND_PCM_OSS_PLUGINS=y
 # CONFIG_SND_DYNAMIC_MINORS is not set
-CONFIG_SND_SUPPORT_OLD_API=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
 CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_VERBOSE_PRINTK is not set
 # CONFIG_SND_DEBUG is not set
diff --git a/arch/powerpc/configs/85xx/mpc8572_ds_defconfig b/arch/powerpc/configs/85xx/mpc8572_ds_defconfig
index 53aa6f3..10f82d1 100644
--- a/arch/powerpc/configs/85xx/mpc8572_ds_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8572_ds_defconfig
@@ -974,10 +974,12 @@ CONFIG_SND=y
 CONFIG_SND_TIMER=y
 CONFIG_SND_PCM=y
 # CONFIG_SND_SEQUENCER is not set
-# CONFIG_SND_MIXER_OSS is not set
-# CONFIG_SND_PCM_OSS is not set
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+CONFIG_SND_PCM_OSS_PLUGINS=y
 # CONFIG_SND_DYNAMIC_MINORS is not set
-CONFIG_SND_SUPPORT_OLD_API=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
 CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_VERBOSE_PRINTK is not set
 # CONFIG_SND_DEBUG is not set
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index 2075722..54937a8 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -982,10 +982,12 @@ CONFIG_SND=y
 CONFIG_SND_TIMER=y
 CONFIG_SND_PCM=y
 # CONFIG_SND_SEQUENCER is not set
-# CONFIG_SND_MIXER_OSS is not set
-# CONFIG_SND_PCM_OSS is not set
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+CONFIG_SND_PCM_OSS_PLUGINS=y
 # CONFIG_SND_DYNAMIC_MINORS is not set
-CONFIG_SND_SUPPORT_OLD_API=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
 CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_VERBOSE_PRINTK is not set
 # CONFIG_SND_DEBUG is not set
diff --git a/arch/powerpc/configs/mpc8610_hpcd_defconfig b/arch/powerpc/configs/mpc8610_hpcd_defconfig
index 7e5b9ce..6a582e2 100644
--- a/arch/powerpc/configs/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/mpc8610_hpcd_defconfig
@@ -938,7 +938,7 @@ CONFIG_SND_PCM=y
 CONFIG_SND_OSSEMUL=y
 CONFIG_SND_MIXER_OSS=y
 CONFIG_SND_PCM_OSS=y
-# CONFIG_SND_PCM_OSS_PLUGINS is not set
+CONFIG_SND_PCM_OSS_PLUGINS=y
 # CONFIG_SND_DYNAMIC_MINORS is not set
 # CONFIG_SND_SUPPORT_OLD_API is not set
 CONFIG_SND_VERBOSE_PROCFS=y
diff --git a/arch/powerpc/configs/mpc8641_hpcn_defconfig b/arch/powerpc/configs/mpc8641_hpcn_defconfig
index d01dcdb..1e5557d 100644
--- a/arch/powerpc/configs/mpc8641_hpcn_defconfig
+++ b/arch/powerpc/configs/mpc8641_hpcn_defconfig
@@ -968,10 +968,12 @@ CONFIG_SND=y
 CONFIG_SND_TIMER=y
 CONFIG_SND_PCM=y
 # CONFIG_SND_SEQUENCER is not set
-# CONFIG_SND_MIXER_OSS is not set
-# CONFIG_SND_PCM_OSS is not set
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+CONFIG_SND_PCM_OSS_PLUGINS=y
 # CONFIG_SND_DYNAMIC_MINORS is not set
-CONFIG_SND_SUPPORT_OLD_API=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
 CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_VERBOSE_PRINTK is not set
 # CONFIG_SND_DEBUG is not set
-- 
1.5.5

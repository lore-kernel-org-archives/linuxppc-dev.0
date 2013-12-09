Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 785F92C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 08:15:53 +1100 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
 [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3ddcdH3kyNz3hk1W
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2013 22:15:44 +0100 (CET)
Received: from localhost (p4FDE751A.dip0.t-ipconnect.de [79.222.117.26])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA id 3ddcdD2kFNzbbcc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2013 22:15:44 +0100 (CET)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/52xx: re-enable bestcomm driver in defconfigs
Date: Mon,  9 Dec 2013 22:15:44 +0100
Message-Id: <1386623744-25970-1-git-send-email-agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The bestcomm driver has been moved to drivers/dma, so to select
this driver by default additionally CONFIG_DMADEVICES has to be
enabled. Currently it is not enabled in the config despite existing
CONFIG_PPC_BESTCOMM=y in the config files. Fix it.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/configs/52xx/cm5200_defconfig    |    3 ++-
 arch/powerpc/configs/52xx/lite5200b_defconfig |    3 ++-
 arch/powerpc/configs/52xx/motionpro_defconfig |    3 ++-
 arch/powerpc/configs/52xx/pcm030_defconfig    |    3 ++-
 arch/powerpc/configs/52xx/tqm5200_defconfig   |    3 ++-
 arch/powerpc/configs/mpc5200_defconfig        |    3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/configs/52xx/cm5200_defconfig b/arch/powerpc/configs/52xx/cm5200_defconfig
index 69b57da..0b88c7b 100644
--- a/arch/powerpc/configs/52xx/cm5200_defconfig
+++ b/arch/powerpc/configs/52xx/cm5200_defconfig
@@ -12,7 +12,6 @@ CONFIG_EXPERT=y
 CONFIG_PPC_MPC52xx=y
 CONFIG_PPC_MPC5200_SIMPLE=y
 # CONFIG_PPC_PMAC is not set
-CONFIG_PPC_BESTCOMM=y
 CONFIG_SPARSE_IRQ=y
 CONFIG_PM=y
 # CONFIG_PCI is not set
@@ -71,6 +70,8 @@ CONFIG_USB_DEVICEFS=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
 CONFIG_USB_STORAGE=y
+CONFIG_DMADEVICES=y
+CONFIG_PPC_BESTCOMM=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
diff --git a/arch/powerpc/configs/52xx/lite5200b_defconfig b/arch/powerpc/configs/52xx/lite5200b_defconfig
index f3638ae..104a332 100644
--- a/arch/powerpc/configs/52xx/lite5200b_defconfig
+++ b/arch/powerpc/configs/52xx/lite5200b_defconfig
@@ -15,7 +15,6 @@ CONFIG_PPC_MPC52xx=y
 CONFIG_PPC_MPC5200_SIMPLE=y
 CONFIG_PPC_LITE5200=y
 # CONFIG_PPC_PMAC is not set
-CONFIG_PPC_BESTCOMM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SPARSE_IRQ=y
@@ -59,6 +58,8 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_MPC=y
 # CONFIG_HWMON is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
+CONFIG_DMADEVICES=y
+CONFIG_PPC_BESTCOMM=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig b/arch/powerpc/configs/52xx/motionpro_defconfig
index 0c7de96..0d13ad7 100644
--- a/arch/powerpc/configs/52xx/motionpro_defconfig
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig
@@ -12,7 +12,6 @@ CONFIG_EXPERT=y
 CONFIG_PPC_MPC52xx=y
 CONFIG_PPC_MPC5200_SIMPLE=y
 # CONFIG_PPC_PMAC is not set
-CONFIG_PPC_BESTCOMM=y
 CONFIG_SPARSE_IRQ=y
 CONFIG_PM=y
 # CONFIG_PCI is not set
@@ -84,6 +83,8 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
+CONFIG_DMADEVICES=y
+CONFIG_PPC_BESTCOMM=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
diff --git a/arch/powerpc/configs/52xx/pcm030_defconfig b/arch/powerpc/configs/52xx/pcm030_defconfig
index 22e7195..430aa18 100644
--- a/arch/powerpc/configs/52xx/pcm030_defconfig
+++ b/arch/powerpc/configs/52xx/pcm030_defconfig
@@ -21,7 +21,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PPC_MPC52xx=y
 CONFIG_PPC_MPC5200_SIMPLE=y
 # CONFIG_PPC_PMAC is not set
-CONFIG_PPC_BESTCOMM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_100=y
@@ -87,6 +86,8 @@ CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
 CONFIG_USB_STORAGE=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PCF8563=m
+CONFIG_DMADEVICES=y
+CONFIG_PPC_BESTCOMM=y
 CONFIG_EXT2_FS=m
 CONFIG_EXT3_FS=m
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
diff --git a/arch/powerpc/configs/52xx/tqm5200_defconfig b/arch/powerpc/configs/52xx/tqm5200_defconfig
index 716a37b..7af4c5b 100644
--- a/arch/powerpc/configs/52xx/tqm5200_defconfig
+++ b/arch/powerpc/configs/52xx/tqm5200_defconfig
@@ -17,7 +17,6 @@ CONFIG_PPC_MPC52xx=y
 CONFIG_PPC_MPC5200_SIMPLE=y
 CONFIG_PPC_MPC5200_BUGFIX=y
 # CONFIG_PPC_PMAC is not set
-CONFIG_PPC_BESTCOMM=y
 CONFIG_PM=y
 # CONFIG_PCI is not set
 CONFIG_NET=y
@@ -86,6 +85,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_DS1374=y
+CONFIG_DMADEVICES=y
+CONFIG_PPC_BESTCOMM=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index 6640a35..8b682d1c 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -15,7 +15,6 @@ CONFIG_PPC_MEDIA5200=y
 CONFIG_PPC_MPC5200_BUGFIX=y
 CONFIG_PPC_MPC5200_LPBFIFO=m
 # CONFIG_PPC_PMAC is not set
-CONFIG_PPC_BESTCOMM=y
 CONFIG_SIMPLE_GPIO=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -125,6 +124,8 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_RTC_DRV_PCF8563=m
+CONFIG_DMADEVICES=y
+CONFIG_PPC_BESTCOMM=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-- 
1.7.9.5

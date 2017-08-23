Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcbn25SF2zDrHC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 15:38:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/46] powerpc/configs: Explicitly drop CONFIG_INPUT_MOUSEDEV
Date: Wed, 23 Aug 2017 15:37:23 +1000
Message-Id: <1503466686-10932-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
References: <1503466686-10932-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 73d8ef76006b ("Input: mousedev - stop offering PS/2 to userspace by
default") (Jan 2017), CONFIG_INPUT_MOUSEDEV was switched from default y to
default n, with the explanation:

  Evdev interface has been available for many years and by now everyone
  is switched to using it, so let's stop offering /dev/input/mouseN
  and /dev/psaux by default.

We had a number of configs which had it enabled, but going by the above
explanation probably don't need it enabled anymore.

So drop the last remnants of it from our defconfigs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/44x/icon_defconfig      | 2 --
 arch/powerpc/configs/85xx/socrates_defconfig | 2 --
 arch/powerpc/configs/85xx/stx_gp3_defconfig  | 2 --
 arch/powerpc/configs/c2k_defconfig           | 1 -
 arch/powerpc/configs/cell_defconfig          | 1 -
 arch/powerpc/configs/g5_defconfig            | 1 -
 arch/powerpc/configs/linkstation_defconfig   | 1 -
 arch/powerpc/configs/maple_defconfig         | 3 ---
 arch/powerpc/configs/mpc512x_defconfig       | 1 -
 arch/powerpc/configs/mvme5100_defconfig      | 1 -
 arch/powerpc/configs/powernv_defconfig       | 1 -
 arch/powerpc/configs/ppc64_defconfig         | 1 -
 arch/powerpc/configs/ppc64e_defconfig        | 1 -
 arch/powerpc/configs/ppc6xx_defconfig        | 1 -
 arch/powerpc/configs/ps3_defconfig           | 1 -
 arch/powerpc/configs/pseries_defconfig       | 1 -
 arch/powerpc/configs/wii_defconfig           | 3 ---
 17 files changed, 24 deletions(-)

diff --git a/arch/powerpc/configs/44x/icon_defconfig b/arch/powerpc/configs/44x/icon_defconfig
index 87bd812a57c5..4453a4590b1a 100644
--- a/arch/powerpc/configs/44x/icon_defconfig
+++ b/arch/powerpc/configs/44x/icon_defconfig
@@ -47,8 +47,6 @@ CONFIG_FUSION_LOGGING=y
 CONFIG_NETDEVICES=y
 CONFIG_IBM_EMAC=y
 # CONFIG_WLAN is not set
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=640
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480
 # CONFIG_MOUSE_PS2_ALPS is not set
 # CONFIG_MOUSE_PS2_LOGIPS2PP is not set
 # CONFIG_MOUSE_PS2_SYNAPTICS is not set
diff --git a/arch/powerpc/configs/85xx/socrates_defconfig b/arch/powerpc/configs/85xx/socrates_defconfig
index 46b479001805..6106fadbbd8b 100644
--- a/arch/powerpc/configs/85xx/socrates_defconfig
+++ b/arch/powerpc/configs/85xx/socrates_defconfig
@@ -42,8 +42,6 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_MARVELL_PHY=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=800
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/powerpc/configs/85xx/stx_gp3_defconfig b/arch/powerpc/configs/85xx/stx_gp3_defconfig
index 9edba010d1bc..5b9cc01b9098 100644
--- a/arch/powerpc/configs/85xx/stx_gp3_defconfig
+++ b/arch/powerpc/configs/85xx/stx_gp3_defconfig
@@ -39,8 +39,6 @@ CONFIG_SCSI_CONSTANTS=y
 CONFIG_NETDEVICES=y
 CONFIG_GIANFAR=y
 CONFIG_MARVELL_PHY=y
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
 CONFIG_INPUT_JOYDEV=m
 CONFIG_INPUT_EVDEV=m
 # CONFIG_VT is not set
diff --git a/arch/powerpc/configs/c2k_defconfig b/arch/powerpc/configs/c2k_defconfig
index 8c954a7b2e5b..5419d3eb852a 100644
--- a/arch/powerpc/configs/c2k_defconfig
+++ b/arch/powerpc/configs/c2k_defconfig
@@ -197,7 +197,6 @@ CONFIG_TUN=m
 # CONFIG_ATM_DRIVERS is not set
 CONFIG_MV643XX_ETH=y
 CONFIG_VITESSE_PHY=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 708a538484a6..2950aa97878b 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -142,7 +142,6 @@ CONFIG_SKY2=m
 CONFIG_GELIC_NET=m
 CONFIG_GELIC_WIRELESS=y
 CONFIG_SPIDER_NET=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO_I8042 is not set
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index cda8afa485a5..6e957e98b108 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -116,7 +116,6 @@ CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_NET1080 is not set
 # CONFIG_USB_NET_CDC_SUBSET is not set
 # CONFIG_USB_NET_ZAURUS is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_JOYDEV=m
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index 5c78ee9f5d6a..8f5cd4d0e80b 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -79,7 +79,6 @@ CONFIG_NET_TULIP=y
 CONFIG_TULIP=y
 CONFIG_TULIP_MMIO=y
 CONFIG_R8169=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
diff --git a/arch/powerpc/configs/maple_defconfig b/arch/powerpc/configs/maple_defconfig
index 3f93d696966c..0ebd376d8829 100644
--- a/arch/powerpc/configs/maple_defconfig
+++ b/arch/powerpc/configs/maple_defconfig
@@ -54,9 +54,6 @@ CONFIG_AMD8111_ETH=y
 CONFIG_TIGON3=y
 CONFIG_E1000=y
 CONFIG_USB_PEGASUS=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index d59e1bad2ba5..dbb61ded3849 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -78,7 +78,6 @@ CONFIG_STE10XP=y
 CONFIG_VITESSE_PHY=y
 CONFIG_FIXED_PHY=y
 # CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_MPC52xx=y
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/configs/mvme5100_defconfig
index b3b2775e6ae9..960a30c1d0c8 100644
--- a/arch/powerpc/configs/mvme5100_defconfig
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -70,7 +70,6 @@ CONFIG_TUN=m
 # CONFIG_NET_VENDOR_3COM is not set
 CONFIG_E100=y
 # CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 7a798e05d1ff..28de9139e914 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -183,7 +183,6 @@ CONFIG_PPP_DEFLATE=m
 CONFIG_PPPOE=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 # CONFIG_SERIO_SERPORT is not set
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 73c0293b1142..c97fcbded986 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -188,7 +188,6 @@ CONFIG_PPP_DEFLATE=m
 CONFIG_PPPOE=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PCSPKR=m
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index f67e49e201fd..7f34b3546092 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -116,7 +116,6 @@ CONFIG_PPP_DEFLATE=m
 CONFIG_PPPOE=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 # CONFIG_SERIO_SERPORT is not set
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 0bfbe29f696a..c55b7016326c 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -584,7 +584,6 @@ CONFIG_USB_ALI_M5632=y
 CONFIG_USB_AN2720=y
 CONFIG_USB_EPSON2888=y
 CONFIG_USB_KC2190=y
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_JOYDEV=m
 CONFIG_INPUT_EVDEV=y
 CONFIG_MOUSE_SERIAL=m
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index ee0ec5a682fc..240f39670794 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -94,7 +94,6 @@ CONFIG_USB_USBNET=m
 # CONFIG_USB_NET_CDC_SUBSET is not set
 # CONFIG_USB_NET_ZAURUS is not set
 CONFIG_INPUT_FF_MEMLESS=m
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_JOYDEV=m
 CONFIG_INPUT_EVDEV=m
 # CONFIG_INPUT_KEYBOARD is not set
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 06b1e65e19ba..75707d669afc 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -182,7 +182,6 @@ CONFIG_PPP_DEFLATE=m
 CONFIG_PPPOE=m
 CONFIG_PPP_ASYNC=m
 CONFIG_PPP_SYNC_TTY=m
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PCSPKR=m
diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 5ab977c1fb1f..600e71c1125b 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -55,9 +55,6 @@ CONFIG_B43_SDIO=y
 # CONFIG_B43_PHY_LP is not set
 CONFIG_B43_DEBUG=y
 CONFIG_INPUT_FF_MEMLESS=m
-# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
-CONFIG_INPUT_MOUSEDEV_SCREEN_X=640
-CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
-- 
2.7.4

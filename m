Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CA109B7D19
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 20:36:40 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/44x: icon: select SM502 and frame buffer console
	support
Date: Wed, 26 May 2010 12:36:30 +0200
Message-Id: <1274870190-4712-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enables SM502 frame buffer and framebuffer console
in the default config file

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/configs/44x/icon_defconfig |  149 +++++++++++++++++++++++++++++--
 1 files changed, 142 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/configs/44x/icon_defconfig b/arch/powerpc/configs/44x/icon_defconfig
index 40a755b..277f88c 100644
--- a/arch/powerpc/configs/44x/icon_defconfig
+++ b/arch/powerpc/configs/44x/icon_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.34-rc5
-# Mon Apr 26 16:44:40 2010
+# Linux kernel version: 2.6.34-rc7
+# Fri May 21 17:40:22 2010
 #
 # CONFIG_PPC64 is not set
 
@@ -691,18 +691,74 @@ CONFIG_IBM_NEW_EMAC_EMAC4=y
 #
 # Input device support
 #
-# CONFIG_INPUT is not set
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+# CONFIG_INPUT_SPARSEKMAP is not set
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=640
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ADP5588 is not set
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_MAX7359 is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_OPENCORES is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_PS2_ALPS is not set
+# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
+# CONFIG_MOUSE_PS2_SYNAPTICS is not set
+# CONFIG_MOUSE_PS2_TRACKPOINT is not set
+# CONFIG_MOUSE_PS2_ELANTECH is not set
+# CONFIG_MOUSE_PS2_SENTELIC is not set
+# CONFIG_MOUSE_PS2_TOUCHKIT is not set
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_MOUSE_SYNAPTICS_I2C is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
 
 #
 # Hardware I/O ports
 #
-# CONFIG_SERIO is not set
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO_XILINX_XPS_PS2 is not set
+# CONFIG_SERIO_ALTERA_PS2 is not set
 # CONFIG_GAMEPORT is not set
 
 #
 # Character devices
 #
-# CONFIG_VT is not set
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
 CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
 # CONFIG_NOZOMI is not set
@@ -826,7 +882,7 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_88PM860X is not set
-# CONFIG_MFD_SM501 is not set
+CONFIG_MFD_SM501=y
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_TWL4030_CORE is not set
 # CONFIG_MFD_TMIO is not set
@@ -852,14 +908,93 @@ CONFIG_VGA_ARB_MAX_GPUS=16
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
-# CONFIG_FB is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_CIRRUS is not set
+# CONFIG_FB_PM2 is not set
+# CONFIG_FB_CYBER2000 is not set
+# CONFIG_FB_OF is not set
+# CONFIG_FB_CT65550 is not set
+# CONFIG_FB_ASILIANT is not set
+# CONFIG_FB_IMSTT is not set
+# CONFIG_FB_VGA16 is not set
+# CONFIG_FB_UVESA is not set
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_NVIDIA is not set
+# CONFIG_FB_RIVA is not set
+# CONFIG_FB_MATROX is not set
+# CONFIG_FB_RADEON is not set
+# CONFIG_FB_ATY128 is not set
+# CONFIG_FB_ATY is not set
+# CONFIG_FB_S3 is not set
+# CONFIG_FB_SAVAGE is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_VIA is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_KYRO is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_VT8623 is not set
+# CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_ARK is not set
+# CONFIG_FB_PM3 is not set
+# CONFIG_FB_CARMINE is not set
+CONFIG_FB_SM501=y
+# CONFIG_FB_IBM_GXT4500 is not set
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Console display driver support
+#
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HIDRAW is not set
+# CONFIG_HID_PID is not set
+
+#
+# Special HID drivers
+#
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_UWB is not set
 # CONFIG_MMC is not set
-- 
1.6.2.5

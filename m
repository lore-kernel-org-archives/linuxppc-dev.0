Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id D4446B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Dec 2010 19:23:53 +1100 (EST)
From: Heiko Schocher <hs@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc, video: add SM501 support for charon board.
Date: Sat,  4 Dec 2010 09:23:48 +0100
Message-Id: <1291451028-22532-2-git-send-email-hs@denx.de>
In-Reply-To: <1291451028-22532-1-git-send-email-hs@denx.de>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
Cc: linux-fbdev@vger.kernel.org, Heiko Schocher <hs@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: linux-fbdev@vger.kernel.org
---
based against 2.6.37-rc4

./scripts/checkpatch.pl 0004-powerpc-video-add-SM501-support-for-charon-board.patch lems and is ready for
total: 0 errors, 0 warnings, 249 lines checked

0004-powerpc-video-add-SM501-support-for-charon-board.patch has no obvious style problems and is ready for submission.

 arch/powerpc/boot/dts/charon.dts           |    9 ++
 arch/powerpc/configs/52xx/charon_defconfig |  176 +++++++++++++++++++++++++++-
 2 files changed, 179 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/charon.dts b/arch/powerpc/boot/dts/charon.dts
index 768f0cc..b2353b3 100644
--- a/arch/powerpc/boot/dts/charon.dts
+++ b/arch/powerpc/boot/dts/charon.dts
@@ -186,6 +186,7 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		ranges = <	0 0 0xfc000000 0x02000000
+				1 0 0xe0000000 0x04000000 // CS1 range, SM501
 				3 0 0xe8000000 0x00080000>;
 
 		flash@0,0 {
@@ -197,6 +198,14 @@
 			#address-cells = <1>;
 		};
 
+		display@1,0 {
+			compatible = "smi,sm501";
+			reg = <1 0x00000000 0x00800000
+			       1 0x03e00000 0x00200000>;
+			mode = "640x480-32@60";
+			interrupts = <1 1 3>;
+		};
+
 		mram0@3,0 {
 			compatible = "mtd-ram";
 			reg = <3 0x00000 0x80000>;
diff --git a/arch/powerpc/configs/52xx/charon_defconfig b/arch/powerpc/configs/52xx/charon_defconfig
index edf3d40..05a46cf 100644
--- a/arch/powerpc/configs/52xx/charon_defconfig
+++ b/arch/powerpc/configs/52xx/charon_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux/powerpc 2.6.37-rc4 Kernel Configuration
-# Tue Nov 30 12:24:32 2010
+# Tue Nov 30 12:32:58 2010
 #
 # CONFIG_PPC64 is not set
 
@@ -719,18 +719,78 @@ CONFIG_WLAN=y
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
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
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
+# CONFIG_KEYBOARD_QT2160 is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_TCA6416 is not set
+# CONFIG_KEYBOARD_MAX7359 is not set
+# CONFIG_KEYBOARD_MCS is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_OPENCORES is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+CONFIG_MOUSE_PS2_ALPS=y
+CONFIG_MOUSE_PS2_LOGIPS2PP=y
+CONFIG_MOUSE_PS2_SYNAPTICS=y
+CONFIG_MOUSE_PS2_TRACKPOINT=y
+# CONFIG_MOUSE_PS2_ELANTECH is not set
+# CONFIG_MOUSE_PS2_SENTELIC is not set
+# CONFIG_MOUSE_PS2_TOUCHKIT is not set
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_APPLETOUCH is not set
+# CONFIG_MOUSE_BCM5974 is not set
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
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_SERIO_XILINX_XPS_PS2 is not set
+# CONFIG_SERIO_ALTERA_PS2 is not set
+# CONFIG_SERIO_PS2MULT is not set
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
 # CONFIG_N_GSM is not set
@@ -885,6 +945,7 @@ CONFIG_SENSORS_LM80=y
 # CONFIG_SENSORS_W83L786NG is not set
 # CONFIG_SENSORS_W83627HF is not set
 # CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_SENSORS_LIS3_I2C is not set
 # CONFIG_THERMAL is not set
 CONFIG_WATCHDOG=y
 # CONFIG_WATCHDOG_NOWAYOUT is not set
@@ -908,7 +969,7 @@ CONFIG_SSB_POSSIBLE=y
 CONFIG_MFD_SUPPORT=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_88PM860X is not set
-# CONFIG_MFD_SM501 is not set
+CONFIG_MFD_SM501=y
 # CONFIG_HTC_PASIC3 is not set
 # CONFIG_TPS6507X is not set
 # CONFIG_TWL4030_CORE is not set
@@ -934,14 +995,116 @@ CONFIG_MFD_SUPPORT=y
 # CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
+CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+CONFIG_FB_FOREIGN_ENDIAN=y
+CONFIG_FB_BOTH_ENDIAN=y
+# CONFIG_FB_BIG_ENDIAN is not set
+# CONFIG_FB_LITTLE_ENDIAN is not set
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
+# CONFIG_FB_OF is not set
+# CONFIG_FB_VGA16 is not set
+# CONFIG_FB_S1D13XXX is not set
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
+CONFIG_VGA_CONSOLE=y
+# CONFIG_VGACON_SOFT_SCROLLBACK is not set
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+# CONFIG_LOGO is not set
 # CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HIDRAW is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_HID_PID is not set
+# CONFIG_USB_HIDDEV is not set
+
+#
+# Special HID drivers
+#
+# CONFIG_HID_3M_PCT is not set
+# CONFIG_HID_A4TECH is not set
+# CONFIG_HID_ACRUX_FF is not set
+# CONFIG_HID_APPLE is not set
+# CONFIG_HID_BELKIN is not set
+# CONFIG_HID_CANDO is not set
+# CONFIG_HID_CHERRY is not set
+# CONFIG_HID_CHICONY is not set
+# CONFIG_HID_CYPRESS is not set
+# CONFIG_HID_DRAGONRISE is not set
+# CONFIG_HID_EGALAX is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_UCLOGIC is not set
+# CONFIG_HID_WALTOP is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_TWINHAN is not set
+# CONFIG_HID_KENSINGTON is not set
+# CONFIG_HID_LOGITECH is not set
+# CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MOSART is not set
+# CONFIG_HID_MONTEREY is not set
+# CONFIG_HID_NTRIG is not set
+# CONFIG_HID_ORTEK is not set
+# CONFIG_HID_PANTHERLORD is not set
+# CONFIG_HID_PETALYNX is not set
+# CONFIG_HID_PICOLCD is not set
+# CONFIG_HID_QUANTA is not set
+# CONFIG_HID_ROCCAT is not set
+# CONFIG_HID_ROCCAT_KONE is not set
+# CONFIG_HID_ROCCAT_PYRA is not set
+# CONFIG_HID_SAMSUNG is not set
+# CONFIG_HID_SONY is not set
+# CONFIG_HID_STANTUM is not set
+# CONFIG_HID_SUNPLUS is not set
+# CONFIG_HID_GREENASIA is not set
+# CONFIG_HID_SMARTJOYPLUS is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_HID_THRUSTMASTER is not set
+# CONFIG_HID_ZEROPLUS is not set
+# CONFIG_HID_ZYDACRON is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
@@ -1007,6 +1170,7 @@ CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
 # CONFIG_USB_STORAGE_KARMA is not set
 # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
 # CONFIG_USB_UAS is not set
-- 
1.7.2.3

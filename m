Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40flDK4RHJzF1RW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 00:21:37 +1000 (AEST)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Robin H. Johnson" <robbat2@gentoo.org>,
 Benjamin Gilbert <benjamin.gilbert@coreos.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] powerpc: wii_defconfig: Enable GPIO-related options
Date: Mon,  7 May 2018 16:20:17 +0200
Message-Id: <20180507142019.32669-3-j.neuschaefer@gmx.net>
In-Reply-To: <20180507142019.32669-1-j.neuschaefer@gmx.net>
References: <20180507142019.32669-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that there's a GPIO driver for the Wii, let's enable the following
drivers:

- the GPIO driver itself
- gpio-keys
- gpio-poweroff
- gpio-leds and a few LED triggers

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
v2:
- Set CONFIG_NEW_LEDS=y and CONFIG_LEDS_TRIGGERS=y, without which some
  of the other options can't be set.
---
 arch/powerpc/configs/wii_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 3167b9d7f3e5..c5933a38e5ad 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -58,6 +58,7 @@ CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
+CONFIG_KEYBOARD_GPIO=y
 # CONFIG_MOUSE_PS2 is not set
 CONFIG_INPUT_JOYSTICK=y
 CONFIG_INPUT_MISC=y
@@ -72,6 +73,9 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_GPIO=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_HLWD=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_GPIO=y
 # CONFIG_HWMON is not set
 CONFIG_SSB_DEBUG=y
 CONFIG_FB=y
@@ -89,6 +93,12 @@ CONFIG_HID_APPLE=m
 CONFIG_HID_WACOM=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_PANIC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_GENERIC=y
 CONFIG_EXT2_FS=y
-- 
2.17.0

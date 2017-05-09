Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMpvx3tQ1zDqKT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 May 2017 05:14:37 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Michal Suchanek <msuchanek@suse.de>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] macintosh: move mac_hid driver to input/mouse.
Date: Tue,  9 May 2017 21:14:18 +0200
Message-Id: <20170509191418.10144-1-msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is nothing mac-specific about this driver. Non-mac hardware with
suboptimal built-in pointer devices exists.

This makes it possible to use this emulation not only on x86 and ppc
notebooks but also on arm and mips.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/input/mouse/Kconfig                  | 20 ++++++++++++++++++++
 drivers/input/mouse/Makefile                 |  1 +
 drivers/{macintosh => input/mouse}/mac_hid.c |  0
 drivers/macintosh/Kconfig                    | 17 -----------------
 drivers/macintosh/Makefile                   |  1 -
 5 files changed, 21 insertions(+), 18 deletions(-)
 rename drivers/{macintosh => input/mouse}/mac_hid.c (100%)

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 89ebb8f39fee..5533fd3a113f 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -12,6 +12,26 @@ menuconfig INPUT_MOUSE
 
 if INPUT_MOUSE
 
+config MAC_EMUMOUSEBTN
+	tristate "Support for mouse button 2+3 emulation"
+	depends on SYSCTL && INPUT
+	help
+	  This provides generic support for emulating the 2nd and 3rd mouse
+	  button with keypresses.  If you say Y here, the emulation is still
+	  disabled by default.  The emulation is controlled by these sysctl
+	  entries:
+	  /proc/sys/dev/mac_hid/mouse_button_emulation
+	  /proc/sys/dev/mac_hid/mouse_button2_keycode
+	  /proc/sys/dev/mac_hid/mouse_button3_keycode
+
+	  If you have an Apple machine with a 1-button mouse, say Y here.
+
+	  This emulation can be useful on notebooks with suboptimal touchpad
+	  hardware as well.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mac_hid.
+
 config MOUSE_PS2
 	tristate "PS/2 mouse"
 	default y
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index 56bf0ad877c6..dfaad1dd8857 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -4,6 +4,7 @@
 
 # Each configuration option enables a list of files.
 
+obj-$(CONFIG_MAC_EMUMOUSEBTN)		+= mac_hid.o
 obj-$(CONFIG_MOUSE_AMIGA)		+= amimouse.o
 obj-$(CONFIG_MOUSE_APPLETOUCH)		+= appletouch.o
 obj-$(CONFIG_MOUSE_ATARI)		+= atarimouse.o
diff --git a/drivers/macintosh/mac_hid.c b/drivers/input/mouse/mac_hid.c
similarity index 100%
rename from drivers/macintosh/mac_hid.c
rename to drivers/input/mouse/mac_hid.c
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 97a420c11eed..011df09c5167 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -159,23 +159,6 @@ config INPUT_ADBHID
 
 	  If unsure, say Y.
 
-config MAC_EMUMOUSEBTN
-	tristate "Support for mouse button 2+3 emulation"
-	depends on SYSCTL && INPUT
-	help
-	  This provides generic support for emulating the 2nd and 3rd mouse
-	  button with keypresses.  If you say Y here, the emulation is still
-	  disabled by default.  The emulation is controlled by these sysctl
-	  entries:
-	  /proc/sys/dev/mac_hid/mouse_button_emulation
-	  /proc/sys/dev/mac_hid/mouse_button2_keycode
-	  /proc/sys/dev/mac_hid/mouse_button3_keycode
-
-	  If you have an Apple machine with a 1-button mouse, say Y here.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called mac_hid.
-
 config THERM_WINDTUNNEL
 	tristate "Support for thermal management on Windtunnel G4s"
 	depends on I2C && I2C_POWERMAC && PPC_PMAC && !PPC_PMAC64
diff --git a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
index 516eb65bcacc..ab8b1e74d160 100644
--- a/drivers/macintosh/Makefile
+++ b/drivers/macintosh/Makefile
@@ -7,7 +7,6 @@
 obj-$(CONFIG_PPC_PMAC)		+= macio_asic.o macio_sysfs.o
 
 obj-$(CONFIG_PMAC_MEDIABAY)	+= mediabay.o
-obj-$(CONFIG_MAC_EMUMOUSEBTN)	+= mac_hid.o
 obj-$(CONFIG_INPUT_ADBHID)	+= adbhid.o
 obj-$(CONFIG_ANSLCD)		+= ans-lcd.o
 
-- 
2.10.2

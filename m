Return-Path: <sbrabec@suse.cz>
Received: from mail.suse.cz (styx.suse.cz [82.119.242.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE475DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 03:14:15 +1100 (EST)
Subject: [PATCH] remove dead MAC_ADBKEYCODES
From: Stanislav Brabec <sbrabec@suse.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Date: Thu, 15 Nov 2007 16:53:29 +0100
Message-Id: <1195142010.14001.21.camel@hammer.suse.cz>
Mime-Version: 1.0
Cc: linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It seems, that current kernel source code contains no traces of
MAC_ADBKEYCODES and no reference to keyboard_sends_linux_keycodes any
more.

Attached patch removes them from configuration files.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>

--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -582,20 +582,6 @@ config MAC_HID
 	depends on INPUT_ADBHID
 	default y
 
-config MAC_ADBKEYCODES
-	bool "Support for ADB raw keycodes"
-	depends on INPUT_ADBHID
-	help
-	  This provides support for sending raw ADB keycodes to console
-	  devices.  This is the default up to 2.4.0, but in future this may be
-	  phased out in favor of generic Linux keycodes.  If you say Y here,
-	  you can dynamically switch via the
-	  /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes
-	  sysctl and with the "keyboard_sends_linux_keycodes=" kernel
-	  argument.
-
-	  If unsure, say Y here.
-
 config ADB_KEYBOARD
 	bool "Support for ADB keyboard (old driver)"
 	depends on MAC && !INPUT_ADBHID
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -678,7 +678,6 @@ CONFIG_LOGO_MAC_CLUT224=y
 #
 CONFIG_MAC_SCC=y
 CONFIG_MAC_HID=y
-CONFIG_MAC_ADBKEYCODES=y
 CONFIG_SERIAL_CONSOLE=y
 
 #


-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +420 284 028 966
190 00 Praha 9                                fax: +420 284 028 951
Czech Republic                                http://www.suse.cz/

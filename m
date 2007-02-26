Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 3C9A0DDEE1
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 02:48:55 +1100 (EST)
Date: Mon, 26 Feb 2007 16:48:49 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] ps3: Introduce CONFIG_PS3_ADVANCED
In-Reply-To: <Pine.LNX.4.64.0702232343330.14457@scrub.home>
Message-ID: <Pine.LNX.4.62.0702261644310.5716@pademelon.sonytel.be>
References: <200702210946.27758.toralf.foerster@gmx.de>
	<Pine.LNX.4.62.0702211102000.340@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702211238400.14457@scrub.home>
	<Pine.LNX.4.62.0702211322350.340@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702220052020.14457@scrub.home>
	<Pine.LNX.4.62.0702221854520.25919@pademelon.sonytel.be>
	<Pine.LNX.4.64.0702232343330.14457@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	=?UTF-8?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ps3: Introduce CONFIG_PS3_ADVANCED, as suggested by Roman Zippel, and use it to
control questions about PS3 subsystems that may not be obvious for the casual
user.

This gets rid of the following warning on non-powerpc platforms:
| drivers/video/Kconfig:1604:warning: 'select' used by config symbol 'FB_PS3' refer to undefined symbol 'PS3_PS3AV'

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
---
 arch/powerpc/platforms/ps3/Kconfig |   28 +++++++++++++++++++++-------
 drivers/video/Kconfig              |    3 +--
 2 files changed, 22 insertions(+), 9 deletions(-)

--- ps3-linux-2.6.21-rc1.orig/arch/powerpc/platforms/ps3/Kconfig
+++ ps3-linux-2.6.21-rc1/arch/powerpc/platforms/ps3/Kconfig
@@ -1,9 +1,24 @@
 menu "PS3 Platform Options"
 	depends on PPC_PS3
 
+config PS3_ADVANCED
+	depends on PPC_PS3
+	bool "PS3 Advanced configuration options"
+	help
+	  This gives you access to some advanced options for the PS3. The
+	  defaults should be fine for most users, but these options may make
+	  it possible to better control the kernel configuration if you know
+	  what you are doing.
+
+	  Note that the answer to this question won't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about these options.
+
+	  Most users should say N to this question.
+
 config PS3_HTAB_SIZE
 	depends on PPC_PS3
-	int "PS3 Platform pagetable size"
+	int "PS3 Platform pagetable size" if PS3_ADVANCED
 	range 18 20
 	default 20
 	help
@@ -42,7 +57,7 @@ config PS3_USE_LPAR_ADDR
 
 config PS3_VUART
 	depends on PPC_PS3
-	bool "PS3 Virtual UART support"
+	bool "PS3 Virtual UART support" if PS3_ADVANCED
 	default y
 	help
 	  Include support for the PS3 Virtual UART.
@@ -52,9 +67,8 @@ config PS3_VUART
 	  general, all users will say Y.
 
 config PS3_PS3AV
-	tristate "PS3 AV settings driver"
-	depends on PPC_PS3
-	select PS3_VUART
+	tristate "PS3 AV settings driver" if PS3_ADVANCED
+	depends on PS3_VUART
 	default y
 	help
 	  Include support for the PS3 AV Settings driver.
@@ -63,8 +77,8 @@ config PS3_PS3AV
 	  general, all users will say Y or M.
 
 config PS3_SYS_MANAGER
-	bool "PS3 System Manager driver"
-	select PS3_VUART
+	bool "PS3 System Manager driver" if PS3_ADVANCED
+	depends on PS3_VUART
 	default y
 	help
 	  Include support for the PS3 System Manager.
--- ps3-linux-2.6.21-rc1.orig/drivers/video/Kconfig
+++ ps3-linux-2.6.21-rc1/drivers/video/Kconfig
@@ -1618,8 +1618,7 @@ config FB_IBM_GXT4500
 
 config FB_PS3
 	bool "PS3 GPU framebuffer driver"
-	depends on FB && PPC_PS3
-	select PS3_PS3AV
+	depends on FB && PS3_PS3AV
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

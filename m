Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0F650DDF14
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 05:00:36 +1000 (EST)
Date: Tue, 15 May 2007 14:03:44 -0500
To: paulus@samba.org
Subject: [PATCH] iseries: fix CONFIG_VIOCONS/CONFIG_VT dependency
Message-ID: <20070515190343.GA13203@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

VT already depends on !VIOCONS, but there's no restriction in the other
direction. This makes an allyesconfig not build.

Switch to a Kconfig dependency instead of a compile-time error.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
index 46c3a8e..e48f018 100644
--- a/arch/powerpc/platforms/iseries/Kconfig
+++ b/arch/powerpc/platforms/iseries/Kconfig
@@ -8,6 +8,7 @@ menu "iSeries device drivers"
 
 config VIOCONS
 	tristate "iSeries Virtual Console Support (Obsolete)"
+	depends on !VT
 	help
 	  This is the old virtual console driver for legacy iSeries.
 	  You should use the iSeries Hypervisor Virtual Console
diff --git a/drivers/char/viocons.c b/drivers/char/viocons.c
index 8de6b95..c2e7a93 100644
--- a/drivers/char/viocons.c
+++ b/drivers/char/viocons.c
@@ -49,10 +49,6 @@
 #include <asm/iseries/hv_lp_config.h>
 #include <asm/iseries/hv_call.h>
 
-#ifdef CONFIG_VT
-#error You must turn off CONFIG_VT to use CONFIG_VIOCONS
-#endif
-
 #define VIOTTY_MAGIC (0x0DCB)
 #define VTTY_PORTS 10
 

Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id CB281DDDF5
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 07:52:29 +1000 (EST)
Message-Id: <20070712210909.166472555@arndb.de>
References: <20070712210156.973038514@arndb.de>
Date: Thu, 12 Jul 2007 23:01:58 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 2/5] linkstation: fix multiplatform build
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The ls_uart file accidentally includes two headers from asm-ppc that
are no longer needed but cause a broken build in some configurations.
Kill the includes to fix the build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
index d0bee9f..3b023b0 100644
--- a/arch/powerpc/platforms/embedded6xx/ls_uart.c
+++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
@@ -4,8 +4,6 @@
 #include <linux/serial_reg.h>
 #include <linux/serial_8250.h>
 #include <asm/io.h>
-#include <asm/mpc10x.h>
-#include <asm/ppc_sys.h>
 #include <asm/prom.h>
 #include <asm/termbits.h>
 

--

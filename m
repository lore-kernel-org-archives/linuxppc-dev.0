Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 9D039DDE0E
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 05:44:12 +1000 (EST)
Message-Id: <20070713184824.163613010@arndb.de>
References: <20070713184452.466490031@arndb.de>
Date: Fri, 13 Jul 2007 20:44:56 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 4/5] linkstation: fix multiplatform build
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger <jdl@freescale.com> wrote:
X-Provags-ID: V01U2FsdGVkX19mfbfAMECjK3Yc4qnJalet5VRz84KpvPei34h
 Js67aIi1Jyt+C01bLuMxs+l5L4KLJuYYiIXI6fjXdktExWZ2WR
 fI/xi0tOHQX8AN87t62WA==

> Hmmm... Shouldn't this sort of change come
> with an update to the 8641 defconfig too?
Content-Disposition: inline; filename=ls-fix-uart.diff

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

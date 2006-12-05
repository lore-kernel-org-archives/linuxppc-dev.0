Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D6E8C67BBE
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 10:30:26 +1100 (EST)
Message-ID: <45760109.8030200@am.sony.com>
Date: Tue, 05 Dec 2006 15:30:17 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: fix build error in rom.c
Content-Type: text/plain; charset=UTF-8
Cc: dwmw2@redhat.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add missing include in rom.c.  Fixes this build error when CONFIG_MTD=y:

  arch/powerpc/sysdev/rom.c:26: error: implicit declaration of function of_platform_device_create

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/sysdev/rom.c |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.19.ppc64.orig/arch/powerpc/sysdev/rom.c
+++ linux-2.6.19.ppc64/arch/powerpc/sysdev/rom.c
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <asm/of_device.h>
+#include <asm/of_platform.h>
 
 static int __init powerpc_flash_init(void)
 {

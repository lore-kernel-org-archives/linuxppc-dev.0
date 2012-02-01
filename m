Return-Path: <b08782@zro04cle141.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB57E1007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Feb 2012 04:05:24 +1100 (EST)
Received: from mail119-ch1 (localhost [127.0.0.1])	by
 mail119-ch1-R.bigfish.com (Postfix) with ESMTP id 298732C042E	for
 <linuxppc-dev@ozlabs.org>; Wed,  1 Feb 2012 17:05:21 +0000 (UTC)
Received: from CH1EHSMHS030.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.237])	by mail119-ch1.bigfish.com (Postfix) with ESMTP id
 B8020C0046
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Feb 2012 17:05:18 +0000 (UTC)
Received: from zro04cle141.ea.freescale.net (udp157456uds.ea.freescale.net
 [140.101.223.141])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 q11H5FfI021424	for <linuxppc-dev@ozlabs.org>; Wed, 1 Feb 2012 11:05:16 -0600
 (CST)
From: Claudiu Manoil <claudiu.manoil@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH][v2] powerpc/85xx: Fix compiler error with THIS_MODULE and
 related
Date: Wed, 1 Feb 2012 19:05:15 +0200
Message-ID: <1328115915-16172-1-git-send-email-claudiu.manoil@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CC      arch/powerpc/sysdev/fsl_85xx_l2ctlr.o
arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:209:13: error: 'THIS_MODULE' undeclared here (not in a function)
arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:20: error: expected declaration specifiers or '...' before string constant
cc1: warnings being treated as errors
arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:1: error: data definition has no type or storage class
arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:1: error: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:229:20: error: function declaration isn't a prototype
arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:16: error: expected declaration specifiers or '...' before string constant
arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:1: error: data definition has no type or storage class
arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:1: error: type defaults to 'int' in declaration of 'MODULE_LICENSE'
arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:230:16: error: function declaration isn't a prototype
make[1]: *** [arch/powerpc/sysdev/fsl_85xx_l2ctlr.o] Error 1

...

  CC      arch/powerpc/sysdev/fsl_85xx_cache_sram.o
cc1: warnings being treated as errors
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: data definition has no type or storage class
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:69:1: error: parameter names (without types) in function declaration
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: data definition has no type or storage class
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
arch/powerpc/sysdev/fsl_85xx_cache_sram.c:80:1: error: parameter names (without types) in function declaration
make[1]: *** [arch/powerpc/sysdev/fsl_85xx_cache_sram.o] Error 1

Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
---
Replaced <linux/module.h> with <linux/export.h> for fsl_85xx_cache_sram.c.

 arch/powerpc/sysdev/fsl_85xx_cache_sram.c |    1 +
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
index 1164158..37a6909 100644
--- a/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
+++ b/arch/powerpc/sysdev/fsl_85xx_cache_sram.c
@@ -24,6 +24,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of_platform.h>
diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index 5f88797..1957e53 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_platform.h>
 #include <asm/io.h>
 
-- 
1.6.6

Return-Path: <domen@coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id 9ABC32BDB5
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Dec 2004 04:53:20 +1100 (EST)
To: paulus@samba.org
From: domen@coderock.org
Date: Sat, 25 Dec 2004 18:46:52 +0100
Message-Id: <20041225174642.720981F123@trashy.coderock.org>
Cc: linuxppc-dev@ozlabs.org, domen@coderock.org
Subject: [patch 2/3] delete unused file
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/arch/ppc/syslib/ppc4xx_pm.c |   47 -----------------------------------------
 1 files changed, 47 deletions(-)

diff -L arch/ppc/syslib/ppc4xx_pm.c -puN arch/ppc/syslib/ppc4xx_pm.c~remove_file-arch_ppc_syslib_ppc4xx_pm.c /dev/null
--- kj/arch/ppc/syslib/ppc4xx_pm.c
+++ /dev/null	2004-12-24 01:21:08.000000000 +0100
@@ -1,47 +0,0 @@
-/*
- * Author: Armin Kuster <akuster@mvista.com>
- *
- * 2002 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * This an attempt to get Power Management going for the IBM 4xx processor.
- * This was derived from the ppc4xx._setup.c file
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-
-#include <asm/ibm4xx.h>
-
-void __init
-ppc4xx_pm_init(void)
-{
-
-	unsigned int value = 0;
-
-	/* turn off unused hardware to save power */
-#ifdef CONFIG_405GP
-	value |= CPM_DCP;	/* CodePack */
-#endif
-
-#if !defined(CONFIG_IBM_OCP_GPIO)
-	value |= CPM_GPIO0;
-#endif
-
-#if !defined(CONFIG_PPC405_I2C_ADAP)
-	value |= CPM_IIC0;
-#ifdef CONFIG_STB03xxx
-	value |= CPM_IIC1;
-#endif
-#endif
-
-
-#if !defined(CONFIG_405_DMA)
-	value |= CPM_DMA;
-#endif
-
-	mtdcr(DCRN_CPMFR, value);
-
-}
_

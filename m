Return-Path: <domen@nd47.coderock.org>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by ozlabs.org (Postfix) with ESMTP id 723D567AC6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Jun 2005 07:58:08 +1000 (EST)
Message-Id: <20050620215014.842618000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:50:15 +0200
From: domen@coderock.org
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, domen@coderock.org
Subject: [patch 1/2] delete arch/ppc/syslib/ppc4xx_pm.c
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
 ppc4xx_pm.c |   47 -----------------------------------------------
 1 files changed, 47 deletions(-)

Index: quilt/arch/ppc/syslib/ppc4xx_pm.c
===================================================================
--- quilt.orig/arch/ppc/syslib/ppc4xx_pm.c
+++ /dev/null
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

--

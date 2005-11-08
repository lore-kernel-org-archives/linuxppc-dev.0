Return-Path: <adobriyan@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.193])
	by ozlabs.org (Postfix) with ESMTP id F14A6686AD
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2005 05:02:07 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id y38so212847nfb
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Nov 2005 10:02:05 -0800 (PST)
Date: Tue, 8 Nov 2005 21:08:02 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051108180802.GH7631@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Domen Puncer <domen@coderock.org>
Subject: [PATCH] Remove arch/ppc/syslib/ppc4xx_pm.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Domen Puncer <domen@coderock.org>

Remove nowhere referenced file ("grep ppc4xx_pm -r ." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Index: linux-kj/arch/ppc/syslib/ppc4xx_pm.c
===================================================================
--- linux-kj.orig/arch/ppc/syslib/ppc4xx_pm.c	2005-11-08 20:46:23.000000000 +0300
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
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

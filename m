Return-Path: <adobriyan@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.195])
	by ozlabs.org (Postfix) with ESMTP id 6CA8D68263
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Sep 2005 06:07:09 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id s1so22789nze
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Sep 2005 13:07:08 -0700 (PDT)
Date: Thu, 15 Sep 2005 00:10:52 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20050914201052.GJ19491@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Armin Kuster <akuster@mvista.com>,
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

Remove nowhere referenced file (grep ppc4xx_pm -r . didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/ppc/syslib/ppc4xx_pm.c |   47 --------------------------------------------
 1 files changed, 47 deletions(-)

--- a/arch/ppc/syslib/ppc4xx_pm.c	2005-09-14 19:05:25.000000000 +0400
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

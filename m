Return-Path: <adobriyan@gmail.com>
Received: from uproxy.gmail.com (uproxy.gmail.com [66.249.92.203])
	by ozlabs.org (Postfix) with ESMTP id C053668AA5
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2006 21:32:18 +1100 (EST)
Received: by uproxy.gmail.com with SMTP id h2so119095ugf
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2006 02:32:14 -0800 (PST)
Date: Thu, 26 Jan 2006 13:50:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Remove arch/ppc/syslib/ppc4xx_pm.c
Message-ID: <20060126105001.GA9288@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen@coderock.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Domen Puncer <domen@coderock.org>

Remove nowhere referenced file ("grep ppc4xx_pm -r ." didn't find anything).

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/ppc/syslib/ppc4xx_pm.c |   47 --------------------------------------------
 1 file changed, 47 deletions(-)

--- a/arch/ppc/syslib/ppc4xx_pm.c
+++ b/arch/ppc/syslib/ppc4xx_pm.c
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

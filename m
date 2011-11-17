Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 231D0B6F91
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 01:51:33 +1100 (EST)
Received: by wwf10 with SMTP id 10so2464375wwf.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 06:51:30 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc/83xx: make mpc830x_rdb use mpc83xx_setup_pci
Date: Thu, 17 Nov 2011 18:48:50 +0400
Message-Id: <1321541330-2330-4-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1321541330-2330-1-git-send-email-dbaryshkov@gmail.com>
References: <1321541330-2330-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Traditionally mpc830x_rdb board file searched for mpc8308-pcie devices.
However both in-kernel dts from the beginning declared those pcie units
as compatible with mpc8314-pci, which is handled by mpc83xx_setup_pci().

Drop special handling for mpc8308 and use common function instead.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/83xx/mpc830x_rdb.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
index 6e4783d..67a3030 100644
--- a/arch/powerpc/platforms/83xx/mpc830x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
@@ -13,11 +13,8 @@
  * option) any later version.
  */
 
-#include <linux/pci.h>
-
 #include <asm/ipic.h>
 #include <asm/udbg.h>
-#include <sysdev/fsl_pci.h>
 
 #include "mpc83xx.h"
 
@@ -26,17 +23,10 @@
  */
 static void __init mpc830x_rdb_setup_arch(void)
 {
-#ifdef CONFIG_PCI
-	struct device_node *np;
-#endif
-
 	if (ppc_md.progress)
 		ppc_md.progress("mpc830x_rdb_setup_arch()", 0);
 
-#ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,mpc8308-pcie")
-		mpc83xx_add_bridge(np);
-#endif
+	mpc83xx_setup_pci();
 	mpc831x_usb_cfg();
 }
 
-- 
1.7.7.1

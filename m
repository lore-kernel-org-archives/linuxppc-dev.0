Return-Path: <r63061@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54F202C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 19:43:16 +1000 (EST)
Received: from mail116-co1 (localhost [127.0.0.1])	by
 mail116-co1-R.bigfish.com (Postfix) with ESMTP id A9EAE3800D2	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 09:43:12 +0000 (UTC)
Received: from CO1EHSMHS002.bigfish.com (unknown [10.243.78.247])	by
 mail116-co1.bigfish.com (Postfix) with ESMTP id 0F7F95C0077	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 09:43:10 +0000 (UTC)
From: Xie Xiaobo <X.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH V5 1/2] powerpc/85xx: Add QE common init function
Date: Thu, 26 Sep 2013 17:37:32 +0800
Message-ID: <1380188253-4710-1-git-send-email-X.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define a QE init function in common file, and avoid
the same codes being duplicated in board files.

Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
---
V5 -> V4: add the board files modification, remove the qe_pic_init.
V4 -> V3: Nochange

 arch/powerpc/platforms/85xx/common.c      | 33 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx.h     |  6 ++++++
 arch/powerpc/platforms/85xx/mpc85xx_mds.c | 29 ++-------------------------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 25 ++---------------------
 4 files changed, 43 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index d0861a0..568fd1f 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -7,6 +7,7 @@
  */
 #include <linux/of_platform.h>
 
+#include <asm/qe.h>
 #include <sysdev/cpm2_pic.h>
 
 #include "mpc85xx.h"
@@ -80,3 +81,35 @@ void __init mpc85xx_cpm2_pic_init(void)
 	irq_set_chained_handler(irq, cpm2_cascade);
 }
 #endif
+
+#ifdef CONFIG_QUICC_ENGINE
+void __init mpc85xx_qe_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!np) {
+		np = of_find_node_by_name(NULL, "qe");
+		if (!np) {
+			pr_err("%s: Could not find Quicc Engine node\n",
+					__func__);
+			return;
+		}
+	}
+
+	qe_reset();
+	of_node_put(np);
+
+	np = of_find_node_by_name(NULL, "par_io");
+	if (np) {
+		struct device_node *ucc;
+
+		par_io_init(np);
+		of_node_put(np);
+
+		for_each_node_by_name(ucc, "ucc")
+			par_io_of_config(ucc);
+
+	}
+}
+#endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index 2aa7c5d..fc51dd4 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -8,4 +8,10 @@ extern void mpc85xx_cpm2_pic_init(void);
 static inline void __init mpc85xx_cpm2_pic_init(void) {}
 #endif /* CONFIG_CPM2 */
 
+#ifdef CONFIG_QUICC_ENGINE
+extern void mpc85xx_qe_init(void);
+#else
+static inline void __init mpc85xx_qe_init(void) {}
+#endif
+
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index a7b3621..34f3c5e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006-2010, 2012 Freescale Semiconductor, Inc.
+ * Copyright (C) 2006-2010, 2012-2013 Freescale Semiconductor, Inc.
  * All rights reserved.
  *
  * Author: Andy Fleming <afleming@freescale.com>
@@ -238,32 +238,7 @@ static void __init mpc85xx_mds_qe_init(void)
 {
 	struct device_node *np;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!np) {
-		np = of_find_node_by_name(NULL, "qe");
-		if (!np)
-			return;
-	}
-
-	if (!of_device_is_available(np)) {
-		of_node_put(np);
-		return;
-	}
-
-	qe_reset();
-	of_node_put(np);
-
-	np = of_find_node_by_name(NULL, "par_io");
-	if (np) {
-		struct device_node *ucc;
-
-		par_io_init(np);
-		of_node_put(np);
-
-		for_each_node_by_name(ucc, "ucc")
-			par_io_of_config(ucc);
-	}
-
+	mpc85xx_qe_init();
 	mpc85xx_mds_reset_ucc_phys();
 
 	if (machine_is(p1021_mds)) {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 53b6fb0..e15bdd1 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -1,7 +1,7 @@
 /*
  * MPC85xx RDB Board Setup
  *
- * Copyright 2009,2012 Freescale Semiconductor Inc.
+ * Copyright 2009,2012-2013 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -98,26 +98,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 	fsl_pci_assign_primary();
 
 #ifdef CONFIG_QUICC_ENGINE
-	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
-	if (!np) {
-		pr_err("%s: Could not find Quicc Engine node\n", __func__);
-		goto qe_fail;
-	}
-
-	qe_reset();
-	of_node_put(np);
-
-	np = of_find_node_by_name(NULL, "par_io");
-	if (np) {
-		struct device_node *ucc;
-
-		par_io_init(np);
-		of_node_put(np);
-
-		for_each_node_by_name(ucc, "ucc")
-			par_io_of_config(ucc);
-
-	}
+	mpc85xx_qe_init();
 #if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
 	if (machine_is(p1025_rdb)) {
 
@@ -148,8 +129,6 @@ static void __init mpc85xx_rdb_setup_arch(void)
 
 	}
 #endif
-
-qe_fail:
 #endif	/* CONFIG_QUICC_ENGINE */
 
 	printk(KERN_INFO "MPC85xx RDB board from Freescale Semiconductor\n");
-- 
1.8.0

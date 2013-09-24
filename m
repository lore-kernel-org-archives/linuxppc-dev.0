Return-Path: <r63061@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EAD542C0092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 20:54:30 +1000 (EST)
Received: from mail182-co1 (localhost [127.0.0.1])	by
 mail182-co1-R.bigfish.com (Postfix) with ESMTP id 622F5700099	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 10:54:25 +0000 (UTC)
Received: from CO1EHSMHS020.bigfish.com (unknown [10.243.78.227])	by
 mail182-co1.bigfish.com (Postfix) with ESMTP id ED04726004A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 10:54:22 +0000 (UTC)
From: Xie Xiaobo <X.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH V4 1/3] powerpc/85xx: Add QE common init functions
Date: Tue, 24 Sep 2013 18:48:57 +0800
Message-ID: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
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

Define two QE init functions in common file, and avoid
the same codes being duplicated in board files.

Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
---
V4 -> V3: Nochange

 arch/powerpc/platforms/85xx/common.c  | 51 +++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx.h |  8 ++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index d0861a0..08fff48 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -7,6 +7,9 @@
  */
 #include <linux/of_platform.h>
 
+#include <asm/machdep.h>
+#include <asm/qe.h>
+#include <asm/qe_ic.h>
 #include <sysdev/cpm2_pic.h>
 
 #include "mpc85xx.h"
@@ -80,3 +83,51 @@ void __init mpc85xx_cpm2_pic_init(void)
 	irq_set_chained_handler(irq, cpm2_cascade);
 }
 #endif
+
+#ifdef CONFIG_QUICC_ENGINE
+void __init mpc85xx_qe_pic_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
+	if (np) {
+		if (machine_is(mpc8568_mds) || machine_is(mpc8569_mds))
+			qe_ic_init(np, 0, qe_ic_cascade_muxed_mpic, NULL);
+		else
+			qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
+					qe_ic_cascade_high_mpic);
+		of_node_put(np);
+	} else
+		pr_err("%s: Could not find qe-ic node\n", __func__);
+}
+
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
index 2aa7c5d..1d39095 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -8,4 +8,12 @@ extern void mpc85xx_cpm2_pic_init(void);
 static inline void __init mpc85xx_cpm2_pic_init(void) {}
 #endif /* CONFIG_CPM2 */
 
+#ifdef CONFIG_QUICC_ENGINE
+extern void mpc85xx_qe_pic_init(void);
+extern void mpc85xx_qe_init(void);
+#else
+static inline void __init mpc85xx_qe_pic_init(void) {}
+static inline void __init mpc85xx_qe_init(void) {}
+#endif
+
 #endif
-- 
1.8.0

Return-Path: <r63061@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 87D732C009A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2013 20:14:35 +1000 (EST)
From: Xie Xiaobo <X.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>,
 <scottwood@freescale.com>
Subject: [PATCH V3 1/2] powerpc/85xx: Add QE common init functions
Date: Mon, 2 Sep 2013 18:11:38 +0800
Message-ID: <1378116699-18826-1-git-send-email-X.Xie@freescale.com>
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
V3 -> V2: Nochange

 arch/powerpc/platforms/85xx/common.c  | 47 +++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx.h |  8 ++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index d0861a0..fb3f5e6 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -7,6 +7,8 @@
  */
 #include <linux/of_platform.h>
 
+#include <asm/qe.h>
+#include <asm/qe_ic.h>
 #include <sysdev/cpm2_pic.h>
 
 #include "mpc85xx.h"
@@ -80,3 +82,48 @@ void __init mpc85xx_cpm2_pic_init(void)
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
+		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
+				qe_ic_cascade_high_mpic);
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

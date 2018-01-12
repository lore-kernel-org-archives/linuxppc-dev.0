Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHnBH1tZKzF0Tp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 13:43:51 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/xive: Move definition of ESB bits
Date: Fri, 12 Jan 2018 13:39:27 +1100
Message-Id: <20180112023928.10926-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From xive.h to xive-regs.h since it's a HW register definition
and it can be used from assembly

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/xive-regs.h | 35 +++++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/xive.h      | 35 -----------------------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/xive-regs.h b/arch/powerpc/include/asm/xive-regs.h
index 1d3f2be5ae39..fa4288822b68 100644
--- a/arch/powerpc/include/asm/xive-regs.h
+++ b/arch/powerpc/include/asm/xive-regs.h
@@ -9,6 +9,41 @@
 #ifndef _ASM_POWERPC_XIVE_REGS_H
 #define _ASM_POWERPC_XIVE_REGS_H
 
+/*
+ * "magic" Event State Buffer (ESB) MMIO offsets.
+ *
+ * Each interrupt source has a 2-bit state machine called ESB
+ * which can be controlled by MMIO. It's made of 2 bits, P and
+ * Q. P indicates that an interrupt is pending (has been sent
+ * to a queue and is waiting for an EOI). Q indicates that the
+ * interrupt has been triggered while pending.
+ *
+ * This acts as a coalescing mechanism in order to guarantee
+ * that a given interrupt only occurs at most once in a queue.
+ *
+ * When doing an EOI, the Q bit will indicate if the interrupt
+ * needs to be re-triggered.
+ *
+ * The following offsets into the ESB MMIO allow to read or
+ * manipulate the PQ bits. They must be used with an 8-bytes
+ * load instruction. They all return the previous state of the
+ * interrupt (atomically).
+ *
+ * Additionally, some ESB pages support doing an EOI via a
+ * store at 0 and some ESBs support doing a trigger via a
+ * separate trigger page.
+ */
+#define XIVE_ESB_STORE_EOI	0x400 /* Store */
+#define XIVE_ESB_LOAD_EOI	0x000 /* Load */
+#define XIVE_ESB_GET		0x800 /* Load */
+#define XIVE_ESB_SET_PQ_00	0xc00 /* Load */
+#define XIVE_ESB_SET_PQ_01	0xd00 /* Load */
+#define XIVE_ESB_SET_PQ_10	0xe00 /* Load */
+#define XIVE_ESB_SET_PQ_11	0xf00 /* Load */
+
+#define XIVE_ESB_VAL_P		0x2
+#define XIVE_ESB_VAL_Q		0x1
+
 /*
  * Thread Management (aka "TM") registers
  */
diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index 371fbebf1ec9..0e77005cf021 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -72,41 +72,6 @@ struct xive_q {
 	atomic_t		pending_count;
 };
 
-/*
- * "magic" Event State Buffer (ESB) MMIO offsets.
- *
- * Each interrupt source has a 2-bit state machine called ESB
- * which can be controlled by MMIO. It's made of 2 bits, P and
- * Q. P indicates that an interrupt is pending (has been sent
- * to a queue and is waiting for an EOI). Q indicates that the
- * interrupt has been triggered while pending.
- *
- * This acts as a coalescing mechanism in order to guarantee
- * that a given interrupt only occurs at most once in a queue.
- *
- * When doing an EOI, the Q bit will indicate if the interrupt
- * needs to be re-triggered.
- *
- * The following offsets into the ESB MMIO allow to read or
- * manipulate the PQ bits. They must be used with an 8-bytes
- * load instruction. They all return the previous state of the
- * interrupt (atomically).
- *
- * Additionally, some ESB pages support doing an EOI via a
- * store at 0 and some ESBs support doing a trigger via a
- * separate trigger page.
- */
-#define XIVE_ESB_STORE_EOI	0x400 /* Store */
-#define XIVE_ESB_LOAD_EOI	0x000 /* Load */
-#define XIVE_ESB_GET		0x800 /* Load */
-#define XIVE_ESB_SET_PQ_00	0xc00 /* Load */
-#define XIVE_ESB_SET_PQ_01	0xd00 /* Load */
-#define XIVE_ESB_SET_PQ_10	0xe00 /* Load */
-#define XIVE_ESB_SET_PQ_11	0xf00 /* Load */
-
-#define XIVE_ESB_VAL_P		0x2
-#define XIVE_ESB_VAL_Q		0x1
-
 /* Global enable flags for the XIVE support */
 extern bool __xive_enabled;
 
-- 
2.14.3

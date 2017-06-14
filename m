Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnS1f0G29zDqL0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 10:19:33 +1000 (AEST)
Message-ID: <1497399565.2897.23.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/xive: Fix offset for store EOI MMIOs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <michaele@au1.ibm.com>
Date: Wed, 14 Jun 2017 10:19:25 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Architecturally we should apply a 0x400 offset for these. Not doing
it will break future HW implementations.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/xive.h         | 12 +++++++-----
 arch/powerpc/kvm/book3s_xive_template.c |  4 ++--
 arch/powerpc/sysdev/xive/common.c       |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index c8a822a..c23ff43 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -94,11 +94,13 @@ struct xive_q {
  * store at 0 and some ESBs support doing a trigger via a
  * separate trigger page.
  */
-#define XIVE_ESB_GET		0x800
-#define XIVE_ESB_SET_PQ_00	0xc00
-#define XIVE_ESB_SET_PQ_01	0xd00
-#define XIVE_ESB_SET_PQ_10	0xe00
-#define XIVE_ESB_SET_PQ_11	0xf00
+#define XIVE_ESB_STORE_EOI	0x400 /* Store */
+#define XIVE_ESB_LOAD_EOI	0x000 /* Load */
+#define XIVE_ESB_GET		0x800 /* Load */
+#define XIVE_ESB_SET_PQ_00	0xc00 /* Load */
+#define XIVE_ESB_SET_PQ_01	0xd00 /* Load */
+#define XIVE_ESB_SET_PQ_10	0xe00 /* Load */
+#define XIVE_ESB_SET_PQ_11	0xf00 /* Load */
 
 #define XIVE_ESB_VAL_P		0x2
 #define XIVE_ESB_VAL_Q		0x1
diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
index 023a311..4636ca6 100644
--- a/arch/powerpc/kvm/book3s_xive_template.c
+++ b/arch/powerpc/kvm/book3s_xive_template.c
@@ -69,7 +69,7 @@ static void GLUE(X_PFX,source_eoi)(u32 hw_irq, struct xive_irq_data *xd)
 {
 	/* If the XIVE supports the new "store EOI facility, use it */
 	if (xd->flags & XIVE_IRQ_FLAG_STORE_EOI)
-		__x_writeq(0, __x_eoi_page(xd));
+		__x_writeq(0, __x_eoi_page(xd) + XIVE_ESB_STORE_EOI);
 	else if (hw_irq && xd->flags & XIVE_IRQ_FLAG_EOI_FW) {
 		opal_int_eoi(hw_irq);
 	} else {
@@ -89,7 +89,7 @@ static void GLUE(X_PFX,source_eoi)(u32 hw_irq, struct xive_irq_data *xd)
 		 * properly.
 		 */
 		if (xd->flags & XIVE_IRQ_FLAG_LSI)
-			__x_readq(__x_eoi_page(xd));
+			__x_readq(__x_eoi_page(xd) + XIVE_ESB_LOAD_EOI);
 		else {
 			eoi_val = GLUE(X_PFX,esb_load)(xd, XIVE_ESB_SET_PQ_00);
 
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 9138250..8f5e303 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -297,7 +297,7 @@ void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data *xd)
 {
 	/* If the XIVE supports the new "store EOI facility, use it */
 	if (xd->flags & XIVE_IRQ_FLAG_STORE_EOI)
-		out_be64(xd->eoi_mmio, 0);
+		out_be64(xd->eoi_mmio + XIVE_ESB_STORE_EOI, 0);
 	else if (hw_irq && xd->flags & XIVE_IRQ_FLAG_EOI_FW) {
 		/*
 		 * The FW told us to call it. This happens for some

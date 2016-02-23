Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 239D21A04ED
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 03:22:09 +1100 (AEDT)
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 16:22:06 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id D4BDF17D805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:22:25 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1NGM4bY35323994
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:22:04 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1NGM416008829
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 09:22:04 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 08/18] cxl: IRQ allocation for guests
Date: Tue, 23 Feb 2016 17:21:49 +0100
Message-Id: <1456244519-18934-9-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PSL interrupt cannot be multiplexed in a guest, as it is not
supported by the hypervisor. So an interrupt will be allocated
for it for each context. It will still be the first interrupt found in
the first interrupt range, but is treated almost like any other AFU
interrupt when creating/deleting the context. Only the handler is
different. Rework the code so that the range 0 is treated like the
other ranges.

Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/irq.c | 78 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 5033869..3c04c14 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -19,6 +19,13 @@
 #include "cxl.h"
 #include "trace.h"
 
+static int afu_irq_range_start(void)
+{
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		return 1;
+	return 0;
+}
+
 static irqreturn_t schedule_cxl_fault(struct cxl_context *ctx, u64 dsisr, u64 dar)
 {
 	ctx->dsisr = dsisr;
@@ -117,11 +124,23 @@ static irqreturn_t cxl_irq_afu(int irq, void *data)
 {
 	struct cxl_context *ctx = data;
 	irq_hw_number_t hwirq = irqd_to_hwirq(irq_get_irq_data(irq));
-	int irq_off, afu_irq = 1;
+	int irq_off, afu_irq = 0;
 	__u16 range;
 	int r;
 
-	for (r = 1; r < CXL_IRQ_RANGES; r++) {
+	/*
+	 * Look for the interrupt number.
+	 * On bare-metal, we know range 0 only contains the PSL
+	 * interrupt so we could start counting at range 1 and initialize
+	 * afu_irq at 1.
+	 * In a guest, range 0 also contains AFU interrupts, so it must
+	 * be counted for. Therefore we initialize afu_irq at 0 to take into
+	 * account the PSL interrupt.
+	 *
+	 * For code-readability, it just seems easier to go over all
+	 * the ranges on bare-metal and guest. The end result is the same.
+	 */
+	for (r = 0; r < CXL_IRQ_RANGES; r++) {
 		irq_off = hwirq - ctx->irqs.offset[r];
 		range = ctx->irqs.range[r];
 		if (irq_off >= 0 && irq_off < range) {
@@ -131,7 +150,7 @@ static irqreturn_t cxl_irq_afu(int irq, void *data)
 		afu_irq += range;
 	}
 	if (unlikely(r >= CXL_IRQ_RANGES)) {
-		WARN(1, "Recieved AFU IRQ out of range for pe %i (virq %i hwirq %lx)\n",
+		WARN(1, "Received AFU IRQ out of range for pe %i (virq %i hwirq %lx)\n",
 		     ctx->pe, irq, hwirq);
 		return IRQ_HANDLED;
 	}
@@ -141,7 +160,7 @@ static irqreturn_t cxl_irq_afu(int irq, void *data)
 	       afu_irq, ctx->pe, irq, hwirq);
 
 	if (unlikely(!ctx->irq_bitmap)) {
-		WARN(1, "Recieved AFU IRQ for context with no IRQ bitmap\n");
+		WARN(1, "Received AFU IRQ for context with no IRQ bitmap\n");
 		return IRQ_HANDLED;
 	}
 	spin_lock(&ctx->lock);
@@ -227,17 +246,33 @@ int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
 {
 	int rc, r, i, j = 1;
 	struct cxl_irq_name *irq_name;
+	int alloc_count;
+
+	/*
+	 * In native mode, range 0 is reserved for the multiplexed
+	 * PSL interrupt. It has been allocated when the AFU was initialized.
+	 *
+	 * In a guest, the PSL interrupt is not mutliplexed, but per-context,
+	 * and is the first interrupt from range 0. It still needs to be
+	 * allocated, so bump the count by one.
+	 */
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		alloc_count = count;
+	else
+		alloc_count = count + 1;
 
 	/* Initialize the list head to hold irq names */
 	INIT_LIST_HEAD(&ctx->irq_names);
 
 	if ((rc = cxl_ops->alloc_irq_ranges(&ctx->irqs, ctx->afu->adapter,
-							count)))
+							alloc_count)))
 		return rc;
 
-	/* Multiplexed PSL Interrupt */
-	ctx->irqs.offset[0] = ctx->afu->psl_hwirq;
-	ctx->irqs.range[0] = 1;
+	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		/* Multiplexed PSL Interrupt */
+		ctx->irqs.offset[0] = ctx->afu->psl_hwirq;
+		ctx->irqs.range[0] = 1;
+	}
 
 	ctx->irq_count = count;
 	ctx->irq_bitmap = kcalloc(BITS_TO_LONGS(count),
@@ -249,7 +284,7 @@ int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
 	 * Allocate names first.  If any fail, bail out before allocating
 	 * actual hardware IRQs.
 	 */
-	for (r = 1; r < CXL_IRQ_RANGES; r++) {
+	for (r = afu_irq_range_start(); r < CXL_IRQ_RANGES; r++) {
 		for (i = 0; i < ctx->irqs.range[r]; i++) {
 			irq_name = kmalloc(sizeof(struct cxl_irq_name),
 					   GFP_KERNEL);
@@ -279,15 +314,30 @@ static void afu_register_hwirqs(struct cxl_context *ctx)
 {
 	irq_hw_number_t hwirq;
 	struct cxl_irq_name *irq_name;
-	int r,i;
+	int r, i;
+	irqreturn_t (*handler)(int irq, void *data);
 
 	/* We've allocated all memory now, so let's do the irq allocations */
 	irq_name = list_first_entry(&ctx->irq_names, struct cxl_irq_name, list);
-	for (r = 1; r < CXL_IRQ_RANGES; r++) {
+	for (r = afu_irq_range_start(); r < CXL_IRQ_RANGES; r++) {
 		hwirq = ctx->irqs.offset[r];
 		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
-			cxl_map_irq(ctx->afu->adapter, hwirq,
-				    cxl_irq_afu, ctx, irq_name->name);
+			if (r == 0 && i == 0)
+				/*
+				 * The very first interrupt of range 0 is
+				 * always the PSL interrupt, but we only
+				 * need to connect a handler for guests,
+				 * because there's one PSL interrupt per
+				 * context.
+				 * On bare-metal, the PSL interrupt is
+				 * multiplexed and was setup when the AFU
+				 * was configured.
+				 */
+				handler = cxl_ops->psl_interrupt;
+			else
+				handler = cxl_irq_afu;
+			cxl_map_irq(ctx->afu->adapter, hwirq, handler, ctx,
+				irq_name->name);
 			irq_name = list_next_entry(irq_name, list);
 		}
 	}
@@ -311,7 +361,7 @@ void afu_release_irqs(struct cxl_context *ctx, void *cookie)
 	unsigned int virq;
 	int r, i;
 
-	for (r = 1; r < CXL_IRQ_RANGES; r++) {
+	for (r = afu_irq_range_start(); r < CXL_IRQ_RANGES; r++) {
 		hwirq = ctx->irqs.offset[r];
 		for (i = 0; i < ctx->irqs.range[r]; hwirq++, i++) {
 			virq = irq_find_mapping(NULL, hwirq);
-- 
1.9.1

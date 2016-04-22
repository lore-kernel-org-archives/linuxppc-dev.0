Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrjzz4hp1zDqhc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 14:58:07 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: Frederic Barrat <frederic.barrat@fr.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frank Haverkamp <HAVERKAM@de.ibm.com>,
 Joerg-Stephan Vogt <JSVOGT@de.ibm.com>,
 Wolfgang Bolz1 <Wolfgang.Bolz@de.ibm.com>, andrew.donnellan@au1.ibm.com
Subject: [PATCH 2/2] cxl: Poll for outstanding IRQs when detaching a context
Date: Fri, 22 Apr 2016 14:57:49 +1000
Message-Id: <1461301069-12331-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1461301069-12331-1-git-send-email-mikey@neuling.org>
References: <1461301069-12331-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When detaching contexts, we may still have interrupts in the system
which are yet to be delivered to any CPU and be acked in the PSL.
This can result in a subsequent unrelated process getting an spurious
IRQ or an interrupt for a non-existent context.

This polls the PSL to ensure that the PSL is clear of IRQs for the
detached context, before removing the context from the idr.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 drivers/misc/cxl/context.c |  7 +++++++
 drivers/misc/cxl/cxl.h     |  2 ++
 drivers/misc/cxl/native.c  | 31 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 10370f2..7edea9c 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -223,6 +223,13 @@ int __detach_context(struct cxl_context *ctx)
 		cxl_ops->link_ok(ctx->afu->adapter, ctx->afu));
 	flush_work(&ctx->fault_work); /* Only needed for dedicated process */
 
+	/*
+	 * Wait until no further interrupts are presented by the PSL
+	 * for this context.
+	 */
+	if (cxl_ops->irq_wait)
+		cxl_ops->irq_wait(ctx);
+
 	/* release the reference to the group leader and mm handling pid */
 	put_pid(ctx->pid);
 	put_pid(ctx->glpid);
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 38e21cf..73dc2a3 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -274,6 +274,7 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_PSL_DSISR_An_PE (1ull << (63-4))  /* PSL Error (implementation specific) */
 #define CXL_PSL_DSISR_An_AE (1ull << (63-5))  /* AFU Error */
 #define CXL_PSL_DSISR_An_OC (1ull << (63-6))  /* OS Context Warning */
+#define CXL_PSL_DSISR_PENDING (CXL_PSL_DSISR_TRANS | CXL_PSL_DSISR_An_PE | CXL_PSL_DSISR_An_AE | CXL_PSL_DSISR_An_OC)
 /* NOTE: Bits 32:63 are undefined if DSISR[DS] = 1 */
 #define CXL_PSL_DSISR_An_M  DSISR_NOHPTE      /* PTE not found */
 #define CXL_PSL_DSISR_An_P  DSISR_PROTFAULT   /* Storage protection violation */
@@ -855,6 +856,7 @@ struct cxl_backend_ops {
 					u64 dsisr, u64 errstat);
 	irqreturn_t (*psl_interrupt)(int irq, void *data);
 	int (*ack_irq)(struct cxl_context *ctx, u64 tfc, u64 psl_reset_mask);
+	void (*irq_wait)(struct cxl_context *ctx);
 	int (*attach_process)(struct cxl_context *ctx, bool kernel,
 			u64 wed, u64 amr);
 	int (*detach_process)(struct cxl_context *ctx);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 387fcbd..ecf7557 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/delay.h>
 #include <asm/synch.h>
 #include <misc/cxl-base.h>
 
@@ -797,6 +798,35 @@ static irqreturn_t native_irq_multiplexed(int irq, void *data)
 	return fail_psl_irq(afu, &irq_info);
 }
 
+void native_irq_wait(struct cxl_context *ctx)
+{
+	u64 dsisr;
+	int timeout = 1000;
+	int ph;
+
+	/*
+	 * Wait until no further interrupts are presented by the PSL
+	 * for this context.
+	 */
+	while (timeout--) {
+		ph = cxl_p2n_read(ctx->afu, CXL_PSL_PEHandle_An) & 0xffff;
+		if (ph != ctx->pe)
+			return;
+		dsisr = cxl_p2n_read(ctx->afu, CXL_PSL_DSISR_An);
+		if ((dsisr & CXL_PSL_DSISR_PENDING) == 0)
+			return;
+		/*
+		 * We are waiting for the workqueue to process our
+		 * irq, so need to let that run here.
+		 */
+		msleep(1);
+	}
+
+	dev_warn(&ctx->afu->dev, "WARNING: waiting on DSI for PE %i"
+		 " DSISR %016llx!\n", ph, dsisr);
+	return;
+}
+
 static irqreturn_t native_slice_irq_err(int irq, void *data)
 {
 	struct cxl_afu *afu = data;
@@ -1076,6 +1106,7 @@ const struct cxl_backend_ops cxl_native_ops = {
 	.handle_psl_slice_error = native_handle_psl_slice_error,
 	.psl_interrupt = NULL,
 	.ack_irq = native_ack_irq,
+	.irq_wait = native_irq_wait,
 	.attach_process = native_attach_process,
 	.detach_process = native_detach_process,
 	.support_attributes = native_support_attributes,
-- 
2.5.0

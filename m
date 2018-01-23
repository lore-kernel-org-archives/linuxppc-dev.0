Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQmNn0BDSzDr2M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 22:32:08 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0NBUkUb112105
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:32:06 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fnyqxu5hh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:32:06 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 23 Jan 2018 11:32:03 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH v2 09/13] ocxl: Add trace points
Date: Tue, 23 Jan 2018 12:31:44 +0100
In-Reply-To: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
References: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20180123113148.6024-10-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define a few trace points so that we can use the standard tracing
mechanism for debug and/or monitoring.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/ocxl/afu_irq.c |   5 ++
 drivers/misc/ocxl/context.c |   2 +
 drivers/misc/ocxl/link.c    |  11 ++-
 drivers/misc/ocxl/trace.c   |   6 ++
 drivers/misc/ocxl/trace.h   | 182 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 205 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/ocxl/trace.c
 create mode 100644 drivers/misc/ocxl/trace.h

diff --git a/drivers/misc/ocxl/afu_irq.c b/drivers/misc/ocxl/afu_irq.c
index f40d853de401..e70cfa24577f 100644
--- a/drivers/misc/ocxl/afu_irq.c
+++ b/drivers/misc/ocxl/afu_irq.c
@@ -4,6 +4,7 @@
 #include <linux/eventfd.h>
 #include <asm/pnv-ocxl.h>
 #include "ocxl_internal.h"
+#include "trace.h"
 
 struct afu_irq {
 	int id;
@@ -28,6 +29,7 @@ static irqreturn_t afu_irq_handler(int virq, void *data)
 {
 	struct afu_irq *irq = (struct afu_irq *) data;
 
+	trace_ocxl_afu_irq_receive(virq);
 	if (irq->ev_ctx)
 		eventfd_signal(irq->ev_ctx, 1);
 	return IRQ_HANDLED;
@@ -102,6 +104,8 @@ int ocxl_afu_irq_alloc(struct ocxl_context *ctx, u64 *irq_offset)
 
 	*irq_offset = irq_id_to_offset(ctx, irq->id);
 
+	trace_ocxl_afu_irq_alloc(ctx->pasid, irq->id, irq->virq, irq->hw_irq,
+				*irq_offset);
 	mutex_unlock(&ctx->irq_lock);
 	return 0;
 
@@ -117,6 +121,7 @@ int ocxl_afu_irq_alloc(struct ocxl_context *ctx, u64 *irq_offset)
 
 static void afu_irq_free(struct afu_irq *irq, struct ocxl_context *ctx)
 {
+	trace_ocxl_afu_irq_free(ctx->pasid, irq->id);
 	if (ctx->mapping)
 		unmap_mapping_range(ctx->mapping,
 				irq_id_to_offset(ctx, irq->id),
diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index 269149490063..909e8807824a 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Copyright 2017 IBM Corp.
 #include <linux/sched/mm.h>
+#include "trace.h"
 #include "ocxl_internal.h"
 
 struct ocxl_context *ocxl_context_alloc(void)
@@ -214,6 +215,7 @@ int ocxl_context_detach(struct ocxl_context *ctx)
 	mutex_lock(&ctx->afu->afu_control_lock);
 	rc = ocxl_config_terminate_pasid(dev, afu_control_pos, ctx->pasid);
 	mutex_unlock(&ctx->afu->afu_control_lock);
+	trace_ocxl_terminate_pasid(ctx->pasid, rc);
 	if (rc) {
 		/*
 		 * If we timeout waiting for the AFU to terminate the
diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index fbca3feec592..f30790582dc0 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -7,6 +7,7 @@
 #include <asm/pnv-ocxl.h>
 #include <misc/ocxl.h>
 #include "ocxl_internal.h"
+#include "trace.h"
 
 
 #define SPA_PASID_BITS		15
@@ -116,8 +117,11 @@ static void ack_irq(struct spa *spa, enum xsl_response r)
 	else
 		WARN(1, "Invalid irq response %d\n", r);
 
-	if (reg)
+	if (reg) {
+		trace_ocxl_fault_ack(spa->spa_mem, spa->xsl_fault.pe,
+				spa->xsl_fault.dsisr, spa->xsl_fault.dar, reg);
 		out_be64(spa->reg_tfc, reg);
+	}
 }
 
 static void xsl_fault_handler_bh(struct work_struct *fault_work)
@@ -182,6 +186,7 @@ static irqreturn_t xsl_fault_handler(int irq, void *data)
 	int lpid, pid, tid;
 
 	read_irq(spa, &dsisr, &dar, &pe_handle);
+	trace_ocxl_fault(spa->spa_mem, pe_handle, dsisr, dar, -1);
 
 	WARN_ON(pe_handle > SPA_PE_MASK);
 	pe = spa->spa_mem + pe_handle;
@@ -532,6 +537,7 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
 	 * the problem.
 	 */
 	mmgrab(mm);
+	trace_ocxl_context_add(current->pid, spa->spa_mem, pasid, pidr, tidr);
 unlock:
 	mutex_unlock(&spa->spa_lock);
 	return rc;
@@ -577,6 +583,9 @@ int ocxl_link_remove_pe(void *link_handle, int pasid)
 		goto unlock;
 	}
 
+	trace_ocxl_context_remove(current->pid, spa->spa_mem, pasid,
+				be32_to_cpu(pe->pid), be32_to_cpu(pe->tid));
+
 	memset(pe, 0, sizeof(struct ocxl_process_element));
 	/*
 	 * The barrier makes sure the PE is removed from the SPA
diff --git a/drivers/misc/ocxl/trace.c b/drivers/misc/ocxl/trace.c
new file mode 100644
index 000000000000..1e6947049697
--- /dev/null
+++ b/drivers/misc/ocxl/trace.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2017 IBM Corp.
+#ifndef __CHECKER__
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+#endif
diff --git a/drivers/misc/ocxl/trace.h b/drivers/misc/ocxl/trace.h
new file mode 100644
index 000000000000..bcb7ff330c1e
--- /dev/null
+++ b/drivers/misc/ocxl/trace.h
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2017 IBM Corp.
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ocxl
+
+#if !defined(_TRACE_OCXL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_OCXL_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(ocxl_context,
+	TP_PROTO(pid_t pid, void *spa, int pasid, u32 pidr, u32 tidr),
+	TP_ARGS(pid, spa, pasid, pidr, tidr),
+
+	TP_STRUCT__entry(
+		__field(pid_t, pid)
+		__field(void*, spa)
+		__field(int, pasid)
+		__field(u32, pidr)
+		__field(u32, tidr)
+	),
+
+	TP_fast_assign(
+		__entry->pid = pid;
+		__entry->spa = spa;
+		__entry->pasid = pasid;
+		__entry->pidr = pidr;
+		__entry->tidr = tidr;
+	),
+
+	TP_printk("linux pid=%d spa=0x%p pasid=0x%x pidr=0x%x tidr=0x%x",
+		__entry->pid,
+		__entry->spa,
+		__entry->pasid,
+		__entry->pidr,
+		__entry->tidr
+	)
+);
+
+DEFINE_EVENT(ocxl_context, ocxl_context_add,
+	TP_PROTO(pid_t pid, void *spa, int pasid, u32 pidr, u32 tidr),
+	TP_ARGS(pid, spa, pasid, pidr, tidr)
+);
+
+DEFINE_EVENT(ocxl_context, ocxl_context_remove,
+	TP_PROTO(pid_t pid, void *spa, int pasid, u32 pidr, u32 tidr),
+	TP_ARGS(pid, spa, pasid, pidr, tidr)
+);
+
+TRACE_EVENT(ocxl_terminate_pasid,
+	TP_PROTO(int pasid, int rc),
+	TP_ARGS(pasid, rc),
+
+	TP_STRUCT__entry(
+		__field(int, pasid)
+		__field(int, rc)
+	),
+
+	TP_fast_assign(
+		__entry->pasid = pasid;
+		__entry->rc = rc;
+	),
+
+	TP_printk("pasid=0x%x rc=%d",
+		__entry->pasid,
+		__entry->rc
+	)
+);
+
+DECLARE_EVENT_CLASS(ocxl_fault_handler,
+	TP_PROTO(void *spa, u64 pe, u64 dsisr, u64 dar, u64 tfc),
+	TP_ARGS(spa, pe, dsisr, dar, tfc),
+
+	TP_STRUCT__entry(
+		__field(void *, spa)
+		__field(u64, pe)
+		__field(u64, dsisr)
+		__field(u64, dar)
+		__field(u64, tfc)
+	),
+
+	TP_fast_assign(
+		__entry->spa = spa;
+		__entry->pe = pe;
+		__entry->dsisr = dsisr;
+		__entry->dar = dar;
+		__entry->tfc = tfc;
+	),
+
+	TP_printk("spa=%p pe=0x%llx dsisr=0x%llx dar=0x%llx tfc=0x%llx",
+		__entry->spa,
+		__entry->pe,
+		__entry->dsisr,
+		__entry->dar,
+		__entry->tfc
+	)
+);
+
+DEFINE_EVENT(ocxl_fault_handler, ocxl_fault,
+	TP_PROTO(void *spa, u64 pe, u64 dsisr, u64 dar, u64 tfc),
+	TP_ARGS(spa, pe, dsisr, dar, tfc)
+);
+
+DEFINE_EVENT(ocxl_fault_handler, ocxl_fault_ack,
+	TP_PROTO(void *spa, u64 pe, u64 dsisr, u64 dar, u64 tfc),
+	TP_ARGS(spa, pe, dsisr, dar, tfc)
+);
+
+TRACE_EVENT(ocxl_afu_irq_alloc,
+	TP_PROTO(int pasid, int irq_id, unsigned int virq, int hw_irq,
+		u64 irq_offset),
+	TP_ARGS(pasid, irq_id, virq, hw_irq, irq_offset),
+
+	TP_STRUCT__entry(
+		__field(int, pasid)
+		__field(int, irq_id)
+		__field(unsigned int, virq)
+		__field(int, hw_irq)
+		__field(u64, irq_offset)
+	),
+
+	TP_fast_assign(
+		__entry->pasid = pasid;
+		__entry->irq_id = irq_id;
+		__entry->virq = virq;
+		__entry->hw_irq = hw_irq;
+		__entry->irq_offset = irq_offset;
+	),
+
+	TP_printk("pasid=0x%x irq_id=%d virq=%u hw_irq=%d irq_offset=0x%llx",
+		__entry->pasid,
+		__entry->irq_id,
+		__entry->virq,
+		__entry->hw_irq,
+		__entry->irq_offset
+	)
+);
+
+TRACE_EVENT(ocxl_afu_irq_free,
+	TP_PROTO(int pasid, int irq_id),
+	TP_ARGS(pasid, irq_id),
+
+	TP_STRUCT__entry(
+		__field(int, pasid)
+		__field(int, irq_id)
+	),
+
+	TP_fast_assign(
+		__entry->pasid = pasid;
+		__entry->irq_id = irq_id;
+	),
+
+	TP_printk("pasid=0x%x irq_id=%d",
+		__entry->pasid,
+		__entry->irq_id
+	)
+);
+
+TRACE_EVENT(ocxl_afu_irq_receive,
+	TP_PROTO(int virq),
+	TP_ARGS(virq),
+
+	TP_STRUCT__entry(
+		__field(int, virq)
+	),
+
+	TP_fast_assign(
+		__entry->virq = virq;
+	),
+
+	TP_printk("virq=%d",
+		__entry->virq
+	)
+);
+
+#endif /* _TRACE_OCXL_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+#include <trace/define_trace.h>
-- 
2.14.1

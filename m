Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400qNf1SC7zDr5K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 20:31:13 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2D9UgOv072175
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 05:31:10 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gp9gpwg73-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 05:31:06 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 13 Mar 2018 09:30:44 -0000
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH] cxl: Add new kernel traces
Date: Tue, 13 Mar 2018 10:30:40 +0100
Message-Id: <1520933440-24652-1-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds new kernel traces in the current in-kernel 'library'
which can be called by other drivers to help interacting with an
IBM XSL on a POWER9 system.

If some kernel traces exist in the 'normal path' to handle a page or a
segment fault, some others are missing when a page fault is handle
through cxllib.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxllib.c |   3 ++
 drivers/misc/cxl/fault.c  |   2 +
 drivers/misc/cxl/irq.c    |   2 +-
 drivers/misc/cxl/trace.h  | 115 ++++++++++++++++++++++++++--------------------
 4 files changed, 72 insertions(+), 50 deletions(-)

diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
index 30ccba4..91cfb69 100644
--- a/drivers/misc/cxl/cxllib.c
+++ b/drivers/misc/cxl/cxllib.c
@@ -13,6 +13,7 @@
 #include <misc/cxllib.h>
 
 #include "cxl.h"
+#include "trace.h"
 
 #define CXL_INVALID_DRA                 ~0ull
 #define CXL_DUMMY_READ_SIZE             128
@@ -218,6 +219,8 @@ int cxllib_handle_fault(struct mm_struct *mm, u64 addr, u64 size, u64 flags)
 	if (mm == NULL)
 		return -EFAULT;
 
+	trace_cxl_lib_handle_fault(addr, size, flags);
+
 	down_read(&mm->mmap_sem);
 
 	vma = find_vma(mm, addr);
diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 70dbb6d..1c4fd74 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -138,6 +138,8 @@ int cxl_handle_mm_fault(struct mm_struct *mm, u64 dsisr, u64 dar)
 	int result;
 	unsigned long access, flags, inv_flags = 0;
 
+	trace_cxl_handle_mm_fault(dsisr, dar);
+
 	/*
 	 * Add the fault handling cpu to task mm cpumask so that we
 	 * can do a safe lockless page table walk when inserting the
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index ce08a9f..79b8b49 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -41,7 +41,7 @@ irqreturn_t cxl_irq_psl9(int irq, struct cxl_context *ctx, struct cxl_irq_info *
 	dsisr = irq_info->dsisr;
 	dar = irq_info->dar;
 
-	trace_cxl_psl9_irq(ctx, irq, dsisr, dar);
+	trace_cxl_psl_irq(ctx, irq, dsisr, dar);
 
 	pr_devel("CXL interrupt %i for afu pe: %i DSISR: %#llx DAR: %#llx\n", irq, ctx->pe, dsisr, dar);
 
diff --git a/drivers/misc/cxl/trace.h b/drivers/misc/cxl/trace.h
index b8e300a..8eb2607 100644
--- a/drivers/misc/cxl/trace.h
+++ b/drivers/misc/cxl/trace.h
@@ -26,19 +26,20 @@
 		{ CXL_PSL9_DSISR_An_OC,		"OC" }, \
 		{ CXL_PSL9_DSISR_An_S,		"S" })
 
-#define DSISR_FLAGS \
-	{ CXL_PSL_DSISR_An_DS,	"DS" }, \
-	{ CXL_PSL_DSISR_An_DM,	"DM" }, \
-	{ CXL_PSL_DSISR_An_ST,	"ST" }, \
-	{ CXL_PSL_DSISR_An_UR,	"UR" }, \
-	{ CXL_PSL_DSISR_An_PE,	"PE" }, \
-	{ CXL_PSL_DSISR_An_AE,	"AE" }, \
-	{ CXL_PSL_DSISR_An_OC,	"OC" }, \
-	{ CXL_PSL_DSISR_An_M,	"M" }, \
-	{ CXL_PSL_DSISR_An_P,	"P" }, \
-	{ CXL_PSL_DSISR_An_A,	"A" }, \
-	{ CXL_PSL_DSISR_An_S,	"S" }, \
-	{ CXL_PSL_DSISR_An_K,	"K" }
+#define dsisr_psl8_flags(flags) \
+	__print_flags(flags, "|", \
+		{ CXL_PSL_DSISR_An_DS,	"DS" }, \
+		{ CXL_PSL_DSISR_An_DM,	"DM" }, \
+		{ CXL_PSL_DSISR_An_ST,	"ST" }, \
+		{ CXL_PSL_DSISR_An_UR,	"UR" }, \
+		{ CXL_PSL_DSISR_An_PE,	"PE" }, \
+		{ CXL_PSL_DSISR_An_AE,	"AE" }, \
+		{ CXL_PSL_DSISR_An_OC,	"OC" }, \
+		{ CXL_PSL_DSISR_An_M,	"M" }, \
+		{ CXL_PSL_DSISR_An_P,	"P" }, \
+		{ CXL_PSL_DSISR_An_A,	"A" }, \
+		{ CXL_PSL_DSISR_An_S,	"S" }, \
+		{ CXL_PSL_DSISR_An_K,	"K" })
 
 #define TFC_FLAGS \
 	{ CXL_PSL_TFC_An_A,	"A" }, \
@@ -163,7 +164,7 @@ TRACE_EVENT(cxl_afu_irq,
 	)
 );
 
-TRACE_EVENT(cxl_psl9_irq,
+TRACE_EVENT(cxl_psl_irq,
 	TP_PROTO(struct cxl_context *ctx, int irq, u64 dsisr, u64 dar),
 
 	TP_ARGS(ctx, irq, dsisr, dar),
@@ -192,40 +193,8 @@ TRACE_EVENT(cxl_psl9_irq,
 		__entry->pe,
 		__entry->irq,
 		__entry->dsisr,
-		dsisr_psl9_flags(__entry->dsisr),
-		__entry->dar
-	)
-);
-
-TRACE_EVENT(cxl_psl_irq,
-	TP_PROTO(struct cxl_context *ctx, int irq, u64 dsisr, u64 dar),
-
-	TP_ARGS(ctx, irq, dsisr, dar),
-
-	TP_STRUCT__entry(
-		__field(u8, card)
-		__field(u8, afu)
-		__field(u16, pe)
-		__field(int, irq)
-		__field(u64, dsisr)
-		__field(u64, dar)
-	),
-
-	TP_fast_assign(
-		__entry->card = ctx->afu->adapter->adapter_num;
-		__entry->afu = ctx->afu->slice;
-		__entry->pe = ctx->pe;
-		__entry->irq = irq;
-		__entry->dsisr = dsisr;
-		__entry->dar = dar;
-	),
-
-	TP_printk("afu%i.%i pe=%i irq=%i dsisr=%s dar=0x%016llx",
-		__entry->card,
-		__entry->afu,
-		__entry->pe,
-		__entry->irq,
-		__print_flags(__entry->dsisr, "|", DSISR_FLAGS),
+		cxl_is_power8() ? dsisr_psl8_flags(__entry->dsisr) :
+				  dsisr_psl9_flags(__entry->dsisr),
 		__entry->dar
 	)
 );
@@ -342,11 +311,59 @@ TRACE_EVENT(cxl_pte_miss,
 		__entry->card,
 		__entry->afu,
 		__entry->pe,
-		__print_flags(__entry->dsisr, "|", DSISR_FLAGS),
+		cxl_is_power8() ? dsisr_psl8_flags(__entry->dsisr) :
+				  dsisr_psl9_flags(__entry->dsisr),
+		__entry->dar
+	)
+);
+
+TRACE_EVENT(cxl_handle_mm_fault,
+	TP_PROTO(u64 dsisr, u64 dar),
+
+	TP_ARGS(dsisr, dar),
+
+	TP_STRUCT__entry(
+		__field(u64, dsisr)
+		__field(u64, dar)
+	),
+
+	TP_fast_assign(
+		__entry->dsisr = dsisr;
+		__entry->dar = dar;
+	),
+
+	TP_printk("dsisr=0x%016llx(%s), dar=0x%016llx",
+		__entry->dsisr,
+		cxl_is_power8() ? dsisr_psl8_flags(__entry->dsisr) :
+				  dsisr_psl9_flags(__entry->dsisr),
 		__entry->dar
 	)
 );
 
+TRACE_EVENT(cxl_lib_handle_fault,
+	TP_PROTO(u64 addr, u64 size, u64 flags),
+
+	TP_ARGS(addr, size, flags),
+
+	TP_STRUCT__entry(
+		__field(u64, addr)
+		__field(u64, size)
+		__field(u64, flags)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->size = size;
+		__entry->flags = flags;
+	),
+
+	TP_printk("addr=0x%016llx, size=0x%016llx, flags=0x%016llx",
+		__entry->addr,
+		__entry->size,
+		__entry->flags
+	)
+);
+
 TRACE_EVENT(cxl_llcmd,
 	TP_PROTO(struct cxl_context *ctx, u64 cmd),
 
-- 
2.7.4

Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 394F81A0B63
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 22:27:10 +1100 (AEDT)
Received: from localhost
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 11:27:07 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id CCB0C17D8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:27:31 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u24BR6hc5046566
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:27:06 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u24BR5lf007740
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 04:27:05 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, manoj@linux.vnet.ibm.com,
 mrochs@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 18/20] cxl: Add tracepoints around the cxl hcall
Date: Fri,  4 Mar 2016 12:26:42 +0100
Message-Id: <1457090804-9719-19-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1457090804-9719-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Lombard <clombard@linux.vnet.ibm.com>

To ease debugging, add a few tracepoints around the cxl hcalls.

Co-authored-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/hcalls.c |   9 +++
 drivers/misc/cxl/trace.h  | 193 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 202 insertions(+)

diff --git a/drivers/misc/cxl/hcalls.c b/drivers/misc/cxl/hcalls.c
index 7e4c517..f01d4c0 100644
--- a/drivers/misc/cxl/hcalls.c
+++ b/drivers/misc/cxl/hcalls.c
@@ -14,6 +14,7 @@
 #include <asm/hvcall.h>
 #include <asm/byteorder.h>
 #include "hcalls.h"
+#include "trace.h"
 
 #define CXL_HCALL_TIMEOUT 60000
 #define CXL_HCALL_TIMEOUT_DOWNLOAD 120000
@@ -142,6 +143,7 @@ long cxl_h_attach_process(u64 unit_address,
 	CXL_H_WAIT_UNTIL_DONE(rc, retbuf, H_ATTACH_CA_PROCESS, unit_address, virt_to_phys(element));
 	_PRINT_MSG(rc, "cxl_h_attach_process(%#.16llx, %#.16lx): %li\n",
 		unit_address, virt_to_phys(element), rc);
+	trace_cxl_hcall_attach(unit_address, virt_to_phys(element), retbuf[0], retbuf[1], retbuf[2], rc);
 
 	pr_devel("token: 0x%.8lx mmio_addr: 0x%lx mmio_size: 0x%lx\nProcess Element Structure:\n",
 		retbuf[0], retbuf[1], retbuf[2]);
@@ -181,6 +183,7 @@ long cxl_h_detach_process(u64 unit_address, u64 process_token)
 
 	CXL_H_WAIT_UNTIL_DONE(rc, retbuf, H_DETACH_CA_PROCESS, unit_address, process_token);
 	_PRINT_MSG(rc, "cxl_h_detach_process(%#.16llx, 0x%.8llx): %li\n", unit_address, process_token, rc);
+	trace_cxl_hcall_detach(unit_address, process_token, rc);
 
 	switch (rc) {
 	case H_SUCCESS:       /* The process was detached from the coherent platform function */
@@ -213,6 +216,7 @@ static long cxl_h_control_function(u64 unit_address, u64 op,
 	CXL_H9_WAIT_UNTIL_DONE(rc, retbuf, H_CONTROL_CA_FUNCTION, unit_address, op, p1, p2, p3, p4);
 	_PRINT_MSG(rc, "cxl_h_control_function(%#.16llx, %s(%#llx, %#llx, %#llx, %#llx, R4: %#lx)): %li\n",
 		unit_address, OP_STR_AFU(op), p1, p2, p3, p4, retbuf[0], rc);
+	trace_cxl_hcall_control_function(unit_address, OP_STR_AFU(op), p1, p2, p3, p4, retbuf[0], rc);
 
 	switch (rc) {
 	case H_SUCCESS:       /* The operation is completed for the coherent platform function */
@@ -406,6 +410,7 @@ long cxl_h_collect_int_info(u64 unit_address, u64 process_token,
 			unit_address, process_token);
 	_PRINT_MSG(rc, "cxl_h_collect_int_info(%#.16llx, 0x%llx): %li\n",
 		unit_address, process_token, rc);
+	trace_cxl_hcall_collect_int_info(unit_address, process_token, rc);
 
 	switch (rc) {
 	case H_SUCCESS:     /* The interrupt info is returned in return registers. */
@@ -449,6 +454,8 @@ long cxl_h_control_faults(u64 unit_address, u64 process_token,
 	_PRINT_MSG(rc, "cxl_h_control_faults(%#.16llx, 0x%llx, %#llx, %#llx): %li (%#lx)\n",
 		unit_address, process_token, control_mask, reset_mask,
 		rc, retbuf[0]);
+	trace_cxl_hcall_control_faults(unit_address, process_token,
+				control_mask, reset_mask, retbuf[0], rc);
 
 	switch (rc) {
 	case H_SUCCESS:    /* Faults were successfully controlled for the function. */
@@ -482,6 +489,7 @@ static long cxl_h_control_facility(u64 unit_address, u64 op,
 	CXL_H9_WAIT_UNTIL_DONE(rc, retbuf, H_CONTROL_CA_FACILITY, unit_address, op, p1, p2, p3, p4);
 	_PRINT_MSG(rc, "cxl_h_control_facility(%#.16llx, %s(%#llx, %#llx, %#llx, %#llx, R4: %#lx)): %li\n",
 		unit_address, OP_STR_CONTROL_ADAPTER(op), p1, p2, p3, p4, retbuf[0], rc);
+	trace_cxl_hcall_control_facility(unit_address, OP_STR_CONTROL_ADAPTER(op), p1, p2, p3, p4, retbuf[0], rc);
 
 	switch (rc) {
 	case H_SUCCESS:       /* The operation is completed for the coherent platform facility */
@@ -588,6 +596,7 @@ static long cxl_h_download_facility(u64 unit_address, u64 op,
 	}
 	_PRINT_MSG(rc, "cxl_h_download_facility(%#.16llx, %s(%#llx, %#llx), %#lx): %li\n",
 		 unit_address, OP_STR_DOWNLOAD_ADAPTER(op), list_address, num, retbuf[0], rc);
+	trace_cxl_hcall_download_facility(unit_address, OP_STR_DOWNLOAD_ADAPTER(op), list_address, num, retbuf[0], rc);
 
 	switch (rc) {
 	case H_SUCCESS:       /* The operation is completed for the coherent platform facility */
diff --git a/drivers/misc/cxl/trace.h b/drivers/misc/cxl/trace.h
index 6e1e2ad..751d611 100644
--- a/drivers/misc/cxl/trace.h
+++ b/drivers/misc/cxl/trace.h
@@ -450,6 +450,199 @@ DEFINE_EVENT(cxl_pe_class, cxl_slbia,
 	TP_ARGS(ctx)
 );
 
+TRACE_EVENT(cxl_hcall,
+	TP_PROTO(u64 unit_address, u64 process_token, long rc),
+
+	TP_ARGS(unit_address, process_token, rc),
+
+	TP_STRUCT__entry(
+		__field(u64, unit_address)
+		__field(u64, process_token)
+		__field(long, rc)
+	),
+
+	TP_fast_assign(
+		__entry->unit_address = unit_address;
+		__entry->process_token = process_token;
+		__entry->rc = rc;
+	),
+
+	TP_printk("unit_address=0x%016llx process_token=0x%016llx rc=%li",
+		__entry->unit_address,
+		__entry->process_token,
+		__entry->rc
+	)
+);
+
+TRACE_EVENT(cxl_hcall_control,
+	TP_PROTO(u64 unit_address, char *fct, u64 p1, u64 p2, u64 p3,
+	u64 p4, unsigned long r4, long rc),
+
+	TP_ARGS(unit_address, fct, p1, p2, p3, p4, r4, rc),
+
+	TP_STRUCT__entry(
+		__field(u64, unit_address)
+		__field(char *, fct)
+		__field(u64, p1)
+		__field(u64, p2)
+		__field(u64, p3)
+		__field(u64, p4)
+		__field(unsigned long, r4)
+		__field(long, rc)
+	),
+
+	TP_fast_assign(
+		__entry->unit_address = unit_address;
+		__entry->fct = fct;
+		__entry->p1 = p1;
+		__entry->p2 = p2;
+		__entry->p3 = p3;
+		__entry->p4 = p4;
+		__entry->r4 = r4;
+		__entry->rc = rc;
+	),
+
+	TP_printk("unit_address=%#.16llx %s(%#llx, %#llx, %#llx, %#llx, R4: %#lx)): %li",
+		__entry->unit_address,
+		__entry->fct,
+		__entry->p1,
+		__entry->p2,
+		__entry->p3,
+		__entry->p4,
+		__entry->r4,
+		__entry->rc
+	)
+);
+
+TRACE_EVENT(cxl_hcall_attach,
+	TP_PROTO(u64 unit_address, u64 phys_addr, unsigned long process_token,
+		unsigned long mmio_addr, unsigned long mmio_size, long rc),
+
+	TP_ARGS(unit_address, phys_addr, process_token,
+		mmio_addr, mmio_size, rc),
+
+	TP_STRUCT__entry(
+		__field(u64, unit_address)
+		__field(u64, phys_addr)
+		__field(unsigned long, process_token)
+		__field(unsigned long, mmio_addr)
+		__field(unsigned long, mmio_size)
+		__field(long, rc)
+	),
+
+	TP_fast_assign(
+		__entry->unit_address = unit_address;
+		__entry->phys_addr = phys_addr;
+		__entry->process_token = process_token;
+		__entry->mmio_addr = mmio_addr;
+		__entry->mmio_size = mmio_size;
+		__entry->rc = rc;
+	),
+
+	TP_printk("unit_address=0x%016llx phys_addr=0x%016llx "
+		"token=0x%.8lx mmio_addr=0x%lx mmio_size=0x%lx rc=%li",
+		__entry->unit_address,
+		__entry->phys_addr,
+		__entry->process_token,
+		__entry->mmio_addr,
+		__entry->mmio_size,
+		__entry->rc
+	)
+);
+
+DEFINE_EVENT(cxl_hcall, cxl_hcall_detach,
+	TP_PROTO(u64 unit_address, u64 process_token, long rc),
+	TP_ARGS(unit_address, process_token, rc)
+);
+
+DEFINE_EVENT(cxl_hcall_control, cxl_hcall_control_function,
+	TP_PROTO(u64 unit_address, char *fct, u64 p1, u64 p2, u64 p3,
+	u64 p4, unsigned long r4, long rc),
+	TP_ARGS(unit_address, fct, p1, p2, p3, p4, r4, rc)
+);
+
+DEFINE_EVENT(cxl_hcall, cxl_hcall_collect_int_info,
+	TP_PROTO(u64 unit_address, u64 process_token, long rc),
+	TP_ARGS(unit_address, process_token, rc)
+);
+
+TRACE_EVENT(cxl_hcall_control_faults,
+	TP_PROTO(u64 unit_address, u64 process_token,
+		u64 control_mask, u64 reset_mask, unsigned long r4,
+		long rc),
+
+	TP_ARGS(unit_address, process_token,
+		control_mask, reset_mask, r4, rc),
+
+	TP_STRUCT__entry(
+		__field(u64, unit_address)
+		__field(u64, process_token)
+		__field(u64, control_mask)
+		__field(u64, reset_mask)
+		__field(unsigned long, r4)
+		__field(long, rc)
+	),
+
+	TP_fast_assign(
+		__entry->unit_address = unit_address;
+		__entry->process_token = process_token;
+		__entry->control_mask = control_mask;
+		__entry->reset_mask = reset_mask;
+		__entry->r4 = r4;
+		__entry->rc = rc;
+	),
+
+	TP_printk("unit_address=0x%016llx process_token=0x%llx "
+		"control_mask=%#llx reset_mask=%#llx r4=%#lx rc=%li",
+		__entry->unit_address,
+		__entry->process_token,
+		__entry->control_mask,
+		__entry->reset_mask,
+		__entry->r4,
+		__entry->rc
+	)
+);
+
+DEFINE_EVENT(cxl_hcall_control, cxl_hcall_control_facility,
+	TP_PROTO(u64 unit_address, char *fct, u64 p1, u64 p2, u64 p3,
+	u64 p4, unsigned long r4, long rc),
+	TP_ARGS(unit_address, fct, p1, p2, p3, p4, r4, rc)
+);
+
+TRACE_EVENT(cxl_hcall_download_facility,
+	TP_PROTO(u64 unit_address, char *fct, u64 list_address, u64 num,
+	unsigned long r4, long rc),
+
+	TP_ARGS(unit_address, fct, list_address, num, r4, rc),
+
+	TP_STRUCT__entry(
+		__field(u64, unit_address)
+		__field(char *, fct)
+		__field(u64, list_address)
+		__field(u64, num)
+		__field(unsigned long, r4)
+		__field(long, rc)
+	),
+
+	TP_fast_assign(
+		__entry->unit_address = unit_address;
+		__entry->fct = fct;
+		__entry->list_address = list_address;
+		__entry->num = num;
+		__entry->r4 = r4;
+		__entry->rc = rc;
+	),
+
+	TP_printk("%#.16llx, %s(%#llx, %#llx), %#lx): %li",
+		__entry->unit_address,
+		__entry->fct,
+		__entry->list_address,
+		__entry->num,
+		__entry->r4,
+		__entry->rc
+	)
+);
+
 #endif /* _CXL_TRACE_H */
 
 /* This part must be outside protection */
-- 
1.9.1

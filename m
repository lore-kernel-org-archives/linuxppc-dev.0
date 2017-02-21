Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS3Qb2VcRzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 12:52:07 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS3QZ6Wwqz9s8G
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:52:06 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L1nE7Y018966
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:52:05 -0500
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r3p8tx3y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:52:04 -0500
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 07:22:01 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 5DD59125805B
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:22:04 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L1otcf31588440
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:20:55 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L1pvMd031414
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:21:57 +0530
Subject: [RFC PATCH 1/7] powerpc/book3s: Move machine check event structure
 to opal-api.h
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 21 Feb 2017 07:21:56 +0530
In-Reply-To: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
References: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148764191593.19289.166429326262713768.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Going forward from Power9, linux would take firmware's (OPAL) help to
exract MCE error reason. OPAL will now handle all chip specific processing
to extract the error reason and send high level information through this
machine check event structure. Hence this structure is now an ABI.

No functionality change.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mce.h        |  110 +--------------------
 arch/powerpc/include/asm/opal-api.h   |  176 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/mce.c             |   18 ++-
 arch/powerpc/platforms/powernv/opal.c |    4 -
 4 files changed, 191 insertions(+), 117 deletions(-)

diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index f97d8cb..36db6b0 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -23,6 +23,7 @@
 #define __ASM_PPC64_MCE_H__
 
 #include <linux/bitops.h>
+#include <asm/opal.h>
 
 /*
  * Machine Check bits on power7 and power8
@@ -66,109 +67,6 @@
 
 #define P8_DSISR_MC_SLB_ERRORS		(P7_DSISR_MC_SLB_ERRORS | \
 					 P8_DSISR_MC_ERAT_MULTIHIT_SEC)
-enum MCE_Version {
-	MCE_V1 = 1,
-};
-
-enum MCE_Severity {
-	MCE_SEV_NO_ERROR = 0,
-	MCE_SEV_WARNING = 1,
-	MCE_SEV_ERROR_SYNC = 2,
-	MCE_SEV_FATAL = 3,
-};
-
-enum MCE_Disposition {
-	MCE_DISPOSITION_RECOVERED = 0,
-	MCE_DISPOSITION_NOT_RECOVERED = 1,
-};
-
-enum MCE_Initiator {
-	MCE_INITIATOR_UNKNOWN = 0,
-	MCE_INITIATOR_CPU = 1,
-};
-
-enum MCE_ErrorType {
-	MCE_ERROR_TYPE_UNKNOWN = 0,
-	MCE_ERROR_TYPE_UE = 1,
-	MCE_ERROR_TYPE_SLB = 2,
-	MCE_ERROR_TYPE_ERAT = 3,
-	MCE_ERROR_TYPE_TLB = 4,
-};
-
-enum MCE_UeErrorType {
-	MCE_UE_ERROR_INDETERMINATE = 0,
-	MCE_UE_ERROR_IFETCH = 1,
-	MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH = 2,
-	MCE_UE_ERROR_LOAD_STORE = 3,
-	MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE = 4,
-};
-
-enum MCE_SlbErrorType {
-	MCE_SLB_ERROR_INDETERMINATE = 0,
-	MCE_SLB_ERROR_PARITY = 1,
-	MCE_SLB_ERROR_MULTIHIT = 2,
-};
-
-enum MCE_EratErrorType {
-	MCE_ERAT_ERROR_INDETERMINATE = 0,
-	MCE_ERAT_ERROR_PARITY = 1,
-	MCE_ERAT_ERROR_MULTIHIT = 2,
-};
-
-enum MCE_TlbErrorType {
-	MCE_TLB_ERROR_INDETERMINATE = 0,
-	MCE_TLB_ERROR_PARITY = 1,
-	MCE_TLB_ERROR_MULTIHIT = 2,
-};
-
-struct machine_check_event {
-	enum MCE_Version	version:8;	/* 0x00 */
-	uint8_t			in_use;		/* 0x01 */
-	enum MCE_Severity	severity:8;	/* 0x02 */
-	enum MCE_Initiator	initiator:8;	/* 0x03 */
-	enum MCE_ErrorType	error_type:8;	/* 0x04 */
-	enum MCE_Disposition	disposition:8;	/* 0x05 */
-	uint8_t			reserved_1[2];	/* 0x06 */
-	uint64_t		gpr3;		/* 0x08 */
-	uint64_t		srr0;		/* 0x10 */
-	uint64_t		srr1;		/* 0x18 */
-	union {					/* 0x20 */
-		struct {
-			enum MCE_UeErrorType ue_error_type:8;
-			uint8_t		effective_address_provided;
-			uint8_t		physical_address_provided;
-			uint8_t		reserved_1[5];
-			uint64_t	effective_address;
-			uint64_t	physical_address;
-			uint8_t		reserved_2[8];
-		} ue_error;
-
-		struct {
-			enum MCE_SlbErrorType slb_error_type:8;
-			uint8_t		effective_address_provided;
-			uint8_t		reserved_1[6];
-			uint64_t	effective_address;
-			uint8_t		reserved_2[16];
-		} slb_error;
-
-		struct {
-			enum MCE_EratErrorType erat_error_type:8;
-			uint8_t		effective_address_provided;
-			uint8_t		reserved_1[6];
-			uint64_t	effective_address;
-			uint8_t		reserved_2[16];
-		} erat_error;
-
-		struct {
-			enum MCE_TlbErrorType tlb_error_type:8;
-			uint8_t		effective_address_provided;
-			uint8_t		reserved_1[6];
-			uint64_t	effective_address;
-			uint8_t		reserved_2[16];
-		} tlb_error;
-	} u;
-};
-
 struct mce_error_info {
 	enum MCE_ErrorType error_type:8;
 	union {
@@ -189,10 +87,10 @@ struct mce_error_info {
 extern void save_mce_event(struct pt_regs *regs, long handled,
 			   struct mce_error_info *mce_err, uint64_t nip,
 			   uint64_t addr);
-extern int get_mce_event(struct machine_check_event *mce, bool release);
+extern int get_mce_event(struct OpalMachineCheckEvent *mce, bool release);
 extern void release_mce_event(void);
 extern void machine_check_queue_event(void);
-extern void machine_check_print_event_info(struct machine_check_event *evt);
-extern uint64_t get_mce_fault_addr(struct machine_check_event *evt);
+extern void machine_check_print_event_info(struct OpalMachineCheckEvent *evt);
+extern uint64_t get_mce_fault_addr(struct OpalMachineCheckEvent *evt);
 
 #endif /* __ASM_PPC64_MCE_H__ */
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0e2e57b..6851be6 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -585,6 +585,182 @@ struct OpalHMIEvent {
 	} u;
 };
 
+/* Machine Check event */
+enum MCE_Version {
+	MCE_V1 = 1,
+};
+
+enum MCE_Severity {
+	MCE_SEV_NO_ERROR = 0,
+	MCE_SEV_WARNING = 1,
+	MCE_SEV_ERROR_SYNC = 2,
+	MCE_SEV_FATAL = 3,
+	MCE_SEV_ERROR_ASYNC = 4,
+};
+
+enum MCE_Disposition {
+	MCE_DISPOSITION_RECOVERED = 0,
+	MCE_DISPOSITION_NOT_RECOVERED = 1,
+};
+
+enum MCE_Initiator {
+	MCE_INITIATOR_UNKNOWN = 0,
+	MCE_INITIATOR_CPU = 1,
+};
+
+enum MCE_ErrorType {
+	MCE_ERROR_TYPE_UNKNOWN = 0,
+	MCE_ERROR_TYPE_UE = 1,
+	MCE_ERROR_TYPE_SLB = 2,
+	MCE_ERROR_TYPE_ERAT = 3,
+	MCE_ERROR_TYPE_TLB = 4,
+	MCE_ERROR_TYPE_NEST = 5,
+	MCE_ERROR_TYPE_CRESP = 6,
+	MCE_ERROR_TYPE_FSPACE = 7,
+	MCE_ERROR_TYPE_ASYNC = 8,
+};
+
+enum MCE_UeErrorType {
+	MCE_UE_ERROR_INDETERMINATE = 0,
+	MCE_UE_ERROR_IFETCH = 1,
+	MCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH = 2,
+	MCE_UE_ERROR_LOAD_STORE = 3,
+	MCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE = 4,
+};
+
+enum MCE_SlbErrorType {
+	MCE_SLB_ERROR_INDETERMINATE = 0,
+	MCE_SLB_ERROR_PARITY = 1,
+	MCE_SLB_ERROR_MULTIHIT = 2,
+};
+
+enum MCE_EratErrorType {
+	MCE_ERAT_ERROR_INDETERMINATE = 0,
+	MCE_ERAT_ERROR_PARITY = 1,
+	MCE_ERAT_ERROR_MULTIHIT = 2,
+};
+
+enum MCE_TlbErrorType {
+	MCE_TLB_ERROR_INDETERMINATE = 0,
+	MCE_TLB_ERROR_PARITY = 1,
+	MCE_TLB_ERROR_MULTIHIT = 2,
+	MCE_TLB_ERROR_TLBIEL_PROG_ERROR = 3,
+};
+
+enum MCE_NestErrorType {
+	MCE_NEST_ERROR_ABRT_IFETCH = 0,
+	MCE_NEST_ERROR_ABRT_IFETCH_TABLEWALK = 1,
+	MCE_NEST_ERROR_ABRT_LOAD = 2,
+	MCE_NEST_ERROR_ABRT_LOAD_TABLEWALK = 3,
+};
+
+enum MCE_CrespErrorType {
+	MCE_CRESP_ERROR_BAD_RADDR_IFETCH = 0,
+	MCE_CRESP_ERROR_BAD_RADDR_IFETCH_TABLEWALK = 1,
+	MCE_CRESP_ERROR_BAD_RADDR_LOAD = 2,
+	MCE_CRESP_ERROR_BAD_RADDR_LOAD_TABLEWALK = 3,
+};
+
+enum MCE_FspaceErrorType {
+	MCE_FSPACE_ERROR_IFETCH = 0,
+	MCE_FSPACE_ERROR_IFETCH_TABLEWALK = 1,
+	MCE_FSPACE_ERROR_RADDR_TRANSLATION = 2,
+	MCE_FSPACE_ERROR_RADDR_LOAD = 3,
+};
+
+enum MCE_AsyncErrorType {
+	MCE_ASYNC_ERROR_REAL_ADDR_STORE = 0,
+	MCE_ASYNC_ERROR_NEST_ABRT_STORE = 1,
+};
+
+struct OpalMachineCheckEvent {
+	uint8_t			version;	/* 0x00 */
+	uint8_t			in_use;		/* 0x01 */
+	uint8_t			severity;	/* 0x02 */
+	uint8_t			initiator;	/* 0x03 */
+	uint8_t			error_type;	/* 0x04 */
+	uint8_t			disposition;	/* 0x05 */
+	uint8_t			reserved_1[2];	/* 0x06 */
+	uint64_t		gpr3;		/* 0x08 */
+	uint64_t		srr0;		/* 0x10 */
+	uint64_t		srr1;		/* 0x18 */
+
+	union {					/* 0x20 */
+		/* Next 32 bytes contains specific information of MCE error. */
+		struct {
+			/* enum MCE_UeErrorType */
+			uint8_t		ue_error_type;
+			uint8_t		effective_address_provided;
+			uint8_t		physical_address_provided;
+			uint8_t		reserved_1[5];
+			uint64_t	effective_address;
+			uint64_t	physical_address;
+			uint8_t		reserved_2[8];
+		} ue_error;
+
+		struct {
+			/* enum MCE_SlbErrorType */
+			uint8_t		slb_error_type;
+			uint8_t		effective_address_provided;
+			uint8_t		reserved_1[6];
+			uint64_t	effective_address;
+			uint8_t		reserved_2[16];
+		} slb_error;
+
+		struct {
+			/* enum MCE_EratErrorType */
+			uint8_t		erat_error_type;
+			uint8_t		effective_address_provided;
+			uint8_t		reserved_1[6];
+			uint64_t	effective_address;
+			uint8_t		reserved_2[16];
+		} erat_error;
+
+		struct {
+			/* enum MCE_TlbErrorType  */
+			uint8_t		tlb_error_type;
+			uint8_t		effective_address_provided;
+			uint8_t		reserved_1[6];
+			uint64_t	effective_address;
+			uint8_t		reserved_2[16];
+		} tlb_error;
+
+		struct {
+			/* enum MCE_NestErrorType */
+			uint8_t		nest_error_type;
+			uint8_t		effective_address_provided;
+			uint8_t		reserved_1[6];
+			uint64_t	effective_address;
+			uint8_t		reserved_2[16];
+		} nest_error;
+
+		struct {
+			/* enum MCE_CrespErrorType */
+			uint8_t		cresp_error_type;
+			uint8_t		effective_address_provided;
+			uint8_t		reserved_1[6];
+			uint64_t	effective_address;
+			uint8_t		reserved_2[16];
+		} cresp_error;
+
+		struct {
+			/* enum MCE_FspaceErrorType */
+			uint8_t		fspace_error_type;
+			uint8_t		effective_address_provided;
+			uint8_t		reserved_1[6];
+			uint64_t	effective_address;
+			uint8_t		reserved_2[16];
+		} fspace_error;
+
+		struct {
+			/* enum MCE_AsyncErrorType */
+			uint8_t		async_error_type;
+			uint8_t		reserved_1[7];
+			uint8_t		reserved_2[24];
+		} async_error;
+	} u;
+};
+
 enum {
 	OPAL_P7IOC_DIAG_TYPE_NONE	= 0,
 	OPAL_P7IOC_DIAG_TYPE_RGC	= 1,
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index c6923ff..51a7c64 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -30,18 +30,18 @@
 #include <asm/mce.h>
 
 static DEFINE_PER_CPU(int, mce_nest_count);
-static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event);
+static DEFINE_PER_CPU(struct OpalMachineCheckEvent[MAX_MC_EVT], mce_event);
 
 /* Queue for delayed MCE events. */
 static DEFINE_PER_CPU(int, mce_queue_count);
-static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event_queue);
+static DEFINE_PER_CPU(struct OpalMachineCheckEvent[MAX_MC_EVT], mce_event_queue);
 
 static void machine_check_process_queued_event(struct irq_work *work);
 static struct irq_work mce_event_process_work = {
         .func = machine_check_process_queued_event,
 };
 
-static void mce_set_error_info(struct machine_check_event *mce,
+static void mce_set_error_info(struct OpalMachineCheckEvent *mce,
 			       struct mce_error_info *mce_err)
 {
 	mce->error_type = mce_err->error_type;
@@ -73,7 +73,7 @@ void save_mce_event(struct pt_regs *regs, long handled,
 		    uint64_t nip, uint64_t addr)
 {
 	int index = __this_cpu_inc_return(mce_nest_count) - 1;
-	struct machine_check_event *mce = this_cpu_ptr(&mce_event[index]);
+	struct OpalMachineCheckEvent *mce = this_cpu_ptr(&mce_event[index]);
 
 	/*
 	 * Return if we don't have enough space to log mce event.
@@ -139,10 +139,10 @@ void save_mce_event(struct pt_regs *regs, long handled,
  * preemption will not be scheduled until ret_from_expect() routine
  * is called.
  */
-int get_mce_event(struct machine_check_event *mce, bool release)
+int get_mce_event(struct OpalMachineCheckEvent *mce, bool release)
 {
 	int index = __this_cpu_read(mce_nest_count) - 1;
-	struct machine_check_event *mc_evt;
+	struct OpalMachineCheckEvent *mc_evt;
 	int ret = 0;
 
 	/* Sanity check */
@@ -177,7 +177,7 @@ void release_mce_event(void)
 void machine_check_queue_event(void)
 {
 	int index;
-	struct machine_check_event evt;
+	struct OpalMachineCheckEvent evt;
 
 	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))
 		return;
@@ -214,7 +214,7 @@ static void machine_check_process_queued_event(struct irq_work *work)
 	}
 }
 
-void machine_check_print_event_info(struct machine_check_event *evt)
+void machine_check_print_event_info(struct OpalMachineCheckEvent *evt)
 {
 	const char *level, *sevstr, *subtype;
 	static const char *mc_ue_types[] = {
@@ -322,7 +322,7 @@ void machine_check_print_event_info(struct machine_check_event *evt)
 	}
 }
 
-uint64_t get_mce_fault_addr(struct machine_check_event *evt)
+uint64_t get_mce_fault_addr(struct OpalMachineCheckEvent *evt)
 {
 	switch (evt->error_type) {
 	case MCE_ERROR_TYPE_UE:
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2822935..3eb0e94 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -392,7 +392,7 @@ int opal_put_chars(uint32_t vtermno, const char *data, int total_len)
 }
 
 static int opal_recover_mce(struct pt_regs *regs,
-					struct machine_check_event *evt)
+					struct OpalMachineCheckEvent *evt)
 {
 	int recovered = 0;
 	uint64_t ea = get_mce_fault_addr(evt);
@@ -432,7 +432,7 @@ static int opal_recover_mce(struct pt_regs *regs,
 
 int opal_machine_check(struct pt_regs *regs)
 {
-	struct machine_check_event evt;
+	struct OpalMachineCheckEvent evt;
 	int ret;
 
 	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))

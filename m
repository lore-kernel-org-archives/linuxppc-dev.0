Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80DA91A0390
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 03:30:25 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E2E08140187
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 03:30:24 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 02:30:23 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 540BE3578054
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 03:30:18 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOGUAao38928484
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 03:30:18 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOGTjEt025348
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 03:29:45 +1100
Subject: [PATCH] powerpc/powernv: Cleanup unused MCE definitions/declarations.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 24 Nov 2014 21:59:26 +0530
Message-ID: <20141124162829.16359.23411.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Cleanup OpalMCE_* definitions/declarations and other related code which
is not used anymore.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h       |  104 ---------------------------------
 arch/powerpc/include/asm/paca.h       |    7 --
 arch/powerpc/kernel/asm-offsets.c     |    7 --
 arch/powerpc/kernel/exceptions-64s.S  |   17 -----
 arch/powerpc/platforms/powernv/opal.c |    1 
 5 files changed, 136 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9124b0e..1c0814f0 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -284,62 +284,6 @@ enum OpalMessageType {
 	OPAL_MSG_TYPE_MAX,
 };
 
-/* Machine check related definitions */
-enum OpalMCE_Version {
-	OpalMCE_V1 = 1,
-};
-
-enum OpalMCE_Severity {
-	OpalMCE_SEV_NO_ERROR = 0,
-	OpalMCE_SEV_WARNING = 1,
-	OpalMCE_SEV_ERROR_SYNC = 2,
-	OpalMCE_SEV_FATAL = 3,
-};
-
-enum OpalMCE_Disposition {
-	OpalMCE_DISPOSITION_RECOVERED = 0,
-	OpalMCE_DISPOSITION_NOT_RECOVERED = 1,
-};
-
-enum OpalMCE_Initiator {
-	OpalMCE_INITIATOR_UNKNOWN = 0,
-	OpalMCE_INITIATOR_CPU = 1,
-};
-
-enum OpalMCE_ErrorType {
-	OpalMCE_ERROR_TYPE_UNKNOWN = 0,
-	OpalMCE_ERROR_TYPE_UE = 1,
-	OpalMCE_ERROR_TYPE_SLB = 2,
-	OpalMCE_ERROR_TYPE_ERAT = 3,
-	OpalMCE_ERROR_TYPE_TLB = 4,
-};
-
-enum OpalMCE_UeErrorType {
-	OpalMCE_UE_ERROR_INDETERMINATE = 0,
-	OpalMCE_UE_ERROR_IFETCH = 1,
-	OpalMCE_UE_ERROR_PAGE_TABLE_WALK_IFETCH = 2,
-	OpalMCE_UE_ERROR_LOAD_STORE = 3,
-	OpalMCE_UE_ERROR_PAGE_TABLE_WALK_LOAD_STORE = 4,
-};
-
-enum OpalMCE_SlbErrorType {
-	OpalMCE_SLB_ERROR_INDETERMINATE = 0,
-	OpalMCE_SLB_ERROR_PARITY = 1,
-	OpalMCE_SLB_ERROR_MULTIHIT = 2,
-};
-
-enum OpalMCE_EratErrorType {
-	OpalMCE_ERAT_ERROR_INDETERMINATE = 0,
-	OpalMCE_ERAT_ERROR_PARITY = 1,
-	OpalMCE_ERAT_ERROR_MULTIHIT = 2,
-};
-
-enum OpalMCE_TlbErrorType {
-	OpalMCE_TLB_ERROR_INDETERMINATE = 0,
-	OpalMCE_TLB_ERROR_PARITY = 1,
-	OpalMCE_TLB_ERROR_MULTIHIT = 2,
-};
-
 enum OpalThreadStatus {
 	OPAL_THREAD_INACTIVE = 0x0,
 	OPAL_THREAD_STARTED = 0x1,
@@ -452,54 +396,6 @@ struct opal_msg {
 	__be64 params[8];
 };
 
-struct opal_machine_check_event {
-	enum OpalMCE_Version	version:8;	/* 0x00 */
-	uint8_t			in_use;		/* 0x01 */
-	enum OpalMCE_Severity	severity:8;	/* 0x02 */
-	enum OpalMCE_Initiator	initiator:8;	/* 0x03 */
-	enum OpalMCE_ErrorType	error_type:8;	/* 0x04 */
-	enum OpalMCE_Disposition disposition:8; /* 0x05 */
-	uint8_t			reserved_1[2];	/* 0x06 */
-	uint64_t		gpr3;		/* 0x08 */
-	uint64_t		srr0;		/* 0x10 */
-	uint64_t		srr1;		/* 0x18 */
-	union {					/* 0x20 */
-		struct {
-			enum OpalMCE_UeErrorType ue_error_type:8;
-			uint8_t		effective_address_provided;
-			uint8_t		physical_address_provided;
-			uint8_t		reserved_1[5];
-			uint64_t	effective_address;
-			uint64_t	physical_address;
-			uint8_t		reserved_2[8];
-		} ue_error;
-
-		struct {
-			enum OpalMCE_SlbErrorType slb_error_type:8;
-			uint8_t		effective_address_provided;
-			uint8_t		reserved_1[6];
-			uint64_t	effective_address;
-			uint8_t		reserved_2[16];
-		} slb_error;
-
-		struct {
-			enum OpalMCE_EratErrorType erat_error_type:8;
-			uint8_t		effective_address_provided;
-			uint8_t		reserved_1[6];
-			uint64_t	effective_address;
-			uint8_t		reserved_2[16];
-		} erat_error;
-
-		struct {
-			enum OpalMCE_TlbErrorType tlb_error_type:8;
-			uint8_t		effective_address_provided;
-			uint8_t		reserved_1[6];
-			uint64_t	effective_address;
-			uint8_t		reserved_2[16];
-		} tlb_error;
-	} u;
-};
-
 /* FSP memory errors handling */
 enum OpalMemErr_Version {
 	OpalMemErr_V1 = 1,
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index a5139ea..24a386c 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -42,7 +42,6 @@ extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
 #define get_slb_shadow()	(get_paca()->slb_shadow_ptr)
 
 struct task_struct;
-struct opal_machine_check_event;
 
 /*
  * Defines the layout of the paca.
@@ -153,12 +152,6 @@ struct paca_struct {
 	u64 tm_scratch;                 /* TM scratch area for reclaim */
 #endif
 
-#ifdef CONFIG_PPC_POWERNV
-	/* Pointer to OPAL machine check event structure set by the
-	 * early exception handler for use by high level C handler
-	 */
-	struct opal_machine_check_event *opal_mc_evt;
-#endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	/* Exclusive emergency stack pointer for machine check exception. */
 	void *mc_emergency_sp;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9d7dede..c161ef3 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -726,12 +726,5 @@ int main(void)
 					arch.timing_last_enter.tv32.tbl));
 #endif
 
-#ifdef CONFIG_PPC_POWERNV
-	DEFINE(OPAL_MC_GPR3, offsetof(struct opal_machine_check_event, gpr3));
-	DEFINE(OPAL_MC_SRR0, offsetof(struct opal_machine_check_event, srr0));
-	DEFINE(OPAL_MC_SRR1, offsetof(struct opal_machine_check_event, srr1));
-	DEFINE(PACA_OPAL_MC_EVT, offsetof(struct paca_struct, opal_mc_evt));
-#endif
-
 	return 0;
 }
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 72e783e..b7a30bd 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1301,23 +1301,6 @@ hmi_exception_after_realmode:
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	hmi_exception_hv
 
-#ifdef CONFIG_PPC_POWERNV
-_GLOBAL(opal_mc_secondary_handler)
-	HMT_MEDIUM_PPR_DISCARD
-	SET_SCRATCH0(r13)
-	GET_PACA(r13)
-	clrldi	r3,r3,2
-	tovirt(r3,r3)
-	std	r3,PACA_OPAL_MC_EVT(r13)
-	ld	r13,OPAL_MC_SRR0(r3)
-	mtspr	SPRN_SRR0,r13
-	ld	r13,OPAL_MC_SRR1(r3)
-	mtspr	SPRN_SRR1,r13
-	ld	r3,OPAL_MC_GPR3(r3)
-	GET_SCRATCH0(r13)
-	b	machine_check_pSeries
-#endif /* CONFIG_PPC_POWERNV */
-
 
 #define MACHINE_CHECK_HANDLER_WINDUP			\
 	/* Clear MSR_RI before setting SRR0 and SRR1. */\
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index d019b08..544b9b7 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -50,7 +50,6 @@ static int mc_recoverable_range_len;
 
 struct device_node *opal_node;
 static DEFINE_SPINLOCK(opal_write_lock);
-extern u64 opal_mc_secondary_handler[];
 static unsigned int *opal_irqs;
 static unsigned int opal_irq_count;
 static ATOMIC_NOTIFIER_HEAD(opal_notifier_head);

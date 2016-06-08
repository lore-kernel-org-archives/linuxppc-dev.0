Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrmn2krTzDwtF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:44:25 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58Ed2AT136048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 10:44:24 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m3tv3h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 10:44:23 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 08:44:23 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 15/16] powerpc/mm: Switch user slb fault handling to
 translation enabled
Date: Wed,  8 Jun 2016 20:13:22 +0530
In-Reply-To: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465397003-26812-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465397003-26812-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We also handle fault with proper stack initialized. This enable us to
callout to C in fault handling routines. We don't do this for kernel
mapping, because of the possibility of taking recursive fault if kernel
stack in not yet mapped by an slb entry.

This enable us to handle Power9 slb fault better. We will add bolted
entries for the entire kernel mapping in segment table and user slb
entries we take fault and insert on demand. With translation on, we
should be able to access segment table from fault handler.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 55 ++++++++++++++++++++++++++++++++----
 arch/powerpc/mm/slb.c                | 11 ++++++++
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index f2bd375b9a4e..2f2c52559ea9 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -794,7 +794,7 @@ data_access_slb_relon_pSeries:
 	mfspr	r3,SPRN_DAR
 	mfspr	r12,SPRN_SRR1
 #ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
+	b	handle_slb_miss_relon
 #else
 	/*
 	 * We can't just use a direct branch to slb_miss_realmode
@@ -803,7 +803,7 @@ data_access_slb_relon_pSeries:
 	 */
 	mfctr	r11
 	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10, slb_miss_realmode)
+	LOAD_HANDLER(r10, handle_slb_miss_relon)
 	mtctr	r10
 	bctr
 #endif
@@ -819,11 +819,11 @@ instruction_access_slb_relon_pSeries:
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 	mfspr	r12,SPRN_SRR1
 #ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
+	b	handle_slb_miss_relon
 #else
 	mfctr	r11
 	ld	r10,PACAKBASE(r13)
-	LOAD_HANDLER(r10, slb_miss_realmode)
+	LOAD_HANDLER(r10, handle_slb_miss_relon)
 	mtctr	r10
 	bctr
 #endif
@@ -961,7 +961,23 @@ h_data_storage_common:
 	bl      unknown_exception
 	b       ret_from_except
 
+/* r3 point to DAR */
 	.align	7
+	.globl slb_miss_user
+slb_miss_user:
+	std	r3,PACA_EXSLB+EX_DAR(r13)
+	/* Restore r3 as expected by PROLOG_COMMON below */
+	ld	r3,PACA_EXSLB+EX_R3(r13)
+	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXSLB)
+	RECONCILE_IRQ_STATE(r10, r11)
+	ld	r4,PACA_EXSLB+EX_DAR(r13)
+	li	r5,0x380
+	std	r4,_DAR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	handle_slb_miss
+	b       ret_from_except_lite
+
+        .align	7
 	.globl instruction_access_common
 instruction_access_common:
 	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
@@ -1379,11 +1395,17 @@ unrecover_mce:
  * We assume we aren't going to take any exceptions during this procedure.
  */
 slb_miss_realmode:
-	mflr	r10
 #ifdef CONFIG_RELOCATABLE
 	mtctr	r11
 #endif
+	/*
+	 * Handle user slb miss with translation enabled
+	 */
+	cmpdi	r3,0
+	bge	3f
 
+slb_miss_kernel:
+	mflr	r10
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
 
@@ -1428,6 +1450,29 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 	mtspr	SPRN_SRR1,r10
 	rfid
 	b	.
+3:
+	/*
+	 * Enable IR/DR and handle the fault
+	 */
+	EXCEPTION_PROLOG_PSERIES_1(slb_miss_user, EXC_STD)
+	/*
+	 * handler with relocation on
+	 */
+handle_slb_miss_relon:
+#ifdef CONFIG_RELOCATABLE
+	mtctr	r11
+#endif
+	/*
+	 * Handle user slb miss with stack initialized.
+	 */
+	cmpdi	r3,0
+	bge	4f
+	/*
+	 * go back to slb_miss_realmode
+	 */
+	b	slb_miss_kernel
+4:
+	EXCEPTION_RELON_PROLOG_PSERIES_1(slb_miss_user, EXC_STD)
 
 unrecov_slb:
 	EXCEPTION_PROLOG_COMMON(0x4100, PACA_EXSLB)
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 48fc28bab544..b18d7df5601d 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -25,6 +25,8 @@
 #include <asm/udbg.h>
 #include <asm/code-patching.h>
 
+#include <linux/context_tracking.h>
+
 enum slb_index {
 	LINEAR_INDEX	= 0, /* Kernel linear map  (0xc000000000000000) */
 	VMALLOC_INDEX	= 1, /* Kernel virtual map (0xd000000000000000) */
@@ -346,3 +348,12 @@ void slb_initialize(void)
 
 	asm volatile("isync":::"memory");
 }
+
+void handle_slb_miss(struct pt_regs *regs,
+		     unsigned long address, unsigned long trap)
+{
+	enum ctx_state prev_state = exception_enter();
+
+	slb_allocate(address);
+	exception_exit(prev_state);
+}
-- 
2.7.4

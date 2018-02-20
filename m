Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlhCt0YT3zDrF6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 11:23:05 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1K0JTjs001719
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:04 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g84k90ntv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:03 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 20 Feb 2018 00:23:02 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 07/12] [WIP] powerpc/tm: Add TM_KERNEL_ENTRY in more
 delicate exception pathes
Date: Tue, 20 Feb 2018 11:22:36 +1100
In-Reply-To: <20180220002241.29648-1-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
Message-Id: <20180220002241.29648-8-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/kernel/entry_64.S       | 15 ++++++++++++++-
 arch/powerpc/kernel/exceptions-64s.S | 31 ++++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 107c15c6f48b..32e8d8f7e091 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -967,7 +967,20 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	bl	__check_irq_replay
 	cmpwi	cr0,r3,0
 	beq	.Lrestore_no_replay
- 
+
+	/*
+	 * We decide VERY late if we need to replay interrupts, theres
+	 * not much which can be done about that so this will have to
+	 * do
+	 */
+	TM_KERNEL_ENTRY
+	/*
+	 * This will restore r3 that TM_KERNEL_ENTRY clobbered.
+	 * Clearly not ideal! I wonder if we could change the trap
+	 * value beforehand...
+	 */
+	bl	__check_irq_replay
+
 	/*
 	 * We need to re-emit an interrupt. We do so by re-using our
 	 * existing exception frame. We first change the trap value,
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3ac87e53b3da..c8899bf77fb0 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -504,6 +504,11 @@ EXC_COMMON_BEGIN(data_access_common)
 	li	r5,0x300
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
+	/*
+	 * Can't do TM_KERNEL_ENTRY here as do_hash_page might jump to
+	 * very late in the expection exit code, well after any
+	 * possiblity of doing a recheckpoint
+	 */
 BEGIN_MMU_FTR_SECTION
 	b	do_hash_page		/* Try to handle as hpte fault */
 MMU_FTR_SECTION_ELSE
@@ -548,6 +553,11 @@ EXC_COMMON_BEGIN(instruction_access_common)
 	li	r5,0x400
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
+	/*
+	 * Can't do TM_KERNEL_ENTRY here as do_hash_page might jump to
+	 * very late in the expection exit code, well after any
+	 * possiblity of doing a recheckpoint
+	 */
 BEGIN_MMU_FTR_SECTION
 	b	do_hash_page		/* Try to handle as hpte fault */
 MMU_FTR_SECTION_ELSE
@@ -761,6 +771,7 @@ EXC_COMMON_BEGIN(alignment_common)
 	std	r4,_DSISR(r1)
 	bl	save_nvgprs
 	RECONCILE_IRQ_STATE(r10, r11)
+	TM_KERNEL_ENTRY
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	alignment_exception
 	b	ret_from_except
@@ -1668,7 +1679,9 @@ do_hash_page:
 
 /* Here we have a page fault that hash_page can't handle. */
 handle_page_fault:
-11:	andis.  r0,r4,DSISR_DABRMATCH@h
+11:	TM_KERNEL_ENTRY
+	ld      r4,_DSISR(r1)
+	andis.  r0,r4,DSISR_DABRMATCH@h
 	bne-    handle_dabr_fault
 	ld	r4,_DAR(r1)
 	ld	r5,_DSISR(r1)
@@ -1685,6 +1698,10 @@ handle_page_fault:
 
 /* We have a data breakpoint exception - handle it */
 handle_dabr_fault:
+	/*
+	 * Don't need to do TM_KERNEL_ENTRY here as we'll
+	 * come from handle_page_fault: which has done it already
+	 */
 	bl	save_nvgprs
 	ld      r4,_DAR(r1)
 	ld      r5,_DSISR(r1)
@@ -1698,7 +1715,14 @@ handle_dabr_fault:
  * the PTE insertion
  */
 13:	bl	save_nvgprs
-	mr	r5,r3
+	/*
+	 * Use a non-volatile as the TM code will call, r3 is the
+	 * return value from __hash_page() so not exactly easy to get
+	 * again.
+	 */
+	mr	r31,r3
+	TM_KERNEL_ENTRY
+	mr	r5, r31
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ld	r4,_DAR(r1)
 	bl	low_hash_fault
@@ -1713,7 +1737,8 @@ handle_dabr_fault:
  * the access, or panic if there isn't a handler.
  */
 77:	bl	save_nvgprs
-	mr	r4,r3
+	TM_KERNEL_ENTRY
+	ld	r4,_DAR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r5,SIGSEGV
 	bl	bad_page_fault
-- 
2.16.2

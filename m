Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ws0L43VqZzDqMP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 04:46:04 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5JIi5SS138836
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 14:46:02 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b6cs6ytbv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 14:46:01 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 04:45:59 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5JIjtHj2163034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 04:45:55 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5JIjsGB026218
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 04:45:55 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc64/exceptions: Refactor code to eliminate a few
 memory loads
Date: Tue, 20 Jun 2017 00:15:45 +0530
In-Reply-To: <8760fsb902.fsf@skywalker.in.ibm.com>
References: <8760fsb902.fsf@skywalker.in.ibm.com>
Message-Id: <20170619184545.28848-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/19 03:21PM, Aneesh Kumar K.V wrote:
> > @@ -1445,8 +1446,8 @@ do_hash_page:
> >  handle_page_fault:
> >  	andis.  r0,r4,DSISR_DABRMATCH@h
> >  	bne-    handle_dabr_fault
> > -	ld	r4,_DAR(r1)
> > -	ld	r5,_DSISR(r1)
> > +	mr	r5,r4
> > +	mr	r4,r3
> >  	addi	r3,r1,STACK_FRAME_OVERHEAD
> >  	bl	do_page_fault
> >  	cmpdi	r3,0
> 
> 
> Can we avoid that if we rearrange args of other functions calls, so that
> we can use r3 and r4 as it is ?

Here's a version that does that. Again, boot tested with radix and 
disable_radix.

Thanks,
Naveen

-
Change data_access_common() and instruction_access_common() to load the
trap number in r3, DAR in r4 and DSISR in r5 (rather than in r5, r3 and
r4 respectively). This change allows us to eliminate a few un-necessary
memory loads and register move operations in handle_page_fault(),
handle_dabr_fault() and label '77'.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 38 +++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b6fad9790784..4c5abe1d6f44 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -494,11 +494,11 @@ EXC_COMMON_BEGIN(data_access_common)
 	EXCEPTION_PROLOG_COMMON(0x300, PACA_EXGEN)
 	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r12,_MSR(r1)
-	ld	r3,PACA_EXGEN+EX_DAR(r13)
-	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
-	li	r5,0x300
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
+	ld	r4,PACA_EXGEN+EX_DAR(r13)
+	lwz	r5,PACA_EXGEN+EX_DSISR(r13)
+	li	r3,0x300
+	std	r4,_DAR(r1)
+	std	r5,_DSISR(r1)
 BEGIN_MMU_FTR_SECTION
 	b	do_hash_page		/* Try to handle as hpte fault */
 MMU_FTR_SECTION_ELSE
@@ -562,11 +562,11 @@ EXC_COMMON_BEGIN(instruction_access_common)
 	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
 	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r12,_MSR(r1)
-	ld	r3,_NIP(r1)
-	andis.	r4,r12,0x5820
-	li	r5,0x400
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
+	ld	r4,_NIP(r1)
+	andis.	r5,r12,0x5820
+	li	r3,0x400
+	std	r4,_DAR(r1)
+	std	r5,_DSISR(r1)
 BEGIN_MMU_FTR_SECTION
 	b	do_hash_page		/* Try to handle as hpte fault */
 MMU_FTR_SECTION_ELSE
@@ -1474,7 +1474,7 @@ USE_TEXT_SECTION()
 	.balign	IFETCH_ALIGN_BYTES
 do_hash_page:
 #ifdef CONFIG_PPC_STD_MMU_64
-	andis.	r0,r4,0xa450		/* weird error? */
+	andis.	r0,r5,0xa450		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
 	CURRENT_THREAD_INFO(r11, r1)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
@@ -1489,8 +1489,10 @@ do_hash_page:
 	 *
 	 * at return r3 = 0 for success, 1 for page fault, negative for error
 	 */
+	mr	r6,r5
+	mr	r5,r3
+	mr	r3,r4
         mr 	r4,r12
-	ld      r6,_DSISR(r1)
 	bl	__hash_page		/* build HPTE if possible */
         cmpdi	r3,0			/* see if __hash_page succeeded */
 
@@ -1500,16 +1502,15 @@ do_hash_page:
 	/* Error */
 	blt-	13f
 
-	/* Reload DSISR into r4 for the DABR check below */
-	ld      r4,_DSISR(r1)
+	/* Reload DAR/DSISR for handle_page_fault */
+	ld	r4,_DAR(r1)
+	ld      r5,_DSISR(r1)
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
 /* Here we have a page fault that hash_page can't handle. */
 handle_page_fault:
-	andis.  r0,r4,DSISR_DABRMATCH@h
+	andis.  r0,r5,DSISR_DABRMATCH@h
 	bne-    handle_dabr_fault
-	ld	r4,_DAR(r1)
-	ld	r5,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_page_fault
 	cmpdi	r3,0
@@ -1524,8 +1525,6 @@ handle_page_fault:
 /* We have a data breakpoint exception - handle it */
 handle_dabr_fault:
 	bl	save_nvgprs
-	ld      r4,_DAR(r1)
-	ld      r5,_DSISR(r1)
 	addi    r3,r1,STACK_FRAME_OVERHEAD
 	bl      do_break
 12:	b       ret_from_except_lite
@@ -1551,7 +1550,6 @@ handle_dabr_fault:
  * the access, or panic if there isn't a handler.
  */
 77:	bl	save_nvgprs
-	mr	r4,r3
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r5,SIGSEGV
 	bl	bad_page_fault
-- 
2.13.1

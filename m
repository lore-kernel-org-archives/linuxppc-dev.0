Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybH7b4Y3qzDqh9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 04:04:58 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vADGxhG2064568
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 12:04:56 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e7c2n5dg4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 12:04:55 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 13 Nov 2017 17:04:54 -0000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc64/exceptions: Refactor code to eliminate a few
 memory loads
Date: Mon, 13 Nov 2017 22:34:45 +0530
In-Reply-To: <874lq2px9c.fsf@concordia.ellerman.id.au>
References: <874lq2px9c.fsf@concordia.ellerman.id.au>
Message-Id: <20171113170445.1404-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
>> On 2017/06/19 03:21PM, Aneesh Kumar K.V wrote:
>>> > @@ -1445,8 +1446,8 @@ do_hash_page:
>>> >  handle_page_fault:
>>> >  	andis.  r0,r4,DSISR_DABRMATCH@h
>>> >  	bne-    handle_dabr_fault
>>> > -	ld	r4,_DAR(r1)
>>> > -	ld	r5,_DSISR(r1)
>>> > +	mr	r5,r4
>>> > +	mr	r4,r3
>>> >  	addi	r3,r1,STACK_FRAME_OVERHEAD
>>> >  	bl	do_page_fault
>>> >  	cmpdi	r3,0
>>> 
>>> 
>>> Can we avoid that if we rearrange args of other functions calls, so that
>>> we can use r3 and r4 as it is ?
>>
>> Here's a version that does that. Again, boot tested with radix and 
>> disable_radix.
>>
>> Thanks,
>> Naveen
>>
>> -
>> Change data_access_common() and instruction_access_common() to load the
>> trap number in r3, DAR in r4 and DSISR in r5 (rather than in r5, r3 and
>> r4 respectively). This change allows us to eliminate a few un-necessary
>> memory loads and register move operations in handle_page_fault(),
>> handle_dabr_fault() and label '77'.
>>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/exceptions-64s.S | 38 +++++++++++++++++-------------------
>>  1 file changed, 18 insertions(+), 20 deletions(-)
> 
> Sorry I missed this and now it doesn't apply. Do you mind rebasing.

No problem - this is just a small refactoring after all :).
Here's a rebased version.  Boot tested on mambo with/without radix.

Thanks,
Naveen

--
[PATCH v3] powerpc/exceptions64s: Eliminate a few un-necessary memory  
loads

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
index 72cffa0c4af6..b8166b4fa728 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -499,11 +499,11 @@ EXC_COMMON_BEGIN(data_access_common)
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
@@ -543,11 +543,11 @@ EXC_COMMON_BEGIN(instruction_access_common)
 	EXCEPTION_PROLOG_COMMON(0x400, PACA_EXGEN)
 	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r12,_MSR(r1)
-	ld	r3,_NIP(r1)
-	andis.	r4,r12,DSISR_BAD_FAULT_64S@h
-	li	r5,0x400
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
+	ld	r4,_NIP(r1)
+	andis.	r5,r12,DSISR_BAD_FAULT_64S@h
+	li	r3,0x400
+	std	r4,_DAR(r1)
+	std	r5,_DSISR(r1)
 BEGIN_MMU_FTR_SECTION
 	b	do_hash_page		/* Try to handle as hpte fault */
 MMU_FTR_SECTION_ELSE
@@ -1523,7 +1523,7 @@ do_hash_page:
 #ifdef CONFIG_PPC_BOOK3S_64
 	lis	r0,DSISR_BAD_FAULT_64S@h
 	ori	r0,r0,DSISR_BAD_FAULT_64S@l
-	and.	r0,r4,r0		/* weird error? */
+	and.	r0,r5,r0		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
 	CURRENT_THREAD_INFO(r11, r1)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
@@ -1538,8 +1538,10 @@ do_hash_page:
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
 
@@ -1549,16 +1551,15 @@ do_hash_page:
 	/* Error */
 	blt-	13f
 
-	/* Reload DSISR into r4 for the DABR check below */
-	ld      r4,_DSISR(r1)
+	/* Reload DAR/DSISR for handle_page_fault */
+	ld	r4,_DAR(r1)
+	ld      r5,_DSISR(r1)
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 /* Here we have a page fault that hash_page can't handle. */
 handle_page_fault:
-11:	andis.  r0,r4,DSISR_DABRMATCH@h
+	andis.  r0,r5,DSISR_DABRMATCH@h
 	bne-    handle_dabr_fault
-	ld	r4,_DAR(r1)
-	ld	r5,_DSISR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_page_fault
 	cmpdi	r3,0
@@ -1573,8 +1574,6 @@ handle_page_fault:
 /* We have a data breakpoint exception - handle it */
 handle_dabr_fault:
 	bl	save_nvgprs
-	ld      r4,_DAR(r1)
-	ld      r5,_DSISR(r1)
 	addi    r3,r1,STACK_FRAME_OVERHEAD
 	bl      do_break
 12:	b       ret_from_except_lite
@@ -1600,7 +1599,6 @@ handle_dabr_fault:
  * the access, or panic if there isn't a handler.
  */
 77:	bl	save_nvgprs
-	mr	r4,r3
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r5,SIGSEGV
 	bl	bad_page_fault
-- 
2.15.0

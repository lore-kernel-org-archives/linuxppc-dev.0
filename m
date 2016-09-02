Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQctl6X9WzDrns
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2016 21:52:31 +1000 (AEST)
Date: Fri, 2 Sep 2016 21:49:21 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc/mm: Preserve CFAR value on SLB miss caused by
 access to bogus address
Message-ID: <20160902114921.GB12433@fergus.ozlabs.ibm.com>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, if userspace or the kernel accesses a completely bogus address,
for example with any of bits 46-59 set, we first take an SLB miss interrupt,
install a corresponding SLB entry with VSID 0, retry the instruction, then
take a DSI/ISI interrupt because there is no HPT entry mapping the address.
However, by the time of the second interrupt, the Come-From Address Register
(CFAR) has been overwritten by the rfid instruction at the end of the SLB
miss interrupt handler.  Since bogus accesses can often be caused by a
function return after the stack has been overwritten, the CFAR value would
be very useful as it could indicate which function it was whose return had
led to the bogus address.

This patch adds code to create a full exception frame in the SLB miss handler
in the case of a bogus address, rather than inserting an SLB entry with a
zero VSID field.  Then we call a new slb_miss_bad_addr() function in C code,
which delivers a signal for a user access or creates an oops for a kernel
access.  In the latter case the oops message will show the CFAR value at the
time of the access.

In the case of the radix MMU, a segment miss interrupt indicates an access
outside the ranges mapped by the page tables.  Previously this was handled
by the code for an unrecoverable SLB miss (one with MSR[RI] = 0), which is
not really correct.  With this patch, we now handle these interrupts with
slb_miss_bad_addr(), which is much more consistent.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kernel/exceptions-64s.S | 40 ++++++++++++++++++++++++++++++------
 arch/powerpc/kernel/traps.c          | 11 ++++++++++
 arch/powerpc/mm/slb_low.S            |  8 +++-----
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index df6d45e..a2526b0 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -175,6 +175,7 @@ data_access_slb_pSeries:
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
 	mfspr	r12,SPRN_SRR1
+	crset	4*cr6+eq
 #ifndef CONFIG_RELOCATABLE
 	b	slb_miss_realmode
 #else
@@ -201,6 +202,7 @@ instruction_access_slb_pSeries:
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 	mfspr	r12,SPRN_SRR1
+	crclr	4*cr6+eq
 #ifndef CONFIG_RELOCATABLE
 	b	slb_miss_realmode
 #else
@@ -767,6 +769,7 @@ data_access_slb_relon_pSeries:
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
 	mfspr	r12,SPRN_SRR1
+	crset	4*cr6+eq
 #ifndef CONFIG_RELOCATABLE
 	b	slb_miss_realmode
 #else
@@ -792,6 +795,7 @@ instruction_access_slb_relon_pSeries:
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 	mfspr	r12,SPRN_SRR1
+	crclr	4*cr6+eq
 #ifndef CONFIG_RELOCATABLE
 	b	slb_miss_realmode
 #else
@@ -1389,6 +1393,7 @@ unrecover_mce:
  * r3 has the faulting address
  * r9 - r13 are saved in paca->exslb.
  * r3 is saved in paca->slb_r3
+ * cr6.eq is set for a D-SLB miss, clear for a I-SLB miss
  * We assume we aren't going to take any exceptions during this procedure.
  */
 slb_miss_realmode:
@@ -1399,29 +1404,31 @@ slb_miss_realmode:
 
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
+	std	r3,PACA_EXSLB+EX_DAR(r13)
 
+	crset	4*cr0+eq
 #ifdef CONFIG_PPC_STD_MMU_64
 BEGIN_MMU_FTR_SECTION
 	bl	slb_allocate_realmode
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 #endif
-	/* All done -- return from exception. */
 
 	ld	r10,PACA_EXSLB+EX_LR(r13)
 	ld	r3,PACA_EXSLB+EX_R3(r13)
 	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
-
 	mtlr	r10
+
+	beq	8f		/* if bad address, make full stack frame */
+
 	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
-BEGIN_MMU_FTR_SECTION
 	beq-	2f
-FTR_SECTION_ELSE
-	b	2f
-ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
+
+	/* All done -- return from exception. */
 
 .machine	push
 .machine	"power4"
 	mtcrf	0x80,r9
+	mtcrf	0x02,r9		/* I/D indication is in cr6 */
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
 .machine	pop
 
@@ -1451,6 +1458,27 @@ unrecov_slb:
 	bl	unrecoverable_exception
 	b	1b
 
+8:	mfspr	r11,SPRN_SRR0
+	ld	r10,PACAKBASE(r13)
+	LOAD_HANDLER(r10,bad_addr_slb)
+	mtspr	SPRN_SRR0,r10
+	ld	r10,PACAKMSR(r13)
+	mtspr	SPRN_SRR1,r10
+	rfid
+	b	.
+
+bad_addr_slb:
+	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXSLB)
+	RECONCILE_IRQ_STATE(r10, r11)
+	ld	r3, PACA_EXSLB+EX_DAR(r13)
+	std	r3, _DAR(r1)
+	beq	cr6, 2f
+	li	r10, 0x480		/* fix trap number for I-SLB miss */
+	std	r10, _TRAP(r1)
+2:	bl	save_nvgprs
+	addi	r3, r1, STACK_FRAME_OVERHEAD
+	bl	slb_miss_bad_addr
+	b	ret_from_except
 
 #ifdef CONFIG_PPC_970_NAP
 power4_fixup_nap:
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2cb5892..a80478b 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1309,6 +1309,17 @@ bail:
 	exception_exit(prev_state);
 }
 
+void slb_miss_bad_addr(struct pt_regs *regs)
+{
+	enum ctx_state prev_state = exception_enter();
+
+	if (user_mode(regs))
+		_exception(SIGSEGV, regs, SEGV_BNDERR, regs->dar);
+	else
+		bad_page_fault(regs, regs->dar, SIGSEGV);
+	exception_exit(prev_state);
+}
+
 void StackOverflow(struct pt_regs *regs)
 {
 	printk(KERN_CRIT "Kernel stack overflow in process %p, r1=%lx\n",
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 9f19834..e2974fc 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -178,11 +178,9 @@ BEGIN_FTR_SECTION
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	b	slb_finish_load
 
-8:	/* invalid EA */
-	li	r10,0			/* BAD_VSID */
-	li	r9,0			/* BAD_VSID */
-	li	r11,SLB_VSID_USER	/* flags don't much matter */
-	b	slb_finish_load
+8:	/* invalid EA - return an error indication */
+	crset	4*cr0+eq		/* indicate failure */
+	blr
 
 /*
  * Finish loading of an SLB entry and return
-- 
2.7.4

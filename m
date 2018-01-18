Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMlLC2sCKzF0lJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 00:34:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org
Cc: greg@kroah.com,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v4.14 backport 06/10] powerpc/64s: Convert slb_miss_common to
 use RFI_TO_USER/KERNEL
Date: Fri, 19 Jan 2018 00:34:06 +1100
Message-Id: <20180118133410.18716-6-mpe@ellerman.id.au>
In-Reply-To: <20180118133410.18716-1-mpe@ellerman.id.au>
References: <20180118133410.18716-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

commit c7305645eb0c1621351cfc104038831ae87c0053 upstream.

In the SLB miss handler we may be returning to user or kernel. We need
to add a check early on and save the result in the cr4 register, and
then we bifurcate the return path based on that.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 85795d41f6ca..845291357f0b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -596,6 +596,9 @@ EXC_COMMON_BEGIN(slb_miss_common)
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
 
+	andi.	r9,r11,MSR_PR	// Check for exception from userspace
+	cmpdi	cr4,r9,MSR_PR	// And save the result in CR4 for later
+
 	/*
 	 * Test MSR_RI before calling slb_allocate_realmode, because the
 	 * MSR in r11 gets clobbered. However we still want to allocate
@@ -622,9 +625,32 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 
 	/* All done -- return from exception. */
 
+	bne	cr4,1f		/* returning to kernel */
+
+.machine	push
+.machine	"power4"
+	mtcrf	0x80,r9
+	mtcrf	0x08,r9		/* MSR[PR] indication is in cr4 */
+	mtcrf	0x04,r9		/* MSR[RI] indication is in cr5 */
+	mtcrf	0x02,r9		/* I/D indication is in cr6 */
+	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
+.machine	pop
+
+	RESTORE_CTR(r9, PACA_EXSLB)
+	RESTORE_PPR_PACA(PACA_EXSLB, r9)
+	mr	r3,r12
+	ld	r9,PACA_EXSLB+EX_R9(r13)
+	ld	r10,PACA_EXSLB+EX_R10(r13)
+	ld	r11,PACA_EXSLB+EX_R11(r13)
+	ld	r12,PACA_EXSLB+EX_R12(r13)
+	ld	r13,PACA_EXSLB+EX_R13(r13)
+	RFI_TO_USER
+	b	.	/* prevent speculative execution */
+1:
 .machine	push
 .machine	"power4"
 	mtcrf	0x80,r9
+	mtcrf	0x08,r9		/* MSR[PR] indication is in cr4 */
 	mtcrf	0x04,r9		/* MSR[RI] indication is in cr5 */
 	mtcrf	0x02,r9		/* I/D indication is in cr6 */
 	mtcrf	0x01,r9		/* slb_allocate uses cr0 and cr7 */
@@ -638,9 +664,10 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 	ld	r11,PACA_EXSLB+EX_R11(r13)
 	ld	r12,PACA_EXSLB+EX_R12(r13)
 	ld	r13,PACA_EXSLB+EX_R13(r13)
-	rfid
+	RFI_TO_KERNEL
 	b	.	/* prevent speculative execution */
 
+
 2:	std     r3,PACA_EXSLB+EX_DAR(r13)
 	mr	r3,r12
 	mfspr	r11,SPRN_SRR0
-- 
2.14.3

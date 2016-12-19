Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8c66lLCzDwKh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:30:30 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id p66so19205173pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 10:30:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 02/10] powerpc/64s: exception macro for stack frame and
 initial register save
Date: Tue, 20 Dec 2016 04:30:03 +1000
Message-Id: <20161219183011.28310-3-npiggin@gmail.com>
In-Reply-To: <20161219183011.28310-1-npiggin@gmail.com>
References: <20161219183011.28310-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This code is common to a few exceptions, and another user will be added.
This causes a trivial change to generated code:

-     604: std     r9,416(r1)
-     608: mfspr   r11,314
-     60c: std     r11,368(r1)
-     610: mfspr   r12,315
+     604: mfspr   r11,314
+     608: mfspr   r12,315
+     60c: std     r9,416(r1)
+     610: std     r11,368(r1)

machine_check_powernv_early could also use this, but that requires non
trivial changes to generated code, so that's for another patch.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 16 ++++++++++------
 arch/powerpc/kernel/exceptions-64s.S     | 13 ++++---------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index b261fb4658b4..1e985382a73a 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -297,6 +297,15 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define NOTEST(n)
 
+#define EXCEPTION_PROLOG_COMMON_1()					   \
+	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
+	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
+	std	r12,_MSR(r1);		/* save SRR1 in stackframe	*/ \
+	std	r10,0(r1);		/* make stack chain pointer	*/ \
+	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
+	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
+
+
 /*
  * The common exception prolog is used for all except a few exceptions
  * such as a segment miss on a kernel address.  We have to be prepared
@@ -321,12 +330,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	addi	r3,r13,area;		/* r3 -> where regs are saved*/	   \
 	RESTORE_CTR(r1, area);						   \
 	b	bad_stack;						   \
-3:	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
-	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
-	std	r12,_MSR(r1);		/* save SRR1 in stackframe	*/ \
-	std	r10,0(r1);		/* make stack chain pointer	*/ \
-	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
-	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
+3:	EXCEPTION_PROLOG_COMMON_1();					   \
 	beq	4f;			/* if from kernel mode		*/ \
 	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
 	SAVE_PPR(area, r9, r10);					   \
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ceff7d6c0518..4573853dfff7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -956,17 +956,12 @@ EXC_VIRT_NONE(0x4e60, 0x4e80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 TRAMP_REAL_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
-	mr	r10,r1			/* Save r1			*/
-	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack		*/
+	mr	r10,r1			/* Save r1 */
+	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack for realmode */
 	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
-	std	r9,_CCR(r1)		/* save CR in stackframe	*/
 	mfspr	r11,SPRN_HSRR0		/* Save HSRR0 */
-	std	r11,_NIP(r1)		/* save HSRR0 in stackframe	*/
-	mfspr	r12,SPRN_HSRR1		/* Save SRR1 */
-	std	r12,_MSR(r1)		/* save SRR1 in stackframe	*/
-	std	r10,0(r1)		/* make stack chain pointer	*/
-	std	r0,GPR0(r1)		/* save r0 in stackframe	*/
-	std	r10,GPR1(r1)		/* save r1 in stackframe	*/
+	mfspr	r12,SPRN_HSRR1		/* Save HSRR1 */
+	EXCEPTION_PROLOG_COMMON_1()
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
 	EXCEPTION_PROLOG_COMMON_3(0xe60)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-- 
2.11.0

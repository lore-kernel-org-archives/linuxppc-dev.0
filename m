Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6Y364bGyzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 15:04:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com,
	mahesh@linux.vnet.ibm.com
Subject: [PATCH] powerpc/64: Fix HMI exception on LE with CONFIG_RELOCATABLE=y
Date: Tue, 18 Apr 2017 15:04:46 +1000
Message-Id: <1492491886-29233-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Prior to commit 2337d207288f ("powerpc/64: CONFIG_RELOCATABLE support for hmi
interrupts"), the branch from hmi_exception_early() to hmi_exception_realmode()
was just a bl hmi_exception_realmode, which the linker would turn into a bl to
the local entry point of hmi_exception_realmode. This was broken when
CONFIG_RELOCATABLE=y because hmi_exception_realmode() is not in the low part of
the kernel text that is copied down to 0x0.

But in fixing that, we added a new bug on little endian kernels. Because the
branch is now a bctrl when CONFIG_RELOCATABLE=y, we branch to the global entry
point of hmi_exception_realmode(). The global entry point must be called with
r12 containing the address of hmi_exception_realmode(), because it uses that
value to calculate the TOC value (r2).

This may manifest as a checkstop, because we take a junk value from r12 which
came from HSRR1, add a small constant to it and then use that as the TOC
pointer. The HSRR1 value will have 0x9 as the top nibble, which puts it above
RAM and somewhere in MMIO space.

Fix it by changing the BRANCH_LINK_TO_FAR() macro to always use r12 to load the
label we're branching to. This means r12 will be setup correctly on LE, fixing
this bug, and r12 is also volatile across function calls on BE so it's a good
choice anyway.

Fixes: 2337d207288f ("powerpc/64: CONFIG_RELOCATABLE support for hmi interrupts")
Reported-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h | 8 ++++----
 arch/powerpc/kernel/exceptions-64s.S     | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 14752eee3d0c..ed3beadd2cc5 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -236,9 +236,9 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mtctr	reg;							\
 	bctr
 
-#define BRANCH_LINK_TO_FAR(reg, label)					\
-	__LOAD_FAR_HANDLER(reg, label);					\
-	mtctr	reg;							\
+#define BRANCH_LINK_TO_FAR(label)					\
+	__LOAD_FAR_HANDLER(r12, label);					\
+	mtctr	r12;							\
 	bctrl
 
 /*
@@ -265,7 +265,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define BRANCH_TO_COMMON(reg, label)					\
 	b	label
 
-#define BRANCH_LINK_TO_FAR(reg, label)					\
+#define BRANCH_LINK_TO_FAR(label)					\
 	bl	label
 
 #define BRANCH_TO_KVM(reg, label)					\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 857bf7c5b946..6353019966e6 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -982,7 +982,7 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
 	EXCEPTION_PROLOG_COMMON_3(0xe60)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	BRANCH_LINK_TO_FAR(r4, hmi_exception_realmode)
+	BRANCH_LINK_TO_FAR(hmi_exception_realmode) /* Function call ABI */
 	/* Windup the stack. */
 	/* Move original HSRR0 and HSRR1 into the respective regs */
 	ld	r9,_MSR(r1)
-- 
2.7.4

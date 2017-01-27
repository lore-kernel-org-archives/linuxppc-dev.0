Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8m0K4s0ZzDq96
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 15:24:49 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id e4so17688804pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 20:24:49 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH] powerpc/64: CONFIG_RELOCATABLE support for hmi interrupts
Date: Fri, 27 Jan 2017 14:24:33 +1000
Message-Id: <20170127042433.14259-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The branch from hmi_exception_early to hmi_exception_realmode must use
a "relocatable-style" branch, because it is branching from unrelocated
exception code to beyond __end_interrupts.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This applies after the KVM RELOCATABLE series, and was split out 
from patch 3.

 arch/powerpc/include/asm/exception-64s.h | 8 ++++++++
 arch/powerpc/kernel/exceptions-64s.S     | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 9a5dbfb2d9f2..6868b8739791 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -236,6 +236,11 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mtctr	reg;							\
 	bctr
 
+#define BRANCH_LINK_TO_FAR(reg, label)					\
+	__LOAD_FAR_HANDLER(reg, label);					\
+	mtctr	reg;							\
+	bctrl
+
 /*
  * KVM requires __LOAD_FAR_HANDLER.
  *
@@ -260,6 +265,9 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define BRANCH_TO_COMMON(reg, label)					\
 	b	label
 
+#define BRANCH_LINK_TO_FAR(reg, label)					\
+	bl	label
+
 #define BRANCH_TO_KVM(reg, label)					\
 	b	label
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 65a2559eeb7f..ee489b6ce5f9 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -977,7 +977,7 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
 	EXCEPTION_PROLOG_COMMON_3(0xe60)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	hmi_exception_realmode
+	BRANCH_LINK_TO_FAR(r4, hmi_exception_realmode)
 	/* Windup the stack. */
 	/* Move original HSRR0 and HSRR1 into the respective regs */
 	ld	r9,_MSR(r1)
-- 
2.11.0

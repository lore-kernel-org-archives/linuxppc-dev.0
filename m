Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsS3V0YwfzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 22:35:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 1/3] powerpc/64s: Use BRANCH_TO_COMMON() for slb_miss_realmode
Date: Tue, 20 Jun 2017 22:34:55 +1000
Message-Id: <1497962097-9402-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All the callers of slb_miss_realmode currently open code the #ifndef
CONFIG_RELOCATABLE check and the branch via CTR in the RELOCATABLE case.
We have a macro to do this, BRANCH_TO_COMMON(), so use it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 42 ++++--------------------------------
 1 file changed, 4 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ed8628c6f0f4..7bdfddbe0328 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -514,18 +514,7 @@ EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
 	mfspr	r3,SPRN_DAR
 	mfspr	r11,SPRN_SRR1
 	crset	4*cr6+eq
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
-#else
-	/*
-	 * We can't just use a direct branch to slb_miss_realmode
-	 * because the distance from here to there depends on where
-	 * the kernel ends up being put.
-	 */
-	LOAD_HANDLER(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
+	BRANCH_TO_COMMON(r10, slb_miss_realmode)
 EXC_REAL_END(data_access_slb, 0x380, 0x80)
 
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
@@ -536,18 +525,7 @@ EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
 	mfspr	r3,SPRN_DAR
 	mfspr	r11,SPRN_SRR1
 	crset	4*cr6+eq
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
-#else
-	/*
-	 * We can't just use a direct branch to slb_miss_realmode
-	 * because the distance from here to there depends on where
-	 * the kernel ends up being put.
-	 */
-	LOAD_HANDLER(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
+	BRANCH_TO_COMMON(r10, slb_miss_realmode)
 EXC_VIRT_END(data_access_slb, 0x4380, 0x80)
 TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 
@@ -580,13 +558,7 @@ EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x80)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 	mfspr	r11,SPRN_SRR1
 	crclr	4*cr6+eq
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
-#else
-	LOAD_HANDLER(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
+	BRANCH_TO_COMMON(r10, slb_miss_realmode)
 EXC_REAL_END(instruction_access_slb, 0x480, 0x80)
 
 EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x80)
@@ -597,13 +569,7 @@ EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x80)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 	mfspr	r11,SPRN_SRR1
 	crclr	4*cr6+eq
-#ifndef CONFIG_RELOCATABLE
-	b	slb_miss_realmode
-#else
-	LOAD_HANDLER(r10, slb_miss_realmode)
-	mtctr	r10
-	bctr
-#endif
+	BRANCH_TO_COMMON(r10, slb_miss_realmode)
 EXC_VIRT_END(instruction_access_slb, 0x4480, 0x80)
 TRAMP_KVM(PACA_EXSLB, 0x480)
 
-- 
2.7.4

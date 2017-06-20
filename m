Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsS3X45twzDqhp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 22:35:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 2/3] powerpc/64s: Rename slb_miss_realmode() to
 slb_miss_common()
Date: Tue, 20 Jun 2017 22:34:56 +1000
Message-Id: <1497962097-9402-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1497962097-9402-1-git-send-email-mpe@ellerman.id.au>
References: <1497962097-9402-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

slb_miss_realmode() doesn't always runs in real mode, which is what the
name implies. So rename it to avoid confusing people.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7bdfddbe0328..6ad755e0cb29 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -514,7 +514,7 @@ EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
 	mfspr	r3,SPRN_DAR
 	mfspr	r11,SPRN_SRR1
 	crset	4*cr6+eq
-	BRANCH_TO_COMMON(r10, slb_miss_realmode)
+	BRANCH_TO_COMMON(r10, slb_miss_common)
 EXC_REAL_END(data_access_slb, 0x380, 0x80)
 
 EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
@@ -525,7 +525,7 @@ EXC_VIRT_BEGIN(data_access_slb, 0x4380, 0x80)
 	mfspr	r3,SPRN_DAR
 	mfspr	r11,SPRN_SRR1
 	crset	4*cr6+eq
-	BRANCH_TO_COMMON(r10, slb_miss_realmode)
+	BRANCH_TO_COMMON(r10, slb_miss_common)
 EXC_VIRT_END(data_access_slb, 0x4380, 0x80)
 TRAMP_KVM_SKIP(PACA_EXSLB, 0x380)
 
@@ -558,7 +558,7 @@ EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x80)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 	mfspr	r11,SPRN_SRR1
 	crclr	4*cr6+eq
-	BRANCH_TO_COMMON(r10, slb_miss_realmode)
+	BRANCH_TO_COMMON(r10, slb_miss_common)
 EXC_REAL_END(instruction_access_slb, 0x480, 0x80)
 
 EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x80)
@@ -569,13 +569,16 @@ EXC_VIRT_BEGIN(instruction_access_slb, 0x4480, 0x80)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 	mfspr	r11,SPRN_SRR1
 	crclr	4*cr6+eq
-	BRANCH_TO_COMMON(r10, slb_miss_realmode)
+	BRANCH_TO_COMMON(r10, slb_miss_common)
 EXC_VIRT_END(instruction_access_slb, 0x4480, 0x80)
 TRAMP_KVM(PACA_EXSLB, 0x480)
 
 
-/* This handler is used by both 0x380 and 0x480 slb miss interrupts */
-EXC_COMMON_BEGIN(slb_miss_realmode)
+/*
+ * This handler is used by the 0x380 and 0x480 SLB miss interrupts, as well as
+ * the virtual mode 0x4380 and 0x4480 interrupts if AIL is enabled.
+ */
+EXC_COMMON_BEGIN(slb_miss_common)
 	/*
 	 * r13 points to the PACA, r9 contains the saved CR,
 	 * r12 contains the saved r3,
-- 
2.7.4

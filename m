Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429nPr3FLpzF3RN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 15:33:52 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, paulus@ozlabs.org,
 sjitindarsingh@gmail.com, mikey@neuling.org
Subject: [PATCH] KVM: PPC: Book3S HV: Fix guest r11 corruption with POWER9 TM
 workarounds
Date: Thu, 13 Sep 2018 15:33:47 +1000
Message-Id: <20180913053347.11389-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we come into the softpatch handler (0x1500), we use r11 to store
the HSRR0 for later use by the denorm handler.

We also use the softpatch handler for the TM workarounds for
POWER9. Unfortunately, in kvmppc_interrupt_hv we later store r11 out
to the vcpu assuming it's still what we got from userspace.

This causes r11 to be corrupted in the VCPU and hence when we restore
the guest, we get a corrupted r11. We've seen this when running TM
tests inside guests on P9.

This fixes the problem by only touching r11 in the denorm case.

Fixes: 4bb3c7a020 ("KVM: PPC: Book3S HV: Work around transactional memory bugs in POWER9")
Cc: <stable@vger.kernel.org> # 4.17+
Test-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/exceptions-64s.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ea04dfb8c0..2d8fc8c9da 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1314,9 +1314,7 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 0x100)
 
 #ifdef CONFIG_PPC_DENORMALISATION
 	mfspr	r10,SPRN_HSRR1
-	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
 	andis.	r10,r10,(HSRR1_DENORM)@h /* denorm? */
-	addi	r11,r11,-4		/* HSRR0 is next instruction */
 	bne+	denorm_assist
 #endif
 
@@ -1382,6 +1380,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
  */
 	XVCPSGNDP32(32)
 denorm_done:
+	mfspr	r11,SPRN_HSRR0
+	subi	r11,r11,4
 	mtspr	SPRN_HSRR0,r11
 	mtcrf	0x80,r9
 	ld	r9,PACA_EXGEN+EX_R9(r13)
-- 
2.17.1

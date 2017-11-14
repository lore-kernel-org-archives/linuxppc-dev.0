Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybjq43zYyzDqkv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 21:07:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64s: Fix masking of SRR1 bits on instruction fault
Date: Tue, 14 Nov 2017 21:07:07 +1100
Message-Id: <20171114100707.7203-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 64-bit Book3s, when we take an instruction fault the reason for the
fault may be reported in SRR1. For data faults the reason is reported
in DSISR (Data Storage Instruction Status Register).

The reasons reported in each do not necessarily correspond, so we mask
the SRR1 bits before copying them to the DSISR, which is then used by
the page fault code.

Prior to commit b4c001dc44f0 ("powerpc/mm: Use symbolic constants for
filtering SRR1 bits on ISIs") we used a hard-coded mask of 0x58200000,
which corresponds to:

  DSISR_NOHPTE		0x40000000 /* no translation found */
  DSISR_NOEXEC_OR_G	0x10000000 /* exec of no-exec or guarded */
  DSISR_PROTFAULT	0x08000000 /* protection fault */
  DSISR_KEYFAULT	0x00200000 /* Storage Key fault */

That commit added a #define for the mask, DSISR_SRR1_MATCH_64S, but
incorrectly used a different similarly named DSISR_BAD_FAULT_64S.

This had the effect of changing the mask to 0xa43a0000, which omits
everything but DSISR_KEYFAULT.

Luckily this had no visible effect, because in practice we hardly use
the DSISR bits. The lack of DSISR_NOHPTE means a TLB flush
optimisation was missed in the native HPTE code, and DSISR_NOEXEC_OR_G
and DSISR_PROTFAULT are both only used to trigger rare warnings.

So we got lucky, but let's fix it. The new value only has bits between
17 and 30 set, so we can continue to use andis.

Fixes: b4c001dc44f0 ("powerpc/mm: Use symbolic constants for filtering SRR1 bits on ISIs")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 445137e2d0ca..4c4d20a29726 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -543,7 +543,7 @@ EXC_COMMON_BEGIN(instruction_access_common)
 	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r12,_MSR(r1)
 	ld	r3,_NIP(r1)
-	andis.	r4,r12,DSISR_BAD_FAULT_64S@h
+	andis.	r4,r12,DSISR_SRR1_MATCH_64S@h
 	li	r5,0x400
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
-- 
2.14.3

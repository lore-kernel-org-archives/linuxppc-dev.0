Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWfp65S2tzDqsF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 14:37:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org,
	kvm-ppc@vger.kernel.org,
	schwab@linux-m68k.org
Subject: [PATCH] KVM: PPC: Book3S HV: Fix invalid use of register expression
Date: Tue, 15 Aug 2017 14:37:01 +1000
Message-Id: <1502771821-10316-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andreas Schwab <schwab@linux-m68k.org>

binutils >= 2.26 now warns about misuse of register expressions in
assembler operands that are actually literals. In this instance r0 is
being used where a literal 0 should be used.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
[mpe: Split into separate KVM patch, tweak change log]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index c52184a8efdf..0bc400f882f4 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -976,7 +976,7 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 #ifdef CONFIG_KVM_XICS
 	/* We are entering the guest on that thread, push VCPU to XIVE */
 	ld	r10, HSTATE_XIVE_TIMA_PHYS(r13)
-	cmpldi	cr0, r10, r0
+	cmpldi	cr0, r10, 0
 	beq	no_xive
 	ld	r11, VCPU_XIVE_SAVED_STATE(r4)
 	li	r9, TM_QW1_OS
-- 
2.7.4

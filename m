Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zclmd2BpDzF17f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 04:38:56 +1100 (AEDT)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH] KVM: PPC: Book3S HV: Branch inside feature section
Date: Thu,  8 Feb 2018 18:38:53 +0100
Message-Id: <20180208173853.15081-1-agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We ended up with code that did a conditional branch inside a feature
section to code outside of the feature section. Depending on how the
object file gets organized, that might mean we exceed the 14bit
relocation limit for conditional branches:

  arch/powerpc/kvm/built-in.o:arch/powerpc/kvm/book3s_hv_rmhandlers.S:416:(__ftr_alt_97+0x8): relocation truncated to fit: R_PPC64_REL14 against `.text'+1ca4

So instead of doing a conditional branch outside of the feature section,
let's just jump at the end of the same, making the branch very short.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 9c61f736c75b..1e037326897b 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -413,10 +413,11 @@ FTR_SECTION_ELSE
 	/* On P9 we use the split_info for coordinating LPCR changes */
 	lwz	r4, KVM_SPLIT_DO_SET(r6)
 	cmpwi	r4, 0
-	beq	63f
+	beq	1f
 	mr	r3, r6
 	bl	kvmhv_p9_set_lpcr
 	nop
+1:
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 63:
 	/* Order load of vcpu after load of vcore */
-- 
2.12.3

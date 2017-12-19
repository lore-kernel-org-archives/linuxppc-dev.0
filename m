Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1LZh5Sk8zDx5y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 01:56:28 +1100 (AEDT)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH] KVM: PPC: Book3S HV: Remove vcpu->arch.dec usage
Date: Tue, 19 Dec 2017 15:56:24 +0100
Message-Id: <20171219145624.46724-1-agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Book3S in HV mode, we don't use the vcpu->arch.dec field at all.
Instead, all logic is built around vcpu->arch.dec_expires.

So let's remove the one remaining piece of code that was setting it.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

Looking through the DEC logic, I fail to see any code that allows
save or restore of DEC. Do we maybe miss out on that register for
(live) migration?
---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 2659844784b8..c8ffd69adfec 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -957,7 +957,6 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_300)
 	mftb	r7
 	subf	r3,r7,r8
 	mtspr	SPRN_DEC,r3
-	std	r3,VCPU_DEC(r4)
 
 	ld	r5, VCPU_SPRG0(r4)
 	ld	r6, VCPU_SPRG1(r4)
-- 
2.12.3

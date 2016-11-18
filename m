Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKqNz6Z3ZzDvt1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 18:28:51 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 04/13] KVM: PPC: Book3S HV: Don't lose hardware R/C bit
 updates in H_PROTECT
Date: Fri, 18 Nov 2016 18:28:33 +1100
Message-Id: <1479454122-26994-5-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hashed page table MMU in POWER processors can update the R
(reference) and C (change) bits in a HPTE at any time until the
HPTE has been invalidated and the TLB invalidation sequence has
completed.  In kvmppc_h_protect, which implements the H_PROTECT
hypercall, we read the HPTE, modify the second doubleword,
invalidate the HPTE in memory, do the TLB invalidation sequence,
and then write the modified value of the second doubleword back
to memory.  In doing so we could overwrite an R/C bit update done
by hardware between when we read the HPTE and when the TLB
invalidation completed.  To fix this we re-read the second
doubleword after the TLB invalidation and OR in the (possibly)
new values of R and C.  We can use an OR since hardware only ever
sets R and C, never clears them.

This race was found by code inspection.  In principle this bug could
cause occasional guest memory corruption under host memory pressure.

Fixes: a8606e20e41a ("KVM: PPC: Handle some PAPR hcalls in the kernel", 2011-06-29)
Cc: stable@vger.kernel.org # v3.19+
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 752451f3..02786b3 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -670,6 +670,8 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 					      HPTE_V_ABSENT);
 			do_tlbies(kvm, &rb, 1, global_invalidates(kvm, flags),
 				  true);
+			/* Don't lose R/C bit updates done by hardware */
+			r |= be64_to_cpu(hpte[1]) & (HPTE_R_R | HPTE_R_C);
 			hpte[1] = cpu_to_be64(r);
 		}
 	}
-- 
2.7.4

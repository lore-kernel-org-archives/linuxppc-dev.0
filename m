Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C45A41A04A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 17:14:25 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 27 Jan 2015 16:14:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 431BE2CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 17:14:21 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0R6ECav26935308
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 17:14:21 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0R6DkmY002497
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 17:13:47 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH V2 1/2] KVM: PPC: BOOK3S: HV: Add helpers for lock/unlock hpte
Date: Tue, 27 Jan 2015 11:43:17 +0530
Message-Id: <1422339198-32357-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds helper routine for lock and unlock hpte and use
the same for rest of the code. We don't change any locking rules in this
patch. In the next patch we switch some of the unlock usage to use
the api with barrier and also document the usage without barriers.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V1:
* Rebase to latest upstream

 arch/powerpc/include/asm/kvm_book3s_64.h | 14 ++++++++++++++
 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 25 ++++++++++---------------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      | 25 +++++++++----------------
 3 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 2d81e202bdcc..0789a0f50969 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -85,6 +85,20 @@ static inline long try_lock_hpte(__be64 *hpte, unsigned long bits)
 	return old == 0;
 }
 
+static inline void unlock_hpte(__be64 *hpte, unsigned long hpte_v)
+{
+	hpte_v &= ~HPTE_V_HVLOCK;
+	asm volatile(PPC_RELEASE_BARRIER "" : : : "memory");
+	hpte[0] = cpu_to_be64(hpte_v);
+}
+
+/* Without barrier */
+static inline void __unlock_hpte(__be64 *hpte, unsigned long hpte_v)
+{
+	hpte_v &= ~HPTE_V_HVLOCK;
+	hpte[0] = cpu_to_be64(hpte_v);
+}
+
 static inline int __hpte_actual_psize(unsigned int lp, int psize)
 {
 	int i, shift;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 534acb3c6c3d..551dabb9551b 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -338,9 +338,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	v = be64_to_cpu(hptep[0]) & ~HPTE_V_HVLOCK;
 	gr = kvm->arch.revmap[index].guest_rpte;
 
-	/* Unlock the HPTE */
-	asm volatile("lwsync" : : : "memory");
-	hptep[0] = cpu_to_be64(v);
+	unlock_hpte(hptep, v);
 	preempt_enable();
 
 	gpte->eaddr = eaddr;
@@ -469,8 +467,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	hpte[0] = be64_to_cpu(hptep[0]) & ~HPTE_V_HVLOCK;
 	hpte[1] = be64_to_cpu(hptep[1]);
 	hpte[2] = r = rev->guest_rpte;
-	asm volatile("lwsync" : : : "memory");
-	hptep[0] = cpu_to_be64(hpte[0]);
+	unlock_hpte(hptep, hpte[0]);
 	preempt_enable();
 
 	if (hpte[0] != vcpu->arch.pgfault_hpte[0] ||
@@ -621,7 +618,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	hptep[1] = cpu_to_be64(r);
 	eieio();
-	hptep[0] = cpu_to_be64(hpte[0]);
+	__unlock_hpte(hptep, hpte[0]);
 	asm volatile("ptesync" : : : "memory");
 	preempt_enable();
 	if (page && hpte_is_writable(r))
@@ -642,7 +639,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return ret;
 
  out_unlock:
-	hptep[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+	__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	preempt_enable();
 	goto out_put;
 }
@@ -771,7 +768,7 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 			}
 		}
 		unlock_rmap(rmapp);
-		hptep[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	}
 	return 0;
 }
@@ -857,7 +854,7 @@ static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 			}
 			ret = 1;
 		}
-		hptep[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
@@ -974,8 +971,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 
 		/* Now check and modify the HPTE */
 		if (!(hptep[0] & cpu_to_be64(HPTE_V_VALID))) {
-			/* unlock and continue */
-			hptep[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+			__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 			continue;
 		}
 
@@ -996,9 +992,9 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 				npages_dirty = n;
 			eieio();
 		}
-		v &= ~(HPTE_V_ABSENT | HPTE_V_HVLOCK);
+		v &= ~HPTE_V_ABSENT;
 		v |= HPTE_V_VALID;
-		hptep[0] = cpu_to_be64(v);
+		__unlock_hpte(hptep, v);
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
@@ -1218,8 +1214,7 @@ static long record_hpte(unsigned long flags, __be64 *hptp,
 			r &= ~HPTE_GR_MODIFIED;
 			revp->guest_rpte = r;
 		}
-		asm volatile(PPC_RELEASE_BARRIER "" : : : "memory");
-		hptp[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+		unlock_hpte(hptp, be64_to_cpu(hptp[0]));
 		preempt_enable();
 		if (!(valid == want_valid && (first_pass || dirty)))
 			ok = 0;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 510bdfbc4073..9123132b3053 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -150,12 +150,6 @@ static pte_t lookup_linux_pte_and_update(pgd_t *pgdir, unsigned long hva,
 	return kvmppc_read_update_linux_pte(ptep, writing, hugepage_shift);
 }
 
-static inline void unlock_hpte(__be64 *hpte, unsigned long hpte_v)
-{
-	asm volatile(PPC_RELEASE_BARRIER "" : : : "memory");
-	hpte[0] = cpu_to_be64(hpte_v);
-}
-
 long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		       long pte_index, unsigned long pteh, unsigned long ptel,
 		       pgd_t *pgdir, bool realmode, unsigned long *pte_idx_ret)
@@ -271,10 +265,10 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 				u64 pte;
 				while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 					cpu_relax();
-				pte = be64_to_cpu(*hpte);
+				pte = be64_to_cpu(hpte[0]);
 				if (!(pte & (HPTE_V_VALID | HPTE_V_ABSENT)))
 					break;
-				*hpte &= ~cpu_to_be64(HPTE_V_HVLOCK);
+				__unlock_hpte(hpte, pte);
 				hpte += 2;
 			}
 			if (i == 8)
@@ -290,9 +284,9 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 			while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
 				cpu_relax();
-			pte = be64_to_cpu(*hpte);
+			pte = be64_to_cpu(hpte[0]);
 			if (pte & (HPTE_V_VALID | HPTE_V_ABSENT)) {
-				*hpte &= ~cpu_to_be64(HPTE_V_HVLOCK);
+				__unlock_hpte(hpte, pte);
 				return H_PTEG_FULL;
 			}
 		}
@@ -331,7 +325,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 	/* Write the first HPTE dword, unlocking the HPTE and making it valid */
 	eieio();
-	hpte[0] = cpu_to_be64(pteh);
+	__unlock_hpte(hpte, pteh);
 	asm volatile("ptesync" : : : "memory");
 
 	*pte_idx_ret = pte_index;
@@ -412,7 +406,7 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn) ||
 	    ((flags & H_ANDCOND) && (pte & avpn) != 0)) {
-		hpte[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+		__unlock_hpte(hpte, pte);
 		return H_NOT_FOUND;
 	}
 
@@ -548,7 +542,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 				be64_to_cpu(hp[0]), be64_to_cpu(hp[1]));
 			rcbits = rev->guest_rpte & (HPTE_R_R|HPTE_R_C);
 			args[j] |= rcbits << (56 - 5);
-			hp[0] = 0;
+			__unlock_hpte(hp, 0);
 		}
 	}
 
@@ -574,7 +568,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	pte = be64_to_cpu(hpte[0]);
 	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn)) {
-		hpte[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+		__unlock_hpte(hpte, pte);
 		return H_NOT_FOUND;
 	}
 
@@ -755,8 +749,7 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 				/* Return with the HPTE still locked */
 				return (hash << 3) + (i >> 1);
 
-			/* Unlock and move on */
-			hpte[i] = cpu_to_be64(v);
+			__unlock_hpte(&hpte[i], v);
 		}
 
 		if (val & HPTE_V_SECONDARY)
-- 
2.1.0

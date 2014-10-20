Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FFC11A0246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 01:29:19 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 20 Oct 2014 19:59:16 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 21DE2125804D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 19:58:56 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9KETeZT52953248
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 19:59:40 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9KET8uc031609
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 19:59:08 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/3] KVM: PPC: BOOK3S: HV: Add helpers for lock/unlock hpte
Date: Mon, 20 Oct 2014 19:58:58 +0530
Message-Id: <1413815340-22426-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/kvm_book3s_64.h | 14 ++++++++++++++
 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 25 ++++++++++---------------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      | 27 ++++++++++-----------------
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 0aa817933e6a..ec9fb6085843 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -86,6 +86,20 @@ static inline long try_lock_hpte(__be64 *hpte, unsigned long bits)
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
index cebb86bc4a37..5ea4b2b6a157 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -475,9 +475,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	v = be64_to_cpu(hptep[0]) & ~HPTE_V_HVLOCK;
 	gr = kvm->arch.revmap[index].guest_rpte;
 
-	/* Unlock the HPTE */
-	asm volatile("lwsync" : : : "memory");
-	hptep[0] = cpu_to_be64(v);
+	unlock_hpte(hptep, v);
 	preempt_enable();
 
 	gpte->eaddr = eaddr;
@@ -606,8 +604,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	hpte[0] = be64_to_cpu(hptep[0]) & ~HPTE_V_HVLOCK;
 	hpte[1] = be64_to_cpu(hptep[1]);
 	hpte[2] = r = rev->guest_rpte;
-	asm volatile("lwsync" : : : "memory");
-	hptep[0] = cpu_to_be64(hpte[0]);
+	unlock_hpte(hptep, hpte[0]);
 	preempt_enable();
 
 	if (hpte[0] != vcpu->arch.pgfault_hpte[0] ||
@@ -758,7 +755,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	hptep[1] = cpu_to_be64(r);
 	eieio();
-	hptep[0] = cpu_to_be64(hpte[0]);
+	__unlock_hpte(hptep, hpte[0]);
 	asm volatile("ptesync" : : : "memory");
 	preempt_enable();
 	if (page && hpte_is_writable(r))
@@ -777,7 +774,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return ret;
 
  out_unlock:
-	hptep[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+	__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	preempt_enable();
 	goto out_put;
 }
@@ -907,7 +904,7 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 			}
 		}
 		unlock_rmap(rmapp);
-		hptep[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	}
 	return 0;
 }
@@ -995,7 +992,7 @@ static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 			}
 			ret = 1;
 		}
-		hptep[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
@@ -1118,8 +1115,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 
 		/* Now check and modify the HPTE */
 		if (!(hptep[0] & cpu_to_be64(HPTE_V_VALID))) {
-			/* unlock and continue */
-			hptep[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+			__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 			continue;
 		}
 		/* need to make it temporarily absent so C is stable */
@@ -1139,9 +1135,9 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
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
@@ -1379,8 +1375,7 @@ static long record_hpte(unsigned long flags, __be64 *hptp,
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
index 084ad54c73cd..769a5d4c0430 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -154,12 +154,6 @@ static pte_t lookup_linux_pte_and_update(pgd_t *pgdir, unsigned long hva,
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
@@ -295,10 +289,10 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
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
@@ -314,9 +308,9 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
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
@@ -356,7 +350,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 	/* Write the first HPTE dword, unlocking the HPTE and making it valid */
 	eieio();
-	hpte[0] = cpu_to_be64(pteh);
+	__unlock_hpte(hpte, pteh);
 	asm volatile("ptesync" : : : "memory");
 
 	*pte_idx_ret = pte_index;
@@ -487,7 +481,7 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn) ||
 	    ((flags & H_ANDCOND) && (pte & avpn) != 0)) {
-		hpte[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+		__unlock_hpte(hpte, pte);
 		return H_NOT_FOUND;
 	}
 
@@ -623,7 +617,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 				be64_to_cpu(hp[0]), be64_to_cpu(hp[1]));
 			rcbits = rev->guest_rpte & (HPTE_R_R|HPTE_R_C);
 			args[j] |= rcbits << (56 - 5);
-			hp[0] = 0;
+			__unlock_hpte(hp, 0);
 		}
 	}
 
@@ -649,7 +643,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	pte = be64_to_cpu(hpte[0]);
 	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn)) {
-		hpte[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
+		__unlock_hpte(hpte, pte);
 		return H_NOT_FOUND;
 	}
 
@@ -700,7 +694,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	}
 	hpte[1] = cpu_to_be64(r);
 	eieio();
-	hpte[0] = cpu_to_be64(v & ~HPTE_V_HVLOCK);
+	__unlock_hpte(hpte, v);
 	asm volatile("ptesync" : : : "memory");
 	return H_SUCCESS;
 }
@@ -841,8 +835,7 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 				/* Return with the HPTE still locked */
 				return (hash << 3) + (i >> 1);
 
-			/* Unlock and move on */
-			hpte[i] = cpu_to_be64(v);
+			__unlock_hpte(&hpte[i], v);
 		}
 
 		if (val & HPTE_V_SECONDARY)
-- 
1.9.1

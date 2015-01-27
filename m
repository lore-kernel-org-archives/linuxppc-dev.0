Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 563581A06D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 17:33:47 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 27 Jan 2015 12:03:43 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2F174394005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 12:03:41 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0R6Xe8o4325764
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 12:03:41 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0R6XeZg028906
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 12:03:40 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH V2 2/2] KVM: PPC: BOOK3S: HV: Use unlock variant with memory
 barrier
Date: Tue, 27 Jan 2015 12:03:30 +0530
Message-Id: <1422340410-2239-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1422339198-32357-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1422339198-32357-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We switch to unlock variant with memory barriers in the error path
and also in code path where we had implicit dependency on previous
functions calling lwsync/ptesync. In most of the cases we don't really
need an explicit barrier, but using the variant make sure we don't make
mistakes later with code movements. We also document why a
non-barrier variant is ok in performance critical path.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V1:
* Rebase to latest upstream

 arch/powerpc/kvm/book3s_64_mmu_hv.c | 10 +++++-----
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 15 ++++++++++-----
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 551dabb9551b..0fd91f54d1a7 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -639,7 +639,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return ret;
 
  out_unlock:
-	__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
+	unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	preempt_enable();
 	goto out_put;
 }
@@ -767,8 +767,8 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 				note_hpte_modification(kvm, &rev[i]);
 			}
 		}
+		unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 		unlock_rmap(rmapp);
-		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	}
 	return 0;
 }
@@ -854,7 +854,7 @@ static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 			}
 			ret = 1;
 		}
-		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
+		unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
@@ -971,7 +971,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 
 		/* Now check and modify the HPTE */
 		if (!(hptep[0] & cpu_to_be64(HPTE_V_VALID))) {
-			__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
+			unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 			continue;
 		}
 
@@ -994,7 +994,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 		}
 		v &= ~HPTE_V_ABSENT;
 		v |= HPTE_V_VALID;
-		__unlock_hpte(hptep, v);
+		unlock_hpte(hptep, v);
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 9123132b3053..2e45bd57d4e8 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -268,6 +268,9 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 				pte = be64_to_cpu(hpte[0]);
 				if (!(pte & (HPTE_V_VALID | HPTE_V_ABSENT)))
 					break;
+				/*
+				 * Data dependency will avoid re-ordering
+				 */
 				__unlock_hpte(hpte, pte);
 				hpte += 2;
 			}
@@ -286,7 +289,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 				cpu_relax();
 			pte = be64_to_cpu(hpte[0]);
 			if (pte & (HPTE_V_VALID | HPTE_V_ABSENT)) {
-				__unlock_hpte(hpte, pte);
+				unlock_hpte(hpte, pte);
 				return H_PTEG_FULL;
 			}
 		}
@@ -406,7 +409,7 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn) ||
 	    ((flags & H_ANDCOND) && (pte & avpn) != 0)) {
-		__unlock_hpte(hpte, pte);
+		unlock_hpte(hpte, pte);
 		return H_NOT_FOUND;
 	}
 
@@ -542,7 +545,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 				be64_to_cpu(hp[0]), be64_to_cpu(hp[1]));
 			rcbits = rev->guest_rpte & (HPTE_R_R|HPTE_R_C);
 			args[j] |= rcbits << (56 - 5);
-			__unlock_hpte(hp, 0);
+			unlock_hpte(hp, 0);
 		}
 	}
 
@@ -568,7 +571,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	pte = be64_to_cpu(hpte[0]);
 	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn)) {
-		__unlock_hpte(hpte, pte);
+		unlock_hpte(hpte, pte);
 		return H_NOT_FOUND;
 	}
 
@@ -748,7 +751,9 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 			    hpte_base_page_size(v, r) == (1ul << pshift))
 				/* Return with the HPTE still locked */
 				return (hash << 3) + (i >> 1);
-
+			/*
+			 * Data dependency should avoid re-ordering
+			 */
 			__unlock_hpte(&hpte[i], v);
 		}
 
-- 
2.1.0

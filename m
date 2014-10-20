Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D1F61A0053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 01:29:16 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 20 Oct 2014 19:59:12 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 12880125804B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 19:58:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9KETevh62193710
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 19:59:40 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9KET9AD031666
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 19:59:09 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/3] KVM: PPC: BOOK3S: HV: Use unlock variant with memory
 barrier
Date: Mon, 20 Oct 2014 19:58:59 +0530
Message-Id: <1413815340-22426-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1413815340-22426-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1413815340-22426-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 10 +++++-----
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 15 ++++++++++-----
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 5ea4b2b6a157..c97690ffb5f6 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -774,7 +774,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	return ret;
 
  out_unlock:
-	__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
+	unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	preempt_enable();
 	goto out_put;
 }
@@ -903,8 +903,8 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 				note_hpte_modification(kvm, &rev[i]);
 			}
 		}
+		unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 		unlock_rmap(rmapp);
-		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	}
 	return 0;
 }
@@ -992,7 +992,7 @@ static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 			}
 			ret = 1;
 		}
-		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
+		unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
@@ -1115,7 +1115,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 
 		/* Now check and modify the HPTE */
 		if (!(hptep[0] & cpu_to_be64(HPTE_V_VALID))) {
-			__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
+			unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 			continue;
 		}
 		/* need to make it temporarily absent so C is stable */
@@ -1137,7 +1137,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 		}
 		v &= ~HPTE_V_ABSENT;
 		v |= HPTE_V_VALID;
-		__unlock_hpte(hptep, v);
+		unlock_hpte(hptep, v);
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 769a5d4c0430..78e689b066f1 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -292,6 +292,9 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 				pte = be64_to_cpu(hpte[0]);
 				if (!(pte & (HPTE_V_VALID | HPTE_V_ABSENT)))
 					break;
+				/*
+				 * Data dependency will avoid re-ordering
+				 */
 				__unlock_hpte(hpte, pte);
 				hpte += 2;
 			}
@@ -310,7 +313,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 				cpu_relax();
 			pte = be64_to_cpu(hpte[0]);
 			if (pte & (HPTE_V_VALID | HPTE_V_ABSENT)) {
-				__unlock_hpte(hpte, pte);
+				unlock_hpte(hpte, pte);
 				return H_PTEG_FULL;
 			}
 		}
@@ -481,7 +484,7 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn) ||
 	    ((flags & H_ANDCOND) && (pte & avpn) != 0)) {
-		__unlock_hpte(hpte, pte);
+		unlock_hpte(hpte, pte);
 		return H_NOT_FOUND;
 	}
 
@@ -617,7 +620,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 				be64_to_cpu(hp[0]), be64_to_cpu(hp[1]));
 			rcbits = rev->guest_rpte & (HPTE_R_R|HPTE_R_C);
 			args[j] |= rcbits << (56 - 5);
-			__unlock_hpte(hp, 0);
+			unlock_hpte(hp, 0);
 		}
 	}
 
@@ -643,7 +646,7 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	pte = be64_to_cpu(hpte[0]);
 	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
 	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn)) {
-		__unlock_hpte(hpte, pte);
+		unlock_hpte(hpte, pte);
 		return H_NOT_FOUND;
 	}
 
@@ -834,7 +837,9 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
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
1.9.1

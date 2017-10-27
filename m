Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yNVky4dx3zDrcY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 15:09:46 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9R492cI036383
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 00:09:43 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2duuqmvk5f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2017 00:09:42 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 26 Oct 2017 22:09:42 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 10/16] powerpc/kvm/hash: Implement HASH_REMOVE hcall
Date: Fri, 27 Oct 2017 09:38:27 +0530
In-Reply-To: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20171027040833.3644-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20171027040833.3644-11-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is equivalent to H_REMOVE hcall, but then takes hash value as the arg
instead of hashpte slot number. We will use this later to speed up invalidate
operation in guest. Instead of finding slot number using H_READ4 hcall, we can
use hash value directly using this hcall.

Only support flag value for the operation is H_AVPN.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h         |   3 +-
 arch/powerpc/include/asm/plpar_wrappers.h |  16 ++++
 arch/powerpc/kvm/book3s_hv.c              |   1 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c       | 134 ++++++++++++++++++++++++++----
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |   2 +
 5 files changed, 138 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 3d34dc0869f6..92980217a076 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -291,7 +291,8 @@
 #define H_INT_ESB               0x3C8
 #define H_INT_SYNC              0x3CC
 #define H_INT_RESET             0x3D0
-#define MAX_HCALL_OPCODE	H_INT_RESET
+#define H_HASH_REMOVE		0x3D4
+#define MAX_HCALL_OPCODE	H_HASH_REMOVE
 
 /* H_VIOCTL functions */
 #define H_GET_VIOA_DUMP_SIZE	0x01
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index c7b164836bc3..8160fea9b5bc 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -124,6 +124,22 @@ static inline long plpar_pte_remove(unsigned long flags, unsigned long ptex,
 	return rc;
 }
 
+static inline long plpar_pte_hash_remove(unsigned long flags, unsigned long hash,
+				    unsigned long avpn, unsigned long *old_pteh_ret,
+				    unsigned long *old_ptel_ret)
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+
+	rc = plpar_hcall(H_HASH_REMOVE, retbuf, flags, hash, avpn);
+
+	*old_pteh_ret = retbuf[0];
+	*old_ptel_ret = retbuf[1];
+
+	return rc;
+}
+
+
 /* plpar_pte_remove_raw can be called in real mode. It calls plpar_hcall_raw */
 static inline long plpar_pte_remove_raw(unsigned long flags, unsigned long ptex,
 		unsigned long avpn, unsigned long *old_pteh_ret,
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 73bf1ebfa78f..56e7f52ed324 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4171,6 +4171,7 @@ static unsigned int default_hcall_list[] = {
 	H_XIRR,
 	H_XIRR_X,
 #endif
+	H_HASH_REMOVE,
 	0
 };
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index d80240ba6de4..7ebeb1be8380 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -465,34 +465,21 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 	}
 }
 
-long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
-			unsigned long pte_index, unsigned long avpn,
-			unsigned long *hpret)
+static long __kvmppc_do_hash_remove(struct kvm *kvm, __be64 *hpte,
+				    unsigned long pte_index,
+				    unsigned long *hpret)
 {
-	__be64 *hpte;
+
 	unsigned long v, r, rb;
 	struct revmap_entry *rev;
 	u64 pte, orig_pte, pte_r;
 
-	if (kvm_is_radix(kvm))
-		return H_FUNCTION;
-	if (pte_index >= kvmppc_hpt_npte(&kvm->arch.hpt))
-		return H_PARAMETER;
-	hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
-	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
-		cpu_relax();
 	pte = orig_pte = be64_to_cpu(hpte[0]);
 	pte_r = be64_to_cpu(hpte[1]);
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 		pte = hpte_new_to_old_v(pte, pte_r);
 		pte_r = hpte_new_to_old_r(pte_r);
 	}
-	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
-	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn) ||
-	    ((flags & H_ANDCOND) && (pte & avpn) != 0)) {
-		__unlock_hpte(hpte, orig_pte);
-		return H_NOT_FOUND;
-	}
 
 	rev = real_vmalloc_addr(&kvm->arch.hpt.rev[pte_index]);
 	v = pte & ~HPTE_V_HVLOCK;
@@ -525,6 +512,35 @@ long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
 	hpret[1] = r;
 	return H_SUCCESS;
 }
+
+long kvmppc_do_h_remove(struct kvm *kvm, unsigned long flags,
+			unsigned long pte_index, unsigned long avpn,
+			unsigned long *hpret)
+{
+	__be64 *hpte;
+	u64 pte, orig_pte, pte_r;
+
+	if (kvm_is_radix(kvm))
+		return H_FUNCTION;
+	if (pte_index >= kvmppc_hpt_npte(&kvm->arch.hpt))
+		return H_PARAMETER;
+	hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
+	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
+		cpu_relax();
+	pte = orig_pte = be64_to_cpu(hpte[0]);
+	pte_r = be64_to_cpu(hpte[1]);
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		pte = hpte_new_to_old_v(pte, pte_r);
+		pte_r = hpte_new_to_old_r(pte_r);
+	}
+	if ((pte & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
+	    ((flags & H_AVPN) && (pte & ~0x7fUL) != avpn) ||
+	    ((flags & H_ANDCOND) && (pte & avpn) != 0)) {
+		__unlock_hpte(hpte, orig_pte);
+		return H_NOT_FOUND;
+	}
+	return __kvmppc_do_hash_remove(kvm, hpte, pte_index, hpret);
+}
 EXPORT_SYMBOL_GPL(kvmppc_do_h_remove);
 
 long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
@@ -534,6 +550,90 @@ long kvmppc_h_remove(struct kvm_vcpu *vcpu, unsigned long flags,
 				  &vcpu->arch.gpr[4]);
 }
 
+/* return locked hpte */
+static __be64 *kvmppc_find_hpte_slot(struct kvm *kvm, unsigned long hash,
+				     unsigned long avpn, unsigned long *pte_index)
+{
+	int i;
+	__be64 *hpte;
+	unsigned long slot;
+	u64 pte_v, orig_pte, pte_r;
+	bool secondary_search = false;
+
+	/*
+	 * search for the hpte in primary group
+	 */
+	slot = (hash & kvmppc_hpt_mask(&kvm->arch.hpt)) * HPTES_PER_GROUP;
+
+search_again:
+	hpte = (__be64 *)(kvm->arch.hpt.virt + (slot << 4));
+	for (i = 0; i < HPTES_PER_GROUP; i++ , hpte += 2) {
+		/* lockless search */
+		pte_v = orig_pte = be64_to_cpu(hpte[0]);
+		pte_r = be64_to_cpu(hpte[1]);
+		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+			pte_v = hpte_new_to_old_v(pte_v, pte_r);
+			pte_r = hpte_new_to_old_r(pte_r);
+		}
+		if ((pte_v & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0)
+			continue;
+
+		if ((pte_v & ~0x7FUL) == avpn) {
+			while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
+				cpu_relax();
+			pte_v = orig_pte = be64_to_cpu(hpte[0]);
+			pte_r = be64_to_cpu(hpte[1]);
+			if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+				pte_v = hpte_new_to_old_v(pte_v, pte_r);
+				pte_r = hpte_new_to_old_r(pte_r);
+			}
+			if ((pte_v & ~0x7FUL) != avpn) {
+				/* unlock and continue */
+				__unlock_hpte(hpte, orig_pte);
+				continue;
+			}
+			*pte_index = slot + i;
+			return hpte;
+		}
+	}
+	if (!secondary_search) {
+		secondary_search = true;
+		slot = (~hash & kvmppc_hpt_mask(&kvm->arch.hpt)) * HPTES_PER_GROUP;
+		goto search_again;
+	}
+	return NULL;
+}
+
+/* Only support H_AVPN flag, which is must */
+long kvmppc_do_h_hash_remove(struct kvm *kvm, unsigned long flags,
+			     unsigned long hash, unsigned long avpn,
+			     unsigned long *hpret)
+{
+	__be64 *hpte;
+	unsigned long pte_index;
+
+
+	if (kvm_is_radix(kvm))
+		return H_FUNCTION;
+
+	if ((flags & H_AVPN) != H_AVPN)
+		return H_PARAMETER;
+
+	hpte = kvmppc_find_hpte_slot(kvm, hash, avpn, &pte_index);
+	if (!hpte)
+		return H_NOT_FOUND;
+
+	return __kvmppc_do_hash_remove(kvm, hpte, pte_index, hpret);
+}
+EXPORT_SYMBOL_GPL(kvmppc_do_h_hash_remove);
+
+long kvmppc_h_hash_remove(struct kvm_vcpu *vcpu, unsigned long flags,
+			  unsigned long hash, unsigned long avpn)
+{
+	return kvmppc_do_h_hash_remove(vcpu->kvm, flags, hash, avpn,
+				  &vcpu->arch.gpr[4]);
+}
+
 long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index ec69fa45d5a2..238ecf5d0ed8 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2375,6 +2375,8 @@ hcall_real_table:
 	.long	0		/* 0x2fc - H_XIRR_X*/
 #endif
 	.long	DOTSYM(kvmppc_h_random) - hcall_real_table
+	.space	((H_HASH_REMOVE - 4) - H_RANDOM), 0
+	.long	DOTSYM(kvmppc_h_hash_remove) - hcall_real_table
 	.globl	hcall_real_table_end
 hcall_real_table_end:
 
-- 
2.13.6

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhrQ55DGzDsQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:41:26 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725f6Lo074237
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:41:24 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c332s6u0u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:41:24 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:41:23 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 12/17] powerpc/kvm/hash: Implement HASH_PROTECT hcall
Date: Wed,  2 Aug 2017 11:10:11 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-13-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is equivalent to H_PROTECT hcall, but then takes hash value as the arg
instead of hashpte slot number. We will use this later to speed up invalidate
operation in guest. Instead of finding slot number using H_READ4 hcall, we can
use hash value directly using this hcall.

H_AVPN flag value is needed. Otherwise will return error.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h         |  3 +-
 arch/powerpc/include/asm/plpar_wrappers.h |  7 +++
 arch/powerpc/kvm/book3s_hv.c              |  1 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c       | 74 ++++++++++++++++++++++---------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  1 +
 5 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 6a09e91889cf..c234be675774 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -281,7 +281,8 @@
 #define H_REGISTER_PROC_TBL	0x37C
 #define H_SIGNAL_SYS_RESET	0x380
 #define H_HASH_REMOVE		0x384
-#define MAX_HCALL_OPCODE	H_HASH_REMOVE
+#define H_HASH_PROTECT		0x388
+#define MAX_HCALL_OPCODE	H_HASH_PROTECT
 
 /* H_VIOCTL functions */
 #define H_GET_VIOA_DUMP_SIZE	0x01
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 8160fea9b5bc..27e30ca6105d 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -226,6 +226,13 @@ static inline long plpar_pte_protect(unsigned long flags, unsigned long ptex,
 	return plpar_hcall_norets(H_PROTECT, flags, ptex, avpn);
 }
 
+static inline long plpar_pte_hash_protect(unsigned long flags,
+					  unsigned long hash,
+					  unsigned long avpn)
+{
+	return plpar_hcall_norets(H_HASH_PROTECT, flags, hash, avpn);
+}
+
 static inline long plpar_resize_hpt_prepare(unsigned long flags,
 					    unsigned long shift)
 {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 86c66af38637..d7be56339d53 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4144,6 +4144,7 @@ static unsigned int default_hcall_list[] = {
 	H_XIRR,
 	H_XIRR_X,
 #endif
+	H_HASH_PROTECT,
 	H_HASH_REMOVE,
 	0
 };
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 85fedb72469b..2aa507614819 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -752,33 +752,14 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
-		      unsigned long pte_index, unsigned long avpn,
-		      unsigned long va)
+long __kvmppc_do_hash_protect(struct kvm *kvm, __be64 *hpte,
+			      unsigned long flags, unsigned long pte_index)
 {
-	struct kvm *kvm = vcpu->kvm;
-	__be64 *hpte;
+	u64 pte_v, pte_r;
 	struct revmap_entry *rev;
 	unsigned long v, r, rb, mask, bits;
-	u64 pte_v, pte_r;
-
-	if (kvm_is_radix(kvm))
-		return H_FUNCTION;
-	if (pte_index >= kvmppc_hpt_npte(&kvm->arch.hpt))
-		return H_PARAMETER;
 
-	hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
-	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
-		cpu_relax();
 	v = pte_v = be64_to_cpu(hpte[0]);
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
-		v = hpte_new_to_old_v(v, be64_to_cpu(hpte[1]));
-	if ((v & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
-	    ((flags & H_AVPN) && (v & ~0x7fUL) != avpn)) {
-		__unlock_hpte(hpte, pte_v);
-		return H_NOT_FOUND;
-	}
-
 	pte_r = be64_to_cpu(hpte[1]);
 	bits = (flags << 55) & HPTE_R_PP0;
 	bits |= (flags << 48) & HPTE_R_KEY_HI;
@@ -823,6 +804,55 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	return H_SUCCESS;
 }
 
+long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
+		      unsigned long pte_index, unsigned long avpn,
+		      unsigned long va)
+{
+	__be64 *hpte;
+	u64 v, pte_v;
+	struct kvm *kvm = vcpu->kvm;
+
+	if (kvm_is_radix(kvm))
+		return H_FUNCTION;
+	if (pte_index >= kvmppc_hpt_npte(&kvm->arch.hpt))
+		return H_PARAMETER;
+
+	hpte = (__be64 *)(kvm->arch.hpt.virt + (pte_index << 4));
+	while (!try_lock_hpte(hpte, HPTE_V_HVLOCK))
+		cpu_relax();
+	v = pte_v = be64_to_cpu(hpte[0]);
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		v = hpte_new_to_old_v(v, be64_to_cpu(hpte[1]));
+	if ((v & (HPTE_V_ABSENT | HPTE_V_VALID)) == 0 ||
+	    ((flags & H_AVPN) && (v & ~0x7fUL) != avpn)) {
+		__unlock_hpte(hpte, pte_v);
+		return H_NOT_FOUND;
+	}
+	return __kvmppc_do_hash_protect(kvm, hpte, flags, pte_index);
+}
+
+/*  H_AVPN flag is must */
+long kvmppc_h_hash_protect(struct kvm_vcpu *vcpu, unsigned long flags,
+			   unsigned long hash, unsigned long avpn,
+			   unsigned long va)
+{
+	__be64 *hpte;
+	unsigned long pte_index;
+	struct kvm *kvm = vcpu->kvm;
+
+	if (kvm_is_radix(kvm))
+		return H_FUNCTION;
+
+	if (!(flags & H_AVPN))
+		return H_PARAMETER;
+
+	hpte = kvmppc_find_hpte_slot(kvm, hash, avpn, &pte_index);
+	if (!hpte)
+		return H_NOT_FOUND;
+
+	return __kvmppc_do_hash_protect(kvm, hpte, flags, pte_index);
+}
+
 long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 		   unsigned long pte_index)
 {
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 988a4f7385cc..3ca9c3fb3320 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2321,6 +2321,7 @@ hcall_real_table:
 	.long	DOTSYM(kvmppc_h_random) - hcall_real_table
 	.space	((H_HASH_REMOVE - 4) - H_RANDOM), 0
 	.long	DOTSYM(kvmppc_h_hash_remove) - hcall_real_table
+	.long	DOTSYM(kvmppc_h_hash_protect) - hcall_real_table
 	.globl	hcall_real_table_end
 hcall_real_table_end:
 
-- 
2.13.3

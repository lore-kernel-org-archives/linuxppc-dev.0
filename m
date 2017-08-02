Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMhrT1JNSzDrnZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 15:41:29 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v725f248088903
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Aug 2017 01:41:27 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c32gxg2nc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Aug 2017 01:41:26 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Aug 2017 23:41:26 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 13/17] powerpc/kvm/hash: Implement HASH_BULK_REMOVE hcall
Date: Wed,  2 Aug 2017 11:10:12 +0530
In-Reply-To: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170802054016.8927-14-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is equivalent to H_BULK_REMOVE hcall, but then takes hash value as the arg
instead of hashpte slot number. We will use this later to speed up bulk remove
operation in guest. Instead of finding slot number using H_READ4 hcall, we can
use hash value directly using this hcall.

only support H_AVPN operation

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +
 arch/powerpc/include/asm/hvcall.h             |  3 +-
 arch/powerpc/kvm/book3s_hv.c                  |  1 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c           | 95 +++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S       |  1 +
 5 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index a784d4ac4fb1..946d02d02822 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -68,6 +68,8 @@
  */
 
 #define HPTES_PER_GROUP 8
+/* ISA defines max HTAB SIZE bits 46 */
+#define MAX_HTAB_MASK ((1UL << 46) - 1)
 
 #define HPTE_V_SSIZE_SHIFT	62
 #define HPTE_V_AVPN_SHIFT	7
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index c234be675774..17366e5a2897 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -282,7 +282,8 @@
 #define H_SIGNAL_SYS_RESET	0x380
 #define H_HASH_REMOVE		0x384
 #define H_HASH_PROTECT		0x388
-#define MAX_HCALL_OPCODE	H_HASH_PROTECT
+#define H_HASH_BULK_REMOVE	0x38C
+#define MAX_HCALL_OPCODE	H_HASH_BULK_REMOVE
 
 /* H_VIOCTL functions */
 #define H_GET_VIOA_DUMP_SIZE	0x01
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d7be56339d53..01cfea8c684f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4146,6 +4146,7 @@ static unsigned int default_hcall_list[] = {
 #endif
 	H_HASH_PROTECT,
 	H_HASH_REMOVE,
+	H_HASH_BULK_REMOVE,
 	0
 };
 
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 2aa507614819..e6820a84daca 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -752,6 +752,101 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+long kvmppc_h_hash_bulk_remove(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long *args = &vcpu->arch.gpr[4];
+	__be64 *hp, *hptes[4];
+	unsigned long tlbrb[4];
+	long int i, j, k, n, pte_index[4];
+	unsigned long flags, req, hash, rcbits;
+	int global;
+	long int ret = H_SUCCESS;
+	struct revmap_entry *rev, *revs[4];
+	u64 hp0, hp1;
+
+	if (kvm_is_radix(kvm))
+		return H_FUNCTION;
+
+	global = global_invalidates(kvm);
+	for (i = 0; i < 4 && ret == H_SUCCESS; ) {
+		n = 0;
+		for (; i < 4; ++i) {
+			j = i * 2;
+			hash = args[j];
+			flags = hash >> 56;
+			hash &= ((1ul << 56) - 1);
+			req = flags >> 6;
+			flags &= 3;
+			if (req == 3) {		/* no more requests */
+				i = 4;
+				break;
+			}
+			/* only support avpn flag */
+			if (req != 1 || flags != 2) {
+				/* parameter error */
+				args[j] = ((0xa0 | flags) << 56) + hash;
+				ret = H_PARAMETER;
+				break;
+			}
+			/*
+			 * We wait here to take lock for all hash values
+			 * FIXME!! will that deadlock ?
+			 */
+			hp = kvmppc_find_hpte_slot(kvm, hash,
+						   args[j + 1], &pte_index[n]);
+			if (!hp) {
+				args[j] = ((0x90 | flags) << 56) + hash;
+				continue;
+			}
+			hp0 = be64_to_cpu(hp[0]);
+			hp1 = be64_to_cpu(hp[1]);
+			if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+				hp0 = hpte_new_to_old_v(hp0, hp1);
+				hp1 = hpte_new_to_old_r(hp1);
+			}
+			args[j] = ((0x80 | flags) << 56) + hash;
+			rev = real_vmalloc_addr(&kvm->arch.hpt.rev[pte_index[n]]);
+			note_hpte_modification(kvm, rev);
+
+			if (!(hp0 & HPTE_V_VALID)) {
+				/* insert R and C bits from PTE */
+				rcbits = rev->guest_rpte & (HPTE_R_R|HPTE_R_C);
+				args[j] |= rcbits << (56 - 5);
+				hp[0] = 0;
+				if (is_mmio_hpte(hp0, hp1))
+					atomic64_inc(&kvm->arch.mmio_update);
+				continue;
+			}
+			/* leave it locked */
+			hp[0] &= ~cpu_to_be64(HPTE_V_VALID);
+			tlbrb[n] = compute_tlbie_rb(hp0, hp1, pte_index[n]);
+			hptes[n] = hp;
+			revs[n] = rev;
+			++n;
+		}
+
+		if (!n)
+			break;
+
+		/* Now that we've collected a batch, do the tlbies */
+		do_tlbies(kvm, tlbrb, n, global, true);
+
+		/* Read PTE low words after tlbie to get final R/C values */
+		for (k = 0; k < n; ++k) {
+			hp = hptes[k];
+			rev = revs[k];
+			remove_revmap_chain(kvm, pte_index[k], rev,
+				be64_to_cpu(hp[0]), be64_to_cpu(hp[1]));
+			rcbits = rev->guest_rpte & (HPTE_R_R|HPTE_R_C);
+			args[j] |= rcbits << (56 - 5);
+			__unlock_hpte(hp, 0);
+		}
+	}
+
+	return ret;
+}
+
 long __kvmppc_do_hash_protect(struct kvm *kvm, __be64 *hpte,
 			      unsigned long flags, unsigned long pte_index)
 {
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 3ca9c3fb3320..cc6ddf0cfa0c 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -2322,6 +2322,7 @@ hcall_real_table:
 	.space	((H_HASH_REMOVE - 4) - H_RANDOM), 0
 	.long	DOTSYM(kvmppc_h_hash_remove) - hcall_real_table
 	.long	DOTSYM(kvmppc_h_hash_protect) - hcall_real_table
+	.long	DOTSYM(kvmppc_h_hash_bulk_remove) - hcall_real_table
 	.globl	hcall_real_table_end
 hcall_real_table_end:
 
-- 
2.13.3

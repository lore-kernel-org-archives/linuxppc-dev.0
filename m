Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D081B6FA8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 01:26:36 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 03/37] KVM: PPC: factor out lpid allocator from
 book3s_64_mmu_hv
Date: Fri, 24 Feb 2012 15:25:57 +0100
Message-Id: <1330093591-19523-4-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-1-git-send-email-agraf@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

We'll use it on e500mc as well.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_book3s.h |    3 ++
 arch/powerpc/include/asm/kvm_booke.h  |    3 ++
 arch/powerpc/include/asm/kvm_ppc.h    |    5 ++++
 arch/powerpc/kvm/book3s_64_mmu_hv.c   |   26 +++++++++---------------
 arch/powerpc/kvm/powerpc.c            |   34 +++++++++++++++++++++++++++++++++
 5 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index aa795cc..046041f 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -452,4 +452,7 @@ static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
 
 #define INS_DCBZ			0x7c0007ec
 
+/* LPIDs we support with this build -- runtime limit may be lower */
+#define KVMPPC_NR_LPIDS			(LPID_RSVD + 1)
+
 #endif /* __ASM_KVM_BOOK3S_H__ */
diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
index a90e091..b7cd335 100644
--- a/arch/powerpc/include/asm/kvm_booke.h
+++ b/arch/powerpc/include/asm/kvm_booke.h
@@ -23,6 +23,9 @@
 #include <linux/types.h>
 #include <linux/kvm_host.h>
 
+/* LPIDs we support with this build -- runtime limit may be lower */
+#define KVMPPC_NR_LPIDS                        64
+
 static inline void kvmppc_set_gpr(struct kvm_vcpu *vcpu, int num, ulong val)
 {
 	vcpu->arch.gpr[num] = val;
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 9d6dee0..731e920 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -204,4 +204,9 @@ int kvm_vcpu_ioctl_config_tlb(struct kvm_vcpu *vcpu,
 int kvm_vcpu_ioctl_dirty_tlb(struct kvm_vcpu *vcpu,
 			     struct kvm_dirty_tlb *cfg);
 
+long kvmppc_alloc_lpid(void);
+void kvmppc_claim_lpid(long lpid);
+void kvmppc_free_lpid(long lpid);
+void kvmppc_init_lpid(unsigned long nr_lpids);
+
 #endif /* __POWERPC_KVM_PPC_H__ */
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index ddc485a..d031ce1 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -36,13 +36,11 @@
 
 /* POWER7 has 10-bit LPIDs, PPC970 has 6-bit LPIDs */
 #define MAX_LPID_970	63
-#define NR_LPIDS	(LPID_RSVD + 1)
-unsigned long lpid_inuse[BITS_TO_LONGS(NR_LPIDS)];
 
 long kvmppc_alloc_hpt(struct kvm *kvm)
 {
 	unsigned long hpt;
-	unsigned long lpid;
+	long lpid;
 	struct revmap_entry *rev;
 	struct kvmppc_linear_info *li;
 
@@ -72,14 +70,9 @@ long kvmppc_alloc_hpt(struct kvm *kvm)
 	}
 	kvm->arch.revmap = rev;
 
-	/* Allocate the guest's logical partition ID */
-	do {
-		lpid = find_first_zero_bit(lpid_inuse, NR_LPIDS);
-		if (lpid >= NR_LPIDS) {
-			pr_err("kvm_alloc_hpt: No LPIDs free\n");
-			goto out_freeboth;
-		}
-	} while (test_and_set_bit(lpid, lpid_inuse));
+	lpid = kvmppc_alloc_lpid();
+	if (lpid < 0)
+		goto out_freeboth;
 
 	kvm->arch.sdr1 = __pa(hpt) | (HPT_ORDER - 18);
 	kvm->arch.lpid = lpid;
@@ -96,7 +89,7 @@ long kvmppc_alloc_hpt(struct kvm *kvm)
 
 void kvmppc_free_hpt(struct kvm *kvm)
 {
-	clear_bit(kvm->arch.lpid, lpid_inuse);
+	kvmppc_free_lpid(kvm->arch.lpid);
 	vfree(kvm->arch.revmap);
 	if (kvm->arch.hpt_li)
 		kvm_release_hpt(kvm->arch.hpt_li);
@@ -171,8 +164,7 @@ int kvmppc_mmu_hv_init(void)
 	if (!cpu_has_feature(CPU_FTR_HVMODE))
 		return -EINVAL;
 
-	memset(lpid_inuse, 0, sizeof(lpid_inuse));
-
+	/* POWER7 has 10-bit LPIDs, PPC970 and e500mc have 6-bit LPIDs */
 	if (cpu_has_feature(CPU_FTR_ARCH_206)) {
 		host_lpid = mfspr(SPRN_LPID);	/* POWER7 */
 		rsvd_lpid = LPID_RSVD;
@@ -181,9 +173,11 @@ int kvmppc_mmu_hv_init(void)
 		rsvd_lpid = MAX_LPID_970;
 	}
 
-	set_bit(host_lpid, lpid_inuse);
+	kvmppc_init_lpid(rsvd_lpid + 1);
+
+	kvmppc_claim_lpid(host_lpid);
 	/* rsvd_lpid is reserved for use in partition switching */
-	set_bit(rsvd_lpid, lpid_inuse);
+	kvmppc_claim_lpid(rsvd_lpid);
 
 	return 0;
 }
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 00d7e34..9806ea5 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -808,6 +808,40 @@ out:
 	return r;
 }
 
+static unsigned long lpid_inuse[BITS_TO_LONGS(KVMPPC_NR_LPIDS)];
+static unsigned long nr_lpids;
+
+long kvmppc_alloc_lpid(void)
+{
+	long lpid;
+
+	do {
+		lpid = find_first_zero_bit(lpid_inuse, KVMPPC_NR_LPIDS);
+		if (lpid >= nr_lpids) {
+			pr_err("%s: No LPIDs free\n", __func__);
+			return -ENOMEM;
+		}
+	} while (test_and_set_bit(lpid, lpid_inuse));
+
+	return lpid;
+}
+
+void kvmppc_claim_lpid(long lpid)
+{
+	set_bit(lpid, lpid_inuse);
+}
+
+void kvmppc_free_lpid(long lpid)
+{
+	clear_bit(lpid, lpid_inuse);
+}
+
+void kvmppc_init_lpid(unsigned long nr_lpids_param)
+{
+	nr_lpids = min_t(unsigned long, KVMPPC_NR_LPIDS, nr_lpids_param);
+	memset(lpid_inuse, 0, sizeof(lpid_inuse));
+}
+
 int kvm_arch_init(void *opaque)
 {
 	return 0;
-- 
1.6.0.2

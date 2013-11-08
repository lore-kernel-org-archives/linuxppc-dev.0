Return-Path: <kernelfans@gmail.com>
Received: from mail-qa0-x232.google.com (mail-qa0-x232.google.com
 [IPv6:2607:f8b0:400d:c00::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 313582C03DA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 18:29:37 +1100 (EST)
Received: by mail-qa0-f50.google.com with SMTP id f11so1385940qae.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Nov 2013 23:29:32 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 2/2] powerpc: kvm: fix rare but potential deadlock scene
Date: Fri,  8 Nov 2013 15:29:54 +0800
Message-Id: <1383895794-16164-3-git-send-email-pingfank@linux.vnet.ibm.com>
In-Reply-To: <1383895794-16164-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1383895794-16164-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since kvmppc_hv_find_lock_hpte() is called from both virtmode and
realmode, so it can trigger the deadlock.

Suppose the following scene:

Two physical cpuM, cpuN, two VM instances A, B, each VM has a group of vcpus.

If on cpuM, vcpu_A_1 holds bitlock X (HPTE_V_HVLOCK), then is switched out,
and on cpuN, vcpu_A_2 try to lock X in realmode, then cpuN will be caught in
realmode for a long time.

What makes things even worse if the following happens,
  On cpuM, bitlockX is hold, on cpuN, Y is hold.
  vcpu_B_2 try to lock Y on cpuM in realmode
  vcpu_A_2 try to lock X on cpuN in realmode

Oops! deadlock happens

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |  4 ++--
 arch/powerpc/kvm/book3s_64_mmu_hv.c   |  5 +++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   | 20 ++++++++++++++++----
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index a818932..3d710ba 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -129,9 +129,9 @@ extern void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu);
 extern int kvmppc_book3s_hv_page_fault(struct kvm_run *run,
 			struct kvm_vcpu *vcpu, unsigned long addr,
 			unsigned long status);
-extern void kvmppc_hv_unlock_hpte(ulong *hptep, ulong *hpte_val);
+extern void kvmppc_hv_unlock_hpte(ulong *hptep, ulong *hpte_val, bool vmode);
 extern long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr,
-			unsigned long slb_v, unsigned long valid);
+			unsigned long slb_v, unsigned long valid, bool vmode);
 
 extern void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte);
 extern struct hpte_cache *kvmppc_mmu_hpte_cache_next(struct kvm_vcpu *vcpu);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 97685e7..12d9635 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -475,13 +475,14 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 
 	/* Find the HPTE in the hash table */
 	index = kvmppc_hv_find_lock_hpte(kvm, eaddr, slb_v,
-					 HPTE_V_VALID | HPTE_V_ABSENT);
+					 HPTE_V_VALID | HPTE_V_ABSENT,
+					 true);
 	if (index < 0)
 		return -ENOENT;
 	hptep = (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
 	v = hptep[0];
 	gr = kvm->arch.revmap[index].guest_rpte;
-	kvmppc_hv_unlock_hpte(hptep, &v);
+	kvmppc_hv_unlock_hpte(hptep, &v, true);
 
 	gpte->eaddr = eaddr;
 	gpte->vpage = ((v & HPTE_V_AVPN) << 4) | ((eaddr >> 12) & 0xfff);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 0ff9e91..18a9425 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -749,16 +749,22 @@ static int slb_base_page_shift[4] = {
 	20,	/* 1M, unsupported */
 };
 
-void kvmppc_hv_unlock_hpte(unsigned long *hptep, unsigned long *hpte_val)
+void kvmppc_hv_unlock_hpte(unsigned long *hptep, unsigned long *hpte_val,
+	bool vmode)
 {
 	*hpte_val = *hpte_val & ~HPTE_V_HVLOCK;
 	asm volatile("lwsync" : : : "memory");
 	*hptep = *hpte_val;
+	if (unlikely(vmode))
+		preempt_enable();
 }
 EXPORT_SYMBOL(kvmppc_hv_unlock_hpte);
 
+/* If called from virtmode and success to lock, then the context will be set
+ * as preemption disabled
+ */
 long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
-			      unsigned long valid)
+			      unsigned long valid, bool vmode)
 {
 	unsigned int i;
 	unsigned int pshift;
@@ -796,6 +802,9 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 		avpn &= ~0x7fUL;
 	val |= avpn;
 
+	if (unlikely(vmode))
+		preempt_disable();
+
 	for (;;) {
 		hpte = (unsigned long *)(kvm->arch.hpt_virt + (hash << 7));
 
@@ -833,6 +842,9 @@ long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 		val |= HPTE_V_SECONDARY;
 		hash = hash ^ kvm->arch.hpt_mask;
 	}
+
+	if (unlikely(vmode))
+		preempt_enable();
 	return -1;
 }
 EXPORT_SYMBOL(kvmppc_hv_find_lock_hpte);
@@ -864,7 +876,7 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 	if (status & DSISR_NOHPTE)
 		valid |= HPTE_V_ABSENT;
 
-	index = kvmppc_hv_find_lock_hpte(kvm, addr, slb_v, valid);
+	index = kvmppc_hv_find_lock_hpte(kvm, addr, slb_v, valid, false);
 	if (index < 0) {
 		if (status & DSISR_NOHPTE)
 			return status;	/* there really was no HPTE */
@@ -875,7 +887,7 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 	r = hpte[1];
 	rev = real_vmalloc_addr(&kvm->arch.revmap[index]);
 	gr = rev->guest_rpte;
-	kvmppc_hv_unlock_hpte(hpte, &v);
+	kvmppc_hv_unlock_hpte(hpte, &v, false);
 
 	/* For not found, if the HPTE is valid by now, retry the instruction */
 	if ((status & DSISR_NOHPTE) && (v & HPTE_V_VALID))
-- 
1.8.1.4

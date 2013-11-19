Return-Path: <kernelfans@gmail.com>
Received: from mail-ob0-x236.google.com (mail-ob0-x236.google.com
 [IPv6:2607:f8b0:4003:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A6092C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 17:12:07 +1100 (EST)
Received: by mail-ob0-f182.google.com with SMTP id wo20so3478791obc.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 22:12:03 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH RESEND v4] powerpc: kvm: fix rare but potential deadlock scene
Date: Tue, 19 Nov 2013 14:12:47 +0800
Message-Id: <1384841568-20986-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>,
 Paolo Bonzini <pbonzini@redhat.com>
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

Two physical cpuM, cpuN, two VM instances A, B, each VM has a group of
vcpus.

If on cpuM, vcpu_A_1 holds bitlock X (HPTE_V_HVLOCK), then is switched
out, and on cpuN, vcpu_A_2 try to lock X in realmode, then cpuN will be
caught in realmode for a long time.

What makes things even worse if the following happens,
  On cpuM, bitlockX is hold, on cpuN, Y is hold.
  vcpu_B_2 try to lock Y on cpuM in realmode
  vcpu_A_2 try to lock X on cpuN in realmode

Oops! deadlock happens

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 6 +++++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 842f081..abf81fe 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -473,11 +473,14 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 		slb_v = vcpu->kvm->arch.vrma_slb_v;
 	}
 
+	preempt_disable();
 	/* Find the HPTE in the hash table */
 	index = kvmppc_hv_find_lock_hpte(kvm, eaddr, slb_v,
 					 HPTE_V_VALID | HPTE_V_ABSENT);
-	if (index < 0)
+	if (index < 0) {
+		preempt_enable();
 		return -ENOENT;
+	}
 	hptep = (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
 	v = hptep[0] & ~HPTE_V_HVLOCK;
 	gr = kvm->arch.revmap[index].guest_rpte;
@@ -485,6 +488,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	/* Unlock the HPTE */
 	asm volatile("lwsync" : : : "memory");
 	hptep[0] = v;
+	preempt_enable();
 
 	gpte->eaddr = eaddr;
 	gpte->vpage = ((v & HPTE_V_AVPN) << 4) | ((eaddr >> 12) & 0xfff);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 9c51544..ea17b30 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -749,6 +749,10 @@ static int slb_base_page_shift[4] = {
 	20,	/* 1M, unsupported */
 };
 
+/* When called from virtmode, this func should be protected by
+ * preempt_disable(), otherwise, the holding of HPTE_V_HVLOCK
+ * can trigger deadlock issue.
+ */
 long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 			      unsigned long valid)
 {
-- 
1.8.1.4

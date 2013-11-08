Return-Path: <kernelfans@gmail.com>
Received: from mail-qc0-x22a.google.com (mail-qc0-x22a.google.com
 [IPv6:2607:f8b0:400d:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6EA912C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 18:29:28 +1100 (EST)
Received: by mail-qc0-f170.google.com with SMTP id n9so1419095qcw.15
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Nov 2013 23:29:23 -0800 (PST)
From: Liu Ping Fan <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 1/2] powerpc: kvm: pair kvmppc_hv_find_lock_hpte with
 _unlock_hpte
Date: Fri,  8 Nov 2013 15:29:53 +0800
Message-Id: <1383895794-16164-2-git-send-email-pingfank@linux.vnet.ibm.com>
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

Highlight the lock pair for the reader. (and later it will the
place to hide the detail about preemption disable)

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s.h |  1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c   |  7 ++-----
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   | 13 ++++++++++---
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index fa19e2f..a818932 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -129,6 +129,7 @@ extern void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu);
 extern int kvmppc_book3s_hv_page_fault(struct kvm_run *run,
 			struct kvm_vcpu *vcpu, unsigned long addr,
 			unsigned long status);
+extern void kvmppc_hv_unlock_hpte(ulong *hptep, ulong *hpte_val);
 extern long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr,
 			unsigned long slb_v, unsigned long valid);
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 842f081..97685e7 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -479,12 +479,9 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	if (index < 0)
 		return -ENOENT;
 	hptep = (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
-	v = hptep[0] & ~HPTE_V_HVLOCK;
+	v = hptep[0];
 	gr = kvm->arch.revmap[index].guest_rpte;
-
-	/* Unlock the HPTE */
-	asm volatile("lwsync" : : : "memory");
-	hptep[0] = v;
+	kvmppc_hv_unlock_hpte(hptep, &v);
 
 	gpte->eaddr = eaddr;
 	gpte->vpage = ((v & HPTE_V_AVPN) << 4) | ((eaddr >> 12) & 0xfff);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 9c51544..0ff9e91 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -749,6 +749,14 @@ static int slb_base_page_shift[4] = {
 	20,	/* 1M, unsupported */
 };
 
+void kvmppc_hv_unlock_hpte(unsigned long *hptep, unsigned long *hpte_val)
+{
+	*hpte_val = *hpte_val & ~HPTE_V_HVLOCK;
+	asm volatile("lwsync" : : : "memory");
+	*hptep = *hpte_val;
+}
+EXPORT_SYMBOL(kvmppc_hv_unlock_hpte);
+
 long kvmppc_hv_find_lock_hpte(struct kvm *kvm, gva_t eaddr, unsigned long slb_v,
 			      unsigned long valid)
 {
@@ -863,12 +871,11 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 		return 0;		/* for prot fault, HPTE disappeared */
 	}
 	hpte = (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
-	v = hpte[0] & ~HPTE_V_HVLOCK;
+	v = hpte[0];
 	r = hpte[1];
 	rev = real_vmalloc_addr(&kvm->arch.revmap[index]);
 	gr = rev->guest_rpte;
-
-	unlock_hpte(hpte, v);
+	kvmppc_hv_unlock_hpte(hpte, &v);
 
 	/* For not found, if the HPTE is valid by now, retry the instruction */
 	if ((status & DSISR_NOHPTE) && (v & HPTE_V_VALID))
-- 
1.8.1.4

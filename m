Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B490100907
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:13 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 14/27] KVM: PPC: Magic Page BookE support
Date: Thu,  1 Jul 2010 12:42:49 +0200
Message-Id: <1277980982-12433-15-git-send-email-agraf@suse.de>
In-Reply-To: <1277980982-12433-1-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As we now have Book3s support for the magic page, we also need BookE to
join in on the party.

This patch implements generic magic page logic for BookE and specific
TLB logic for e500. I didn't have any 440 around, so I didn't dare to
blindly try and write up broken code.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/booke.c    |   29 +++++++++++++++++++++++++++++
 arch/powerpc/kvm/e500_tlb.c |   19 +++++++++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 0f8ff9d..9609207 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -244,6 +244,31 @@ void kvmppc_core_deliver_interrupts(struct kvm_vcpu *vcpu)
 		vcpu->arch.shared->int_pending = 0;
 }
 
+/* Check if a DTLB miss was on the magic page. Returns !0 if so. */
+int kvmppc_dtlb_magic_page(struct kvm_vcpu *vcpu, ulong eaddr)
+{
+	ulong mp_ea = vcpu->arch.magic_page_ea;
+	ulong gpaddr = vcpu->arch.magic_page_pa;
+	int gtlb_index = 11 | (1 << 16); /* Random number in TLB1 */
+
+	/* Check for existence of magic page */
+	if(likely(!mp_ea))
+		return 0;
+
+	/* Check if we're on the magic page */
+	if(likely((eaddr >> 12) != (mp_ea >> 12)))
+		return 0;
+
+	/* Don't map in user mode */
+	if(vcpu->arch.shared->msr & MSR_PR)
+		return 0;
+
+	kvmppc_mmu_map(vcpu, vcpu->arch.magic_page_ea, gpaddr, gtlb_index);
+	kvmppc_account_exit(vcpu, DTLB_VIRT_MISS_EXITS);
+
+	return 1;
+}
+
 /**
  * kvmppc_handle_exit
  *
@@ -311,6 +336,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			r = RESUME_HOST;
 			break;
 		case EMULATE_FAIL:
+		case EMULATE_DO_MMIO:
 			/* XXX Deliver Program interrupt to guest. */
 			printk(KERN_CRIT "%s: emulation at %lx failed (%08x)\n",
 			       __func__, vcpu->arch.pc, vcpu->arch.last_inst);
@@ -380,6 +406,9 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		gpa_t gpaddr;
 		gfn_t gfn;
 
+		if (kvmppc_dtlb_magic_page(vcpu, eaddr))
+			break;
+
 		/* Check the guest TLB. */
 		gtlb_index = kvmppc_mmu_dtlb_index(vcpu, eaddr);
 		if (gtlb_index < 0) {
diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index 66845a5..f5582ca 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -295,9 +295,22 @@ static inline void kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	struct page *new_page;
 	struct tlbe *stlbe;
 	hpa_t hpaddr;
+	u32 mas2 = gtlbe->mas2;
+	u32 mas3 = gtlbe->mas3;
 
 	stlbe = &vcpu_e500->shadow_tlb[tlbsel][esel];
 
+	if ((vcpu_e500->vcpu.arch.magic_page_ea) &&
+	    ((vcpu_e500->vcpu.arch.magic_page_pa >> PAGE_SHIFT) == gfn) &&
+	    !(vcpu_e500->vcpu.arch.shared->msr & MSR_PR)) {
+		mas2 = 0;
+		mas3 = E500_TLB_SUPER_PERM_MASK;
+		hpaddr = virt_to_phys(vcpu_e500->vcpu.arch.shared);
+		new_page = pfn_to_page(hpaddr >> PAGE_SHIFT);
+		get_page(new_page);
+		goto mapped;
+	}
+
 	/* Get reference to new page. */
 	new_page = gfn_to_page(vcpu_e500->vcpu.kvm, gfn);
 	if (is_error_page(new_page)) {
@@ -305,6 +318,8 @@ static inline void kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 		kvm_release_page_clean(new_page);
 		return;
 	}
+
+mapped:
 	hpaddr = page_to_phys(new_page);
 
 	/* Drop reference to old page. */
@@ -316,10 +331,10 @@ static inline void kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 	stlbe->mas1 = MAS1_TSIZE(BOOK3E_PAGESZ_4K)
 		| MAS1_TID(get_tlb_tid(gtlbe)) | MAS1_TS | MAS1_VALID;
 	stlbe->mas2 = (gvaddr & MAS2_EPN)
-		| e500_shadow_mas2_attrib(gtlbe->mas2,
+		| e500_shadow_mas2_attrib(mas2,
 				vcpu_e500->vcpu.arch.shared->msr & MSR_PR);
 	stlbe->mas3 = (hpaddr & MAS3_RPN)
-		| e500_shadow_mas3_attrib(gtlbe->mas3,
+		| e500_shadow_mas3_attrib(mas3,
 				vcpu_e500->vcpu.arch.shared->msr & MSR_PR);
 	stlbe->mas7 = (hpaddr >> 32) & MAS7_RPN;
 
-- 
1.6.0.2

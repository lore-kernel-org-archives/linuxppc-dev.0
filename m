Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 21518B7094
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:07 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 13/27] KVM: PPC: Magic Page Book3s support
Date: Thu,  1 Jul 2010 12:42:48 +0200
Message-Id: <1277980982-12433-14-git-send-email-agraf@suse.de>
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

We need to override EA as well as PA lookups for the magic page. When the guest
tells us to project it, the magic page overrides any guest mappings.

In order to reflect that, we need to hook into all the MMU layers of KVM to
force map the magic page if necessary.

Signed-off-by: Alexander Graf <agraf@suse.de>

v1 -> v2:

  - RMO -> PAM
---
 arch/powerpc/kvm/book3s.c             |    7 +++++++
 arch/powerpc/kvm/book3s_32_mmu.c      |   16 ++++++++++++++++
 arch/powerpc/kvm/book3s_32_mmu_host.c |   12 ++++++++++++
 arch/powerpc/kvm/book3s_64_mmu.c      |   30 +++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_64_mmu_host.c |   12 ++++++++++++
 5 files changed, 76 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 14db032..b22e608 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -554,6 +554,13 @@ mmio:
 
 static int kvmppc_visible_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
+	ulong mp_pa = vcpu->arch.magic_page_pa;
+
+	if (unlikely(mp_pa) &&
+	    unlikely((mp_pa & KVM_RMO) >> PAGE_SHIFT == gfn)) {
+		return 1;
+	}
+
 	return kvm_is_visible_gfn(vcpu->kvm, gfn);
 }
 
diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index 41130c8..5bf4bf8 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -281,8 +281,24 @@ static int kvmppc_mmu_book3s_32_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 				      struct kvmppc_pte *pte, bool data)
 {
 	int r;
+	ulong mp_ea = vcpu->arch.magic_page_ea;
 
 	pte->eaddr = eaddr;
+
+	/* Magic page override */
+	if (unlikely(mp_ea) &&
+	    unlikely((eaddr & ~0xfffULL) == (mp_ea & ~0xfffULL)) &&
+	    !(vcpu->arch.shared->msr & MSR_PR)) {
+		pte->vpage = kvmppc_mmu_book3s_32_ea_to_vp(vcpu, eaddr, data);
+		pte->raddr = vcpu->arch.magic_page_pa | (pte->raddr & 0xfff);
+		pte->raddr &= KVM_PAM;
+		pte->may_execute = true;
+		pte->may_read = true;
+		pte->may_write = true;
+
+		return 0;
+	}
+
 	r = kvmppc_mmu_book3s_32_xlate_bat(vcpu, eaddr, pte, data);
 	if (r < 0)
 	       r = kvmppc_mmu_book3s_32_xlate_pte(vcpu, eaddr, pte, data, true);
diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 67b8c38..506d187 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -145,6 +145,16 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 	bool primary = false;
 	bool evict = false;
 	struct hpte_cache *pte;
+	ulong mp_pa = vcpu->arch.magic_page_pa;
+
+	/* Magic page override */
+	if (unlikely(mp_pa) &&
+	    unlikely((orig_pte->raddr & ~0xfffUL & KVM_PAM) ==
+		     (mp_pa & ~0xfffUL & KVM_PAM))) {
+		hpaddr = (pfn_t)virt_to_phys(vcpu->arch.shared);
+		get_page(pfn_to_page(hpaddr >> PAGE_SHIFT));
+		goto mapped;
+	}
 
 	/* Get host physical address for gpa */
 	hpaddr = gfn_to_pfn(vcpu->kvm, orig_pte->raddr >> PAGE_SHIFT);
@@ -155,6 +165,8 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 	}
 	hpaddr <<= PAGE_SHIFT;
 
+mapped:
+
 	/* and write the mapping ea -> hpa into the pt */
 	vcpu->arch.mmu.esid_to_vsid(vcpu, orig_pte->eaddr >> SID_SHIFT, &vsid);
 	map = find_sid_vsid(vcpu, vsid);
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 58aa840..d7889ef 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -163,6 +163,22 @@ static int kvmppc_mmu_book3s_64_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	bool found = false;
 	bool perm_err = false;
 	int second = 0;
+	ulong mp_ea = vcpu->arch.magic_page_ea;
+
+	/* Magic page override */
+	if (unlikely(mp_ea) &&
+	    unlikely((eaddr & ~0xfffULL) == (mp_ea & ~0xfffULL)) &&
+	    !(vcpu->arch.shared->msr & MSR_PR)) {
+		gpte->eaddr = eaddr;
+		gpte->vpage = kvmppc_mmu_book3s_64_ea_to_vp(vcpu, eaddr, data);
+		gpte->raddr = vcpu->arch.magic_page_pa | (gpte->raddr & 0xfff);
+		gpte->raddr &= KVM_PAM;
+		gpte->may_execute = true;
+		gpte->may_read = true;
+		gpte->may_write = true;
+
+		return 0;
+	}
 
 	slbe = kvmppc_mmu_book3s_64_find_slbe(vcpu_book3s, eaddr);
 	if (!slbe)
@@ -445,6 +461,7 @@ static int kvmppc_mmu_book3s_64_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 	ulong ea = esid << SID_SHIFT;
 	struct kvmppc_slb *slb;
 	u64 gvsid = esid;
+	ulong mp_ea = vcpu->arch.magic_page_ea;
 
 	if (vcpu->arch.shared->msr & (MSR_DR|MSR_IR)) {
 		slb = kvmppc_mmu_book3s_64_find_slbe(to_book3s(vcpu), ea);
@@ -464,7 +481,7 @@ static int kvmppc_mmu_book3s_64_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 		break;
 	case MSR_DR|MSR_IR:
 		if (!slb)
-			return -ENOENT;
+			goto no_slb;
 
 		*vsid = gvsid;
 		break;
@@ -477,6 +494,17 @@ static int kvmppc_mmu_book3s_64_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 		*vsid |= VSID_PR;
 
 	return 0;
+
+no_slb:
+	/* Catch magic page case */
+	if (unlikely(mp_ea) &&
+	    unlikely(esid == (mp_ea >> SID_SHIFT)) &&
+	    !(vcpu->arch.shared->msr & MSR_PR)) {
+		*vsid = VSID_REAL | esid;
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static bool kvmppc_mmu_book3s_64_is_dcbz32(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 71c1f90..d589b85 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -99,6 +99,16 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 	int vflags = 0;
 	int attempt = 0;
 	struct kvmppc_sid_map *map;
+	ulong mp_pa = vcpu->arch.magic_page_pa;
+
+	/* Magic page override */
+	if (unlikely(mp_pa) &&
+	    unlikely((orig_pte->raddr & ~0xfffULL & KVM_PAM) ==
+		     (mp_pa & ~0xfffULL & KVM_PAM))) {
+		hpaddr = (pfn_t)virt_to_phys(vcpu->arch.shared);
+		get_page(pfn_to_page(hpaddr >> PAGE_SHIFT));
+		goto mapped;
+	}
 
 	/* Get host physical address for gpa */
 	hpaddr = gfn_to_pfn(vcpu->kvm, orig_pte->raddr >> PAGE_SHIFT);
@@ -114,6 +124,8 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
 #error Unknown page size
 #endif
 
+mapped:
+
 	/* and write the mapping ea -> hpa into the pt */
 	vcpu->arch.mmu.esid_to_vsid(vcpu, orig_pte->eaddr >> SID_SHIFT, &vsid);
 	map = find_sid_vsid(vcpu, vsid);
-- 
1.6.0.2

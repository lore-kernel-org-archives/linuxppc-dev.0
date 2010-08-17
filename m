Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D764B7178
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:13 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 15/26] KVM: PPC: Interpret SR registers on demand
Date: Tue, 17 Aug 2010 15:57:50 +0200
Message-Id: <1282053481-18787-16-git-send-email-agraf@suse.de>
In-Reply-To: <1282053481-18787-1-git-send-email-agraf@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
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

Right now we're examining the contents of Book3s_32's segment registers when
the register is written and put the interpreted contents into a struct.

There are two reasons this is bad. For starters, the struct has worse real-time
performance, as it occupies more ram. But the more important part is that with
segment registers being interpreted from their raw values, we can put them in
the shared page, allowing guests to mess with them directly.

This patch makes the internal representation of SRs be u32s.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_book3s.h |   11 +----
 arch/powerpc/kvm/book3s.c             |    4 +-
 arch/powerpc/kvm/book3s_32_mmu.c      |   79 ++++++++++++++++++---------------
 3 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index f04f516..0884652 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -38,15 +38,6 @@ struct kvmppc_slb {
 	bool class	: 1;
 };
 
-struct kvmppc_sr {
-	u32 raw;
-	u32 vsid;
-	bool Ks		: 1;
-	bool Kp		: 1;
-	bool nx		: 1;
-	bool valid	: 1;
-};
-
 struct kvmppc_bat {
 	u64 raw;
 	u32 bepi;
@@ -79,7 +70,7 @@ struct kvmppc_vcpu_book3s {
 		u64 vsid;
 	} slb_shadow[64];
 	u8 slb_shadow_max;
-	struct kvmppc_sr sr[16];
+	u32 sr[16];
 	struct kvmppc_bat ibat[8];
 	struct kvmppc_bat dbat[8];
 	u64 hid[6];
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 3e017da..082ec62 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -1160,8 +1160,8 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 		}
 	} else {
 		for (i = 0; i < 16; i++) {
-			sregs->u.s.ppc32.sr[i] = vcpu3s->sr[i].raw;
-			sregs->u.s.ppc32.sr[i] = vcpu3s->sr[i].raw;
+			sregs->u.s.ppc32.sr[i] = vcpu3s->sr[i];
+			sregs->u.s.ppc32.sr[i] = vcpu3s->sr[i];
 		}
 		for (i = 0; i < 8; i++) {
 			sregs->u.s.ppc32.ibat[i] = vcpu3s->ibat[i].raw;
diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index 5bf4bf8..d4ff76f 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -58,14 +58,39 @@ static inline bool check_debug_ip(struct kvm_vcpu *vcpu)
 #endif
 }
 
+static inline u32 sr_vsid(u32 sr_raw)
+{
+	return sr_raw & 0x0fffffff;
+}
+
+static inline bool sr_valid(u32 sr_raw)
+{
+	return (sr_raw & 0x80000000) ? false : true;
+}
+
+static inline bool sr_ks(u32 sr_raw)
+{
+	return (sr_raw & 0x40000000) ? true: false;
+}
+
+static inline bool sr_kp(u32 sr_raw)
+{
+	return (sr_raw & 0x20000000) ? true: false;
+}
+
+static inline bool sr_nx(u32 sr_raw)
+{
+	return (sr_raw & 0x10000000) ? true: false;
+}
+
 static int kvmppc_mmu_book3s_32_xlate_bat(struct kvm_vcpu *vcpu, gva_t eaddr,
 					  struct kvmppc_pte *pte, bool data);
 static int kvmppc_mmu_book3s_32_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 					     u64 *vsid);
 
-static struct kvmppc_sr *find_sr(struct kvmppc_vcpu_book3s *vcpu_book3s, gva_t eaddr)
+static u32 find_sr(struct kvmppc_vcpu_book3s *vcpu_book3s, gva_t eaddr)
 {
-	return &vcpu_book3s->sr[(eaddr >> 28) & 0xf];
+	return vcpu_book3s->sr[(eaddr >> 28) & 0xf];
 }
 
 static u64 kvmppc_mmu_book3s_32_ea_to_vp(struct kvm_vcpu *vcpu, gva_t eaddr,
@@ -87,7 +112,7 @@ static void kvmppc_mmu_book3s_32_reset_msr(struct kvm_vcpu *vcpu)
 }
 
 static hva_t kvmppc_mmu_book3s_32_get_pteg(struct kvmppc_vcpu_book3s *vcpu_book3s,
-				      struct kvmppc_sr *sre, gva_t eaddr,
+				      u32 sre, gva_t eaddr,
 				      bool primary)
 {
 	u32 page, hash, pteg, htabmask;
@@ -96,7 +121,7 @@ static hva_t kvmppc_mmu_book3s_32_get_pteg(struct kvmppc_vcpu_book3s *vcpu_book3
 	page = (eaddr & 0x0FFFFFFF) >> 12;
 	htabmask = ((vcpu_book3s->sdr1 & 0x1FF) << 16) | 0xFFC0;
 
-	hash = ((sre->vsid ^ page) << 6);
+	hash = ((sr_vsid(sre) ^ page) << 6);
 	if (!primary)
 		hash = ~hash;
 	hash &= htabmask;
@@ -105,7 +130,7 @@ static hva_t kvmppc_mmu_book3s_32_get_pteg(struct kvmppc_vcpu_book3s *vcpu_book3
 
 	dprintk("MMU: pc=0x%lx eaddr=0x%lx sdr1=0x%llx pteg=0x%x vsid=0x%x\n",
 		kvmppc_get_pc(&vcpu_book3s->vcpu), eaddr, vcpu_book3s->sdr1, pteg,
-		sre->vsid);
+		sr_vsid(sre));
 
 	r = gfn_to_hva(vcpu_book3s->vcpu.kvm, pteg >> PAGE_SHIFT);
 	if (kvm_is_error_hva(r))
@@ -113,10 +138,9 @@ static hva_t kvmppc_mmu_book3s_32_get_pteg(struct kvmppc_vcpu_book3s *vcpu_book3
 	return r | (pteg & ~PAGE_MASK);
 }
 
-static u32 kvmppc_mmu_book3s_32_get_ptem(struct kvmppc_sr *sre, gva_t eaddr,
-				    bool primary)
+static u32 kvmppc_mmu_book3s_32_get_ptem(u32 sre, gva_t eaddr, bool primary)
 {
-	return ((eaddr & 0x0fffffff) >> 22) | (sre->vsid << 7) |
+	return ((eaddr & 0x0fffffff) >> 22) | (sr_vsid(sre) << 7) |
 	       (primary ? 0 : 0x40) | 0x80000000;
 }
 
@@ -180,7 +204,7 @@ static int kvmppc_mmu_book3s_32_xlate_pte(struct kvm_vcpu *vcpu, gva_t eaddr,
 				     bool primary)
 {
 	struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
-	struct kvmppc_sr *sre;
+	u32 sre;
 	hva_t ptegp;
 	u32 pteg[16];
 	u32 ptem = 0;
@@ -190,7 +214,7 @@ static int kvmppc_mmu_book3s_32_xlate_pte(struct kvm_vcpu *vcpu, gva_t eaddr,
 	sre = find_sr(vcpu_book3s, eaddr);
 
 	dprintk_pte("SR 0x%lx: vsid=0x%x, raw=0x%x\n", eaddr >> 28,
-		    sre->vsid, sre->raw);
+		    sr_vsid(sre), sre);
 
 	pte->vpage = kvmppc_mmu_book3s_32_ea_to_vp(vcpu, eaddr, data);
 
@@ -214,8 +238,8 @@ static int kvmppc_mmu_book3s_32_xlate_pte(struct kvm_vcpu *vcpu, gva_t eaddr,
 			pte->raddr = (pteg[i+1] & ~(0xFFFULL)) | (eaddr & 0xFFF);
 			pp = pteg[i+1] & 3;
 
-			if ((sre->Kp &&  (vcpu->arch.shared->msr & MSR_PR)) ||
-			    (sre->Ks && !(vcpu->arch.shared->msr & MSR_PR)))
+			if ((sr_kp(sre) &&  (vcpu->arch.shared->msr & MSR_PR)) ||
+			    (sr_ks(sre) && !(vcpu->arch.shared->msr & MSR_PR)))
 				pp |= 4;
 
 			pte->may_write = false;
@@ -311,30 +335,13 @@ static int kvmppc_mmu_book3s_32_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 
 static u32 kvmppc_mmu_book3s_32_mfsrin(struct kvm_vcpu *vcpu, u32 srnum)
 {
-	return to_book3s(vcpu)->sr[srnum].raw;
+	return to_book3s(vcpu)->sr[srnum];
 }
 
 static void kvmppc_mmu_book3s_32_mtsrin(struct kvm_vcpu *vcpu, u32 srnum,
 					ulong value)
 {
-	struct kvmppc_sr *sre;
-
-	sre = &to_book3s(vcpu)->sr[srnum];
-
-	/* Flush any left-over shadows from the previous SR */
-
-	/* XXX Not necessary? */
-	/* kvmppc_mmu_pte_flush(vcpu, ((u64)sre->vsid) << 28, 0xf0000000ULL); */
-
-	/* And then put in the new SR */
-	sre->raw = value;
-	sre->vsid = (value & 0x0fffffff);
-	sre->valid = (value & 0x80000000) ? false : true;
-	sre->Ks = (value & 0x40000000) ? true : false;
-	sre->Kp = (value & 0x20000000) ? true : false;
-	sre->nx = (value & 0x10000000) ? true : false;
-
-	/* Map the new segment */
+	to_book3s(vcpu)->sr[srnum] = value;
 	kvmppc_mmu_map_segment(vcpu, srnum << SID_SHIFT);
 }
 
@@ -347,13 +354,13 @@ static int kvmppc_mmu_book3s_32_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 					     u64 *vsid)
 {
 	ulong ea = esid << SID_SHIFT;
-	struct kvmppc_sr *sr;
+	u32 sr;
 	u64 gvsid = esid;
 
 	if (vcpu->arch.shared->msr & (MSR_DR|MSR_IR)) {
 		sr = find_sr(to_book3s(vcpu), ea);
-		if (sr->valid)
-			gvsid = sr->vsid;
+		if (sr_valid(sr))
+			gvsid = sr_vsid(sr);
 	}
 
 	/* In case we only have one of MSR_IR or MSR_DR set, let's put
@@ -370,8 +377,8 @@ static int kvmppc_mmu_book3s_32_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 		*vsid = VSID_REAL_DR | gvsid;
 		break;
 	case MSR_DR|MSR_IR:
-		if (sr->valid)
-			*vsid = sr->vsid;
+		if (sr_valid(sr))
+			*vsid = sr_vsid(sr);
 		else
 			*vsid = VSID_BAT | gvsid;
 		break;
-- 
1.6.0.2

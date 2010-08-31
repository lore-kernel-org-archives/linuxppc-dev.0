Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id AA7ABB7109
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:20 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 16/35] KVM: PPC: Put segment registers in shared page
Date: Tue, 31 Aug 2010 04:31:57 +0200
Message-Id: <1283221937-21006-17-git-send-email-agraf@suse.de>
In-Reply-To: <1283221937-21006-1-git-send-email-agraf@suse.de>
References: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that the actual mtsr doesn't do anything anymore, we can move the sr
contents over to the shared page, so a guest can directly read and write
its sr contents from guest context.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_book3s.h |    1 -
 arch/powerpc/include/asm/kvm_para.h   |    1 +
 arch/powerpc/kvm/book3s.c             |    7 +++----
 arch/powerpc/kvm/book3s_32_mmu.c      |   12 ++++++------
 arch/powerpc/kvm/powerpc.c            |    2 +-
 5 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 0884652..be8aac2 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -70,7 +70,6 @@ struct kvmppc_vcpu_book3s {
 		u64 vsid;
 	} slb_shadow[64];
 	u8 slb_shadow_max;
-	u32 sr[16];
 	struct kvmppc_bat ibat[8];
 	struct kvmppc_bat dbat[8];
 	u64 hid[6];
diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index 43c1b22..d79fd09 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -38,6 +38,7 @@ struct kvm_vcpu_arch_shared {
 	__u64 msr;
 	__u32 dsisr;
 	__u32 int_pending;	/* Tells the guest if we have an interrupt */
+	__u32 sr[16];
 };
 
 #define KVM_SC_MAGIC_R0		0x4b564d21 /* "KVM!" */
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 34472af..02a9cb1 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -1161,10 +1161,9 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 			sregs->u.s.ppc64.slb[i].slbv = vcpu3s->slb[i].origv;
 		}
 	} else {
-		for (i = 0; i < 16; i++) {
-			sregs->u.s.ppc32.sr[i] = vcpu3s->sr[i];
-			sregs->u.s.ppc32.sr[i] = vcpu3s->sr[i];
-		}
+		for (i = 0; i < 16; i++)
+			sregs->u.s.ppc32.sr[i] = vcpu->arch.shared->sr[i];
+
 		for (i = 0; i < 8; i++) {
 			sregs->u.s.ppc32.ibat[i] = vcpu3s->ibat[i].raw;
 			sregs->u.s.ppc32.dbat[i] = vcpu3s->dbat[i].raw;
diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index d4ff76f..c8cefdd 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -88,9 +88,9 @@ static int kvmppc_mmu_book3s_32_xlate_bat(struct kvm_vcpu *vcpu, gva_t eaddr,
 static int kvmppc_mmu_book3s_32_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 					     u64 *vsid);
 
-static u32 find_sr(struct kvmppc_vcpu_book3s *vcpu_book3s, gva_t eaddr)
+static u32 find_sr(struct kvm_vcpu *vcpu, gva_t eaddr)
 {
-	return vcpu_book3s->sr[(eaddr >> 28) & 0xf];
+	return vcpu->arch.shared->sr[(eaddr >> 28) & 0xf];
 }
 
 static u64 kvmppc_mmu_book3s_32_ea_to_vp(struct kvm_vcpu *vcpu, gva_t eaddr,
@@ -211,7 +211,7 @@ static int kvmppc_mmu_book3s_32_xlate_pte(struct kvm_vcpu *vcpu, gva_t eaddr,
 	int i;
 	int found = 0;
 
-	sre = find_sr(vcpu_book3s, eaddr);
+	sre = find_sr(vcpu, eaddr);
 
 	dprintk_pte("SR 0x%lx: vsid=0x%x, raw=0x%x\n", eaddr >> 28,
 		    sr_vsid(sre), sre);
@@ -335,13 +335,13 @@ static int kvmppc_mmu_book3s_32_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 
 static u32 kvmppc_mmu_book3s_32_mfsrin(struct kvm_vcpu *vcpu, u32 srnum)
 {
-	return to_book3s(vcpu)->sr[srnum];
+	return vcpu->arch.shared->sr[srnum];
 }
 
 static void kvmppc_mmu_book3s_32_mtsrin(struct kvm_vcpu *vcpu, u32 srnum,
 					ulong value)
 {
-	to_book3s(vcpu)->sr[srnum] = value;
+	vcpu->arch.shared->sr[srnum] = value;
 	kvmppc_mmu_map_segment(vcpu, srnum << SID_SHIFT);
 }
 
@@ -358,7 +358,7 @@ static int kvmppc_mmu_book3s_32_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 	u64 gvsid = esid;
 
 	if (vcpu->arch.shared->msr & (MSR_DR|MSR_IR)) {
-		sr = find_sr(to_book3s(vcpu), ea);
+		sr = find_sr(vcpu, ea);
 		if (sr_valid(sr))
 			gvsid = sr_vsid(sr);
 	}
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 496d7a5..028891c 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -66,7 +66,7 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
 		vcpu->arch.magic_page_pa = param1;
 		vcpu->arch.magic_page_ea = param2;
 
-		r2 = 0;
+		r2 = KVM_MAGIC_FEAT_SR;
 
 		r = HC_EV_SUCCESS;
 		break;
-- 
1.6.0.2

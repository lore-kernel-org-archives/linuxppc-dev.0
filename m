Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE5D92C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:14:24 +1100 (EST)
Received: from mail15-ch1 (localhost [127.0.0.1])	by mail15-ch1-R.bigfish.com
 (Postfix) with ESMTP id 7F555220124	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 11 Oct 2012 16:14:19 +0000 (UTC)
Received: from CH1EHSMHS017.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.254])	by mail15-ch1.bigfish.com (Postfix) with ESMTP id
 097C9160068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:18 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q9BGEBaQ028132	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:14:12 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 05/12] KVM: PPC: e500: Add emulation helper for getting
 instruction ea
Date: Thu, 11 Oct 2012 19:13:22 +0300
Message-ID: <1349972009-23027-6-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add emulation helper for getting instruction ea and refactor tlb instruction
emulation to use it.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v1: use _t_ype instead of _t_arget _r_egister in tlbilx emulation.

 arch/powerpc/include/asm/kvm_ppc.h |   11 +++++++++++
 arch/powerpc/kvm/e500.h            |    6 +++---
 arch/powerpc/kvm/e500_emulate.c    |   15 ++++++++++-----
 arch/powerpc/kvm/e500_tlb.c        |   33 +++++++++++----------------------
 4 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 609cca3..a08e756 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -293,4 +293,15 @@ static inline void kvmppc_lazy_ee_enable(void)
 #endif
 }
 
+static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int ra, int rb)
+{
+	ulong ea;
+
+	ea = kvmppc_get_gpr(vcpu, rb);
+	if (ra)
+		ea += kvmppc_get_gpr(vcpu, ra);
+
+	return ea;
+}
+
 #endif /* __POWERPC_KVM_PPC_H__ */
diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index d162286..32e98a7 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -129,9 +129,9 @@ int kvmppc_e500_emul_mt_mmucsr0(struct kvmppc_vcpu_e500 *vcpu_e500,
 				ulong value);
 int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu);
 int kvmppc_e500_emul_tlbre(struct kvm_vcpu *vcpu);
-int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, int ra, int rb);
-int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, int ra, int rb);
-int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, int rb);
+int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, gva_t ea);
+int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int type, gva_t ea);
+int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, gva_t ea);
 int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500);
 void kvmppc_e500_tlb_uninit(struct kvmppc_vcpu_e500 *vcpu_e500);
 
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index e04b0ef..3bf2486 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -88,7 +88,7 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	int emulated = EMULATE_DONE;
 	int ra = get_ra(inst);
 	int rb = get_rb(inst);
-	int rt = get_rt(inst);
+	gva_t ea;
 
 	switch (get_op(inst)) {
 	case 31:
@@ -113,15 +113,20 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			break;
 
 		case XOP_TLBSX:
-			emulated = kvmppc_e500_emul_tlbsx(vcpu,rb);
+			ea = kvmppc_get_ea_indexed(vcpu, ra, rb);
+			emulated = kvmppc_e500_emul_tlbsx(vcpu, ea);
 			break;
 
-		case XOP_TLBILX:
-			emulated = kvmppc_e500_emul_tlbilx(vcpu, rt, ra, rb);
+		case XOP_TLBILX: {
+			int t = (inst >> 21) & 0x3;
+			ea = kvmppc_get_ea_indexed(vcpu, ra, rb);
+			emulated = kvmppc_e500_emul_tlbilx(vcpu, t, ea);
 			break;
+		}
 
 		case XOP_TLBIVAX:
-			emulated = kvmppc_e500_emul_tlbivax(vcpu, ra, rb);
+			ea = kvmppc_get_ea_indexed(vcpu, ra, rb);
+			emulated = kvmppc_e500_emul_tlbivax(vcpu, ea);
 			break;
 
 		default:
diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index 23b3de6..b5a188a 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -689,14 +689,11 @@ int kvmppc_e500_emul_mt_mmucsr0(struct kvmppc_vcpu_e500 *vcpu_e500, ulong value)
 	return EMULATE_DONE;
 }
 
-int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, int ra, int rb)
+int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, gva_t ea)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 	unsigned int ia;
 	int esel, tlbsel;
-	gva_t ea;
-
-	ea = ((ra) ? kvmppc_get_gpr(vcpu, ra) : 0) + kvmppc_get_gpr(vcpu, rb);
 
 	ia = (ea >> 2) & 0x1;
 
@@ -723,7 +720,7 @@ int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, int ra, int rb)
 }
 
 static void tlbilx_all(struct kvmppc_vcpu_e500 *vcpu_e500, int tlbsel,
-		       int pid, int rt)
+		       int pid, int type)
 {
 	struct kvm_book3e_206_tlb_entry *tlbe;
 	int tid, esel;
@@ -732,7 +729,7 @@ static void tlbilx_all(struct kvmppc_vcpu_e500 *vcpu_e500, int tlbsel,
 	for (esel = 0; esel < vcpu_e500->gtlb_params[tlbsel].entries; esel++) {
 		tlbe = get_entry(vcpu_e500, tlbsel, esel);
 		tid = get_tlb_tid(tlbe);
-		if (rt == 0 || tid == pid) {
+		if (type == 0 || tid == pid) {
 			inval_gtlbe_on_host(vcpu_e500, tlbsel, esel);
 			kvmppc_e500_gtlbe_invalidate(vcpu_e500, tlbsel, esel);
 		}
@@ -740,14 +737,9 @@ static void tlbilx_all(struct kvmppc_vcpu_e500 *vcpu_e500, int tlbsel,
 }
 
 static void tlbilx_one(struct kvmppc_vcpu_e500 *vcpu_e500, int pid,
-		       int ra, int rb)
+		       gva_t ea)
 {
 	int tlbsel, esel;
-	gva_t ea;
-
-	ea = kvmppc_get_gpr(&vcpu_e500->vcpu, rb);
-	if (ra)
-		ea += kvmppc_get_gpr(&vcpu_e500->vcpu, ra);
 
 	for (tlbsel = 0; tlbsel < 2; tlbsel++) {
 		esel = kvmppc_e500_tlb_index(vcpu_e500, ea, tlbsel, pid, -1);
@@ -759,16 +751,16 @@ static void tlbilx_one(struct kvmppc_vcpu_e500 *vcpu_e500, int pid,
 	}
 }
 
-int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, int ra, int rb)
+int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int type, gva_t ea)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 	int pid = get_cur_spid(vcpu);
 
-	if (rt == 0 || rt == 1) {
-		tlbilx_all(vcpu_e500, 0, pid, rt);
-		tlbilx_all(vcpu_e500, 1, pid, rt);
-	} else if (rt == 3) {
-		tlbilx_one(vcpu_e500, pid, ra, rb);
+	if (type == 0 || type == 1) {
+		tlbilx_all(vcpu_e500, 0, pid, type);
+		tlbilx_all(vcpu_e500, 1, pid, type);
+	} else if (type == 3) {
+		tlbilx_one(vcpu_e500, pid, ea);
 	}
 
 	return EMULATE_DONE;
@@ -793,16 +785,13 @@ int kvmppc_e500_emul_tlbre(struct kvm_vcpu *vcpu)
 	return EMULATE_DONE;
 }
 
-int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, int rb)
+int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, gva_t ea)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 	int as = !!get_cur_sas(vcpu);
 	unsigned int pid = get_cur_spid(vcpu);
 	int esel, tlbsel;
 	struct kvm_book3e_206_tlb_entry *gtlbe = NULL;
-	gva_t ea;
-
-	ea = kvmppc_get_gpr(vcpu, rb);
 
 	for (tlbsel = 0; tlbsel < 2; tlbsel++) {
 		esel = kvmppc_e500_tlb_index(vcpu_e500, ea, tlbsel, pid, as);
-- 
1.7.4.1

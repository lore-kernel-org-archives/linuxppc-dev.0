Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2584B6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:50 +1000 (EST)
Received: from mail9-ch1 (localhost [127.0.0.1])	by mail9-ch1-R.bigfish.com
 (Postfix) with ESMTP id C36C840063	for <linuxppc-dev@lists.ozlabs.org>; Mon,
 25 Jun 2012 12:25:06 +0000 (UTC)
Received: from CH1EHSMHS007.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.248])	by mail9-ch1.bigfish.com (Postfix) with ESMTP id
 E31051A0047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:04 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQdFR003892	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:40 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 06/17] KVM: PPC: e500: Add emulation helper for getting
 instruction ea
Date: Mon, 25 Jun 2012 15:26:24 +0300
Message-ID: <1340627195-11544-7-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>
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
 arch/powerpc/kvm/e500.h         |    6 +++---
 arch/powerpc/kvm/e500_emulate.c |   21 ++++++++++++++++++---
 arch/powerpc/kvm/e500_tlb.c     |   23 ++++++-----------------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 3e31098..70bfed4 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -130,9 +130,9 @@ int kvmppc_e500_emul_mt_mmucsr0(struct kvmppc_vcpu_e500 *vcpu_e500,
 				ulong value);
 int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu);
 int kvmppc_e500_emul_tlbre(struct kvm_vcpu *vcpu);
-int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, int ra, int rb);
-int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, int ra, int rb);
-int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, int rb);
+int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, gva_t ea);
+int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, gva_t ea);
+int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, gva_t ea);
 int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500);
 void kvmppc_e500_tlb_uninit(struct kvmppc_vcpu_e500 *vcpu_e500);
 
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 8b99e07..81288f7 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -82,6 +82,17 @@ static int kvmppc_e500_emul_msgsnd(struct kvm_vcpu *vcpu, int rb)
 }
 #endif
 
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
 int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
                            unsigned int inst, int *advance)
 {
@@ -89,6 +100,7 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	int ra = get_ra(inst);
 	int rb = get_rb(inst);
 	int rt = get_rt(inst);
+	gva_t ea;
 
 	switch (get_op(inst)) {
 	case 31:
@@ -113,15 +125,18 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			break;
 
 		case XOP_TLBSX:
-			emulated = kvmppc_e500_emul_tlbsx(vcpu,rb);
+			ea = kvmppc_get_ea_indexed(vcpu, ra, rb);
+			emulated = kvmppc_e500_emul_tlbsx(vcpu, ea);
 			break;
 
 		case XOP_TLBILX:
-			emulated = kvmppc_e500_emul_tlbilx(vcpu, rt, ra, rb);
+			ea = kvmppc_get_ea_indexed(vcpu, ra, rb);
+			emulated = kvmppc_e500_emul_tlbilx(vcpu, rt, ea);
 			break;
 
 		case XOP_TLBIVAX:
-			emulated = kvmppc_e500_emul_tlbivax(vcpu, ra, rb);
+			ea = kvmppc_get_ea_indexed(vcpu, ra, rb);
+			emulated = kvmppc_e500_emul_tlbivax(vcpu, ea);
 			break;
 
 		default:
diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index c510fc9..2175a58 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008-2011 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (C) 2008-2012 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author: Yu Liu, yu.liu@freescale.com
  *         Scott Wood, scottwood@freescale.com
@@ -680,14 +680,11 @@ int kvmppc_e500_emul_mt_mmucsr0(struct kvmppc_vcpu_e500 *vcpu_e500, ulong value)
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
 
@@ -731,14 +728,9 @@ static void tlbilx_all(struct kvmppc_vcpu_e500 *vcpu_e500, int tlbsel,
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
@@ -750,7 +742,7 @@ static void tlbilx_one(struct kvmppc_vcpu_e500 *vcpu_e500, int pid,
 	}
 }
 
-int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, int ra, int rb)
+int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, gva_t ea)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
 	int pid = get_cur_spid(vcpu);
@@ -759,7 +751,7 @@ int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, int ra, int rb)
 		tlbilx_all(vcpu_e500, 0, pid, rt);
 		tlbilx_all(vcpu_e500, 1, pid, rt);
 	} else if (rt == 3) {
-		tlbilx_one(vcpu_e500, pid, ra, rb);
+		tlbilx_one(vcpu_e500, pid, ea);
 	}
 
 	return EMULATE_DONE;
@@ -784,16 +776,13 @@ int kvmppc_e500_emul_tlbre(struct kvm_vcpu *vcpu)
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

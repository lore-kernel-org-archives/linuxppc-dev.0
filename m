Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BA5E22C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 01:03:04 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 Nov 2013 19:33:01 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id EE7651258053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 19:33:47 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rABE2uP933030334
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 19:32:56 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rABE2xbK019249
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 19:32:59 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: book3s: kvm: Use the saved dsisr and dar values
Date: Mon, 11 Nov 2013 19:32:57 +0530
Message-Id: <1384178577-23721-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Don't try to compute these values.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---

NOTE: I am not sure why we were originally computing dsisr and dar. So may be
we need a variant of this patch. But with this and the additional patch
"powerpc: book3s: PR: Enable Little Endian PR guest" I am able to get a Little Endian
PR guest to boot.

 arch/powerpc/kvm/book3s_emulate.c | 64 ++-------------------------------------
 1 file changed, 2 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 99d40f8..62768f9 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -569,70 +569,10 @@ unprivileged:
 
 u32 kvmppc_alignment_dsisr(struct kvm_vcpu *vcpu, unsigned int inst)
 {
-	u32 dsisr = 0;
-
-	/*
-	 * This is what the spec says about DSISR bits (not mentioned = 0):
-	 *
-	 * 12:13		[DS]	Set to bits 30:31
-	 * 15:16		[X]	Set to bits 29:30
-	 * 17			[X]	Set to bit 25
-	 *			[D/DS]	Set to bit 5
-	 * 18:21		[X]	Set to bits 21:24
-	 *			[D/DS]	Set to bits 1:4
-	 * 22:26			Set to bits 6:10 (RT/RS/FRT/FRS)
-	 * 27:31			Set to bits 11:15 (RA)
-	 */
-
-	switch (get_op(inst)) {
-	/* D-form */
-	case OP_LFS:
-	case OP_LFD:
-	case OP_STFD:
-	case OP_STFS:
-		dsisr |= (inst >> 12) & 0x4000;	/* bit 17 */
-		dsisr |= (inst >> 17) & 0x3c00; /* bits 18:21 */
-		break;
-	/* X-form */
-	case 31:
-		dsisr |= (inst << 14) & 0x18000; /* bits 15:16 */
-		dsisr |= (inst << 8)  & 0x04000; /* bit 17 */
-		dsisr |= (inst << 3)  & 0x03c00; /* bits 18:21 */
-		break;
-	default:
-		printk(KERN_INFO "KVM: Unaligned instruction 0x%x\n", inst);
-		break;
-	}
-
-	dsisr |= (inst >> 16) & 0x03ff; /* bits 22:31 */
-
-	return dsisr;
+	return vcpu->arch.fault_dsisr;
 }
 
 ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
 {
-	ulong dar = 0;
-	ulong ra = get_ra(inst);
-	ulong rb = get_rb(inst);
-
-	switch (get_op(inst)) {
-	case OP_LFS:
-	case OP_LFD:
-	case OP_STFD:
-	case OP_STFS:
-		if (ra)
-			dar = kvmppc_get_gpr(vcpu, ra);
-		dar += (s32)((s16)inst);
-		break;
-	case 31:
-		if (ra)
-			dar = kvmppc_get_gpr(vcpu, ra);
-		dar += kvmppc_get_gpr(vcpu, rb);
-		break;
-	default:
-		printk(KERN_INFO "KVM: Unaligned instruction 0x%x\n", inst);
-		break;
-	}
-
-	return dar;
+	return vcpu->arch.fault_dar;
 }
-- 
1.8.3.2

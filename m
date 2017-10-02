Return-Path: <groug@kaod.org>
Received: from 16.mo1.mail-out.ovh.net (16.mo1.mail-out.ovh.net
 [178.33.104.224])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5GJZ06LszDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Oct 2017 19:57:32 +1100 (AEDT)
Received: from player756.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 59D759C17C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Oct 2017 10:40:32 +0200 (CEST)
Subject: [PATCH v2] KVM: PPC: Book3S PR: only install valid SLBs during
 KVM_SET_SREGS
From: Greg Kurz <groug@kaod.org>
To: kvm-ppc@vger.kernel.org
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Date: Mon, 02 Oct 2017 10:40:22 +0200
Message-ID: <150693362232.15210.2878817650741484831.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Userland passes an array of 64 SLB descriptors to KVM_SET_SREGS,
some of which are valid (ie, SLB_ESID_V is set) and the rest are
likely all-zeroes (with QEMU at least).

Each of them is then passed to kvmppc_mmu_book3s_64_slbmte(), which
assumes to find the SLB index in the 3 lower bits of its rb argument.
When passed zeroed arguments, it happily overwrites the 0th SLB entry
with zeroes. This is exactly what happens while doing live migration
with QEMU when the destination pushes the incoming SLB descriptors to
KVM PR. When reloading the SLBs at the next synchronization, QEMU first
clears its SLB array and only restore valid ones, but the 0th one is
now gone and we cannot access the corresponding memory anymore:

(qemu) x/x $pc
c0000000000b742c: Cannot access memory

To avoid this, let's filter out non-valid SLB entries. While here, we
also force a full SLB flush before installing new entries.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - flush SLB before installing new entries
---
 arch/powerpc/kvm/book3s_pr.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 3beb4ff469d1..7cce08d610ae 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1327,9 +1327,15 @@ static int kvm_arch_vcpu_ioctl_set_sregs_pr(struct kvm_vcpu *vcpu,
 
 	vcpu3s->sdr1 = sregs->u.s.sdr1;
 	if (vcpu->arch.hflags & BOOK3S_HFLAG_SLB) {
+		/* Flush all SLB entries */
+		vcpu->arch.mmu.slbmte(vcpu, 0, 0);
+		vcpu->arch.mmu.slbia(vcpu);
+
 		for (i = 0; i < 64; i++) {
-			vcpu->arch.mmu.slbmte(vcpu, sregs->u.s.ppc64.slb[i].slbv,
-						    sregs->u.s.ppc64.slb[i].slbe);
+			u64 rb = sregs->u.s.ppc64.slb[i].slbe;
+			u64 rs = sregs->u.s.ppc64.slb[i].slbv;
+			if (rb & SLB_ESID_V)
+				vcpu->arch.mmu.slbmte(vcpu, rs, rb);
 		}
 	} else {
 		for (i = 0; i < 16; i++) {

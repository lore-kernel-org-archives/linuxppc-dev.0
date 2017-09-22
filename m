Return-Path: <groug@kaod.org>
Received: from 7.mo173.mail-out.ovh.net (7.mo173.mail-out.ovh.net
 [46.105.44.159])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz9b86X3czDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 21:04:03 +1000 (AEST)
Received: from player687.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id C083B73762
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 11:34:43 +0200 (CEST)
Subject: [PATCH] KVM: PPC: Book3S PR: only call slbmte for valid SLB entries
From: Greg Kurz <groug@kaod.org>
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 qemu-ppc@nongnu.org
Date: Fri, 22 Sep 2017 11:34:29 +0200
Message-ID: <150607286967.26027.12529646475118424696.stgit@bahia.lan>
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

To avoid this, let's filter out non-valid SLB entries, like we
already do for Book3S HV.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 arch/powerpc/kvm/book3s_pr.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 3beb4ff469d1..cb6894e55f97 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1328,8 +1328,10 @@ static int kvm_arch_vcpu_ioctl_set_sregs_pr(struct kvm_vcpu *vcpu,
 	vcpu3s->sdr1 = sregs->u.s.sdr1;
 	if (vcpu->arch.hflags & BOOK3S_HFLAG_SLB) {
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

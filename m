Return-Path: <groug@kaod.org>
Received: from 12.mo4.mail-out.ovh.net (12.mo4.mail-out.ovh.net
 [178.33.104.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFvhj6WPZzDrFy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 21:29:56 +1100 (AEDT)
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 48D1AE8263
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 12:29:53 +0200 (CEST)
Subject: [PATCH v3] KVM: PPC: Book3S PR: only install valid SLBs during
 KVM_SET_SREGS
From: Greg Kurz <groug@kaod.org>
To: kvm-ppc@vger.kernel.org
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Date: Mon, 16 Oct 2017 12:29:44 +0200
Message-ID: <150814978410.4979.16857563162569877345.stgit@bahia.lan>
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
also force a full SLB flush before installing new entries. Since SLB
is for 64-bit only, we now build this path conditionally to avoid a
build break on 32-bit, which doesn't define SLB_ESID_V.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v3: - build SLB path for 64-bit only [*]
    - add blank line after declaration of rb and rs to silence checkpatch

v2: - flush SLB before installing new entries

[*] I'm wondering if other users of BOOK3S_HFLAG_SLB in this file
    shouldn't be conditionally built as well, for consistency.
---
 arch/powerpc/kvm/book3s_pr.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 3beb4ff469d1..68c1f8bc17c4 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1326,12 +1326,22 @@ static int kvm_arch_vcpu_ioctl_set_sregs_pr(struct kvm_vcpu *vcpu,
 	kvmppc_set_pvr_pr(vcpu, sregs->pvr);
 
 	vcpu3s->sdr1 = sregs->u.s.sdr1;
+#ifdef CONFIG_PPC_BOOK3S_64
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
+
+			if (rb & SLB_ESID_V)
+				vcpu->arch.mmu.slbmte(vcpu, rs, rb);
 		}
-	} else {
+	} else
+#endif
+	{
 		for (i = 0; i < 16; i++) {
 			vcpu->arch.mmu.mtsrin(vcpu, i, sregs->u.s.ppc32.sr[i]);
 		}

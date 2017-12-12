Return-Path: <clg@kaod.org>
Received: from 14.mo7.mail-out.ovh.net (14.mo7.mail-out.ovh.net
 [178.33.251.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywzPG0Xk1zDrcL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 23:18:09 +1100 (AEDT)
Received: from player697.ha.ovh.net (gw6.ovh.net [213.251.189.206])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 9C35C838B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 13:02:17 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] KVM: PPC: Book3S: fix XIVE migration of pending interrupts
Date: Tue, 12 Dec 2017 12:02:04 +0000
Message-Id: <20171212120204.6799-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When restoring a pending interrupt, we are setting the Q bit to force
a retrigger in xive_finish_unmask(). But we also need to force an EOI
in this case to reach the same initial state : P=1, Q=0.

This can be done by not setting 'old_p' for pending interrupts which
will inform xive_finish_unmask() that an EOI needs to be sent.

Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---

 Tested with a guest running iozone.

 arch/powerpc/kvm/book3s_xive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index bf457843e032..b5e6d227a034 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1558,7 +1558,7 @@ static int xive_set_source(struct kvmppc_xive *xive, long irq, u64 addr)
 
 	/*
 	 * Restore P and Q. If the interrupt was pending, we
-	 * force both P and Q, which will trigger a resend.
+	 * force Q and !P, which will trigger a resend.
 	 *
 	 * That means that a guest that had both an interrupt
 	 * pending (queued) and Q set will restore with only
@@ -1566,7 +1566,7 @@ static int xive_set_source(struct kvmppc_xive *xive, long irq, u64 addr)
 	 * is perfectly fine as coalescing interrupts that haven't
 	 * been presented yet is always allowed.
 	 */
-	if (val & KVM_XICS_PRESENTED || val & KVM_XICS_PENDING)
+	if (val & KVM_XICS_PRESENTED && !(val & KVM_XICS_PENDING))
 		state->old_p = true;
 	if (val & KVM_XICS_QUEUED || val & KVM_XICS_PENDING)
 		state->old_q = true;
-- 
2.13.6

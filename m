Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78236B6FD3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 03:57:08 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: <kvm-ppc@vger.kernel.org> <kvm-ppc@vger.kernel.org>
Subject: [PATCH 18/30] KVM: PPC: e500mc: Move r1/r2 restoration very early
Date: Fri, 17 Feb 2012 17:56:46 +0100
Message-Id: <1329497818-9729-19-git-send-email-agraf@suse.de>
In-Reply-To: <1329497818-9729-1-git-send-email-agraf@suse.de>
References: <1329497818-9729-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we hit any exception whatsoever in the restore path and r1/r2 aren't the
host registers, we don't get a working oops. So it's always a good idea to
restore them as early as possible.

This time, it actually has practical reasons to do so too, since we need to
have the host page fault handler fix up our guest instruction read code. And
for that to work we need r1/r2 restored.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/bookehv_interrupts.S |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 9eaeebd..63023ae 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -67,6 +67,12 @@
  * saved in vcpu: cr, ctr, r3-r13
  */
 .macro kvm_handler_common intno, srr0, flags
+	/* Restore host stack pointer */
+	PPC_STL	r1, VCPU_GPR(r1)(r4)
+	PPC_STL	r2, VCPU_GPR(r2)(r4)
+	PPC_LL	r1, VCPU_HOST_STACK(r4)
+	PPC_LL	r2, HOST_R2(r1)
+
 	mfspr	r10, SPRN_PID
 	lwz	r8, VCPU_HOST_PID(r4)
 	PPC_LL	r11, VCPU_SHARED(r4)
@@ -290,10 +296,8 @@ _GLOBAL(kvmppc_resume_host)
 	/* Save remaining volatile guest register state to vcpu. */
 	mfspr	r3, SPRN_VRSAVE
 	PPC_STL	r0, VCPU_GPR(r0)(r4)
-	PPC_STL	r1, VCPU_GPR(r1)(r4)
 	mflr	r5
 	mfspr	r6, SPRN_SPRG4
-	PPC_STL	r2, VCPU_GPR(r2)(r4)
 	PPC_STL	r5, VCPU_LR(r4)
 	mfspr	r7, SPRN_SPRG5
 	PPC_STL	r3, VCPU_VRSAVE(r4)
@@ -334,10 +338,6 @@ _GLOBAL(kvmppc_resume_host)
 	mtspr	SPRN_EPCR, r3
 	isync
 
-	/* Restore host stack pointer */
-	PPC_LL	r1, VCPU_HOST_STACK(r4)
-	PPC_LL	r2, HOST_R2(r1)
-
 	/* Switch to kernel stack and jump to handler. */
 	PPC_LL	r3, HOST_RUN(r1)
 	mr	r5, r14 /* intno */
-- 
1.6.0.2

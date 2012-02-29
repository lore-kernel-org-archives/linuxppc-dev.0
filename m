Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E6AFB6FF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 11:10:21 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 33/38] KVM: PPC: bookehv: remove unused code
Date: Wed, 29 Feb 2012 01:10:01 +0100
Message-Id: <1330474206-14794-34-git-send-email-agraf@suse.de>
In-Reply-To: <1330474206-14794-1-git-send-email-agraf@suse.de>
References: <1330474206-14794-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There was some unused code in the exit code path that must have been
a leftover from earlier iterations. While it did no harm, it's superfluous
and thus should be removed.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v2 -> v3:

  - fix commit message
  - also remove "lwz	r9, VCPU_KVM(r4)" which was as superfluous
---
 arch/powerpc/kvm/bookehv_interrupts.S |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 021d087..63fc5f0 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -91,10 +91,6 @@
 	PPC_STL	r9, VCPU_TIMING_EXIT_TBU(r4)
 #endif
 
-	.if	\flags & NEED_EMU
-	lwz	r9, VCPU_KVM(r4)
-	.endif
-
 	oris	r8, r6, MSR_CE@h
 #ifdef CONFIG_64BIT
 	std	r6, (VCPU_SHARED_MSR)(r11)
@@ -112,9 +108,6 @@
 	 * appropriate for the exception type).
 	 */
 	cmpw	r6, r8
-	.if	\flags & NEED_EMU
-	lwz	r9, KVM_LPID(r9)
-	.endif
 	beq	1f
 	mfmsr	r7
 	.if	\srr0 != SPRN_MCSRR0 && \srr0 != SPRN_CSRR0
-- 
1.6.0.2

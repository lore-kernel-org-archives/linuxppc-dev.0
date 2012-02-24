Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E429B7001
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 01:26:49 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 26/37] KVM: PPC: bookehv: fix exit timing
Date: Fri, 24 Feb 2012 15:26:20 +0100
Message-Id: <1330093591-19523-27-git-send-email-agraf@suse.de>
In-Reply-To: <1330093591-19523-1-git-send-email-agraf@suse.de>
References: <1330093591-19523-1-git-send-email-agraf@suse.de>
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

When using exit timing stats, we clobber r9 in the NEED_EMU case,
so better move that part down a few lines and fix it that way.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/bookehv_interrupts.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index f7dc3f6..215381e 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -83,10 +83,6 @@
 	stw	r10, VCPU_GUEST_PID(r4)
 	mtspr	SPRN_PID, r8
 
-	.if	\flags & NEED_EMU
-	lwz	r9, VCPU_KVM(r4)
-	.endif
-
 #ifdef CONFIG_KVM_EXIT_TIMING
 	/* save exit time */
 1:	mfspr	r7, SPRN_TBRU
@@ -98,6 +94,10 @@
 	PPC_STL	r9, VCPU_TIMING_EXIT_TBU(r4)
 #endif
 
+	.if	\flags & NEED_EMU
+	lwz	r9, VCPU_KVM(r4)
+	.endif
+
 	oris	r8, r6, MSR_CE@h
 #ifndef CONFIG_64BIT
 	stw	r6, (VCPU_SHARED_MSR + 4)(r11)
-- 
1.6.0.2

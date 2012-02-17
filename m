Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 009CD100839
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 04:14:12 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 26/30] KVM: PPC: bookehv: fix exit timing
Date: Fri, 17 Feb 2012 18:13:53 +0100
Message-Id: <1329498837-11717-27-git-send-email-agraf@suse.de>
In-Reply-To: <1329498837-11717-1-git-send-email-agraf@suse.de>
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
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
index e0f484c..9cf7ed7 100644
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

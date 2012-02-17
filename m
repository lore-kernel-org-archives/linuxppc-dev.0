Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0A3EF100803
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 04:14:12 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 29/30] KVM: PPC: bookehv: disable MAS register updates early
Date: Fri, 17 Feb 2012 18:13:56 +0100
Message-Id: <1329498837-11717-30-git-send-email-agraf@suse.de>
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

We need to make sure that no MAS updates happen automatically while we
have the guest MAS registers loaded. So move the disabling code a bit
higher up so that it covers the full time we have guest values in MAS
registers.

The race this patch fixes should never occur, but it makes the code a
bit more logical to do it this way around.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/bookehv_interrupts.S |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 8a297c3..7d558a8 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -358,6 +358,7 @@ _GLOBAL(kvmppc_resume_host)
 	mtspr	SPRN_MAS4, r6
 	stw	r5, VCPU_SHARED_MAS7_3+0(r11)
 	mtspr	SPRN_MAS6, r8
+	/* Enable MAS register updates via exception */
 	mfspr	r3, SPRN_EPCR
 	rlwinm	r3, r3, 0, ~SPRN_EPCR_DMIUH
 	mtspr	SPRN_EPCR, r3
@@ -515,6 +516,11 @@ lightweight_exit:
 	mtspr	SPRN_PID, r3
 
 	PPC_LL	r11, VCPU_SHARED(r4)
+	/* Disable MAS register updates via exception */
+	mfspr	r3, SPRN_EPCR
+	oris	r3, r3, SPRN_EPCR_DMIUH@h
+	mtspr	SPRN_EPCR, r3
+	isync
 	/* Save host mas4 and mas6 and load guest MAS registers */
 	mfspr	r3, SPRN_MAS4
 	stw	r3, VCPU_HOST_MAS4(r4)
@@ -538,10 +544,6 @@ lightweight_exit:
 	lwz	r5, VCPU_SHARED_MAS7_3+0(r11)
 	mtspr	SPRN_MAS6, r3
 	mtspr	SPRN_MAS7, r5
-	/* Disable MAS register updates via exception */
-	mfspr	r3, SPRN_EPCR
-	oris	r3, r3, SPRN_EPCR_DMIUH@h
-	mtspr	SPRN_EPCR, r3
 
 	/*
 	 * Host interrupt handlers may have clobbered these guest-readable
-- 
1.6.0.2

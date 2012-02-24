Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 489ADB7008
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2012 01:26:50 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 27/37] KVM: PPC: bookehv: remove negation for CONFIG_64BIT
Date: Fri, 24 Feb 2012 15:26:21 +0100
Message-Id: <1330093591-19523-28-git-send-email-agraf@suse.de>
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

Instead if doing

  #ifndef CONFIG_64BIT
  ...
  #else
  ...
  #endif

we should rather do

  #ifdef CONFIG_64BIT
  ...
  #else
  ...
  #endif

which is a lot easier to read. Change the bookehv implementation to
stick with this rule.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/bookehv_interrupts.S |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 215381e..c5a0796 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -99,10 +99,10 @@
 	.endif
 
 	oris	r8, r6, MSR_CE@h
-#ifndef CONFIG_64BIT
-	stw	r6, (VCPU_SHARED_MSR + 4)(r11)
-#else
+#ifdef CONFIG_64BIT
 	std	r6, (VCPU_SHARED_MSR)(r11)
+#else
+	stw	r6, (VCPU_SHARED_MSR + 4)(r11)
 #endif
 	ori	r8, r8, MSR_ME | MSR_RI
 	PPC_STL	r5, VCPU_PC(r4)
@@ -344,10 +344,10 @@ _GLOBAL(kvmppc_resume_host)
 	stw	r5, VCPU_SHARED_MAS0(r11)
 	mfspr	r7, SPRN_MAS2
 	stw	r6, VCPU_SHARED_MAS1(r11)
-#ifndef CONFIG_64BIT
-	stw	r7, (VCPU_SHARED_MAS2 + 4)(r11)
-#else
+#ifdef CONFIG_64BIT
 	std	r7, (VCPU_SHARED_MAS2)(r11)
+#else
+	stw	r7, (VCPU_SHARED_MAS2 + 4)(r11)
 #endif
 	mfspr	r5, SPRN_MAS3
 	mfspr	r6, SPRN_MAS4
@@ -530,10 +530,10 @@ lightweight_exit:
 	stw	r3, VCPU_HOST_MAS6(r4)
 	lwz	r3, VCPU_SHARED_MAS0(r11)
 	lwz	r5, VCPU_SHARED_MAS1(r11)
-#ifndef CONFIG_64BIT
-	lwz	r6, (VCPU_SHARED_MAS2 + 4)(r11)
-#else
+#ifdef CONFIG_64BIT
 	ld	r6, (VCPU_SHARED_MAS2)(r11)
+#else
+	lwz	r6, (VCPU_SHARED_MAS2 + 4)(r11)
 #endif
 	lwz	r7, VCPU_SHARED_MAS7_3+4(r11)
 	lwz	r8, VCPU_SHARED_MAS4(r11)
@@ -572,10 +572,10 @@ lightweight_exit:
 	PPC_LL	r6, VCPU_CTR(r4)
 	PPC_LL	r7, VCPU_CR(r4)
 	PPC_LL	r8, VCPU_PC(r4)
-#ifndef CONFIG_64BIT
-	lwz	r9, (VCPU_SHARED_MSR + 4)(r11)
-#else
+#ifdef CONFIG_64BIT
 	ld	r9, (VCPU_SHARED_MSR)(r11)
+#else
+	lwz	r9, (VCPU_SHARED_MSR + 4)(r11)
 #endif
 	PPC_LL	r0, VCPU_GPR(r0)(r4)
 	PPC_LL	r1, VCPU_GPR(r1)(r4)
-- 
1.6.0.2

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C07992C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:47 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 8 Oct 2013 02:48:44 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 56BD23578054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 03:48:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r97GmTb19830822
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:30 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r97GmeAA024919
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Oct 2013 03:48:40 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 07/14] kvm: powerpc: book3s: Cleanup interrupt handling
 code
Date: Mon,  7 Oct 2013 22:17:55 +0530
Message-Id: <1381164482-31001-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

With this patch if HV is included, interrupts come in to the HV version
of the kvmppc_interrupt code, which then jumps to the PR handler,
renamed to kvmppc_interrupt_pr, if the guest is a PR guest. This helps
in enabling both HV and PR, which we do in later patch

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h | 11 +++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  9 +++++++--
 arch/powerpc/kvm/book3s_segment.S        |  4 ++--
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index fe1c62d..76d326e 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -197,6 +197,17 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	cmpwi	r10,0;							\
 	bne	do_kvm_##n
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+/*
+ * If hv is possible, interrupts come into to the hv version
+ * of the kvmppc_interrupt code, which then jumps to the PR handler,
+ * kvmppc_interrupt_pr, if the guest is a PR guest.
+ */
+#define kvmppc_interrupt kvmppc_interrupt_hv
+#else
+#define kvmppc_interrupt kvmppc_interrupt_pr
+#endif
+
 #define __KVM_HANDLER(area, h, n)					\
 do_kvm_##n:								\
 	BEGIN_FTR_SECTION_NESTED(947)					\
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index f1f1bf3..55e4a01 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -734,8 +734,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 /*
  * We come here from the first-level interrupt handlers.
  */
-	.globl	kvmppc_interrupt
-kvmppc_interrupt:
+	.globl	kvmppc_interrupt_hv
+kvmppc_interrupt_hv:
 	/*
 	 * Register contents:
 	 * R12		= interrupt vector
@@ -749,6 +749,11 @@ kvmppc_interrupt:
 	lbz	r9, HSTATE_IN_GUEST(r13)
 	cmpwi	r9, KVM_GUEST_MODE_HOST_HV
 	beq	kvmppc_bad_host_intr
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
+	cmpwi	r9, KVM_GUEST_MODE_GUEST
+	ld	r9, HSTATE_HOST_R2(r13)
+	beq	kvmppc_interrupt_pr
+#endif
 	/* We're now back in the host but in guest MMU context */
 	li	r9, KVM_GUEST_MODE_HOST_HV
 	stb	r9, HSTATE_IN_GUEST(r13)
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index 1abe478..bc50c97 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -161,8 +161,8 @@ kvmppc_handler_trampoline_enter_end:
 .global kvmppc_handler_trampoline_exit
 kvmppc_handler_trampoline_exit:
 
-.global kvmppc_interrupt
-kvmppc_interrupt:
+.global kvmppc_interrupt_pr
+kvmppc_interrupt_pr:
 
 	/* Register usage at this point:
 	 *
-- 
1.8.1.2

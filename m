Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 382511A0299
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 18:14:22 +1000 (EST)
Date: Thu, 12 Jun 2014 18:14:20 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, agraf@suse.de, clg@fr.ibm.com
Subject: [PATCH 1/4] KVM: PPC: Book3S PR: Fix ABIv2 issues
Message-ID: <20140612181420.65b05675@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

binutils knows that a branch to a function descriptor is actually
a branch to the function text. By removing the explicit branch to
dot symbols, we maintain both ABIv1 and ABIv2 compatibility.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kvm/book3s_interrupts.S
===================================================================
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -25,11 +25,9 @@
 #include <asm/exception-64s.h>
 
 #if defined(CONFIG_PPC_BOOK3S_64)
-#define FUNC(name) 		GLUE(.,name)
 #define GET_SHADOW_VCPU(reg)    addi	reg, r13, PACA_SVCPU
 
 #elif defined(CONFIG_PPC_BOOK3S_32)
-#define FUNC(name)		name
 #define GET_SHADOW_VCPU(reg)	lwz     reg, (THREAD + THREAD_KVM_SVCPU)(r2)
 
 #endif /* CONFIG_PPC_BOOK3S_XX */
@@ -93,7 +91,7 @@ kvm_start_entry:
 kvm_start_lightweight:
 	/* Copy registers into shadow vcpu so we can access them in real mode */
 	GET_SHADOW_VCPU(r3)
-	bl	FUNC(kvmppc_copy_to_svcpu)
+	bl	kvmppc_copy_to_svcpu
 	nop
 	REST_GPR(4, r1)
 
@@ -131,7 +129,7 @@ after_sprg3_load:
 	PPC_LL	r4, VCPU_SHADOW_MSR(r4)	/* get shadow_msr */
 
 	/* Jump to segment patching handler and into our guest */
-	bl	FUNC(kvmppc_entry_trampoline)
+	bl	kvmppc_entry_trampoline
 	nop
 
 /*
@@ -164,7 +162,7 @@ after_sprg3_load:
 	/* On 64-bit, interrupts are still off at this point */
 
 	GET_SHADOW_VCPU(r4)
-	bl	FUNC(kvmppc_copy_from_svcpu)
+	bl	kvmppc_copy_from_svcpu
 	nop
 
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -203,7 +201,7 @@ after_sprg3_load:
 
 	/* Restore r3 (kvm_run) and r4 (vcpu) */
 	REST_2GPRS(3, r1)
-	bl	FUNC(kvmppc_handle_exit_pr)
+	bl	kvmppc_handle_exit_pr
 
 	/* If RESUME_GUEST, get back in the loop */
 	cmpwi	r3, RESUME_GUEST
Index: b/arch/powerpc/kvm/book3s_rmhandlers.S
===================================================================
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -34,13 +34,7 @@
  *                                                                           *
  ****************************************************************************/
 
-#if defined(CONFIG_PPC_BOOK3S_64)
-
-#define FUNC(name) 		GLUE(.,name)
-
-#elif defined(CONFIG_PPC_BOOK3S_32)
-
-#define FUNC(name)		name
+#ifdef CONFIG_PPC_BOOK3S_32
 
 .macro INTERRUPT_TRAMPOLINE intno
 

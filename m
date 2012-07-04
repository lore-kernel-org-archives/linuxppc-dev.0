Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 434C12C01FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 15:59:14 +1000 (EST)
Message-ID: <1341381547.16808.5.camel@pasglop>
Subject: [PATCH] powerpc: Move and fix MTMSR_EERI definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Wed, 04 Jul 2012 15:59:07 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move this duplicated definition to ppc_asm.h and remove the
braces which prevent the use of %rN register names

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Alex: This is needed to fix the build with Mikey's patch series
that enforce proper register name usage in assembly files.

I'm about to merge the whole lot in powerpc -next, possibly
tomorrow. I've pushed it all to my "test" branch on k.org for
now so I can still rebase.

Please check with whatever you have pending in your or avi's
-next as it's possible that there will be build breakage...

If there is and you can send me a fix, I will slip it in before
the patch that turns on the enforcement, so please have a look
at what I have in 'test' asap.


 arch/powerpc/include/asm/ppc_asm.h   |    2 ++
 arch/powerpc/kvm/book3s_rmhandlers.S |    1 -
 arch/powerpc/kvm/book3s_segment.S    |    2 --
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 2c7edd5..d4c589b 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -475,6 +475,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #ifdef CONFIG_PPC_BOOK3S_64
 #define RFI		rfid
 #define MTMSRD(r)	mtmsrd	r
+#define MTMSR_EERI(reg)	mtmsrd	reg,1
 #else
 #define FIX_SRR1(ra, rb)
 #ifndef CONFIG_40x
@@ -483,6 +484,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define RFI		rfi; b .	/* Prevent prefetch past rfi */
 #endif
 #define MTMSRD(r)	mtmsr	r
+#define MTMSR_EERI(reg)	mtmsr	reg
 #define CLR_TOP32(r)
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
index 3418758..ab523f3 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -37,7 +37,6 @@
 #if defined(CONFIG_PPC_BOOK3S_64)
 
 #define FUNC(name) 		GLUE(.,name)
-#define MTMSR_EERI(reg)		mtmsrd	(reg),1
 
 	.globl	kvmppc_skip_interrupt
 kvmppc_skip_interrupt:
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index 798491a..1abe478 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -23,7 +23,6 @@
 
 #define GET_SHADOW_VCPU(reg)    \
 	mr	reg, r13
-#define MTMSR_EERI(reg)		mtmsrd	(reg),1
 
 #elif defined(CONFIG_PPC_BOOK3S_32)
 
@@ -31,7 +30,6 @@
 	tophys(reg, r2);       			\
 	lwz     reg, (THREAD + THREAD_KVM_SVCPU)(reg);	\
 	tophys(reg, reg)
-#define MTMSR_EERI(reg)		mtmsr	(reg)
 
 #endif
 

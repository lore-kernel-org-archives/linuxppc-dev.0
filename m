Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 21 Jun 2012 12:04:35 +1000
Subject: [PATCH 8/18] powerpc: merge VCPU_GPR
In-Reply-To: <1340244266.960241.475925824909.qpush@ale>
Message-Id: <20120621020435.3FEE3D431D9@localhost.localdomain>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org, schwab@linux-m68k.org,
 Anton Blanchard <anton@samba.org>, Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge the defines of VCPU_GPR from different places.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc_asm.h      |    7 +++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    3 ---
 arch/powerpc/kvm/book3s_interrupts.S    |    8 --------
 arch/powerpc/kvm/booke_interrupts.S     |    2 --
 arch/powerpc/kvm/bookehv_interrupts.S   |    1 -
 5 files changed, 7 insertions(+), 14 deletions(-)

Index: powerpc-test/arch/powerpc/include/asm/ppc_asm.h
===================================================================
--- powerpc-test.orig/arch/powerpc/include/asm/ppc_asm.h
+++ powerpc-test/arch/powerpc/include/asm/ppc_asm.h
@@ -178,6 +178,13 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLP
 #define HMT_HIGH	or	3,3,3
 #define HMT_EXTRA_HIGH	or	7,7,7		# power7 only
 
+#ifdef CONFIG_PPC64
+#define ULONG_SIZE 	8
+#else
+#define ULONG_SIZE	4
+#endif
+#define VCPU_GPR(n)	(VCPU_GPRS + (n * ULONG_SIZE))
+
 #ifdef __KERNEL__
 #ifdef CONFIG_PPC64
 
Index: powerpc-test/arch/powerpc/kvm/book3s_hv_rmhandlers.S
===================================================================
--- powerpc-test.orig/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ powerpc-test/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -72,9 +72,6 @@ _GLOBAL(kvmppc_hv_entry_trampoline)
 	mtsrr1	r6
 	RFI
 
-#define ULONG_SIZE 		8
-#define VCPU_GPR(n)		(VCPU_GPRS + (n * ULONG_SIZE))
-
 /******************************************************************************
  *                                                                            *
  *                               Entry code                                   *
Index: powerpc-test/arch/powerpc/kvm/book3s_interrupts.S
===================================================================
--- powerpc-test.orig/arch/powerpc/kvm/book3s_interrupts.S
+++ powerpc-test/arch/powerpc/kvm/book3s_interrupts.S
@@ -25,19 +25,11 @@
 #include <asm/exception-64s.h>
 
 #if defined(CONFIG_PPC_BOOK3S_64)
-
-#define ULONG_SIZE 		8
 #define FUNC(name) 		GLUE(.,name)
-
 #elif defined(CONFIG_PPC_BOOK3S_32)
-
-#define ULONG_SIZE              4
 #define FUNC(name)		name
-
 #endif /* CONFIG_PPC_BOOK3S_XX */
 
-
-#define VCPU_GPR(n)		(VCPU_GPRS + (n * ULONG_SIZE))
 #define VCPU_LOAD_NVGPRS(vcpu) \
 	PPC_LL	r14, VCPU_GPR(R14)(vcpu); \
 	PPC_LL	r15, VCPU_GPR(R15)(vcpu); \
Index: powerpc-test/arch/powerpc/kvm/booke_interrupts.S
===================================================================
--- powerpc-test.orig/arch/powerpc/kvm/booke_interrupts.S
+++ powerpc-test/arch/powerpc/kvm/booke_interrupts.S
@@ -25,8 +25,6 @@
 #include <asm/page.h>
 #include <asm/asm-offsets.h>
 
-#define VCPU_GPR(n)     (VCPU_GPRS + (n * 4))
-
 /* The host stack layout: */
 #define HOST_R1         0 /* Implied by stwu. */
 #define HOST_CALLEE_LR  4
Index: powerpc-test/arch/powerpc/kvm/bookehv_interrupts.S
===================================================================
--- powerpc-test.orig/arch/powerpc/kvm/bookehv_interrupts.S
+++ powerpc-test/arch/powerpc/kvm/bookehv_interrupts.S
@@ -37,7 +37,6 @@
 
 #define LONGBYTES		(BITS_PER_LONG / 8)
 
-#define VCPU_GPR(n)     	(VCPU_GPRS + (n * LONGBYTES))
 #define VCPU_GUEST_SPRG(n)	(VCPU_GUEST_SPRGS + (n * LONGBYTES))
 
 /* The host stack layout: */

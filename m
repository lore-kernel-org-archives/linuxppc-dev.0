Return-Path: <paulus@ozlabs.org>
Date: Tue, 16 Apr 2013 16:28:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix build errors with UP configs in HV-style KVM
Message-ID: <20130416062801.GB27197@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes these errors when building UP with CONFIG_KVM_BOOK3S_64_HV=y:

arch/powerpc/kvm/book3s_hv.c:1855:2: error: implicit declaration of function 'inhibit_secondary_onlining' [-Werror=implicit-function-declaration]
arch/powerpc/kvm/book3s_hv.c:1862:2: error: implicit declaration of function 'uninhibit_secondary_onlining' [-Werror=implicit-function-declaration]
cc1: all warnings being treated as errors

and this error (with CONFIG_KVM_BOOK3S_64=m, or a vmlinux link error
with CONFIG_KVM_BOOK3S_64=y):

ERROR: "smp_send_reschedule" [arch/powerpc/kvm/kvm.ko] undefined!
make[2]: *** [__modpost] Error 1

The fix for the link error is suboptimal; ideally we want a self_ipi()
function from irq.c, connected at least to the MPIC code, to initiate
an IPI to this cpu.  The fix here at least lets the code build, and it
will work, just with interrupts being delayed sometimes.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/smp.h          |    2 ++
 arch/powerpc/kvm/book3s_hv_interrupts.S |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 195ce2a..ffbaabe 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -143,6 +143,8 @@ extern void __cpu_die(unsigned int cpu);
 /* for UP */
 #define hard_smp_processor_id()		get_hard_smp_processor_id(0)
 #define smp_setup_cpu_maps()
+static inline void inhibit_secondary_onlining(void) {}
+static inline void uninhibit_secondary_onlining(void) {}
 
 #endif /* CONFIG_SMP */
 
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index 84035a5..37f1cc4 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -122,11 +122,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	add	r8,r8,r7
 	std	r8,HSTATE_DECEXP(r13)
 
+#ifdef CONFIG_SMP
 	/*
 	 * On PPC970, if the guest vcpu has an external interrupt pending,
 	 * send ourselves an IPI so as to interrupt the guest once it
 	 * enables interrupts.  (It must have interrupts disabled,
 	 * otherwise we would already have delivered the interrupt.)
+	 *
+	 * XXX If this is a UP build, smp_send_reschedule is not available,
+	 * so the interrupt will be delayed until the next time the vcpu
+	 * enters the guest with interrupts enabled.
 	 */
 BEGIN_FTR_SECTION
 	ld	r0, VCPU_PENDING_EXC(r4)
@@ -141,6 +146,7 @@ BEGIN_FTR_SECTION
 	mr	r4, r31
 32:
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
+#endif /* CONFIG_SMP */
 
 	/* Jump to partition switch code */
 	bl	.kvmppc_hv_entry_trampoline
-- 
1.7.10.4

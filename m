Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C4C3C1A0B55
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:41:32 +1100 (AEDT)
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EB354140317
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:41:31 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:41:30 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 30B141FF0027
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:29:37 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIfRHC38469794
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:27 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIfNYH018369
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:41:27 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 08/14] KVM: PPC: Book3S HV: Complete passthrough interrupt in
 host
Date: Fri, 26 Feb 2016 12:40:26 -0600
Message-Id: <1456512032-31286-9-git-send-email-warrier@linux.vnet.ibm.com>
In-Reply-To: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
References: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In existing real mode ICP code, when updating the virtual ICP
state, if there is a required action that cannot be completely
handled in real mode, as for instance, a VCPU needs to be woken
up, flags are set in the ICP to indicate the required action.
This is checked when returning from hypercalls to decide whether
the call needs switch back to the host where the action can be
performed in virtual mode. Note that if h_ipi_redirect is enabled,
real mode code will first try to message a free host CPU to
complete this job instead of returning the host to do it ourselves.

Currently, the real mode PCI passthrough interrupt handling code
checks if any of these flags are set and simply returns to the host.
This is not good enough as the trap value (0x500) is treated as an
external interrupt by the host code. It is only when the trap value
is a hypercall that the host code searches for and acts on unfinished
work by calling kvmppc_xics_rm_complete.

This patch introduces a special trap BOOK3S_INTERRUPT_HV_RM_HARD
which is returned by KVM if there is unfinished business to be
completed in host virtual mode after handling a PCI passthrough
interrupt. The host checks for this special interrupt condition
and calls into the kvmppc_xics_rm_complete, which is made an
exported function for this reason.

Signed-off-by: Suresh Warrier <warrier@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_asm.h      | 10 ++++++++++
 arch/powerpc/include/asm/kvm_ppc.h      |  3 +++
 arch/powerpc/kvm/book3s_hv.c            |  8 +++++++-
 arch/powerpc/kvm/book3s_hv_builtin.c    |  1 +
 arch/powerpc/kvm/book3s_hv_rm_xics.c    |  2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 26 ++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_xics.c          |  3 ++-
 7 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index 5bca220..05cabed 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -105,6 +105,15 @@
 #define BOOK3S_INTERRUPT_FAC_UNAVAIL	0xf60
 #define BOOK3S_INTERRUPT_H_FAC_UNAVAIL	0xf80
 
+/* book3s_hv */
+
+/*
+ * Special trap used to indicate to host that this is a
+ * passthrough interrupt that could not be handled
+ * completely in the guest.
+ */
+#define BOOK3S_INTERRUPT_HV_RM_HARD	0x5555
+
 #define BOOK3S_IRQPRIO_SYSTEM_RESET		0
 #define BOOK3S_IRQPRIO_DATA_SEGMENT		1
 #define BOOK3S_IRQPRIO_INST_SEGMENT		2
@@ -136,6 +145,7 @@
 #define RESUME_FLAG_NV          (1<<0)  /* Reload guest nonvolatile state? */
 #define RESUME_FLAG_HOST        (1<<1)  /* Resume host? */
 #define RESUME_FLAG_ARCH1	(1<<2)
+#define RESUME_FLAG_ARCH2	(1<<3)
 
 #define RESUME_GUEST            0
 #define RESUME_GUEST_NV         RESUME_FLAG_NV
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index c5c7386..b19bb30 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -474,6 +474,7 @@ static inline struct kvmppc_passthru_irqmap *kvmppc_get_passthru_irqmap(
 extern void kvmppc_alloc_host_rm_ops(void);
 extern void kvmppc_free_host_rm_ops(void);
 extern void kvmppc_free_pimap(struct kvm *kvm);
+extern int kvmppc_xics_rm_complete(struct kvm_vcpu *vcpu, u32 hcall);
 extern void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu);
 extern int kvmppc_xics_create_icp(struct kvm_vcpu *vcpu, unsigned long server);
 extern int kvm_vm_ioctl_xics_irq(struct kvm *kvm, struct kvm_irq_level *args);
@@ -491,6 +492,8 @@ static inline struct kvmppc_passthru_irqmap *kvmppc_get_passthru_irqmap(
 static inline void kvmppc_alloc_host_rm_ops(void) {};
 static inline void kvmppc_free_host_rm_ops(void) {};
 static inline void kvmppc_free_pimap(struct kvm *kvm) {};
+static inline int kvmppc_xics_rm_complete(struct kvm_vcpu *vcpu, u32 hcall)
+	{ return 0; }
 static inline int kvmppc_xics_enabled(struct kvm_vcpu *vcpu)
 	{ return 0; }
 static inline void kvmppc_xics_free_icp(struct kvm_vcpu *vcpu) { }
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8504a5d..cc5aea96 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -70,6 +70,8 @@
 
 /* Used to indicate that a guest page fault needs to be handled */
 #define RESUME_PAGE_FAULT	(RESUME_GUEST | RESUME_FLAG_ARCH1)
+/* Used to indicate that a guest passthrough interrupt needs to be handled */
+#define RESUME_PASSTHROUGH	(RESUME_GUEST | RESUME_FLAG_ARCH2)
 
 /* Used as a "null" value for timebase values */
 #define TB_NIL	(~(u64)0)
@@ -991,6 +993,9 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
 		r = RESUME_GUEST;
 		break;
+	case BOOK3S_INTERRUPT_HV_RM_HARD:
+		r = RESUME_PASSTHROUGH;
+		break;
 	default:
 		kvmppc_dump_regs(vcpu);
 		printk(KERN_EMERG "trap=0x%x | pc=0x%lx | msr=0x%llx\n",
@@ -2819,7 +2824,8 @@ static int kvmppc_vcpu_run_hv(struct kvm_run *run, struct kvm_vcpu *vcpu)
 			r = kvmppc_book3s_hv_page_fault(run, vcpu,
 				vcpu->arch.fault_dar, vcpu->arch.fault_dsisr);
 			srcu_read_unlock(&vcpu->kvm->srcu, srcu_idx);
-		}
+		} else if (r == RESUME_PASSTHROUGH)
+			r = kvmppc_xics_rm_complete(vcpu, 0);
 	} while (is_kvmppc_resume_guest(r));
 
  out:
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 403fb50..62252da 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -332,6 +332,7 @@ static struct kvmppc_irq_map *get_irqmap(struct kvmppc_passthru_irqmap *pimap,
  * Returns:
  *	0 if no interrupt is pending
  *	1 if an interrupt is pending that needs to be handled by the host
+ *	2 Passthrough that needs completion in the host
  *	-1 if there was a guest wakeup IPI (which has now been cleared)
  *	-2 if there is PCI passthrough external interrupt that was handled
  */
diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
index 1089bfa..8390c50 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
@@ -751,7 +751,7 @@ long kvmppc_deliver_irq_passthru(struct kvm_vcpu *vcpu,
 	icp_eoi(pimap->irq_chip, irq_map->r_hwirq, xirr);
 
 	if (check_too_hard(xics, icp) == H_TOO_HARD)
-		return 1;
+		return 2;
 	else
 		return -2;
 }
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 5e12cb4e..5b62f95 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1274,6 +1274,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	 *   1 An interrupt is pending that needs to be handled by the host
 	 *     Exit guest and return to host by branching to guest_exit_cont
 	 *
+	 *   2 Passthrough that needs completion in the host
+	 *     Exit guest and return to host by branching to guest_exit_cont
+	 *     However, we also set r12 to BOOK3S_INTERRUPT_HV_RM_HARD
+	 *     to indicate to the host to complete handling the interrupt
+	 *
 	 * Before returning to guest, we check if any CPU is heading out
 	 * to the host and if so, we head out also. If no CPUs are heading
 	 * check return values <= 0.
@@ -1295,6 +1300,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	 *    made an OPAL call to EOI the interrupt which scratches them.
 	 */
 
+	cmpdi	r3, 1
+	ble	1f
+
+	/* Return code = 2 */
+	li	r12, BOOK3S_INTERRUPT_HV_RM_HARD
+	stw	r12, VCPU_TRAP(r9)
+	b	guest_exit_cont
+
+1:
+	/* Return code <= 1 */
 	cmpdi	r3, 0
 	bgt	guest_exit_cont
 
@@ -2412,6 +2427,17 @@ kvm_end_cede:
 	 * should not modify r3 until this check is done.
 	 */
 	ld	r4, HSTATE_KVM_VCPU(r13)
+	cmpdi	r3, 1
+	ble	1f
+
+	/*
+	 * Return code of 2 means PCI passthrough interrupt, but
+	 * we need to return back to host to complete handling the
+	 * interrupt. Trap reason is expected in r12 by guest
+	 * exit code.
+	 */
+	li	r31, BOOK3S_INTERRUPT_HV_RM_HARD
+1:
 	mr	r12, r31
 
 	/* Load NV GPRS */
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index 905e94a..be23f88 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -812,7 +812,7 @@ static noinline int kvmppc_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr)
 	return H_SUCCESS;
 }
 
-static noinline int kvmppc_xics_rm_complete(struct kvm_vcpu *vcpu, u32 hcall)
+int kvmppc_xics_rm_complete(struct kvm_vcpu *vcpu, u32 hcall)
 {
 	struct kvmppc_xics *xics = vcpu->kvm->arch.xics;
 	struct kvmppc_icp *icp = vcpu->arch.icp;
@@ -841,6 +841,7 @@ static noinline int kvmppc_xics_rm_complete(struct kvm_vcpu *vcpu, u32 hcall)
 
 	return H_SUCCESS;
 }
+EXPORT_SYMBOL_GPL(kvmppc_xics_rm_complete);
 
 int kvmppc_xics_hcall(struct kvm_vcpu *vcpu, u32 req)
 {
-- 
1.8.3.4

Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id B4A20B70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 22:48:13 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 07/27] KVM: PPC: Implement hypervisor interface
Date: Thu, 29 Jul 2010 14:47:48 +0200
Message-Id: <1280407688-9815-8-git-send-email-agraf@suse.de>
In-Reply-To: <1280407688-9815-1-git-send-email-agraf@suse.de>
References: <1280407688-9815-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To communicate with KVM directly we need to plumb some sort of interface
between the guest and KVM. Usually those interfaces use hypercalls.

This hypercall implementation is described in the last patch of the series
in a special documentation file. Please read that for further information.

This patch implements stubs to handle KVM PPC hypercalls on the host and
guest side alike.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - change hypervisor calls to use new register values

v2 -> v3:

  - move PV interface to ePAPR
  - only check R0 on hypercall
  - remove PVR hack
  - align hypercalls to in/out of ePAPR
  - add kvm.c with hypercall function
---
 arch/powerpc/include/asm/kvm_para.h |  114 ++++++++++++++++++++++++++++++++++-
 arch/powerpc/include/asm/kvm_ppc.h  |    1 +
 arch/powerpc/kernel/Makefile        |    2 +
 arch/powerpc/kernel/kvm.c           |   68 +++++++++++++++++++++
 arch/powerpc/kvm/book3s.c           |    9 ++-
 arch/powerpc/kvm/booke.c            |   10 +++-
 arch/powerpc/kvm/powerpc.c          |   32 ++++++++++
 include/linux/kvm_para.h            |    1 +
 8 files changed, 233 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/kernel/kvm.c

diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index e402999..556fd59 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -21,6 +21,7 @@
 #define __POWERPC_KVM_PARA_H__
 
 #include <linux/types.h>
+#include <linux/of.h>
 
 struct kvm_vcpu_arch_shared {
 	__u64 sprg0;
@@ -34,16 +35,127 @@ struct kvm_vcpu_arch_shared {
 	__u32 dsisr;
 };
 
+#define KVM_SC_MAGIC_R0		0x4b564d21 /* "KVM!" */
+#define HC_VENDOR_KVM		(42 << 16)
+#define HC_EV_SUCCESS		0
+#define HC_EV_UNIMPLEMENTED	12
+
 #ifdef __KERNEL__
 
+#ifdef CONFIG_KVM_GUEST
+
+static inline int kvm_para_available(void)
+{
+	struct device_node *hyper_node;
+
+	hyper_node = of_find_node_by_path("/hypervisor");
+	if (!hyper_node)
+		return 0;
+
+	if (!of_device_is_compatible(hyper_node, "linux,kvm"))
+		return 0;
+
+	return 1;
+}
+
+extern unsigned long kvm_hypercall(unsigned long *in,
+				   unsigned long *out,
+				   unsigned long nr);
+
+#else
+
 static inline int kvm_para_available(void)
 {
 	return 0;
 }
 
+static unsigned long kvm_hypercall(unsigned long *in,
+				   unsigned long *out,
+				   unsigned long nr)
+{
+	return HC_EV_UNIMPLEMENTED;
+}
+
+#endif
+
+static inline long kvm_hypercall0_1(unsigned int nr, unsigned long *r2)
+{
+	unsigned long in[8];
+	unsigned long out[8];
+	unsigned long r;
+
+	r = kvm_hypercall(in, out, nr | HC_VENDOR_KVM);
+	*r2 = out[0];
+
+	return r;
+}
+
+static inline long kvm_hypercall0(unsigned int nr)
+{
+	unsigned long in[8];
+	unsigned long out[8];
+
+	return kvm_hypercall(in, out, nr | HC_VENDOR_KVM);
+}
+
+static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
+{
+	unsigned long in[8];
+	unsigned long out[8];
+
+	in[0] = p1;
+	return kvm_hypercall(in, out, nr | HC_VENDOR_KVM);
+}
+
+static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
+				  unsigned long p2)
+{
+	unsigned long in[8];
+	unsigned long out[8];
+
+	in[0] = p1;
+	in[1] = p2;
+	return kvm_hypercall(in, out, nr | HC_VENDOR_KVM);
+}
+
+static inline long kvm_hypercall3(unsigned int nr, unsigned long p1,
+				  unsigned long p2, unsigned long p3)
+{
+	unsigned long in[8];
+	unsigned long out[8];
+
+	in[0] = p1;
+	in[1] = p2;
+	in[2] = p3;
+	return kvm_hypercall(in, out, nr | HC_VENDOR_KVM);
+}
+
+static inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
+				  unsigned long p2, unsigned long p3,
+				  unsigned long p4)
+{
+	unsigned long in[8];
+	unsigned long out[8];
+
+	in[0] = p1;
+	in[1] = p2;
+	in[2] = p3;
+	in[3] = p4;
+	return kvm_hypercall(in, out, nr | HC_VENDOR_KVM);
+}
+
+
 static inline unsigned int kvm_arch_para_features(void)
 {
-	return 0;
+	unsigned long r;
+
+	if (!kvm_para_available())
+		return 0;
+
+	if(kvm_hypercall0_1(KVM_HC_FEATURES, &r))
+		return 0;
+
+	return r;
 }
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 18d139e..ecb3bc7 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -107,6 +107,7 @@ extern int kvmppc_booke_init(void);
 extern void kvmppc_booke_exit(void);
 
 extern void kvmppc_core_destroy_mmu(struct kvm_vcpu *vcpu);
+extern int kvmppc_kvm_pv(struct kvm_vcpu *vcpu);
 
 /*
  * Cuts out inst bits with ordering according to spec.
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 58d0572..5ea853d 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -125,6 +125,8 @@ ifneq ($(CONFIG_XMON)$(CONFIG_KEXEC),)
 obj-y				+= ppc_save_regs.o
 endif
 
+obj-$(CONFIG_KVM_GUEST)		+= kvm.o
+
 # Disable GCOV in odd or sensitive code
 GCOV_PROFILE_prom_init.o := n
 GCOV_PROFILE_ftrace.o := n
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
new file mode 100644
index 0000000..4f85505
--- /dev/null
+++ b/arch/powerpc/kernel/kvm.c
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2010 SUSE Linux Products GmbH. All rights reserved.
+ *
+ * Authors:
+ *     Alexander Graf <agraf@suse.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/init.h>
+#include <linux/kvm_para.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+
+#include <asm/reg.h>
+#include <asm/kvm_ppc.h>
+#include <asm/sections.h>
+#include <asm/cacheflush.h>
+#include <asm/disassemble.h>
+
+unsigned long kvm_hypercall(unsigned long *in,
+			    unsigned long *out,
+			    unsigned long nr)
+{
+	unsigned long register r0 asm("r0");
+	unsigned long register r3 asm("r3") = in[0];
+	unsigned long register r4 asm("r4") = in[1];
+	unsigned long register r5 asm("r5") = in[2];
+	unsigned long register r6 asm("r6") = in[3];
+	unsigned long register r7 asm("r7") = in[4];
+	unsigned long register r8 asm("r8") = in[5];
+	unsigned long register r9 asm("r9") = in[6];
+	unsigned long register r10 asm("r10") = in[7];
+	unsigned long register r11 asm("r11") = nr;
+	unsigned long register r12 asm("r12");
+
+	asm volatile("bl	kvm_hypercall_start"
+		     : "=r"(r0), "=r"(r3), "=r"(r4), "=r"(r5), "=r"(r6),
+		       "=r"(r7), "=r"(r8), "=r"(r9), "=r"(r10), "=r"(r11),
+		       "=r"(r12)
+		     : "r"(r3), "r"(r4), "r"(r5), "r"(r6), "r"(r7), "r"(r8),
+		       "r"(r9), "r"(r10), "r"(r11)
+		     : "memory", "cc", "xer", "ctr", "lr");
+
+	out[0] = r4;
+	out[1] = r5;
+	out[2] = r6;
+	out[3] = r7;
+	out[4] = r8;
+	out[5] = r9;
+	out[6] = r10;
+	out[7] = r11;
+
+	return r3;
+}
+EXPORT_SYMBOL_GPL(kvm_hypercall);
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index cfd7fe5..5cb5f0d 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -947,10 +947,10 @@ program_interrupt:
 		break;
 	}
 	case BOOK3S_INTERRUPT_SYSCALL:
-		// XXX make user settable
 		if (vcpu->arch.osi_enabled &&
 		    (((u32)kvmppc_get_gpr(vcpu, 3)) == OSI_SC_MAGIC_R3) &&
 		    (((u32)kvmppc_get_gpr(vcpu, 4)) == OSI_SC_MAGIC_R4)) {
+			/* MOL hypercalls */
 			u64 *gprs = run->osi.gprs;
 			int i;
 
@@ -959,8 +959,13 @@ program_interrupt:
 				gprs[i] = kvmppc_get_gpr(vcpu, i);
 			vcpu->arch.osi_needed = 1;
 			r = RESUME_HOST_NV;
-
+		} else if (!(vcpu->arch.shared->msr & MSR_PR) &&
+		    (((u32)kvmppc_get_gpr(vcpu, 0)) == KVM_SC_MAGIC_R0)) {
+			/* KVM PV hypercalls */
+			kvmppc_set_gpr(vcpu, 3, kvmppc_kvm_pv(vcpu));
+			r = RESUME_GUEST;
 		} else {
+			/* Guest syscalls */
 			vcpu->stat.syscall_exits++;
 			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
 			r = RESUME_GUEST;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index b2c8c42..13e0747 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -338,7 +338,15 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 
 	case BOOKE_INTERRUPT_SYSCALL:
-		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SYSCALL);
+		if (!(vcpu->arch.shared->msr & MSR_PR) &&
+		    (((u32)kvmppc_get_gpr(vcpu, 0)) == KVM_SC_MAGIC_R0)) {
+			/* KVM PV hypercalls */
+			kvmppc_set_gpr(vcpu, 3, kvmppc_kvm_pv(vcpu));
+			r = RESUME_GUEST;
+		} else {
+			/* Guest syscalls */
+			kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SYSCALL);
+		}
 		kvmppc_account_exit(vcpu, SYSCALL_EXITS);
 		r = RESUME_GUEST;
 		break;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 22f6fa2..a4cf4b4 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -42,6 +42,38 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 	       !!(v->arch.pending_exceptions);
 }
 
+int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
+{
+	int nr = kvmppc_get_gpr(vcpu, 11);
+	int r;
+	unsigned long __maybe_unused param1 = kvmppc_get_gpr(vcpu, 3);
+	unsigned long __maybe_unused param2 = kvmppc_get_gpr(vcpu, 4);
+	unsigned long __maybe_unused param3 = kvmppc_get_gpr(vcpu, 5);
+	unsigned long __maybe_unused param4 = kvmppc_get_gpr(vcpu, 6);
+	unsigned long r2 = 0;
+
+	if (!(vcpu->arch.shared->msr & MSR_SF)) {
+		/* 32 bit mode */
+		param1 &= 0xffffffff;
+		param2 &= 0xffffffff;
+		param3 &= 0xffffffff;
+		param4 &= 0xffffffff;
+	}
+
+	switch (nr) {
+	case HC_VENDOR_KVM | KVM_HC_FEATURES:
+		r = HC_EV_SUCCESS;
+
+		/* Second return value is in r4 */
+		kvmppc_set_gpr(vcpu, 4, r2);
+		break;
+	default:
+		r = HC_EV_UNIMPLEMENTED;
+		break;
+	}
+
+	return r;
+}
 
 int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
diff --git a/include/linux/kvm_para.h b/include/linux/kvm_para.h
index d731092..3b8080e 100644
--- a/include/linux/kvm_para.h
+++ b/include/linux/kvm_para.h
@@ -17,6 +17,7 @@
 
 #define KVM_HC_VAPIC_POLL_IRQ		1
 #define KVM_HC_MMU_OP			2
+#define KVM_HC_FEATURES			3
 
 /*
  * hypercalls use architecture specific
-- 
1.6.0.2

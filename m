Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 0178CB7090
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:05 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 07/27] KVM: PPC: Implement hypervisor interface
Date: Thu,  1 Jul 2010 12:42:42 +0200
Message-Id: <1277980982-12433-8-git-send-email-agraf@suse.de>
In-Reply-To: <1277980982-12433-1-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
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
---
 arch/powerpc/include/asm/kvm_para.h |  100 ++++++++++++++++++++++++++++++++++-
 arch/powerpc/include/asm/kvm_ppc.h  |    1 +
 arch/powerpc/kvm/book3s.c           |   10 +++-
 arch/powerpc/kvm/booke.c            |   11 ++++-
 arch/powerpc/kvm/emulate.c          |   11 ++++-
 arch/powerpc/kvm/powerpc.c          |   28 ++++++++++
 include/linux/kvm_para.h            |    1 +
 7 files changed, 156 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index e402999..89c2760 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -34,16 +34,112 @@ struct kvm_vcpu_arch_shared {
 	__u32 dsisr;
 };
 
+#define KVM_PVR_PARA		0x4b564d3f /* "KVM?" */
+#define KVM_SC_MAGIC_R0		0x4b564d52 /* "KVMR" */
+#define KVM_SC_MAGIC_R3		0x554c455a /* "ULEZ" */
+
 #ifdef __KERNEL__
 
 static inline int kvm_para_available(void)
 {
-	return 0;
+	unsigned long pvr = KVM_PVR_PARA;
+
+	asm volatile("mfpvr %0" : "=r"(pvr) : "0"(pvr));
+	return pvr == KVM_PVR_PARA;
+}
+
+static inline long kvm_hypercall0(unsigned int nr)
+{
+	unsigned long register r0 asm("r0") = KVM_SC_MAGIC_R0;
+	unsigned long register r3 asm("r3") = KVM_SC_MAGIC_R3;
+	unsigned long register _nr asm("r4") = nr;
+
+	asm volatile("sc"
+		     : "=r"(r3)
+		     : "r"(r0), "r"(r3), "r"(_nr)
+		     : "memory");
+
+	return r3;
 }
 
+static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
+{
+	unsigned long register r0 asm("r0") = KVM_SC_MAGIC_R0;
+	unsigned long register r3 asm("r3") = KVM_SC_MAGIC_R3;
+	unsigned long register _nr asm("r4") = nr;
+	unsigned long register _p1 asm("r5") = p1;
+
+	asm volatile("sc"
+		     : "=r"(r3)
+		     : "r"(r0), "r"(r3), "r"(_nr), "r"(_p1)
+		     : "memory");
+
+	return r3;
+}
+
+static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
+				  unsigned long p2)
+{
+	unsigned long register r0 asm("r0") = KVM_SC_MAGIC_R0;
+	unsigned long register r3 asm("r3") = KVM_SC_MAGIC_R3;
+	unsigned long register _nr asm("r4") = nr;
+	unsigned long register _p1 asm("r5") = p1;
+	unsigned long register _p2 asm("r6") = p2;
+
+	asm volatile("sc"
+		     : "=r"(r3)
+		     : "r"(r0), "r"(r3), "r"(_nr), "r"(_p1), "r"(_p2)
+		     : "memory");
+
+	return r3;
+}
+
+static inline long kvm_hypercall3(unsigned int nr, unsigned long p1,
+				  unsigned long p2, unsigned long p3)
+{
+	unsigned long register r0 asm("r0") = KVM_SC_MAGIC_R0;
+	unsigned long register r3 asm("r3") = KVM_SC_MAGIC_R3;
+	unsigned long register _nr asm("r4") = nr;
+	unsigned long register _p1 asm("r5") = p1;
+	unsigned long register _p2 asm("r6") = p2;
+	unsigned long register _p3 asm("r7") = p3;
+
+	asm volatile("sc"
+		     : "=r"(r3)
+		     : "r"(r0), "r"(r3), "r"(_nr), "r"(_p1), "r"(_p2), "r"(_p3)
+		     : "memory");
+
+	return r3;
+}
+
+static inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
+				  unsigned long p2, unsigned long p3,
+				  unsigned long p4)
+{
+	unsigned long register r0 asm("r0") = KVM_SC_MAGIC_R0;
+	unsigned long register r3 asm("r3") = KVM_SC_MAGIC_R3;
+	unsigned long register _nr asm("r4") = nr;
+	unsigned long register _p1 asm("r5") = p1;
+	unsigned long register _p2 asm("r6") = p2;
+	unsigned long register _p3 asm("r7") = p3;
+	unsigned long register _p4 asm("r8") = p4;
+
+	asm volatile("sc"
+		     : "=r"(r3)
+		     : "r"(r0), "r"(r3), "r"(_nr), "r"(_p1), "r"(_p2), "r"(_p3),
+		       "r"(_p4)
+		     : "memory");
+
+	return r3;
+}
+
+
 static inline unsigned int kvm_arch_para_features(void)
 {
-	return 0;
+	if (!kvm_para_available())
+		return 0;
+
+	return kvm_hypercall0(KVM_HC_FEATURES);
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
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 0a56e8d..10afa48 100644
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
 
@@ -959,8 +959,14 @@ program_interrupt:
 				gprs[i] = kvmppc_get_gpr(vcpu, i);
 			vcpu->arch.osi_needed = 1;
 			r = RESUME_HOST_NV;
-
+		} else if (!(vcpu->arch.shared->msr & MSR_PR) &&
+		    (((u32)kvmppc_get_gpr(vcpu, 0)) == KVM_SC_MAGIC_R0) &&
+		    (((u32)kvmppc_get_gpr(vcpu, 3)) == KVM_SC_MAGIC_R3)) {
+			/* KVM PV hypercalls */
+			kvmppc_set_gpr(vcpu, 3, kvmppc_kvm_pv(vcpu));
+			r = RESUME_GUEST;
 		} else {
+			/* Guest syscalls */
 			vcpu->stat.syscall_exits++;
 			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
 			r = RESUME_GUEST;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 984c461..bd812f4 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -338,7 +338,16 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 
 	case BOOKE_INTERRUPT_SYSCALL:
-		kvmppc_booke_queue_irqprio(vcpu, BOOKE_IRQPRIO_SYSCALL);
+		if (!(vcpu->arch.shared->msr & MSR_PR) &&
+		    (((u32)kvmppc_get_gpr(vcpu, 0)) == KVM_SC_MAGIC_R0) &&
+		    (((u32)kvmppc_get_gpr(vcpu, 3)) == KVM_SC_MAGIC_R3)) {
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
diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
index 454869b..5efde36 100644
--- a/arch/powerpc/kvm/emulate.c
+++ b/arch/powerpc/kvm/emulate.c
@@ -248,7 +248,16 @@ int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
 				kvmppc_set_gpr(vcpu, rt, vcpu->arch.shared->srr1);
 				break;
 			case SPRN_PVR:
-				kvmppc_set_gpr(vcpu, rt, vcpu->arch.pvr); break;
+			{
+				/* Expose PV interface */
+				if (kvmppc_get_gpr(vcpu, rt) == KVM_PVR_PARA) {
+					kvmppc_set_gpr(vcpu, rt, KVM_PVR_PARA);
+					break;
+				}
+
+				kvmppc_set_gpr(vcpu, rt, vcpu->arch.pvr);
+				break;
+			}
 			case SPRN_PIR:
 				kvmppc_set_gpr(vcpu, rt, vcpu->vcpu_id); break;
 			case SPRN_MSSSR0:
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 22f6fa2..1ebb29e 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -42,6 +42,34 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 	       !!(v->arch.pending_exceptions);
 }
 
+int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
+{
+	int nr = kvmppc_get_gpr(vcpu, 4);
+	int r;
+	unsigned long __maybe_unused param1 = kvmppc_get_gpr(vcpu, 5);
+	unsigned long __maybe_unused param2 = kvmppc_get_gpr(vcpu, 6);
+	unsigned long __maybe_unused param3 = kvmppc_get_gpr(vcpu, 7);
+	unsigned long __maybe_unused param4 = kvmppc_get_gpr(vcpu, 8);
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
+	case KVM_HC_FEATURES:
+		r = 0;
+		break;
+	default:
+		r = -KVM_ENOSYS;
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

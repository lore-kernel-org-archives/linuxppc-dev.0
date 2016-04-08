Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhPSF44XzzDq6Y
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 02:05:16 +1000 (AEST)
From: Laurent Vivier <lvivier@redhat.com>
To: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dgibson@redhat.com, thuth@redhat.com,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2] kvm-pr: manage single-step mode
Date: Fri,  8 Apr 2016 18:05:00 +0200
Message-Id: <1460131500-19560-1-git-send-email-lvivier@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Until now, when we connect gdb to the QEMU gdb-server, the
single-step mode is not managed.

This patch adds this, only for kvm-pr:

If KVM_GUESTDBG_SINGLESTEP is set, we enable single-step trace bit in the
MSR (MSR_SE) just before the __kvmppc_vcpu_run(), and disable it just after.
In kvmppc_handle_exit_pr, instead of routing the interrupt to
the guest, we return to host, with KVM_EXIT_DEBUG reason.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
v2: split BOOK3S_INTERRUPT_MACHINE_CHECK and BOOK3S_INTERRUPT_TRACE

 arch/powerpc/kvm/book3s_pr.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 95bceca..8129b0d 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -882,6 +882,24 @@ void kvmppc_set_fscr(struct kvm_vcpu *vcpu, u64 fscr)
 }
 #endif
 
+static void kvmppc_setup_debug(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
+		u64 msr = kvmppc_get_msr(vcpu);
+
+		kvmppc_set_msr(vcpu, msr | MSR_SE);
+	}
+}
+
+static void kvmppc_clear_debug(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
+		u64 msr = kvmppc_get_msr(vcpu);
+
+		kvmppc_set_msr(vcpu, msr & ~MSR_SE);
+	}
+}
+
 int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			  unsigned int exit_nr)
 {
@@ -1207,10 +1225,18 @@ program_interrupt:
 		break;
 #endif
 	case BOOK3S_INTERRUPT_MACHINE_CHECK:
-	case BOOK3S_INTERRUPT_TRACE:
 		kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
 		r = RESUME_GUEST;
 		break;
+	case BOOK3S_INTERRUPT_TRACE:
+		if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
+			run->exit_reason = KVM_EXIT_DEBUG;
+			r = RESUME_HOST;
+		} else {
+			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
+			r = RESUME_GUEST;
+		}
+		break;
 	default:
 	{
 		ulong shadow_srr1 = vcpu->arch.shadow_srr1;
@@ -1479,6 +1505,8 @@ static int kvmppc_vcpu_run_pr(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
+	kvmppc_setup_debug(vcpu);
+
 	/*
 	 * Interrupts could be timers for the guest which we have to inject
 	 * again, so let's postpone them until we're in the guest and if we
@@ -1501,6 +1529,8 @@ static int kvmppc_vcpu_run_pr(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 
 	ret = __kvmppc_vcpu_run(kvm_run, vcpu);
 
+	kvmppc_clear_debug(vcpu);
+
 	/* No need for kvm_guest_exit. It's done in handle_exit.
 	   We also get here with interrupts enabled. */
 
-- 
2.5.5

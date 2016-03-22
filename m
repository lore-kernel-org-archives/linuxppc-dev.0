Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTwgq36zvzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 01:53:59 +1100 (AEDT)
From: Laurent Vivier <lvivier@redhat.com>
To: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dgibson@redhat.com, thuth@redhat.com,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] kvm-pr: manage single-step mode
Date: Tue, 22 Mar 2016 15:53:48 +0100
Message-Id: <1458658428-19566-1-git-send-email-lvivier@redhat.com>
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
 arch/powerpc/kvm/book3s_pr.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 95bceca..e6896f4 100644
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
@@ -1208,8 +1226,13 @@ program_interrupt:
 #endif
 	case BOOK3S_INTERRUPT_MACHINE_CHECK:
 	case BOOK3S_INTERRUPT_TRACE:
-		kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
-		r = RESUME_GUEST;
+		if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
+			run->exit_reason = KVM_EXIT_DEBUG;
+			r = RESUME_HOST;
+		} else {
+			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
+			r = RESUME_GUEST;
+		}
 		break;
 	default:
 	{
@@ -1479,6 +1502,8 @@ static int kvmppc_vcpu_run_pr(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
+	kvmppc_setup_debug(vcpu);
+
 	/*
 	 * Interrupts could be timers for the guest which we have to inject
 	 * again, so let's postpone them until we're in the guest and if we
@@ -1501,6 +1526,8 @@ static int kvmppc_vcpu_run_pr(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 
 	ret = __kvmppc_vcpu_run(kvm_run, vcpu);
 
+	kvmppc_clear_debug(vcpu);
+
 	/* No need for kvm_guest_exit. It's done in handle_exit.
 	   We also get here with interrupts enabled. */
 
-- 
2.5.0

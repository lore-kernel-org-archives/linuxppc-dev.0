Return-Path: <paulus@ozlabs.org>
Date: Wed, 11 May 2011 20:43:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
Subject: [PATCH 08/13] kvm/powerpc: Move guest enter/exit down into
	subarch-specific code
Message-ID: <20110511104331.GI2837@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110511103443.GA2837@brick.ozlabs.ibm.com>
Cc: Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From 964ee93b2d728e4fb16ae66eaceb6e912bf114ad Mon Sep 17 00:00:00 2001
From: Paul Mackerras <paulus@samba.org>
Date: Tue, 10 May 2011 22:23:18 +1000
Subject: [PATCH 08/13] kvm/powerpc: Move guest enter/exit down into
 subarch-specific code

Instead of doing the kvm_guest_enter/exit() and local_irq_dis/enable()
calls in powerpc.c, this moves them down into the subarch-specific
book3s_pr.c and booke.c.  This eliminates an extra local_irq_enable()
call in book3s_pr.c, and will be needed for when we do SMT4 guest
support in the book3s hypervisor mode code.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_ppc.h   |    1 +
 arch/powerpc/kvm/book3s_interrupts.S |    2 +-
 arch/powerpc/kvm/book3s_pr.c         |   12 ++++++------
 arch/powerpc/kvm/booke.c             |   13 +++++++++++++
 arch/powerpc/kvm/powerpc.c           |    6 +-----
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index f3c218a..3210911 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -42,6 +42,7 @@ enum emulation_result {
 	EMULATE_AGAIN,        /* something went wrong. go again */
 };
 
+extern int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
 extern int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
 extern char kvmppc_handlers_start[];
 extern unsigned long kvmppc_handler_len;
diff --git a/arch/powerpc/kvm/book3s_interrupts.S b/arch/powerpc/kvm/book3s_interrupts.S
index 2f0bc92..8c5e0e1 100644
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -85,7 +85,7 @@
  *  r3: kvm_run pointer
  *  r4: vcpu pointer
  */
-_GLOBAL(__kvmppc_vcpu_entry)
+_GLOBAL(__kvmppc_vcpu_run)
 
 kvm_start_entry:
 	/* Write correct stack frame */
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 08cedf0..f769915 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -891,8 +891,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	vfree(vcpu_book3s);
 }
 
-extern int __kvmppc_vcpu_entry(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
-int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
+int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
 	int ret;
 	double fpr[32][TS_FPRWIDTH];
@@ -944,14 +943,15 @@ int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	/* Remember the MSR with disabled extensions */
 	ext_msr = current->thread.regs->msr;
 
-	/* XXX we get called with irq disabled - change that! */
-	local_irq_enable();
-
 	/* Preload FPU if it's enabled */
 	if (vcpu->arch.shared->msr & MSR_FP)
 		kvmppc_handle_ext(vcpu, BOOK3S_INTERRUPT_FP_UNAVAIL, MSR_FP);
 
-	ret = __kvmppc_vcpu_entry(kvm_run, vcpu);
+	kvm_guest_enter();
+
+	ret = __kvmppc_vcpu_run(kvm_run, vcpu);
+
+	kvm_guest_exit();
 
 	local_irq_disable();
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ee65ec4..403e17c 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -257,6 +257,19 @@ void kvmppc_core_deliver_interrupts(struct kvm_vcpu *vcpu)
 		vcpu->arch.shared->int_pending = 0;
 }
 
+int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
+{
+	int ret;
+
+	local_irq_disable();
+	kvm_guest_enter();
+	ret = __kvmppc_vcpu_run(kvm_run, vcpu);
+	kvm_guest_exit();
+	local_irq_enable();
+
+	return ret;
+}
+
 /**
  * kvmppc_handle_exit
  *
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index b6a2a04..4b54148 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -478,11 +478,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	kvmppc_core_deliver_interrupts(vcpu);
 
-	local_irq_disable();
-	kvm_guest_enter();
-	r = __kvmppc_vcpu_run(run, vcpu);
-	kvm_guest_exit();
-	local_irq_enable();
+	r = kvmppc_vcpu_run(run, vcpu);
 
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
-- 
1.7.4.4

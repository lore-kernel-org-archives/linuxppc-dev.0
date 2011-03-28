Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3ABCBB6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 07:00:24 +1100 (EST)
Date: Mon, 28 Mar 2011 15:00:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [PATCH v2 2/4] KVM: PPC: booke: Wrap __kvmppc_vcpu_run()
Message-ID: <20110328200004.GA25685@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110328195923.GA25659@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: yu liu <yu.liu@freescale.com>

We need to save/restore SPE environment on e500 core.
Wrap __kvmppc_vcpu_run() so that we can put the SPE code in
e500.c.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: added kvm-ppc (sorry for the resend)

 arch/powerpc/include/asm/kvm_ppc.h  |    1 +
 arch/powerpc/kvm/44x.c              |    5 +++++
 arch/powerpc/kvm/book3s.c           |    1 -
 arch/powerpc/kvm/booke_interrupts.S |    2 +-
 arch/powerpc/kvm/e500.c             |    5 +++++
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index ecb3bc7..4e7a1be 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -42,6 +42,7 @@ enum emulation_result {
 	EMULATE_AGAIN,        /* something went wrong. go again */
 };
 
+extern int __kvmppc_vcpu_entry(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
 extern int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
 extern char kvmppc_handlers_start[];
 extern unsigned long kvmppc_handler_len;
diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
index 74d0e74..3d2e7d2 100644
--- a/arch/powerpc/kvm/44x.c
+++ b/arch/powerpc/kvm/44x.c
@@ -147,6 +147,11 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	kmem_cache_free(kvm_vcpu_cache, vcpu_44x);
 }
 
+int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
+{
+	return __kvmppc_vcpu_entry(kvm_run, vcpu);
+}
+
 static int __init kvmppc_44x_init(void)
 {
 	int r;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index c961de4..fb12853 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -1379,7 +1379,6 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	vfree(vcpu_book3s);
 }
 
-extern int __kvmppc_vcpu_entry(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
 int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
 	int ret;
diff --git a/arch/powerpc/kvm/booke_interrupts.S b/arch/powerpc/kvm/booke_interrupts.S
index 1cc471f..ab29f5f 100644
--- a/arch/powerpc/kvm/booke_interrupts.S
+++ b/arch/powerpc/kvm/booke_interrupts.S
@@ -293,7 +293,7 @@ heavyweight_exit:
  *  r3: kvm_run pointer
  *  r4: vcpu pointer
  */
-_GLOBAL(__kvmppc_vcpu_run)
+_GLOBAL(__kvmppc_vcpu_entry)
 	stwu	r1, -HOST_STACK_SIZE(r1)
 	stw	r1, VCPU_HOST_STACK(r4)	/* Save stack pointer to vcpu. */
 
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index e3768ee..e762634 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -70,6 +70,11 @@ int kvmppc_core_vcpu_setup(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
+{
+	return __kvmppc_vcpu_entry(kvm_run, vcpu);
+}
+
 /* 'linear_address' is actually an encoding of AS|PID|EADDR . */
 int kvmppc_core_vcpu_translate(struct kvm_vcpu *vcpu,
                                struct kvm_translation *tr)
-- 
1.7.1

Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.185])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9356EB6F94
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 07:00:25 +1100 (EST)
Date: Mon, 28 Mar 2011 15:00:06 -0500
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [PATCH v2 3/4] KVM: PPC: e500: Introduce msr_block for e500v2
Message-ID: <20110328200006.GB25685@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20110328195923.GA25659@schlenkerla.am.freescale.net>
Cc: kvmppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: yu liu <yu.liu@freescale.com>

In order to use lazy SPE register save/restore, we need to
know when the guest is using MSR[SPE].  In order to do that, we
need to control the actual MSR[SPE] separately from the guest's
notion of MSR[SPE].

Only bits set in msr_block can be changed by the guest in the real MSR.

Signed-off-by: Liu Yu <yu.liu@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: added kvm-ppc (sorry for the resend)

 arch/powerpc/include/asm/kvm_host.h |    3 +++
 arch/powerpc/kernel/asm-offsets.c   |    3 +++
 arch/powerpc/kvm/booke.h            |   17 +++++++++++++++++
 arch/powerpc/kvm/booke_interrupts.S |    6 +++++-
 arch/powerpc/kvm/e500.c             |    3 +++
 5 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index bba3b9b..c376f6b 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -217,6 +217,9 @@ struct kvm_vcpu_arch {
 	ulong xer;
 	u32 cr;
 #endif
+#ifdef CONFIG_FSL_BOOKE
+	ulong msr_block;
+#endif
 
 #ifdef CONFIG_PPC_BOOK3S
 	ulong shadow_msr;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 23e6a93..75b72c7 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -403,6 +403,9 @@ int main(void)
 	DEFINE(VCPU_SHARED, offsetof(struct kvm_vcpu, arch.shared));
 	DEFINE(VCPU_SHARED_MSR, offsetof(struct kvm_vcpu_arch_shared, msr));
 
+#ifdef CONFIG_FSL_BOOKE
+	DEFINE(VCPU_MSR_BLOCK, offsetof(struct kvm_vcpu, arch.msr_block));
+#endif
 	/* book3s */
 #ifdef CONFIG_PPC_BOOK3S
 	DEFINE(VCPU_HOST_RETIP, offsetof(struct kvm_vcpu, arch.host_retip));
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index 492bb70..303a415 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -52,6 +52,23 @@
 
 extern unsigned long kvmppc_booke_handlers;
 
+#ifdef CONFIG_FSL_BOOKE
+static inline bool kvmppc_msr_block_has(struct kvm_vcpu *vcpu, u32 block_bit)
+{
+	return !(vcpu->arch.msr_block & block_bit);
+}
+
+static inline void kvmppc_set_msr_block(struct kvm_vcpu *vcpu, u32 block_bit)
+{
+	vcpu->arch.msr_block &= ~block_bit;
+}
+
+static inline void kvmppc_clr_msr_block(struct kvm_vcpu *vcpu, u32 block_bit)
+{
+	vcpu->arch.msr_block |= block_bit;
+}
+#endif
+
 /* Helper function for "full" MSR writes. No need to call this if only EE is
  * changing. */
 static inline void kvmppc_set_msr(struct kvm_vcpu *vcpu, u32 new_msr)
diff --git a/arch/powerpc/kvm/booke_interrupts.S b/arch/powerpc/kvm/booke_interrupts.S
index ab29f5f..92193c7 100644
--- a/arch/powerpc/kvm/booke_interrupts.S
+++ b/arch/powerpc/kvm/booke_interrupts.S
@@ -409,7 +409,6 @@ lightweight_exit:
 	mtctr	r3
 	lwz	r3, VCPU_CR(r4)
 	mtcr	r3
-	lwz	r5, VCPU_GPR(r5)(r4)
 	lwz	r6, VCPU_GPR(r6)(r4)
 	lwz	r7, VCPU_GPR(r7)(r4)
 	lwz	r8, VCPU_GPR(r8)(r4)
@@ -419,6 +418,11 @@ lightweight_exit:
 	lwz	r3, (VCPU_SHARED_MSR + 4)(r3)
 	oris	r3, r3, KVMPPC_MSR_MASK@h
 	ori	r3, r3, KVMPPC_MSR_MASK@l
+#ifdef CONFIG_FSL_BOOKE
+	lwz	r5, VCPU_MSR_BLOCK(r4)
+	and	r3, r3, r5
+#endif
+	lwz	r5, VCPU_GPR(r5)(r4)
 	mtsrr1	r3
 
 	/* Clear any debug events which occurred since we disabled MSR[DE].
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index e762634..acfe052 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -67,6 +67,9 @@ int kvmppc_core_vcpu_setup(struct kvm_vcpu *vcpu)
 	/* Since booke kvm only support one core, update all vcpus' PIR to 0 */
 	vcpu->vcpu_id = 0;
 
+	/* Unblock all msr bits */
+	kvmppc_clr_msr_block(vcpu, ~0UL);
+
 	return 0;
 }
 
-- 
1.7.1

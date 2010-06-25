Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD10010083E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:18 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 08/26] KVM: PPC: Add PV guest critical sections
Date: Sat, 26 Jun 2010 01:24:56 +0200
Message-Id: <1277508314-915-9-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-1-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
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

When running in hooked code we need a way to disable interrupts without
clobbering any interrupts or exiting out to the hypervisor.

To achieve this, we have an additional critical field in the shared page. If
that field is equal to the r1 register of the guest, it tells the hypervisor
that we're in such a critical section and thus may not receive any interrupts.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_para.h |    1 +
 arch/powerpc/kvm/book3s.c           |   15 +++++++++++++--
 arch/powerpc/kvm/booke.c            |   12 ++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index eaab306..d1fe9ae 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 struct kvm_vcpu_arch_shared {
+	__u64 critical;		/* Guest may not get interrupts if == r1 */
 	__u64 sprg0;
 	__u64 sprg1;
 	__u64 sprg2;
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index e8001c5..f0e8047 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -251,14 +251,25 @@ int kvmppc_book3s_irqprio_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 	int deliver = 1;
 	int vec = 0;
 	ulong flags = 0ULL;
+	ulong crit_raw = vcpu->arch.shared->critical;
+	ulong crit_r1 = kvmppc_get_gpr(vcpu, 1);
+	bool crit;
+
+	/* Truncate crit indicators in 32 bit mode */
+	if (!(vcpu->arch.shared->msr & MSR_SF)) {
+		crit_raw &= 0xffffffff;
+		crit_r1 &= 0xffffffff;
+	}
+
+	crit = (crit_raw == crit_r1);
 
 	switch (priority) {
 	case BOOK3S_IRQPRIO_DECREMENTER:
-		deliver = vcpu->arch.shared->msr & MSR_EE;
+		deliver = (vcpu->arch.shared->msr & MSR_EE) && !crit;
 		vec = BOOK3S_INTERRUPT_DECREMENTER;
 		break;
 	case BOOK3S_IRQPRIO_EXTERNAL:
-		deliver = vcpu->arch.shared->msr & MSR_EE;
+		deliver = (vcpu->arch.shared->msr & MSR_EE) && !crit;
 		vec = BOOK3S_INTERRUPT_EXTERNAL;
 		break;
 	case BOOK3S_IRQPRIO_SYSTEM_RESET:
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index e7d1216..485f8fa 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -147,6 +147,17 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	int allowed = 0;
 	ulong uninitialized_var(msr_mask);
 	bool update_esr = false, update_dear = false;
+	ulong crit_raw = vcpu->arch.shared->critical;
+	ulong crit_r1 = kvmppc_get_gpr(vcpu, 1);
+	bool crit;
+
+	/* Truncate crit indicators in 32 bit mode */
+	if (!(vcpu->arch.shared->msr & MSR_SF)) {
+		crit_raw &= 0xffffffff;
+		crit_r1 &= 0xffffffff;
+	}
+
+	crit = (crit_raw == crit_r1);
 
 	switch (priority) {
 	case BOOKE_IRQPRIO_DTLB_MISS:
@@ -181,6 +192,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 	case BOOKE_IRQPRIO_DECREMENTER:
 	case BOOKE_IRQPRIO_FIT:
 		allowed = vcpu->arch.shared->msr & MSR_EE;
+		allowed = allowed && !crit;
 		msr_mask = MSR_CE|MSR_ME|MSR_DE;
 		break;
 	case BOOKE_IRQPRIO_DEBUG:
-- 
1.6.0.2

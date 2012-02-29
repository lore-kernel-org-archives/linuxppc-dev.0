Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6B4CFB6FE5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 11:10:20 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 16/38] KVM: PPC: e500mc: Add doorbell emulation support
Date: Wed, 29 Feb 2012 01:09:44 +0100
Message-Id: <1330474206-14794-17-git-send-email-agraf@suse.de>
In-Reply-To: <1330474206-14794-1-git-send-email-agraf@suse.de>
References: <1330474206-14794-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When one vcpu wants to kick another, it can issue a special IPI instruction
called msgsnd. This patch emulates this instruction, its clearing counterpart
and the infrastructure required to actually trigger that interrupt inside
a guest vcpu.

With this patch, SMP guests on e500mc work.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - introduce and use constants
  - drop e500mc ifdefs
---
 arch/powerpc/include/asm/dbell.h |    2 +
 arch/powerpc/kvm/booke.c         |    2 +
 arch/powerpc/kvm/e500_emulate.c  |   68 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index d7365b0..154c067 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -19,7 +19,9 @@
 
 #define PPC_DBELL_MSG_BRDCAST	(0x04000000)
 #define PPC_DBELL_TYPE(x)	(((x) & 0xf) << (63-36))
+#define PPC_DBELL_TYPE_MASK	PPC_DBELL_TYPE(0xf)
 #define PPC_DBELL_LPID(x)	((x) << (63 - 49))
+#define PPC_DBELL_PIR_MASK	0x3fff
 enum ppc_dbell {
 	PPC_DBELL = 0,		/* doorbell */
 	PPC_DBELL_CRIT = 1,	/* critical doorbell */
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 0b77be1..85bd5b8 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -326,6 +326,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 		int_class = INT_CLASS_NONCRIT;
 		break;
 	case BOOKE_IRQPRIO_CRITICAL:
+	case BOOKE_IRQPRIO_DBELL_CRIT:
 		allowed = vcpu->arch.shared->msr & MSR_CE;
 		allowed = allowed && !crit;
 		msr_mask = MSR_GS | MSR_ME;
@@ -342,6 +343,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 		keep_irq = true;
 		/* fall through */
 	case BOOKE_IRQPRIO_EXTERNAL:
+	case BOOKE_IRQPRIO_DBELL:
 		allowed = vcpu->arch.shared->msr & MSR_EE;
 		allowed = allowed && !crit;
 		msr_mask = MSR_GS | MSR_CE | MSR_ME | MSR_DE;
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index 98b6c1c..99155f8 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -14,16 +14,74 @@
 
 #include <asm/kvm_ppc.h>
 #include <asm/disassemble.h>
+#include <asm/dbell.h>
 
 #include "booke.h"
 #include "e500.h"
 
+#define XOP_MSGSND  206
+#define XOP_MSGCLR  238
 #define XOP_TLBIVAX 786
 #define XOP_TLBSX   914
 #define XOP_TLBRE   946
 #define XOP_TLBWE   978
 #define XOP_TLBILX  18
 
+#ifdef CONFIG_KVM_E500MC
+static int dbell2prio(ulong param)
+{
+	int msg = param & PPC_DBELL_TYPE_MASK;
+	int prio = -1;
+
+	switch (msg) {
+	case PPC_DBELL_TYPE(PPC_DBELL):
+		prio = BOOKE_IRQPRIO_DBELL;
+		break;
+	case PPC_DBELL_TYPE(PPC_DBELL_CRIT):
+		prio = BOOKE_IRQPRIO_DBELL_CRIT;
+		break;
+	default:
+		break;
+	}
+
+	return prio;
+}
+
+static int kvmppc_e500_emul_msgclr(struct kvm_vcpu *vcpu, int rb)
+{
+	ulong param = vcpu->arch.gpr[rb];
+	int prio = dbell2prio(param);
+
+	if (prio < 0)
+		return EMULATE_FAIL;
+
+	clear_bit(prio, &vcpu->arch.pending_exceptions);
+	return EMULATE_DONE;
+}
+
+static int kvmppc_e500_emul_msgsnd(struct kvm_vcpu *vcpu, int rb)
+{
+	ulong param = vcpu->arch.gpr[rb];
+	int prio = dbell2prio(rb);
+	int pir = param & PPC_DBELL_PIR_MASK;
+	int i;
+	struct kvm_vcpu *cvcpu;
+
+	if (prio < 0)
+		return EMULATE_FAIL;
+
+	kvm_for_each_vcpu(i, cvcpu, vcpu->kvm) {
+		int cpir = cvcpu->arch.shared->pir;
+		if ((param & PPC_DBELL_MSG_BRDCAST) || (cpir == pir)) {
+			set_bit(prio, &cvcpu->arch.pending_exceptions);
+			kvm_vcpu_kick(cvcpu);
+		}
+	}
+
+	return EMULATE_DONE;
+}
+#endif
+
 int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
                            unsigned int inst, int *advance)
 {
@@ -36,6 +94,16 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	case 31:
 		switch (get_xop(inst)) {
 
+#ifdef CONFIG_KVM_E500MC
+		case XOP_MSGSND:
+			emulated = kvmppc_e500_emul_msgsnd(vcpu, get_rb(inst));
+			break;
+
+		case XOP_MSGCLR:
+			emulated = kvmppc_e500_emul_msgclr(vcpu, get_rb(inst));
+			break;
+#endif
+
 		case XOP_TLBRE:
 			emulated = kvmppc_e500_emul_tlbre(vcpu);
 			break;
-- 
1.6.0.2

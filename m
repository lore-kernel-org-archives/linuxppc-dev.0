Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0B42E2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 03:44:39 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jan 2014 22:14:37 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 20F21E0053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:17:41 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SGiaUU6947218
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:36 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SGiYnn020412
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:35 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 08/10] KVM: PPC: BOOK3S: PR: Add support for facility
 unavailable interrupt
Date: Tue, 28 Jan 2014 22:14:13 +0530
Message-Id: <1390927455-3312-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At this point we allow all the supported facilities except EBB. So
forward the interrupt to guest as illegal instruction.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_asm.h |  4 +++-
 arch/powerpc/kvm/book3s.c          |  4 ++++
 arch/powerpc/kvm/book3s_emulate.c  | 18 ++++++++++++++++++
 arch/powerpc/kvm/book3s_pr.c       | 17 +++++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index 1bd92fd43cfb..799244face51 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -99,6 +99,7 @@
 #define BOOK3S_INTERRUPT_PERFMON	0xf00
 #define BOOK3S_INTERRUPT_ALTIVEC	0xf20
 #define BOOK3S_INTERRUPT_VSX		0xf40
+#define BOOK3S_INTERRUPT_FAC_UNAVAIL    0xf60
 
 #define BOOK3S_IRQPRIO_SYSTEM_RESET		0
 #define BOOK3S_IRQPRIO_DATA_SEGMENT		1
@@ -117,7 +118,8 @@
 #define BOOK3S_IRQPRIO_DECREMENTER		14
 #define BOOK3S_IRQPRIO_PERFORMANCE_MONITOR	15
 #define BOOK3S_IRQPRIO_EXTERNAL_LEVEL		16
-#define BOOK3S_IRQPRIO_MAX			17
+#define BOOK3S_IRQPRIO_FAC_UNAVAIL		17
+#define BOOK3S_IRQPRIO_MAX			18
 
 #define BOOK3S_HFLAG_DCBZ32			0x1
 #define BOOK3S_HFLAG_SLB			0x2
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 8912608b7e1b..a9aea28c2677 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -143,6 +143,7 @@ static int kvmppc_book3s_vec2irqprio(unsigned int vec)
 	case 0xd00: prio = BOOK3S_IRQPRIO_DEBUG;		break;
 	case 0xf20: prio = BOOK3S_IRQPRIO_ALTIVEC;		break;
 	case 0xf40: prio = BOOK3S_IRQPRIO_VSX;			break;
+	case 0xf60: prio = BOOK3S_IRQPRIO_FAC_UNAVAIL;		break;
 	default:    prio = BOOK3S_IRQPRIO_MAX;			break;
 	}
 
@@ -273,6 +274,9 @@ int kvmppc_book3s_irqprio_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 	case BOOK3S_IRQPRIO_PERFORMANCE_MONITOR:
 		vec = BOOK3S_INTERRUPT_PERFMON;
 		break;
+	case BOOK3S_IRQPRIO_FAC_UNAVAIL:
+		vec = BOOK3S_INTERRUPT_FAC_UNAVAIL;
+		break;
 	default:
 		deliver = 0;
 		printk(KERN_ERR "KVM: Unknown interrupt: 0x%x\n", priority);
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 60d0b6b745e7..bf6b11021250 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -481,6 +481,15 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 		vcpu->arch.shadow_fscr = vcpu->arch.fscr & host_fscr;
 		break;
 	}
+	case SPRN_EBBHR:
+		vcpu->arch.ebbhr = spr_val;
+		break;
+	case SPRN_EBBRR:
+		vcpu->arch.ebbrr = spr_val;
+		break;
+	case SPRN_BESCR:
+		vcpu->arch.bescr = spr_val;
+		break;
 unprivileged:
 	default:
 		printk(KERN_INFO "KVM: invalid SPR write: %d\n", sprn);
@@ -607,6 +616,15 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
 	case SPRN_FSCR:
 		*spr_val = vcpu->arch.fscr;
 		break;
+	case SPRN_EBBHR:
+		*spr_val = vcpu->arch.ebbhr;
+		break;
+	case SPRN_EBBRR:
+		*spr_val = vcpu->arch.ebbrr;
+		break;
+	case SPRN_BESCR:
+		*spr_val = vcpu->arch.bescr;
+		break;
 	default:
 unprivileged:
 		printk(KERN_INFO "KVM: invalid SPR read: %d\n", sprn);
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 51d469f8c9fd..828056ec208f 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -900,6 +900,23 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	case BOOK3S_INTERRUPT_PERFMON:
 		r = RESUME_GUEST;
 		break;
+	case BOOK3S_INTERRUPT_FAC_UNAVAIL:
+	{
+		/*
+		 * Check for the facility that need to be emulated
+		 */
+		ulong fscr_ic = vcpu->arch.shadow_fscr >> 56;
+		if (fscr_ic != FSCR_EBB_LG) {
+			/*
+			 * We only disable EBB facility.
+			 * So only emulate that.
+			 */
+			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
+			r = RESUME_GUEST;
+			break;
+		}
+		/* Fall through */
+	}
 	case BOOK3S_INTERRUPT_PROGRAM:
 	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
 	{
-- 
1.8.5.3

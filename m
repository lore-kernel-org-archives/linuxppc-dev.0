Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 944901A01FB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 22:08:39 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Jun 2014 22:08:25 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6A7772BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 22:08:24 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s55BqQFs13172878
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 21:52:26 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s55C8NqL010872
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jun 2014 22:08:23 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/4] KVM: PPC: BOOK3S: PR: Emulate virtual timebase register
Date: Thu,  5 Jun 2014 17:38:02 +0530
Message-Id: <1401970085-14493-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

virtual time base register is a per VM, per cpu register that needs
to be saved and restored on vm exit and entry. Writing to VTB is not
allowed in the privileged mode.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/include/asm/reg.h      | 15 +++++++++++++++
 arch/powerpc/include/asm/time.h     |  9 +++++++++
 arch/powerpc/kvm/book3s.c           |  6 ++++++
 arch/powerpc/kvm/book3s_emulate.c   |  3 +++
 arch/powerpc/kvm/book3s_hv.c        |  6 ------
 arch/powerpc/kvm/book3s_pr.c        |  3 ++-
 7 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 4a58731a0a72..bd3caeaeebe1 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -505,6 +505,7 @@ struct kvm_vcpu_arch {
 #endif
 	/* Time base value when we entered the guest */
 	u64 entry_tb;
+	u64 entry_vtb;
 	u32 tcr;
 	ulong tsr; /* we need to perform set/clr_bits() which requires ulong */
 	u32 ivor[64];
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 4852bcf270f3..3e7085d8af90 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -25,6 +25,7 @@
 #ifdef CONFIG_8xx
 #include <asm/reg_8xx.h>
 #endif /* CONFIG_8xx */
+#include <asm/bug.h>
 
 #define MSR_SF_LG	63              /* Enable 64 bit mode */
 #define MSR_ISF_LG	61              /* Interrupt 64b mode valid on 630 */
@@ -1193,6 +1194,20 @@
 				     : "r" ((unsigned long)(v)) \
 				     : "memory")
 
+static inline unsigned long mfvtb (void)
+{
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		return mfspr(SPRN_VTB);
+#endif
+	/*
+	 * The above mfspr will be a no-op on anything before Power8
+	 * That can result in random values returned. We need to
+	 * capture that.
+	 */
+	BUG();
+}
+
 #ifdef __powerpc64__
 #if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
 #define mftb()		({unsigned long rval;				\
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 1d428e6007ca..03cbada59d3a 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -102,6 +102,15 @@ static inline u64 get_rtc(void)
 	return (u64)hi * 1000000000 + lo;
 }
 
+static inline u64 get_vtb(void)
+{
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		return mfvtb();
+#endif
+	return 0;
+}
+
 #ifdef CONFIG_PPC64
 static inline u64 get_tb(void)
 {
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 52c654dbd41a..ae43e4178ecd 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -646,6 +646,9 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 		case KVM_REG_PPC_BESCR:
 			val = get_reg_val(reg->id, vcpu->arch.bescr);
 			break;
+		case KVM_REG_PPC_VTB:
+			val = get_reg_val(reg->id, vcpu->arch.vtb);
+			break;
 		default:
 			r = -EINVAL;
 			break;
@@ -750,6 +753,9 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 		case KVM_REG_PPC_BESCR:
 			vcpu->arch.bescr = set_reg_val(reg->id, val);
 			break;
+		case KVM_REG_PPC_VTB:
+			vcpu->arch.vtb = set_reg_val(reg->id, val);
+			break;
 		default:
 			r = -EINVAL;
 			break;
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 3565e775b61b..1bb16a59dcbc 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -577,6 +577,9 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
 		 */
 		*spr_val = vcpu->arch.spurr;
 		break;
+	case SPRN_VTB:
+		*spr_val = vcpu->arch.vtb;
+		break;
 	case SPRN_GQR0:
 	case SPRN_GQR1:
 	case SPRN_GQR2:
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index aba05bbb3e74..f6ac58336b3f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -897,9 +897,6 @@ static int kvmppc_get_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_IC:
 		*val = get_reg_val(id, vcpu->arch.ic);
 		break;
-	case KVM_REG_PPC_VTB:
-		*val = get_reg_val(id, vcpu->arch.vtb);
-		break;
 	case KVM_REG_PPC_CSIGR:
 		*val = get_reg_val(id, vcpu->arch.csigr);
 		break;
@@ -1097,9 +1094,6 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	case KVM_REG_PPC_IC:
 		vcpu->arch.ic = set_reg_val(id, *val);
 		break;
-	case KVM_REG_PPC_VTB:
-		vcpu->arch.vtb = set_reg_val(id, *val);
-		break;
 	case KVM_REG_PPC_CSIGR:
 		vcpu->arch.csigr = set_reg_val(id, *val);
 		break;
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index ff15f8e31a27..96cdf89a8c86 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -125,6 +125,7 @@ void kvmppc_copy_to_svcpu(struct kvmppc_book3s_shadow_vcpu *svcpu,
 	 * to find the guest purr and spurr value.
 	 */
 	vcpu->arch.entry_tb = get_tb();
+	vcpu->arch.entry_vtb = get_vtb();
 	svcpu->in_use = true;
 }
 
@@ -176,7 +177,7 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
 	 */
 	vcpu->arch.purr += get_tb() - vcpu->arch.entry_tb;
 	vcpu->arch.spurr += get_tb() - vcpu->arch.entry_tb;
-
+	vcpu->arch.vtb += get_vtb() - vcpu->arch.entry_vtb;
 	svcpu->in_use = false;
 
 out:
-- 
1.9.1

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0BCA12C01AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 03:44:39 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jan 2014 22:14:37 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 19693E0053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:17:40 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SGiUOI60686420
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:30 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SGiXaQ020363
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 22:14:34 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 07/10] KVM: PPC: BOOK3S: PR: Emulate facility status and
 control register
Date: Tue, 28 Jan 2014 22:14:12 +0530
Message-Id: <1390927455-3312-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We allow priv-mode update of this. The guest value is saved in fscr,
and the value actually used is saved in shadow_fscr. shadow_fscr
only contains values that are allowed by the host. On
facility unavailable interrupt, if the facility is allowed by fscr
but disabled in shadow_fscr we need to emulate the support. Currently
all but EBB is disabled. We still don't support performance monitoring
in PR guest.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_asm.h |  1 +
 arch/powerpc/include/asm/kvm_host.h       |  1 +
 arch/powerpc/kernel/asm-offsets.c         |  2 ++
 arch/powerpc/kvm/book3s_emulate.c         | 16 ++++++++++++++++
 arch/powerpc/kvm/book3s_interrupts.S      | 25 ++++++++++++++++++++++---
 5 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index 192917d2239c..abd42523ad93 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -103,6 +103,7 @@ struct kvmppc_host_state {
 #ifdef CONFIG_PPC_BOOK3S_64
 	u64 cfar;
 	u64 ppr;
+	u64 host_fscr;
 #endif
 };
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index e0b13aca98e6..f4be7be14330 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -478,6 +478,7 @@ struct kvm_vcpu_arch {
 	ulong ppr;
 	ulong pspb;
 	ulong fscr;
+	ulong shadow_fscr;
 	ulong tfhar;
 	ulong tfiar;
 	ulong texasr;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 2c2227da6917..7484676b8f25 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -525,6 +525,7 @@ int main(void)
 	DEFINE(VCPU_CFAR, offsetof(struct kvm_vcpu, arch.cfar));
 	DEFINE(VCPU_PPR, offsetof(struct kvm_vcpu, arch.ppr));
 	DEFINE(VCPU_FSCR, offsetof(struct kvm_vcpu, arch.fscr));
+	DEFINE(VCPU_SHADOW_FSCR, offsetof(struct kvm_vcpu, arch.shadow_fscr));
 	DEFINE(VCPU_PSPB, offsetof(struct kvm_vcpu, arch.pspb));
 	DEFINE(VCPU_TFHAR, offsetof(struct kvm_vcpu, arch.tfhar));
 	DEFINE(VCPU_TFIAR, offsetof(struct kvm_vcpu, arch.tfiar));
@@ -626,6 +627,7 @@ int main(void)
 #ifdef CONFIG_PPC_BOOK3S_64
 	HSTATE_FIELD(HSTATE_CFAR, cfar);
 	HSTATE_FIELD(HSTATE_PPR, ppr);
+	HSTATE_FIELD(HSTATE_FSCR, host_fscr);
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 #else /* CONFIG_PPC_BOOK3S */
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 7f25adbd2590..60d0b6b745e7 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -468,6 +468,19 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 	case SPRN_MSSSR0:
 	case SPRN_DABR:
 		break;
+	case SPRN_FSCR:
+	{
+		ulong host_fscr = mfspr(SPRN_FSCR);
+		/*
+		 * We disable FSCR_EBB for pr guest. TAR and DSCR are always
+		 * enabled.
+		 */
+		if (spr_val & ~(FSCR_TAR|FSCR_DSCR|FSCR_EBB))
+			pr_info("KVM: invalud FSCR value 0x%lx", spr_val);
+		vcpu->arch.fscr = spr_val & (FSCR_TAR|FSCR_DSCR);
+		vcpu->arch.shadow_fscr = vcpu->arch.fscr & host_fscr;
+		break;
+	}
 unprivileged:
 	default:
 		printk(KERN_INFO "KVM: invalid SPR write: %d\n", sprn);
@@ -591,6 +604,9 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
 		 */
 		*spr_val = 0;
 		break;
+	case SPRN_FSCR:
+		*spr_val = vcpu->arch.fscr;
+		break;
 	default:
 unprivileged:
 		printk(KERN_INFO "KVM: invalid SPR read: %d\n", sprn);
diff --git a/arch/powerpc/kvm/book3s_interrupts.S b/arch/powerpc/kvm/book3s_interrupts.S
index f779450cb07c..fcbdf4817301 100644
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -107,6 +107,14 @@ kvm_start_lightweight:
 	ld	r3, VCPU_SHARED(r4)
 	ld	r3, VCPU_SHARED_SPRG3(r3)
 	mtspr	SPRN_SPRG3, r3
+
+BEGIN_FTR_SECTION
+	mfspr r3,SPRN_FSCR
+	PPC_STL	r3, HSTATE_FSCR(r13)
+
+	PPC_LL r3, VCPU_SHADOW_FSCR(r4)
+	mtspr SPRN_FSCR, r3
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 	PPC_LL	r4, VCPU_SHADOW_MSR(r4)	/* get shadow_msr */
@@ -148,6 +156,9 @@ kvm_start_lightweight:
 	bl	FUNC(kvmppc_copy_from_svcpu)
 	nop
 
+	/* R7 = vcpu */
+	PPC_LL	r7, GPR4(r1)
+
 #ifdef CONFIG_PPC_BOOK3S_64
 	/*
 	 * Reload kernel SPRG3 value.
@@ -155,10 +166,18 @@ kvm_start_lightweight:
 	 */
 	ld	r3, PACA_SPRG3(r13)
 	mtspr	SPRN_SPRG3, r3
-#endif /* CONFIG_PPC_BOOK3S_64 */
+BEGIN_FTR_SECTION
+	/*
+	 * Save the current fscr in shadow fscr
+	 */
+	mfspr r3,SPRN_FSCR
+	PPC_STL r3, VCPU_SHADOW_FSCR(r7)
 
-	/* R7 = vcpu */
-	PPC_LL	r7, GPR4(r1)
+	PPC_LL	r3, HSTATE_FSCR(r13)
+	mtspr	SPRN_FSCR, r3
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
+
+#endif /* CONFIG_PPC_BOOK3S_64 */
 
 	PPC_STL	r14, VCPU_GPR(R14)(r7)
 	PPC_STL	r15, VCPU_GPR(R15)(r7)
-- 
1.8.5.3

Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1570EC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:03:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73876204FD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 12:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="h6zhcrLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73876204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Pd8g64X4zF3D0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 22:03:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="h6zhcrLd";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PcSJ1rnzzF35t
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 21:32:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="h6zhcrLd"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PcSH2wq9z9t0P; Tue,  2 Oct 2018 21:31:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42PcSG6xMkz9snk;
 Tue,  2 Oct 2018 21:31:58 +1000 (AEST)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538479919; bh=WJ08nOmxYvBxfArr+t8nAyyJwP8eQrD//awOLfCb5XM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h6zhcrLdudUewt450Lz6RS+693PbqOatwZaulmazFOiO8ntwQfas1oyIwRb40a7al
 kwwxC04dAi8zhNJ5XaB5232cXTwV8RP09Keq8Am1sAkjN1K2y6hC52F5PMALreLMa8
 NLXRJIrH4bCu9vYN2EfWMaFqO4TmGc+mHCw8p6UIFWuUS1cD/lUsEpFTJFfLgZ5gbV
 jSqH/C1sVd1cXXod3eRSIwCNaHFLseKm9Scn7GVjWNPQ8dtPvGc9dlsl8XRmNDMCY1
 7oZcf1YQapluaIWocGEESQWWUaHHK4VNv+pEoLqZ5NNHxN5QcMMOQdLWcGk16vHIDN
 YMG6BhAiP6jJA==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v3 12/33] KVM: PPC: Use ccr field in pt_regs struct embedded
 in vcpu struct
Date: Tue,  2 Oct 2018 21:31:11 +1000
Message-Id: <1538479892-14835-13-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When the 'regs' field was added to struct kvm_vcpu_arch, the code
was changed to use several of the fields inside regs (e.g., gpr, lr,
etc.) but not the ccr field, because the ccr field in struct pt_regs
is 64 bits on 64-bit platforms, but the cr field in kvm_vcpu_arch is
only 32 bits.  This changes the code to use the regs.ccr field
instead of cr, and changes the assembly code on 64-bit platforms to
use 64-bit loads and stores instead of 32-bit ones.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_book3s.h    |  4 ++--
 arch/powerpc/include/asm/kvm_book3s_64.h |  4 ++--
 arch/powerpc/include/asm/kvm_booke.h     |  4 ++--
 arch/powerpc/include/asm/kvm_host.h      |  2 --
 arch/powerpc/kernel/asm-offsets.c        |  4 ++--
 arch/powerpc/kvm/book3s_emulate.c        | 12 ++++++------
 arch/powerpc/kvm/book3s_hv.c             |  4 ++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  4 ++--
 arch/powerpc/kvm/book3s_hv_tm.c          |  6 +++---
 arch/powerpc/kvm/book3s_hv_tm_builtin.c  |  5 +++--
 arch/powerpc/kvm/book3s_pr.c             |  4 ++--
 arch/powerpc/kvm/bookehv_interrupts.S    |  8 ++++----
 arch/powerpc/kvm/emulate_loadstore.c     |  1 -
 13 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 83a9aa3..dd18d81 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -301,12 +301,12 @@ static inline ulong kvmppc_get_gpr(struct kvm_vcpu *vcpu, int num)
 
 static inline void kvmppc_set_cr(struct kvm_vcpu *vcpu, u32 val)
 {
-	vcpu->arch.cr = val;
+	vcpu->arch.regs.ccr = val;
 }
 
 static inline u32 kvmppc_get_cr(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.cr;
+	return vcpu->arch.regs.ccr;
 }
 
 static inline void kvmppc_set_xer(struct kvm_vcpu *vcpu, ulong val)
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index af25aaa..5c0e2d9 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -483,7 +483,7 @@ static inline u64 sanitize_msr(u64 msr)
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 static inline void copy_from_checkpoint(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.cr  = vcpu->arch.cr_tm;
+	vcpu->arch.regs.ccr  = vcpu->arch.cr_tm;
 	vcpu->arch.regs.xer = vcpu->arch.xer_tm;
 	vcpu->arch.regs.link  = vcpu->arch.lr_tm;
 	vcpu->arch.regs.ctr = vcpu->arch.ctr_tm;
@@ -500,7 +500,7 @@ static inline void copy_from_checkpoint(struct kvm_vcpu *vcpu)
 
 static inline void copy_to_checkpoint(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.cr_tm  = vcpu->arch.cr;
+	vcpu->arch.cr_tm  = vcpu->arch.regs.ccr;
 	vcpu->arch.xer_tm = vcpu->arch.regs.xer;
 	vcpu->arch.lr_tm  = vcpu->arch.regs.link;
 	vcpu->arch.ctr_tm = vcpu->arch.regs.ctr;
diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
index d513e3e..f0cef62 100644
--- a/arch/powerpc/include/asm/kvm_booke.h
+++ b/arch/powerpc/include/asm/kvm_booke.h
@@ -46,12 +46,12 @@ static inline ulong kvmppc_get_gpr(struct kvm_vcpu *vcpu, int num)
 
 static inline void kvmppc_set_cr(struct kvm_vcpu *vcpu, u32 val)
 {
-	vcpu->arch.cr = val;
+	vcpu->arch.regs.ccr = val;
 }
 
 static inline u32 kvmppc_get_cr(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.cr;
+	return vcpu->arch.regs.ccr;
 }
 
 static inline void kvmppc_set_xer(struct kvm_vcpu *vcpu, ulong val)
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index a3d4f61..c9cc42f 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -538,8 +538,6 @@ struct kvm_vcpu_arch {
 	ulong tar;
 #endif
 
-	u32 cr;
-
 #ifdef CONFIG_PPC_BOOK3S
 	ulong hflags;
 	ulong guest_owned_ext;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 89cf155..7c3738d 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -438,7 +438,7 @@ int main(void)
 #ifdef CONFIG_PPC_BOOK3S
 	OFFSET(VCPU_TAR, kvm_vcpu, arch.tar);
 #endif
-	OFFSET(VCPU_CR, kvm_vcpu, arch.cr);
+	OFFSET(VCPU_CR, kvm_vcpu, arch.regs.ccr);
 	OFFSET(VCPU_PC, kvm_vcpu, arch.regs.nip);
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	OFFSET(VCPU_MSR, kvm_vcpu, arch.shregs.msr);
@@ -695,7 +695,7 @@ int main(void)
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 #else /* CONFIG_PPC_BOOK3S */
-	OFFSET(VCPU_CR, kvm_vcpu, arch.cr);
+	OFFSET(VCPU_CR, kvm_vcpu, arch.regs.ccr);
 	OFFSET(VCPU_XER, kvm_vcpu, arch.regs.xer);
 	OFFSET(VCPU_LR, kvm_vcpu, arch.regs.link);
 	OFFSET(VCPU_CTR, kvm_vcpu, arch.regs.ctr);
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 36b11c5..2654df2 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -110,7 +110,7 @@ static inline void kvmppc_copyto_vcpu_tm(struct kvm_vcpu *vcpu)
 	vcpu->arch.ctr_tm = vcpu->arch.regs.ctr;
 	vcpu->arch.tar_tm = vcpu->arch.tar;
 	vcpu->arch.lr_tm = vcpu->arch.regs.link;
-	vcpu->arch.cr_tm = vcpu->arch.cr;
+	vcpu->arch.cr_tm = vcpu->arch.regs.ccr;
 	vcpu->arch.xer_tm = vcpu->arch.regs.xer;
 	vcpu->arch.vrsave_tm = vcpu->arch.vrsave;
 }
@@ -129,7 +129,7 @@ static inline void kvmppc_copyfrom_vcpu_tm(struct kvm_vcpu *vcpu)
 	vcpu->arch.regs.ctr = vcpu->arch.ctr_tm;
 	vcpu->arch.tar = vcpu->arch.tar_tm;
 	vcpu->arch.regs.link = vcpu->arch.lr_tm;
-	vcpu->arch.cr = vcpu->arch.cr_tm;
+	vcpu->arch.regs.ccr = vcpu->arch.cr_tm;
 	vcpu->arch.regs.xer = vcpu->arch.xer_tm;
 	vcpu->arch.vrsave = vcpu->arch.vrsave_tm;
 }
@@ -141,7 +141,7 @@ static void kvmppc_emulate_treclaim(struct kvm_vcpu *vcpu, int ra_val)
 	uint64_t texasr;
 
 	/* CR0 = 0 | MSR[TS] | 0 */
-	vcpu->arch.cr = (vcpu->arch.cr & ~(CR0_MASK << CR0_SHIFT)) |
+	vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & ~(CR0_MASK << CR0_SHIFT)) |
 		(((guest_msr & MSR_TS_MASK) >> (MSR_TS_S_LG - 1))
 		 << CR0_SHIFT);
 
@@ -220,7 +220,7 @@ void kvmppc_emulate_tabort(struct kvm_vcpu *vcpu, int ra_val)
 	tm_abort(ra_val);
 
 	/* CR0 = 0 | MSR[TS] | 0 */
-	vcpu->arch.cr = (vcpu->arch.cr & ~(CR0_MASK << CR0_SHIFT)) |
+	vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & ~(CR0_MASK << CR0_SHIFT)) |
 		(((guest_msr & MSR_TS_MASK) >> (MSR_TS_S_LG - 1))
 		 << CR0_SHIFT);
 
@@ -494,8 +494,8 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 			if (!(kvmppc_get_msr(vcpu) & MSR_PR)) {
 				preempt_disable();
-				vcpu->arch.cr = (CR0_TBEGIN_FAILURE |
-				  (vcpu->arch.cr & ~(CR0_MASK << CR0_SHIFT)));
+				vcpu->arch.regs.ccr = (CR0_TBEGIN_FAILURE |
+				  (vcpu->arch.regs.ccr & ~(CR0_MASK << CR0_SHIFT)));
 
 				vcpu->arch.texasr = (TEXASR_FS | TEXASR_EXACT |
 					(((u64)(TM_CAUSE_EMULATE | TM_CAUSE_PERSISTENT))
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index aa13728..01a0532 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -410,8 +410,8 @@ static void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
 	       vcpu->arch.shregs.sprg0, vcpu->arch.shregs.sprg1);
 	pr_err("sprg2 = %.16llx sprg3 = %.16llx\n",
 	       vcpu->arch.shregs.sprg2, vcpu->arch.shregs.sprg3);
-	pr_err("cr = %.8x  xer = %.16lx  dsisr = %.8x\n",
-	       vcpu->arch.cr, vcpu->arch.regs.xer, vcpu->arch.shregs.dsisr);
+	pr_err("cr = %.8lx  xer = %.16lx  dsisr = %.8x\n",
+	       vcpu->arch.regs.ccr, vcpu->arch.regs.xer, vcpu->arch.shregs.dsisr);
 	pr_err("dar = %.16llx\n", vcpu->arch.shregs.dar);
 	pr_err("fault dar = %.16lx dsisr = %.8x\n",
 	       vcpu->arch.fault_dar, vcpu->arch.fault_dsisr);
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 2abc336..83efc13 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1092,7 +1092,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 	ld	r5, VCPU_LR(r4)
-	lwz	r6, VCPU_CR(r4)
+	ld	r6, VCPU_CR(r4)
 	mtlr	r5
 	mtcr	r6
 
@@ -1280,7 +1280,7 @@ kvmppc_interrupt_hv:
 	std	r3, VCPU_GPR(R12)(r9)
 	/* CR is in the high half of r12 */
 	srdi	r4, r12, 32
-	stw	r4, VCPU_CR(r9)
+	std	r4, VCPU_CR(r9)
 BEGIN_FTR_SECTION
 	ld	r3, HSTATE_CFAR(r13)
 	std	r3, VCPU_CFAR(r9)
diff --git a/arch/powerpc/kvm/book3s_hv_tm.c b/arch/powerpc/kvm/book3s_hv_tm.c
index 0082850..888e260 100644
--- a/arch/powerpc/kvm/book3s_hv_tm.c
+++ b/arch/powerpc/kvm/book3s_hv_tm.c
@@ -130,7 +130,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 			return RESUME_GUEST;
 		}
 		/* Set CR0 to indicate previous transactional state */
-		vcpu->arch.cr = (vcpu->arch.cr & 0x0fffffff) |
+		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
 			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
 		/* L=1 => tresume, L=0 => tsuspend */
 		if (instr & (1 << 21)) {
@@ -174,7 +174,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 		copy_from_checkpoint(vcpu);
 
 		/* Set CR0 to indicate previous transactional state */
-		vcpu->arch.cr = (vcpu->arch.cr & 0x0fffffff) |
+		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
 			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
 		vcpu->arch.shregs.msr &= ~MSR_TS_MASK;
 		return RESUME_GUEST;
@@ -204,7 +204,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
 		copy_to_checkpoint(vcpu);
 
 		/* Set CR0 to indicate previous transactional state */
-		vcpu->arch.cr = (vcpu->arch.cr & 0x0fffffff) |
+		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
 			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
 		vcpu->arch.shregs.msr = msr | MSR_TS_S;
 		return RESUME_GUEST;
diff --git a/arch/powerpc/kvm/book3s_hv_tm_builtin.c b/arch/powerpc/kvm/book3s_hv_tm_builtin.c
index b2c7c6f..3cf5863 100644
--- a/arch/powerpc/kvm/book3s_hv_tm_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_tm_builtin.c
@@ -89,7 +89,8 @@ int kvmhv_p9_tm_emulation_early(struct kvm_vcpu *vcpu)
 		if (instr & (1 << 21))
 			vcpu->arch.shregs.msr = (msr & ~MSR_TS_MASK) | MSR_TS_T;
 		/* Set CR0 to 0b0010 */
-		vcpu->arch.cr = (vcpu->arch.cr & 0x0fffffff) | 0x20000000;
+		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
+			0x20000000;
 		return 1;
 	}
 
@@ -105,5 +106,5 @@ void kvmhv_emulate_tm_rollback(struct kvm_vcpu *vcpu)
 	vcpu->arch.shregs.msr &= ~MSR_TS_MASK;	/* go to N state */
 	vcpu->arch.regs.nip = vcpu->arch.tfhar;
 	copy_from_checkpoint(vcpu);
-	vcpu->arch.cr = (vcpu->arch.cr & 0x0fffffff) | 0xa0000000;
+	vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) | 0xa0000000;
 }
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 059683e4..4efd65d 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -167,7 +167,7 @@ void kvmppc_copy_to_svcpu(struct kvm_vcpu *vcpu)
 	svcpu->gpr[11] = vcpu->arch.regs.gpr[11];
 	svcpu->gpr[12] = vcpu->arch.regs.gpr[12];
 	svcpu->gpr[13] = vcpu->arch.regs.gpr[13];
-	svcpu->cr  = vcpu->arch.cr;
+	svcpu->cr  = vcpu->arch.regs.ccr;
 	svcpu->xer = vcpu->arch.regs.xer;
 	svcpu->ctr = vcpu->arch.regs.ctr;
 	svcpu->lr  = vcpu->arch.regs.link;
@@ -249,7 +249,7 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu)
 	vcpu->arch.regs.gpr[11] = svcpu->gpr[11];
 	vcpu->arch.regs.gpr[12] = svcpu->gpr[12];
 	vcpu->arch.regs.gpr[13] = svcpu->gpr[13];
-	vcpu->arch.cr  = svcpu->cr;
+	vcpu->arch.regs.ccr  = svcpu->cr;
 	vcpu->arch.regs.xer = svcpu->xer;
 	vcpu->arch.regs.ctr = svcpu->ctr;
 	vcpu->arch.regs.link  = svcpu->lr;
diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
index 81bd8a07..051af7d 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -182,7 +182,7 @@
 	 */
 	PPC_LL	r4, PACACURRENT(r13)
 	PPC_LL	r4, (THREAD + THREAD_KVM_VCPU)(r4)
-	stw	r10, VCPU_CR(r4)
+	PPC_STL	r10, VCPU_CR(r4)
 	PPC_STL r11, VCPU_GPR(R4)(r4)
 	PPC_STL	r5, VCPU_GPR(R5)(r4)
 	PPC_STL	r6, VCPU_GPR(R6)(r4)
@@ -292,7 +292,7 @@ _GLOBAL(kvmppc_handler_\intno\()_\srr1)
 	PPC_STL	r4, VCPU_GPR(R4)(r11)
 	PPC_LL	r4, THREAD_NORMSAVE(0)(r10)
 	PPC_STL	r5, VCPU_GPR(R5)(r11)
-	stw	r13, VCPU_CR(r11)
+	PPC_STL	r13, VCPU_CR(r11)
 	mfspr	r5, \srr0
 	PPC_STL	r3, VCPU_GPR(R10)(r11)
 	PPC_LL	r3, THREAD_NORMSAVE(2)(r10)
@@ -319,7 +319,7 @@ _GLOBAL(kvmppc_handler_\intno\()_\srr1)
 	PPC_STL	r4, VCPU_GPR(R4)(r11)
 	PPC_LL	r4, GPR9(r8)
 	PPC_STL	r5, VCPU_GPR(R5)(r11)
-	stw	r9, VCPU_CR(r11)
+	PPC_STL	r9, VCPU_CR(r11)
 	mfspr	r5, \srr0
 	PPC_STL	r3, VCPU_GPR(R8)(r11)
 	PPC_LL	r3, GPR10(r8)
@@ -643,7 +643,7 @@ lightweight_exit:
 	PPC_LL	r3, VCPU_LR(r4)
 	PPC_LL	r5, VCPU_XER(r4)
 	PPC_LL	r6, VCPU_CTR(r4)
-	lwz	r7, VCPU_CR(r4)
+	PPC_LL	r7, VCPU_CR(r4)
 	PPC_LL	r8, VCPU_PC(r4)
 	PPC_LD(r9, VCPU_SHARED_MSR, r11)
 	PPC_LL	r0, VCPU_GPR(R0)(r4)
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index 75dce1e..f91b130 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -117,7 +117,6 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 	emulated = EMULATE_FAIL;
 	vcpu->arch.regs.msr = vcpu->arch.shared->msr;
-	vcpu->arch.regs.ccr = vcpu->arch.cr;
 	if (analyse_instr(&op, &vcpu->arch.regs, inst) == 0) {
 		int type = op.type & INSTR_TYPE_MASK;
 		int size = GETSIZE(op.type);
-- 
2.7.4


Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CDDF2B7091
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:06 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 02/27] KVM: PPC: Convert MSR to shared page
Date: Thu,  1 Jul 2010 12:42:37 +0200
Message-Id: <1277980982-12433-3-git-send-email-agraf@suse.de>
In-Reply-To: <1277980982-12433-1-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
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

One of the most obvious registers to share with the guest directly is the
MSR. The MSR contains the "interrupts enabled" flag which the guest has to
toggle in critical sections.

So in order to bring the overhead of interrupt en- and disabling down, let's
put msr into the shared page. Keep in mind that even though you can fully read
its contents, writing to it doesn't always update all state. There are a few
safe fields that don't require hypervisor interaction. See the documentation
for a list of MSR bits that are safe to be set from inside the guest.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm_host.h      |    1 -
 arch/powerpc/include/asm/kvm_para.h      |    1 +
 arch/powerpc/kernel/asm-offsets.c        |    2 +-
 arch/powerpc/kvm/44x_tlb.c               |    8 ++--
 arch/powerpc/kvm/book3s.c                |   65 ++++++++++++++++--------------
 arch/powerpc/kvm/book3s_32_mmu.c         |   12 +++---
 arch/powerpc/kvm/book3s_32_mmu_host.c    |    4 +-
 arch/powerpc/kvm/book3s_64_mmu.c         |   12 +++---
 arch/powerpc/kvm/book3s_64_mmu_host.c    |    4 +-
 arch/powerpc/kvm/book3s_emulate.c        |    9 ++--
 arch/powerpc/kvm/book3s_paired_singles.c |    7 ++-
 arch/powerpc/kvm/booke.c                 |   20 +++++-----
 arch/powerpc/kvm/booke.h                 |    6 +-
 arch/powerpc/kvm/booke_emulate.c         |    6 +-
 arch/powerpc/kvm/booke_interrupts.S      |    3 +-
 arch/powerpc/kvm/e500_tlb.c              |   12 +++---
 arch/powerpc/kvm/e500_tlb.h              |    2 +-
 arch/powerpc/kvm/powerpc.c               |    3 +-
 18 files changed, 93 insertions(+), 84 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 246a3dd..c7aee42 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -210,7 +210,6 @@ struct kvm_vcpu_arch {
 	u32 cr;
 #endif
 
-	ulong msr;
 #ifdef CONFIG_PPC_BOOK3S
 	ulong shadow_msr;
 	ulong hflags;
diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/asm/kvm_para.h
index 1485ba8..a17dc52 100644
--- a/arch/powerpc/include/asm/kvm_para.h
+++ b/arch/powerpc/include/asm/kvm_para.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 struct kvm_vcpu_arch_shared {
+	__u64 msr;
 };
 
 #ifdef __KERNEL__
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 944f593..a55d47e 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -394,13 +394,13 @@ int main(void)
 	DEFINE(VCPU_HOST_STACK, offsetof(struct kvm_vcpu, arch.host_stack));
 	DEFINE(VCPU_HOST_PID, offsetof(struct kvm_vcpu, arch.host_pid));
 	DEFINE(VCPU_GPRS, offsetof(struct kvm_vcpu, arch.gpr));
-	DEFINE(VCPU_MSR, offsetof(struct kvm_vcpu, arch.msr));
 	DEFINE(VCPU_SPRG4, offsetof(struct kvm_vcpu, arch.sprg4));
 	DEFINE(VCPU_SPRG5, offsetof(struct kvm_vcpu, arch.sprg5));
 	DEFINE(VCPU_SPRG6, offsetof(struct kvm_vcpu, arch.sprg6));
 	DEFINE(VCPU_SPRG7, offsetof(struct kvm_vcpu, arch.sprg7));
 	DEFINE(VCPU_SHADOW_PID, offsetof(struct kvm_vcpu, arch.shadow_pid));
 	DEFINE(VCPU_SHARED, offsetof(struct kvm_vcpu, arch.shared));
+	DEFINE(VCPU_SHARED_MSR, offsetof(struct kvm_vcpu_arch_shared, msr));
 
 	/* book3s */
 #ifdef CONFIG_PPC_BOOK3S
diff --git a/arch/powerpc/kvm/44x_tlb.c b/arch/powerpc/kvm/44x_tlb.c
index 8123125..4cbbca7 100644
--- a/arch/powerpc/kvm/44x_tlb.c
+++ b/arch/powerpc/kvm/44x_tlb.c
@@ -221,14 +221,14 @@ gpa_t kvmppc_mmu_xlate(struct kvm_vcpu *vcpu, unsigned int gtlb_index,
 
 int kvmppc_mmu_itlb_index(struct kvm_vcpu *vcpu, gva_t eaddr)
 {
-	unsigned int as = !!(vcpu->arch.msr & MSR_IS);
+	unsigned int as = !!(vcpu->arch.shared->msr & MSR_IS);
 
 	return kvmppc_44x_tlb_index(vcpu, eaddr, vcpu->arch.pid, as);
 }
 
 int kvmppc_mmu_dtlb_index(struct kvm_vcpu *vcpu, gva_t eaddr)
 {
-	unsigned int as = !!(vcpu->arch.msr & MSR_DS);
+	unsigned int as = !!(vcpu->arch.shared->msr & MSR_DS);
 
 	return kvmppc_44x_tlb_index(vcpu, eaddr, vcpu->arch.pid, as);
 }
@@ -353,7 +353,7 @@ void kvmppc_mmu_map(struct kvm_vcpu *vcpu, u64 gvaddr, gpa_t gpaddr,
 
 	stlbe.word1 = (hpaddr & 0xfffffc00) | ((hpaddr >> 32) & 0xf);
 	stlbe.word2 = kvmppc_44x_tlb_shadow_attrib(flags,
-	                                            vcpu->arch.msr & MSR_PR);
+	                                            vcpu->arch.shared->msr & MSR_PR);
 	stlbe.tid = !(asid & 0xff);
 
 	/* Keep track of the reference so we can properly release it later. */
@@ -422,7 +422,7 @@ static int tlbe_is_host_safe(const struct kvm_vcpu *vcpu,
 
 	/* Does it match current guest AS? */
 	/* XXX what about IS != DS? */
-	if (get_tlb_ts(tlbe) != !!(vcpu->arch.msr & MSR_IS))
+	if (get_tlb_ts(tlbe) != !!(vcpu->arch.shared->msr & MSR_IS))
 		return 0;
 
 	gpa = get_tlb_raddr(tlbe);
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 2c2c3ca..38cca77 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -115,31 +115,31 @@ static u32 kvmppc_get_dec(struct kvm_vcpu *vcpu)
 
 static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
 {
-	vcpu->arch.shadow_msr = vcpu->arch.msr;
+	ulong smsr = vcpu->arch.shared->msr;
+
 	/* Guest MSR values */
-	vcpu->arch.shadow_msr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE |
-				 MSR_BE | MSR_DE;
+	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE | MSR_DE;
 	/* Process MSR values */
-	vcpu->arch.shadow_msr |= MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_PR |
-				 MSR_EE;
+	smsr |= MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_PR | MSR_EE;
 	/* External providers the guest reserved */
-	vcpu->arch.shadow_msr |= (vcpu->arch.msr & vcpu->arch.guest_owned_ext);
+	smsr |= (vcpu->arch.shared->msr & vcpu->arch.guest_owned_ext);
 	/* 64-bit Process MSR values */
 #ifdef CONFIG_PPC_BOOK3S_64
-	vcpu->arch.shadow_msr |= MSR_ISF | MSR_HV;
+	smsr |= MSR_ISF | MSR_HV;
 #endif
+	vcpu->arch.shadow_msr = smsr;
 }
 
 void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
 {
-	ulong old_msr = vcpu->arch.msr;
+	ulong old_msr = vcpu->arch.shared->msr;
 
 #ifdef EXIT_DEBUG
 	printk(KERN_INFO "KVM: Set MSR to 0x%llx\n", msr);
 #endif
 
 	msr &= to_book3s(vcpu)->msr_mask;
-	vcpu->arch.msr = msr;
+	vcpu->arch.shared->msr = msr;
 	kvmppc_recalc_shadow_msr(vcpu);
 
 	if (msr & (MSR_WE|MSR_POW)) {
@@ -149,21 +149,21 @@ void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
 		}
 	}
 
-	if ((vcpu->arch.msr & (MSR_PR|MSR_IR|MSR_DR)) !=
+	if ((vcpu->arch.shared->msr & (MSR_PR|MSR_IR|MSR_DR)) !=
 		   (old_msr & (MSR_PR|MSR_IR|MSR_DR))) {
 		kvmppc_mmu_flush_segments(vcpu);
 		kvmppc_mmu_map_segment(vcpu, kvmppc_get_pc(vcpu));
 	}
 
 	/* Preload FPU if it's enabled */
-	if (vcpu->arch.msr & MSR_FP)
+	if (vcpu->arch.shared->msr & MSR_FP)
 		kvmppc_handle_ext(vcpu, BOOK3S_INTERRUPT_FP_UNAVAIL, MSR_FP);
 }
 
 void kvmppc_inject_interrupt(struct kvm_vcpu *vcpu, int vec, u64 flags)
 {
 	vcpu->arch.srr0 = kvmppc_get_pc(vcpu);
-	vcpu->arch.srr1 = vcpu->arch.msr | flags;
+	vcpu->arch.srr1 = vcpu->arch.shared->msr | flags;
 	kvmppc_set_pc(vcpu, to_book3s(vcpu)->hior + vec);
 	vcpu->arch.mmu.reset_msr(vcpu);
 }
@@ -254,11 +254,11 @@ int kvmppc_book3s_irqprio_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 
 	switch (priority) {
 	case BOOK3S_IRQPRIO_DECREMENTER:
-		deliver = vcpu->arch.msr & MSR_EE;
+		deliver = vcpu->arch.shared->msr & MSR_EE;
 		vec = BOOK3S_INTERRUPT_DECREMENTER;
 		break;
 	case BOOK3S_IRQPRIO_EXTERNAL:
-		deliver = vcpu->arch.msr & MSR_EE;
+		deliver = vcpu->arch.shared->msr & MSR_EE;
 		vec = BOOK3S_INTERRUPT_EXTERNAL;
 		break;
 	case BOOK3S_IRQPRIO_SYSTEM_RESET:
@@ -437,7 +437,7 @@ static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
 static int kvmppc_xlate(struct kvm_vcpu *vcpu, ulong eaddr, bool data,
 			 struct kvmppc_pte *pte)
 {
-	int relocated = (vcpu->arch.msr & (data ? MSR_DR : MSR_IR));
+	int relocated = (vcpu->arch.shared->msr & (data ? MSR_DR : MSR_IR));
 	int r;
 
 	if (relocated) {
@@ -545,8 +545,8 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	int page_found = 0;
 	struct kvmppc_pte pte;
 	bool is_mmio = false;
-	bool dr = (vcpu->arch.msr & MSR_DR) ? true : false;
-	bool ir = (vcpu->arch.msr & MSR_IR) ? true : false;
+	bool dr = (vcpu->arch.shared->msr & MSR_DR) ? true : false;
+	bool ir = (vcpu->arch.shared->msr & MSR_IR) ? true : false;
 	u64 vsid;
 
 	relocated = data ? dr : ir;
@@ -563,7 +563,7 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		pte.vpage = eaddr >> 12;
 	}
 
-	switch (vcpu->arch.msr & (MSR_DR|MSR_IR)) {
+	switch (vcpu->arch.shared->msr & (MSR_DR|MSR_IR)) {
 	case 0:
 		pte.vpage |= ((u64)VSID_REAL << (SID_SHIFT - 12));
 		break;
@@ -571,7 +571,7 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	case MSR_IR:
 		vcpu->arch.mmu.esid_to_vsid(vcpu, eaddr >> SID_SHIFT, &vsid);
 
-		if ((vcpu->arch.msr & (MSR_DR|MSR_IR)) == MSR_DR)
+		if ((vcpu->arch.shared->msr & (MSR_DR|MSR_IR)) == MSR_DR)
 			pte.vpage |= ((u64)VSID_REAL_DR << (SID_SHIFT - 12));
 		else
 			pte.vpage |= ((u64)VSID_REAL_IR << (SID_SHIFT - 12));
@@ -596,14 +596,16 @@ int kvmppc_handle_pagefault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		/* Page not found in guest PTE entries */
 		vcpu->arch.dear = kvmppc_get_fault_dar(vcpu);
 		to_book3s(vcpu)->dsisr = to_svcpu(vcpu)->fault_dsisr;
-		vcpu->arch.msr |= (to_svcpu(vcpu)->shadow_srr1 & 0x00000000f8000000ULL);
+		vcpu->arch.shared->msr |=
+			(to_svcpu(vcpu)->shadow_srr1 & 0x00000000f8000000ULL);
 		kvmppc_book3s_queue_irqprio(vcpu, vec);
 	} else if (page_found == -EPERM) {
 		/* Storage protection */
 		vcpu->arch.dear = kvmppc_get_fault_dar(vcpu);
 		to_book3s(vcpu)->dsisr = to_svcpu(vcpu)->fault_dsisr & ~DSISR_NOHPTE;
 		to_book3s(vcpu)->dsisr |= DSISR_PROTFAULT;
-		vcpu->arch.msr |= (to_svcpu(vcpu)->shadow_srr1 & 0x00000000f8000000ULL);
+		vcpu->arch.shared->msr |=
+			(to_svcpu(vcpu)->shadow_srr1 & 0x00000000f8000000ULL);
 		kvmppc_book3s_queue_irqprio(vcpu, vec);
 	} else if (page_found == -EINVAL) {
 		/* Page not found in guest SLB */
@@ -695,9 +697,11 @@ static int kvmppc_read_inst(struct kvm_vcpu *vcpu)
 
 	ret = kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
 	if (ret == -ENOENT) {
-		vcpu->arch.msr = kvmppc_set_field(vcpu->arch.msr, 33, 33, 1);
-		vcpu->arch.msr = kvmppc_set_field(vcpu->arch.msr, 34, 36, 0);
-		vcpu->arch.msr = kvmppc_set_field(vcpu->arch.msr, 42, 47, 0);
+		ulong msr = vcpu->arch.shared->msr;
+
+		msr = kvmppc_set_field(msr, 33, 33, 1);
+		msr = kvmppc_set_field(msr, 34, 36, 0);
+		vcpu->arch.shared->msr = kvmppc_set_field(msr, 42, 47, 0);
 		kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_INST_STORAGE);
 		return EMULATE_AGAIN;
 	}
@@ -736,7 +740,7 @@ static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int exit_nr,
 	if (vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE)
 		return RESUME_GUEST;
 
-	if (!(vcpu->arch.msr & msr)) {
+	if (!(vcpu->arch.shared->msr & msr)) {
 		kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
 		return RESUME_GUEST;
 	}
@@ -804,7 +808,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	if ((exit_nr != 0x900) && (exit_nr != 0x500))
 		printk(KERN_EMERG "exit_nr=0x%x | pc=0x%lx | dar=0x%lx | msr=0x%lx\n",
 			exit_nr, kvmppc_get_pc(vcpu), kvmppc_get_fault_dar(vcpu),
-			vcpu->arch.msr);
+			vcpu->arch.shared->msr);
 #endif
 	kvm_resched(vcpu);
 	switch (exit_nr) {
@@ -836,7 +840,8 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			kvmppc_mmu_pte_flush(vcpu, kvmppc_get_pc(vcpu), ~0xFFFUL);
 			r = RESUME_GUEST;
 		} else {
-			vcpu->arch.msr |= to_svcpu(vcpu)->shadow_srr1 & 0x58000000;
+			vcpu->arch.shared->msr |=
+				to_svcpu(vcpu)->shadow_srr1 & 0x58000000;
 			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
 			kvmppc_mmu_pte_flush(vcpu, kvmppc_get_pc(vcpu), ~0xFFFUL);
 			r = RESUME_GUEST;
@@ -904,7 +909,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 program_interrupt:
 		flags = to_svcpu(vcpu)->shadow_srr1 & 0x1f0000ull;
 
-		if (vcpu->arch.msr & MSR_PR) {
+		if (vcpu->arch.shared->msr & MSR_PR) {
 #ifdef EXIT_DEBUG
 			printk(KERN_INFO "Userspace triggered 0x700 exception at 0x%lx (0x%x)\n", kvmppc_get_pc(vcpu), kvmppc_get_last_inst(vcpu));
 #endif
@@ -1052,7 +1057,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->ctr = kvmppc_get_ctr(vcpu);
 	regs->lr = kvmppc_get_lr(vcpu);
 	regs->xer = kvmppc_get_xer(vcpu);
-	regs->msr = vcpu->arch.msr;
+	regs->msr = vcpu->arch.shared->msr;
 	regs->srr0 = vcpu->arch.srr0;
 	regs->srr1 = vcpu->arch.srr1;
 	regs->pid = vcpu->arch.pid;
@@ -1358,7 +1363,7 @@ int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	local_irq_enable();
 
 	/* Preload FPU if it's enabled */
-	if (vcpu->arch.msr & MSR_FP)
+	if (vcpu->arch.shared->msr & MSR_FP)
 		kvmppc_handle_ext(vcpu, BOOK3S_INTERRUPT_FP_UNAVAIL, MSR_FP);
 
 	ret = __kvmppc_vcpu_entry(kvm_run, vcpu);
diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
index 079760b..41130c8 100644
--- a/arch/powerpc/kvm/book3s_32_mmu.c
+++ b/arch/powerpc/kvm/book3s_32_mmu.c
@@ -133,7 +133,7 @@ static int kvmppc_mmu_book3s_32_xlate_bat(struct kvm_vcpu *vcpu, gva_t eaddr,
 		else
 			bat = &vcpu_book3s->ibat[i];
 
-		if (vcpu->arch.msr & MSR_PR) {
+		if (vcpu->arch.shared->msr & MSR_PR) {
 			if (!bat->vp)
 				continue;
 		} else {
@@ -214,8 +214,8 @@ static int kvmppc_mmu_book3s_32_xlate_pte(struct kvm_vcpu *vcpu, gva_t eaddr,
 			pte->raddr = (pteg[i+1] & ~(0xFFFULL)) | (eaddr & 0xFFF);
 			pp = pteg[i+1] & 3;
 
-			if ((sre->Kp &&  (vcpu->arch.msr & MSR_PR)) ||
-			    (sre->Ks && !(vcpu->arch.msr & MSR_PR)))
+			if ((sre->Kp &&  (vcpu->arch.shared->msr & MSR_PR)) ||
+			    (sre->Ks && !(vcpu->arch.shared->msr & MSR_PR)))
 				pp |= 4;
 
 			pte->may_write = false;
@@ -334,7 +334,7 @@ static int kvmppc_mmu_book3s_32_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 	struct kvmppc_sr *sr;
 	u64 gvsid = esid;
 
-	if (vcpu->arch.msr & (MSR_DR|MSR_IR)) {
+	if (vcpu->arch.shared->msr & (MSR_DR|MSR_IR)) {
 		sr = find_sr(to_book3s(vcpu), ea);
 		if (sr->valid)
 			gvsid = sr->vsid;
@@ -343,7 +343,7 @@ static int kvmppc_mmu_book3s_32_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 	/* In case we only have one of MSR_IR or MSR_DR set, let's put
 	   that in the real-mode context (and hope RM doesn't access
 	   high memory) */
-	switch (vcpu->arch.msr & (MSR_DR|MSR_IR)) {
+	switch (vcpu->arch.shared->msr & (MSR_DR|MSR_IR)) {
 	case 0:
 		*vsid = VSID_REAL | esid;
 		break;
@@ -363,7 +363,7 @@ static int kvmppc_mmu_book3s_32_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 		BUG();
 	}
 
-	if (vcpu->arch.msr & MSR_PR)
+	if (vcpu->arch.shared->msr & MSR_PR)
 		*vsid |= VSID_PR;
 
 	return 0;
diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
index 0b51ef8..67b8c38 100644
--- a/arch/powerpc/kvm/book3s_32_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
@@ -86,7 +86,7 @@ static struct kvmppc_sid_map *find_sid_vsid(struct kvm_vcpu *vcpu, u64 gvsid)
 	struct kvmppc_sid_map *map;
 	u16 sid_map_mask;
 
-	if (vcpu->arch.msr & MSR_PR)
+	if (vcpu->arch.shared->msr & MSR_PR)
 		gvsid |= VSID_PR;
 
 	sid_map_mask = kvmppc_sid_hash(vcpu, gvsid);
@@ -253,7 +253,7 @@ static struct kvmppc_sid_map *create_sid_map(struct kvm_vcpu *vcpu, u64 gvsid)
 	u16 sid_map_mask;
 	static int backwards_map = 0;
 
-	if (vcpu->arch.msr & MSR_PR)
+	if (vcpu->arch.shared->msr & MSR_PR)
 		gvsid |= VSID_PR;
 
 	/* We might get collisions that trap in preceding order, so let's
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 4025ea2..58aa840 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -180,9 +180,9 @@ do_second:
 		goto no_page_found;
 	}
 
-	if ((vcpu->arch.msr & MSR_PR) && slbe->Kp)
+	if ((vcpu->arch.shared->msr & MSR_PR) && slbe->Kp)
 		key = 4;
-	else if (!(vcpu->arch.msr & MSR_PR) && slbe->Ks)
+	else if (!(vcpu->arch.shared->msr & MSR_PR) && slbe->Ks)
 		key = 4;
 
 	for (i=0; i<16; i+=2) {
@@ -381,7 +381,7 @@ static void kvmppc_mmu_book3s_64_slbia(struct kvm_vcpu *vcpu)
 	for (i = 1; i < vcpu_book3s->slb_nr; i++)
 		vcpu_book3s->slb[i].valid = false;
 
-	if (vcpu->arch.msr & MSR_IR) {
+	if (vcpu->arch.shared->msr & MSR_IR) {
 		kvmppc_mmu_flush_segments(vcpu);
 		kvmppc_mmu_map_segment(vcpu, kvmppc_get_pc(vcpu));
 	}
@@ -446,13 +446,13 @@ static int kvmppc_mmu_book3s_64_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 	struct kvmppc_slb *slb;
 	u64 gvsid = esid;
 
-	if (vcpu->arch.msr & (MSR_DR|MSR_IR)) {
+	if (vcpu->arch.shared->msr & (MSR_DR|MSR_IR)) {
 		slb = kvmppc_mmu_book3s_64_find_slbe(to_book3s(vcpu), ea);
 		if (slb)
 			gvsid = slb->vsid;
 	}
 
-	switch (vcpu->arch.msr & (MSR_DR|MSR_IR)) {
+	switch (vcpu->arch.shared->msr & (MSR_DR|MSR_IR)) {
 	case 0:
 		*vsid = VSID_REAL | esid;
 		break;
@@ -473,7 +473,7 @@ static int kvmppc_mmu_book3s_64_esid_to_vsid(struct kvm_vcpu *vcpu, ulong esid,
 		break;
 	}
 
-	if (vcpu->arch.msr & MSR_PR)
+	if (vcpu->arch.shared->msr & MSR_PR)
 		*vsid |= VSID_PR;
 
 	return 0;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_host.c b/arch/powerpc/kvm/book3s_64_mmu_host.c
index 384179a..71c1f90 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_host.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_host.c
@@ -66,7 +66,7 @@ static struct kvmppc_sid_map *find_sid_vsid(struct kvm_vcpu *vcpu, u64 gvsid)
 	struct kvmppc_sid_map *map;
 	u16 sid_map_mask;
 
-	if (vcpu->arch.msr & MSR_PR)
+	if (vcpu->arch.shared->msr & MSR_PR)
 		gvsid |= VSID_PR;
 
 	sid_map_mask = kvmppc_sid_hash(vcpu, gvsid);
@@ -191,7 +191,7 @@ static struct kvmppc_sid_map *create_sid_map(struct kvm_vcpu *vcpu, u64 gvsid)
 	u16 sid_map_mask;
 	static int backwards_map = 0;
 
-	if (vcpu->arch.msr & MSR_PR)
+	if (vcpu->arch.shared->msr & MSR_PR)
 		gvsid |= VSID_PR;
 
 	/* We might get collisions that trap in preceding order, so let's
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index c85f906..35d3c16 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -86,14 +86,15 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	case 31:
 		switch (get_xop(inst)) {
 		case OP_31_XOP_MFMSR:
-			kvmppc_set_gpr(vcpu, get_rt(inst), vcpu->arch.msr);
+			kvmppc_set_gpr(vcpu, get_rt(inst),
+				       vcpu->arch.shared->msr);
 			break;
 		case OP_31_XOP_MTMSRD:
 		{
 			ulong rs = kvmppc_get_gpr(vcpu, get_rs(inst));
 			if (inst & 0x10000) {
-				vcpu->arch.msr &= ~(MSR_RI | MSR_EE);
-				vcpu->arch.msr |= rs & (MSR_RI | MSR_EE);
+				vcpu->arch.shared->msr &= ~(MSR_RI | MSR_EE);
+				vcpu->arch.shared->msr |= rs & (MSR_RI | MSR_EE);
 			} else
 				kvmppc_set_msr(vcpu, rs);
 			break;
@@ -204,7 +205,7 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				ra = kvmppc_get_gpr(vcpu, get_ra(inst));
 
 			addr = (ra + rb) & ~31ULL;
-			if (!(vcpu->arch.msr & MSR_SF))
+			if (!(vcpu->arch.shared->msr & MSR_SF))
 				addr &= 0xffffffff;
 			vaddr = addr;
 
diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index 474f2e2..626e6ef 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -165,9 +165,10 @@ static inline void kvmppc_sync_qpr(struct kvm_vcpu *vcpu, int rt)
 static void kvmppc_inject_pf(struct kvm_vcpu *vcpu, ulong eaddr, bool is_store)
 {
 	u64 dsisr;
+	struct kvm_vcpu_arch_shared *shared = vcpu->arch.shared;
 
-	vcpu->arch.msr = kvmppc_set_field(vcpu->arch.msr, 33, 36, 0);
-	vcpu->arch.msr = kvmppc_set_field(vcpu->arch.msr, 42, 47, 0);
+	shared->msr = kvmppc_set_field(shared->msr, 33, 36, 0);
+	shared->msr = kvmppc_set_field(shared->msr, 42, 47, 0);
 	vcpu->arch.dear = eaddr;
 	/* Page Fault */
 	dsisr = kvmppc_set_field(0, 33, 33, 1);
@@ -658,7 +659,7 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	if (!kvmppc_inst_is_paired_single(vcpu, inst))
 		return EMULATE_FAIL;
 
-	if (!(vcpu->arch.msr & MSR_FP)) {
+	if (!(vcpu->arch.shared->msr & MSR_FP)) {
 		kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_FP_UNAVAIL);
 		return EMULATE_AGAIN;
 	}
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 376b586..ddb4cac 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -62,7 +62,7 @@ void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu)
 {
 	int i;
 
-	printk("pc:   %08lx msr:  %08lx\n", vcpu->arch.pc, vcpu->arch.msr);
+	printk("pc:   %08lx msr:  %08llx\n", vcpu->arch.pc, vcpu->arch.shared->msr);
 	printk("lr:   %08lx ctr:  %08lx\n", vcpu->arch.lr, vcpu->arch.ctr);
 	printk("srr0: %08lx srr1: %08lx\n", vcpu->arch.srr0, vcpu->arch.srr1);
 
@@ -169,34 +169,34 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 		break;
 	case BOOKE_IRQPRIO_CRITICAL:
 	case BOOKE_IRQPRIO_WATCHDOG:
-		allowed = vcpu->arch.msr & MSR_CE;
+		allowed = vcpu->arch.shared->msr & MSR_CE;
 		msr_mask = MSR_ME;
 		break;
 	case BOOKE_IRQPRIO_MACHINE_CHECK:
-		allowed = vcpu->arch.msr & MSR_ME;
+		allowed = vcpu->arch.shared->msr & MSR_ME;
 		msr_mask = 0;
 		break;
 	case BOOKE_IRQPRIO_EXTERNAL:
 	case BOOKE_IRQPRIO_DECREMENTER:
 	case BOOKE_IRQPRIO_FIT:
-		allowed = vcpu->arch.msr & MSR_EE;
+		allowed = vcpu->arch.shared->msr & MSR_EE;
 		msr_mask = MSR_CE|MSR_ME|MSR_DE;
 		break;
 	case BOOKE_IRQPRIO_DEBUG:
-		allowed = vcpu->arch.msr & MSR_DE;
+		allowed = vcpu->arch.shared->msr & MSR_DE;
 		msr_mask = MSR_ME;
 		break;
 	}
 
 	if (allowed) {
 		vcpu->arch.srr0 = vcpu->arch.pc;
-		vcpu->arch.srr1 = vcpu->arch.msr;
+		vcpu->arch.srr1 = vcpu->arch.shared->msr;
 		vcpu->arch.pc = vcpu->arch.ivpr | vcpu->arch.ivor[priority];
 		if (update_esr == true)
 			vcpu->arch.esr = vcpu->arch.queued_esr;
 		if (update_dear == true)
 			vcpu->arch.dear = vcpu->arch.queued_dear;
-		kvmppc_set_msr(vcpu, vcpu->arch.msr & msr_mask);
+		kvmppc_set_msr(vcpu, vcpu->arch.shared->msr & msr_mask);
 
 		clear_bit(priority, &vcpu->arch.pending_exceptions);
 	}
@@ -265,7 +265,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 
 	case BOOKE_INTERRUPT_PROGRAM:
-		if (vcpu->arch.msr & MSR_PR) {
+		if (vcpu->arch.shared->msr & MSR_PR) {
 			/* Program traps generated by user-level software must be handled
 			 * by the guest kernel. */
 			kvmppc_core_queue_program(vcpu, vcpu->arch.fault_esr);
@@ -467,7 +467,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.pc = 0;
-	vcpu->arch.msr = 0;
+	vcpu->arch.shared->msr = 0;
 	kvmppc_set_gpr(vcpu, 1, (16<<20) - 8); /* -8 for the callee-save LR slot */
 
 	vcpu->arch.shadow_pid = 1;
@@ -490,7 +490,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->ctr = vcpu->arch.ctr;
 	regs->lr = vcpu->arch.lr;
 	regs->xer = kvmppc_get_xer(vcpu);
-	regs->msr = vcpu->arch.msr;
+	regs->msr = vcpu->arch.shared->msr;
 	regs->srr0 = vcpu->arch.srr0;
 	regs->srr1 = vcpu->arch.srr1;
 	regs->pid = vcpu->arch.pid;
diff --git a/arch/powerpc/kvm/booke.h b/arch/powerpc/kvm/booke.h
index d59bcca..88258ac 100644
--- a/arch/powerpc/kvm/booke.h
+++ b/arch/powerpc/kvm/booke.h
@@ -54,12 +54,12 @@ extern unsigned long kvmppc_booke_handlers;
  * changing. */
 static inline void kvmppc_set_msr(struct kvm_vcpu *vcpu, u32 new_msr)
 {
-	if ((new_msr & MSR_PR) != (vcpu->arch.msr & MSR_PR))
+	if ((new_msr & MSR_PR) != (vcpu->arch.shared->msr & MSR_PR))
 		kvmppc_mmu_priv_switch(vcpu, new_msr & MSR_PR);
 
-	vcpu->arch.msr = new_msr;
+	vcpu->arch.shared->msr = new_msr;
 
-	if (vcpu->arch.msr & MSR_WE) {
+	if (vcpu->arch.shared->msr & MSR_WE) {
 		kvm_vcpu_block(vcpu);
 		kvmppc_set_exit_type(vcpu, EMULATED_MTMSRWE_EXITS);
 	};
diff --git a/arch/powerpc/kvm/booke_emulate.c b/arch/powerpc/kvm/booke_emulate.c
index cbc790e..b115203 100644
--- a/arch/powerpc/kvm/booke_emulate.c
+++ b/arch/powerpc/kvm/booke_emulate.c
@@ -62,7 +62,7 @@ int kvmppc_booke_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 		case OP_31_XOP_MFMSR:
 			rt = get_rt(inst);
-			kvmppc_set_gpr(vcpu, rt, vcpu->arch.msr);
+			kvmppc_set_gpr(vcpu, rt, vcpu->arch.shared->msr);
 			kvmppc_set_exit_type(vcpu, EMULATED_MFMSR_EXITS);
 			break;
 
@@ -74,13 +74,13 @@ int kvmppc_booke_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 		case OP_31_XOP_WRTEE:
 			rs = get_rs(inst);
-			vcpu->arch.msr = (vcpu->arch.msr & ~MSR_EE)
+			vcpu->arch.shared->msr = (vcpu->arch.shared->msr & ~MSR_EE)
 					| (kvmppc_get_gpr(vcpu, rs) & MSR_EE);
 			kvmppc_set_exit_type(vcpu, EMULATED_WRTEE_EXITS);
 			break;
 
 		case OP_31_XOP_WRTEEI:
-			vcpu->arch.msr = (vcpu->arch.msr & ~MSR_EE)
+			vcpu->arch.shared->msr = (vcpu->arch.shared->msr & ~MSR_EE)
 							 | (inst & MSR_EE);
 			kvmppc_set_exit_type(vcpu, EMULATED_WRTEE_EXITS);
 			break;
diff --git a/arch/powerpc/kvm/booke_interrupts.S b/arch/powerpc/kvm/booke_interrupts.S
index 380a78c..0498469 100644
--- a/arch/powerpc/kvm/booke_interrupts.S
+++ b/arch/powerpc/kvm/booke_interrupts.S
@@ -415,7 +415,8 @@ lightweight_exit:
 	lwz	r8, VCPU_GPR(r8)(r4)
 	lwz	r3, VCPU_PC(r4)
 	mtsrr0	r3
-	lwz	r3, VCPU_MSR(r4)
+	lwz	r3, VCPU_SHARED(r4)
+	lwz	r3, VCPU_SHARED_MSR(r3)
 	oris	r3, r3, KVMPPC_MSR_MASK@h
 	ori	r3, r3, KVMPPC_MSR_MASK@l
 	mtsrr1	r3
diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index f11ca0f..66845a5 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -317,10 +317,10 @@ static inline void kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 		| MAS1_TID(get_tlb_tid(gtlbe)) | MAS1_TS | MAS1_VALID;
 	stlbe->mas2 = (gvaddr & MAS2_EPN)
 		| e500_shadow_mas2_attrib(gtlbe->mas2,
-				vcpu_e500->vcpu.arch.msr & MSR_PR);
+				vcpu_e500->vcpu.arch.shared->msr & MSR_PR);
 	stlbe->mas3 = (hpaddr & MAS3_RPN)
 		| e500_shadow_mas3_attrib(gtlbe->mas3,
-				vcpu_e500->vcpu.arch.msr & MSR_PR);
+				vcpu_e500->vcpu.arch.shared->msr & MSR_PR);
 	stlbe->mas7 = (hpaddr >> 32) & MAS7_RPN;
 
 	trace_kvm_stlb_write(index_of(tlbsel, esel), stlbe->mas1, stlbe->mas2,
@@ -579,28 +579,28 @@ int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu)
 
 int kvmppc_mmu_itlb_index(struct kvm_vcpu *vcpu, gva_t eaddr)
 {
-	unsigned int as = !!(vcpu->arch.msr & MSR_IS);
+	unsigned int as = !!(vcpu->arch.shared->msr & MSR_IS);
 
 	return kvmppc_e500_tlb_search(vcpu, eaddr, get_cur_pid(vcpu), as);
 }
 
 int kvmppc_mmu_dtlb_index(struct kvm_vcpu *vcpu, gva_t eaddr)
 {
-	unsigned int as = !!(vcpu->arch.msr & MSR_DS);
+	unsigned int as = !!(vcpu->arch.shared->msr & MSR_DS);
 
 	return kvmppc_e500_tlb_search(vcpu, eaddr, get_cur_pid(vcpu), as);
 }
 
 void kvmppc_mmu_itlb_miss(struct kvm_vcpu *vcpu)
 {
-	unsigned int as = !!(vcpu->arch.msr & MSR_IS);
+	unsigned int as = !!(vcpu->arch.shared->msr & MSR_IS);
 
 	kvmppc_e500_deliver_tlb_miss(vcpu, vcpu->arch.pc, as);
 }
 
 void kvmppc_mmu_dtlb_miss(struct kvm_vcpu *vcpu)
 {
-	unsigned int as = !!(vcpu->arch.msr & MSR_DS);
+	unsigned int as = !!(vcpu->arch.shared->msr & MSR_DS);
 
 	kvmppc_e500_deliver_tlb_miss(vcpu, vcpu->arch.fault_dear, as);
 }
diff --git a/arch/powerpc/kvm/e500_tlb.h b/arch/powerpc/kvm/e500_tlb.h
index d28e301..458946b 100644
--- a/arch/powerpc/kvm/e500_tlb.h
+++ b/arch/powerpc/kvm/e500_tlb.h
@@ -171,7 +171,7 @@ static inline int tlbe_is_host_safe(const struct kvm_vcpu *vcpu,
 
 	/* Does it match current guest AS? */
 	/* XXX what about IS != DS? */
-	if (get_tlb_ts(tlbe) != !!(vcpu->arch.msr & MSR_IS))
+	if (get_tlb_ts(tlbe) != !!(vcpu->arch.shared->msr & MSR_IS))
 		return 0;
 
 	gpa = get_tlb_raddr(tlbe);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 72a4ad8..22f6fa2 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -38,7 +38,8 @@
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
-	return !(v->arch.msr & MSR_WE) || !!(v->arch.pending_exceptions);
+	return !(v->arch.shared->msr & MSR_WE) ||
+	       !!(v->arch.pending_exceptions);
 }
 
 
-- 
1.6.0.2

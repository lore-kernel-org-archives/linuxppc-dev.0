Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 547D2100880
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:23 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 24/26] KVM: PPC: PV mtmsrd L=0 and mtmsr
Date: Sat, 26 Jun 2010 01:25:12 +0200
Message-Id: <1277508314-915-25-git-send-email-agraf@suse.de>
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

There is also a form of mtmsr where all bits need to be addressed. While the
PPC64 Linux kernel behaves resonably well here, the PPC32 one never uses the
L=1 form but does mtmsr even for simple things like only changing EE.

So we need to hook into that one as well and check for a mask of bits that we
deem safe to change from within guest context.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/kvm.c      |   51 ++++++++++++++++++++++++
 arch/powerpc/kernel/kvm_emul.S |   84 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 71153d0..3557bc8 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -62,7 +62,9 @@
 #define KVM_INST_MTSPR_DSISR	0x7c1203a6
 
 #define KVM_INST_TLBSYNC	0x7c00046c
+#define KVM_INST_MTMSRD_L0	0x7c000164
 #define KVM_INST_MTMSRD_L1	0x7c010164
+#define KVM_INST_MTMSR		0x7c000124
 
 static bool kvm_patching_worked = true;
 static char kvm_tmp[1024 * 1024];
@@ -155,6 +157,49 @@ static void kvm_patch_ins_mtmsrd(u32 *inst, u32 rt)
 	*inst = KVM_INST_B | (distance_start & KVM_INST_B_MASK);
 }
 
+extern u32 kvm_emulate_mtmsr_branch_offs;
+extern u32 kvm_emulate_mtmsr_reg1_offs;
+extern u32 kvm_emulate_mtmsr_reg2_offs;
+extern u32 kvm_emulate_mtmsr_reg3_offs;
+extern u32 kvm_emulate_mtmsr_orig_ins_offs;
+extern u32 kvm_emulate_mtmsr_len;
+extern u32 kvm_emulate_mtmsr[];
+
+static void kvm_patch_ins_mtmsr(u32 *inst, u32 rt)
+{
+	u32 *p;
+	int distance_start;
+	int distance_end;
+	ulong next_inst;
+
+	p = kvm_alloc(kvm_emulate_mtmsr_len * 4);
+	if (!p)
+		return;
+
+	/* Find out where we are and put everything there */
+	distance_start = (ulong)p - (ulong)inst;
+	next_inst = ((ulong)inst + 4);
+	distance_end = next_inst - (ulong)&p[kvm_emulate_mtmsr_branch_offs];
+
+	/* Make sure we only write valid b instructions */
+	if (distance_start > KVM_INST_B_MAX) {
+		kvm_patching_worked = false;
+		return;
+	}
+
+	/* Modify the chunk to fit the invocation */
+	memcpy(p, kvm_emulate_mtmsr, kvm_emulate_mtmsr_len * 4);
+	p[kvm_emulate_mtmsr_branch_offs] |= distance_end & KVM_INST_B_MASK;
+	p[kvm_emulate_mtmsr_reg1_offs] |= rt;
+	p[kvm_emulate_mtmsr_reg2_offs] |= rt;
+	p[kvm_emulate_mtmsr_reg3_offs] |= rt;
+	p[kvm_emulate_mtmsr_orig_ins_offs] = *inst;
+	flush_icache_range((ulong)p, (ulong)p + kvm_emulate_mtmsr_len * 4);
+
+	/* Patch the invocation */
+	*inst = KVM_INST_B | (distance_start & KVM_INST_B_MASK);
+}
+
 static void kvm_map_magic_page(void *data)
 {
 	kvm_hypercall2(KVM_HC_PPC_MAP_MAGIC_PAGE,
@@ -235,6 +280,12 @@ static void kvm_check_ins(u32 *inst)
 		if (get_rt(inst_rt) < 30)
 			kvm_patch_ins_mtmsrd(inst, inst_rt);
 		break;
+	case KVM_INST_MTMSR:
+	case KVM_INST_MTMSRD_L0:
+		/* We use r30 and r31 during the hook */
+		if (get_rt(inst_rt) < 30)
+			kvm_patch_ins_mtmsr(inst, inst_rt);
+		break;
 	}
 
 	switch (_inst) {
diff --git a/arch/powerpc/kernel/kvm_emul.S b/arch/powerpc/kernel/kvm_emul.S
index 25e6683..ccf5a42 100644
--- a/arch/powerpc/kernel/kvm_emul.S
+++ b/arch/powerpc/kernel/kvm_emul.S
@@ -110,3 +110,87 @@ kvm_emulate_mtmsrd_reg_offs:
 .global kvm_emulate_mtmsrd_len
 kvm_emulate_mtmsrd_len:
 	.long (kvm_emulate_mtmsrd_end - kvm_emulate_mtmsrd) / 4
+
+
+#define MSR_SAFE_BITS (MSR_EE | MSR_CE | MSR_ME | MSR_RI)
+#define MSR_CRITICAL_BITS ~MSR_SAFE_BITS
+
+.global kvm_emulate_mtmsr
+kvm_emulate_mtmsr:
+
+	SCRATCH_SAVE
+
+	/* Fetch old MSR in r31 */
+	LL64(r31, KVM_MAGIC_PAGE + KVM_MAGIC_MSR, 0)
+
+	/* Find the changed bits between old and new MSR */
+kvm_emulate_mtmsr_reg1:
+	xor	r31, r0, r31
+
+	/* Check if we need to really do mtmsr */
+	LOAD_REG_IMMEDIATE(r30, MSR_CRITICAL_BITS)
+	and.	r31, r31, r30
+
+	/* No critical bits changed? Maybe we can stay in the guest. */
+	beq	maybe_stay_in_guest
+
+do_mtmsr:
+
+	SCRATCH_RESTORE
+
+	/* Just fire off the mtmsr if it's critical */
+kvm_emulate_mtmsr_orig_ins:
+	mtmsr	r0
+
+	b	kvm_emulate_mtmsr_branch
+
+maybe_stay_in_guest:
+
+	/* Check if we have to fetch an interrupt */
+	lwz	r31, (KVM_MAGIC_PAGE + KVM_MAGIC_INT)(0)
+	cmpwi	r31, 0
+	beq+	no_mtmsr
+
+	/* Check if we may trigger an interrupt */
+kvm_emulate_mtmsr_reg2:
+	andi.	r31, r0, MSR_EE
+	beq	no_mtmsr
+
+	b	do_mtmsr
+
+no_mtmsr:
+
+	/* Put MSR into magic page because we don't call mtmsr */
+kvm_emulate_mtmsr_reg3:
+	STL64(r0, KVM_MAGIC_PAGE + KVM_MAGIC_MSR, 0)
+
+	SCRATCH_RESTORE
+
+	/* Go back to caller */
+kvm_emulate_mtmsr_branch:
+	b	.
+kvm_emulate_mtmsr_end:
+
+.global kvm_emulate_mtmsr_branch_offs
+kvm_emulate_mtmsr_branch_offs:
+	.long (kvm_emulate_mtmsr_branch - kvm_emulate_mtmsr) / 4
+
+.global kvm_emulate_mtmsr_reg1_offs
+kvm_emulate_mtmsr_reg1_offs:
+	.long (kvm_emulate_mtmsr_reg1 - kvm_emulate_mtmsr) / 4
+
+.global kvm_emulate_mtmsr_reg2_offs
+kvm_emulate_mtmsr_reg2_offs:
+	.long (kvm_emulate_mtmsr_reg2 - kvm_emulate_mtmsr) / 4
+
+.global kvm_emulate_mtmsr_reg3_offs
+kvm_emulate_mtmsr_reg3_offs:
+	.long (kvm_emulate_mtmsr_reg3 - kvm_emulate_mtmsr) / 4
+
+.global kvm_emulate_mtmsr_orig_ins_offs
+kvm_emulate_mtmsr_orig_ins_offs:
+	.long (kvm_emulate_mtmsr_orig_ins - kvm_emulate_mtmsr) / 4
+
+.global kvm_emulate_mtmsr_len
+kvm_emulate_mtmsr_len:
+	.long (kvm_emulate_mtmsr_end - kvm_emulate_mtmsr) / 4
-- 
1.6.0.2

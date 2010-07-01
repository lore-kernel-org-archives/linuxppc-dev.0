Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 428FB1008F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:12 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 24/27] KVM: PPC: PV mtmsrd L=1
Date: Thu,  1 Jul 2010 12:42:59 +0200
Message-Id: <1277980982-12433-25-git-send-email-agraf@suse.de>
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

The PowerPC ISA has a special instruction for mtmsr that only changes the EE
and RI bits, namely the L=1 form.

Since that one is reasonably often occuring and simple to implement, let's
go with this first. Writing EE=0 is always just a store. Doing EE=1 also
requires us to check for pending interrupts and if necessary exit back to the
hypervisor.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - use kvm_patch_ins_b
---
 arch/powerpc/kernel/kvm.c      |   45 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/kvm_emul.S |   56 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 337e3e5..1e32298 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -62,6 +62,7 @@
 #define KVM_INST_MTSPR_DSISR	0x7c1203a6
 
 #define KVM_INST_TLBSYNC	0x7c00046c
+#define KVM_INST_MTMSRD_L1	0x7c010164
 
 static bool kvm_patching_worked = true;
 static char kvm_tmp[1024 * 1024];
@@ -128,6 +129,43 @@ static u32 *kvm_alloc(int len)
 	return p;
 }
 
+extern u32 kvm_emulate_mtmsrd_branch_offs;
+extern u32 kvm_emulate_mtmsrd_reg_offs;
+extern u32 kvm_emulate_mtmsrd_len;
+extern u32 kvm_emulate_mtmsrd[];
+
+static void kvm_patch_ins_mtmsrd(u32 *inst, u32 rt)
+{
+	u32 *p;
+	int distance_start;
+	int distance_end;
+	ulong next_inst;
+
+	p = kvm_alloc(kvm_emulate_mtmsrd_len * 4);
+	if (!p)
+		return;
+
+	/* Find out where we are and put everything there */
+	distance_start = (ulong)p - (ulong)inst;
+	next_inst = ((ulong)inst + 4);
+	distance_end = next_inst - (ulong)&p[kvm_emulate_mtmsrd_branch_offs];
+
+	/* Make sure we only write valid b instructions */
+	if (distance_start > KVM_INST_B_MAX) {
+		kvm_patching_worked = false;
+		return;
+	}
+
+	/* Modify the chunk to fit the invocation */
+	memcpy(p, kvm_emulate_mtmsrd, kvm_emulate_mtmsrd_len * 4);
+	p[kvm_emulate_mtmsrd_branch_offs] |= distance_end & KVM_INST_B_MASK;
+	p[kvm_emulate_mtmsrd_reg_offs] |= rt;
+	flush_icache_range((ulong)p, (ulong)p + kvm_emulate_mtmsrd_len * 4);
+
+	/* Patch the invocation */
+	kvm_patch_ins_b(inst, distance_start);
+}
+
 static void kvm_map_magic_page(void *data)
 {
 	kvm_hypercall2(KVM_HC_PPC_MAP_MAGIC_PAGE,
@@ -201,6 +239,13 @@ static void kvm_check_ins(u32 *inst)
 	case KVM_INST_TLBSYNC:
 		kvm_patch_ins_nop(inst);
 		break;
+
+	/* Rewrites */
+	case KVM_INST_MTMSRD_L1:
+		/* We use r30 and r31 during the hook */
+		if (get_rt(inst_rt) < 30)
+			kvm_patch_ins_mtmsrd(inst, inst_rt);
+		break;
 	}
 
 	switch (_inst) {
diff --git a/arch/powerpc/kernel/kvm_emul.S b/arch/powerpc/kernel/kvm_emul.S
index 7da835a..25e6683 100644
--- a/arch/powerpc/kernel/kvm_emul.S
+++ b/arch/powerpc/kernel/kvm_emul.S
@@ -54,3 +54,59 @@
 	/* Disable critical section. We are critical if			\
 	   shared->critical == r1 and r2 is always != r1 */		\
 	STL64(r2, KVM_MAGIC_PAGE + KVM_MAGIC_CRITICAL, 0);
+
+.global kvm_emulate_mtmsrd
+kvm_emulate_mtmsrd:
+
+	SCRATCH_SAVE
+
+	/* Put MSR & ~(MSR_EE|MSR_RI) in r31 */
+	LL64(r31, KVM_MAGIC_PAGE + KVM_MAGIC_MSR, 0)
+	lis	r30, (~(MSR_EE | MSR_RI))@h
+	ori	r30, r30, (~(MSR_EE | MSR_RI))@l
+	and	r31, r31, r30
+
+	/* OR the register's (MSR_EE|MSR_RI) on MSR */
+kvm_emulate_mtmsrd_reg:
+	andi.	r30, r0, (MSR_EE|MSR_RI)
+	or	r31, r31, r30
+
+	/* Put MSR back into magic page */
+	STL64(r31, KVM_MAGIC_PAGE + KVM_MAGIC_MSR, 0)
+
+	/* Check if we have to fetch an interrupt */
+	lwz	r31, (KVM_MAGIC_PAGE + KVM_MAGIC_INT)(0)
+	cmpwi	r31, 0
+	beq+	no_check
+
+	/* Check if we may trigger an interrupt */
+	andi.	r30, r30, MSR_EE
+	beq	no_check
+
+	SCRATCH_RESTORE
+
+	/* Nag hypervisor */
+	tlbsync
+
+	b	kvm_emulate_mtmsrd_branch
+
+no_check:
+
+	SCRATCH_RESTORE
+
+	/* Go back to caller */
+kvm_emulate_mtmsrd_branch:
+	b	.
+kvm_emulate_mtmsrd_end:
+
+.global kvm_emulate_mtmsrd_branch_offs
+kvm_emulate_mtmsrd_branch_offs:
+	.long (kvm_emulate_mtmsrd_branch - kvm_emulate_mtmsrd) / 4
+
+.global kvm_emulate_mtmsrd_reg_offs
+kvm_emulate_mtmsrd_reg_offs:
+	.long (kvm_emulate_mtmsrd_reg - kvm_emulate_mtmsrd) / 4
+
+.global kvm_emulate_mtmsrd_len
+kvm_emulate_mtmsrd_len:
+	.long (kvm_emulate_mtmsrd_end - kvm_emulate_mtmsrd) / 4
-- 
1.6.0.2

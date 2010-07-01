Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id AA5E310083B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 20:43:09 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 26/27] KVM: PPC: PV wrteei
Date: Thu,  1 Jul 2010 12:43:01 +0200
Message-Id: <1277980982-12433-27-git-send-email-agraf@suse.de>
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

On BookE the preferred way to write the EE bit is the wrteei instruction. It
already encodes the EE bit in the instruction.

So in order to get BookE some speedups as well, let's also PV'nize thati
instruction.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - use kvm_patch_ins_b
---
 arch/powerpc/kernel/kvm.c      |   50 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/kvm_emul.S |   41 ++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 2541736..995fadd 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -66,6 +66,9 @@
 #define KVM_INST_MTMSRD_L1	0x7c010164
 #define KVM_INST_MTMSR		0x7c000124
 
+#define KVM_INST_WRTEEI_0	0x7c000146
+#define KVM_INST_WRTEEI_1	0x7c008146
+
 static bool kvm_patching_worked = true;
 static char kvm_tmp[1024 * 1024];
 static int kvm_tmp_index;
@@ -211,6 +214,47 @@ static void kvm_patch_ins_mtmsr(u32 *inst, u32 rt)
 	kvm_patch_ins_b(inst, distance_start);
 }
 
+#ifdef CONFIG_BOOKE
+
+extern u32 kvm_emulate_wrteei_branch_offs;
+extern u32 kvm_emulate_wrteei_ee_offs;
+extern u32 kvm_emulate_wrteei_len;
+extern u32 kvm_emulate_wrteei[];
+
+static void kvm_patch_ins_wrteei(u32 *inst)
+{
+	u32 *p;
+	int distance_start;
+	int distance_end;
+	ulong next_inst;
+
+	p = kvm_alloc(kvm_emulate_wrteei_len * 4);
+	if (!p)
+		return;
+
+	/* Find out where we are and put everything there */
+	distance_start = (ulong)p - (ulong)inst;
+	next_inst = ((ulong)inst + 4);
+	distance_end = next_inst - (ulong)&p[kvm_emulate_wrteei_branch_offs];
+
+	/* Make sure we only write valid b instructions */
+	if (distance_start > KVM_INST_B_MAX) {
+		kvm_patching_worked = false;
+		return;
+	}
+
+	/* Modify the chunk to fit the invocation */
+	memcpy(p, kvm_emulate_wrteei, kvm_emulate_wrteei_len * 4);
+	p[kvm_emulate_wrteei_branch_offs] |= distance_end & KVM_INST_B_MASK;
+	p[kvm_emulate_wrteei_ee_offs] |= (*inst & MSR_EE);
+	flush_icache_range((ulong)p, (ulong)p + kvm_emulate_wrteei_len * 4);
+
+	/* Patch the invocation */
+	kvm_patch_ins_b(inst, distance_start);
+}
+
+#endif
+
 static void kvm_map_magic_page(void *data)
 {
 	kvm_hypercall2(KVM_HC_PPC_MAP_MAGIC_PAGE,
@@ -300,6 +344,12 @@ static void kvm_check_ins(u32 *inst)
 	}
 
 	switch (_inst) {
+#ifdef CONFIG_BOOKE
+	case KVM_INST_WRTEEI_0:
+	case KVM_INST_WRTEEI_1:
+		kvm_patch_ins_wrteei(inst);
+		break;
+#endif
 	}
 }
 
diff --git a/arch/powerpc/kernel/kvm_emul.S b/arch/powerpc/kernel/kvm_emul.S
index ccf5a42..b79b9de 100644
--- a/arch/powerpc/kernel/kvm_emul.S
+++ b/arch/powerpc/kernel/kvm_emul.S
@@ -194,3 +194,44 @@ kvm_emulate_mtmsr_orig_ins_offs:
 .global kvm_emulate_mtmsr_len
 kvm_emulate_mtmsr_len:
 	.long (kvm_emulate_mtmsr_end - kvm_emulate_mtmsr) / 4
+
+
+
+.global kvm_emulate_wrteei
+kvm_emulate_wrteei:
+
+	SCRATCH_SAVE
+
+	/* Fetch old MSR in r31 */
+	LL64(r31, KVM_MAGIC_PAGE + KVM_MAGIC_MSR, 0)
+
+	/* Remove MSR_EE from old MSR */
+	li	r30, 0
+	ori	r30, r30, MSR_EE
+	andc	r31, r31, r30
+
+	/* OR new MSR_EE onto the old MSR */
+kvm_emulate_wrteei_ee:
+	ori	r31, r31, 0
+
+	/* Write new MSR value back */
+	STL64(r31, KVM_MAGIC_PAGE + KVM_MAGIC_MSR, 0)
+
+	SCRATCH_RESTORE
+
+	/* Go back to caller */
+kvm_emulate_wrteei_branch:
+	b	.
+kvm_emulate_wrteei_end:
+
+.global kvm_emulate_wrteei_branch_offs
+kvm_emulate_wrteei_branch_offs:
+	.long (kvm_emulate_wrteei_branch - kvm_emulate_wrteei) / 4
+
+.global kvm_emulate_wrteei_ee_offs
+kvm_emulate_wrteei_ee_offs:
+	.long (kvm_emulate_wrteei_ee - kvm_emulate_wrteei) / 4
+
+.global kvm_emulate_wrteei_len
+kvm_emulate_wrteei_len:
+	.long (kvm_emulate_wrteei_end - kvm_emulate_wrteei) / 4
-- 
1.6.0.2

Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5670F1008F5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:23 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 25/26] KVM: PPC: PV wrteei
Date: Sat, 26 Jun 2010 01:25:13 +0200
Message-Id: <1277508314-915-26-git-send-email-agraf@suse.de>
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

On BookE the preferred way to write the EE bit is the wrteei instruction. It
already encodes the EE bit in the instruction.

So in order to get BookE some speedups as well, let's also PV'nize thati
instruction.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/kvm.c      |   50 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/kvm_emul.S |   41 ++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 3557bc8..85e2163 100644
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
@@ -200,6 +203,47 @@ static void kvm_patch_ins_mtmsr(u32 *inst, u32 rt)
 	*inst = KVM_INST_B | (distance_start & KVM_INST_B_MASK);
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
+	*inst = KVM_INST_B | (distance_start & KVM_INST_B_MASK);
+}
+
+#endif
+
 static void kvm_map_magic_page(void *data)
 {
 	kvm_hypercall2(KVM_HC_PPC_MAP_MAGIC_PAGE,
@@ -289,6 +333,12 @@ static void kvm_check_ins(u32 *inst)
 	}
 
 	switch (_inst) {
+#ifdef CONFIG_BOOKE
+	case KVM_INST_WRTEEI_0:
+	case KVM_INST_WRTEEI_1:
+		kvm_patch_ins_wrteei(inst);
+		break;
+#endif
 	}
 
 	flush_icache_range((ulong)inst, (ulong)inst + 4);
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

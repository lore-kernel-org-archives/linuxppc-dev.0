Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 623DAB7159
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:08 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 20/26] KVM: PPC: Make PV mtmsrd L=1 work with r30 and r31
Date: Tue, 17 Aug 2010 15:57:55 +0200
Message-Id: <1282053481-18787-21-git-send-email-agraf@suse.de>
In-Reply-To: <1282053481-18787-1-git-send-email-agraf@suse.de>
References: <1282053481-18787-1-git-send-email-agraf@suse.de>
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

We had an arbitrary limitation in mtmsrd L=1 that kept us from using r30 and
r31 as input registers. Let's get rid of that and get more potential speedups!

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/kvm.c      |   21 +++++++++++++++++----
 arch/powerpc/kernel/kvm_emul.S |    8 +++++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 517967d..517da39 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -159,6 +159,7 @@ static u32 *kvm_alloc(int len)
 
 extern u32 kvm_emulate_mtmsrd_branch_offs;
 extern u32 kvm_emulate_mtmsrd_reg_offs;
+extern u32 kvm_emulate_mtmsrd_orig_ins_offs;
 extern u32 kvm_emulate_mtmsrd_len;
 extern u32 kvm_emulate_mtmsrd[];
 
@@ -187,7 +188,21 @@ static void kvm_patch_ins_mtmsrd(u32 *inst, u32 rt)
 	/* Modify the chunk to fit the invocation */
 	memcpy(p, kvm_emulate_mtmsrd, kvm_emulate_mtmsrd_len * 4);
 	p[kvm_emulate_mtmsrd_branch_offs] |= distance_end & KVM_INST_B_MASK;
-	p[kvm_emulate_mtmsrd_reg_offs] |= rt;
+	switch (get_rt(rt)) {
+	case 30:
+		kvm_patch_ins_ll(&p[kvm_emulate_mtmsrd_reg_offs],
+				 magic_var(scratch2), KVM_RT_30);
+		break;
+	case 31:
+		kvm_patch_ins_ll(&p[kvm_emulate_mtmsrd_reg_offs],
+				 magic_var(scratch1), KVM_RT_30);
+		break;
+	default:
+		p[kvm_emulate_mtmsrd_reg_offs] |= rt;
+		break;
+	}
+
+	p[kvm_emulate_mtmsrd_orig_ins_offs] = *inst;
 	flush_icache_range((ulong)p, (ulong)p + kvm_emulate_mtmsrd_len * 4);
 
 	/* Patch the invocation */
@@ -424,9 +439,7 @@ static void kvm_check_ins(u32 *inst, u32 features)
 
 	/* Rewrites */
 	case KVM_INST_MTMSRD_L1:
-		/* We use r30 and r31 during the hook */
-		if (get_rt(inst_rt) < 30)
-			kvm_patch_ins_mtmsrd(inst, inst_rt);
+		kvm_patch_ins_mtmsrd(inst, inst_rt);
 		break;
 	case KVM_INST_MTMSR:
 	case KVM_INST_MTMSRD_L0:
diff --git a/arch/powerpc/kernel/kvm_emul.S b/arch/powerpc/kernel/kvm_emul.S
index 6530532..f2b1b25 100644
--- a/arch/powerpc/kernel/kvm_emul.S
+++ b/arch/powerpc/kernel/kvm_emul.S
@@ -78,7 +78,8 @@ kvm_emulate_mtmsrd:
 
 	/* OR the register's (MSR_EE|MSR_RI) on MSR */
 kvm_emulate_mtmsrd_reg:
-	andi.	r30, r0, (MSR_EE|MSR_RI)
+	ori	r30, r0, 0
+	andi.	r30, r30, (MSR_EE|MSR_RI)
 	or	r31, r31, r30
 
 	/* Put MSR back into magic page */
@@ -96,6 +97,7 @@ kvm_emulate_mtmsrd_reg:
 	SCRATCH_RESTORE
 
 	/* Nag hypervisor */
+kvm_emulate_mtmsrd_orig_ins:
 	tlbsync
 
 	b	kvm_emulate_mtmsrd_branch
@@ -117,6 +119,10 @@ kvm_emulate_mtmsrd_branch_offs:
 kvm_emulate_mtmsrd_reg_offs:
 	.long (kvm_emulate_mtmsrd_reg - kvm_emulate_mtmsrd) / 4
 
+.global kvm_emulate_mtmsrd_orig_ins_offs
+kvm_emulate_mtmsrd_orig_ins_offs:
+	.long (kvm_emulate_mtmsrd_orig_ins - kvm_emulate_mtmsrd) / 4
+
 .global kvm_emulate_mtmsrd_len
 kvm_emulate_mtmsrd_len:
 	.long (kvm_emulate_mtmsrd_end - kvm_emulate_mtmsrd) / 4
-- 
1.6.0.2

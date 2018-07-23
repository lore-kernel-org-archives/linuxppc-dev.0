Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4cb1BL9zDr0y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:08:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc/64s: Add support for software count cache flush
Date: Tue, 24 Jul 2018 01:07:54 +1000
Message-Id: <20180723150756.11108-3-mpe@ellerman.id.au>
In-Reply-To: <20180723150756.11108-1-mpe@ellerman.id.au>
References: <20180723150756.11108-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some CPU revisions support a mode where the count cache needs to be
flushed by software on context switch. Additionally some revisions may
have a hardware accelerated flush, in which case the software flush
sequence can be shortened.

If we detect the appropriate flag from firmware we patch a branch
into _switch() which takes us to a count cache flush sequence.

That sequence in turn may be patched to return early if we detect that
the CPU supports accelerating the flush sequence in hardware.

Add debugfs support for reporting the state of the flush, as well as
runtime disabling it.

And modify the spectre_v2 sysfs file to report the state of the
software flush.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/asm-prototypes.h    |  6 ++
 arch/powerpc/include/asm/security_features.h |  1 +
 arch/powerpc/kernel/entry_64.S               | 54 ++++++++++++++++
 arch/powerpc/kernel/security.c               | 96 ++++++++++++++++++++++++++--
 4 files changed, 152 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 769567b66c0c..70fdc5b9b9fb 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -143,4 +143,10 @@ struct kvm_vcpu;
 void _kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu, u64 guest_msr);
 void _kvmppc_save_tm_pr(struct kvm_vcpu *vcpu, u64 guest_msr);
 
+/* Patch sites */
+extern s32 patch__call_flush_count_cache;
+extern s32 patch__flush_count_cache_return;
+
+extern long flush_count_cache;
+
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/include/asm/security_features.h b/arch/powerpc/include/asm/security_features.h
index a0d47bc18a5c..759597bf0fd8 100644
--- a/arch/powerpc/include/asm/security_features.h
+++ b/arch/powerpc/include/asm/security_features.h
@@ -22,6 +22,7 @@ enum stf_barrier_type {
 
 void setup_stf_barrier(void);
 void do_stf_barrier_fixups(enum stf_barrier_type types);
+void setup_count_cache_flush(void);
 
 static inline void security_ftr_set(unsigned long feature)
 {
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 0357f87a013c..017cf70f01d7 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -25,6 +25,7 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/thread_info.h>
+#include <asm/code-patching-asm.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/cputable.h>
@@ -504,6 +505,57 @@ _GLOBAL(ret_from_kernel_thread)
 	li	r3,0
 	b	.Lsyscall_exit
 
+#ifdef CONFIG_PPC_BOOK3S_64
+
+#define FLUSH_COUNT_CACHE	\
+1:	nop;			\
+	patch_site 1b, patch__call_flush_count_cache
+
+
+#define BCCTR_FLUSH	.long 0x4c400420
+
+.macro nops number
+	.rept \number
+	nop
+	.endr
+.endm
+
+.balign 32
+.global flush_count_cache
+flush_count_cache:
+	/* Save LR into r9 */
+	mflr	r9
+
+	.rept 64
+	bl	.+4
+	.endr
+	b	1f
+	nops	6
+
+	.balign 32
+	/* Restore LR */
+1:	mtlr	r9
+	li	r9,0x7fff
+	mtctr	r9
+
+	BCCTR_FLUSH
+
+2:	nop
+	patch_site 2b patch__flush_count_cache_return
+
+	nops	3
+
+	.rept 278
+	.balign 32
+	BCCTR_FLUSH
+	nops	7
+	.endr
+
+	blr
+#else
+#define FLUSH_COUNT_CACHE
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
 /*
  * This routine switches between two different tasks.  The process
  * state of one is saved on its kernel stack.  Then the state
@@ -535,6 +587,8 @@ _GLOBAL(_switch)
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
 
+	FLUSH_COUNT_CACHE
+
 	/*
 	 * On SMP kernels, care must be taken because a task may be
 	 * scheduled off CPUx and on to CPUy. Memory ordering must be
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 4cb8f1f7b593..fa9366b53eb7 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -8,6 +8,8 @@
 #include <linux/device.h>
 #include <linux/seq_buf.h>
 
+#include <asm/asm-prototypes.h>
+#include <asm/code-patching.h>
 #include <asm/debugfs.h>
 #include <asm/security_features.h>
 #include <asm/setup.h>
@@ -15,6 +17,13 @@
 
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
+enum count_cache_flush_type {
+	COUNT_CACHE_FLUSH_NONE	= 0x1,
+	COUNT_CACHE_FLUSH_SW	= 0x2,
+	COUNT_CACHE_FLUSH_HW	= 0x4,
+};
+static enum count_cache_flush_type count_cache_flush_type;
+
 bool barrier_nospec_enabled;
 
 static void enable_barrier_nospec(bool enable)
@@ -147,17 +156,29 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 	bcs = security_ftr_enabled(SEC_FTR_BCCTRL_SERIALISED);
 	ccd = security_ftr_enabled(SEC_FTR_COUNT_CACHE_DISABLED);
 
-	if (bcs || ccd) {
+	if (bcs || ccd || count_cache_flush_type != COUNT_CACHE_FLUSH_NONE) {
+		bool comma = false;
 		seq_buf_printf(&s, "Mitigation: ");
 
-		if (bcs)
+		if (bcs) {
 			seq_buf_printf(&s, "Indirect branch serialisation (kernel only)");
+			comma = true;
+		}
+
+		if (ccd) {
+			if (comma)
+				seq_buf_printf(&s, ", ");
+			seq_buf_printf(&s, "Indirect branch cache disabled");
+			comma = true;
+		}
 
-		if (bcs && ccd)
+		if (comma)
 			seq_buf_printf(&s, ", ");
 
-		if (ccd)
-			seq_buf_printf(&s, "Indirect branch cache disabled");
+		seq_buf_printf(&s, "Software count cache flush");
+
+		if (count_cache_flush_type == COUNT_CACHE_FLUSH_HW)
+			seq_buf_printf(&s, "(hardware accelerated)");
 	} else
 		seq_buf_printf(&s, "Vulnerable");
 
@@ -313,3 +334,68 @@ static __init int stf_barrier_debugfs_init(void)
 }
 device_initcall(stf_barrier_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
+
+static void toggle_count_cache_flush(bool enable)
+{
+	if (!enable || !security_ftr_enabled(SEC_FTR_FLUSH_COUNT_CACHE)) {
+		patch_instruction_site(&patch__call_flush_count_cache, PPC_INST_NOP);
+		count_cache_flush_type = COUNT_CACHE_FLUSH_NONE;
+		pr_info("count-cache-flush: software flush disabled.\n");
+		return;
+	}
+
+	patch_branch_site(&patch__call_flush_count_cache,
+			  (u64)&flush_count_cache, BRANCH_SET_LINK);
+
+	if (!security_ftr_enabled(SEC_FTR_BCCTR_FLUSH_ASSIST)) {
+		count_cache_flush_type = COUNT_CACHE_FLUSH_SW;
+		pr_info("count-cache-flush: full software flush sequence enabled.\n");
+		return;
+	}
+
+	patch_instruction_site(&patch__flush_count_cache_return, PPC_INST_BLR);
+	count_cache_flush_type = COUNT_CACHE_FLUSH_HW;
+	pr_info("count-cache-flush: hardware assisted flush sequence enabled\n");
+}
+
+void setup_count_cache_flush(void)
+{
+	toggle_count_cache_flush(true);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static int count_cache_flush_set(void *data, u64 val)
+{
+	bool enable;
+
+	if (val == 1)
+		enable = true;
+	else if (val == 0)
+		enable = false;
+	else
+		return -EINVAL;
+
+	toggle_count_cache_flush(enable);
+
+	return 0;
+}
+
+static int count_cache_flush_get(void *data, u64 *val)
+{
+	if (count_cache_flush_type == COUNT_CACHE_FLUSH_NONE)
+		*val = 0;
+	else
+		*val = 1;
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_count_cache_flush, count_cache_flush_get, count_cache_flush_set, "%llu\n");
+
+static __init int count_cache_flush_debugfs_init(void)
+{
+	debugfs_create_file("count_cache_flush", 0600, powerpc_debugfs_root, NULL, &fops_count_cache_flush);
+	return 0;
+}
+device_initcall(count_cache_flush_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */
-- 
2.14.1

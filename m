Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D34BC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 11:59:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF592075E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 11:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF592075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W0dl43T4zDqNP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 22:59:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vzw90gLmzDqT3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 22:26:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44Vzw80PxQz9sSV; Fri, 29 Mar 2019 22:26:48 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44Vzw74W13z9sSc; Fri, 29 Mar 2019 22:26:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.14 17/32] powerpc/64s: Add support for software
 count cache flush
Date: Fri, 29 Mar 2019 22:26:05 +1100
Message-Id: <20190329112620.14489-18-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329112620.14489-1-mpe@ellerman.id.au>
References: <20190329112620.14489-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

commit ee13cb249fabdff8b90aaff61add347749280087 upstream.

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
 arch/powerpc/kernel/entry_64.S               | 54 +++++++++++
 arch/powerpc/kernel/security.c               | 98 +++++++++++++++++++-
 4 files changed, 154 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 7330150bfe34..ba4c75062d49 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -126,4 +126,10 @@ extern int __ucmpdi2(u64, u64);
 void _mcount(void);
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip);
 
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
index 7a43b27dc6e0..e40e74e8c635 100644
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
@@ -497,6 +498,57 @@ _GLOBAL(ret_from_kernel_thread)
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
@@ -528,6 +580,8 @@ _GLOBAL(_switch)
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
 
+	FLUSH_COUNT_CACHE
+
 	/*
 	 * On SMP kernels, care must be taken because a task may be
 	 * scheduled off CPUx and on to CPUy. Memory ordering must be
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 206488603b66..554d33c7b758 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -9,12 +9,21 @@
 #include <linux/seq_buf.h>
 
 #include <asm/debugfs.h>
+#include <asm/asm-prototypes.h>
+#include <asm/code-patching.h>
 #include <asm/security_features.h>
 #include <asm/setup.h>
 
 
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
+enum count_cache_flush_type {
+	COUNT_CACHE_FLUSH_NONE	= 0x1,
+	COUNT_CACHE_FLUSH_SW	= 0x2,
+	COUNT_CACHE_FLUSH_HW	= 0x4,
+};
+static enum count_cache_flush_type count_cache_flush_type;
+
 bool barrier_nospec_enabled;
 static bool no_nospec;
 
@@ -159,17 +168,29 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
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
 
@@ -326,4 +347,71 @@ static __init int stf_barrier_debugfs_init(void)
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
+DEFINE_SIMPLE_ATTRIBUTE(fops_count_cache_flush, count_cache_flush_get,
+			count_cache_flush_set, "%llu\n");
+
+static __init int count_cache_flush_debugfs_init(void)
+{
+	debugfs_create_file("count_cache_flush", 0600, powerpc_debugfs_root,
+			    NULL, &fops_count_cache_flush);
+	return 0;
+}
+device_initcall(count_cache_flush_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */
 #endif /* CONFIG_PPC_BOOK3S_64 */
-- 
2.20.1


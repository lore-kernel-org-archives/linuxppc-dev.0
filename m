Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7801F1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 18:00:04 +1100 (AEDT)
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BEF93140157
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2016 18:00:03 +1100 (AEDT)
Received: by mail-pa0-x22b.google.com with SMTP id td3so5423073pab.2
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Mar 2016 23:00:03 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: bsingharora@gmail.com, duwe@lst.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz, Torsten Duwe <duwe@suse.de>
Subject: [PATCH][v6][RFC] livepatch/ppc: Enable livepatching on powerpc
Date: Wed,  9 Mar 2016 17:59:40 +1100
Message-Id: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The previous revision was nacked by Torsten, but compared to the alternatives
at hand I think we should test this approach. Ideally we want all the complexity
of live-patching in the live-patching code and not in the patch. The other option
is to accept v4 and document the limitation to patch writers of not patching
functions > 8 arguments or marking such functions as notrace or equivalent


Changelog v6:
	1. Experimental changes -- need loads of testing
	   Based on the assumption that very far TOC and LR values
	   indicate the call happened through a stub and the
	   stub return works differently from a local call which
	   uses klp_return_helper.
	2. This now runs the test case posted by Petr
	   http://marc.info/?l=linux-kernel&m=145745300216069&w=2
Changelog v5:
	1. Removed the mini-stack frame created for klp_return_helper.
	   As a result of the mini-stack frame, function with > 8
	   arguments could not be patched
	2. Removed camel casing in the comments
Changelog v4:
	1. Renamed klp_matchaddr() to klp_get_ftrace_location()
	   and used it just to convert the function address.
	2. Synced klp_write_module_reloc() with s390(); made it
	   inline, no error message, return -ENOSYS
	3. Added an error message when including
	   powerpc/include/asm/livepatch.h without HAVE_LIVEPATCH
	4. Update some comments.
Changelog v3:
	1. Moved -ENOSYS to -EINVAL in klp_write_module_reloc
	2. Moved klp_matchaddr to use ftrace_location_range
Changelog v2:
	1. Implement review comments by Michael
	2. The previous version compared _NIP from the
	   wrong location to check for whether we
	   are going to a patched location

This patch enables live patching for powerpc. The current patch
is applied on top of topic/mprofile-kernel at
https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/

This patch builds on top of ftrace with regs changes and the
-mprofile-kernel changes. It detects a change in NIP after
the klp subsystem has potentially changes the NIP as a result
of a livepatch. In that case it saves the TOC in the parents
stack and the offset of the return address from the TOC in
the reserved (CR+4) space. This hack allows us to provide the
complete frame of the calling function as is to the caller
without having to create a mini-frame

Upon return from the patched function, the TOC and correct
LR is restored.

I tested the sample in the livepatch and an additional sample
that patches int_to_scsilun. I'll post out that sample if there
is interest later. I also tested ftrace functionality on the
command line to check for breakage

Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 arch/powerpc/Kconfig                 |  3 ++
 arch/powerpc/include/asm/livepatch.h | 47 +++++++++++++++++++++++
 arch/powerpc/kernel/Makefile         |  1 +
 arch/powerpc/kernel/entry_64.S       | 72 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/livepatch.c      | 29 +++++++++++++++
 include/linux/ftrace.h               |  1 +
 include/linux/livepatch.h            |  2 +
 kernel/livepatch/core.c              | 28 ++++++++++++--
 kernel/trace/ftrace.c                | 14 ++++++-
 9 files changed, 193 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 91da283..926c0ea 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -159,6 +159,7 @@ config PPC
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select HAVE_ARCH_SECCOMP_FILTER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select HAVE_LIVEPATCH if HAVE_DYNAMIC_FTRACE_WITH_REGS
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
@@ -1110,3 +1111,5 @@ config PPC_LIB_RHEAP
 	bool
 
 source "arch/powerpc/kvm/Kconfig"
+
+source "kernel/livepatch/Kconfig"
diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
new file mode 100644
index 0000000..b9856ce
--- /dev/null
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -0,0 +1,47 @@
+/*
+ * livepatch.h - powerpc-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2015 SUSE
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef _ASM_POWERPC64_LIVEPATCH_H
+#define _ASM_POWERPC64_LIVEPATCH_H
+
+#include <linux/module.h>
+
+#ifdef CONFIG_LIVEPATCH
+
+static inline int klp_check_compiler_support(void)
+{
+	return 0;
+}
+
+static inline int klp_write_module_reloc(struct module *mod, unsigned long
+		type, unsigned long loc, unsigned long value)
+{
+	/* This requires infrastructure changes; we need the loadinfos. */
+	return -ENOSYS;
+}
+
+static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+{
+	regs->nip = ip;
+}
+
+#else /* CONFIG_LIVEPATCH */
+#error Include linux/livepatch.h, not asm/livepatch.h
+#endif /* CONFIG_LIVEPATCH */
+
+#endif /* _ASM_POWERPC64_LIVEPATCH_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2da380f..b767e14 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_TRACING)		+= trace_clock.o
+obj-$(CONFIG_LIVEPATCH)		+= livepatch.o
 
 ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
 obj-y				+= iomap.o
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index ec7f8aa..01f53d4 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1224,6 +1224,9 @@ _GLOBAL(ftrace_caller)
 	addi	r3,r3,function_trace_op@toc@l
 	ld	r5,0(r3)
 
+#ifdef CONFIG_LIVEPATCH
+	mr	r14,r7		/* remember old NIP */
+#endif
 	/* Calculate ip from nip-4 into r3 for call below */
 	subi    r3, r7, MCOUNT_INSN_SIZE
 
@@ -1248,6 +1251,9 @@ ftrace_call:
 	/* Load ctr with the possibly modified NIP */
 	ld	r3, _NIP(r1)
 	mtctr	r3
+#ifdef CONFIG_LIVEPATCH
+	cmpd	r14,r3		/* has NIP been altered? */
+#endif
 
 	/* Restore gprs */
 	REST_8GPRS(0,r1)
@@ -1265,6 +1271,51 @@ ftrace_call:
 	ld	r0, LRSAVE(r1)
 	mtlr	r0
 
+#ifdef CONFIG_LIVEPATCH
+	beq+	4f		/* likely(old_NIP == new_NIP) */
+	/*
+	 * For a local call, restore this TOC after calling the patch function.
+	 * For a global call, it does not matter what we restore here,
+	 * since the global caller does its own restore right afterwards,
+	 * anyway. Just insert a klp_return_helper frame in any case,
+	 * so a patch function can always count on the changed stack offsets.
+	 * The patch introduces a frame such that from the patched function
+	 * we return back to klp_return helper. For ABI compliance r12,
+	 * lr and LRSAVE(r1) contain the address of klp_return_helper.
+	 * We loaded ctr with the address of the patched function earlier
+	 * We use the reserved space in the parent stack frame at CR+4.
+	 * This space is stored with the contents of LR-TOC, where LR
+	 * refers to the address to return to.
+	 * Why do we need this?
+	 * After patching we need to return to a trampoline return function
+	 * that guarantees that we restore the TOC and return to the correct
+	 * caller back
+	 */
+klp_return_prepare:		/* For debugging only */
+	subf	r0, r2, r0	/* Calculate offset from current TOC */
+	sradi.	r11, r0, 32
+	cmpdi	r11, 0
+	bgt-	6f
+
+	bl	5f
+5:	mflr	r12
+	addi	r12, r12, (klp_return_helper + 4 - .)@l
+	std	r12, LRSAVE(r1)
+	mtlr	r12
+	mfctr	r12		/* allow for TOC calculation in newfunc */
+	std	r2, 24(r1)	/* save TOC now, unconditionally. */
+	stw	r0, 12(r1)	/* Of the final LR and save it in CR+4 */
+	bctr
+
+	/* If LR and TOC are very far, the callee should be restroing r2 */
+	/* Because we got there through a stub via create_stub           */
+6:	ld	r0, LRSAVE(r1)
+	mtlr	r0
+	mfctr	r12
+	bctr
+4:
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	stdu	r1, -112(r1)
 .globl ftrace_graph_call
@@ -1281,6 +1332,27 @@ _GLOBAL(ftrace_graph_stub)
 
 _GLOBAL(ftrace_stub)
 	blr
+#ifdef CONFIG_LIVEPATCH
+/*
+ * Helper function for local calls that are becoming global
+ * due to live patching.
+ * We can't simply patch the NOP after the original call,
+ * because, depending on the consistency model, some kernel
+ * threads may still have called the original, local function
+ * *without* saving their TOC in the respective stack frame slot,
+ * so the decision is made per-thread during function return by
+ * maybe inserting a klp_return_helper frame or not.
+*/
+klp_return_helper:
+	ld	r2, 24(r1)	/* restore TOC (saved by ftrace_caller) */
+	lwa	r0, 12(r1)	/* Load from CR+4, offset of LR w.r.t TOC */
+	add	r0, r0, r2	/* Add the offset to current TOC */
+	std	r0, LRSAVE(r1)	/* save the real return address */
+	mtlr	r0
+	blr
+#endif
+
+
 #else
 _GLOBAL_TOC(_mcount)
 	/* Taken from output of objdump from lib64/glibc */
diff --git a/arch/powerpc/kernel/livepatch.c b/arch/powerpc/kernel/livepatch.c
new file mode 100644
index 0000000..17f1a14
--- /dev/null
+++ b/arch/powerpc/kernel/livepatch.c
@@ -0,0 +1,29 @@
+/*
+ * livepatch.c - powerpc-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2015 SUSE
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/ftrace.h>
+#include <asm/livepatch.h>
+
+/*
+ * Live patch works only with -mprofile-kernel on PPC. In this case,
+ * the ftrace location is always within the first 16 bytes.
+ */
+unsigned long klp_get_ftrace_location(unsigned long faddr)
+{
+	return ftrace_location_range(faddr, faddr + 16);
+}
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 81de712..3481a8e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -455,6 +455,7 @@ int ftrace_update_record(struct dyn_ftrace *rec, int enable);
 int ftrace_test_record(struct dyn_ftrace *rec, int enable);
 void ftrace_run_stop_machine(int command);
 unsigned long ftrace_location(unsigned long ip);
+unsigned long ftrace_location_range(unsigned long start, unsigned long end);
 unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec);
 unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec);
 
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index a882865..25a267b 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -134,6 +134,8 @@ int klp_unregister_patch(struct klp_patch *);
 int klp_enable_patch(struct klp_patch *);
 int klp_disable_patch(struct klp_patch *);
 
+unsigned long klp_get_ftrace_location(unsigned long faddr);
+
 #endif /* CONFIG_LIVEPATCH */
 
 #endif /* _LINUX_LIVEPATCH_H_ */
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index bc2c85c..e2dbf01 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -298,22 +298,39 @@ unlock:
 	rcu_read_unlock();
 }
 
+/*
+ * Convert a function address into the appropriate ftrace location.
+ *
+ * The given address is returned on most architectures. Live patching
+ * usually works only when the ftrace location is the first instruction
+ * in the function.
+ */
+unsigned long __weak klp_get_ftrace_location(unsigned long faddr)
+{
+	return faddr;
+}
+
 static void klp_disable_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
+	unsigned long ftrace_loc;
 
 	if (WARN_ON(func->state != KLP_ENABLED))
 		return;
 	if (WARN_ON(!func->old_addr))
 		return;
 
+	ftrace_loc = klp_get_ftrace_location(func->old_addr);
+	if (WARN_ON(!ftrace_loc))
+		return;
+
 	ops = klp_find_ops(func->old_addr);
 	if (WARN_ON(!ops))
 		return;
 
 	if (list_is_singular(&ops->func_stack)) {
 		WARN_ON(unregister_ftrace_function(&ops->fops));
-		WARN_ON(ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0));
+		WARN_ON(ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0));
 
 		list_del_rcu(&func->stack_node);
 		list_del(&ops->node);
@@ -328,6 +345,7 @@ static void klp_disable_func(struct klp_func *func)
 static int klp_enable_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
+	unsigned long ftrace_loc;
 	int ret;
 
 	if (WARN_ON(!func->old_addr))
@@ -336,6 +354,10 @@ static int klp_enable_func(struct klp_func *func)
 	if (WARN_ON(func->state != KLP_DISABLED))
 		return -EINVAL;
 
+	ftrace_loc = klp_get_ftrace_location(func->old_addr);
+	if (WARN_ON(!ftrace_loc))
+		return -EINVAL;
+
 	ops = klp_find_ops(func->old_addr);
 	if (!ops) {
 		ops = kzalloc(sizeof(*ops), GFP_KERNEL);
@@ -352,7 +374,7 @@ static int klp_enable_func(struct klp_func *func)
 		INIT_LIST_HEAD(&ops->func_stack);
 		list_add_rcu(&func->stack_node, &ops->func_stack);
 
-		ret = ftrace_set_filter_ip(&ops->fops, func->old_addr, 0, 0);
+		ret = ftrace_set_filter_ip(&ops->fops, ftrace_loc, 0, 0);
 		if (ret) {
 			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
 			       func->old_name, ret);
@@ -363,7 +385,7 @@ static int klp_enable_func(struct klp_func *func)
 		if (ret) {
 			pr_err("failed to register ftrace handler for function '%s' (%d)\n",
 			       func->old_name, ret);
-			ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0);
+			ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0);
 			goto err;
 		}
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index eca592f..e1b3f23 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1533,7 +1533,19 @@ static int ftrace_cmp_recs(const void *a, const void *b)
 	return 0;
 }
 
-static unsigned long ftrace_location_range(unsigned long start, unsigned long end)
+/**
+ * ftrace_location_range - return the first address of a traced location
+ *	if it touches the given ip range
+ * @start: start of range to search.
+ * @end: end of range to search (inclusive). @end points to the last byte
+ *	to check.
+ *
+ * Returns rec->ip if the related ftrace location is a least partly within
+ * the given address range. That is, the first address of the instruction
+ * that is either a NOP or call to the function tracer. It checks the ftrace
+ * internal tables to determine if the address belongs or not.
+ */
+unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 {
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
-- 
2.5.0

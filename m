Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4234E1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 00:12:16 +1100 (AEDT)
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8475E14170D
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 00:12:15 +1100 (AEDT)
Received: by mail-pa0-x235.google.com with SMTP id fy10so14736216pac.1
 for <linuxppc-dev@ozlabs.org>; Thu, 03 Mar 2016 05:12:15 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: bsingharora@gmail.com, duwe@lst.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz, Torsten Duwe <duwe@suse.de>
Subject: [PATCH][v3] Enable livepatching on powerpc
Date: Fri,  4 Mar 2016 00:11:55 +1100
Message-Id: <1457010715-21092-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Changelog v3:
	1. Moved -ENOSYS to -EINVAL in klp_write_module_reloc
	2. Moved klp_matchaddr to use ftrace_location_range
Changelog v2:
	1. Implement review comments by Michael
	2. The previous version compared _NIP from the
	   wrong location to check for whether we
	   are going to a patched location

This applies on top of the patches posted by Michael 
https://patchwork.ozlabs.org/patch/589791/

It enables livepatching. This takes patch 6/8 and 7/8 of v8 as the base.
(See the reference [1] below) and adds logic for checking offset ranges
in livepatch with ftrace_location_range.

I tested the sample in the livepatch

References

1. https://patchwork.ozlabs.org/patch/581521/

Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/Kconfig                 |  3 ++
 arch/powerpc/include/asm/livepatch.h | 41 +++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile         |  1 +
 arch/powerpc/kernel/entry_64.S       | 50 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/livepatch.c      | 54 ++++++++++++++++++++++++++++++++++++
 include/linux/ftrace.h               |  1 +
 include/linux/livepatch.h            |  2 ++
 kernel/livepatch/core.c              | 12 ++++++--
 kernel/trace/ftrace.c                |  2 +-
 9 files changed, 162 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/include/asm/livepatch.h
 create mode 100644 arch/powerpc/kernel/livepatch.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index df41537..1f4a24b 100644
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
index 0000000..9ecd879
--- /dev/null
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -0,0 +1,41 @@
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
+#include <linux/ftrace.h>
+
+#ifdef CONFIG_LIVEPATCH
+
+static inline int klp_check_compiler_support(void)
+{
+	return 0;
+}
+
+extern int klp_write_module_reloc(struct module *mod, unsigned long type,
+				   unsigned long loc, unsigned long value);
+
+static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+{
+	regs->nip = ip;
+}
+
+#endif /* CONFIG_LIVEPATCH */
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
index ec7f8aa..2d5333c 100644
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
@@ -1265,6 +1271,31 @@ ftrace_call:
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
+	 */
+	stdu	r1, -32(r1)	/* open new mini stack frame */
+	std	r2, 24(r1)	/* save TOC now, unconditionally. */
+	bl	5f
+5:	mflr	r12
+	addi	r12, r12, (klp_return_helper + 4 - .)@l
+	std	r12, LRSAVE(r1)
+	mtlr	r12
+	mfctr	r12		/* allow for TOC calculation in newfunc */
+	bctr
+4:
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	stdu	r1, -112(r1)
 .globl ftrace_graph_call
@@ -1281,6 +1312,25 @@ _GLOBAL(ftrace_graph_stub)
 
 _GLOBAL(ftrace_stub)
 	blr
+#ifdef CONFIG_LIVEPATCH
+/* Helper function for local calls that are becoming global
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
+	addi r1, r1, 32		/* destroy mini stack frame */
+	ld	r0, LRSAVE(r1)	/* get the real return address */
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
index 0000000..8c99e2d
--- /dev/null
+++ b/arch/powerpc/kernel/livepatch.c
@@ -0,0 +1,54 @@
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
+#include <linux/module.h>
+#include <asm/livepatch.h>
+
+/**
+ * klp_write_module_reloc() - write a relocation in a module
+ * @mod:       module in which the section to be modified is found
+ * @type:      ELF relocation type (see asm/elf.h)
+ * @loc:       address that the relocation should be written to
+ * @value:     relocation value (sym address + addend)
+ *
+ * This function writes a relocation to the specified location for
+ * a particular module.
+ */
+int klp_write_module_reloc(struct module *mod, unsigned long type,
+			    unsigned long loc, unsigned long value)
+{
+	/* This requires infrastructure changes; we need the loadinfos. */
+	pr_err("klp_write_module_reloc not yet supported\n");
+	return -EINVAL;
+}
+
+int klp_matchaddr(struct ftrace_ops *ops, unsigned long ip,
+				int remove, int reset)
+{
+	int ret = 1;
+	unsigned long correct_ip;
+
+	correct_ip = ftrace_location_range(ip, ip + 16);
+	if (!correct_ip)
+		goto done;
+
+	ret = ftrace_set_filter_ip(ops, correct_ip, remove, reset);
+done:
+	return ret;
+}
+
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index c2b340e..fb13cd3 100644
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
index a882865..29cea3a 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -134,6 +134,8 @@ int klp_unregister_patch(struct klp_patch *);
 int klp_enable_patch(struct klp_patch *);
 int klp_disable_patch(struct klp_patch *);
 
+int klp_matchaddr(struct ftrace_ops *ops, unsigned long ip,
+					int remove, int reset);
 #endif /* CONFIG_LIVEPATCH */
 
 #endif /* _LINUX_LIVEPATCH_H_ */
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index bc2c85c..c484a4b 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -298,6 +298,12 @@ unlock:
 	rcu_read_unlock();
 }
 
+int __weak klp_matchaddr(struct ftrace_ops *ops, unsigned long ip,
+					int remove, int reset)
+{
+	return ftrace_set_filter_ip(ops, ip, remove, reset);
+}
+
 static void klp_disable_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
@@ -313,7 +319,7 @@ static void klp_disable_func(struct klp_func *func)
 
 	if (list_is_singular(&ops->func_stack)) {
 		WARN_ON(unregister_ftrace_function(&ops->fops));
-		WARN_ON(ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0));
+		WARN_ON(klp_matchaddr(&ops->fops, func->old_addr, 1, 0));
 
 		list_del_rcu(&func->stack_node);
 		list_del(&ops->node);
@@ -352,7 +358,7 @@ static int klp_enable_func(struct klp_func *func)
 		INIT_LIST_HEAD(&ops->func_stack);
 		list_add_rcu(&func->stack_node, &ops->func_stack);
 
-		ret = ftrace_set_filter_ip(&ops->fops, func->old_addr, 0, 0);
+		ret = klp_matchaddr(&ops->fops, func->old_addr, 0, 0);
 		if (ret) {
 			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
 			       func->old_name, ret);
@@ -363,7 +369,7 @@ static int klp_enable_func(struct klp_func *func)
 		if (ret) {
 			pr_err("failed to register ftrace handler for function '%s' (%d)\n",
 			       func->old_name, ret);
-			ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0);
+			klp_matchaddr(&ops->fops, func->old_addr, 1, 0);
 			goto err;
 		}
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 57a6eea..18b2969 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1533,7 +1533,7 @@ static int ftrace_cmp_recs(const void *a, const void *b)
 	return 0;
 }
 
-static unsigned long ftrace_location_range(unsigned long start, unsigned long end)
+unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 {
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
-- 
2.5.0

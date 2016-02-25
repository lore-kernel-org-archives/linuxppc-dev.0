Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 549941A0349
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 10:19:39 +1100 (AEDT)
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A0C411402BC
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 10:19:38 +1100 (AEDT)
Received: by mail-pf0-x231.google.com with SMTP id e127so40738999pfe.3
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 15:19:38 -0800 (PST)
Received: from cotter.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id h66sm14510623pfd.91.2016.02.25.15.19.35
 for <linuxppc-dev@ozlabs.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 25 Feb 2016 15:19:36 -0800 (PST)
Resent-Message-ID: <56CF8C04.5010001@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	duwe@lst.de
Cc: jkosina@suse.cz, mbenes@suse.cz, pmladek@suse.com, jeyu@redhat.com,
 rostedt@goodmis.org, live-patching@vger.kernel.org,
 Torsten Duwe <duwe@suse.de>, Balbir Singh <bsingharora@gmail.com>
Subject: [RFC][PATCH] Enable livepatching for powerpc
Date: Thu, 25 Feb 2016 23:11:45 +1100
Message-Id: <1456402305-1612-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This applies on top of the patches posted by Michael today
Enable livepatching. This takes patch 6/8 and 7/8 of v8 as the base.
Removes the extra strict check in gcc-profile-kernel-notrace.sh
and adds logic for checking offsets in livepatch. The patch
for HAVE_C_RECORDMCOUNT is not required and not used here.

Depending on whether or not a TOC is generated, the offset
for _mcount can be +16 or +8. The changes are such that the
offset checks are specific to powerpc.

Comments? Testing? I tested the sample in the livepatch
directory

References

1. https://patchwork.ozlabs.org/patch/581521/
2. https://patchwork.ozlabs.org/patch/587464/

Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/Kconfig                        |  3 ++
 arch/powerpc/gcc-mprofile-kernel-notrace.sh |  7 ----
 arch/powerpc/include/asm/livepatch.h        | 61 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile                |  1 +
 arch/powerpc/kernel/entry_64.S              | 46 ++++++++++++++++++++++
 arch/powerpc/kernel/livepatch.c             | 38 ++++++++++++++++++
 include/linux/livepatch.h                   | 13 ++++++
 kernel/livepatch/core.c                     |  4 +-
 8 files changed, 164 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9f72565..72e46b0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -160,6 +160,7 @@ config PPC
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select HAVE_ARCH_SECCOMP_FILTER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select HAVE_LIVEPATCH if PPC64 && CPU_LITTLE_ENDIAN
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
@@ -1093,3 +1094,5 @@ config PPC_LIB_RHEAP
 	bool
 
 source "arch/powerpc/kvm/Kconfig"
+
+source "kernel/livepatch/Kconfig"
diff --git a/arch/powerpc/gcc-mprofile-kernel-notrace.sh b/arch/powerpc/gcc-mprofile-kernel-notrace.sh
index 68d6482..6dafff6 100755
--- a/arch/powerpc/gcc-mprofile-kernel-notrace.sh
+++ b/arch/powerpc/gcc-mprofile-kernel-notrace.sh
@@ -12,12 +12,6 @@ echo "int func() { return 0; }" | \
 
 trace_result=$?
 
-echo "int func() { return 0; }" | \
-    $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
-    sed -n -e '/func:/,/bl _mcount/p' | grep -q TOC
-
-leaf_toc_result=$?
-
 /bin/echo -e "#include <linux/compiler.h>\nnotrace int func() { return 0; }" | \
     $* -S -x c -O2 -p -mprofile-kernel - -o - 2> /dev/null | \
     grep -q "mcount"
@@ -25,7 +19,6 @@ leaf_toc_result=$?
 notrace_result=$?
 
 if [ "$trace_result" -eq "0" -a \
-	"$leaf_toc_result" -eq "0" -a \
 	"$notrace_result" -eq "1" ]; then
 	echo y
 else
diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
new file mode 100644
index 0000000..6abb69c
--- /dev/null
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -0,0 +1,61 @@
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
+static inline int klp_check_compiler_support(void)
+{
+#if !defined(_CALL_ELF) || _CALL_ELF != 2 || !defined(CC_USING_MPROFILE_KERNEL)
+	return 1;
+#endif
+	return 0;
+}
+
+#define ARCH_HAVE_KLP_MATCHADDR
+static inline int klp_matchaddr(struct ftrace_ops *ops, unsigned long ip,
+				int remove, int reset)
+{
+	int offsets[] = {8, 16};
+	int i;
+	int ret = 1;
+
+	for (i = 0; i < ARRAY_SIZE(offsets); i++) {
+		ret = ftrace_set_filter_ip(ops, ip+offsets[i], remove, reset);
+		if (!ret)
+			break;
+	}
+	return ret;
+}
+
+extern int klp_write_module_reloc(struct module *mod, unsigned long type,
+				   unsigned long loc, unsigned long value);
+
+static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+{
+	regs->nip = ip;
+}
+#else
+#error Live patching support is disabled; check CONFIG_LIVEPATCH
+#endif
+
+#endif /* _ASM_POWERPC64_LIVEPATCH_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 44667fd..405efce 100644
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
index f347f50..853717f 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1225,6 +1225,9 @@ _GLOBAL(ftrace_caller)
 
 	/* Calculate ip from nip-4 into r3 for call below */
 	subi    r3, r7, MCOUNT_INSN_SIZE
+#ifdef CONFIG_LIVEPATCH
+	mr	r14,r3		/* remember old NIP */
+#endif
 
 	/* Put the original return address in r4 as parent_ip */
 	mr	r4, r0
@@ -1247,6 +1250,9 @@ ftrace_call:
 	/* Load ctr with the possibly modified NIP */
 	ld	r3, _NIP(r1)
 	mtctr	r3
+#ifdef CONFIG_LIVEPATCH
+	cmpd	r14,r3		/* has NIP been altered? */
+#endif
 
 	/* Restore gprs */
 	REST_8GPRS(0,r1)
@@ -1264,6 +1270,27 @@ ftrace_call:
 	ld	r0, LRSAVE(r1)
 	mtlr	r0
 
+#ifdef CONFIG_LIVEPATCH
+	beq+	4f		/* likely(old_NIP == new_NIP) */
+
+	/* For a local call, restore this TOC after calling the patch function.
+	 * For a global call, it does not matter what we restore here,
+	 * since the global caller does its own restore right afterwards,
+	 * anyway. Just insert a KLP_return_helper frame in any case,
+	 * so a patch function can always count on the changed stack offsets.
+	 */
+	stdu	r1,-32(r1)	/* open new mini stack frame */
+	std	r0,24(r1)	/* save TOC now, unconditionally. */
+	bl	5f
+5:	mflr	r12
+	addi	r12,r12,(KLP_return_helper+4-.)@l
+	std	r12,LRSAVE(r1)
+	mtlr	r12
+	mfctr	r12		/* allow for TOC calculation in newfunc */
+	bctr
+4:
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	stdu	r1, -112(r1)
 .globl ftrace_graph_call
@@ -1279,6 +1306,25 @@ _GLOBAL(ftrace_graph_stub)
 #endif /* CC_USING_MPROFILE_KERNEL */
 _GLOBAL(ftrace_stub)
 	blr
+#ifdef CONFIG_LIVEPATCH
+/* Helper function for local calls that are becoming global
+   due to live patching.
+   We can't simply patch the NOP after the original call,
+   because, depending on the consistency model, some kernel
+   threads may still have called the original, local function
+   *without* saving their TOC in the respective stack frame slot,
+   so the decision is made per-thread during function return by
+   maybe inserting a KLP_return_helper frame or not.
+*/
+KLP_return_helper:
+	ld	r2,24(r1)	/* restore TOC (saved by ftrace_caller) */
+	addi r1, r1, 32		/* destroy mini stack frame */
+	ld	r0,LRSAVE(r1)	/* get the real return address */
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
index 0000000..cdd15f1
--- /dev/null
+++ b/arch/powerpc/kernel/livepatch.c
@@ -0,0 +1,38 @@
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
+	return -ENOSYS;
+}
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index a882865..e63a5b3 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -134,6 +134,19 @@ int klp_unregister_patch(struct klp_patch *);
 int klp_enable_patch(struct klp_patch *);
 int klp_disable_patch(struct klp_patch *);
 
+#ifndef ARCH_HAVE_KLP_MATCHADDR
+static inline int klp_matchaddr(struct ftrace_ops *ops, unsigned long ip,
+				int remove, int reset)
+{
+	return ftrace_set_filter_ip(ops, ip, remove, reset);
+}
+
+#else
+int klp_matchaddr(struct ftrace_ops *ops, unsigned long ip,
+				int remove, int reset);
+
+#endif
+
 #endif /* CONFIG_LIVEPATCH */
 
 #endif /* _LINUX_LIVEPATCH_H_ */
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index bc2c85c..6625b06 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -313,7 +313,7 @@ static void klp_disable_func(struct klp_func *func)
 
 	if (list_is_singular(&ops->func_stack)) {
 		WARN_ON(unregister_ftrace_function(&ops->fops));
-		WARN_ON(ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0));
+		WARN_ON(klp_matchaddr(&ops->fops, func->old_addr, 1, 0));
 
 		list_del_rcu(&func->stack_node);
 		list_del(&ops->node);
@@ -352,7 +352,7 @@ static int klp_enable_func(struct klp_func *func)
 		INIT_LIST_HEAD(&ops->func_stack);
 		list_add_rcu(&func->stack_node, &ops->func_stack);
 
-		ret = ftrace_set_filter_ip(&ops->fops, func->old_addr, 0, 0);
+		ret = klp_matchaddr(&ops->fops, func->old_addr, 0, 0);
 		if (ret) {
 			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
 			       func->old_name, ret);

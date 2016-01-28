Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F42B1A03B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 04:45:20 +1100 (AEDT)
In-Reply-To: <20160210174221.EBBEC692C8@newverein.lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
From: Torsten Duwe <duwe@lst.de>
Date: Thu, 28 Jan 2016 16:32:19 +0100
Subject: [PATCH v8 8/8] livepatch: Detect offset for the ftrace location
 during build
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Message-Id: <20160210174517.8347D692C8@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Petr Mladek <pmladek@suse.com>

Livepatch works on x86_64 and s390 only when the ftrace call
is at the very beginning of the function. But PPC is different.
We need to handle TOC and save LR there before calling the
global ftrace handler.

Now, the problem is that the extra operations have different
length on PPC depending on the used gcc version. It is
4 instructions (16 bytes) before gcc-6 and only 3 instructions
(12 bytes) with gcc-6.

This patch tries to detect the offset a generic way during
build. It assumes that the offset of the ftrace location
is the same for all functions. It modifies the existing
recordmcount tool that is able to find read mcount locations
directly from the object files. It adds an option -p
to print the first found offset.

The recordmcount tool is then used in the kernel/livepatch
subdirectory to generate a header file. It defines
a constant that is used to compute the ftrace location
from the function address.

Finally, we have to enable the C implementation of the
recordmcount tool to be used on PPC and S390. It seems
to work fine there. It should be more reliable because
it reads the standardized elf structures. The old perl
implementation uses rather complex regular expressions
to parse objdump output and is therefore much more tricky.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/powerpc/Kconfig           |  1 +
 arch/s390/Kconfig              |  1 +
 kernel/livepatch/Makefile      | 13 +++++++++++++
 kernel/livepatch/core.c        | 12 +++++++++---
 kernel/livepatch/ftrace-test.c |  6 ++++++
 scripts/recordmcount.c         |  6 +++++-
 scripts/recordmcount.h         | 17 +++++++++++++++--
 7 files changed, 50 insertions(+), 6 deletions(-)
 create mode 100644 kernel/livepatch/ftrace-test.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8c7a327..a546829 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -93,6 +93,7 @@ config PPC
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_C_RECORDMCOUNT
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if PPC64 && CPU_LITTLE_ENDIAN
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 3be9c83..c574bc4 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -121,6 +121,7 @@ config S390
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_BPF_JIT if PACK_STACK && HAVE_MARCH_Z196_FEATURES
+	select HAVE_C_RECORDMCOUNT
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/kernel/livepatch/Makefile b/kernel/livepatch/Makefile
index e8780c0..65a44b6 100644
--- a/kernel/livepatch/Makefile
+++ b/kernel/livepatch/Makefile
@@ -1,3 +1,16 @@
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 
 livepatch-objs := core.o
+
+always		:= $(hostprogs-y) ftrace-test.o
+
+# dependencies on generated files need to be listed explicitly
+$(obj)/core.o: $(obj)/livepatch-ftrace.h
+
+quiet_cmd_livepatch-rmcount = RMCOUNT $@
+      cmd_livepatch-rmcount = $(objtree)/scripts/recordmcount -p $< > $@
+
+$(obj)/livepatch-ftrace.h: $(obj)/ftrace-test.o $(objtree)/scripts/recordmcount
+	$(call if_changed,livepatch-rmcount)
+
+targets += livepatch-ftrace.h
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index bc2c85c..864d589 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -30,6 +30,8 @@
 #include <linux/livepatch.h>
 #include <asm/cacheflush.h>
 
+#include "livepatch-ftrace.h"
+
 /**
  * struct klp_ops - structure for tracking registered ftrace ops structs
  *
@@ -312,8 +314,10 @@ static void klp_disable_func(struct klp_func *func)
 		return;
 
 	if (list_is_singular(&ops->func_stack)) {
+		unsigned long ftrace_loc = func->old_addr + KLP_FTRACE_LOCATION;
+
 		WARN_ON(unregister_ftrace_function(&ops->fops));
-		WARN_ON(ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0));
+		WARN_ON(ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0));
 
 		list_del_rcu(&func->stack_node);
 		list_del(&ops->node);
@@ -338,6 +342,8 @@ static int klp_enable_func(struct klp_func *func)
 
 	ops = klp_find_ops(func->old_addr);
 	if (!ops) {
+		unsigned long ftrace_loc = func->old_addr + KLP_FTRACE_LOCATION;
+
 		ops = kzalloc(sizeof(*ops), GFP_KERNEL);
 		if (!ops)
 			return -ENOMEM;
@@ -352,7 +358,7 @@ static int klp_enable_func(struct klp_func *func)
 		INIT_LIST_HEAD(&ops->func_stack);
 		list_add_rcu(&func->stack_node, &ops->func_stack);
 
-		ret = ftrace_set_filter_ip(&ops->fops, func->old_addr, 0, 0);
+		ret = ftrace_set_filter_ip(&ops->fops, ftrace_loc, 0, 0);
 		if (ret) {
 			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
 			       func->old_name, ret);
@@ -363,7 +369,7 @@ static int klp_enable_func(struct klp_func *func)
 		if (ret) {
 			pr_err("failed to register ftrace handler for function '%s' (%d)\n",
 			       func->old_name, ret);
-			ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0);
+			ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0);
 			goto err;
 		}
 
diff --git a/kernel/livepatch/ftrace-test.c b/kernel/livepatch/ftrace-test.c
new file mode 100644
index 0000000..22f0c54
--- /dev/null
+++ b/kernel/livepatch/ftrace-test.c
@@ -0,0 +1,6 @@
+/* Sample code to figure out mcount location offset */
+
+int test(int a)
+{
+	return ++a;
+}
diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index e167592..e351b2f 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -53,6 +53,7 @@ static struct stat sb;	/* Remember .st_size, etc. */
 static jmp_buf jmpenv;	/* setjmp/longjmp per-file error escape */
 static const char *altmcount;	/* alternate mcount symbol name */
 static int warn_on_notrace_sect; /* warn when section has mcount not being recorded */
+static int print_mcount_offset; /* print offset of the first mcount location */
 static void *file_map;	/* pointer of the mapped file */
 static void *file_end;	/* pointer to the end of the mapped file */
 static int file_updated; /* flag to state file was changed */
@@ -539,11 +540,14 @@ main(int argc, char *argv[])
 	int c;
 	int i;
 
-	while ((c = getopt(argc, argv, "w")) >= 0) {
+	while ((c = getopt(argc, argv, "wp")) >= 0) {
 		switch (c) {
 		case 'w':
 			warn_on_notrace_sect = 1;
 			break;
+		case 'p':
+			print_mcount_offset = 1;
+			break;
 		default:
 			fprintf(stderr, "usage: recordmcount [-w] file.o...\n");
 			return 0;
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index b9897e2..a677a5a 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -47,6 +47,7 @@
 #undef fn_ELF_R_SYM
 #undef fn_ELF_R_INFO
 #undef uint_t
+#undef uint_t_format
 #undef _w
 #undef _align
 #undef _size
@@ -81,6 +82,7 @@
 # define fn_ELF_R_SYM		fn_ELF64_R_SYM
 # define fn_ELF_R_INFO		fn_ELF64_R_INFO
 # define uint_t			uint64_t
+# define uint_t_format		"%lu"
 # define _w			w8
 # define _align			7u
 # define _size			8
@@ -114,6 +116,7 @@
 # define fn_ELF_R_SYM		fn_ELF32_R_SYM
 # define fn_ELF_R_INFO		fn_ELF32_R_INFO
 # define uint_t			uint32_t
+# define uint_t_format		"%u"
 # define _w			w
 # define _align			3u
 # define _size			4
@@ -338,7 +341,14 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 			} else
 				*mlocp++ = addend;
 
+			if (print_mcount_offset) {
+				printf("#define KLP_FTRACE_LOCATION " uint_t_format "\n",
+				       addend);
+				succeed_file();
+			}
+
 			mrelp = (Elf_Rel *)(rel_entsize + (void *)mrelp);
+
 		}
 		relp = (Elf_Rel const *)(rel_entsize + (void *)relp);
 	}
@@ -458,7 +468,8 @@ __has_rel_mcount(Elf_Shdr const *const relhdr,  /* is SHT_REL or SHT_RELA */
 	Elf_Shdr const *const txthdr = &shdr0[w(relhdr->sh_info)];
 	char const *const txtname = &shstrtab[w(txthdr->sh_name)];
 
-	if (strcmp("__mcount_loc", txtname) == 0) {
+	/* Allow to print the mcount offset for an already modified file. */
+	if (strcmp("__mcount_loc", txtname) == 0 && !print_mcount_offset) {
 		fprintf(stderr, "warning: __mcount_loc already exists: %s\n",
 			fname);
 		succeed_file();
@@ -546,7 +557,9 @@ do_func(Elf_Ehdr *const ehdr, char const *const fname, unsigned const reltype)
 			nop_mcount(relhdr, ehdr, txtname);
 		}
 	}
-	if (mloc0 != mlocp) {
+
+	/* The file is not modified when the offset is just printed. */
+	if (mloc0 != mlocp && !print_mcount_offset) {
 		append_func(ehdr, shstr, mloc0, mlocp, mrel0, mrelp,
 			    rel_entsize, symsec_sh_link);
 	}
-- 
1.8.5.6

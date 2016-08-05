Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Qg748QYzDqYN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 22:12:51 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y134so20071614pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 05:12:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Alan Modra <amodra@gmail.com>
Subject: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Date: Fri,  5 Aug 2016 22:12:00 +1000
Message-Id: <1470399123-8455-3-git-send-email-npiggin@gmail.com>
In-Reply-To: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce LINKER_DCE option for architectures to select if they want
to build with -ffunction-sections, -fdata-sections, and link with
--gc-sections. It requires some work (documented) to ensure all
unreferenced entrypoints are live, and requires toolchain and
build verification, so it is made a per-arch option for now.

On a random powerpc64le build, this yelds a significant size saving,
it boots and runs fine, but there is a lot I haven't tested as yet,
so these savings may be reduced if there are bugs in the link.

    text      data        bss        dec   filename
11169741   1180744    1923176	14273661   vmlinux
10445269   1004127    1919707	13369103   vmlinux.dce

~700K text, ~170K data, 6% removed from kernel image size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Makefile                          | 10 ++++++++
 arch/Kconfig                      | 13 ++++++++++
 include/asm-generic/vmlinux.lds.h | 52 ++++++++++++++++++++++-----------------
 include/linux/compiler.h          | 18 ++++++++++++++
 include/linux/export.h            | 30 +++++++++++-----------
 include/linux/init.h              | 38 ++++++++++------------------
 init/Makefile                     |  2 ++
 7 files changed, 100 insertions(+), 63 deletions(-)

diff --git a/Makefile b/Makefile
index b409076..d5ef31a 100644
--- a/Makefile
+++ b/Makefile
@@ -618,6 +618,11 @@ include arch/$(SRCARCH)/Makefile
 
 KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
 
+ifdef CONFIG_LINKER_DCE
+KBUILD_CFLAGS	+= $(call cc-option,-ffunction-sections,)
+KBUILD_CFLAGS	+= $(call cc-option,-fdata-sections,)
+endif
+
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= -Os $(call cc-disable-warning,maybe-uninitialized,)
 else
@@ -819,6 +824,11 @@ LDFLAGS_BUILD_ID = $(patsubst -Wl$(comma)%,%,\
 KBUILD_LDFLAGS_MODULE += $(LDFLAGS_BUILD_ID)
 LDFLAGS_vmlinux += $(LDFLAGS_BUILD_ID)
 
+ifdef CONFIG_LINKER_DCE
+# LDFLAGS_MODULE	+= $(call ld-option, --gc-sections,)
+LDFLAGS_vmlinux	+= $(call ld-option, --gc-sections,)
+endif
+
 ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
 LDFLAGS_vmlinux	+= $(call ld-option, -X,)
 endif
diff --git a/arch/Kconfig b/arch/Kconfig
index 1330bf4..a49092b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -430,6 +430,19 @@ config THIN_ARCHIVES
 	  Select this if the architecture wants to use thin archives
 	  instead of ld -r to create the built-in.o files.
 
+config LINKER_DCE
+	bool
+	help
+	  Select this if the architecture wants to do dead code and
+	  data elimination with the linker by compiling with
+	  -ffunction-sections -fdata-sections and linking with
+	  --gc-sections.
+
+	  This requires that the arch annotates or otherwise protects
+	  its external entry points from being discarded. Linker scripts
+	  must also merge .text.*, .data.*, and .bss.* correctly into
+	  output sections.
+
 config HAVE_CONTEXT_TRACKING
 	bool
 	help
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 6a67ab9..a66ffe9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -196,9 +196,14 @@
 	*(.dtb.init.rodata)						\
 	VMLINUX_SYMBOL(__dtb_end) = .;
 
-/* .data section */
+/*
+ * .data section
+ * -fdata-sections generates .data.identifier which needs to be pulled in
+ * with .data, but don't want to pull in .data..stuff which has its own
+ * requirements. Same for bss.
+ */
 #define DATA_DATA							\
-	*(.data)							\
+	*(.data .data.[0-9a-zA-Z_]*)					\
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
 	MEM_KEEP(init.data)						\
@@ -312,76 +317,76 @@
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start___ksymtab) = .;			\
-		*(SORT(___ksymtab+*))					\
+		KEEP(*(SORT(___ksymtab+*)))				\
 		VMLINUX_SYMBOL(__stop___ksymtab) = .;			\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
 	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
 		VMLINUX_SYMBOL(__start___ksymtab_gpl) = .;		\
-		*(SORT(___ksymtab_gpl+*))				\
+		KEEP(*(SORT(___ksymtab_gpl+*)))				\
 		VMLINUX_SYMBOL(__stop___ksymtab_gpl) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: Normal unused symbols */		\
 	__ksymtab_unused  : AT(ADDR(__ksymtab_unused) - LOAD_OFFSET) {	\
 		VMLINUX_SYMBOL(__start___ksymtab_unused) = .;		\
-		*(SORT(___ksymtab_unused+*))				\
+		KEEP(*(SORT(___ksymtab_unused+*)))			\
 		VMLINUX_SYMBOL(__stop___ksymtab_unused) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only unused symbols */		\
 	__ksymtab_unused_gpl : AT(ADDR(__ksymtab_unused_gpl) - LOAD_OFFSET) { \
 		VMLINUX_SYMBOL(__start___ksymtab_unused_gpl) = .;	\
-		*(SORT(___ksymtab_unused_gpl+*))			\
+		KEEP(*(SORT(___ksymtab_unused_gpl+*)))			\
 		VMLINUX_SYMBOL(__stop___ksymtab_unused_gpl) = .;	\
 	}								\
 									\
 	/* Kernel symbol table: GPL-future-only symbols */		\
 	__ksymtab_gpl_future : AT(ADDR(__ksymtab_gpl_future) - LOAD_OFFSET) { \
 		VMLINUX_SYMBOL(__start___ksymtab_gpl_future) = .;	\
-		*(SORT(___ksymtab_gpl_future+*))			\
+		KEEP(*(SORT(___ksymtab_gpl_future+*)))			\
 		VMLINUX_SYMBOL(__stop___ksymtab_gpl_future) = .;	\
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start___kcrctab) = .;			\
-		*(SORT(___kcrctab+*))					\
+		KEEP(*(SORT(___kcrctab+*)))				\
 		VMLINUX_SYMBOL(__stop___kcrctab) = .;			\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
 	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
 		VMLINUX_SYMBOL(__start___kcrctab_gpl) = .;		\
-		*(SORT(___kcrctab_gpl+*))				\
+		KEEP(*(SORT(___kcrctab_gpl+*)))				\
 		VMLINUX_SYMBOL(__stop___kcrctab_gpl) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: Normal unused symbols */		\
 	__kcrctab_unused  : AT(ADDR(__kcrctab_unused) - LOAD_OFFSET) {	\
 		VMLINUX_SYMBOL(__start___kcrctab_unused) = .;		\
-		*(SORT(___kcrctab_unused+*))				\
+		KEEP(*(SORT(___kcrctab_unused+*)))			\
 		VMLINUX_SYMBOL(__stop___kcrctab_unused) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only unused symbols */		\
 	__kcrctab_unused_gpl : AT(ADDR(__kcrctab_unused_gpl) - LOAD_OFFSET) { \
 		VMLINUX_SYMBOL(__start___kcrctab_unused_gpl) = .;	\
-		*(SORT(___kcrctab_unused_gpl+*))			\
+		KEEP(*(SORT(___kcrctab_unused_gpl+*)))			\
 		VMLINUX_SYMBOL(__stop___kcrctab_unused_gpl) = .;	\
 	}								\
 									\
 	/* Kernel symbol table: GPL-future-only symbols */		\
 	__kcrctab_gpl_future : AT(ADDR(__kcrctab_gpl_future) - LOAD_OFFSET) { \
 		VMLINUX_SYMBOL(__start___kcrctab_gpl_future) = .;	\
-		*(SORT(___kcrctab_gpl_future+*))			\
+		KEEP(*(SORT(___kcrctab_gpl_future+*)))			\
 		VMLINUX_SYMBOL(__stop___kcrctab_gpl_future) = .;	\
 	}								\
 									\
 	/* Kernel symbol table: strings */				\
         __ksymtab_strings : AT(ADDR(__ksymtab_strings) - LOAD_OFFSET) {	\
-		*(__ksymtab_strings)					\
+		KEEP(*(__ksymtab_strings))				\
 	}								\
 									\
 	/* __*init sections */						\
@@ -416,7 +421,7 @@
 #define SECURITY_INIT							\
 	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
 		VMLINUX_SYMBOL(__security_initcall_start) = .;		\
-		*(.security_initcall.init) 				\
+		KEEP(*(.security_initcall.init))			\
 		VMLINUX_SYMBOL(__security_initcall_end) = .;		\
 	}
 
@@ -424,7 +429,7 @@
  * during second ld run in second ld pass when generating System.map */
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
-		*(.text.hot .text .text.fixup .text.unlikely)		\
+		*(.text.hot .text .text.fixup .text.unlikely .text.*)	\
 		*(.ref.text)						\
 	MEM_KEEP(init.text)						\
 	MEM_KEEP(exit.text)						\
@@ -519,6 +524,7 @@
 
 /* init and exit section handling */
 #define INIT_DATA							\
+	KEEP(*(SORT(___kentry+*)))					\
 	*(.init.data)							\
 	MEM_DISCARD(init.data)						\
 	KERNEL_CTORS()							\
@@ -581,7 +587,7 @@
 		BSS_FIRST_SECTIONS					\
 		*(.bss..page_aligned)					\
 		*(.dynbss)						\
-		*(.bss)							\
+		*(.bss .bss.[0-9a-zA-Z_]*)				\
 		*(COMMON)						\
 	}
 
@@ -664,12 +670,12 @@
 
 #define INIT_CALLS_LEVEL(level)						\
 		VMLINUX_SYMBOL(__initcall##level##_start) = .;		\
-		*(.initcall##level##.init)				\
-		*(.initcall##level##s.init)				\
+		KEEP(*(.initcall##level##.init))			\
+		KEEP(*(.initcall##level##s.init))			\
 
 #define INIT_CALLS							\
 		VMLINUX_SYMBOL(__initcall_start) = .;			\
-		*(.initcallearly.init)					\
+		KEEP(*(.initcallearly.init))				\
 		INIT_CALLS_LEVEL(0)					\
 		INIT_CALLS_LEVEL(1)					\
 		INIT_CALLS_LEVEL(2)					\
@@ -683,21 +689,21 @@
 
 #define CON_INITCALL							\
 		VMLINUX_SYMBOL(__con_initcall_start) = .;		\
-		*(.con_initcall.init)					\
+		KEEP(*(.con_initcall.init))				\
 		VMLINUX_SYMBOL(__con_initcall_end) = .;
 
 #define SECURITY_INITCALL						\
 		VMLINUX_SYMBOL(__security_initcall_start) = .;		\
-		*(.security_initcall.init)				\
+		KEEP(*(.security_initcall.init))			\
 		VMLINUX_SYMBOL(__security_initcall_end) = .;
 
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
 	VMLINUX_SYMBOL(__initramfs_start) = .;				\
-	*(.init.ramfs)							\
+	KEEP(*(.init.ramfs))						\
 	. = ALIGN(8);							\
-	*(.init.ramfs.info)
+	KEEP(*(.init.ramfs.info))
 #else
 #define INIT_RAM_FS
 #endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 793c082..8404d93 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -184,6 +184,24 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
 # define unreachable() do { } while (1)
 #endif
 
+/*
+ * KENTRY - kernel entry point
+ * This can be used to annotate symbols (functions or data) that are used
+ * without their linker symbol being referenced. For example, interrupt vector
+ * handlers, or functions in the kernel image that are found programatically.
+ * This can be avoided if the symbols are marked as KEEP() in the linker script.
+ * For example the architecture could KEEP() its entire exception vector
+ * code rather than annotate each one.
+ */
+#ifndef KENTRY
+# define KENTRY(sym)						\
+	extern typeof(sym) sym;					\
+	static const unsigned long __kentry_##sym		\
+	__used							\
+	__attribute__((section("___kentry" "+" #sym ), used))	\
+	= (unsigned long)&sym;
+#endif
+
 #ifndef RELOC_HIDE
 # define RELOC_HIDE(ptr, off)					\
   ({ unsigned long __ptr;					\
diff --git a/include/linux/export.h b/include/linux/export.h
index 2f9ccbe..0d1ccdd 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -1,5 +1,6 @@
 #ifndef _LINUX_EXPORT_H
 #define _LINUX_EXPORT_H
+
 /*
  * Export symbols from the kernel to modules.  Forked from module.h
  * to reduce the amount of pointless cruft we feed to gcc when only
@@ -42,27 +43,26 @@ extern struct module __this_module;
 #ifdef CONFIG_MODVERSIONS
 /* Mark the CRC weak since genksyms apparently decides not to
  * generate a checksums for some symbols */
-#define __CRC_SYMBOL(sym, sec)					\
-	extern __visible void *__crc_##sym __attribute__((weak));		\
-	static const unsigned long __kcrctab_##sym		\
-	__used							\
-	__attribute__((section("___kcrctab" sec "+" #sym), unused))	\
+#define __CRC_SYMBOL(sym, sec)						\
+	extern __visible void *__crc_##sym __attribute__((weak));	\
+	static const unsigned long __kcrctab_##sym			\
+	__used								\
+	__attribute__((section("___kcrctab" sec "+" #sym), used))	\
 	= (unsigned long) &__crc_##sym;
 #else
 #define __CRC_SYMBOL(sym, sec)
 #endif
 
 /* For every exported symbol, place a struct in the __ksymtab section */
-#define ___EXPORT_SYMBOL(sym, sec)				\
-	extern typeof(sym) sym;					\
-	__CRC_SYMBOL(sym, sec)					\
-	static const char __kstrtab_##sym[]			\
-	__attribute__((section("__ksymtab_strings"), aligned(1))) \
-	= VMLINUX_SYMBOL_STR(sym);				\
-	extern const struct kernel_symbol __ksymtab_##sym;	\
-	__visible const struct kernel_symbol __ksymtab_##sym	\
-	__used							\
-	__attribute__((section("___ksymtab" sec "+" #sym), unused))	\
+#define ___EXPORT_SYMBOL(sym, sec)					\
+	extern typeof(sym) sym;						\
+	__CRC_SYMBOL(sym, sec)						\
+	static const char __kstrtab_##sym[]				\
+	__attribute__((section("__ksymtab_strings"), aligned(1)))	\
+	= VMLINUX_SYMBOL_STR(sym);					\
+	static const struct kernel_symbol __ksymtab_##sym		\
+	__used								\
+	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
 #if defined(__KSYM_DEPS__)
diff --git a/include/linux/init.h b/include/linux/init.h
index aedb254..9abd61f 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -156,24 +156,8 @@ extern bool initcall_debug;
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_LTO
-/* Work around a LTO gcc problem: when there is no reference to a variable
- * in a module it will be moved to the end of the program. This causes
- * reordering of initcalls which the kernel does not like.
- * Add a dummy reference function to avoid this. The function is
- * deleted by the linker.
- */
-#define LTO_REFERENCE_INITCALL(x) \
-	; /* yes this is needed */			\
-	static __used __exit void *reference_##x(void)	\
-	{						\
-		return &x;				\
-	}
-#else
-#define LTO_REFERENCE_INITCALL(x)
-#endif
-
-/* initcalls are now grouped by functionality into separate 
+/*
+ * initcalls are now grouped by functionality into separate 
  * subsections. Ordering inside the subsections is determined
  * by link order. 
  * For backwards compatibility, initcall() puts the call in 
@@ -181,12 +165,16 @@ extern bool initcall_debug;
  *
  * The `id' arg to __define_initcall() is needed so that multiple initcalls
  * can point at the same handler without causing duplicate-symbol build errors.
+ *
+ * Initcalls are run by placing pointers in initcall sections that the
+ * kernel iterates at runtime. The linker can do dead code / data elimination
+ * and remove that completely, so the initcall sections have to be marked
+ * as KEEP() in the linker script.
  */
 
 #define __define_initcall(fn, id) \
 	static initcall_t __initcall_##fn##id __used \
-	__attribute__((__section__(".initcall" #id ".init"))) = fn; \
-	LTO_REFERENCE_INITCALL(__initcall_##fn##id)
+	__attribute__((__section__(".initcall" #id ".init"))) = fn;
 
 /*
  * Early initcalls run before initializing SMP.
@@ -222,15 +210,15 @@ extern bool initcall_debug;
 
 #define __initcall(fn) device_initcall(fn)
 
-#define __exitcall(fn) \
+#define __exitcall(fn)						\
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
-#define console_initcall(fn) \
-	static initcall_t __initcall_##fn \
+#define console_initcall(fn)					\
+	static initcall_t __initcall_##fn			\
 	__used __section(.con_initcall.init) = fn
 
-#define security_initcall(fn) \
-	static initcall_t __initcall_##fn \
+#define security_initcall(fn)					\
+	static initcall_t __initcall_##fn			\
 	__used __section(.security_initcall.init) = fn
 
 struct obs_kernel_param {
diff --git a/init/Makefile b/init/Makefile
index 7bc47ee..c4fb455 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+ccflags-y := -fno-function-sections -fno-data-sections
+
 obj-y                          := main.o version.o mounts.o
 ifneq ($(CONFIG_BLK_DEV_INITRD),y)
 obj-y                          += noinitramfs.o
-- 
2.8.1

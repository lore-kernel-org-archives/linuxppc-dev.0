Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40S70Y0s0dzF258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 17:34:36 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h69so3882619pfe.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 00:34:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
 Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 1/4] kbuild: Fix asm-generic/vmlinux.lds.h for
 LD_DEAD_CODE_DATA_ELIMINATION
Date: Fri, 20 Apr 2018 17:34:11 +1000
Message-Id: <20180420073414.23169-2-npiggin@gmail.com>
In-Reply-To: <20180420073414.23169-1-npiggin@gmail.com>
References: <20180420073414.23169-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KEEP more tables, and add the function/data section wildcard to more
section selections.

This is a little ad-hoc at the moment, but kernel code should be moved
to consistently use .text..x (note: double dots) for explicit sections
and all references to it in the linker script can be made with
TEXT_MAIN, and similarly for other sections.

For now, let's see if major architectures move to enabling this option
then we can do some refactoring passes. Otherwise if it remains unused
or superseded by LTO, this may not be required.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 49 ++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 278841c75b97..23f5f8d22f56 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -64,15 +64,24 @@
  * generates .data.identifier sections, which need to be pulled in with
  * .data. We don't want to pull in .data..other sections, which Linux
  * has defined. Same for text and bss.
+ *
+ * RODATA_MAIN is not used because existing code already defines .rodata.x
+ * sections to be brought in with rodata.
  */
 #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
 #define DATA_MAIN .data .data.[0-9a-zA-Z_]*
+#define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
+#define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]*
+#define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
 #define TEXT_MAIN .text
 #define DATA_MAIN .data
+#define SDATA_MAIN .sdata
+#define RODATA_MAIN .rodata
 #define BSS_MAIN .bss
+#define SBSS_MAIN .sbss
 #endif
 
 /*
@@ -105,7 +114,7 @@
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			VMLINUX_SYMBOL(__start_mcount_loc) = .; \
-			*(__mcount_loc)				\
+			KEEP(*(__mcount_loc))			\
 			VMLINUX_SYMBOL(__stop_mcount_loc) = .;
 #else
 #define MCOUNT_REC()
@@ -113,7 +122,7 @@
 
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
 #define LIKELY_PROFILE()	VMLINUX_SYMBOL(__start_annotated_branch_profile) = .; \
-				*(_ftrace_annotated_branch)			      \
+				KEEP(*(_ftrace_annotated_branch))		      \
 				VMLINUX_SYMBOL(__stop_annotated_branch_profile) = .;
 #else
 #define LIKELY_PROFILE()
@@ -121,7 +130,7 @@
 
 #ifdef CONFIG_PROFILE_ALL_BRANCHES
 #define BRANCH_PROFILE()	VMLINUX_SYMBOL(__start_branch_profile) = .;   \
-				*(_ftrace_branch)			      \
+				KEEP(*(_ftrace_branch))			      \
 				VMLINUX_SYMBOL(__stop_branch_profile) = .;
 #else
 #define BRANCH_PROFILE()
@@ -238,8 +247,8 @@
 	*(DATA_MAIN)							\
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
-	MEM_KEEP(init.data)						\
-	MEM_KEEP(exit.data)						\
+	MEM_KEEP(init.data*)						\
+	MEM_KEEP(exit.data*)						\
 	*(.data.unlikely)						\
 	VMLINUX_SYMBOL(__start_once) = .;				\
 	*(.data.once)							\
@@ -289,8 +298,8 @@
 	VMLINUX_SYMBOL(__start_init_task) = .;				\
 	VMLINUX_SYMBOL(init_thread_union) = .;				\
 	VMLINUX_SYMBOL(init_stack) = .;					\
-	*(.data..init_task)						\
-	*(.data..init_thread_info)					\
+	KEEP(*(.data..init_task))					\
+	KEEP(*(.data..init_thread_info))				\
 	. = VMLINUX_SYMBOL(__start_init_task) + THREAD_SIZE;		\
 	VMLINUX_SYMBOL(__end_init_task) = .;
 
@@ -487,8 +496,8 @@
 		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
 		*(.text..refcount)					\
 		*(.ref.text)						\
-	MEM_KEEP(init.text)						\
-	MEM_KEEP(exit.text)						\
+	MEM_KEEP(init.text*)						\
+	MEM_KEEP(exit.text*)						\
 
 
 /* sched.text is aling to function alignment to secure we have same
@@ -538,7 +547,7 @@
 		VMLINUX_SYMBOL(__softirqentry_text_end) = .;
 
 /* Section used for early init (in .S files) */
-#define HEAD_TEXT  *(.head.text)
+#define HEAD_TEXT  KEEP(*(.head.text))
 
 #define HEAD_TEXT_SECTION							\
 	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {		\
@@ -579,11 +588,11 @@
 /* init and exit section handling */
 #define INIT_DATA							\
 	KEEP(*(SORT(___kentry+*)))					\
-	*(.init.data)							\
-	MEM_DISCARD(init.data)						\
+	*(.init.data init.data.*)					\
+	MEM_DISCARD(init.data*)						\
 	KERNEL_CTORS()							\
 	MCOUNT_REC()							\
-	*(.init.rodata)							\
+	*(.init.rodata .init.rodata.*)					\
 	FTRACE_EVENTS()							\
 	TRACE_SYSCALLS()						\
 	KPROBE_BLACKLIST()						\
@@ -602,16 +611,16 @@
 	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
-	*(.init.text)							\
+	*(.init.text .init.text.*)					\
 	*(.text.startup)						\
-	MEM_DISCARD(init.text)
+	MEM_DISCARD(init.text*)
 
 #define EXIT_DATA							\
-	*(.exit.data)							\
+	*(.exit.data .exit.data.*)					\
 	*(.fini_array)							\
 	*(.dtors)							\
-	MEM_DISCARD(exit.data)						\
-	MEM_DISCARD(exit.rodata)
+	MEM_DISCARD(exit.data*)						\
+	MEM_DISCARD(exit.rodata*)
 
 #define EXIT_TEXT							\
 	*(.exit.text)							\
@@ -629,7 +638,7 @@
 	. = ALIGN(sbss_align);						\
 	.sbss : AT(ADDR(.sbss) - LOAD_OFFSET) {				\
 		*(.dynsbss)						\
-		*(.sbss)						\
+		*(SBSS_MAIN)						\
 		*(.scommon)						\
 	}
 
@@ -754,7 +763,7 @@
 #define NOTES								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
 		VMLINUX_SYMBOL(__start_notes) = .;			\
-		*(.note.*)						\
+		KEEP(*(.note.*))					\
 		VMLINUX_SYMBOL(__stop_notes) = .;			\
 	}
 
-- 
2.17.0

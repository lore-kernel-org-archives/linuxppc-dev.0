Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spc284xB6zDrLw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 11:23:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3 04/42] powerpc: Use gas sections for arranging exception
 vectors
Date: Wed,  5 Oct 2016 11:22:26 +1100
Message-Id: <1475626984-18770-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
References: <1475626984-18770-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

Use assembler sections of fixed size and location to arrange the 64-bit
Book3S exception vector code (64-bit Book3E also uses it in head_64.S
for 0x0..0x100).

This allows better flexibility in arranging exception code and hiding
unimportant details behind macros.

Gas sections can be a bit painful to use this way, mainly because the
assembler does not know where they will be finally linked. Taking
absolute addresses requires a bit of trickery for example, but it can
be hidden behind macros for the most part.

Generated code is mostly the same except locations, offsets, alignments.

The "+ 0x2" is only required for the trap number / kvm exit number,
which gets loaded as a constant into a register.

Previously, code also used + 0x2 for label names, but we changed to
using "H" to distinguish HV case for that. Remove the last vestiges
of that.

__after_prom_start is taking absolute address of a label in another
fixed section. Newer toolchains seemed to compile this okay, but older
ones do not. FIXED_SYMBOL_ABS_ADDR is more foolproof, it just takes an
additional line to define.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/exception-64s.h |   2 +-
 arch/powerpc/include/asm/head-64.h       | 261 +++++++++++++++++++++++++++++--
 arch/powerpc/kernel/exceptions-64s.S     | 111 +++++++++----
 arch/powerpc/kernel/head_64.S            |  44 ++++--
 arch/powerpc/kernel/vmlinux.lds.S        |  53 ++++++-
 5 files changed, 404 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 72f2b1e3f343..2e4e7d878c8e 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -91,7 +91,7 @@
  */
 #define LOAD_HANDLER(reg, label)					\
 	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
-	ori	reg,reg,((label)-_stext)@l;	/* virt addr of handler ... */
+	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
 
 /* Exception register prefixes */
 #define EXC_HV	H
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index 613f743e91aa..ab90c2fa1ea6 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -3,28 +3,218 @@
 
 #include <asm/cache.h>
 
+/*
+ * We can't do CPP stringification and concatination directly into the section
+ * name for some reason, so these macros can do it for us.
+ */
+.macro define_ftsec name
+	.section ".head.text.\name\()","ax",@progbits
+.endm
+.macro define_data_ftsec name
+	.section ".head.data.\name\()","a",@progbits
+.endm
+.macro use_ftsec name
+	.section ".head.text.\name\()"
+.endm
+
+/*
+ * Fixed (location) sections are used by opening fixed sections and emitting
+ * fixed section entries into them before closing them. Multiple fixed sections
+ * can be open at any time.
+ *
+ * Each fixed section created in a .S file must have corresponding linkage
+ * directives including location, added to  arch/powerpc/kernel/vmlinux.lds.S
+ *
+ * For each fixed section, code is generated into it in the order which it
+ * appears in the source.  Fixed section entries can be placed at a fixed
+ * location within the section using _LOCATION postifx variants. These must
+ * be ordered according to their relative placements within the section.
+ *
+ * OPEN_FIXED_SECTION(section_name, start_address, end_address)
+ * FIXED_SECTION_ENTRY_BEGIN(section_name, label1)
+ *
+ * USE_FIXED_SECTION(section_name)
+ * label3:
+ *     li  r10,128
+ *     mv  r11,r10
+
+ * FIXED_SECTION_ENTRY_BEGIN_LOCATION(section_name, label2, start_address)
+ * FIXED_SECTION_ENTRY_END_LOCATION(section_name, label2, end_address)
+ * CLOSE_FIXED_SECTION(section_name)
+ *
+ * ZERO_FIXED_SECTION can be used to emit zeroed data.
+ *
+ * Troubleshooting:
+ * - If the build dies with "Error: attempt to move .org backwards" at
+ *   CLOSE_FIXED_SECTION() or elsewhere, there may be something
+ *   unexpected being added there. Remove the '. = x_len' line, rebuild, and
+ *   check what is pushing the section down.
+ * - If the build dies in linking, check arch/powerpc/kernel/vmlinux.lds.S
+ *   for instructions.
+ * - If the kernel crashes or hangs in very early boot, it could be linker
+ *   stubs at the start of the main text.
+ */
+
+#define OPEN_FIXED_SECTION(sname, start, end)			\
+	sname##_start = (start);				\
+	sname##_end = (end);					\
+	sname##_len = (end) - (start);				\
+	define_ftsec sname;					\
+	. = 0x0;						\
+start_##sname:
+
+#define OPEN_TEXT_SECTION(start)				\
+	text_start = (start);					\
+	.section ".text","ax",@progbits;			\
+	. = 0x0;						\
+start_text:
+
+#define ZERO_FIXED_SECTION(sname, start, end)			\
+	sname##_start = (start);				\
+	sname##_end = (end);					\
+	sname##_len = (end) - (start);				\
+	define_data_ftsec sname;				\
+	. = 0x0;						\
+	. = sname##_len;
+
+#define USE_FIXED_SECTION(sname)				\
+	fs_label = start_##sname;				\
+	fs_start = sname##_start;				\
+	use_ftsec sname;
+
+#define USE_TEXT_SECTION()					\
+	fs_label = start_text;					\
+	fs_start = text_start;					\
+	.text
+
+#define CLOSE_FIXED_SECTION(sname)				\
+	USE_FIXED_SECTION(sname);				\
+	. = sname##_len;					\
+end_##sname:
+
+
+#define __FIXED_SECTION_ENTRY_BEGIN(sname, name, __align)	\
+	USE_FIXED_SECTION(sname);				\
+	.align __align;						\
+	.global name;						\
+name:
+
+#define FIXED_SECTION_ENTRY_BEGIN(sname, name)			\
+	__FIXED_SECTION_ENTRY_BEGIN(sname, name, 0)
+
+#define FIXED_SECTION_ENTRY_BEGIN_LOCATION(sname, name, start)		\
+	USE_FIXED_SECTION(sname);				\
+	name##_start = (start);					\
+	.if (start) < sname##_start;				\
+	.error "Fixed section underflow";			\
+	.abort;							\
+	.endif;							\
+	. = (start) - sname##_start;				\
+	.global name;						\
+name:
+
+#define FIXED_SECTION_ENTRY_END_LOCATION(sname, name, end)		\
+	.if (end) > sname##_end;				\
+	.error "Fixed section overflow";			\
+	.abort;							\
+	.endif;							\
+	.if (. - name > end - name##_start);			\
+	.error "Fixed entry overflow";				\
+	.abort;							\
+	.endif;							\
+	. = ((end) - sname##_start);				\
+
+
+/*
+ * These macros are used to change symbols in other fixed sections to be
+ * absolute or related to our current fixed section.
+ *
+ * - DEFINE_FIXED_SYMBOL / FIXED_SYMBOL_ABS_ADDR is used to find the
+ *   absolute address of a symbol within a fixed section, from any section.
+ *
+ * - ABS_ADDR is used to find the absolute address of any symbol, from within
+ *   a fixed section.
+ */
+#define DEFINE_FIXED_SYMBOL(label)				\
+	label##_absolute = (label - fs_label + fs_start)
+
+#define FIXED_SYMBOL_ABS_ADDR(label)				\
+	(label##_absolute)
+
+#define ABS_ADDR(label) (label - fs_label + fs_start)
+
+/*
+ * Following are the BOOK3S exception handler helper macros.
+ * Handlers come in a number of types, and each type has a number of varieties.
+ *
+ * EXC_REAL_*        - real, unrelocated exception vectors
+ * EXC_VIRT_*        - virt (AIL), unrelocated exception vectors
+ * TRAMP_REAL_*   - real, unrelocated helpers (virt can call these)
+ * TRAMP_VIRT_*  - virt, unreloc helpers (in practice, real can use)
+ * TRAMP_KVM         - KVM handlers that get put into real, unrelocated
+ * EXC_COMMON_*  - virt, relocated common handlers
+ *
+ * The EXC handlers are given a name, and branch to name_common, or the
+ * appropriate KVM or masking function. Vector handler verieties are as
+ * follows:
+ *
+ * EXC_{REAL|VIRT}_BEGIN/END - used to open-code the exception
+ *
+ * EXC_{REAL|VIRT}  - standard exception
+ *
+ * EXC_{REAL|VIRT}_suffix
+ *     where _suffix is:
+ *   - _MASKABLE               - maskable exception
+ *   - _OOL                    - out of line with trampoline to common handler
+ *   - _HV                     - HV exception
+ *
+ * There can be combinations, e.g., EXC_VIRT_OOL_MASKABLE_HV
+ *
+ * The one unusual case is __EXC_REAL_OOL_HV_DIRECT, which is
+ * an OOL vector that branches to a specified handler rather than the usual
+ * trampoline that goes to common. It, and other underscore macros, should
+ * be used with care.
+ *
+ * KVM handlers come in the following verieties:
+ * TRAMP_KVM
+ * TRAMP_KVM_SKIP
+ * TRAMP_KVM_HV
+ * TRAMP_KVM_HV_SKIP
+ *
+ * COMMON handlers come in the following verieties:
+ * EXC_COMMON_BEGIN/END - used to open-code the handler
+ * EXC_COMMON
+ * EXC_COMMON_ASYNC
+ * EXC_COMMON_HV
+ *
+ * TRAMP_REAL and TRAMP_VIRT can be used with BEGIN/END. KVM
+ * and OOL handlers are implemented as types of TRAMP and TRAMP_VIRT handlers.
+ */
+
 #define EXC_REAL_BEGIN(name, start, end)			\
-	. = start ;							\
-	.global exc_real_##start##_##name ;				\
-exc_real_##start##_##name:
+	FIXED_SECTION_ENTRY_BEGIN_LOCATION(real_vectors, exc_real_##start##_##name, start)
 
-#define EXC_REAL_END(name, start, end)
+#define EXC_REAL_END(name, start, end)			\
+	FIXED_SECTION_ENTRY_END_LOCATION(real_vectors, exc_real_##start##_##name, end)
 
 #define EXC_VIRT_BEGIN(name, start, end)			\
-	. = start ;							\
-	.global exc_virt_##start##_##name ;				\
-exc_virt_##start##_##name:
+	FIXED_SECTION_ENTRY_BEGIN_LOCATION(virt_vectors, exc_virt_##start##_##name, start)
 
-#define EXC_VIRT_END(name, start, end)
+#define EXC_VIRT_END(name, start, end)			\
+	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_virt_##start##_##name, end)
 
 #define EXC_COMMON_BEGIN(name)					\
+	USE_TEXT_SECTION();						\
 	.align	7;							\
 	.global name;							\
+	DEFINE_FIXED_SYMBOL(name);					\
 name:
 
 #define TRAMP_REAL_BEGIN(name)					\
-	.global name ;							\
-name:
+	FIXED_SECTION_ENTRY_BEGIN(real_trampolines, name)
+
+#define TRAMP_VIRT_BEGIN(name)					\
+	FIXED_SECTION_ENTRY_BEGIN(virt_trampolines, name)
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 #define TRAMP_KVM_BEGIN(name)						\
@@ -33,9 +223,13 @@ name:
 #define TRAMP_KVM_BEGIN(name)
 #endif
 
-#define EXC_REAL_NONE(start, end)
+#define EXC_REAL_NONE(start, end)				\
+	FIXED_SECTION_ENTRY_BEGIN_LOCATION(real_vectors, exc_real_##start##_##unused, start); \
+	FIXED_SECTION_ENTRY_END_LOCATION(real_vectors, exc_real_##start##_##unused, end)
 
-#define EXC_VIRT_NONE(start, end)
+#define EXC_VIRT_NONE(start, end)				\
+	FIXED_SECTION_ENTRY_BEGIN_LOCATION(virt_vectors, exc_virt_##start##_##unused, start); \
+	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_virt_##start##_##unused, end);
 
 
 #define EXC_REAL(name, start, end)				\
@@ -77,6 +271,10 @@ name:
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
 	STD_EXCEPTION_PSERIES_OOL(vec, name##_common);			\
 
+#define EXC_REAL_OOL(name, start, end)			\
+	__EXC_REAL_OOL(name, start, end);			\
+	__TRAMP_REAL_REAL_OOL(name, start);
+
 #define __EXC_REAL_OOL_MASKABLE(name, start, end)		\
 	__EXC_REAL_OOL(name, start, end);
 
@@ -84,6 +282,10 @@ name:
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
 	MASKABLE_EXCEPTION_PSERIES_OOL(vec, name##_common);		\
 
+#define EXC_REAL_OOL_MASKABLE(name, start, end)		\
+	__EXC_REAL_OOL_MASKABLE(name, start, end);		\
+	__TRAMP_REAL_REAL_OOL_MASKABLE(name, start);
+
 #define __EXC_REAL_OOL_HV_DIRECT(name, start, end, handler)	\
 	EXC_REAL_BEGIN(name, start, end);			\
 	__OOL_EXCEPTION(start, label, handler);				\
@@ -96,6 +298,10 @@ name:
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
 	STD_EXCEPTION_HV_OOL(vec, name##_common);			\
 
+#define EXC_REAL_OOL_HV(name, start, end)			\
+	__EXC_REAL_OOL_HV(name, start, end);			\
+	__TRAMP_REAL_REAL_OOL_HV(name, start);
+
 #define __EXC_REAL_OOL_MASKABLE_HV(name, start, end)		\
 	__EXC_REAL_OOL(name, start, end);
 
@@ -103,36 +309,56 @@ name:
 	TRAMP_REAL_BEGIN(tramp_real_##name);				\
 	MASKABLE_EXCEPTION_HV_OOL(vec, name##_common);			\
 
+#define EXC_REAL_OOL_MASKABLE_HV(name, start, end)		\
+	__EXC_REAL_OOL_MASKABLE_HV(name, start, end);	\
+	__TRAMP_REAL_REAL_OOL_MASKABLE_HV(name, start);
+
 #define __EXC_VIRT_OOL(name, start, end)			\
 	EXC_VIRT_BEGIN(name, start, end);			\
 	__OOL_EXCEPTION(start, label, tramp_virt_##name);		\
 	EXC_VIRT_END(name, start, end);
 
 #define __TRAMP_REAL_VIRT_OOL(name, realvec)				\
-	TRAMP_REAL_BEGIN(tramp_virt_##name);				\
+	TRAMP_VIRT_BEGIN(tramp_virt_##name);			\
 	STD_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
 
+#define EXC_VIRT_OOL(name, start, end, realvec)		\
+	__EXC_VIRT_OOL(name, start, end);			\
+	__TRAMP_REAL_VIRT_OOL(name, realvec);
+
 #define __EXC_VIRT_OOL_MASKABLE(name, start, end)		\
 	__EXC_VIRT_OOL(name, start, end);
 
 #define __TRAMP_REAL_VIRT_OOL_MASKABLE(name, realvec)		\
-	TRAMP_REAL_BEGIN(tramp_virt_##name);				\
+	TRAMP_VIRT_BEGIN(tramp_virt_##name);			\
 	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
 
+#define EXC_VIRT_OOL_MASKABLE(name, start, end, realvec)	\
+	__EXC_VIRT_OOL_MASKABLE(name, start, end);		\
+	__TRAMP_REAL_VIRT_OOL_MASKABLE(name, realvec);
+
 #define __EXC_VIRT_OOL_HV(name, start, end)			\
 	__EXC_VIRT_OOL(name, start, end);
 
 #define __TRAMP_REAL_VIRT_OOL_HV(name, realvec)			\
-	TRAMP_REAL_BEGIN(tramp_virt_##name);				\
+	TRAMP_VIRT_BEGIN(tramp_virt_##name);			\
 	STD_RELON_EXCEPTION_HV_OOL(realvec, name##_common);		\
 
+#define EXC_VIRT_OOL_HV(name, start, end, realvec)		\
+	__EXC_VIRT_OOL_HV(name, start, end);			\
+	__TRAMP_REAL_VIRT_OOL_HV(name, realvec);
+
 #define __EXC_VIRT_OOL_MASKABLE_HV(name, start, end)		\
 	__EXC_VIRT_OOL(name, start, end);
 
 #define __TRAMP_REAL_VIRT_OOL_MASKABLE_HV(name, realvec)		\
-	TRAMP_REAL_BEGIN(tramp_virt_##name);				\
+	TRAMP_VIRT_BEGIN(tramp_virt_##name);			\
 	MASKABLE_RELON_EXCEPTION_HV_OOL(realvec, name##_common);	\
 
+#define EXC_VIRT_OOL_MASKABLE_HV(name, start, end, realvec)	\
+	__EXC_VIRT_OOL_MASKABLE_HV(name, start, end);	\
+	__TRAMP_REAL_VIRT_OOL_MASKABLE_HV(name, realvec);
+
 #define TRAMP_KVM(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_##n);					\
 	KVM_HANDLER(area, EXC_STD, n);					\
@@ -141,6 +367,9 @@ name:
 	TRAMP_KVM_BEGIN(do_kvm_##n);					\
 	KVM_HANDLER_SKIP(area, EXC_STD, n);				\
 
+/*
+ * HV variant exceptions get the 0x2 bit added to their trap number.
+ */
 #define TRAMP_KVM_HV(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_H##n);					\
 	KVM_HANDLER(area, EXC_HV, n + 0x2);				\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d398e8716ef8..6ea330a3c51a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -19,16 +19,68 @@
 #include <asm/head-64.h>
 
 /*
+ * There are a few constraints to be concerned with.
+ * - Real mode exceptions code/data must be located at their physical location.
+ * - Virtual mode exceptions must be mapped at their 0xc000... location.
+ * - Fixed location code must not call directly beyond the __end_interrupts
+ *   area when built with CONFIG_RELOCATABLE. LOAD_HANDLER / bctr sequence
+ *   must be used.
+ * - LOAD_HANDLER targets must be within first 64K of physical 0 /
+ *   virtual 0xc00...
+ * - Conditional branch targets must be within +/-32K of caller.
+ *
+ * "Virtual exceptions" run with relocation on (MSR_IR=1, MSR_DR=1), and
+ * therefore don't have to run in physically located code or rfid to
+ * virtual mode kernel code. However on relocatable kernels they do have
+ * to branch to KERNELBASE offset because the rest of the kernel (outside
+ * the exception vectors) may be located elsewhere.
+ *
+ * Virtual exceptions correspond with physical, except their entry points
+ * are offset by 0xc000000000000000 and also tend to get an added 0x4000
+ * offset applied. Virtual exceptions are enabled with the Alternate
+ * Interrupt Location (AIL) bit set in the LPCR. However this does not
+ * guarantee they will be delivered virtually. Some conditions (see the ISA)
+ * cause exceptions to be delivered in real mode.
+ *
+ * It's impossible to receive interrupts below 0x300 via AIL.
+ *
+ * KVM: None of the virtual exceptions are from the guest. Anything that
+ * escalated to HV=1 from HV=0 is delivered via real mode handlers.
+ *
+ *
  * We layout physical memory as follows:
  * 0x0000 - 0x00ff : Secondary processor spin code
- * 0x0100 - 0x17ff : pSeries Interrupt prologs
- * 0x1800 - 0x4000 : interrupt support common interrupt prologs
- * 0x4000 - 0x5fff : pSeries interrupts with IR=1,DR=1
- * 0x6000 - 0x6fff : more interrupt support including for IR=1,DR=1
+ * 0x0100 - 0x18ff : Real mode pSeries interrupt vectors
+ * 0x1900 - 0x3fff : Real mode trampolines
+ * 0x4000 - 0x58ff : Relon (IR=1,DR=1) mode pSeries interrupt vectors
+ * 0x5900 - 0x6fff : Relon mode trampolines
  * 0x7000 - 0x7fff : FWNMI data area
- * 0x8000 - 0x8fff : Initial (CPU0) segment table
- * 0x9000 -        : Early init and support code
+ * 0x8000 -   .... : Common interrupt handlers, remaining early
+ *                   setup code, rest of kernel.
+ */
+OPEN_FIXED_SECTION(real_vectors,        0x0100, 0x1900)
+OPEN_FIXED_SECTION(real_trampolines,    0x1900, 0x4000)
+OPEN_FIXED_SECTION(virt_vectors,        0x4000, 0x5900)
+OPEN_FIXED_SECTION(virt_trampolines,    0x5900, 0x7000)
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+/*
+ * Data area reserved for FWNMI option.
+ * This address (0x7000) is fixed by the RPA.
+ * pseries and powernv need to keep the whole page from
+ * 0x7000 to 0x8000 free for use by the firmware
  */
+ZERO_FIXED_SECTION(fwnmi_page,          0x7000, 0x8000)
+OPEN_TEXT_SECTION(0x8000)
+#else
+OPEN_TEXT_SECTION(0x7000)
+#endif
+
+USE_FIXED_SECTION(real_vectors)
+
+#define LOAD_SYSCALL_HANDLER(reg)				\
+	ld	reg,PACAKBASE(r13);				\
+	ori	reg,reg,(ABS_ADDR(system_call_common))@l;
+
 	/* Syscall routine is used twice, in reloc-off and reloc-on paths */
 #define SYSCALL_PSERIES_1 					\
 BEGIN_FTR_SECTION						\
@@ -42,7 +94,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 
 #define SYSCALL_PSERIES_2_RFID 					\
 	mfspr	r12,SPRN_SRR1 ;					\
-	LOAD_HANDLER(r10, system_call_common) ; 		\
+	LOAD_SYSCALL_HANDLER(r10) ; 				\
 	mtspr	SPRN_SRR0,r10 ; 				\
 	ld	r10,PACAKMSR(r13) ;				\
 	mtspr	SPRN_SRR1,r10 ; 				\
@@ -63,7 +115,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
 	 * is volatile across system calls.
 	 */
 #define SYSCALL_PSERIES_2_DIRECT				\
-	LOAD_HANDLER(r12, system_call_common) ;			\
+	LOAD_SYSCALL_HANDLER(r12) ;				\
 	mtctr	r12 ;						\
 	mfspr	r12,SPRN_SRR1 ;					\
 	li	r10,MSR_RI ;					\
@@ -86,7 +138,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
  * Therefore any relative branches in this section must only
  * branch to labels in this section.
  */
-	. = 0x100
 	.globl __start_interrupts
 __start_interrupts:
 
@@ -200,9 +251,6 @@ EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
 #endif
 EXC_REAL_END(instruction_access_slb, 0x480, 0x500)
 
-	/* We open code these as we can't have a ". = x" (even with
-	 * x = "." within a feature section
-	 */
 EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x600)
 	.globl hardware_interrupt_hv;
 hardware_interrupt_hv:
@@ -306,7 +354,6 @@ __EXC_REAL_OOL_HV(h_facility_unavailable, 0xf80, 0xfa0)
 
 EXC_REAL_NONE(0xfa0, 0x1200)
 
-
 #ifdef CONFIG_CBE_RAS
 EXC_REAL_HV(cbe_system_error, 0x1200, 0x1300)
 
@@ -359,7 +406,6 @@ TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
 
 #else /* CONFIG_CBE_RAS */
 EXC_REAL_NONE(0x1800, 0x1900)
-	. = 0x1800
 #endif
 
 
@@ -606,7 +652,13 @@ masked_##_H##interrupt:					\
 	GET_SCRATCH0(r13);				\
 	##_H##rfid;					\
 	b	.
-	
+
+/*
+ * Real mode exceptions actually use this too, but alternate
+ * instruction code patches (which end up in the common .text area)
+ * cannot reach these if they are put there.
+ */
+USE_FIXED_SECTION(virt_trampolines)
 	MASKED_INTERRUPT()
 	MASKED_INTERRUPT(H)
 
@@ -620,6 +672,7 @@ masked_##_H##interrupt:					\
  * in the generated frame has EE set to 1 or the exception
  * handler will not properly re-enable them.
  */
+USE_TEXT_SECTION()
 _GLOBAL(__replay_interrupt)
 	/* We are going to jump to the exception common code which
 	 * will retrieve various register values from the PACA which
@@ -862,7 +915,7 @@ EXC_VIRT(altivec_assist, 0x5700, 0x5800, 0x1700)
 
 EXC_VIRT_NONE(0x5800, 0x5900)
 
-TRAMP_REAL_BEGIN(ppc64_runlatch_on_trampoline)
+EXC_COMMON_BEGIN(ppc64_runlatch_on_trampoline)
 	b	__ppc64_runlatch_on
 
 /*
@@ -1070,6 +1123,7 @@ __TRAMP_REAL_VIRT_OOL(vsx_unavailable, 0xf40)
 __TRAMP_REAL_VIRT_OOL(facility_unavailable, 0xf60)
 __TRAMP_REAL_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
 
+USE_FIXED_SECTION(virt_trampolines)
 	/*
 	 * The __end_interrupts marker must be past the out-of-line (OOL)
 	 * handlers, so that they are copied to real address 0x100 when running
@@ -1080,21 +1134,7 @@ __TRAMP_REAL_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
 	.align	7
 	.globl	__end_interrupts
 __end_interrupts:
-
-#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
-/*
- * Data area reserved for FWNMI option.
- * This address (0x7000) is fixed by the RPA.
- */
-	.= 0x7000
-	.globl fwnmi_data_area
-fwnmi_data_area:
-
-	/* pseries and powernv need to keep the whole page from
-	 * 0x7000 to 0x8000 free for use by the firmware
-	 */
-	. = 0x8000
-#endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
+DEFINE_FIXED_SYMBOL(__end_interrupts)
 
 EXC_COMMON(facility_unavailable_common, 0xf60, facility_unavailable_exception)
 EXC_COMMON(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
@@ -1106,7 +1146,7 @@ EXC_COMMON(cbe_thermal_common, 0x1800, cbe_thermal_exception)
 #endif /* CONFIG_CBE_RAS */
 
 
-EXC_COMMON_BEGIN(hmi_exception_early)
+TRAMP_REAL_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
 	mr	r10,r1			/* Save r1			*/
 	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack		*/
@@ -1430,6 +1470,13 @@ TRAMP_REAL_BEGIN(power4_fixup_nap)
 	blr
 #endif
 
+CLOSE_FIXED_SECTION(real_vectors);
+CLOSE_FIXED_SECTION(real_trampolines);
+CLOSE_FIXED_SECTION(virt_vectors);
+CLOSE_FIXED_SECTION(virt_trampolines);
+
+USE_TEXT_SECTION()
+
 /*
  * Hash table stuff
  */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 6e21812ee672..79da0641bae2 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -28,6 +28,7 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/ppc_asm.h>
+#include <asm/head-64.h>
 #include <asm/asm-offsets.h>
 #include <asm/bug.h>
 #include <asm/cputable.h>
@@ -65,9 +66,14 @@
  *   2. The kernel is entered at __start
  */
 
-	.text
-	.globl  _stext
-_stext:
+OPEN_FIXED_SECTION(first_256B, 0x0, 0x100)
+USE_FIXED_SECTION(first_256B)
+	/*
+	 * Offsets are relative from the start of fixed section, and
+	 * first_256B starts at 0. Offsets are a bit easier to use here
+	 * than the fixed section entry macros.
+	 */
+	. = 0x0
 _GLOBAL(__start)
 	/* NOP this out unconditionally */
 BEGIN_FTR_SECTION
@@ -104,6 +110,7 @@ __secondary_hold_acknowledge:
 	. = 0x5c
 	.globl	__run_at_load
 __run_at_load:
+DEFINE_FIXED_SYMBOL(__run_at_load)
 	.long	0x72756e30	/* "run0" -- relocate to 0 by default */
 #endif
 
@@ -133,7 +140,7 @@ __secondary_hold:
 	/* Tell the master cpu we're here */
 	/* Relocation is off & we are located at an address less */
 	/* than 0x100, so only need to grab low order offset.    */
-	std	r24,__secondary_hold_acknowledge-_stext(0)
+	std	r24,(ABS_ADDR(__secondary_hold_acknowledge))(0)
 	sync
 
 	li	r26,0
@@ -141,7 +148,7 @@ __secondary_hold:
 	tovirt(r26,r26)
 #endif
 	/* All secondary cpus wait here until told to start. */
-100:	ld	r12,__secondary_hold_spinloop-_stext(r26)
+100:	ld	r12,(ABS_ADDR(__secondary_hold_spinloop))(r26)
 	cmpdi	0,r12,0
 	beq	100b
 
@@ -166,12 +173,13 @@ __secondary_hold:
 #else
 	BUG_OPCODE
 #endif
+CLOSE_FIXED_SECTION(first_256B)
 
 /* This value is used to mark exception frames on the stack. */
 	.section ".toc","aw"
 exception_marker:
 	.tc	ID_72656773_68657265[TC],0x7265677368657265
-	.text
+	.previous
 
 /*
  * On server, we include the exception vectors code here as it
@@ -180,8 +188,12 @@ exception_marker:
  */
 #ifdef CONFIG_PPC_BOOK3S
 #include "exceptions-64s.S"
+#else
+OPEN_TEXT_SECTION(0x100)
 #endif
 
+USE_TEXT_SECTION()
+
 #ifdef CONFIG_PPC_BOOK3E
 /*
  * The booting_thread_hwid holds the thread id we want to boot in cpu
@@ -558,7 +570,7 @@ __after_prom_start:
 #if defined(CONFIG_PPC_BOOK3E)
 	tovirt(r26,r26)		/* on booke, we already run at PAGE_OFFSET */
 #endif
-	lwz	r7,__run_at_load-_stext(r26)
+	lwz	r7,(FIXED_SYMBOL_ABS_ADDR(__run_at_load))(r26)
 #if defined(CONFIG_PPC_BOOK3E)
 	tophys(r26,r26)
 #endif
@@ -601,7 +613,7 @@ __after_prom_start:
 #if defined(CONFIG_PPC_BOOK3E)
 	tovirt(r26,r26)		/* on booke, we already run at PAGE_OFFSET */
 #endif
-	lwz	r7,__run_at_load-_stext(r26)
+	lwz	r7,(FIXED_SYMBOL_ABS_ADDR(__run_at_load))(r26)
 	cmplwi	cr0,r7,1
 	bne	3f
 
@@ -611,19 +623,21 @@ __after_prom_start:
 	sub	r5,r5,r11
 #else
 	/* just copy interrupts */
-	LOAD_REG_IMMEDIATE(r5, __end_interrupts - _stext)
+	LOAD_REG_IMMEDIATE(r5, FIXED_SYMBOL_ABS_ADDR(__end_interrupts))
 #endif
 	b	5f
 3:
 #endif
-	lis	r5,(copy_to_here - _stext)@ha
-	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy */
+	/* # bytes of memory to copy */
+	lis	r5,(ABS_ADDR(copy_to_here))@ha
+	addi	r5,r5,(ABS_ADDR(copy_to_here))@l
 
 	bl	copy_and_flush		/* copy the first n bytes	 */
 					/* this includes the code being	 */
 					/* executed here.		 */
-	addis	r8,r3,(4f - _stext)@ha	/* Jump to the copy of this code */
-	addi	r12,r8,(4f - _stext)@l	/* that we just made */
+	/* Jump to the copy of this code that we just made */
+	addis	r8,r3,(ABS_ADDR(4f))@ha
+	addi	r12,r8,(ABS_ADDR(4f))@l
 	mtctr	r12
 	bctr
 
@@ -635,8 +649,8 @@ p_end: .llong _end - copy_to_here
 	 * Now copy the rest of the kernel up to _end, add
 	 * _end - copy_to_here to the copy limit and run again.
 	 */
-	addis   r8,r26,(p_end - _stext)@ha
-	ld      r8,(p_end - _stext)@l(r8)
+	addis   r8,r26,(ABS_ADDR(p_end))@ha
+	ld      r8,(ABS_ADDR(p_end))@l(r8)
 	add	r5,r5,r8
 5:	bl	copy_and_flush		/* copy the rest */
 
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index b59d75e194a5..2d1cfafd1404 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -44,11 +44,58 @@ SECTIONS
  * Text, read only data and other permanent read-only sections
  */
 
-	/* Text and gots */
+	_text = .;
+	_stext = .;
+
+	/*
+	 * Head text.
+	 * This needs to be in its own output section to avoid ld placing
+	 * branch trampoline stubs randomly throughout the fixed sections,
+	 * which it will do (even if the branch comes from another section)
+	 * in order to optimize stub generation.
+	 */
+	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
+#ifdef CONFIG_PPC64
+		KEEP(*(.head.text.first_256B));
+#ifdef CONFIG_PPC_BOOK3E
+# define END_FIXED	0x100
+#else
+		KEEP(*(.head.text.real_vectors));
+		*(.head.text.real_trampolines);
+		KEEP(*(.head.text.virt_vectors));
+		*(.head.text.virt_trampolines);
+# if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+		KEEP(*(.head.data.fwnmi_page));
+#  define END_FIXED	0x8000
+# else
+#  define END_FIXED	0x7000
+# endif
+#endif
+		ASSERT((. == END_FIXED), "vmlinux.lds.S: fixed section overflow error");
+#else /* !CONFIG_PPC64 */
+		HEAD_TEXT
+#endif
+	} :kernel
+
+	/*
+	 * If the build dies here, it's likely code in head_64.S is referencing
+	 * labels it can't reach, and the linker inserting stubs without the
+	 * assembler's knowledge. To debug, remove the above assert and
+	 * rebuild. Look for branch stubs in the fixed section region.
+	 *
+	 * Linker stub generation could be allowed in "trampoline"
+	 * sections if absolutely necessary, but this would require
+	 * some rework of the fixed sections. Before resorting to this,
+	 * consider references that have sufficient addressing range,
+	 * (e.g., hand coded trampolines) so the linker does not have
+	 * to add stubs.
+	 *
+	 * Linker stubs at the top of the main text section are currently not
+	 * detected, and will result in a crash at boot due to offsets being
+	 * wrong.
+	 */
 	.text : AT(ADDR(.text) - LOAD_OFFSET) {
 		ALIGN_FUNCTION();
-		HEAD_TEXT
-		_text = .;
 		/* careful! __ftr_alt_* sections need to be close to .text */
 		*(.text .fixup __ftr_alt_* .ref.text)
 		SCHED_TEXT
-- 
2.7.4

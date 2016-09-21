Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfBV204wCzDshc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 17:44:42 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id my20so1944671pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:44:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/41] powerpc/64: use gas sections for arranging exception
 vectors
Date: Wed, 21 Sep 2016 17:43:29 +1000
Message-Id: <20160921074407.4885-4-npiggin@gmail.com>
In-Reply-To: <20160921074407.4885-1-npiggin@gmail.com>
References: <20160921074407.4885-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use assembler sections of fixed size and location to arrange pseries
exception vector code (64e also using it in head_64.S for 0x0..0x100).

This allows better flexibility in arranging exception code and hiding
unimportant details behind macros.

Gas sections can be a bit painful to use this way, mainly because the
assembler does not know where they will be finally linked. Taking
absolute addresses requires a bit of trickery for example, but it can
be hidden behind macros for the most part.

Generated code is mostly the same except locations, offsets, alignments.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h |   4 +-
 arch/powerpc/include/asm/head-64.h       | 273 ++++++++++++++++++++++++++++---
 arch/powerpc/kernel/exceptions-64s.S     | 103 ++++++++----
 arch/powerpc/kernel/head_64.S            |  58 ++++---
 arch/powerpc/kernel/vmlinux.lds.S        |  45 ++++-
 5 files changed, 404 insertions(+), 79 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 6c0080f..c7a1c90 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -89,9 +89,9 @@
  * low halfword of the address, but for Kdump we need the whole low
  * word.
  */
-#define LOAD_HANDLER(reg, label)					\
 	/* Handlers must be within 64K of kbase, which must be 64k aligned */ \
-	ori	reg,reg,(label)-_stext;	/* virt addr of handler ... */
+#define LOAD_HANDLER(reg, label)					\
+	ori	reg,reg,ABS_ADDR(label);
 
 /* Exception register prefixes */
 #define EXC_HV	H
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index a76049d..1949fe9 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -3,32 +3,225 @@
 
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
+ * FIXED_SECTION_ENTRY_END(section_name, label1)
+ *
+ * USE_FIXED_SECTION(section_name)
+ * label3:
+ *     li  r10,128
+ *     mv  r11,r10
+ * UNUSE_FIXED_SECTION(section_name)
+
+ * FIXED_SECTION_ENTRY_BEGIN_LOCATION(section_name, label2, start_address)
+ * FIXED_SECTION_ENTRY_END_LOCATION(section_name, label2, end_address)
+ * CLOSE_FIXED_SECTION(section_name)
+ *
+ * ZERO_FIXED_SECTION can be used to emit zeroed data.
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
+#define UNUSE_FIXED_SECTION(sname)				\
+	.previous;
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
+#define FIXED_SECTION_ENTRY_END(sname, name)			\
+	UNUSE_FIXED_SECTION(sname);
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
+	UNUSE_FIXED_SECTION(sname);
+
+
+/*
+ * These macros are used to change symbols in other fixed sections to be
+ * absolute or related to our current fixed section.
+ *
+ * GAS makes things as painful as it possibly can.
+ */
+/* ABS_ADDR: absolute address of a label within same section */
+#define ABS_ADDR(label) (label - fs_label + fs_start)
+
+/* FIXED_SECTION_ABS_ADDR: absolute address of a label in another setcion */
+#define FIXED_SECTION_ABS_ADDR(sname, target)				\
+	(target - start_##sname + sname##_start)
+
+/* FIXED_SECTION_REL_ADDR: relative address of a label in another setcion */
+#define FIXED_SECTION_REL_ADDR(sname, target)				\
+	(FIXED_SECTION_ABS_ADDR(sname, target) + fs_label - fs_start)
+
+
+/*
+ * Following are the BOOK3S exception handler helper macros.
+ * Handlers come in a number of types, and each type has a number of varieties.
+ *
+ * VECTOR_HANDLER_REAL_* - real, unrelocated exception vectors
+ * VECTOR_HANDLER_VIRT_* - virt (AIL), unrelocated exception vectors
+ * TRAMP_HANDLER_*       - real, unrelocated helpers (virt can call these)
+ * VTRAMP_HANDLER_*      - virt, unreloc helpers (in practice, real can use)
+ * TRAMP_KVM             - KVM handlers that get put into real, unrelocated
+ * COMMON_HANDLER_*      - virt, relocated common handlers
+ *
+ * The VECTOR_HANDLERs are given a name, and branch to name_common, or the
+ * appropriate KVM or masking function. Vector handler verieties are as
+ * follows:
+ *
+ * VECTOR_HANDLER_{REAL|VIRT}_BEGIN/END - used to open-code the exception
+ *
+ * VECTOR_HANDLER_{REAL|VIRT}  - standard exception
+ *
+ * VECTOR_HANDLER_{REAL|VIRT}_suffix
+ *     where _suffix is:
+ *   - _MASKABLE               - maskable exception
+ *   - _OOL                    - out of line with trampoline to common handler
+ *   - _HV                     - HV exception
+ *
+ * There can be combinations, e.g., VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV
+ *
+ * The one unusual case is __VECTOR_HANDLER_REAL_OOL_HV_DIRECT, which is
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
+ * COMMON_HANDLER_BEGIN/END - used to open-code the handler
+ * COMMON_HANDLER
+ * COMMON_HANDLER_ASYNC
+ * COMMON_HANDLER_HV
+ *
+ * TRAMP_HANDLER and VTRAMP_HANDLER can be used with BEGIN/END. KVM
+ * and OOL handlers are implemented as types of TRAMP and VTRAMP handlers.
+ */
+
 #define VECTOR_HANDLER_REAL_BEGIN(name, start, end)			\
-	. = start ;							\
-	.global exc_##start##_##name ;					\
-exc_##start##_##name:
+	FIXED_SECTION_ENTRY_BEGIN_LOCATION(real_vectors, exc_##start##_##name, start)
 
-#define VECTOR_HANDLER_REAL_END(name, start, end)
+#define VECTOR_HANDLER_REAL_END(name, start, end)			\
+	FIXED_SECTION_ENTRY_END_LOCATION(real_vectors, exc_##start##_##name, end)
 
 #define VECTOR_HANDLER_VIRT_BEGIN(name, start, end)			\
-	. = start ;							\
-	.global exc_##start##_##name ;					\
-exc_##start##_##name:
+	FIXED_SECTION_ENTRY_BEGIN_LOCATION(virt_vectors, exc_##start##_##name, start)
 
-#define VECTOR_HANDLER_VIRT_END(name, start, end)
+#define VECTOR_HANDLER_VIRT_END(name, start, end)			\
+	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_##start##_##name, end)
 
 #define COMMON_HANDLER_BEGIN(name)					\
+	USE_TEXT_SECTION();						\
 	.align	7;							\
 	.global name;							\
 name:
 
-#define COMMON_HANDLER_END(name)
+#define COMMON_HANDLER_END(name)					\
+	.previous
 
 #define TRAMP_HANDLER_BEGIN(name)					\
-	.global name ;							\
-name:
+	FIXED_SECTION_ENTRY_BEGIN(real_trampolines, name)
+
+#define TRAMP_HANDLER_END(name)						\
+	FIXED_SECTION_ENTRY_END(real_trampolines, name)
+
+#define VTRAMP_HANDLER_BEGIN(name)					\
+	FIXED_SECTION_ENTRY_BEGIN(virt_trampolines, name)
 
-#define TRAMP_HANDLER_END(name)
+#define VTRAMP_HANDLER_END(name)					\
+	FIXED_SECTION_ENTRY_END(virt_trampolines, name)
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 #define TRAMP_KVM_BEGIN(name)						\
@@ -41,9 +234,13 @@ name:
 #define TRAMP_KVM_END(name)
 #endif
 
-#define VECTOR_HANDLER_REAL_NONE(start, end)
+#define VECTOR_HANDLER_REAL_NONE(start, end)				\
+	FIXED_SECTION_ENTRY_BEGIN_LOCATION(real_vectors, exc_##start##_##unused, start); \
+	FIXED_SECTION_ENTRY_END_LOCATION(real_vectors, exc_##start##_##unused, end)
 
-#define VECTOR_HANDLER_VIRT_NONE(start, end)
+#define VECTOR_HANDLER_VIRT_NONE(start, end)				\
+	FIXED_SECTION_ENTRY_BEGIN_LOCATION(virt_vectors, exc_##start##_##unused, start); \
+	FIXED_SECTION_ENTRY_END_LOCATION(virt_vectors, exc_##start##_##unused, end);
 
 
 #define VECTOR_HANDLER_REAL(name, start, end)				\
@@ -86,6 +283,10 @@ name:
 	STD_EXCEPTION_PSERIES_OOL(vec, name##_common);			\
 	TRAMP_HANDLER_END(tramp_real_##name);
 
+#define VECTOR_HANDLER_REAL_OOL(name, start, end)			\
+	__VECTOR_HANDLER_REAL_OOL(name, start, end);			\
+	__TRAMP_HANDLER_REAL_OOL(name, start);
+
 #define __VECTOR_HANDLER_REAL_OOL_MASKABLE(name, start, end)		\
 	__VECTOR_HANDLER_REAL_OOL(name, start, end);
 
@@ -94,6 +295,10 @@ name:
 	MASKABLE_EXCEPTION_PSERIES_OOL(vec, name##_common);		\
 	TRAMP_HANDLER_END(tramp_real_##name);
 
+#define VECTOR_HANDLER_REAL_OOL_MASKABLE(name, start, end)		\
+	__VECTOR_HANDLER_REAL_OOL_MASKABLE(name, start, end);		\
+	__TRAMP_HANDLER_REAL_OOL_MASKABLE(name, start);
+
 #define __VECTOR_HANDLER_REAL_OOL_HV_DIRECT(name, start, end, handler)	\
 	VECTOR_HANDLER_REAL_BEGIN(name, start, end);			\
 	__OOL_EXCEPTION(start, label, handler);				\
@@ -107,6 +312,10 @@ name:
 	STD_EXCEPTION_HV_OOL(vec + 0x2, name##_common);			\
 	TRAMP_HANDLER_END(tramp_real_##name);
 
+#define VECTOR_HANDLER_REAL_OOL_HV(name, start, end)			\
+	__VECTOR_HANDLER_REAL_OOL_HV(name, start, end);			\
+	__TRAMP_HANDLER_REAL_OOL_HV(name, start);
+
 #define __VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(name, start, end)		\
 	__VECTOR_HANDLER_REAL_OOL(name, start, end);
 
@@ -115,39 +324,59 @@ name:
 	MASKABLE_EXCEPTION_HV_OOL(vec, name##_common);			\
 	TRAMP_HANDLER_END(tramp_real_##name);
 
+#define VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(name, start, end)		\
+	__VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(name, start, end);	\
+	__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(name, start);
+
 #define __VECTOR_HANDLER_VIRT_OOL(name, start, end)			\
 	VECTOR_HANDLER_VIRT_BEGIN(name, start, end);			\
 	__OOL_EXCEPTION(start, label, tramp_virt_##name);		\
 	VECTOR_HANDLER_VIRT_END(name, start, end);
 
 #define __TRAMP_HANDLER_VIRT_OOL(name, realvec)				\
-	TRAMP_HANDLER_BEGIN(tramp_virt_##name);				\
+	VTRAMP_HANDLER_BEGIN(tramp_virt_##name);			\
 	STD_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
-	TRAMP_HANDLER_END(tramp_virt_##name);
+	VTRAMP_HANDLER_END(tramp_virt_##name);
+
+#define VECTOR_HANDLER_VIRT_OOL(name, start, end, realvec)		\
+	__VECTOR_HANDLER_VIRT_OOL(name, start, end);			\
+	__TRAMP_HANDLER_VIRT_OOL(name, realvec);
 
 #define __VECTOR_HANDLER_VIRT_OOL_MASKABLE(name, start, end)		\
 	__VECTOR_HANDLER_VIRT_OOL(name, start, end);
 
 #define __TRAMP_HANDLER_VIRT_OOL_MASKABLE(name, realvec)		\
-	TRAMP_HANDLER_BEGIN(tramp_virt_##name);				\
+	VTRAMP_HANDLER_BEGIN(tramp_virt_##name);			\
 	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
-	TRAMP_HANDLER_END(tramp_virt_##name);
+	VTRAMP_HANDLER_END(tramp_virt_##name);
+
+#define VECTOR_HANDLER_VIRT_OOL_MASKABLE(name, start, end, realvec)	\
+	__VECTOR_HANDLER_VIRT_OOL_MASKABLE(name, start, end);		\
+	__TRAMP_HANDLER_VIRT_OOL_MASKABLE(name, realvec);
 
 #define __VECTOR_HANDLER_VIRT_OOL_HV(name, start, end)			\
 	__VECTOR_HANDLER_VIRT_OOL(name, start, end);
 
 #define __TRAMP_HANDLER_VIRT_OOL_HV(name, realvec)			\
-	TRAMP_HANDLER_BEGIN(tramp_virt_##name);				\
+	VTRAMP_HANDLER_BEGIN(tramp_virt_##name);			\
 	STD_RELON_EXCEPTION_HV_OOL(realvec, name##_common);		\
-	TRAMP_HANDLER_END(tramp_virt_##name);
+	VTRAMP_HANDLER_END(tramp_virt_##name)
+
+#define VECTOR_HANDLER_VIRT_OOL_HV(name, start, end, realvec)		\
+	__VECTOR_HANDLER_VIRT_OOL_HV(name, start, end);			\
+	__TRAMP_HANDLER_VIRT_OOL_HV(name, realvec);
 
 #define __VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(name, start, end)		\
 	__VECTOR_HANDLER_VIRT_OOL(name, start, end);
 
 #define __TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(name, realvec)		\
-	TRAMP_HANDLER_BEGIN(tramp_virt_##name);				\
+	VTRAMP_HANDLER_BEGIN(tramp_virt_##name);			\
 	MASKABLE_RELON_EXCEPTION_HV_OOL(realvec, name##_common);	\
-	TRAMP_HANDLER_END(tramp_virt_##name);
+	VTRAMP_HANDLER_END(tramp_virt_##name);
+
+#define VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(name, start, end, realvec)	\
+	__VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(name, start, end);	\
+	__TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(name, realvec);
 
 #define TRAMP_KVM(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_##n);					\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 418758d..11a7b28 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -19,16 +19,65 @@
 #include <asm/head-64.h>
 
 /*
+ * There are a few constraints to be conerned with.
+ * - Real mode exceptions code/data must be located at thier physical location.
+ * - Virtual mode exceptions must be mapped at their  0xc000... location.
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
+ * KVM: None of these traps are from the guest ; anything that escalated
+ * to HV=1 from HV=0 is delivered via real mode handlers.
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
+
 	/* Syscall routine is used twice, in reloc-off and reloc-on paths */
 #define SYSCALL_PSERIES_1 					\
 BEGIN_FTR_SECTION						\
@@ -91,7 +140,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
  * Therefore any relative branches in this section must only
  * branch to labels in this section.
  */
-	. = 0x100
 	.globl __start_interrupts
 __start_interrupts:
 
@@ -205,9 +253,6 @@ VECTOR_HANDLER_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
 #endif
 VECTOR_HANDLER_REAL_END(instruction_access_slb, 0x480, 0x500)
 
-	/* We open code these as we can't have a ". = x" (even with
-	 * x = "." within a feature section
-	 */
 VECTOR_HANDLER_REAL_BEGIN(hardware_interrupt, 0x500, 0x600)
 	.globl hardware_interrupt_hv;
 hardware_interrupt_hv:
@@ -217,7 +262,7 @@ hardware_interrupt_hv:
 do_kvm_H0x500:
 		KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x500)
 	FTR_SECTION_ELSE
-		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
+		_MASKABLE_EXCEPTION_PSERIES(0x500, FIXED_SECTION_REL_ADDR(text, hardware_interrupt_common),
 					    EXC_STD, SOFTEN_TEST_PR)
 do_kvm_0x500:
 		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
@@ -364,7 +409,6 @@ TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
 
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
-	. = 0x1800
 #endif
 
 
@@ -617,9 +661,16 @@ masked_##_H##interrupt:					\
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
+UNUSE_FIXED_SECTION(virt_trampolines)
 
 /*
  * Called from arch_local_irq_enable when an interrupt needs
@@ -805,7 +856,7 @@ hardware_interrupt_relon_hv:
 	BEGIN_FTR_SECTION
 		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_HV, SOFTEN_TEST_HV)
 	FTR_SECTION_ELSE
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_STD, SOFTEN_TEST_PR)
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, FIXED_SECTION_REL_ADDR(text, hardware_interrupt_common), EXC_STD, SOFTEN_TEST_PR)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 VECTOR_HANDLER_VIRT_END(hardware_interrupt, 0x4500, 0x4600)
 
@@ -1094,6 +1145,7 @@ __TRAMP_HANDLER_VIRT_OOL(vsx_unavailable, 0xf40)
 __TRAMP_HANDLER_VIRT_OOL(facility_unavailable, 0xf60)
 __TRAMP_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
 
+USE_FIXED_SECTION(virt_trampolines)
 	/*
 	 * The __end_interrupts marker must be past the out-of-line (OOL)
 	 * handlers, so that they are copied to real address 0x100 when running
@@ -1104,21 +1156,7 @@ __TRAMP_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
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
+UNUSE_FIXED_SECTION(virt_trampolines)
 
 COMMON_HANDLER(facility_unavailable_common, 0xf60, facility_unavailable_exception)
 COMMON_HANDLER(h_facility_unavailable_common, 0xf80, facility_unavailable_exception)
@@ -1438,6 +1476,13 @@ TRAMP_HANDLER_BEGIN(power4_fixup_nap)
 TRAMP_HANDLER_END(power4_fixup_nap)
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
index f765b04..885ecec9 100644
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
@@ -65,10 +66,10 @@
  *   2. The kernel is entered at __start
  */
 
-	.text
-	.globl  _stext
-_stext:
-_GLOBAL(__start)
+OPEN_FIXED_SECTION(first_256B, 0x0, 0x100)
+
+USE_FIXED_SECTION(first_256B)
+FIXED_SECTION_ENTRY_BEGIN_LOCATION(first_256B, __start, 0x0)
 	/* NOP this out unconditionally */
 BEGIN_FTR_SECTION
 	FIXUP_ENDIAN
@@ -77,6 +78,7 @@ END_FTR_SECTION(0, 1)
 
 	/* Catch branch to 0 in real mode */
 	trap
+FIXED_SECTION_ENTRY_END(first_256B, __start)
 
 	/* Secondary processors spin on this value until it becomes non-zero.
 	 * When non-zero, it contains the real address of the function the cpu
@@ -101,13 +103,13 @@ __secondary_hold_acknowledge:
 	 * observing the alignment requirement.
 	 */
 	/* Do not move this variable as kexec-tools knows about it. */
-	. = 0x5c
-	.globl	__run_at_load
-__run_at_load:
+FIXED_SECTION_ENTRY_BEGIN_LOCATION(first_256B, __run_at_load, 0x5c)
 	.long	0x72756e30	/* "run0" -- relocate to 0 by default */
+FIXED_SECTION_ENTRY_END(first_256B, __run_at_load)
+
 #endif
 
-	. = 0x60
+FIXED_SECTION_ENTRY_BEGIN_LOCATION(first_256B, __secondary_hold, 0x60)
 /*
  * The following code is used to hold secondary processors
  * in a spin loop after they have entered the kernel, but
@@ -117,8 +119,6 @@ __run_at_load:
  * Use .globl here not _GLOBAL because we want __secondary_hold
  * to be the actual text address, not a descriptor.
  */
-	.globl	__secondary_hold
-__secondary_hold:
 	FIXUP_ENDIAN
 #ifndef CONFIG_PPC_BOOK3E
 	mfmsr	r24
@@ -133,7 +133,7 @@ __secondary_hold:
 	/* Tell the master cpu we're here */
 	/* Relocation is off & we are located at an address less */
 	/* than 0x100, so only need to grab low order offset.    */
-	std	r24,__secondary_hold_acknowledge-_stext(0)
+	std	r24,ABS_ADDR(__secondary_hold_acknowledge)(0)
 	sync
 
 	li	r26,0
@@ -141,7 +141,7 @@ __secondary_hold:
 	tovirt(r26,r26)
 #endif
 	/* All secondary cpus wait here until told to start. */
-100:	ld	r12,__secondary_hold_spinloop-_stext(r26)
+100:	ld	r12,ABS_ADDR(__secondary_hold_spinloop)(r26)
 	cmpdi	0,r12,0
 	beq	100b
 
@@ -166,12 +166,15 @@ __secondary_hold:
 #else
 	BUG_OPCODE
 #endif
+FIXED_SECTION_ENTRY_END(first_256B, __secondary_hold)
+
+CLOSE_FIXED_SECTION(first_256B)
 
 /* This value is used to mark exception frames on the stack. */
 	.section ".toc","aw"
 exception_marker:
 	.tc	ID_72656773_68657265[TC],0x7265677368657265
-	.text
+	.previous
 
 /*
  * On server, we include the exception vectors code here as it
@@ -180,8 +183,12 @@ exception_marker:
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
@@ -558,7 +565,7 @@ __after_prom_start:
 #if defined(CONFIG_PPC_BOOK3E)
 	tovirt(r26,r26)		/* on booke, we already run at PAGE_OFFSET */
 #endif
-	lwz	r7,__run_at_load-_stext(r26)
+	lwz	r7,ABS_ADDR(__run_at_load)(r26)
 #if defined(CONFIG_PPC_BOOK3E)
 	tophys(r26,r26)
 #endif
@@ -601,7 +608,7 @@ __after_prom_start:
 #if defined(CONFIG_PPC_BOOK3E)
 	tovirt(r26,r26)		/* on booke, we already run at PAGE_OFFSET */
 #endif
-	lwz	r7,__run_at_load-_stext(r26)
+	lwz	r7,ABS_ADDR(__run_at_load)(r26)
 	cmplwi	cr0,r7,1
 	bne	3f
 
@@ -611,28 +618,31 @@ __after_prom_start:
 	sub	r5,r5,r11
 #else
 	/* just copy interrupts */
-	LOAD_REG_IMMEDIATE(r5, __end_interrupts - _stext)
+	LOAD_REG_IMMEDIATE(r5, FIXED_SECTION_ABS_ADDR(virt_trampolines, __end_interrupts))
 #endif
 	b	5f
 3:
 #endif
-	lis	r5,(copy_to_here - _stext)@ha
-	addi	r5,r5,(copy_to_here - _stext)@l /* # bytes of memory to copy */
+	/* # bytes of memory to copy */
+	lis	r5,ABS_ADDR(copy_to_here)@ha
+	addi	r5,r5,ABS_ADDR(copy_to_here)@l
 
 	bl	copy_and_flush		/* copy the first n bytes	 */
 					/* this includes the code being	 */
 					/* executed here.		 */
-	addis	r8,r3,(4f - _stext)@ha	/* Jump to the copy of this code */
-	addi	r12,r8,(4f - _stext)@l	/* that we just made */
+	/* Jump to the copy of this code that we just made*/
+	addis	r8,r3, ABS_ADDR(4f)@ha
+	addi	r12,r8, ABS_ADDR(4f)@l
 	mtctr	r12
 	bctr
 
-.balign 8
-p_end:	.llong	_end - _stext
+p_end: .llong _end - copy_to_here
 
 4:	/* Now copy the rest of the kernel up to _end */
-	addis	r5,r26,(p_end - _stext)@ha
-	ld	r5,(p_end - _stext)@l(r5)	/* get _end */
+	addis   r8,r26,ABS_ADDR(p_end)@ha
+	/* load p_end */
+	ld      r8,ABS_ADDR(p_end)@l(r8)
+	add	r5,r5,r8
 5:	bl	copy_and_flush		/* copy the rest */
 
 9:	b	start_here_multiplatform
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index b5fba68..df59e14 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -44,11 +44,52 @@ SECTIONS
  * Text, read only data and other permanent read-only sections
  */
 
+	_text = .;
+	_stext = .;
+
+#ifdef CONFIG_PPC64
+	/*
+	 * Head text.
+	 * This needs to be in its own output section to avoid ld placing
+	 * branch trampoline stubs randomly throughout the fixed sections,
+	 * which it will do (even if the branch comes from another section)
+	 * in order to optimize stub generation.
+	 */
+	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
+		KEEP(*(.head.text.first_256B));
+#ifndef CONFIG_PPC_BOOK3S
+		. = 0x100;
+#else
+		KEEP(*(.head.text.real_vectors));
+		*(.head.text.real_trampolines);
+		KEEP(*(.head.text.virt_vectors));
+		*(.head.text.virt_trampolines);
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+		KEEP(*(.head.data.fwnmi_page));
+		. = 0x8000;
+#else
+		. = 0x7000;
+#endif
+#endif
+		/*
+		 * The offsets above are specified in order to catch the linker
+		 * adding branch stubs in one of the fixed sections, which
+		 * breaks the fixed section offsets (see head-64.h) and that
+		 * can't be caught by the assembler. If the build died here,
+		 * code in head is referencing labels it can't reach.
+		 *
+		 * Linker stub generation could be allowed in "trampoline"
+		 * sections if necessary, if they were put into their own
+		 * output sections and the fixed section code adjusted to
+		 * avoid complete padding of those sections (their offsets
+		 * would be specified here in the linker script).
+		 */
+	} :kernel
+#endif
+
 	/* Text and gots */
 	.text : AT(ADDR(.text) - LOAD_OFFSET) {
 		ALIGN_FUNCTION();
-		HEAD_TEXT
-		_text = .;
 		/* careful! __ftr_alt_* sections need to be close to .text */
 		*(.text .fixup __ftr_alt_* .ref.text)
 		SCHED_TEXT
-- 
2.9.3

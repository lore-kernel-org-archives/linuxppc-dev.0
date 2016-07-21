Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rw45z2VxyzDqTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2016 16:45:11 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id g202so4911284pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 23:45:11 -0700 (PDT)
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 09/14] powerpc/64: use gas sections for arranging exception
 vectors
Date: Thu, 21 Jul 2016 16:44:08 +1000
Message-Id: <1469083453-9279-10-git-send-email-npiggin@gmail.com>
In-Reply-To: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
References: <1469083453-9279-1-git-send-email-npiggin@gmail.com>
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

Signed-off-by: Nick Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h |   8 +-
 arch/powerpc/include/asm/head-64.h       | 252 +++++++++++++++++++++++++------
 arch/powerpc/include/asm/ppc_asm.h       |  29 ++--
 arch/powerpc/kernel/exceptions-64s.S     |  90 ++++++++---
 arch/powerpc/kernel/head_64.S            |  84 ++++++-----
 arch/powerpc/kernel/vmlinux.lds.S        |  22 ++-
 6 files changed, 367 insertions(+), 118 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 01fd163..06e2247 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -93,11 +93,11 @@
  * reg must contain kbase, and kbase must be 64K aligned.
  */
 #define LOAD_HANDLER_64K(reg, label)					\
-	ori	reg,reg,(label)-_stext ;
+	ori	reg,reg,ABS_ADDR(label);
 
 #define LOAD_HANDLER_4G(reg, label)					\
-	ori	reg,reg,((label)-_stext)@l ;				\
-	addis	reg,reg,((label)-_stext)@h ;
+	ori	reg,reg,ABS_ADDR(label)@l ;				\
+	addis	reg,reg,ABS_ADDR(label)@h
 
 /* Exception register prefixes */
 #define EXC_HV	H
@@ -186,7 +186,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
 	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
-	LOAD_HANDLER_4G(r12,label)					\
+	LOAD_HANDLER_4G(r12,label);					\
 	mtspr	SPRN_##h##SRR0,r12;					\
 	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
 	mtspr	SPRN_##h##SRR1,r10;					\
diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index 98cd36b..5adb48d 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -1,37 +1,167 @@
 #ifndef _ASM_POWERPC_HEAD_64_H
 #define _ASM_POWERPC_HEAD_64_H
-
+/*
+ * Stuff to help the fixed layout head code, and S exception vectors.
+ */
+#include <asm/ppc_asm.h>
 #include <asm/cache.h>
 
+/*
+ * We can't do CPP stringification and concatination directly into the section
+ * name for some reason, so these macros can do it for us.
+ */
+.macro define_ftsec name
+	.section ".head.text.\name\()","ax",@progbits
+.endm
+.macro use_ftsec name
+	.section ".head.text.\name\()"
+.endm
+
+#define OPEN_FIXED_SECTION(sname, start, end)			\
+	sname##_start = (start);				\
+	sname##_end = (end);					\
+	sname##_len = (end) - (start);				\
+	define_ftsec sname;					\
+	. = 0x0;						\
+	.global start_##sname;					\
+start_##sname:
+
+#define OPEN_TEXT_SECTION(start)				\
+	text_start = (start);					\
+	.section ".text","ax",@progbits;			\
+	. = 0x0;						\
+	.global start_text;					\
+start_text:
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
+#define CLOSE_FIXED_SECTION_LAST(sname)				\
+	USE_FIXED_SECTION(sname);				\
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
+#define FIXED_SECTION_ENTRY_S_BEGIN(sname, name, start)		\
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
+end_##name:							\
+	UNUSE_FIXED_SECTION(sname);
+
+#define FIXED_SECTION_ENTRY_E_END(sname, name, end)		\
+	.if (end) > sname##_end;				\
+	.error "Fixed section overflow";			\
+	.abort;							\
+	.endif;							\
+end_##name:							\
+	.if (end_##name - name > end - name##_start);		\
+	.error "Fixed entry overflow";				\
+	.abort;							\
+	.endif;							\
+	/* Pad out the end with traps */			\
+	.rept (((end) - name##_start) - (. - name)) / 4;	\
+	trap;							\
+	.endr;							\
+	. = ((end) - sname##_start);				\
+	UNUSE_FIXED_SECTION(sname);
+
+#define FIXED_SECTION_ENTRY_S(sname, name, start, entry)	\
+	FIXED_SECTION_ENTRY_S_BEGIN(sname, name, start);	\
+	entry;							\
+	FIXED_SECTION_ENTRY_END(sname, name);			\
+
+#define FIXED_SECTION_ENTRY(sname, name, start, end, entry)	\
+	FIXED_SECTION_ENTRY_S_BEGIN(sname, name, start);	\
+	entry;							\
+	FIXED_SECTION_ENTRY_E_END(sname, name, end);
+
+#define FIXED_SECTION_ENTRY_ZERO(sname, start, end)		\
+	FIXED_SECTION_ENTRY_S_BEGIN(sname, sname##_##zero, start); \
+	.zero (end) - (start);					\
+	FIXED_SECTION_ENTRY_E_END(sname, sname##_##zero, end);
+
+#define ABS_ADDR(label) (label - fs_label + fs_start)
+
+/*
+ * These macros are used to change symbols in other fixed sections to be
+ * absolute or related to our current fixed section.
+ *
+ * GAS makes things as painful as it possibly can.
+ */
+#define FIXED_SECTION_ABS_ADDR(sname, target)				\
+	(target - start_##sname + sname##_start)
+
+#define FIXED_SECTION_REL_ADDR(sname, target)				\
+	(FIXED_SECTION_ABS_ADDR(sname, target) + fs_label - fs_start)
+
+#define FTR_SECTION_FIXED_SECTION_RELADDR(label, sname, target)		\
+	FTR_SECTION_EXT_RELADDR(label, FIXED_SECTION_REL_ADDR(sname, target))
+
+
 #define VECTOR_HANDLER_REAL_BEGIN(name, start, end)			\
-	. = start ;							\
-	.align 7;							\
-	.global exc_##start##_##name ;					\
-exc_##start##_##name:
+	FIXED_SECTION_ENTRY_S_BEGIN(real_vectors, exc_##start##_##name, start)
 
-#define VECTOR_HANDLER_REAL_END(name, start, end)
+#define VECTOR_HANDLER_REAL_END(name, start, end)			\
+	FIXED_SECTION_ENTRY_E_END(real_vectors, exc_##start##_##name, end)
 
 #define VECTOR_HANDLER_VIRT_BEGIN(name, start, end)			\
-	. = start ;							\
-	.align 7;	i						\
-	.global exc_##start##_##name ;					\
-exc_##start##_##name:
+	FIXED_SECTION_ENTRY_S_BEGIN(virt_vectors, exc_##start##_##name, start)
 
-#define VECTOR_HANDLER_VIRT_END(name, start, end)
+#define VECTOR_HANDLER_VIRT_END(name, start, end)			\
+	FIXED_SECTION_ENTRY_E_END(virt_vectors, exc_##start##_##name, end)
 
 #define COMMON_HANDLER_BEGIN(name)					\
+	USE_TEXT_SECTION();						\
 	.align 7;							\
 	.global name;							\
 name:
 
-#define COMMON_HANDLER_END(name)
+#define COMMON_HANDLER_END(name)					\
+	.previous
 
 #define TRAMP_HANDLER_BEGIN(name)					\
-	.align 7;							\
-	.global name ;							\
-name:
+	__FIXED_SECTION_ENTRY_BEGIN(real_trampolines, name, 7)
+
+#define TRAMP_HANDLER_END(name)						\
+	FIXED_SECTION_ENTRY_END(real_trampolines, name)
 
-#define TRAMP_HANDLER_END(name)	
+#define VTRAMP_HANDLER_BEGIN(name)					\
+	__FIXED_SECTION_ENTRY_BEGIN(virt_trampolines, name, 7)
+
+#define VTRAMP_HANDLER_END(name)					\
+	FIXED_SECTION_ENTRY_END(virt_trampolines, name)
 
 #define TRAMP_KVM_BEGIN(name)						\
 	TRAMP_HANDLER_BEGIN(name)
@@ -39,63 +169,75 @@ name:
 #define TRAMP_KVM_END(name)						\
 	TRAMP_HANDLER_END(name)
 
-#define VECTOR_HANDLER_REAL_NONE(start, end)
+#define VECTOR_HANDLER_REAL_NONE(start, end)				\
+	FIXED_SECTION_ENTRY_S_BEGIN(real_vectors, exc_##start##_##unused, start); \
+	FIXED_SECTION_ENTRY_E_END(real_vectors, exc_##start##_##unused, end)
 
-#define VECTOR_HANDLER_VIRT_NONE(start, end)
+#define VECTOR_HANDLER_VIRT_NONE(start, end)				\
+	FIXED_SECTION_ENTRY_S_BEGIN(virt_vectors, exc_##start##_##unused, start); \
+	FIXED_SECTION_ENTRY_E_END(virt_vectors, exc_##start##_##unused, end);
 
 
 #define VECTOR_HANDLER_REAL(name, start, end)				\
 	VECTOR_HANDLER_REAL_BEGIN(name, start, end);			\
 	STD_EXCEPTION_PSERIES(start, name##_common);			\
-	VECTOR_HANDLER_REAL_END(name, start, end);
+	VECTOR_HANDLER_REAL_END(name, start, end)
 
 #define VECTOR_HANDLER_VIRT(name, start, end, realvec)			\
 	VECTOR_HANDLER_VIRT_BEGIN(name, start, end);			\
 	STD_RELON_EXCEPTION_PSERIES(start, realvec, name##_common);	\
-	VECTOR_HANDLER_VIRT_END(name, start, end);
+	VECTOR_HANDLER_VIRT_END(name, start, end)
 
 #define VECTOR_HANDLER_REAL_MASKABLE(name, start, end)			\
 	VECTOR_HANDLER_REAL_BEGIN(name, start, end);			\
 	MASKABLE_EXCEPTION_PSERIES(start, start, name##_common);	\
-	VECTOR_HANDLER_REAL_END(name, start, end);
+	VECTOR_HANDLER_REAL_END(name, start, end)
 
 #define VECTOR_HANDLER_VIRT_MASKABLE(name, start, end, realvec)		\
 	VECTOR_HANDLER_VIRT_BEGIN(name, start, end);			\
 	MASKABLE_RELON_EXCEPTION_PSERIES(start, realvec, name##_common); \
-	VECTOR_HANDLER_VIRT_END(name, start, end);
+	VECTOR_HANDLER_VIRT_END(name, start, end)
 
 #define VECTOR_HANDLER_REAL_HV(name, start, end)			\
 	VECTOR_HANDLER_REAL_BEGIN(name, start, end);			\
 	STD_EXCEPTION_HV(start, start + 0x2, name##_common);		\
-	VECTOR_HANDLER_REAL_END(name, start, end);
+	VECTOR_HANDLER_REAL_END(name, start, end)
 
 #define VECTOR_HANDLER_VIRT_HV(name, start, end, realvec)		\
 	VECTOR_HANDLER_VIRT_BEGIN(name, start, end);			\
 	STD_RELON_EXCEPTION_HV(start, realvec + 0x2, name##_common);	\
-	VECTOR_HANDLER_VIRT_END(name, start, end);
+	VECTOR_HANDLER_VIRT_END(name, start, end)
 
 #define __VECTOR_HANDLER_REAL_OOL(name, start, end)			\
 	VECTOR_HANDLER_REAL_BEGIN(name, start, end);			\
 	__OOL_EXCEPTION(start, label, tramp_real_##name);		\
-	VECTOR_HANDLER_REAL_END(name, start, end);
+	VECTOR_HANDLER_REAL_END(name, start, end)
 
 #define __TRAMP_HANDLER_REAL_OOL(name, vec)				\
 	TRAMP_HANDLER_BEGIN(tramp_real_##name);				\
 	STD_EXCEPTION_PSERIES_OOL(vec, name##_common);			\
-	TRAMP_HANDLER_END(tramp_real_##name);
+	TRAMP_HANDLER_END(tramp_real_##name)
+
+#define VECTOR_HANDLER_REAL_OOL(name, start, end)			\
+	__VECTOR_HANDLER_REAL_OOL(name, start, end);			\
+	__TRAMP_HANDLER_REAL_OOL(name, start)
 
 #define __VECTOR_HANDLER_REAL_OOL_MASKABLE(name, start, end)		\
-	__VECTOR_HANDLER_REAL_OOL(name, start, end);
+	__VECTOR_HANDLER_REAL_OOL(name, start, end)
 
 #define __TRAMP_HANDLER_REAL_OOL_MASKABLE(name, vec)			\
 	TRAMP_HANDLER_BEGIN(tramp_real_##name);				\
 	MASKABLE_EXCEPTION_PSERIES_OOL(vec, name##_common);		\
-	TRAMP_HANDLER_END(tramp_real_##name);
+	TRAMP_HANDLER_END(tramp_real_##name)
+
+#define VECTOR_HANDLER_REAL_OOL_MASKABLE(name, start, end)		\
+	__VECTOR_HANDLER_REAL_OOL_MASKABLE(name, start, end);		\
+	__TRAMP_HANDLER_REAL_OOL_MASKABLE(name, start)
 
 #define __VECTOR_HANDLER_REAL_OOL_HV_DIRECT(name, start, end, handler)	\
 	VECTOR_HANDLER_REAL_BEGIN(name, start, end);			\
 	__OOL_EXCEPTION(start, label, handler);				\
-	VECTOR_HANDLER_REAL_END(name, start, end);
+	VECTOR_HANDLER_REAL_END(name, start, end)
 
 #define __VECTOR_HANDLER_REAL_OOL_HV(name, start, end)			\
 	__VECTOR_HANDLER_REAL_OOL(name, start, end);
@@ -103,7 +245,11 @@ name:
 #define __TRAMP_HANDLER_REAL_OOL_HV(name, vec)				\
 	TRAMP_HANDLER_BEGIN(tramp_real_##name);				\
 	STD_EXCEPTION_HV_OOL(vec + 0x2, name##_common);			\
-	TRAMP_HANDLER_END(tramp_real_##name);
+	TRAMP_HANDLER_END(tramp_real_##name)
+
+#define VECTOR_HANDLER_REAL_OOL_HV(name, start, end)			\
+	__VECTOR_HANDLER_REAL_OOL_HV(name, start, end);			\
+	__TRAMP_HANDLER_REAL_OOL_HV(name, start)
 
 #define __VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(name, start, end)		\
 	__VECTOR_HANDLER_REAL_OOL(name, start, end);
@@ -111,41 +257,61 @@ name:
 #define __TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(name, vec)			\
 	TRAMP_HANDLER_BEGIN(tramp_real_##name);				\
 	MASKABLE_EXCEPTION_HV_OOL(vec, name##_common);			\
-	TRAMP_HANDLER_END(tramp_real_##name);
+	TRAMP_HANDLER_END(tramp_real_##name)
+
+#define VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(name, start, end)		\
+	__VECTOR_HANDLER_REAL_OOL_MASKABLE_HV(name, start, end);	\
+	__TRAMP_HANDLER_REAL_OOL_MASKABLE_HV(name, start)
 
 #define __VECTOR_HANDLER_VIRT_OOL(name, start, end)			\
 	VECTOR_HANDLER_VIRT_BEGIN(name, start, end);			\
 	__OOL_EXCEPTION(start, label, tramp_virt_##name);		\
-	VECTOR_HANDLER_VIRT_END(name, start, end);
+	VECTOR_HANDLER_VIRT_END(name, start, end)
 
 #define __TRAMP_HANDLER_VIRT_OOL(name, realvec)				\
-	TRAMP_HANDLER_BEGIN(tramp_virt_##name);				\
+	VTRAMP_HANDLER_BEGIN(tramp_virt_##name);			\
 	STD_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
-	TRAMP_HANDLER_END(tramp_virt_##name);
+	VTRAMP_HANDLER_END(tramp_virt_##name)
+
+#define VECTOR_HANDLER_VIRT_OOL(name, start, end, realvec)		\
+	__VECTOR_HANDLER_VIRT_OOL(name, start, end);			\
+	__TRAMP_HANDLER_VIRT_OOL(name, realvec)
 
 #define __VECTOR_HANDLER_VIRT_OOL_MASKABLE(name, start, end)		\
-	__VECTOR_HANDLER_VIRT_OOL(name, start, end);
+	__VECTOR_HANDLER_VIRT_OOL(name, start, end)
 
 #define __TRAMP_HANDLER_VIRT_OOL_MASKABLE(name, realvec)		\
-	TRAMP_HANDLER_BEGIN(tramp_virt_##name);				\
+	VTRAMP_HANDLER_BEGIN(tramp_virt_##name);			\
 	MASKABLE_RELON_EXCEPTION_PSERIES_OOL(realvec, name##_common);	\
-	TRAMP_HANDLER_END(tramp_virt_##name);
+	VTRAMP_HANDLER_END(tramp_virt_##name)
+
+#define VECTOR_HANDLER_VIRT_OOL_MASKABLE(name, start, end, realvec)	\
+	__VECTOR_HANDLER_VIRT_OOL_MASKABLE(name, start, end);		\
+	__TRAMP_HANDLER_VIRT_OOL_MASKABLE(name, realvec)
 
 #define __VECTOR_HANDLER_VIRT_OOL_HV(name, start, end)			\
-	__VECTOR_HANDLER_VIRT_OOL(name, start, end);
+	__VECTOR_HANDLER_VIRT_OOL(name, start, end)
 
 #define __TRAMP_HANDLER_VIRT_OOL_HV(name, realvec)			\
-	TRAMP_HANDLER_BEGIN(tramp_virt_##name);				\
+	VTRAMP_HANDLER_BEGIN(tramp_virt_##name);			\
 	STD_RELON_EXCEPTION_HV_OOL(realvec, name##_common);		\
-	TRAMP_HANDLER_END(tramp_virt_##name);
+	VTRAMP_HANDLER_END(tramp_virt_##name)
+
+#define VECTOR_HANDLER_VIRT_OOL_HV(name, start, end, realvec)		\
+	__VECTOR_HANDLER_VIRT_OOL_HV(name, start, end);			\
+	__TRAMP_HANDLER_VIRT_OOL_HV(name, realvec)
 
 #define __VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(name, start, end)		\
-	__VECTOR_HANDLER_VIRT_OOL(name, start, end);
+	__VECTOR_HANDLER_VIRT_OOL(name, start, end)
 
 #define __TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(name, realvec)		\
-	TRAMP_HANDLER_BEGIN(tramp_virt_##name);				\
+	VTRAMP_HANDLER_BEGIN(tramp_virt_##name);			\
 	MASKABLE_RELON_EXCEPTION_HV_OOL(realvec, name##_common);	\
-	TRAMP_HANDLER_END(tramp_virt_##name);
+	VTRAMP_HANDLER_END(tramp_virt_##name)
+
+#define VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(name, start, end, realvec)	\
+	__VECTOR_HANDLER_VIRT_OOL_MASKABLE_HV(name, start, end);	\
+	__TRAMP_HANDLER_VIRT_OOL_MASKABLE_HV(name, realvec)
 
 #define TRAMP_KVM(area, n)						\
 	TRAMP_KVM_BEGIN(do_kvm_##n);					\
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 2b31632..18e04ac 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -200,29 +200,26 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 
 #if defined(_CALL_ELF) && _CALL_ELF == 2
 
-#define _GLOBAL(name) \
-	.section ".text"; \
+#define ____GLOBAL(name) \
 	.align 2 ; \
 	.type name,@function; \
 	.globl name; \
 name:
 
+#define _GLOBAL(name) \
+	.section ".text"; \
+	____GLOBAL(name)
+
 #define _GLOBAL_TOC(name) \
 	.section ".text"; \
-	.align 2 ; \
-	.type name,@function; \
-	.globl name; \
-name: \
+	____GLOBAL(name) \
 0:	addis r2,r12,(.TOC.-0b)@ha; \
 	addi r2,r2,(.TOC.-0b)@l; \
 	.localentry name,.-name
 
 #define _KPROBE(name) \
 	.section ".kprobes.text","a"; \
-	.align 2 ; \
-	.type name,@function; \
-	.globl name; \
-name:
+	____GLOBAL(name) \
 
 #define DOTSYM(a)	a
 
@@ -231,6 +228,18 @@ name:
 #define XGLUE(a,b) a##b
 #define GLUE(a,b) XGLUE(a,b)
 
+#define ____GLOBAL(name) \
+	.align 2 ; \
+	.globl name; \
+	.globl GLUE(.,name); \
+	.section ".opd","aw"; \
+name: \
+	.quad GLUE(.,name); \
+	.quad .TOC.@tocbase; \
+	.quad 0; \
+	.type GLUE(.,name),@function; \
+GLUE(.,name):
+
 #define _GLOBAL(name) \
 	.section ".text"; \
 	.align 2 ; \
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index db13569..9093521 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -18,16 +18,60 @@
 #include <asm/cpuidle.h>
 
 /*
+ * There are a few constraints to be conerned with.
+ * - Exception vectors must be placed according to specification.
+ * - Real mode code and data must be located at thier physical location.
+ * - Virtual mode exceptions must be located at 0xc000... virtual address.
+ * - LOAD_HANDLER_64K and conditional branch targets must be within 64K/32K 
+ *
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
+ * 0x0100 - 0x17ff : Real mode pSeries interrupt vectors
+ * 0x1800 - 0x1fff : Reserved for vectors
+ * 0x2000 - 0x3fff : Real mode trampolines
+ * 0x4000 - 0x5fff : Relon (IR=1,DR=1) mode pSeries interrupt vectors
+ * 0x6000 - 0x6fff : Relon mode trampolines
  * 0x7000 - 0x7fff : FWNMI data area
- * 0x8000 - 0x8fff : Initial (CPU0) segment table
- * 0x9000 -        : Early init and support code
+ * 0x8000 -   .... : Common interrupt handlers, remaining early
+ *                   setup code, rest of kernel.
+ *
+ * 0x0000 - 0x3000 runs in real mode, other kernel code runs virtual.
+ * 0x0000 - 0x6fff is mapped to PAGE_OFFSET, other kernel code is relocatable.
  */
+OPEN_FIXED_SECTION(real_vectors,        0x0100, 0x2000)
+OPEN_FIXED_SECTION(real_trampolines,    0x2000, 0x4000)
+OPEN_FIXED_SECTION(virt_vectors,        0x4000, 0x6000)
+OPEN_FIXED_SECTION(virt_trampolines,    0x6000, 0x7000)
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+OPEN_FIXED_SECTION(fwnmi_page,          0x7000, 0x8000)
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
@@ -90,7 +134,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)				\
  * Therefore any relative branches in this section must only
  * branch to labels in this section.
  */
-	. = 0x100
 	.globl __start_interrupts
 __start_interrupts:
 
@@ -239,9 +282,6 @@ VECTOR_HANDLER_REAL_BEGIN(instruction_access_slb, 0x480, 0x500)
 #endif
 VECTOR_HANDLER_REAL_END(instruction_access_slb, 0x480, 0x500)
 
-	/* We open code these as we can't have a ". = x" (even with
-	 * x = "." within a feature section
-	 */
 VECTOR_HANDLER_REAL_BEGIN(hardware_interrupt, 0x500, 0x600)
 	.globl hardware_interrupt_hv;
 hardware_interrupt_hv:
@@ -249,7 +289,7 @@ hardware_interrupt_hv:
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
 					    EXC_HV, SOFTEN_TEST_HV)
 	FTR_SECTION_ELSE
-		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt_common,
+		_MASKABLE_EXCEPTION_PSERIES(0x500, FIXED_SECTION_REL_ADDR(text, hardware_interrupt_common),
 					    EXC_STD, SOFTEN_TEST_PR)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 VECTOR_HANDLER_REAL_END(hardware_interrupt, 0x500, 0x600)
@@ -400,7 +440,6 @@ TRAMP_KVM_HV_SKIP(PACA_EXGEN, 0x1800)
 
 #else /* CONFIG_CBE_RAS */
 VECTOR_HANDLER_REAL_NONE(0x1800, 0x1900)
-	. = 0x1800
 #endif
 
 
@@ -637,9 +676,11 @@ masked_##_H##interrupt:					\
 	GET_SCRATCH0(r13);				\
 	##_H##rfid;					\
 	b	.
-	
+
+USE_FIXED_SECTION(real_trampolines)
 	MASKED_INTERRUPT()
 	MASKED_INTERRUPT(H)
+UNUSE_FIXED_SECTION(real_trampolines)
 
 /*
  * Called from arch_local_irq_enable when an interrupt needs
@@ -827,7 +868,7 @@ hardware_interrupt_relon_hv:
 	BEGIN_FTR_SECTION
 		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_HV, SOFTEN_TEST_HV)
 	FTR_SECTION_ELSE
-		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, hardware_interrupt_common, EXC_STD, SOFTEN_TEST_PR)
+		_MASKABLE_RELON_EXCEPTION_PSERIES(0x500, FIXED_SECTION_REL_ADDR(text, hardware_interrupt_common), EXC_STD, SOFTEN_TEST_PR)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 VECTOR_HANDLER_VIRT_END(hardware_interrupt, 0x4500, 0x4600)
 
@@ -1114,6 +1155,7 @@ __TRAMP_HANDLER_VIRT_OOL(vsx_unavailable, 0xf40)
 __TRAMP_HANDLER_VIRT_OOL(facility_unavailable, 0xf60)
 __TRAMP_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
 
+USE_FIXED_SECTION(virt_trampolines)
 	/*
 	 * The __end_interrupts marker must be past the out-of-line (OOL)
 	 * handlers, so that they are copied to real address 0x100 when running
@@ -1124,20 +1166,16 @@ __TRAMP_HANDLER_VIRT_OOL_HV(h_facility_unavailable, 0xf80)
 	.align	7
 	.globl	__end_interrupts
 __end_interrupts:
+UNUSE_FIXED_SECTION(virt_trampolines)
 
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
  * Data area reserved for FWNMI option.
  * This address (0x7000) is fixed by the RPA.
+ * pseries and powernv need to keep the whole page from
+ * 0x7000 to 0x8000 free for use by the firmware
  */
-	.= 0x7000
-	.globl fwnmi_data_area
-fwnmi_data_area:
-
-	/* pseries and powernv need to keep the whole page from
-	 * 0x7000 to 0x8000 free for use by the firmware
-	 */
-	. = 0x8000
+FIXED_SECTION_ENTRY_ZERO(fwnmi_page, 0x7000, 0x8000)
 #endif /* defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV) */
 
 COMMON_HANDLER_BEGIN(hmi_exception_early)
@@ -1419,6 +1457,14 @@ TRAMP_HANDLER_BEGIN(power4_fixup_nap)
 TRAMP_HANDLER_END(power4_fixup_nap)
 #endif
 
+CLOSE_FIXED_SECTION(real_vectors);
+CLOSE_FIXED_SECTION(real_trampolines);
+CLOSE_FIXED_SECTION(virt_vectors);
+CLOSE_FIXED_SECTION(virt_trampolines);
+CLOSE_FIXED_SECTION(fwnmi_page);
+
+USE_TEXT_SECTION()
+
 /*
  * Hash table stuff
  */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 2d14774..9006e51 100644
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
+FIXED_SECTION_ENTRY_S_BEGIN(first_256B, __start, 0x0)
 	/* NOP this out unconditionally */
 BEGIN_FTR_SECTION
 	FIXUP_ENDIAN
@@ -77,6 +78,7 @@ END_FTR_SECTION(0, 1)
 
 	/* Catch branch to 0 in real mode */
 	trap
+FIXED_SECTION_ENTRY_END(first_256B, __start)
 
 	/* Secondary processors spin on this value until it becomes non-zero.
 	 * When non-zero, it contains the real address of the function the cpu
@@ -101,24 +103,22 @@ __secondary_hold_acknowledge:
 	 * observing the alignment requirement.
 	 */
 	/* Do not move this variable as kexec-tools knows about it. */
-	. = 0x5c
-	.globl	__run_at_load
-__run_at_load:
+FIXED_SECTION_ENTRY_S_BEGIN(first_256B, __run_at_load, 0x5c)
 	.long	0x72756e30	/* "run0" -- relocate to 0 by default */
+FIXED_SECTION_ENTRY_END(first_256B, __run_at_load)
+
 #endif
 
-	. = 0x60
+FIXED_SECTION_ENTRY_S_BEGIN(first_256B, __secondary_hold, 0x60)
 /*
  * The following code is used to hold secondary processors
  * in a spin loop after they have entered the kernel, but
  * before the bulk of the kernel has been relocated.  This code
  * is relocated to physical address 0x60 before prom_init is run.
  * All of it must fit below the first exception vector at 0x100.
- * Use .globl here not _GLOBAL because we want __secondary_hold
+ * Use .globl here not ____GLOBAL because we want __secondary_hold
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
@@ -199,7 +206,7 @@ booting_thread_hwid:
  * r3 = the thread physical id
  * r4 = the entry point where thread starts
  */
-_GLOBAL(book3e_start_thread)
+____GLOBAL(book3e_start_thread)
 	LOAD_REG_IMMEDIATE(r5, MSR_KERNEL)
 	cmpi	0, r3, 0
 	beq	10f
@@ -227,7 +234,7 @@ _GLOBAL(book3e_start_thread)
  * input parameter:
  * r3 = the thread physical id
  */
-_GLOBAL(book3e_stop_thread)
+____GLOBAL(book3e_stop_thread)
 	cmpi	0, r3, 0
 	beq	10f
 	cmpi	0, r3, 1
@@ -241,7 +248,7 @@ _GLOBAL(book3e_stop_thread)
 13:
 	blr
 
-_GLOBAL(fsl_secondary_thread_init)
+____GLOBAL(fsl_secondary_thread_init)
 	mfspr	r4,SPRN_BUCSR
 
 	/* Enable branch prediction */
@@ -278,7 +285,7 @@ _GLOBAL(fsl_secondary_thread_init)
 1:
 #endif
 
-_GLOBAL(generic_secondary_thread_init)
+____GLOBAL(generic_secondary_thread_init)
 	mr	r24,r3
 
 	/* turn on 64-bit mode */
@@ -304,7 +311,7 @@ _GLOBAL(generic_secondary_thread_init)
  * this core already exists (setup via some other mechanism such
  * as SCOM before entry).
  */
-_GLOBAL(generic_secondary_smp_init)
+____GLOBAL(generic_secondary_smp_init)
 	FIXUP_ENDIAN
 	mr	r24,r3
 	mr	r25,r4
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
@@ -645,7 +655,7 @@ p_end:	.llong	_end - _stext
  *
  * Note: this routine *only* clobbers r0, r6 and lr
  */
-_GLOBAL(copy_and_flush)
+____GLOBAL(copy_and_flush)
 	addi	r5,r5,-8
 	addi	r6,r6,-8
 4:	li	r0,8			/* Use the smallest common	*/
@@ -676,15 +686,15 @@ _GLOBAL(copy_and_flush)
 .align 8
 copy_to_here:
 
+	.text
+
 #ifdef CONFIG_SMP
 #ifdef CONFIG_PPC_PMAC
 /*
  * On PowerMac, secondary processors starts from the reset vector, which
  * is temporarily turned into a call to one of the functions below.
  */
-	.section ".text";
 	.align 2 ;
-
 	.globl	__secondary_start_pmac_0
 __secondary_start_pmac_0:
 	/* NB the entries for cpus 0, 1, 2 must each occupy 8 bytes. */
@@ -697,7 +707,7 @@ __secondary_start_pmac_0:
 	li	r24,3
 1:
 	
-_GLOBAL(pmac_secondary_start)
+____GLOBAL(pmac_secondary_start)
 	/* turn on 64-bit mode */
 	bl	enable_64b_mode
 
@@ -758,7 +768,6 @@ _GLOBAL(pmac_secondary_start)
  *   r13       = paca virtual address
  *   SPRG_PACA = paca virtual address
  */
-	.section ".text";
 	.align 2 ;
 
 	.globl	__secondary_start
@@ -818,7 +827,7 @@ start_secondary_prolog:
  * to continue with online operation when woken up
  * from cede in cpu offline.
  */
-_GLOBAL(start_secondary_resume)
+____GLOBAL(start_secondary_resume)
 	ld	r1,PACAKSAVE(r13)	/* Reload kernel stack pointer */
 	li	r3,0
 	std	r3,0(r1)		/* Zero the stack frame pointer	*/
@@ -855,7 +864,7 @@ enable_64b_mode:
  * accessed later with the MMU on. We use tovirt() at the call
  * sites to handle this.
  */
-_GLOBAL(relative_toc)
+____GLOBAL(relative_toc)
 	mflr	r0
 	bcl	20,31,$+4
 0:	mflr	r11
@@ -864,6 +873,7 @@ _GLOBAL(relative_toc)
 	mtlr	r0
 	blr
 
+
 .balign 8
 p_toc:	.llong	__toc_start + 0x8000 - 0b
 
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 552dcbc..6d5d551 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -36,6 +36,7 @@ jiffies = jiffies_64;
 OUTPUT_ARCH(powerpc:common)
 jiffies = jiffies_64 + 4;
 #endif
+
 SECTIONS
 {
 	. = KERNELBASE;
@@ -47,9 +48,25 @@ SECTIONS
 	/* Text and gots */
 	.text : AT(ADDR(.text) - LOAD_OFFSET) {
 		ALIGN_FUNCTION();
-		HEAD_TEXT
 		_text = .;
-		*(.text .fixup .ref.text)
+		_stext = .;
+		*(.head.text.first_256B);
+		*(.head.text.real_vectors);
+		*(.head.text.real_trampolines);
+		*(.head.text.virt_vectors);
+		*(.head.text.virt_trampolines);
+		/*
+		 * If the build dies here, it's normally due to the linker
+		 * placing branch stubs inside a fixed section but before the
+		 * fixed section start label. Must use branches that can
+		 * directly reach their target.
+		 */
+		. = 0x7000;
+#if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
+		*(.head.text.fwnmi_page);
+		. = 0x8000;
+#endif
+		*(.text .fixup .ref.text);
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
@@ -276,3 +293,4 @@ SECTIONS
 	/* Sections to be discarded. */
 	DISCARDS
 }
+
-- 
2.8.1

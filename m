Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swK745TdKzDt3X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 18:32:16 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id r16so6684532pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 00:32:16 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Balbir Singh <bsingharora@gmail.com>,
 Alan Modra <amodra@gmail.com>
Subject: [PATCH v2] powerpc: link warning for orphan sections
Date: Fri, 14 Oct 2016 18:32:00 +1100
Message-Id: <20161014073200.24669-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add --orphan-handling=warn to final link flags. This ensures we can
handle all sections explicitly. This would have caught subtle breakage
such as 7de3b27bac47da9de08409df1d69664acbb72197 at build-time.

Also bring some wayward sections into the fold:
- .text.hot and .text.unlikely are compiler generated sections.
- .sfpr is a linker generated section for register save functions.
- .sdata2, .dynsbss, .plt are used by PPC32
- We previously did not specify DWARF_DEBUG or STABS_DEBUG
- DWARF_DEBUG did not include all DWARF sections that can be emitted
- A number of sections are unused.

I don't know if I've exactly got everything right here, particularly
with ppc32, so would appreciate people casting their eye over it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes since v1:
- warn instead of error
- use ld-option
- add some more DWARF sections
- small typo in linker script

 arch/powerpc/Makefile             |  1 +
 arch/powerpc/kernel/vmlinux.lds.S | 16 ++++++++++++++--
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 50d020a..c39601d 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -91,6 +91,7 @@ endif
 LDFLAGS_vmlinux-y := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
+LDFLAGS_vmlinux += $(call ld-option,--orphan-handling=warn)
 
 ifeq ($(CONFIG_PPC64),y)
 ifeq ($(call cc-option-yn,-mcmodel=medium),y)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 8295f51..a0e6452 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -97,7 +97,7 @@ SECTIONS
 	.text : AT(ADDR(.text) - LOAD_OFFSET) {
 		ALIGN_FUNCTION();
 		/* careful! __ftr_alt_* sections need to be close to .text */
-		*(.text .fixup __ftr_alt_* .ref.text)
+		*(.text.hot .text .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text .sfpr)
 		SCHED_TEXT
 		CPUIDLE_TEXT
 		LOCK_TEXT
@@ -256,7 +256,9 @@ SECTIONS
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
 		*(.sdata)
+		*(.sdata2)
 		*(.got.plt) *(.got)
+		*(.plt)
 	}
 #else
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
@@ -317,6 +319,16 @@ SECTIONS
 	_end = . ;
 	PROVIDE32 (end = .);
 
-	/* Sections to be discarded. */
+	STABS_DEBUG
+
+	DWARF_DEBUG
+
 	DISCARDS
+	/DISCARD/ : {
+		*(*.EMB.apuinfo)
+		*(.glink .iplt .plt .rela* .comment)
+		*(.gnu.version*)
+		*(.gnu.attributes)
+		*(.eh_frame)
+	}
 }
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3e42bcd..2f825de 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -581,6 +581,7 @@
 #define SBSS(sbss_align)						\
 	. = ALIGN(sbss_align);						\
 	.sbss : AT(ADDR(.sbss) - LOAD_OFFSET) {				\
+		*(.dynsbss)						\
 		*(.sbss)						\
 		*(.scommon)						\
 	}
@@ -627,11 +628,21 @@
 		.debug_str      0 : { *(.debug_str) }			\
 		.debug_loc      0 : { *(.debug_loc) }			\
 		.debug_macinfo  0 : { *(.debug_macinfo) }		\
+		.debug_pubtypes 0 : { *(.debug_pubtypes) }		\
+		/* DWARF 3 */						\
+		.debug_ranges	0 : { *(.debug_ranges) }		\
 		/* SGI/MIPS DWARF 2 extensions */			\
 		.debug_weaknames 0 : { *(.debug_weaknames) }		\
 		.debug_funcnames 0 : { *(.debug_funcnames) }		\
 		.debug_typenames 0 : { *(.debug_typenames) }		\
 		.debug_varnames  0 : { *(.debug_varnames) }		\
+		/* GNU DWARF 2 extensions */				\
+		.debug_gnu_pubnames 0 : { *(.debug_gnu_pubnames) }	\
+		.debug_gnu_pubtypes 0 : { *(.debug_gnu_pubtypes) }	\
+		/* DWARF 4 */						\
+		.debug_types	0 : { *(.debug_types) }			\
+		/* DWARF 5 */						\
+		.debug_addr	0 : { *(.debug_addr) }
 
 		/* Stabs debugging sections.  */
 #define STABS_DEBUG							\
-- 
2.9.3

Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSW7F127tzDwCG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:40:09 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i88so7507516pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 20:40:09 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] powerpc: link warning for orphan sections
Date: Tue, 29 Nov 2016 15:39:42 +1100
Message-Id: <20161129043942.13848-5-npiggin@gmail.com>
In-Reply-To: <20161129043942.13848-1-npiggin@gmail.com>
References: <20161129043942.13848-1-npiggin@gmail.com>
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
- .sdata2, .dynsbss, .plt are used by PPC32
- We previously did not specify DWARF_DEBUG or STABS_DEBUG
- DWARF_DEBUG did not include all DWARF sections that can be emitted
- A number of sections are unused.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

I don't know if I've exactly got everything right here, particularly
with ppc32, so would appreciate people casting their eye over it.

 arch/powerpc/Makefile             |  1 +
 arch/powerpc/kernel/vmlinux.lds.S | 16 ++++++++++++++--
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9fbc1c8..6a9f319 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -102,6 +102,7 @@ endif
 LDFLAGS_vmlinux-y := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
+LDFLAGS_vmlinux += $(call ld-option,--orphan-handling=warn)
 
 ifeq ($(CONFIG_PPC64),y)
 ifeq ($(call cc-option-yn,-mcmodel=medium),y)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index f710d15..6bd42d3 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -86,7 +86,7 @@ SECTIONS
 		ALIGN_FUNCTION();
 #endif
 		/* careful! __ftr_alt_* sections need to be close to .text */
-		*(.text .fixup __ftr_alt_* .ref.text)
+		*(.text.hot .text .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);
 		SCHED_TEXT
 		CPUIDLE_TEXT
 		LOCK_TEXT
@@ -253,7 +253,9 @@ SECTIONS
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
 		*(.sdata)
+		*(.sdata2)
 		*(.got.plt) *(.got)
+		*(.plt)
 	}
 #else
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
@@ -314,6 +316,16 @@ SECTIONS
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
index 31e1d63..6d5d35f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -595,6 +595,7 @@
 #define SBSS(sbss_align)						\
 	. = ALIGN(sbss_align);						\
 	.sbss : AT(ADDR(.sbss) - LOAD_OFFSET) {				\
+		*(.dynsbss)						\
 		*(.sbss)						\
 		*(.scommon)						\
 	}
@@ -641,11 +642,21 @@
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
2.10.2

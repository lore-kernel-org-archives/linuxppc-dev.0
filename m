Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swGHk4sQwzDt2P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 16:24:34 +1100 (AEDT)
Received: by mail-pa0-x241.google.com with SMTP id os4so1555376pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 22:24:34 -0700 (PDT)
Date: Fri, 14 Oct 2016 16:24:26 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH] powerpc: link error on orphan sections
Message-ID: <20161014162426.4b9c628d@roar.ozlabs.ibm.com>
In-Reply-To: <87twcfd2z2.fsf@concordia.ellerman.id.au>
References: <20161012070020.30170-1-npiggin@gmail.com>
 <87twcfd2z2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc Alan Modra

On Fri, 14 Oct 2016 14:27:45 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> With DEBUG_INFO=y I'm seeing:
> 
>   /opt/toolchains/6/powerpc/bin/ld: error: unplaced orphan section `.debug_addr' from `arch/powerpc/kernel/prom_init.o'.
>   /opt/toolchains/6/powerpc/bin/ld: error: unplaced orphan section `.debug_gnu_pubnames' from `arch/powerpc/kernel/prom_init.o'.
>   /opt/toolchains/6/powerpc/bin/ld: error: unplaced orphan section `.debug_gnu_pubtypes' from `arch/powerpc/kernel/prom_init.o'.
> 
> And many more for the same sections from other files.

How's this? Might take a few iterations to smooth out all toolchains


From: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 22 Sep 2016 18:41:14 +1000
Subject: [PATCH] powerpc: link error on orphan sections

Add --orphan-handling=error to final link flags. This ensures we have to
handle all sections. This would have caught subtle breakage such as
7de3b27bac47da9de08409df1d69664acbb72197 at build-time.

Also bring some wayward sections into the fold:
- .text.hot and .text.unlikely are compiler generated sections.
- .sfpr is a linker generated section for register save functions.
- .sdata2, .dynsbss, .plt are used by PPC32
- We previously did not specify DWARF_DEBUG or STABS_DEBUG
- DWARF_DEBUG did not include DWARF3 .debug_ranges
- A number of sections are unused.

I don't know if I've exactly got everything right here, particularly
with ppc32, so would appreciate people casting their eye over it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile             |  1 +
 arch/powerpc/kernel/vmlinux.lds.S | 16 ++++++++++++++--
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 50d020a..6883fca 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -91,6 +91,7 @@ endif
 LDFLAGS_vmlinux-y := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
+LDFLAGS_vmlinux += $(call ld-option,--orphan-handling=error)
 
 ifeq ($(CONFIG_PPC64),y)
 ifeq ($(call cc-option-yn,-mcmodel=medium),y)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 8295f51..9f4d85e 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -97,7 +97,7 @@ SECTIONS
 	.text : AT(ADDR(.text) - LOAD_OFFSET) {
 		ALIGN_FUNCTION();
 		/* careful! __ftr_alt_* sections need to be close to .text */
-		*(.text .fixup __ftr_alt_* .ref.text)
+		*(.text.hot .text .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text .sfpr) \
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

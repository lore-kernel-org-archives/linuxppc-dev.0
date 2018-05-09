Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gxKn3bQkzF2NP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 23:00:29 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id k11-v6so21535824pgo.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 06:00:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
Date: Wed,  9 May 2018 23:00:01 +1000
Message-Id: <20180509130001.24276-5-npiggin@gmail.com>
In-Reply-To: <20180509130001.24276-1-npiggin@gmail.com>
References: <20180509130001.24276-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This requires further changes to linker script to KEEP some tables
and wildcard compiler generated sections into the right place. This
includes pp32 modifications from Christophe Leroy.

When compiling powernv_defconfig with this option, the resulting
kernel is almost 400kB smaller (and still boots):

    text      data       bss        dec   filename
11827621   4810490   1341080   17979191   vmlinux
11752437   4598858   1338776   17690071   vmlinux.dcde

Mathieu's numbers for custom Mac Mini G4 config has almost 200kB
saving. It also had some increase in vmlinux size for as-yet
unknown reasons.

    text      data       bss        dec   filename
 7461457   2475122   1428064   11364643   vmlinux
 7386425   2364370   1425432   11176227   vmlinux.dcde

Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> [8xx]
Tested-by: Mathieu Malaterre <malat@debian.org> [32-bit powermac]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/kernel/vmlinux.lds.S | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c32a181a7cbb..ee6dbe2efc8b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -205,6 +205,7 @@ config PPC
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
+	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_LIVEPATCH			if HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index c8af90ff49f0..52a93cdd04bc 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -89,7 +89,7 @@ SECTIONS
 	 */
 	.text BLOCK(0) : AT(ADDR(.text) - LOAD_OFFSET) {
 #ifdef CONFIG_LD_HEAD_STUB_CATCH
-		*(.linker_stub_catch);
+		KEEP(*(.linker_stub_catch));
 		. = . ;
 #endif
 
@@ -98,7 +98,7 @@ SECTIONS
 		ALIGN_FUNCTION();
 #endif
 		/* careful! __ftr_alt_* sections need to be close to .text */
-		*(.text.hot .text .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);
+		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);
 		SCHED_TEXT
 		CPUIDLE_TEXT
 		LOCK_TEXT
@@ -170,10 +170,10 @@ SECTIONS
 	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
 		INIT_DATA
 		__vtop_table_begin = .;
-		*(.vtop_fixup);
+		KEEP(*(.vtop_fixup));
 		__vtop_table_end = .;
 		__ptov_table_begin = .;
-		*(.ptov_fixup);
+		KEEP(*(.ptov_fixup));
 		__ptov_table_end = .;
 	}
 
@@ -194,26 +194,26 @@ SECTIONS
 	. = ALIGN(8);
 	__ftr_fixup : AT(ADDR(__ftr_fixup) - LOAD_OFFSET) {
 		__start___ftr_fixup = .;
-		*(__ftr_fixup)
+		KEEP(*(__ftr_fixup))
 		__stop___ftr_fixup = .;
 	}
 	. = ALIGN(8);
 	__mmu_ftr_fixup : AT(ADDR(__mmu_ftr_fixup) - LOAD_OFFSET) {
 		__start___mmu_ftr_fixup = .;
-		*(__mmu_ftr_fixup)
+		KEEP(*(__mmu_ftr_fixup))
 		__stop___mmu_ftr_fixup = .;
 	}
 	. = ALIGN(8);
 	__lwsync_fixup : AT(ADDR(__lwsync_fixup) - LOAD_OFFSET) {
 		__start___lwsync_fixup = .;
-		*(__lwsync_fixup)
+		KEEP(*(__lwsync_fixup))
 		__stop___lwsync_fixup = .;
 	}
 #ifdef CONFIG_PPC64
 	. = ALIGN(8);
 	__fw_ftr_fixup : AT(ADDR(__fw_ftr_fixup) - LOAD_OFFSET) {
 		__start___fw_ftr_fixup = .;
-		*(__fw_ftr_fixup)
+		KEEP(*(__fw_ftr_fixup))
 		__stop___fw_ftr_fixup = .;
 	}
 #endif
@@ -226,7 +226,7 @@ SECTIONS
 	. = ALIGN(8);
 	.machine.desc : AT(ADDR(.machine.desc) - LOAD_OFFSET) {
 		__machine_desc_start = . ;
-		*(.machine.desc)
+		KEEP(*(.machine.desc))
 		__machine_desc_end = . ;
 	}
 #ifdef CONFIG_RELOCATABLE
@@ -274,7 +274,7 @@ SECTIONS
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
 		*(.data.rel*)
-		*(.sdata)
+		*(SDATA_MAIN)
 		*(.sdata2)
 		*(.got.plt) *(.got)
 		*(.plt)
@@ -289,7 +289,7 @@ SECTIONS
 
 	.opd : AT(ADDR(.opd) - LOAD_OFFSET) {
 		__start_opd = .;
-		*(.opd)
+		KEEP(*(.opd))
 		__end_opd = .;
 	}
 
-- 
2.17.0

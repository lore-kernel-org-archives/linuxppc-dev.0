Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADC8DDE0A2
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 20:53:24 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 10/12] [POWERPC] Update linker script to properly set physical
	addresses
Date: Thu, 10 Apr 2008 05:48:49 -0500
Message-Id: <1207824531-27168-11-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1207824531-27168-10-git-send-email-galak@kernel.crashing.org>
References: <1207824531-27168-1-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-2-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-3-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-4-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-5-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-6-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-7-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-8-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-9-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-10-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We can set LOAD_OFFSET and use the AT attribute on sections and the
linker will properly set the physical address of the LOAD program
header for us.

This allows us to know how the PHYSICAL_START the user configured a
kernel with by just looking at the resulting vmlinux ELF.

This is pretty much stolen from how x86 does things in their linker
scripts.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/vmlinux.lds.S |   47 ++++++++++++++++++-------------------
 include/asm-powerpc/page.h        |    1 +
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index b5a76bc..0c3000b 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -31,7 +31,7 @@ SECTIONS
  */
 
 	/* Text and gots */
-	.text : {
+	.text : AT(ADDR(.text) - LOAD_OFFSET) {
 		ALIGN_FUNCTION();
 		*(.text.head)
 		_text = .;
@@ -56,7 +56,7 @@ SECTIONS
 	RODATA
 
 	/* Exception & bug tables */
-	__ex_table : {
+	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {
 		__start___ex_table = .;
 		*(__ex_table)
 		__stop___ex_table = .;
@@ -72,7 +72,7 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 	__init_begin = .;
 
-	.init.text : {
+	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {
 		_sinittext = .;
 		INIT_TEXT
 		_einittext = .;
@@ -81,11 +81,11 @@ SECTIONS
 	/* .exit.text is discarded at runtime, not link time,
 	 * to deal with references from __bug_table
 	 */
-	.exit.text : {
+	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
 		EXIT_TEXT
 	}
 
-	.init.data : {
+	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
 		INIT_DATA
 		__vtop_table_begin = .;
 		*(.vtop_fixup);
@@ -101,19 +101,19 @@ SECTIONS
 	}
 
 	. = ALIGN(16);
-	.init.setup : {
+	.init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) {
 		__setup_start = .;
 		*(.init.setup)
 		__setup_end = .;
 	}
 
-	.initcall.init : {
+	.initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET) {
 		__initcall_start = .;
 		INITCALLS
 		__initcall_end = .;
 		}
 
-	.con_initcall.init : {
+	.con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
 		__con_initcall_start = .;
 		*(.con_initcall.init)
 		__con_initcall_end = .;
@@ -122,14 +122,14 @@ SECTIONS
 	SECURITY_INIT
 
 	. = ALIGN(8);
-	__ftr_fixup : {
+	__ftr_fixup : AT(ADDR(__ftr_fixup) - LOAD_OFFSET) {
 		__start___ftr_fixup = .;
 		*(__ftr_fixup)
 		__stop___ftr_fixup = .;
 	}
 #ifdef CONFIG_PPC64
 	. = ALIGN(8);
-	__fw_ftr_fixup : {
+	__fw_ftr_fixup : AT(ADDR(__fw_ftr_fixup) - LOAD_OFFSET) {
 		__start___fw_ftr_fixup = .;
 		*(__fw_ftr_fixup)
 		__stop___fw_ftr_fixup = .;
@@ -137,14 +137,14 @@ SECTIONS
 #endif
 #ifdef CONFIG_BLK_DEV_INITRD
 	. = ALIGN(PAGE_SIZE);
-	.init.ramfs : {
+	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
 		__initramfs_start = .;
 		*(.init.ramfs)
 		__initramfs_end = .;
 	}
 #endif
 	. = ALIGN(PAGE_SIZE);
-	.data.percpu : {
+	.data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) {
 		__per_cpu_start = .;
 		*(.data.percpu)
 		*(.data.percpu.shared_aligned)
@@ -152,7 +152,7 @@ SECTIONS
 	}
 
 	. = ALIGN(8);
-	.machine.desc : {
+	.machine.desc : AT(ADDR(.machine.desc) - LOAD_OFFSET) {
 		__machine_desc_start = . ;
 		*(.machine.desc)
 		__machine_desc_end = . ;
@@ -170,25 +170,24 @@ SECTIONS
 	_sdata = .;
 
 #ifdef CONFIG_PPC32
-	.data    :
-	{
+	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
 		*(.sdata)
 		*(.got.plt) *(.got)
 	}
 #else
-	.data : {
+	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
 		*(.data.rel*)
 		*(.toc1)
 		*(.branch_lt)
 	}
 
-	.opd : {
+	.opd : AT(ADDR(.opd) - LOAD_OFFSET) {
 		*(.opd)
 	}
 
-	.got : {
+	.got : AT(ADDR(.got) - LOAD_OFFSET) {
 		__toc_start = .;
 		*(.got)
 		*(.toc)
@@ -205,26 +204,26 @@ SECTIONS
 #else
 	. = ALIGN(16384);
 #endif
-	.data.init_task : {
+	.data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
 		*(.data.init_task)
 	}
 
 	. = ALIGN(PAGE_SIZE);
-	.data.page_aligned : {
+	.data.page_aligned : AT(ADDR(.data.page_aligned) - LOAD_OFFSET) {
 		*(.data.page_aligned)
 	}
 
-	.data.cacheline_aligned : {
+	.data.cacheline_aligned : AT(ADDR(.data.cacheline_aligned) - LOAD_OFFSET) {
 		*(.data.cacheline_aligned)
 	}
 
 	. = ALIGN(L1_CACHE_BYTES);
-	.data.read_mostly : {
+	.data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) {
 		*(.data.read_mostly)
 	}
 
 	. = ALIGN(PAGE_SIZE);
-	__data_nosave : {
+	.data_nosave : AT(ADDR(.data_nosave) - LOAD_OFFSET) {
 		__nosave_begin = .;
 		*(.data.nosave)
 		. = ALIGN(PAGE_SIZE);
@@ -235,7 +234,7 @@ SECTIONS
  * And finally the bss
  */
 
-	.bss : {
+	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
 		__bss_start = .;
 		*(.sbss) *(.scommon)
 		*(.dynbss)
diff --git a/include/asm-powerpc/page.h b/include/asm-powerpc/page.h
index df47bbb..6c85060 100644
--- a/include/asm-powerpc/page.h
+++ b/include/asm-powerpc/page.h
@@ -53,6 +53,7 @@
 
 #define PAGE_OFFSET     ASM_CONST(CONFIG_KERNEL_START)
 #define KERNELBASE      (PAGE_OFFSET + PHYSICAL_START)
+#define LOAD_OFFSET	PAGE_OFFSET
 
 #ifdef CONFIG_FLATMEM
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
-- 
1.5.4.1

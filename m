Return-Path: <sfr@canb.auug.org.au>
Date: Sat, 1 Oct 2005 00:10:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20051001001005.348d7798.sfr@canb.auug.org.au>
In-Reply-To: <20050930233602.138b6e27.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 8/9] powerpc: make iSeries build
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also Merge vmlinux.lds.S and remove arch/powerpc/kernel/vmlinux.lds which
is a generated file.

The merge of vmlinux.lds.S would be much cleaner if it is clear that
putting the ..start/end symbols inside the section definitions is OK on
ppc32.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/Kconfig                      |    6 +
 arch/powerpc/Makefile                     |   27 ++--
 arch/powerpc/kernel/Makefile              |    9 +
 arch/powerpc/kernel/vmlinux.lds           |  174 ---------------------------
 arch/powerpc/kernel/vmlinux.lds.S         |  190 +++++++++++++++++++++++++++--
 arch/powerpc/platforms/iseries/lpevents.c |    2 
 arch/ppc64/kernel/Makefile                |    8 -
 include/asm-powerpc/system.h              |    4 -
 8 files changed, 214 insertions(+), 206 deletions(-)
 delete mode 100644 arch/powerpc/kernel/vmlinux.lds

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

f0c094f719829a7a15cbbea72a33093b9a7dec5d
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -833,6 +833,12 @@ config PIN_TLB
 	depends on ADVANCED_OPTIONS && 8xx
 endmenu
 
+if PPC64
+config KERNEL_START
+	hex
+	default "0xc0000000"
+endif
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -124,12 +124,14 @@ head-$(CONFIG_6xx)		+= arch/powerpc/kern
 head-$(CONFIG_PPC_FPU)		+= arch/powerpc/kernel/fpu.o
 endif
 
-core-y				+= arch/powerpc/kernel/ \
-				   arch/$(OLDARCH)/kernel/ \
-				   arch/powerpc/mm/ \
-				   arch/powerpc/lib/ \
-				   arch/powerpc/sysdev/ \
-				   arch/powerpc/platforms/
+core-y				+= arch/powerpc/kernel/
+core-y				+= arch/$(OLDARCH)/kernel/
+core-$(CONFIG_PPC32)		+= arch/powerpc/mm/
+core-$(CONFIG_PPC64)		+= arch/$(OLDARCH)/mm/
+core-$(CONFIG_PPC32)		+= arch/powerpc/lib/
+libs-$(CONFIG_PPC64)		+= arch/$(OLDARCH)/lib/
+core-y				+= arch/powerpc/sysdev/
+core-y				+= arch/powerpc/platforms/
 core-$(CONFIG_PPC32)		+= arch/ppc/syslib/
 core-$(CONFIG_MATH_EMULATION)	+= arch/ppc/math-emu/
 core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
@@ -140,17 +142,20 @@ drivers-$(CONFIG_CPM2)		+= arch/ppc/8260
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
-BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
-
-.PHONY: $(BOOT_TARGETS)
-
-all: uImage zImage
+defaultimage-$(CONFIG_PPC32)	:= uImage zImage
+defaultimage-$(CONFIG_PPC_ISERIES) := vmlinux
+KBUILD_IMAGE := $(defaultimage-y)
+all: $(KBUILD_IMAGE)
 
 CPPFLAGS_vmlinux.lds	:= -Upowerpc
 
 # All the instructions talk about "make bzImage".
 bzImage: zImage
 
+BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd vmlinux.sm
+
+.PHONY: $(BOOT_TARGETS)
+
 boot := arch/$(OLDARCH)/boot
 
 $(BOOT_TARGETS): vmlinux
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -6,8 +6,10 @@ ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS	+= -mno-minimal-toc
 endif
 
+ifeq ($(CONFIG_PPC32),y)
 extra-$(CONFIG_PPC_STD_MMU)	:= head.o
-extra_$(CONFIG_PPC64)		:= head_64.o
+endif
+extra-$(CONFIG_PPC64)		:= head_64.o
 extra-$(CONFIG_40x)		:= head_4xx.o
 extra-$(CONFIG_44x)		:= head_44x.o
 extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
@@ -23,3 +25,8 @@ ifeq ($(CONFIG_PPC32),y)
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 endif
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
+
+ifeq ($(CONFIG_PPC_ISERIES),y)
+arch/powerpc/kernel/head_64.o: arch/powerpc/platforms/iseries/lparmap.s
+AFLAGS_head_64.o += -Iarch/powerpc/platforms/iseries
+endif
diff --git a/arch/powerpc/kernel/vmlinux.lds b/arch/powerpc/kernel/vmlinux.lds
deleted file mode 100644
--- a/arch/powerpc/kernel/vmlinux.lds
+++ /dev/null
@@ -1,174 +0,0 @@
-/* Align . to a 8 byte boundary equals to maximum function alignment. */
-/* sched.text is aling to function alignment to secure we have same
- * address even at second ld pass when generating System.map */
-/* spinlock.text is aling to function alignment to secure we have same
- * address even at second ld pass when generating System.map */
-  /* DWARF debug sections.
-		Symbols in the DWARF debugging sections are relative to
-		the beginning of the section so we begin them at 0.  */
-  /* Stabs debugging sections.  */
-OUTPUT_ARCH(powerpc:common)
-jiffies = jiffies_64 + 4;
-SECTIONS
-{
-  /* Read-only sections, merged into text segment: */
-  . = + SIZEOF_HEADERS;
-  .interp : { *(.interp) }
-  .hash : { *(.hash) }
-  .dynsym : { *(.dynsym) }
-  .dynstr : { *(.dynstr) }
-  .rel.text : { *(.rel.text) }
-  .rela.text : { *(.rela.text) }
-  .rel.data : { *(.rel.data) }
-  .rela.data : { *(.rela.data) }
-  .rel.rodata : { *(.rel.rodata) }
-  .rela.rodata : { *(.rela.rodata) }
-  .rel.got : { *(.rel.got) }
-  .rela.got : { *(.rela.got) }
-  .rel.ctors : { *(.rel.ctors) }
-  .rela.ctors : { *(.rela.ctors) }
-  .rel.dtors : { *(.rel.dtors) }
-  .rela.dtors : { *(.rela.dtors) }
-  .rel.bss : { *(.rel.bss) }
-  .rela.bss : { *(.rela.bss) }
-  .rel.plt : { *(.rel.plt) }
-  .rela.plt : { *(.rela.plt) }
-/*  .init          : { *(.init)	} =0*/
-  .plt : { *(.plt) }
-  .text :
-  {
-    *(.text)
-    . = ALIGN(8); __sched_text_start = .; *(.sched.text) __sched_text_end = .;
-    . = ALIGN(8); __lock_text_start = .; *(.spinlock.text) __lock_text_end = .;
-    *(.fixup)
-    *(.got1)
-    __got2_start = .;
-    *(.got2)
-    __got2_end = .;
-  }
-  _etext = .;
-  PROVIDE (etext = .);
-  .rodata : AT(ADDR(.rodata) - 0) { *(.rodata) *(.rodata.*) *(__vermagic) } .rodata1 : AT(ADDR(.rodata1) - 0) { *(.rodata1) } .pci_fixup : AT(ADDR(.pci_fixup) - 0) { __start_pci_fixups_early = .; *(.pci_fixup_early) __end_pci_fixups_early = .; __start_pci_fixups_header = .; *(.pci_fixup_header) __end_pci_fixups_header = .; __start_pci_fixups_final = .; *(.pci_fixup_final) __end_pci_fixups_final = .; __start_pci_fixups_enable = .; *(.pci_fixup_enable) __end_pci_fixups_enable = .; } __ksymtab : AT(ADDR(__ksymtab) - 0) { __start___ksymtab = .; *(__ksymtab) __stop___ksymtab = .; } __ksymtab_gpl : AT(ADDR(__ksymtab_gpl) - 0) { __start___ksymtab_gpl = .; *(__ksymtab_gpl) __stop___ksymtab_gpl = .; } __kcrctab : AT(ADDR(__kcrctab) - 0) { __start___kcrctab = .; *(__kcrctab) __stop___kcrctab = .; } __kcrctab_gpl : AT(ADDR(__kcrctab_gpl) - 0) { __start___kcrctab_gpl = .; *(__kcrctab_gpl) __stop___kcrctab_gpl = .; } __ksymtab_strings : AT(ADDR(__ksymtab_strings) - 0) { *(__ksymtab_strings) } __param : AT(ADDR(__param) - 0) { __start___param = .; *(__param) __stop___param = .; }
-  .fini : { *(.fini) } =0
-  .ctors : { *(.ctors) }
-  .dtors : { *(.dtors) }
-  .fixup : { *(.fixup) }
- __ex_table : {
-  __start___ex_table = .;
-  *(__ex_table)
-  __stop___ex_table = .;
- }
- __bug_table : {
-  __start___bug_table = .;
-  *(__bug_table)
-  __stop___bug_table = .;
- }
-  /* Read-write section, merged into data segment: */
-  . = ALIGN(4096);
-  .data :
-  {
-    *(.data)
-    *(.data1)
-    *(.sdata)
-    *(.sdata2)
-    *(.got.plt) *(.got)
-    *(.dynamic)
-    CONSTRUCTORS
-  }
-
-  . = ALIGN(4096);
-  __nosave_begin = .;
-  .data_nosave : { *(.data.nosave) }
-  . = ALIGN(4096);
-  __nosave_end = .;
-
-  . = ALIGN(32);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  _edata = .;
-  PROVIDE (edata = .);
-
-  . = ALIGN(8192);
-  .data.init_task : { *(.data.init_task) }
-
-  . = ALIGN(4096);
-  __init_begin = .;
-  .init.text : {
- _sinittext = .;
- *(.init.text)
- _einittext = .;
-  }
-  /* .exit.text is discarded at runtime, not link time,
-     to deal with references from __bug_table */
-  .exit.text : { *(.exit.text) }
-  .init.data : {
-    *(.init.data);
-    __vtop_table_begin = .;
-    *(.vtop_fixup);
-    __vtop_table_end = .;
-    __ptov_table_begin = .;
-    *(.ptov_fixup);
-    __ptov_table_end = .;
-  }
-  . = ALIGN(16);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : {
- *(.initcall1.init)
- *(.initcall2.init)
- *(.initcall3.init)
- *(.initcall4.init)
- *(.initcall5.init)
- *(.initcall6.init)
- *(.initcall7.init)
-  }
-  __initcall_end = .;
-
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
-
-  .security_initcall.init : AT(ADDR(.security_initcall.init) - 0) { __security_initcall_start = .; *(.security_initcall.init) __security_initcall_end = .; }
-
-  __start___ftr_fixup = .;
-  __ftr_fixup : { *(__ftr_fixup) }
-  __stop___ftr_fixup = .;
-
-  . = ALIGN(32);
-  __per_cpu_start = .;
-  .data.percpu : { *(.data.percpu) }
-  __per_cpu_end = .;
-
-  . = ALIGN(4096);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
-  __initramfs_end = .;
-
-  . = ALIGN(4096);
-  __init_end = .;
-
-  . = ALIGN(4096);
-  _sextratext = .;
-  _eextratext = .;
-
-  __bss_start = .;
-  .bss :
-  {
-   *(.sbss) *(.scommon)
-   *(.dynbss)
-   *(.bss)
-   *(COMMON)
-  }
-  __bss_stop = .;
-
-  _end = . ;
-  PROVIDE (end = .);
-
-  /* Sections to be discarded. */
-  /DISCARD/ : {
-    *(.exitcall.exit)
-    *(.exit.data)
-  }
-}
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -1,10 +1,29 @@
+#include <linux/config.h>
+#ifdef CONFIG_PPC64
+#include <asm/page.h>
+#endif
 #include <asm-generic/vmlinux.lds.h>
 
+#ifdef CONFIG_PPC64
+OUTPUT_ARCH(powerpc:common64)
+jiffies = jiffies_64;
+#else
 OUTPUT_ARCH(powerpc:common)
 jiffies = jiffies_64 + 4;
+#endif
 SECTIONS
 {
+  /* Sections to be discarded. */
+  /DISCARD/ : {
+    *(.exitcall.exit)
+#ifdef CONFIG_PPC32
+    *(.exit.data)
+#endif
+  }
+
+
   /* Read-only sections, merged into text segment: */
+#ifdef CONFIG_PPC32
   . = + SIZEOF_HEADERS;
   .interp : { *(.interp) }
   .hash          : { *(.hash)		}
@@ -28,17 +47,30 @@ SECTIONS
   .rela.plt      : { *(.rela.plt)		}
 /*  .init          : { *(.init)	} =0*/
   .plt : { *(.plt) }
-  .text      :
-  {
+#endif
+  .text : {
+#ifdef CONFIG_PPC64
+    *(.text .text.*)
+#else
     *(.text)
+#endif
     SCHED_TEXT
     LOCK_TEXT
+#ifdef CONFIG_PPC64
+    KPROBES_TEXT
+#endif
     *(.fixup)
+#ifdef CONFIG_PPC32
     *(.got1)
     __got2_start = .;
     *(.got2)
     __got2_end = .;
+#else
+    . = ALIGN(PAGE_SIZE);
+    _etext = .;
+#endif
   }
+#ifdef CONFIG_PPC32
   _etext = .;
   PROVIDE (etext = .);
 
@@ -48,6 +80,7 @@ SECTIONS
   .dtors     : { *(.dtors)   }
 
   .fixup   : { *(.fixup) }
+#endif
 
 	__ex_table : {
 		__start___ex_table = .;
@@ -61,6 +94,17 @@ SECTIONS
 		__stop___bug_table = .;
 	}
 
+#ifdef CONFIG_PPC64
+	__ftr_fixup : {
+		__start___ftr_fixup = .;
+		*(__ftr_fixup)
+		__stop___ftr_fixup = .;
+	}
+
+  RODATA
+#endif
+
+#ifdef CONFIG_PPC32
   /* Read-write section, merged into data segment: */
   . = ALIGN(4096);
   .data    :
@@ -90,16 +134,25 @@ SECTIONS
   .data.init_task : { *(.data.init_task) }
 
   . = ALIGN(4096);
+#else
+  /* will be freed after init */
+  . = ALIGN(PAGE_SIZE);
+#endif
   __init_begin = .;
   .init.text : {
 	_sinittext = .;
 	*(.init.text)
 	_einittext = .;
   }
+#ifdef CONFIG_PPC32
   /* .exit.text is discarded at runtime, not link time,
      to deal with references from __bug_table */
   .exit.text : { *(.exit.text) }
+#endif
   .init.data : {
+#ifdef CONFIG_PPC64
+    *(.init.data)
+#else
     *(.init.data);
     __vtop_table_begin = .;
     *(.vtop_fixup);
@@ -107,13 +160,31 @@ SECTIONS
     __ptov_table_begin = .;
     *(.ptov_fixup);
     __ptov_table_end = .;
+#endif
   }
+
   . = ALIGN(16);
+#ifdef CONFIG_PPC32
   __setup_start = .;
-  .init.setup : { *(.init.setup) }
+#endif
+  .init.setup : {
+#ifdef CONFIG_PPC64
+    __setup_start = .;
+#endif
+    *(.init.setup)
+#ifdef CONFIG_PPC64
+    __setup_end = .;
+#endif
+  }
+#ifdef CONFIG_PPC32
   __setup_end = .;
+
   __initcall_start = .;
+#endif
   .initcall.init : {
+#ifdef CONFIG_PPC64
+	__initcall_start = .;
+#endif
 	*(.initcall1.init)
 	*(.initcall2.init)
 	*(.initcall3.init)
@@ -121,27 +192,109 @@ SECTIONS
 	*(.initcall5.init)
 	*(.initcall6.init)
 	*(.initcall7.init)
+#ifdef CONFIG_PPC64
+	__initcall_end = .;
+#endif
   }
+#ifdef CONFIG_PPC32
   __initcall_end = .;
 
   __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
+#endif
+  .con_initcall.init : {
+#ifdef CONFIG_PPC64
+    __con_initcall_start = .;
+#endif
+    *(.con_initcall.init)
+#ifdef CONFIG_PPC64
+    __con_initcall_end = .;
+#endif
+  }
+#ifdef CONFIG_PPC32
   __con_initcall_end = .;
+#endif
 
   SECURITY_INIT
 
+#ifdef CONFIG_PPC32
   __start___ftr_fixup = .;
   __ftr_fixup : { *(__ftr_fixup) }
   __stop___ftr_fixup = .;
+#else
+  . = ALIGN(PAGE_SIZE);
+  .init.ramfs : {
+    __initramfs_start = .;
+    *(.init.ramfs)
+    __initramfs_end = .;
+  }
+#endif
 
+#ifdef CONFIG_PPC32
   . = ALIGN(32);
   __per_cpu_start = .;
-  .data.percpu  : { *(.data.percpu) }
+#endif
+  .data.percpu : {
+#ifdef CONFIG_PPC64
+    __per_cpu_start = .;
+#endif
+    *(.data.percpu)
+#ifdef CONFIG_PPC64
+    __per_cpu_end = .;
+#endif
+  }
+#ifdef CONFIG_PPC32
   __per_cpu_end = .;
+#endif
+
+#ifdef CONFIG_PPC64
+ . = ALIGN(PAGE_SIZE);
+ . = ALIGN(16384);
+ __init_end = .;
+ /* freed after init ends here */
+
+
+ /* Read/write sections */
+ . = ALIGN(PAGE_SIZE);
+ . = ALIGN(16384);
+ /* The initial task and kernel stack */
+ .data.init_task : {
+      *(.data.init_task)
+      }
+
+ . = ALIGN(PAGE_SIZE);
+ .data.page_aligned : {
+      *(.data.page_aligned)
+      }
+
+ .data.cacheline_aligned : {
+      *(.data.cacheline_aligned)
+      }
+
+ .data : {
+      *(.data .data.rel* .toc1)
+      *(.branch_lt)
+      }
+
+ .opd : {
+      *(.opd)
+      }
+
+ .got : {
+      __toc_start = .;
+      *(.got)
+      *(.toc)
+      . = ALIGN(PAGE_SIZE);
+      _edata = .;
+      }
 
+
+  . = ALIGN(PAGE_SIZE);
+#else
   . = ALIGN(4096);
   __initramfs_start = .;
-  .init.ramfs : { *(.init.ramfs) }
+  .init.ramfs : {
+    *(.init.ramfs)
+  }
   __initramfs_end = .;
 
   . = ALIGN(4096);
@@ -152,21 +305,30 @@ SECTIONS
   _eextratext = .;
 
   __bss_start = .;
-  .bss       :
-  {
+#endif
+  .bss : {
+#ifdef CONFIG_PPC64
+    __bss_start = .;
+#else
    *(.sbss) *(.scommon)
    *(.dynbss)
+#endif
    *(.bss)
+#ifdef CONFIG_PPC32
    *(COMMON)
+#else
+  __bss_stop = .;
+#endif
   }
+#ifdef CONFIG_PPC32
   __bss_stop = .;
+#endif
 
+#ifdef CONFIG_PPC64
+  . = ALIGN(PAGE_SIZE);
+#endif
   _end = . ;
+#ifdef CONFIG_PPC32
   PROVIDE (end = .);
-
-  /* Sections to be discarded. */
-  /DISCARD/ : {
-    *(.exitcall.exit)
-    *(.exit.data)
-  }
+#endif
 }
diff --git a/arch/powerpc/platforms/iseries/lpevents.c b/arch/powerpc/platforms/iseries/lpevents.c
--- a/arch/powerpc/platforms/iseries/lpevents.c
+++ b/arch/powerpc/platforms/iseries/lpevents.c
@@ -13,6 +13,8 @@
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
+#include <linux/module.h>
+
 #include <asm/system.h>
 #include <asm/paca.h>
 #include <asm/iSeries/ItLpQueue.h>
diff --git a/arch/ppc64/kernel/Makefile b/arch/ppc64/kernel/Makefile
--- a/arch/ppc64/kernel/Makefile
+++ b/arch/ppc64/kernel/Makefile
@@ -2,10 +2,10 @@
 # Makefile for the linux ppc64 kernel.
 #
 
-ifneq ($(CONFIG_PPC_MERGE),y)
-
 EXTRA_CFLAGS	+= -mno-minimal-toc
+ifneq ($(CONFIG_PPC_MERGE),y)
 extra-y		:= head.o vmlinux.lds
+endif
 
 obj-y               :=	setup.o entry.o irq.o idle.o dma.o \
 			time.o process.o signal.o syscalls.o misc.o ptrace.o \
@@ -70,11 +70,9 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o
 
 CFLAGS_ioctl32.o += -Ifs/
 
+ifneq ($(CONFIG_PPC_MERGE),y)
 ifeq ($(CONFIG_PPC_ISERIES),y)
 arch/ppc64/kernel/head.o: arch/powerpc/platforms/iseries/lparmap.s
 AFLAGS_head.o += -Iarch/powerpc/platforms/iseries
 endif
-
-else
-
 endif
diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -118,10 +118,10 @@ extern void _set_L3CR(unsigned long);
 #endif
 
 extern void via_cuda_init(void);
-extern void pmac_nvram_init(void);
 extern void read_rtc_time(void);
 extern void pmac_find_display(void);
 extern void giveup_fpu(struct task_struct *);
+extern void disable_kernel_fp(void);
 extern void enable_kernel_fp(void);
 extern void flush_fp_to_thread(struct task_struct *);
 extern void enable_kernel_altivec(void);
@@ -346,5 +346,7 @@ __cmpxchg(volatile void *ptr, unsigned l
 
 #define arch_align_stack(x) (x)
 
+extern unsigned long reloc_offset(void);
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_SYSTEM_H */

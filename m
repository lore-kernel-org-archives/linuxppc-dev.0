Return-Path: <suzuki@in.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E0C1F100A17
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 19:58:53 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Thu, 15 Dec 2011 14:28:49 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBF8wFUU2732064
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 14:28:15 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBF8wCUT002195
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2011 14:28:14 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v5 3/7] [ppc] Process dynamic relocations for kernel
To: Josh Boyer <jwboyer@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 15 Dec 2011 14:28:12 +0530
Message-ID: <20111215085803.3404.74963.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111215085516.3404.56377.stgit@suzukikp.in.ibm.com>
References: <20111215085516.3404.56377.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Scott Wood <scottwood@freescale.com>,
 Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch implements the dynamic relocation processing for
PPC32 kernel. relocate() accepts the target virtual address and relocates
 the kernel image to the same.

Currently the following relocation types are handled :

	R_PPC_RELATIVE
	R_PPC_ADDR16_LO
	R_PPC_ADDR16_HI
	R_PPC_ADDR16_HA

The last 3 relocations in the above list depends on value of Symbol indexed
whose index is encoded in the Relocation entry. Hence we need the Symbol
Table for processing such relocations.

Note: The GNU ld for ppc32 produces buggy relocations for relocation types
that depend on symbols. The value of the symbols with STB_LOCAL scope
should be assumed to be zero. - Alan Modra

Changes since V4:

 ( Suggested by: Segher Boessenkool <segher@kernel.crashing.org>: )
 * Added 'sync' between dcbst and icbi for the modified instruction in
   relocate().
 * Replaced msync with sync.
 * Better comments on register usage in relocate().
 * Better check for relocation types in relocs_check.pl

Changes since V3:
 * Updated relocation types for ppc in arch/powerpc/relocs_check.pl

Changes since v2:
  * Flush the d-cache'd instructions and invalidate the i-cache to reflect
the processed instructions.(Reported by: Josh Poimboeuf)

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Modra <amodra@au1.ibm.com>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/Kconfig              |   41 ++++---
 arch/powerpc/Makefile             |    6 +
 arch/powerpc/kernel/Makefile      |    2 
 arch/powerpc/kernel/reloc_32.S    |  208 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S |    8 +
 arch/powerpc/relocs_check.pl      |   14 ++
 6 files changed, 256 insertions(+), 23 deletions(-)
 create mode 100644 arch/powerpc/kernel/reloc_32.S

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5eafe95..33b1c8c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -843,23 +843,30 @@ config DYNAMIC_MEMSTART
 	  load address. When this option is enabled, the compile time physical 
 	  address CONFIG_PHYSICAL_START is ignored.
 
-# Mapping based RELOCATABLE is moved to DYNAMIC_MEMSTART
-# config RELOCATABLE
-#	bool "Build a relocatable kernel (EXPERIMENTAL)"
-#	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && (FSL_BOOKE || PPC_47x)
-#	help
-#	  This builds a kernel image that is capable of running at the
-#	  location the kernel is loaded at, without any alignment restrictions.
-#
-#	  One use is for the kexec on panic case where the recovery kernel
-#	  must live at a different physical address than the primary
-#	  kernel.
-#
-#	  Note: If CONFIG_RELOCATABLE=y, then the kernel runs from the address
-#	  it has been loaded at and the compile time physical addresses
-#	  CONFIG_PHYSICAL_START is ignored.  However CONFIG_PHYSICAL_START
-#	  setting can still be useful to bootwrappers that need to know the
-#	  load location of the kernel (eg. u-boot/mkimage).
+	  This option is overridden by CONFIG_RELOCATABLE
+
+config RELOCATABLE
+	bool "Build a relocatable kernel (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM
+	select NONSTATIC_KERNEL
+	help
+	  This builds a kernel image that is capable of running at the
+	  location the kernel is loaded at, without any alignment restrictions.
+	  This feature is a superset of DYNAMIC_MEMSTART and hence overrides it.
+
+	  One use is for the kexec on panic case where the recovery kernel
+	  must live at a different physical address than the primary
+	  kernel.
+
+	  Note: If CONFIG_RELOCATABLE=y, then the kernel runs from the address
+	  it has been loaded at and the compile time physical addresses
+	  CONFIG_PHYSICAL_START is ignored.  However CONFIG_PHYSICAL_START
+	  setting can still be useful to bootwrappers that need to know the
+	  load address of the kernel (eg. u-boot/mkimage).
+
+config RELOCATABLE_PPC32
+	def_bool y
+	depends on PPC32 && RELOCATABLE
 
 config PAGE_OFFSET_BOOL
 	bool "Set custom page offset address"
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ffe4d88..b8b105c 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -63,9 +63,9 @@ override CC	+= -m$(CONFIG_WORD_SIZE)
 override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-powerpc $(AR)
 endif
 
-LDFLAGS_vmlinux-yy := -Bstatic
-LDFLAGS_vmlinux-$(CONFIG_PPC64)$(CONFIG_RELOCATABLE) := -pie
-LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-yy)
+LDFLAGS_vmlinux-y := -Bstatic
+LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
+LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
 
 CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=no -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 -mmultiple
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index ce4f7f1..ee728e4 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -85,6 +85,8 @@ extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-y				+= vmlinux.lds
 
+obj-$(CONFIG_RELOCATABLE_PPC32)	+= reloc_32.o
+
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
 obj-$(CONFIG_PPC64)		+= dma-iommu.o iommu.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
diff --git a/arch/powerpc/kernel/reloc_32.S b/arch/powerpc/kernel/reloc_32.S
new file mode 100644
index 0000000..ef46ba6
--- /dev/null
+++ b/arch/powerpc/kernel/reloc_32.S
@@ -0,0 +1,208 @@
+/*
+ * Code to process dynamic relocations for PPC32.
+ *
+ * Copyrights (C) IBM Corporation, 2011.
+ *	Author: Suzuki Poulose <suzuki@in.ibm.com>
+ *
+ *  - Based on ppc64 code - reloc_64.S
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/ppc_asm.h>
+
+/* Dynamic section table entry tags */
+DT_RELA = 7			/* Tag for Elf32_Rela section */
+DT_RELASZ = 8			/* Size of the Rela relocs */
+DT_RELAENT = 9			/* Size of one Rela reloc entry */
+
+STN_UNDEF = 0			/* Undefined symbol index */
+STB_LOCAL = 0			/* Local binding for the symbol */
+
+R_PPC_ADDR16_LO = 4		/* Lower half of (S+A) */
+R_PPC_ADDR16_HI = 5		/* Upper half of (S+A) */
+R_PPC_ADDR16_HA = 6		/* High Adjusted (S+A) */
+R_PPC_RELATIVE = 22
+
+/*
+ * r3 = desired final address
+ */
+
+_GLOBAL(relocate)
+
+	mflr	r0		/* Save our LR */
+	bl	0f		/* Find our current runtime address */
+0:	mflr	r12		/* Make it accessible */
+	mtlr	r0
+
+	lwz	r11, (p_dyn - 0b)(r12)
+	add	r11, r11, r12	/* runtime address of .dynamic section */
+	lwz	r9, (p_rela - 0b)(r12)
+	add	r9, r9, r12	/* runtime address of .rela.dyn section */
+	lwz	r10, (p_st - 0b)(r12)
+	add	r10, r10, r12	/* runtime address of _stext section */
+	lwz	r13, (p_sym - 0b)(r12)
+	add	r13, r13, r12	/* runtime address of .dynsym section */
+
+	/*
+	 * Scan the dynamic section for RELA, RELASZ entries
+	 */
+	li	r6, 0
+	li	r7, 0
+	li	r8, 0
+1:	lwz	r5, 0(r11)	/* ELF_Dyn.d_tag */
+	cmpwi	r5, 0		/* End of ELF_Dyn[] */
+	beq	eodyn
+	cmpwi	r5, DT_RELA
+	bne	relasz
+	lwz	r7, 4(r11)	/* r7 = rela.link */
+	b	skip
+relasz:
+	cmpwi	r5, DT_RELASZ
+	bne	relaent
+	lwz	r8, 4(r11)	/* r8 = Total Rela relocs size */
+	b	skip
+relaent:
+	cmpwi	r5, DT_RELAENT
+	bne	skip
+	lwz	r6, 4(r11)	/* r6 = Size of one Rela reloc */
+skip:
+	addi	r11, r11, 8
+	b	1b
+eodyn:				/* End of Dyn Table scan */
+
+	/* Check if we have found all the entries */
+	cmpwi	r7, 0
+	beq	done
+	cmpwi	r8, 0
+	beq	done
+	cmpwi	r6, 0
+	beq	done
+
+
+	/*
+	 * Work out the current offset from the link time address of .rela
+	 * section.
+	 *  cur_offset[r7] = rela.run[r9] - rela.link [r7]
+	 *  _stext.link[r12] = _stext.run[r10] - cur_offset[r7]
+	 *  final_offset[r3] = _stext.final[r3] - _stext.link[r12]
+	 */
+	subf	r7, r7, r9	/* cur_offset */
+	subf	r12, r7, r10
+	subf	r3, r12, r3	/* final_offset */
+
+	subf	r8, r6, r8	/* relaz -= relaent */
+	/*
+	 * Scan through the .rela table and process each entry
+	 * r9	- points to the current .rela table entry
+	 * r13	- points to the symbol table
+	 */
+
+	/*
+	 * Check if we have a relocation based on symbol
+	 * r5 will hold the value of the symbol.
+	 */
+applyrela:
+	lwz	r4, 4(r9)		/* r4 = rela.r_info */
+	srwi	r5, r4, 8		/* ELF32_R_SYM(r_info) */
+	cmpwi	r5, STN_UNDEF	/* sym == STN_UNDEF ? */
+	beq	get_type	/* value = 0 */
+	/* Find the value of the symbol at index(r5) */
+	slwi	r5, r5, 4		/* r5 = r5 * sizeof(Elf32_Sym) */
+	add	r12, r13, r5	/* r12 = &__dyn_sym[Index] */
+
+	/*
+	 * GNU ld has a bug, where dynamic relocs based on
+	 * STB_LOCAL symbols, the value should be assumed
+	 * to be zero. - Alan Modra
+	 */
+	/* XXX: Do we need to check if we are using GNU ld ? */
+	lbz	r5, 12(r12)	/* r5 = dyn_sym[Index].st_info */
+	extrwi	r5, r5, 4, 24	/* r5 = ELF32_ST_BIND(r5) */
+	cmpwi	r5, STB_LOCAL	/* st_value = 0, ld bug */
+	beq	get_type	/* We have r5 = 0 */
+	lwz	r5, 4(r12)	/* r5 = __dyn_sym[Index].st_value */
+
+get_type:
+	/* Load the relocation type to r4 */
+	extrwi	r4, r4, 8, 24	/* r4 = ELF32_R_TYPE(r_info) = ((char*)r4)[3] */
+
+	/* R_PPC_RELATIVE */
+	cmpwi	r4, R_PPC_RELATIVE
+	bne	hi16
+	lwz	r4, 0(r9)	/* r_offset */
+	lwz	r0, 8(r9)	/* r_addend */
+	add	r0, r0, r3	/* final addend */
+	stwx	r0, r4, r7	/* memory[r4+r7]) = (u32)r0 */
+	b	nxtrela		/* continue */
+
+	/* R_PPC_ADDR16_HI */
+hi16:
+	cmpwi	r4, R_PPC_ADDR16_HI
+	bne	ha16
+	lwz	r4, 0(r9)	/* r_offset */
+	lwz	r0, 8(r9)	/* r_addend */
+	add	r0, r0, r3
+	add	r0, r0, r5	/* r0 = (S+A+Offset) */
+	extrwi	r0, r0, 16, 0	/* r0 = (r0 >> 16) */
+	b	store_half
+
+	/* R_PPC_ADDR16_HA */
+ha16:
+	cmpwi	r4, R_PPC_ADDR16_HA
+	bne	lo16
+	lwz	r4, 0(r9)	/* r_offset */
+	lwz	r0, 8(r9)	/* r_addend */
+	add	r0, r0, r3
+	add	r0, r0, r5	/* r0 = (S+A+Offset) */
+	extrwi	r5, r0, 1, 16	/* Extract bit 16 */
+	extrwi	r0, r0, 16, 0	/* r0 = (r0 >> 16) */
+	add	r0, r0, r5	/* Add it to r0 */
+	b	store_half
+
+	/* R_PPC_ADDR16_LO */
+lo16:
+	cmpwi	r4, R_PPC_ADDR16_LO
+	bne	nxtrela
+	lwz	r4, 0(r9)	/* r_offset */
+	lwz	r0, 8(r9)	/* r_addend */
+	add	r0, r0, r3
+	add	r0, r0, r5	/* r0 = (S+A+Offset) */
+	extrwi	r0, r0, 16, 16	/* r0 &= 0xffff */
+	/* Fall through to */
+
+	/* Store half word */
+store_half:
+	sthx	r0, r4, r7	/* memory[r4+r7] = (u16)r0 */
+
+nxtrela:
+	/*
+	 * We have to flush the modified instructions to the
+	 * main storage from the d-cache. And also, invalidate the
+	 * cached instructions in i-cache which has been modified.
+	 *
+	 * We delay the sync / isync operation till the end, since
+	 * we won't be executing the modified instructions until
+	 * we return from here.
+	 */
+	dcbst	r4,r7
+	sync			/* Ensure the data is flushed before icbi */
+	icbi	r4,r7
+	cmpwi	r8, 0		/* relasz = 0 ? */
+	ble	done
+	add	r9, r9, r6	/* move to next entry in the .rela table */
+	subf	r8, r6, r8	/* relasz -= relaent */
+	b	applyrela
+
+done:
+	sync			/* Wait for the flush to finish */
+	isync			/* Discard prefetched instructions */
+	blr
+
+p_dyn:		.long	__dynamic_start - 0b
+p_rela:		.long	__rela_dyn_start - 0b
+p_sym:		.long	__dynamic_symtab - 0b
+p_st:		.long	_stext - 0b
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 920276c..710a540 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -170,7 +170,13 @@ SECTIONS
 	}
 #ifdef CONFIG_RELOCATABLE
 	. = ALIGN(8);
-	.dynsym : AT(ADDR(.dynsym) - LOAD_OFFSET) { *(.dynsym) }
+	.dynsym : AT(ADDR(.dynsym) - LOAD_OFFSET)
+	{
+#ifdef CONFIG_RELOCATABLE_PPC32
+		__dynamic_symtab = .;
+#endif
+		*(.dynsym)
+	}
 	.dynstr : AT(ADDR(.dynstr) - LOAD_OFFSET) { *(.dynstr) }
 	.dynamic : AT(ADDR(.dynamic) - LOAD_OFFSET)
 	{
diff --git a/arch/powerpc/relocs_check.pl b/arch/powerpc/relocs_check.pl
index d257109..7f5b838 100755
--- a/arch/powerpc/relocs_check.pl
+++ b/arch/powerpc/relocs_check.pl
@@ -32,8 +32,18 @@ while (<FD>) {
 	next if (!/\s+R_/);
 
 	# These relocations are okay
-	next if (/R_PPC64_RELATIVE/ or /R_PPC64_NONE/ or
-	         /R_PPC64_ADDR64\s+mach_/);
+	# On PPC64:
+	# 	R_PPC64_RELATIVE, R_PPC64_NONE, R_PPC64_ADDR64
+	# On PPC:
+	# 	R_PPC_RELATIVE, R_PPC_ADDR16_HI, 
+	# 	R_PPC_ADDR16_HA,R_PPC_ADDR16_LO,
+	# 	R_PPC_NONE
+
+	next if (/\bR_PPC64_RELATIVE\b/ or /\bR_PPC64_NONE\b/ or
+	         /\bR_PPC64_ADDR64\s+mach_/);
+	next if (/\bR_PPC_ADDR16_LO\b/ or /\bR_PPC_ADDR16_HI\b/ or
+		 /\bR_PPC_ADDR16_HA\b/ or /\bR_PPC_RELATIVE\b/ or
+		 /\bR_PPC_NONE\b/);
 
 	# If we see this type of relcoation it's an idication that
 	# we /may/ be using an old version of binutils.

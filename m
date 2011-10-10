Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 12F3AB6F9B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 20:56:37 +1100 (EST)
Received: from /spool/local by au.ibm.com with XMail ESMTP
 for <linuxppc-dev@lists.ozlabs.org> from <suzuki@in.ibm.com>;
 Mon, 10 Oct 2011 10:52:09 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 p9A9tAGe1343584
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 20:55:10 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 p9A9t9NY003565
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 20:55:10 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH 1/3] [powerpc32] Process dynamic relocations for kernel
To: linux ppc dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 10 Oct 2011 15:25:03 +0530
Message-ID: <20111010095432.16589.32935.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
References: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michal Simek <monstr@monstr.eu>, tmarri@apm.com,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Alan Modra <amodra@au1.ibm.com>, Dave Hansen <dave@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>, Scott Wood <scottwood@freescale.com>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>
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

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Cc:	Paul Mackerras <paulus@samba.org>
Cc:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:	Alan Modra <amodra@au1.ibm.com>
Cc:	Kumar Gala <galak@kernel.crashing.org>
Cc:	Josh Boyer <jwboyer@gmail.com>
Cc:	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
---

 arch/powerpc/Kconfig              |    4 +
 arch/powerpc/kernel/Makefile      |    2 
 arch/powerpc/kernel/reloc_32.S    |  194 +++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S |    8 +-
 4 files changed, 207 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/kernel/reloc_32.S

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8523bd1..9eb2e60 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -859,6 +859,10 @@ config RELOCATABLE
 	  setting can still be useful to bootwrappers that need to know the
 	  load location of the kernel (eg. u-boot/mkimage).
 
+config RELOCATABLE_PPC32
+	def_bool y
+	depends on PPC32 && RELOCATABLE
+
 config PAGE_OFFSET_BOOL
 	bool "Set custom page offset address"
 	depends on ADVANCED_OPTIONS
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
index 0000000..045d61e
--- /dev/null
+++ b/arch/powerpc/kernel/reloc_32.S
@@ -0,0 +1,194 @@
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
+	mflr	r0
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
+	 *  _stext.link[r10] = _stext.run[r10] - cur_offset[r7]
+	 *  final_offset[r3] = _stext.final[r3] - _stext.link[r10]
+	 */
+	subf	r7, r7, r9	/* cur_offset */
+	subf	r10, r7, r10
+	subf	r3, r10, r3	/* final_offset */
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
+	lwz	r4, 4(r9)
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
+	/* r4 holds the relocation type */
+	extrwi	r4, r4, 8, 24	/* r4 = ((char*)r4)[3] */
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
+	cmpwi	r8, 0		/* relasz = 0 ? */
+	ble	done
+	add	r9, r9, r6	/* move to next entry in the .rela table */
+	subf	r8, r6, r8	/* relasz -= relaent */
+	b	applyrela
+
+done:	blr
+
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

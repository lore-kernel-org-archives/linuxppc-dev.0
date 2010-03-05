Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Fri, 5 Mar 2010 17:43:47 -0300
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100305204347.18424.1181.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
References: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
Subject: [PATCH 09/13] powerpc/476: Workaround for dcbf/dcbz workaround on DD1
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/476: Workaround for dcbf/dcbz workaround on DD1

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

On the DD1.1 core, the dcbf and dcbz instructions need to be preceded and
followed by an lwsync.  We must trap user-space to ensure that this occurs
there too.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/asm-compat.h |   10 +++++++
 arch/powerpc/include/asm/ppc-opcode.h |    4 +++
 arch/powerpc/include/asm/reg_booke.h  |    9 +++++++
 arch/powerpc/kernel/entry_32.S        |   35 +++++++++++++++++++++++---
 arch/powerpc/kernel/head_44x.S        |    9 +++++++
 arch/powerpc/kernel/misc_32.S         |   32 ++++++++++++++++++++++-
 arch/powerpc/kernel/traps.c           |   45 +++++++++++++++++++++++++++++++++
 arch/powerpc/lib/copy_32.S            |    7 ++++-
 8 files changed, 145 insertions(+), 6 deletions(-)


diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 8f0fe79..bee05ec 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -64,6 +64,16 @@
 #define PPC405_ERR77(ra,rb)
 #define PPC405_ERR77_SYNC
 #endif
+
+#ifdef CONFIG_PPC_47x
+#define PPC476_ERR_DCBx()			\
+	BEGIN_FTR_SECTION;			\
+		lwsync;				\
+	END_FTR_SECTION_IFSET(CPU_FTR_476_DD1_1)
+#else
+#define PPC476_ERR_DCBx()
+#endif /* CONFIG_PPC_47x */
+
 #endif
 
 #endif /* _ASM_POWERPC_ASM_COMPAT_H */
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index ef9aa84..629b1fe 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -19,6 +19,10 @@
 #define PPC_INST_DCBA			0x7c0005ec
 #define PPC_INST_DCBA_MASK		0xfc0007fe
 #define PPC_INST_DCBAL			0x7c2005ec
+#define PPC_INST_DCBF			0x7c0000ac
+#define PPC_INST_DCBF_MASK		0xfc0007fe
+#define PPC_INST_DCBZ			0x7c0007ec
+#define PPC_INST_DCBZ_MASK		0xfc0007fe
 #define PPC_INST_DCBZL			0x7c2007ec
 #define PPC_INST_ISEL			0x7c00001e
 #define PPC_INST_ISEL_MASK		0xfc00003e
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index ee61a9d..8153093 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -276,6 +276,8 @@
 #define ESR_IMCN	0x40000000	/* Instr. Machine Check - Non-config */
 #define ESR_IMCB	0x20000000	/* Instr. Machine Check - Bus error */
 #define ESR_IMCT	0x10000000	/* Instr. Machine Check - Timeout */
+#define ESR_POT1	0x20000000	/* 476 - IOCR1 trap */
+#define ESR_POT2	0x10000000	/* 476 - IOCR2 trap */
 #define ESR_PIL		0x08000000	/* Program Exception - Illegal */
 #define ESR_PPR		0x04000000	/* Program Exception - Privileged */
 #define ESR_PTR		0x02000000	/* Program Exception - Trap */
@@ -535,6 +537,13 @@
 #define MMUBE1_VBE3		0x00000004
 #define MMUBE1_VBE4		0x00000002
 #define MMUBE1_VBE5		0x00000001
+#define SPRN_IOCCR	860
+#define		IOCCR_IOCR1EN		0x80000000
+#define		IOCCR_IOCR1M		0x40000000
+#define		IOCCR_IOCR2EN		0x20000000
+#define		IOCCR_IOCR2M		0x10000000
+#define SPRN_IOCR1	861
+#define SPRN_IOCR2	862
 
 #endif /* __ASM_POWERPC_REG_BOOKE_H__ */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index ed4aeb9..57b7893 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -142,6 +142,12 @@ transfer_to_handler:
 	addi	r2,r12,-THREAD
 	tovirt(r2,r2)			/* set r2 to current */
 	beq	2f			/* if from user, fix up THREAD.regs */
+#ifdef CONFIG_PPC_47x
+BEGIN_FTR_SECTION
+	li	r11,0
+	mtspr	SPRN_IOCCR,r11
+END_FTR_SECTION_IFSET(CPU_FTR_476_DD1_1)
+#endif /* CONFIG_PPC_47x */
 	addi	r11,r1,STACK_FRAME_OVERHEAD
 	stw	r11,PT_REGS(r12)
 #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
@@ -280,6 +286,12 @@ stack_ovf:
 0:
 
 _GLOBAL(DoSyscall)
+#ifdef CONFIG_PPC_47x
+BEGIN_FTR_SECTION
+	li	r11,0
+	mtspr	SPRN_IOCCR,r11
+END_FTR_SECTION_IFSET(CPU_FTR_476_DD1_1)
+#endif /* CONFIG_PPC_47x */
 	stw	r3,ORIG_GPR3(r1)
 	li	r12,0
 	stw	r12,RESULT(r1)
@@ -381,6 +393,16 @@ BEGIN_MMU_FTR_SECTION
 1:
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_47x)
 #endif /* CONFIG_44x */
+#ifdef CONFIG_PPC_47x
+BEGIN_FTR_SECTION
+	lwz	r7,_MSR(r1)
+	andi.	r5,r7,MSR_PR
+	beq	11f
+	lis	r4,(IOCCR_IOCR1EN|IOCCR_IOCR2EN)@h
+	mtspr	SPRN_IOCCR,r4
+11:
+END_FTR_SECTION_IFSET(CPU_FTR_476_DD1_1)
+#endif /* CONFIG_PPC_47x */
 BEGIN_FTR_SECTION
 	lwarx	r7,0,r1
 END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
@@ -716,9 +738,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_SPE)
 fast_exception_return:
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 	andi.	r10,r9,MSR_RI		/* check for recoverable interrupt */
-	beq	1f			/* if not, we've got problems */
+	beq	try_recov_exception	/* if not, we've got problems */
 #endif
-
 2:	REST_4GPRS(3, r11)
 	lwz	r10,_CCR(r11)
 	REST_GPR(1, r11)
@@ -736,7 +757,8 @@ fast_exception_return:
 
 #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 /* check if the exception happened in a restartable section */
-1:	lis	r3,exc_exit_restart_end@ha
+try_recov_exception:
+	lis	r3,exc_exit_restart_end@ha
 	addi	r3,r3,exc_exit_restart_end@l
 	cmplw	r12,r3
 	bge	3f
@@ -809,6 +831,13 @@ restore_user:
 	andis.	r10,r0,DBCR0_IDM@h
 	bnel-	load_dbcr0
 #endif
+#ifdef CONFIG_PPC_47x
+BEGIN_FTR_SECTION
+	lis	r0,(IOCCR_IOCR1EN|IOCCR_IOCR2EN)@h
+	mtspr	SPRN_IOCCR,r0
+1:
+END_FTR_SECTION_IFSET(CPU_FTR_476_DD1_1)
+#endif /* CONFIG_PPC_47x */
 
 #ifdef CONFIG_PREEMPT
 	b	restore
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index af3a9e1..a96796d 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -1113,6 +1113,15 @@ clear_utlb_entry:
 	mtspr	SPRN_CCR0,r3
 	isync
 
+	/* XXX DD1.1 workaround, trap on dcbz & dcbf. We pre-configure
+	 *     IOCR1 and 2 but we don't enable them in IOCCR, this will
+	 *     be done on kernel entry/exit
+	 */
+	LOAD_REG_IMMEDIATE(r3, (31 << 26) | (  86 << 1))	/* dcbf */
+	LOAD_REG_IMMEDIATE(r4, (31 << 26) | (1014 << 1))	/* dcbz */
+	mtspr	SPRN_IOCR1, r3
+	mtspr	SPRN_IOCR2, r4
+
 #endif /* CONFIG_PPC_47x */
 
 /*
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 8043d1b..db6b115 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -393,7 +393,9 @@ _GLOBAL(flush_dcache_range)
 	beqlr
 	mtctr	r4
 
-1:	dcbf	0,r3
+1:	PPC476_ERR_DCBx()
+	dcbf	0,r3
+	PPC476_ERR_DCBx()
 	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	1b
 	sync				/* wait for dcbst's to get to ram */
@@ -507,7 +509,9 @@ _GLOBAL(clear_pages)
 	li	r0,PAGE_SIZE/L1_CACHE_BYTES
 	slw	r0,r0,r4
 	mtctr	r0
-1:	dcbz	0,r3
+1:	PPC476_ERR_DCBx()
+	dcbz	0,r3
+	PPC476_ERR_DCBx()
 	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	1b
 	blr
@@ -551,7 +555,9 @@ _GLOBAL(copy_page)
 	mtctr	r0
 1:
 	dcbt	r11,r4
+	PPC476_ERR_DCBx()
 	dcbz	r5,r3
+	PPC476_ERR_DCBx()
 	COPY_16_BYTES
 #if L1_CACHE_BYTES >= 32
 	COPY_16_BYTES
@@ -807,3 +813,25 @@ relocate_new_kernel_end:
 relocate_new_kernel_size:
 	.long relocate_new_kernel_end - relocate_new_kernel
 #endif
+
+#ifdef CONFIG_PPC_47x
+_GLOBAL(__dcbf)
+	lwsync
+1:	dcbf	0,r3
+	lwsync
+	li	r3,0
+	blr
+_GLOBAL(__dcbz)
+	lwsync
+2:	dcbz	0,r3
+	lwsync
+	li	r3,0
+	blr
+3:	li	r3,-EFAULT
+	blr
+	.section __ex_table,"a"
+	.align	2
+	.long	1b,3b
+	.long	2b,3b
+	.text
+#endif /* CONFIG_PPC_47x */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 9957c44..2f89c7f 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -772,6 +772,31 @@ static int emulate_isel(struct pt_regs *regs, u32 instword)
 	return 0;
 }
 
+#ifdef CONFIG_PPC_47x
+
+extern int __dcbf(unsigned long ea);
+extern int __dcbz(unsigned long ea);
+
+static int emulate_dcbf(struct pt_regs *regs, u32 instword)
+{
+	u8 rA = (instword >> 16) & 0x1f;
+	u8 rB = (instword >> 11) & 0x1f;
+	unsigned long ea = regs->gpr[rB] + ((rA == 0) ? 0 : regs->gpr[rA]);
+
+	return __dcbf(ea);
+}
+
+static int emulate_dcbz(struct pt_regs *regs, u32 instword)
+{
+	u8 rA = (instword >> 16) & 0x1f;
+	u8 rB = (instword >> 11) & 0x1f;
+	unsigned long ea = regs->gpr[rB] + ((rA == 0) ? 0 : regs->gpr[rA]);
+
+	return __dcbz(ea);
+}
+
+#endif /* CONFIG_PPC_47x */
+
 static int emulate_instruction(struct pt_regs *regs)
 {
 	u32 instword;
@@ -827,6 +852,18 @@ static int emulate_instruction(struct pt_regs *regs)
 		return emulate_isel(regs, instword);
 	}
 
+#ifdef CONFIG_PPC_47x
+	/* Emulate dcbf instruction */
+	if ((instword & PPC_INST_DCBF_MASK) == PPC_INST_DCBF) {
+		return emulate_dcbf(regs, instword);
+	}
+
+	/* Emulate dcbz instruction */
+	if ((instword & PPC_INST_DCBZ_MASK) == PPC_INST_DCBZ) {
+		return emulate_dcbz(regs, instword);
+	}
+#endif /* CONFIG_47x */
+
 	return -EINVAL;
 }
 
@@ -842,6 +879,14 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 
 	/* We can now get here via a FP Unavailable exception if the core
 	 * has no FPU, in that case the reason flags will be 0 */
+#ifdef CONFIG_PPC_47x
+	/* Make IOC instruction traps look like illegal instructions
+	 * so we hit the proper emulation code path
+	 */
+	if (mmu_has_feature(MMU_FTR_TYPE_47x) &&
+	    (reason & (ESR_POT1 | ESR_POT2)))
+		reason |= ESR_PIL;
+#endif /* CONFIG_PPC_47x */
 
 	if (reason & REASON_FP) {
 		/* IEEE FP exception */
diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
index 74a7f41..d649609 100644
--- a/arch/powerpc/lib/copy_32.S
+++ b/arch/powerpc/lib/copy_32.S
@@ -12,6 +12,7 @@
 #include <asm/cache.h>
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
+#include <asm/cputable.h>
 
 #define COPY_16_BYTES		\
 	lwz	r7,4(r4);	\
@@ -98,7 +99,9 @@ _GLOBAL(cacheable_memzero)
 	bdnz	4b
 3:	mtctr	r9
 	li	r7,4
-10:	dcbz	r7,r6
+10:	PPC476_ERR_DCBx()
+	dcbz	r7,r6
+	PPC476_ERR_DCBx()
 	addi	r6,r6,CACHELINE_BYTES
 	bdnz	10b
 	clrlwi	r5,r8,32-LG_CACHELINE_BYTES
@@ -368,7 +371,9 @@ _GLOBAL(__copy_tofrom_user)
 	mtctr	r8
 
 53:	dcbt	r3,r4
+	PPC476_ERR_DCBx()
 54:	dcbz	r11,r6
+	PPC476_ERR_DCBx()
 	.section __ex_table,"a"
 	.align	2
 	.long	54b,105f

-- 
Dave Kleikamp
IBM Linux Technology Center

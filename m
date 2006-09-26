Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5359167C26
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 13:42:48 +1000 (EST)
Date: Tue, 26 Sep 2006 13:42:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 7/7] [POWERPC] implement BEGIN/END_FW_FTR_SECTION
Message-Id: <20060926134222.9e035cc8.sfr@canb.auug.org.au>
In-Reply-To: <20060926134008.45905bff.sfr@canb.auug.org.au>
References: <20060926133413.8ca8142e.sfr@canb.auug.org.au>
	<20060926133548.43afd711.sfr@canb.auug.org.au>
	<20060926133651.897ad602.sfr@canb.auug.org.au>
	<20060926133756.071a981f.sfr@canb.auug.org.au>
	<20060926133910.23948614.sfr@canb.auug.org.au>
	<20060926134008.45905bff.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

and use it an all the obvious places in assembler code.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/entry_64.S    |   18 +++++++---
 arch/powerpc/kernel/head_64.S     |   28 ++++++++++++++-
 arch/powerpc/kernel/misc_64.S     |   46 +++++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S |    8 ++++
 arch/powerpc/mm/slb_low.S         |    3 ++
 include/asm-powerpc/firmware.h    |   67 ++++++++++++++++++++++++-------------
 6 files changed, 137 insertions(+), 33 deletions(-)

This has been booted as a combined kernel on iSeries (and also as just an
iSeries build).
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2cd872b..748e74f 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -27,10 +27,7 @@ #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/cputable.h>
-
-#ifdef CONFIG_PPC_ISERIES
-#define DO_SOFT_DISABLE
-#endif
+#include <asm/firmware.h>
 
 /*
  * System calls.
@@ -91,6 +88,7 @@ system_call_common:
 	ld	r11,exception_marker@toc(r2)
 	std	r11,-16(r9)		/* "regshere" marker */
 #ifdef CONFIG_PPC_ISERIES
+BEGIN_FW_FTR_SECTION
 	/* Hack for handling interrupts when soft-enabling on iSeries */
 	cmpdi	cr1,r0,0x5555		/* syscall 0x5555 */
 	andi.	r10,r12,MSR_PR		/* from kernel */
@@ -98,6 +96,7 @@ #ifdef CONFIG_PPC_ISERIES
 	beq	hardware_interrupt_entry
 	lbz	r10,PACAPROCENABLED(r13)
 	std	r10,SOFTE(r1)
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
 	mfmsr	r11
 	ori	r11,r11,MSR_EE
@@ -462,6 +461,7 @@ #endif
 
 restore:
 #ifdef CONFIG_PPC_ISERIES
+BEGIN_FW_FTR_SECTION
 	ld	r5,SOFTE(r1)
 	cmpdi	0,r5,0
 	beq	4f
@@ -480,6 +480,7 @@ #ifdef CONFIG_PPC_ISERIES
 	b	.ret_from_except_lite		/* loop back and handle more */
 
 4:	stb	r5,PACAPROCENABLED(r13)
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
 
 	ld	r3,_MSR(r1)
@@ -538,18 +539,23 @@ #ifdef CONFIG_PREEMPT
 	lwz	r8,TI_PREEMPT(r9)
 	cmpwi	cr1,r8,0
 #ifdef CONFIG_PPC_ISERIES
+BEGIN_FW_FTR_SECTION
 	ld	r0,SOFTE(r1)
 	cmpdi	r0,0
-#else
-	andi.	r0,r3,MSR_EE
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
+BEGIN_FW_FTR_SECTION
+	andi.	r0,r3,MSR_EE
+END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
 	crandc	eq,cr1*4+eq,eq
 	bne	restore
 	/* here we are preempting the current task */
 1:
 #ifdef CONFIG_PPC_ISERIES
+BEGIN_FW_FTR_SECTION
 	li	r0,1
 	stb	r0,PACAPROCENABLED(r13)
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
 	ori	r10,r10,MSR_EE
 	mtmsrd	r10,1		/* reenable interrupts */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 3065b47..645c7f1 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -33,6 +33,7 @@ #include <asm/setup.h>
 #include <asm/hvcall.h>
 #include <asm/iseries/lpar_map.h>
 #include <asm/thread_info.h>
+#include <asm/firmware.h>
 
 #ifdef CONFIG_PPC_ISERIES
 #define DO_SOFT_DISABLE
@@ -365,19 +366,28 @@ label##_iSeries:							\
 
 #ifdef DO_SOFT_DISABLE
 #define DISABLE_INTS				\
+BEGIN_FW_FTR_SECTION;				\
 	lbz	r10,PACAPROCENABLED(r13);	\
 	li	r11,0;				\
 	std	r10,SOFTE(r1);			\
 	mfmsr	r10;				\
 	stb	r11,PACAPROCENABLED(r13);	\
 	ori	r10,r10,MSR_EE;			\
-	mtmsrd	r10,1
+	mtmsrd	r10,1;				\
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 
 #define ENABLE_INTS				\
+BEGIN_FW_FTR_SECTION;				\
 	lbz	r10,PACAPROCENABLED(r13);	\
 	mfmsr	r11;				\
 	std	r10,SOFTE(r1);			\
 	ori	r11,r11,MSR_EE;			\
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES);	\
+BEGIN_FW_FTR_SECTION;				\
+	ld	r12,_MSR(r1);			\
+	mfmsr	r11;				\
+	rlwimi	r11,r12,0,MSR_EE;		\
+END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES);	\
 	mtmsrd	r11,1
 
 #else	/* hard enable/disable interrupts */
@@ -1071,8 +1081,10 @@ _GLOBAL(slb_miss_realmode)
 	ld	r3,PACA_EXSLB+EX_R3(r13)
 	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
 #ifdef CONFIG_PPC_ISERIES
+BEGIN_FW_FTR_SECTION
 	ld	r11,PACALPPACAPTR(r13)
 	ld	r11,LPPACASRR0(r11)		/* get SRR0 value */
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif /* CONFIG_PPC_ISERIES */
 
 	mtlr	r10
@@ -1087,8 +1099,10 @@ #endif /* CONFIG_PPC_ISERIES */
 .machine	pop
 
 #ifdef CONFIG_PPC_ISERIES
+BEGIN_FW_FTR_SECTION
 	mtspr	SPRN_SRR0,r11
 	mtspr	SPRN_SRR1,r12
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif /* CONFIG_PPC_ISERIES */
 	ld	r9,PACA_EXSLB+EX_R9(r13)
 	ld	r10,PACA_EXSLB+EX_R10(r13)
@@ -1301,6 +1315,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 	cmpdi	r3,0			/* see if hash_page succeeded */
 
 #ifdef DO_SOFT_DISABLE
+BEGIN_FW_FTR_SECTION
 	/*
 	 * If we had interrupts soft-enabled at the point where the
 	 * DSI/ISI occurred, and an interrupt came in during hash_page,
@@ -1321,12 +1336,14 @@ #ifdef DO_SOFT_DISABLE
 	ld	r3,SOFTE(r1)
 	bl	.local_irq_restore
 	b	11f
-#else
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
+#endif
+BEGIN_FW_FTR_SECTION
 	beq	fast_exception_return   /* Return from exception on success */
 	ble-	12f			/* Failure return from hash_page */
 
 	/* fall through */
-#endif
+END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ISERIES)
 
 /* Here we have a page fault that hash_page can't handle. */
 _GLOBAL(handle_page_fault)
@@ -1861,7 +1878,9 @@ _GLOBAL(__secondary_start)
 	LOAD_REG_ADDR(r3, .start_secondary_prolog)
 	LOAD_REG_IMMEDIATE(r4, MSR_KERNEL)
 #ifdef DO_SOFT_DISABLE
+BEGIN_FW_FTR_SECTION
 	ori	r4,r4,MSR_EE
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
 	mtspr	SPRN_SRR0,r3
 	mtspr	SPRN_SRR1,r4
@@ -1986,6 +2005,7 @@ _STATIC(start_here_common)
 	 */
 	li	r3,0
 	bl	.do_cpu_ftr_fixups
+	bl	.do_fw_ftr_fixups
 
 	/* ptr to current */
 	LOAD_REG_IMMEDIATE(r4, init_task)
@@ -2000,11 +2020,13 @@ _STATIC(start_here_common)
 	/* Load up the kernel context */
 5:
 #ifdef DO_SOFT_DISABLE
+BEGIN_FW_FTR_SECTION
 	li	r5,0
 	stb	r5,PACAPROCENABLED(r13)	/* Soft Disabled */
 	mfmsr	r5
 	ori	r5,r5,MSR_EE		/* Hard Enabled */
 	mtmsrd	r5
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif
 
 	bl .start_kernel
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index e3ed21c..465a764 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -325,6 +325,52 @@ _GLOBAL(do_cpu_ftr_fixups)
 	isync
 	b	1b
 
+/*
+ * do_fw_ftr_fixups - goes through the list of firmware feature fixups
+ * and writes nop's over sections of code that don't apply for this firmware.
+ * r3 = data offset (not changed)
+ */
+_GLOBAL(do_fw_ftr_fixups)
+	/* Get firmware features */
+	LOAD_REG_IMMEDIATE(r6,powerpc_firmware_features)
+	sub	r6,r6,r3
+	ld	r4,0(r6)
+	/* Get the fixup table */
+	LOAD_REG_IMMEDIATE(r6,__start___fw_ftr_fixup)
+	sub	r6,r6,r3
+	LOAD_REG_IMMEDIATE(r7,__stop___fw_ftr_fixup)
+	sub	r7,r7,r3
+	/* Do the fixup */
+1:	cmpld	r6,r7
+	bgelr
+	addi	r6,r6,32
+	ld	r8,-32(r6)	/* mask */
+	and	r8,r8,r4
+	ld	r9,-24(r6)	/* value */
+	cmpld	r8,r9
+	beq	1b
+	ld	r8,-16(r6)	/* section begin */
+	ld	r9,-8(r6)	/* section end */
+	subf.	r9,r8,r9
+	beq	1b
+	/* write nops over the section of code */
+	/* todo: if large section, add a branch at the start of it */
+	srwi	r9,r9,2
+	mtctr	r9
+	sub	r8,r8,r3
+	lis	r0,0x60000000@h	/* nop */
+3:	stw	r0,0(r8)
+BEGIN_FTR_SECTION
+	dcbst	0,r8		/* suboptimal, but simpler */
+	sync
+	icbi	0,r8
+END_FTR_SECTION_IFSET(CPU_FTR_SPLIT_ID_CACHE)
+	addi	r8,r8,4
+	bdnz	3b
+	sync			/* additional sync needed on g4 */
+	isync
+	b	1b
+
 #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE)
 /*
  * Do an IO access in real mode
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 02665a0..cb0e8d4 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -132,6 +132,14 @@ #endif
 		*(__ftr_fixup)
 		__stop___ftr_fixup = .;
 	}
+#ifdef CONFIG_PPC64
+	. = ALIGN(8);
+	__fw_ftr_fixup : {
+		__start___fw_ftr_fixup = .;
+		*(__fw_ftr_fixup)
+		__stop___fw_ftr_fixup = .;
+	}
+#endif
 
 	. = ALIGN(PAGE_SIZE);
 	.init.ramfs : {
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index dbc1abb..b10e470 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -21,6 +21,7 @@ #include <asm/cputable.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
+#include <asm/firmware.h>
 
 /* void slb_allocate_realmode(unsigned long ea);
  *
@@ -183,6 +184,7 @@ slb_finish_load:
  	 * dont have any LRU information to help us choose a slot.
  	 */
 #ifdef CONFIG_PPC_ISERIES
+BEGIN_FW_FTR_SECTION
 	/*
 	 * On iSeries, the "bolted" stack segment can be cast out on
 	 * shared processor switch so we need to check for a miss on
@@ -194,6 +196,7 @@ #ifdef CONFIG_PPC_ISERIES
 	li	r10,SLB_NUM_BOLTED-1	/* Stack goes in last bolted slot */
 	cmpld	r9,r3
 	beq	3f
+END_FW_FTR_SECTION_IFSET(FW_FEATURE_ISERIES)
 #endif /* CONFIG_PPC_ISERIES */
 
 	ld	r10,PACASTABRR(r13)
diff --git a/include/asm-powerpc/firmware.h b/include/asm-powerpc/firmware.h
index 77069df..1022737 100644
--- a/include/asm-powerpc/firmware.h
+++ b/include/asm-powerpc/firmware.h
@@ -14,34 +14,36 @@ #define __ASM_POWERPC_FIRMWARE_H
 
 #ifdef __KERNEL__
 
-#ifndef __ASSEMBLY__
+#include <asm/asm-compat.h>
 
 /* firmware feature bitmask values */
 #define FIRMWARE_MAX_FEATURES 63
 
-#define FW_FEATURE_PFT		(1UL<<0)
-#define FW_FEATURE_TCE		(1UL<<1)
-#define FW_FEATURE_SPRG0	(1UL<<2)
-#define FW_FEATURE_DABR		(1UL<<3)
-#define FW_FEATURE_COPY		(1UL<<4)
-#define FW_FEATURE_ASR		(1UL<<5)
-#define FW_FEATURE_DEBUG	(1UL<<6)
-#define FW_FEATURE_TERM		(1UL<<7)
-#define FW_FEATURE_PERF		(1UL<<8)
-#define FW_FEATURE_DUMP		(1UL<<9)
-#define FW_FEATURE_INTERRUPT	(1UL<<10)
-#define FW_FEATURE_MIGRATE	(1UL<<11)
-#define FW_FEATURE_PERFMON	(1UL<<12)
-#define FW_FEATURE_CRQ		(1UL<<13)
-#define FW_FEATURE_VIO		(1UL<<14)
-#define FW_FEATURE_RDMA		(1UL<<15)
-#define FW_FEATURE_LLAN		(1UL<<16)
-#define FW_FEATURE_BULK		(1UL<<17)
-#define FW_FEATURE_XDABR	(1UL<<18)
-#define FW_FEATURE_MULTITCE	(1UL<<19)
-#define FW_FEATURE_SPLPAR	(1UL<<20)
-#define FW_FEATURE_ISERIES	(1UL<<21)
-#define FW_FEATURE_LPAR		(1UL<<22)
+#define FW_FEATURE_PFT		ASM_CONST(0x0000000000000001)
+#define FW_FEATURE_TCE		ASM_CONST(0x0000000000000002)
+#define FW_FEATURE_SPRG0	ASM_CONST(0x0000000000000004)
+#define FW_FEATURE_DABR		ASM_CONST(0x0000000000000008)
+#define FW_FEATURE_COPY		ASM_CONST(0x0000000000000010)
+#define FW_FEATURE_ASR		ASM_CONST(0x0000000000000020)
+#define FW_FEATURE_DEBUG	ASM_CONST(0x0000000000000040)
+#define FW_FEATURE_TERM		ASM_CONST(0x0000000000000080)
+#define FW_FEATURE_PERF		ASM_CONST(0x0000000000000100)
+#define FW_FEATURE_DUMP		ASM_CONST(0x0000000000000200)
+#define FW_FEATURE_INTERRUPT	ASM_CONST(0x0000000000000400)
+#define FW_FEATURE_MIGRATE	ASM_CONST(0x0000000000000800)
+#define FW_FEATURE_PERFMON	ASM_CONST(0x0000000000001000)
+#define FW_FEATURE_CRQ		ASM_CONST(0x0000000000002000)
+#define FW_FEATURE_VIO		ASM_CONST(0x0000000000004000)
+#define FW_FEATURE_RDMA		ASM_CONST(0x0000000000008000)
+#define FW_FEATURE_LLAN		ASM_CONST(0x0000000000010000)
+#define FW_FEATURE_BULK		ASM_CONST(0x0000000000020000)
+#define FW_FEATURE_XDABR	ASM_CONST(0x0000000000040000)
+#define FW_FEATURE_MULTITCE	ASM_CONST(0x0000000000080000)
+#define FW_FEATURE_SPLPAR	ASM_CONST(0x0000000000100000)
+#define FW_FEATURE_ISERIES	ASM_CONST(0x0000000000200000)
+#define FW_FEATURE_LPAR		ASM_CONST(0x0000000000400000)
+
+#ifndef __ASSEMBLY__
 
 enum {
 #ifdef CONFIG_PPC64
@@ -94,6 +96,23 @@ extern void machine_check_fwnmi(void);
 /* This is true if we are using the firmware NMI handler (typically LPAR) */
 extern int fwnmi_active;
 
+#else /* __ASSEMBLY__ */
+
+#define BEGIN_FW_FTR_SECTION		96:
+
+#define END_FW_FTR_SECTION(msk, val)		\
+97:						\
+	.section __fw_ftr_fixup,"a";		\
+	.align 3;				\
+	.llong msk;				\
+	.llong val;				\
+	.llong 96b;				\
+	.llong 97b;				\
+	.previous
+
+#define END_FW_FTR_SECTION_IFSET(msk)	END_FW_FTR_SECTION((msk), (msk))
+#define END_FW_FTR_SECTION_IFCLR(msk)	END_FW_FTR_SECTION((msk), 0)
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_FIRMWARE_H */
-- 
1.4.2.1

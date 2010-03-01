Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Mon, 1 Mar 2010 12:13:15 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100301191315.20987.48063.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
Subject: [RFC: PATCH 03/13] powerpc/47x: Base ppc476 support
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/47x: Base ppc476 support

From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

This patch adds the base support for the 476 processor.  The code was
primarily written by Ben Herrenschmidt and Torez Smith, but I've been
maintaining it for a while.

The goal is to have a single binary that will run on 44x and 47x, but
we still have some details to work out.  The biggest is that the L1 cache
line size differs on the two platforms, but it's currently a compile-time
option.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/cache.h       |    6 
 arch/powerpc/include/asm/cputable.h    |    4 
 arch/powerpc/include/asm/mmu-44x.h     |   51 +++
 arch/powerpc/include/asm/mmu.h         |    1 
 arch/powerpc/include/asm/reg.h         |    1 
 arch/powerpc/include/asm/reg_booke.h   |   26 ++
 arch/powerpc/kernel/cputable.c         |   13 +
 arch/powerpc/kernel/entry_32.S         |    5 
 arch/powerpc/kernel/head_44x.S         |  502 +++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/misc_32.S          |    9 -
 arch/powerpc/kernel/smp.c              |    8 +
 arch/powerpc/mm/44x_mmu.c              |  144 +++++++++
 arch/powerpc/mm/mmu_context_nohash.c   |    8 +
 arch/powerpc/mm/mmu_decl.h             |    7 
 arch/powerpc/mm/tlb_nohash_low.S       |  118 +++++++-
 arch/powerpc/platforms/44x/Kconfig     |   37 ++
 arch/powerpc/platforms/Kconfig.cputype |    5 
 17 files changed, 888 insertions(+), 57 deletions(-)


diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 81de6eb..725634f 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -12,8 +12,12 @@
 #define L1_CACHE_SHIFT		6
 #define MAX_COPY_PREFETCH	4
 #elif defined(CONFIG_PPC32)
-#define L1_CACHE_SHIFT		5
 #define MAX_COPY_PREFETCH	4
+#if defined(CONFIG_PPC_47x)
+#define L1_CACHE_SHIFT		7
+#else
+#define L1_CACHE_SHIFT		5
+#endif
 #else /* CONFIG_PPC64 */
 #define L1_CACHE_SHIFT		7
 #endif
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 80f315e..75b774e 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -365,6 +365,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_44X	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_440x6	(CPU_FTR_USE_TB | CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_INDEXED_DCR)
+#define CPU_FTRS_47X	(CPU_FTRS_440x6)
 #define CPU_FTRS_E200	(CPU_FTR_USE_TB | CPU_FTR_SPE_COMP | \
 	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
 	    CPU_FTR_UNIFIED_ID_CACHE | CPU_FTR_NOEXECUTE)
@@ -453,6 +454,9 @@ enum {
 #ifdef CONFIG_44x
 	    CPU_FTRS_44X | CPU_FTRS_440x6 |
 #endif
+#ifdef CONFIG_PPC_47x
+	    CPU_FTRS_47X |
+#endif
 #ifdef CONFIG_E200
 	    CPU_FTRS_E200 |
 #endif
diff --git a/arch/powerpc/include/asm/mmu-44x.h b/arch/powerpc/include/asm/mmu-44x.h
index 0372669..bf52d70 100644
--- a/arch/powerpc/include/asm/mmu-44x.h
+++ b/arch/powerpc/include/asm/mmu-44x.h
@@ -40,7 +40,7 @@
 #define PPC44x_TLB_I		0x00000400      /* Caching is inhibited */
 #define PPC44x_TLB_M		0x00000200      /* Memory is coherent */
 #define PPC44x_TLB_G		0x00000100      /* Memory is guarded */
-#define PPC44x_TLB_E		0x00000080      /* Memory is guarded */
+#define PPC44x_TLB_E		0x00000080      /* Memory is little endian */
 
 #define PPC44x_TLB_PERM_MASK	0x0000003f
 #define PPC44x_TLB_UX		0x00000020      /* User execution */
@@ -53,6 +53,52 @@
 /* Number of TLB entries */
 #define PPC44x_TLB_SIZE		64
 
+/* 47x bits */
+#define PPC47x_MMUCR_TID	0x0000ffff
+#define PPC47x_MMUCR_STS	0x00010000
+
+/* Page identification fields */
+#define PPC47x_TLB0_EPN_MASK	0xfffff000      /* Effective Page Number */
+#define PPC47x_TLB0_VALID	0x00000800      /* Valid flag */
+#define PPC47x_TLB0_TS		0x00000400	/* Translation address space */
+#define PPC47x_TLB0_4K		0x00000000
+#define PPC47x_TLB0_16K		0x00000010
+#define PPC47x_TLB0_64K		0x00000030
+#define PPC47x_TLB0_1M		0x00000070
+#define PPC47x_TLB0_16M		0x000000f0
+#define PPC47x_TLB0_256M	0x000001f0
+#define PPC47x_TLB0_1G		0x000003f0
+#define PPC47x_TLB0_BOLTED_R	0x00000008	/* tlbre only */
+
+/* Translation fields */
+#define PPC47x_TLB1_RPN_MASK	0xfffff000      /* Real Page Number */
+#define PPC47x_TLB1_ERPN_MASK	0x000003ff
+
+/* Storage attribute and access control fields */
+#define PPC47x_TLB2_ATTR_MASK	0x0003ff80
+#define PPC47x_TLB2_IL1I	0x00020000      /* Memory is guarded */
+#define PPC47x_TLB2_IL1D	0x00010000      /* Memory is guarded */
+#define PPC47x_TLB2_U0		0x00008000      /* User 0 */
+#define PPC47x_TLB2_U1		0x00004000      /* User 1 */
+#define PPC47x_TLB2_U2		0x00002000      /* User 2 */
+#define PPC47x_TLB2_U3		0x00001000      /* User 3 */
+#define PPC47x_TLB2_W		0x00000800      /* Caching is write-through */
+#define PPC47x_TLB2_I		0x00000400      /* Caching is inhibited */
+#define PPC47x_TLB2_M		0x00000200      /* Memory is coherent */
+#define PPC47x_TLB2_G		0x00000100      /* Memory is guarded */
+#define PPC47x_TLB2_E		0x00000080      /* Memory is little endian */
+#define PPC47x_TLB2_PERM_MASK	0x0000003f
+#define PPC47x_TLB2_UX		0x00000020      /* User execution */
+#define PPC47x_TLB2_UW		0x00000010      /* User write */
+#define PPC47x_TLB2_UR		0x00000008      /* User read */
+#define PPC47x_TLB2_SX		0x00000004      /* Super execution */
+#define PPC47x_TLB2_SW		0x00000002      /* Super write */
+#define PPC47x_TLB2_SR		0x00000001      /* Super read */
+#define PPC47x_TLB2_U_RWX	(PPC47x_TLB2_UX|PPC47x_TLB2_UW|PPC47x_TLB2_UR)
+#define PPC47x_TLB2_S_RWX	(PPC47x_TLB2_SX|PPC47x_TLB2_SW|PPC47x_TLB2_SR)
+#define PPC47x_TLB2_S_RW	(PPC47x_TLB2_SW | PPC47x_TLB2_SR)
+#define PPC47x_TLB2_IMG		(PPC47x_TLB2_I | PPC47x_TLB2_M | PPC47x_TLB2_G)
+
 #ifndef __ASSEMBLY__
 
 extern unsigned int tlb_44x_hwater;
@@ -79,12 +125,15 @@ typedef struct {
 
 #if (PAGE_SHIFT == 12)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_4K
+#define PPC47x_TLBE_SIZE	PPC47x_TLB0_4K
 #define mmu_virtual_psize	MMU_PAGE_4K
 #elif (PAGE_SHIFT == 14)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_16K
+#define PPC47x_TLBE_SIZE	PPC47x_TLB0_16K
 #define mmu_virtual_psize	MMU_PAGE_16K
 #elif (PAGE_SHIFT == 16)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_64K
+#define PPC47x_TLBE_SIZE	PPC47x_TLB0_64K
 #define mmu_virtual_psize	MMU_PAGE_64K
 #elif (PAGE_SHIFT == 18)
 #define PPC44x_TLBE_SIZE	PPC44x_TLB_256K
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 7ffbb65..7ebf42e 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -18,6 +18,7 @@
 #define MMU_FTR_TYPE_44x		ASM_CONST(0x00000008)
 #define MMU_FTR_TYPE_FSL_E		ASM_CONST(0x00000010)
 #define MMU_FTR_TYPE_3E			ASM_CONST(0x00000020)
+#define MMU_FTR_TYPE_47x		ASM_CONST(0x00000040)
 
 /*
  * This is individual features
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index bc8dd53..4af1c28 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -813,6 +813,7 @@
 #define PVR_403GC	0x00200200
 #define PVR_403GCX	0x00201400
 #define PVR_405GP	0x40110000
+#define PVR_476		0x11a52000
 #define PVR_STB03XXX	0x40310000
 #define PVR_NP405H	0x41410000
 #define PVR_NP405L	0x41610000
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 3bf7835..ee61a9d 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -191,6 +191,12 @@
 #define MCSR_DCFP	0x01000000 /* D-Cache Flush Parity Error */
 #define MCSR_IMPE	0x00800000 /* Imprecise Machine Check Exception */
 
+#ifdef CONFIG_PPC_47x
+#define PPC47x_MCSR_GPR	0x01000000 /* GPR parity error */
+#define PPC47x_MCSR_FPR	0x00800000 /* FPR parity error */
+#define PPC47x_MCSR_IPR	0x00400000 /* Imprecise Machine Check Exception */
+#endif
+
 #ifdef CONFIG_E500
 #define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
 #define MCSR_ICPERR 	0x40000000UL /* I-Cache Parity Error */
@@ -510,5 +516,25 @@
 #define DBCR_JOI	0x00000002	/* JTAG Serial Outbound Int. Enable */
 #define DBCR_JII	0x00000001	/* JTAG Serial Inbound Int. Enable */
 #endif /* 403GCX */
+
+/* Some 476 specific registers */
+#define SPRN_SSPCR		830
+#define SPRN_USPCR		831
+#define SPRN_ISPCR		829
+#define SPRN_MMUBE0		820
+#define MMUBE0_IBE0_SHIFT	24
+#define MMUBE0_IBE1_SHIFT	16
+#define MMUBE0_IBE2_SHIFT	8
+#define MMUBE0_VBE0		0x00000004
+#define MMUBE0_VBE1		0x00000002
+#define MMUBE0_VBE2		0x00000001
+#define SPRN_MMUBE1		821
+#define MMUBE1_IBE3_SHIFT	24
+#define MMUBE1_IBE4_SHIFT	16
+#define MMUBE1_IBE5_SHIFT	8
+#define MMUBE1_VBE3		0x00000004
+#define MMUBE1_VBE4		0x00000002
+#define MMUBE1_VBE5		0x00000001
+
 #endif /* __ASM_POWERPC_REG_BOOKE_H__ */
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 2fc82ba..338ac47 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1701,6 +1701,19 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
+	{ /* 476 core */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x11a50000,
+		.cpu_name		= "476",
+		.cpu_features		= CPU_FTRS_47X,
+		.cpu_user_features	= COMMON_USER_BOOKE |
+			PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_47x |
+			MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 128,
+		.platform		= "ppc470",
+	},
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 1175a85..ed4aeb9 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -373,11 +373,13 @@ syscall_exit_cont:
 	bnel-	load_dbcr0
 #endif
 #ifdef CONFIG_44x
+BEGIN_MMU_FTR_SECTION
 	lis	r4,icache_44x_need_flush@ha
 	lwz	r5,icache_44x_need_flush@l(r4)
 	cmplwi	cr0,r5,0
 	bne-	2f
 1:
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_47x)
 #endif /* CONFIG_44x */
 BEGIN_FTR_SECTION
 	lwarx	r7,0,r1
@@ -848,6 +850,9 @@ resume_kernel:
 	/* interrupts are hard-disabled at this point */
 restore:
 #ifdef CONFIG_44x
+BEGIN_MMU_FTR_SECTION
+	b	1f
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 	lis	r4,icache_44x_need_flush@ha
 	lwz	r5,icache_44x_need_flush@l(r4)
 	cmplwi	cr0,r5,0
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 39be049..1acd175 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -37,6 +37,7 @@
 #include <asm/thread_info.h>
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/synch.h>
 #include "head_booke.h"
 
 
@@ -191,7 +192,7 @@ interrupt_base:
 #endif
 
 	/* Data TLB Error Interrupt */
-	START_EXCEPTION(DataTLBError)
+	START_EXCEPTION(DataTLBError44x)
 	mtspr	SPRN_SPRG_WSCRATCH0, r10		/* Save some working registers */
 	mtspr	SPRN_SPRG_WSCRATCH1, r11
 	mtspr	SPRN_SPRG_WSCRATCH2, r12
@@ -282,7 +283,7 @@ tlb_44x_patch_hwater_D:
 	mfspr	r10,SPRN_DEAR
 
 	 /* Jump to common tlb load */
-	b	finish_tlb_load
+	b	finish_tlb_load_44x
 
 2:
 	/* The bailout.  Restore registers to pre-exception conditions
@@ -302,7 +303,7 @@ tlb_44x_patch_hwater_D:
 	 * information from different registers and bailout
 	 * to a different point.
 	 */
-	START_EXCEPTION(InstructionTLBError)
+	START_EXCEPTION(InstructionTLBError44x)
 	mtspr	SPRN_SPRG_WSCRATCH0, r10 /* Save some working registers */
 	mtspr	SPRN_SPRG_WSCRATCH1, r11
 	mtspr	SPRN_SPRG_WSCRATCH2, r12
@@ -378,7 +379,7 @@ tlb_44x_patch_hwater_I:
 	mfspr	r10,SPRN_SRR0
 
 	/* Jump to common TLB load point */
-	b	finish_tlb_load
+	b	finish_tlb_load_44x
 
 2:
 	/* The bailout.  Restore registers to pre-exception conditions
@@ -392,15 +393,7 @@ tlb_44x_patch_hwater_I:
 	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	b	InstructionStorage
 
-	/* Debug Interrupt */
-	DEBUG_CRIT_EXCEPTION
-
-/*
- * Local functions
-  */
-
 /*
-
  * Both the instruction and data TLB miss get to this
  * point to load the TLB.
  * 	r10 - EA of fault
@@ -410,7 +403,7 @@ tlb_44x_patch_hwater_I:
  *	MMUCR - loaded with proper value when we get here
  *	Upon exit, we reload everything and RFI.
  */
-finish_tlb_load:
+finish_tlb_load_44x:
 	/* Combine RPN & ERPN an write WS 0 */
 	rlwimi	r11,r12,0,0,31-PAGE_SHIFT
 	tlbwe	r11,r13,PPC44x_TLB_XLAT
@@ -443,6 +436,227 @@ finish_tlb_load:
 	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	rfi					/* Force context change */
 
+/* TLB error interrupts for 476
+ */
+#ifdef CONFIG_PPC_47x
+	START_EXCEPTION(DataTLBError47x)
+	mtspr	SPRN_SPRG_WSCRATCH0,r10	/* Save some working registers */
+	mtspr	SPRN_SPRG_WSCRATCH1,r11
+	mtspr	SPRN_SPRG_WSCRATCH2,r12
+	mtspr	SPRN_SPRG_WSCRATCH3,r13
+	mfcr	r11
+	mtspr	SPRN_SPRG_WSCRATCH4,r11
+	mfspr	r10,SPRN_DEAR		/* Get faulting address */
+
+	/* If we are faulting a kernel address, we have to use the
+	 * kernel page tables.
+	 */
+	lis	r11,PAGE_OFFSET@h
+	cmplw	cr0,r10,r11
+	blt+	3f
+	lis	r11,swapper_pg_dir@h
+	ori	r11,r11, swapper_pg_dir@l
+	li	r12,0			/* MMUCR = 0 */
+	b	4f
+
+	/* Get the PGD for the current thread and setup MMUCR */
+3:	mfspr	r11,SPRN_SPRG3
+	lwz	r11,PGDIR(r11)
+	mfspr   r12,SPRN_PID		/* Get PID */
+4:	mtspr	SPRN_MMUCR,r12		/* Set MMUCR */
+
+	/* Mask of required permission bits. Note that while we
+	 * do copy ESR:ST to _PAGE_RW position as trying to write
+	 * to an RO page is pretty common, we don't do it with
+	 * _PAGE_DIRTY. We could do it, but it's a fairly rare
+	 * event so I'd rather take the overhead when it happens
+	 * rather than adding an instruction here. We should measure
+	 * whether the whole thing is worth it in the first place
+	 * as we could avoid loading SPRN_ESR completely in the first
+	 * place...
+	 *
+	 * TODO: Is it worth doing that mfspr & rlwimi in the first
+	 *       place or can we save a couple of instructions here ?
+	 */
+	mfspr	r12,SPRN_ESR
+	li	r13,_PAGE_PRESENT|_PAGE_ACCESSED
+	rlwimi	r13,r12,10,30,30
+
+	/* Load the PTE */
+	/* Compute pgdir/pmd offset */
+	rlwinm  r12,r10,PPC44x_PGD_OFF_SHIFT,PPC44x_PGD_OFF_MASK_BIT,29
+	lwzx	r11,r12,r11		/* Get pgd/pmd entry */
+
+	/* Word 0 is EPN,V,TS,DSIZ */
+	li	r12,PPC47x_TLB0_VALID | PPC47x_TLBE_SIZE
+	rlwimi	r10,r12,0,32-PAGE_SHIFT,31	/* Insert valid and page size*/
+	li	r12,0
+	tlbwe	r10,r12,0
+
+	/* XXX can we do better ? Need to make sure tlbwe has established
+	 * latch V bit in MMUCR0 before the PTE is loaded further down */
+#ifdef CONFIG_SMP
+	isync
+#endif
+
+	rlwinm.	r12,r11,0,0,20		/* Extract pt base address */
+	/* Compute pte address */
+	rlwimi  r12,r10,PPC44x_PTE_ADD_SHIFT,PPC44x_PTE_ADD_MASK_BIT,28
+	beq	2f			/* Bail if no table */
+	lwz	r11,0(r12)		/* Get high word of pte entry */
+
+	/* XXX can we do better ? maybe insert a known 0 bit from r11 into the
+	 * bottom of r12 to create a data dependency... We can also use r10
+	 * as destination nowadays
+	 */
+#ifdef CONFIG_SMP
+	lwsync
+#endif
+	lwz	r12,4(r12)		/* Get low word of pte entry */
+
+	andc.	r13,r13,r12		/* Check permission */
+
+	 /* Jump to common tlb load */
+	beq	finish_tlb_load_47x
+
+2:	/* The bailout.  Restore registers to pre-exception conditions
+	 * and call the heavyweights to help us out.
+	 */
+	mfspr	r11,SPRN_SPRG_RSCRATCH4
+	mtcr	r11
+	mfspr	r13,SPRN_SPRG_RSCRATCH3
+	mfspr	r12,SPRN_SPRG_RSCRATCH2
+	mfspr	r11,SPRN_SPRG_RSCRATCH1
+	mfspr	r10,SPRN_SPRG_RSCRATCH0
+	b	DataStorage
+
+	/* Instruction TLB Error Interrupt */
+	/*
+	 * Nearly the same as above, except we get our
+	 * information from different registers and bailout
+	 * to a different point.
+	 */
+	START_EXCEPTION(InstructionTLBError47x)
+	mtspr	SPRN_SPRG_WSCRATCH0,r10	/* Save some working registers */
+	mtspr	SPRN_SPRG_WSCRATCH1,r11
+	mtspr	SPRN_SPRG_WSCRATCH2,r12
+	mtspr	SPRN_SPRG_WSCRATCH3,r13
+	mfcr	r11
+	mtspr	SPRN_SPRG_WSCRATCH4,r11
+	mfspr	r10,SPRN_SRR0		/* Get faulting address */
+
+	/* If we are faulting a kernel address, we have to use the
+	 * kernel page tables.
+	 */
+	lis	r11,PAGE_OFFSET@h
+	cmplw	cr0,r10,r11
+	blt+	3f
+	lis	r11,swapper_pg_dir@h
+	ori	r11,r11, swapper_pg_dir@l
+	li	r12,0			/* MMUCR = 0 */
+	b	4f
+
+	/* Get the PGD for the current thread and setup MMUCR */
+3:	mfspr	r11,SPRN_SPRG_THREAD
+	lwz	r11,PGDIR(r11)
+	mfspr   r12,SPRN_PID		/* Get PID */
+4:	mtspr	SPRN_MMUCR,r12		/* Set MMUCR */
+
+	/* Make up the required permissions */
+	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
+
+	/* Load PTE */
+	/* Compute pgdir/pmd offset */
+	rlwinm  r12,r10,PPC44x_PGD_OFF_SHIFT,PPC44x_PGD_OFF_MASK_BIT,29
+	lwzx	r11,r12,r11		/* Get pgd/pmd entry */
+
+	/* Word 0 is EPN,V,TS,DSIZ */
+	li	r12,PPC47x_TLB0_VALID | PPC47x_TLBE_SIZE
+	rlwimi	r10,r12,0,32-PAGE_SHIFT,31	/* Insert valid and page size*/
+	li	r12,0
+	tlbwe	r10,r12,0
+
+	/* XXX can we do better ? Need to make sure tlbwe has established
+	 * latch V bit in MMUCR0 before the PTE is loaded further down */
+#ifdef CONFIG_SMP
+	isync
+#endif
+
+	rlwinm.	r12,r11,0,0,20		/* Extract pt base address */
+	/* Compute pte address */
+	rlwimi  r12,r10,PPC44x_PTE_ADD_SHIFT,PPC44x_PTE_ADD_MASK_BIT,28
+	beq	2f			/* Bail if no table */
+
+	lwz	r11,0(r12)		/* Get high word of pte entry */
+	/* XXX can we do better ? maybe insert a known 0 bit from r11 into the
+	 * bottom of r12 to create a data dependency... We can also use r10
+	 * as destination nowadays
+	 */
+#ifdef CONFIG_SMP
+	lwsync
+#endif
+	lwz	r12,4(r12)		/* Get low word of pte entry */
+
+	andc.	r13,r13,r12		/* Check permission */
+
+	/* Jump to common TLB load point */
+	beq	finish_tlb_load_47x
+
+2:	/* The bailout.  Restore registers to pre-exception conditions
+	 * and call the heavyweights to help us out.
+	 */
+	mfspr	r11, SPRN_SPRG_RSCRATCH4
+	mtcr	r11
+	mfspr	r13, SPRN_SPRG_RSCRATCH3
+	mfspr	r12, SPRN_SPRG_RSCRATCH2
+	mfspr	r11, SPRN_SPRG_RSCRATCH1
+	mfspr	r10, SPRN_SPRG_RSCRATCH0
+	b	InstructionStorage
+
+/*
+ * Both the instruction and data TLB miss get to this
+ * point to load the TLB.
+ * 	r10 - free to use
+ * 	r11 - PTE high word value
+ *	r12 - PTE low word value
+ *      r13 - free to use
+ *	MMUCR - loaded with proper value when we get here
+ *	Upon exit, we reload everything and RFI.
+ */
+finish_tlb_load_47x:
+	/* Combine RPN & ERPN an write WS 1 */
+	rlwimi	r11,r12,0,0,31-PAGE_SHIFT
+	tlbwe	r11,r13,1
+
+	/* And make up word 2 */
+	li	r10,0xf85			/* Mask to apply from PTE */
+	rlwimi	r10,r12,29,30,30		/* DIRTY -> SW position */
+	and	r11,r12,r10			/* Mask PTE bits to keep */
+	andi.	r10,r12,_PAGE_USER		/* User page ? */
+	beq	1f				/* nope, leave U bits empty */
+	rlwimi	r11,r11,3,26,28			/* yes, copy S bits to U */
+1:	tlbwe	r11,r13,2
+
+	/* Done...restore registers and get out of here.
+	*/
+	mfspr	r11, SPRN_SPRG_RSCRATCH4
+	mtcr	r11
+	mfspr	r13, SPRN_SPRG_RSCRATCH3
+	mfspr	r12, SPRN_SPRG_RSCRATCH2
+	mfspr	r11, SPRN_SPRG_RSCRATCH1
+	mfspr	r10, SPRN_SPRG_RSCRATCH0
+	rfi
+
+#endif /* CONFIG_PPC_47x */
+
+	/* Debug Interrupt */
+	/*
+	 * This statement needs to exist at the end of the IVPR
+	 * definition just in case you end up taking a debug
+	 * exception within another exception.
+	 */
+	DEBUG_CRIT_EXCEPTION
+
 /*
  * Global functions
  */
@@ -491,9 +705,18 @@ _GLOBAL(set_context)
 /*
  * Init CPU state. This is called at boot time or for secondary CPUs
  * to setup initial TLB entries, setup IVORs, etc...
+ *
  */
 _GLOBAL(init_cpu_state)
 	mflr	r22
+#ifdef CONFIG_PPC_47x
+	/* We use the PVR to differenciate 44x cores from 476 */
+	mfspr	r3,SPRN_PVR
+	srwi	r3,r3,16
+	cmplwi	cr0,r3,PVR_476@h
+	beq	head_start_47x
+#endif /* CONFIG_PPC_47x */
+
 /*
  * In case the firmware didn't do it, we apply some workarounds
  * that are good for all 440 core variants here
@@ -506,7 +729,7 @@ _GLOBAL(init_cpu_state)
 	sync
 
 /*
- * Set up the initial MMU state
+ * Set up the initial MMU state for 44x
  *
  * We are still executing code at the virtual address
  * mappings set by the firmware for the base of RAM.
@@ -646,16 +869,257 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	SET_IVOR(10, Decrementer);
 	SET_IVOR(11, FixedIntervalTimer);
 	SET_IVOR(12, WatchdogTimer);
-	SET_IVOR(13, DataTLBError);
-	SET_IVOR(14, InstructionTLBError);
+	SET_IVOR(13, DataTLBError44x);
+	SET_IVOR(14, InstructionTLBError44x);
 	SET_IVOR(15, DebugCrit);
 
+	b	head_start_common
+
+
+#ifdef CONFIG_PPC_47x
+
+#ifdef CONFIG_SMP
+
+/* Entry point for secondary 47x processors */
+_GLOBAL(start_secondary_47x)
+        mr      r24,r3          /* CPU number */
+
+	bl	init_cpu_state
+
+	/* Now we need to bolt the rest of kernel memory which
+	 * is done in C code. We must be careful because our task
+	 * struct or our stack can (and will probably) be out
+	 * of reach of the initial 256M TLB entry, so we use a
+	 * small temporary stack in .bss for that. This works
+	 * because only one CPU at a time can be in this code
+	 */
+	lis	r1,temp_boot_stack@h
+	ori	r1,r1,temp_boot_stack@l
+	addi	r1,r1,1024-STACK_FRAME_OVERHEAD
+	li	r0,0
+	stw	r0,0(r1)
+	bl	mmu_init_secondary
+
+	/* Now we can get our task struct and real stack pointer */
+
+	/* Get current_thread_info and current */
+	lis	r1,secondary_ti@ha
+	lwz	r1,secondary_ti@l(r1)
+	lwz	r2,TI_TASK(r1)
+
+	/* Current stack pointer */
+	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
+	li	r0,0
+	stw	r0,0(r1)
+
+	/* Kernel stack for exception entry in SPRG3 */
+	addi	r4,r2,THREAD	/* init task's THREAD */
+	mtspr	SPRN_SPRG3,r4
+
+	b	start_secondary
+
+#endif /* CONFIG_SMP */
+
+/*
+ * Set up the initial MMU state for 44x
+ *
+ * We are still executing code at the virtual address
+ * mappings set by the firmware for the base of RAM.
+ */
+
+head_start_47x:
+	/* Load our current PID->MMUCR TID and MSR IS->MMUCR STS */
+	mfspr	r3,SPRN_PID			/* Get PID */
+	mfmsr	r4				/* Get MSR */
+	andi.	r4,r4,MSR_IS@l			/* TS=1? */
+	beq	1f				/* If not, leave STS=0 */
+	oris	r3,r3,PPC47x_MMUCR_STS@h	/* Set STS=1 */
+1:	mtspr	SPRN_MMUCR,r3			/* Put MMUCR */
+	sync
+
+	/* Find the entry we are running from */
+	bl	1f
+1:	mflr	r23
+	tlbsx	r23,0,r23
+	tlbre	r24,r23,0
+	tlbre	r25,r23,1
+	tlbre	r26,r23,2
+
+/*
+ * Cleanup time
+ */
+
+	/* Initialize MMUCR */
+	li	r5,0
+	mtspr	SPRN_MMUCR,r5
+	sync
+
+clear_all_utlb_entries:
+
+	#; Set initial values.
+
+	addis		r3,0,0x8000
+	addi		r4,0,0
+	addi		r5,0,0
+	b		clear_utlb_entry
+
+	#; Align the loop to speed things up.
+
+	.align		6
+
+clear_utlb_entry:
+
+	tlbwe		r4,r3,0
+	tlbwe		r5,r3,1
+	tlbwe		r5,r3,2
+	addis		r3,r3,0x2000
+	cmpwi		r3,0
+	bne		clear_utlb_entry
+	addis		r3,0,0x8000
+	addis		r4,r4,0x100
+	cmpwi		r4,0
+	bne		clear_utlb_entry
+
+	#; Restore original entry.
+
+	oris	r23,r23,0x8000  /* specify the way */
+	tlbwe		r24,r23,0
+	tlbwe		r25,r23,1
+	tlbwe		r26,r23,2
+
+/*
+ * Configure and load pinned entry into TLB for the kernel core
+ */
+
+	lis	r3,PAGE_OFFSET@h
+	ori	r3,r3,PAGE_OFFSET@l
+
+	/* Kernel is at the base of RAM */
+	li r4, 0			/* Load the kernel physical address */
+
+	/* Load the kernel PID = 0 */
+	li	r0,0
+	mtspr	SPRN_PID,r0
+	sync
+
+	/* Word 0 */
+	clrrwi	r3,r3,12		/* Mask off the effective page number */
+	ori	r3,r3,PPC47x_TLB0_VALID | PPC47x_TLB0_256M
+
+	/* Word 1 */
+	clrrwi	r4,r4,12		/* Mask off the real page number */
+					/* ERPN is 0 for first 4GB page */
+	/* Word 2 */
+	li	r5,0
+	ori	r5,r5,PPC47x_TLB2_S_RWX
+#ifdef CONFIG_SMP
+	ori	r5,r5,PPC47x_TLB2_M
+#endif
+
+	/* We write to way 0 and bolted 0 */
+	lis	r0,0x8800
+	tlbwe	r3,r0,0
+	tlbwe	r4,r0,1
+	tlbwe	r5,r0,2
+
+/*
+ * Configure SSPCR, ISPCR and USPCR for now to search everything, we can fix
+ * them up later
+ */
+	LOAD_REG_IMMEDIATE(r3, 0x9abcdef0)
+	mtspr	SPRN_SSPCR,r3
+	mtspr	SPRN_USPCR,r3
+	LOAD_REG_IMMEDIATE(r3, 0x12345670)
+	mtspr	SPRN_ISPCR,r3
+
+	/* Force context change */
+	mfmsr	r0
+	mtspr	SPRN_SRR1, r0
+	lis	r0,3f@h
+	ori	r0,r0,3f@l
+	mtspr	SPRN_SRR0,r0
+	sync
+	rfi
+
+	/* Invalidate original entry we used */
+3:
+	rlwinm	r24,r24,0,21,19 /* clear the "valid" bit */
+	tlbwe	r24,r23,0
+	addi	r24,0,0
+	tlbwe	r24,r23,1
+	tlbwe	r24,r23,2
+	isync                   /* Clear out the shadow TLB entries */
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_44x
+	/* Add UART mapping for early debug. */
+
+	/* Word 0 */
+	lis	r3,PPC44x_EARLY_DEBUG_VIRTADDR@h
+	ori	r3,r3,PPC47x_TLB0_VALID | PPC47x_TLB0_TS | PPC47x_TLB0_1M
+
+	/* Word 1 */
+	lis	r4,CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW@h
+	ori	r4,r4,CONFIG_PPC_EARLY_DEBUG_44x_PHYSHIGH
+
+	/* Word 2 */
+	li	r5,(PPC47x_TLB2_S_RW | PPC47x_TLB2_IMG)
+
+	/* Bolted in way 0, bolt slot 5, we -hope- we don't hit the same
+	 * congruence class as the kernel, we need to make sure of it at
+	 * some point
+	 */
+        lis	r0,0x8d00
+	tlbwe	r3,r0,0
+	tlbwe	r4,r0,1
+	tlbwe	r5,r0,2
+
+	/* Force context change */
+	isync
+#endif /* CONFIG_PPC_EARLY_DEBUG_44x */
+
+	/* Establish the interrupt vector offsets */
+	SET_IVOR(0,  CriticalInput);
+	SET_IVOR(1,  MachineCheckA);
+	SET_IVOR(2,  DataStorage);
+	SET_IVOR(3,  InstructionStorage);
+	SET_IVOR(4,  ExternalInput);
+	SET_IVOR(5,  Alignment);
+	SET_IVOR(6,  Program);
+	SET_IVOR(7,  FloatingPointUnavailable);
+	SET_IVOR(8,  SystemCall);
+	SET_IVOR(9,  AuxillaryProcessorUnavailable);
+	SET_IVOR(10, Decrementer);
+	SET_IVOR(11, FixedIntervalTimer);
+	SET_IVOR(12, WatchdogTimer);
+	SET_IVOR(13, DataTLBError47x);
+	SET_IVOR(14, InstructionTLBError47x);
+	SET_IVOR(15, DebugCrit);
+
+	/* We configure icbi to invalidate 128 bytes at a time since the
+	 * current 32-bit kernel code isn't too happy with icache != dcache
+	 * block size
+	 */
+	mfspr	r3,SPRN_CCR0
+	oris	r3,r3,0x0020
+	mtspr	SPRN_CCR0,r3
+	isync
+
+#endif /* CONFIG_PPC_47x */
+
+/*
+ * Here we are back to code that is common between 44x and 47x
+ *
+ * We proceed to further kernel initialization and return to the
+ * main kernel entry
+ */
+head_start_common:
 	/* Establish the interrupt vector base */
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
 	mtspr	SPRN_IVPR,r4
 
 	addis	r22,r22,KERNELBASE@h
 	mtlr	r22
+	isync
 	blr
 
 /*
@@ -683,3 +1147,9 @@ swapper_pg_dir:
  */
 abatron_pteptrs:
 	.space	8
+
+#ifdef CONFIG_SMP
+	.align	12
+temp_boot_stack:
+	.space	1024
+#endif /* CONFIG_SMP */
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 8649f53..8043d1b 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -441,7 +441,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	addi	r3,r3,L1_CACHE_BYTES
 	bdnz	0b
 	sync
-#ifndef CONFIG_44x
+#ifdef CONFIG_44x
 	/* We don't flush the icache on 44x. Those have a virtual icache
 	 * and we don't have access to the virtual address here (it's
 	 * not the page vaddr but where it's mapped in user space). The
@@ -449,15 +449,19 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	 * a change in the address space occurs, before returning to
 	 * user space
 	 */
+BEGIN_MMU_FTR_SECTION
+	blr
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_44x)
+#endif /* CONFIG_44x */
 	mtctr	r4
 1:	icbi	0,r6
 	addi	r6,r6,L1_CACHE_BYTES
 	bdnz	1b
 	sync
 	isync
-#endif /* CONFIG_44x */
 	blr
 
+#ifndef CONFIG_BOOKE
 /*
  * Flush a particular page from the data cache to RAM, identified
  * by its physical address.  We turn off the MMU so we can just use
@@ -490,6 +494,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	mtmsr	r10				/* restore DR */
 	isync
 	blr
+#endif /* CONFIG_BOOKE */
 
 /*
  * Clear pages using the dcbz instruction, which doesn't cause any
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index c2ee144..484e83f 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -495,6 +495,14 @@ int __devinit start_secondary(void *unused)
 	current->active_mm = &init_mm;
 
 	smp_store_cpu_info(cpu);
+
+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+	/* Clear any pending timer interrupts */
+	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
+
+	/* Enable decrementer interrupt */
+	mtspr(SPRN_TCR, TCR_DIE);
+#endif
 	set_dec(tb_ticks_per_jiffy);
 	preempt_disable();
 	cpu_callin_map[cpu] = 1;
diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index 3986264..d8c6efb 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -38,7 +38,9 @@ unsigned int tlb_44x_index; /* = 0 */
 unsigned int tlb_44x_hwater = PPC44x_TLB_SIZE - 1 - PPC44x_EARLY_TLBS;
 int icache_44x_need_flush;
 
-static void __init ppc44x_update_tlb_hwater(void)
+unsigned long tlb_47x_boltmap[1024/8];
+
+static void __cpuinit ppc44x_update_tlb_hwater(void)
 {
 	extern unsigned int tlb_44x_patch_hwater_D[];
 	extern unsigned int tlb_44x_patch_hwater_I[];
@@ -59,7 +61,7 @@ static void __init ppc44x_update_tlb_hwater(void)
 }
 
 /*
- * "Pins" a 256MB TLB entry in AS0 for kernel lowmem
+ * "Pins" a 256MB TLB entry in AS0 for kernel lowmem for 44x type MMU
  */
 static void __init ppc44x_pin_tlb(unsigned int virt, unsigned int phys)
 {
@@ -67,12 +69,18 @@ static void __init ppc44x_pin_tlb(unsigned int virt, unsigned int phys)
 
 	ppc44x_update_tlb_hwater();
 
+	mtspr(SPRN_MMUCR, 0);
+
 	__asm__ __volatile__(
 		"tlbwe	%2,%3,%4\n"
 		"tlbwe	%1,%3,%5\n"
 		"tlbwe	%0,%3,%6\n"
 	:
+#ifdef CONFIG_PPC47x
+	: "r" (PPC47x_TLB2_S_RWX),
+#else
 	: "r" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44x_TLB_G),
+#endif
 	  "r" (phys),
 	  "r" (virt | PPC44x_TLB_VALID | PPC44x_TLB_256M),
 	  "r" (entry),
@@ -81,8 +89,93 @@ static void __init ppc44x_pin_tlb(unsigned int virt, unsigned int phys)
 	  "i" (PPC44x_TLB_ATTRIB));
 }
 
+static int __init ppc47x_find_free_bolted(void)
+{
+	unsigned int mmube0 = mfspr(SPRN_MMUBE0);
+	unsigned int mmube1 = mfspr(SPRN_MMUBE1);
+
+	if (!(mmube0 & MMUBE0_VBE0))
+		return 0;
+	if (!(mmube0 & MMUBE0_VBE1))
+		return 1;
+	if (!(mmube0 & MMUBE0_VBE2))
+		return 2;
+	if (!(mmube1 & MMUBE1_VBE3))
+		return 3;
+	if (!(mmube1 & MMUBE1_VBE4))
+		return 4;
+	if (!(mmube1 & MMUBE1_VBE5))
+		return 5;
+	return -1;
+}
+
+static void __init ppc47x_update_boltmap(void)
+{
+	unsigned int mmube0 = mfspr(SPRN_MMUBE0);
+	unsigned int mmube1 = mfspr(SPRN_MMUBE1);
+
+	if (mmube0 & MMUBE0_VBE0)
+		__set_bit((mmube0 >> MMUBE0_IBE0_SHIFT) & 0xff,
+			  tlb_47x_boltmap);
+	if (mmube0 & MMUBE0_VBE1)
+		__set_bit((mmube0 >> MMUBE0_IBE1_SHIFT) & 0xff,
+			  tlb_47x_boltmap);
+	if (mmube0 & MMUBE0_VBE2)
+		__set_bit((mmube0 >> MMUBE0_IBE2_SHIFT) & 0xff,
+			  tlb_47x_boltmap);
+	if (mmube1 & MMUBE1_VBE3)
+		__set_bit((mmube1 >> MMUBE1_IBE3_SHIFT) & 0xff,
+			  tlb_47x_boltmap);
+	if (mmube1 & MMUBE1_VBE4)
+		__set_bit((mmube1 >> MMUBE1_IBE4_SHIFT) & 0xff,
+			  tlb_47x_boltmap);
+	if (mmube1 & MMUBE1_VBE5)
+		__set_bit((mmube1 >> MMUBE1_IBE5_SHIFT) & 0xff,
+			  tlb_47x_boltmap);
+}
+
+/*
+ * "Pins" a 256MB TLB entry in AS0 for kernel lowmem for 47x type MMU
+ */
+static void __cpuinit ppc47x_pin_tlb(unsigned int virt, unsigned int phys)
+{
+	unsigned int rA;
+	int bolted;
+
+	/* Base rA is HW way select, way 0, bolted bit set */
+	rA = 0x88000000;
+
+	/* Look for a bolted entry slot */
+	bolted = ppc47x_find_free_bolted();
+	BUG_ON(bolted < 0);
+
+	/* Insert bolted slot number */
+	rA |= bolted << 24;
+
+	pr_debug("256M TLB entry for 0x%08x->0x%08x in bolt slot %d\n",
+		 virt, phys, bolted);
+
+	mtspr(SPRN_MMUCR, 0);
+
+	__asm__ __volatile__(
+		"tlbwe	%2,%3,0\n"
+		"tlbwe	%1,%3,1\n"
+		"tlbwe	%0,%3,2\n"
+		:
+		: "r" (PPC47x_TLB2_SW | PPC47x_TLB2_SR |
+		       PPC47x_TLB2_SX
+#ifdef CONFIG_SMP
+		       | PPC47x_TLB2_M
+#endif
+		       ),
+		  "r" (phys),
+		  "r" (virt | PPC47x_TLB0_VALID | PPC47x_TLB0_256M),
+		  "r" (rA));
+}
+
 void __init MMU_init_hw(void)
 {
+	/* This is not useful on 47x but won't hurt either */
 	ppc44x_update_tlb_hwater();
 
 	flush_instruction_cache();
@@ -95,8 +188,51 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 	/* Pin in enough TLBs to cover any lowmem not covered by the
 	 * initial 256M mapping established in head_44x.S */
 	for (addr = PPC_PIN_SIZE; addr < lowmem_end_addr;
-	     addr += PPC_PIN_SIZE)
-		ppc44x_pin_tlb(addr + PAGE_OFFSET, addr);
+	     addr += PPC_PIN_SIZE) {
+		if (mmu_has_feature(MMU_FTR_TYPE_47x))
+			ppc47x_pin_tlb(addr + PAGE_OFFSET, addr);
+		else
+			ppc44x_pin_tlb(addr + PAGE_OFFSET, addr);
+	}
+	if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
+		ppc47x_update_boltmap();
 
+#ifdef DEBUG
+		{
+			int i;
+
+			printk(KERN_DEBUG "bolted entries: ");
+			for (i = 0; i < 255; i++) {
+				if (test_bit(i, tlb_47x_boltmap))
+					printk("%d ", i);
+			}
+			printk("\n");
+		}
+#endif /* DEBUG */
+	}
 	return total_lowmem;
 }
+
+#ifdef CONFIG_SMP
+void __cpuinit mmu_init_secondary(int cpu)
+{
+	unsigned long addr;
+
+	/* Pin in enough TLBs to cover any lowmem not covered by the
+	 * initial 256M mapping established in head_44x.S
+	 *
+	 * WARNING: This is called with only the first 256M of the
+	 * linear mapping in the TLB and we can't take faults yet
+	 * so beware of what this code uses. It runs off a temporary
+	 * stack. current (r2) isn't initialized, smp_processor_id()
+	 * will not work, current thread info isn't accessible, ...
+	 */
+	for (addr = PPC_PIN_SIZE; addr < lowmem_end_addr;
+	     addr += PPC_PIN_SIZE) {
+		if (mmu_has_feature(MMU_FTR_TYPE_47x))
+			ppc47x_pin_tlb(addr + PAGE_OFFSET, addr);
+		else
+			ppc44x_pin_tlb(addr + PAGE_OFFSET, addr);
+	}
+}
+#endif /* CONFIG_SMP */
diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 1044a63..49e7b2f 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -394,10 +394,18 @@ void __init mmu_context_init(void)
 	 * the PID/TID comparison is disabled, so we can use a TID of zero
 	 * to represent all kernel pages as shared among all contexts.
 	 * 	-- Dan
+	 *
+	 * The IBM 47x core supports 16-bit PIDs, thus 65535 contexts. We
+	 * should normally never have to steal though the facility is
+	 * present if needed.
+	 *      -- BenH
 	 */
 	if (mmu_has_feature(MMU_FTR_TYPE_8xx)) {
 		first_context = 0;
 		last_context = 15;
+	} else if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
+		first_context = 1;
+		last_context = 65535;
 	} else {
 		first_context = 1;
 		last_context = 255;
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index d49a775..eb11d5d 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -69,12 +69,7 @@ static inline void _tlbil_va(unsigned long address, unsigned int pid,
 }
 #endif /* CONIFG_8xx */
 
-/*
- * As of today, we don't support tlbivax broadcast on any
- * implementation. When that becomes the case, this will be
- * an extern.
- */
-#ifdef CONFIG_PPC_BOOK3E
+#if defined(CONFIG_PPC_BOOK3E) || defined(CONFIG_PPC_47x)
 extern void _tlbivax_bcast(unsigned long address, unsigned int pid,
 			   unsigned int tsize, unsigned int ind);
 #else
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index bbdc5b5..e925cb5 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -10,7 +10,7 @@
  *	- tlbil_va
  *	- tlbil_pid
  *	- tlbil_all
- *	- tlbivax_bcast (not yet)
+ *	- tlbivax_bcast
  *
  * Code mostly moved over from misc_32.S
  *
@@ -33,6 +33,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor.h>
+#include <asm/bug.h>
 
 #if defined(CONFIG_40x)
 
@@ -65,7 +66,7 @@ _GLOBAL(__tlbil_va)
  * Nothing to do for 8xx, everything is inline
  */
 
-#elif defined(CONFIG_44x)
+#elif defined(CONFIG_44x) /* Includes 47x */
 
 /*
  * 440 implementation uses tlbsx/we for tlbil_va and a full sweep
@@ -73,7 +74,13 @@ _GLOBAL(__tlbil_va)
  */
 _GLOBAL(__tlbil_va)
 	mfspr	r5,SPRN_MMUCR
-	rlwimi	r5,r4,0,24,31			/* Set TID */
+	mfmsr   r10
+
+	/*
+	 * We write 16 bits of STID since 47x supports that much, we
+	 * will never be passed out of bounds values on 440 (hopefully)
+	 */
+	rlwimi  r5,r4,0,16,31
 
 	/* We have to run the search with interrupts disabled, otherwise
 	 * an interrupt which causes a TLB miss can clobber the MMUCR
@@ -83,24 +90,41 @@ _GLOBAL(__tlbil_va)
 	 * and restoring MMUCR, so only normal interrupts have to be
 	 * taken care of.
 	 */
-	mfmsr	r4
 	wrteei	0
 	mtspr	SPRN_MMUCR,r5
-	tlbsx.	r3, 0, r3
-	wrtee	r4
-	bne	1f
+	tlbsx.	r6,0,r3
+	bne	10f
 	sync
-	/* There are only 64 TLB entries, so r3 < 64,
-	 * which means bit 22, is clear.  Since 22 is
-	 * the V bit in the TLB_PAGEID, loading this
+BEGIN_MMU_FTR_SECTION
+	b	2f
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
+	/* On 440 There are only 64 TLB entries, so r3 < 64, which means bit
+	 * 22, is clear.  Since 22 is the V bit in the TLB_PAGEID, loading this
 	 * value will invalidate the TLB entry.
 	 */
-	tlbwe	r3, r3, PPC44x_TLB_PAGEID
+	tlbwe	r6,r6,PPC44x_TLB_PAGEID
 	isync
-1:	blr
+10:	wrtee	r10
+	blr
+2:
+#ifdef CONFIG_PPC_47x
+	oris	r7,r6,0x8000	/* specify way explicitely */
+	clrrwi	r4,r3,12	/* get an EPN for the hashing with V = 0 */
+	ori	r4,r4,PPC47x_TLBE_SIZE
+	tlbwe   r4,r7,0		/* write it */
+	isync
+	wrtee	r10
+	blr
+#else /* CONFIG_PPC_47x */
+1:	trap
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0;
+#endif /* !CONFIG_PPC_47x */
 
 _GLOBAL(_tlbil_all)
 _GLOBAL(_tlbil_pid)
+BEGIN_MMU_FTR_SECTION
+	b	2f
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 	li	r3,0
 	sync
 
@@ -115,6 +139,76 @@ _GLOBAL(_tlbil_pid)
 
 	isync
 	blr
+2:
+#ifdef CONFIG_PPC_47x
+	/* 476 variant. There's not simple way to do this, hopefully we'll
+	 * try to limit the amount of such full invalidates
+	 */
+	mfmsr	r11		/* Interrupts off */
+	wrteei	0
+	li	r3,-1		/* Current set */
+	lis	r10,tlb_47x_boltmap@h
+	ori	r10,r10,tlb_47x_boltmap@l
+	lis	r7,0x8000	/* Specify way explicitely */
+
+	b	9f		/* For each set */
+
+1:	li	r9,4		/* Number of ways */
+	li	r4,0		/* Current way */
+	li	r6,0		/* Default entry value 0 */
+	andi.	r0,r8,1		/* Check if way 0 is bolted */
+	mtctr	r9		/* Load way counter */
+	bne-	3f		/* Bolted, skip loading it */
+
+2:	/* For each way */
+	or	r5,r3,r4	/* Make way|index for tlbre */
+	rlwimi	r5,r5,16,8,15	/* Copy index into position */
+	tlbre	r6,r5,0		/* Read entry */
+3:	addis	r4,r4,0x2000	/* Next way */
+	andi.	r0,r6,PPC47x_TLB0_VALID /* Valid entry ? */
+	beq	4f		/* Nope, skip it */
+	rlwimi	r7,r5,0,1,2	/* Insert way number */
+	rlwinm	r6,r6,0,21,19	/* Clear V */
+	tlbwe   r6,r7,0		/* Write it */
+4:	bdnz	2b		/* Loop for each way */
+	srwi	r8,r8,1		/* Next boltmap bit */
+9:	cmpwi	cr1,r3,255	/* Last set done ? */
+	addi	r3,r3,1		/* Next set */
+	beq	cr1,1f		/* End of loop */
+	andi.	r0,r3,0x1f	/* Need to load a new boltmap word ? */
+	bne	1b		/* No, loop */
+	lwz	r8,0(r10)	/* Load boltmap entry */
+	addi	r10,r10,4	/* Next word */
+	b	1b		/* Then loop */
+1:	isync			/* Sync shadows */
+	wrtee	r11
+#else /* CONFIG_PPC_47x */
+1:	trap
+	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0;
+#endif /* !CONFIG_PPC_47x */
+	blr
+
+#ifdef CONFIG_PPC_47x
+/*
+ * _tlbivax_bcast is only on 47x. We don't bother doing a runtime
+ * check though, it will blow up soon enough if we mistakenly try
+ * to use it on a 440.
+ */
+_GLOBAL(_tlbivax_bcast)
+	mfspr	r5,SPRN_MMUCR
+	mfmsr	r10
+	rlwimi	r5,r4,0,16,31
+	wrteei	0
+	mtspr	SPRN_MMUCR,r5
+/*	tlbivax	0,r3 - use .long to avoid binutils deps */
+	.long 0x7c000624 | (r3 << 11)
+	isync
+	eieio
+	tlbsync
+	sync
+	wrtee	r10
+	blr
+#endif /* CONFIG_PPC_47x */
 
 #elif defined(CONFIG_FSL_BOOKE)
 /*
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 7486bff..1dfc1c1 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -1,6 +1,17 @@
+config PPC_44x_46x
+	bool "Support for 44x and 46x variants"
+	depends on 44x
+	default n
+
+config PPC_47x
+	bool "Support for 47x variant"
+	depends on 44x
+	select MPIC
+	default n
+
 config BAMBOO
 	bool "Bamboo"
-	depends on 44x
+	depends on PPC_44x_46x
 	default n
 	select PPC44x_SIMPLE
 	select 440EP
@@ -10,7 +21,7 @@ config BAMBOO
 
 config EBONY
 	bool "Ebony"
-	depends on 44x
+	depends on PPC_44x_46x
 	default y
 	select 440GP
 	select PCI
@@ -20,7 +31,7 @@ config EBONY
 
 config SAM440EP
         bool "Sam440ep"
-	depends on 44x
+	depends on PPC_44x_46x
         default n
         select 440EP
         select PCI
@@ -29,7 +40,7 @@ config SAM440EP
 
 config SEQUOIA
 	bool "Sequoia"
-	depends on 44x
+	depends on PPC_44x_46x
 	default n
 	select PPC44x_SIMPLE
 	select 440EPX
@@ -38,7 +49,7 @@ config SEQUOIA
 
 config TAISHAN
 	bool "Taishan"
-	depends on 44x
+	depends on PPC_44x_46x
 	default n
 	select PPC44x_SIMPLE
 	select 440GX
@@ -49,7 +60,7 @@ config TAISHAN
 
 config KATMAI
 	bool "Katmai"
-	depends on 44x
+	depends on PPC_44x_46x
 	default n
 	select PPC44x_SIMPLE
 	select 440SPe
@@ -60,7 +71,7 @@ config KATMAI
 
 config RAINIER
 	bool "Rainier"
-	depends on 44x
+	depends on PPC_44x_46x
 	default n
 	select PPC44x_SIMPLE
 	select 440GRX
@@ -70,7 +81,7 @@ config RAINIER
 
 config WARP
 	bool "PIKA Warp"
-	depends on 44x
+	depends on PPC_44x_46x
 	default n
 	select 440EP
 	help
@@ -94,7 +105,7 @@ config ARCHES
 
 config CANYONLANDS
 	bool "Canyonlands"
-	depends on 44x
+	depends on PPC_44x_46x
 	default n
 	select PPC44x_SIMPLE
 	select 460EX
@@ -143,7 +154,7 @@ config EIGER
 
 config YOSEMITE
 	bool "Yosemite"
-	depends on 44x
+	depends on PPC_44x_46x
 	default n
 	select PPC44x_SIMPLE
 	select 440EP
@@ -153,7 +164,7 @@ config YOSEMITE
 
 #config LUAN
 #	bool "Luan"
-#	depends on 44x
+#	depends on PPC_44x_46x
 #	default n
 #	select 440SP
 #	help
@@ -161,7 +172,7 @@ config YOSEMITE
 
 #config OCOTEA
 #	bool "Ocotea"
-#	depends on 44x
+#	depends on PPC_44x_46x
 #	default n
 #	select 440GX
 #	help
@@ -169,7 +180,7 @@ config YOSEMITE
 
 config XILINX_VIRTEX440_GENERIC_BOARD
 	bool "Generic Xilinx Virtex 5 FXT board support"
-	depends on 44x
+	depends on PPC_44x_46x
 	default n
 	select XILINX_VIRTEX_5_FXT
 	help
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index fa0f690..cf84169 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -43,7 +43,7 @@ config 40x
 	select PPC_PCI_CHOICE
 
 config 44x
-	bool "AMCC 44x"
+	bool "AMCC 44x, 46x or 47x"
 	select PPC_DCR_NATIVE
 	select PPC_UDBG_16550
 	select 4xx_SOC
@@ -284,7 +284,7 @@ config PPC_PERF_CTRS
          This enables the powerpc-specific perf_event back-end.
 
 config SMP
-	depends on PPC_BOOK3S || PPC_BOOK3E || FSL_BOOKE
+	depends on PPC_BOOK3S || PPC_BOOK3E || FSL_BOOKE || PPC_47x
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
@@ -312,6 +312,7 @@ config NR_CPUS
 config NOT_COHERENT_CACHE
 	bool
 	depends on 4xx || 8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
+	default n if PPC_47x
 	default y
 
 config CHECK_CACHE_COHERENCY

-- 
Dave Kleikamp
IBM Linux Technology Center

Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Fri, 5 Mar 2010 13:43:24 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100305204324.18424.40814.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
References: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
Subject: [PATCH 05/13] powerpc/476: Add isync after loading mmu and debug spr's
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/476: Add isync after loading mmu and debug spr's

From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

476 requires an isync after loading MMU and debug related SPR's.  Some of
these are in performance-critical paths and may need to be optimized, but
initially, we're playing it safe.

Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/head_44x.S   |    8 ++++++++
 arch/powerpc/kernel/kprobes.c    |    3 +++
 arch/powerpc/kernel/process.c    |    3 +++
 arch/powerpc/kernel/traps.c      |    6 ++++++
 arch/powerpc/mm/44x_mmu.c        |    1 +
 arch/powerpc/mm/tlb_nohash_low.S |    3 +++
 6 files changed, 24 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 1acd175..992e9d5 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -464,6 +464,9 @@ finish_tlb_load_44x:
 	lwz	r11,PGDIR(r11)
 	mfspr   r12,SPRN_PID		/* Get PID */
 4:	mtspr	SPRN_MMUCR,r12		/* Set MMUCR */
+#ifdef CONFIG_PPC_47x
+	isync
+#endif
 
 	/* Mask of required permission bits. Note that while we
 	 * do copy ESR:ST to _PAGE_RW position as trying to write
@@ -561,6 +564,9 @@ finish_tlb_load_44x:
 	lwz	r11,PGDIR(r11)
 	mfspr   r12,SPRN_PID		/* Get PID */
 4:	mtspr	SPRN_MMUCR,r12		/* Set MMUCR */
+#ifdef CONFIG_PPC_47x
+	isync
+#endif
 
 	/* Make up the required permissions */
 	li	r13,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
@@ -1031,6 +1037,7 @@ clear_utlb_entry:
 	mtspr	SPRN_USPCR,r3
 	LOAD_REG_IMMEDIATE(r3, 0x12345670)
 	mtspr	SPRN_ISPCR,r3
+	isync	/* 476 needs this */
 
 	/* Force context change */
 	mfmsr	r0
@@ -1116,6 +1123,7 @@ head_start_common:
 	/* Establish the interrupt vector base */
 	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
 	mtspr	SPRN_IVPR,r4
+	isync	/* 476 needs this */
 
 	addis	r22,r22,KERNELBASE@h
 	mtlr	r22
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index c932978..7fec5db 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -113,6 +113,9 @@ static void __kprobes prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
 #ifdef CONFIG_BOOKE
 	regs->msr &= ~MSR_CE;
 	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
+#ifdef CONFIG_PPC_47x
+	isync();
+#endif
 #endif
 
 	/*
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 7b816da..15ee756 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -286,6 +286,9 @@ int set_dabr(unsigned long dabr)
 	/* XXX should we have a CPU_FTR_HAS_DABR ? */
 #if defined(CONFIG_BOOKE)
 	mtspr(SPRN_DAC1, dabr);
+#ifdef CONFIG_PPC_47x
+	isync();
+#endif
 #elif defined(CONFIG_PPC_BOOK3S)
 	mtspr(SPRN_DABR, dabr);
 #endif
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 21ed77b..9957c44 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1080,6 +1080,9 @@ void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_BT);
 		/* Clear the BT event */
 		mtspr(SPRN_DBSR, DBSR_BT);
+#ifdef CONFIG_PPC_47x
+		isync();
+#endif
 
 		/* Do the single step trick only when coming from userspace */
 		if (user_mode(regs)) {
@@ -1102,6 +1105,9 @@ void __kprobes DebugException(struct pt_regs *regs, unsigned long debug_status)
 		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
 		/* Clear the instruction completion event */
 		mtspr(SPRN_DBSR, DBSR_IC);
+#ifdef CONFIG_PPC_47x
+		isync();
+#endif
 
 		if (notify_die(DIE_SSTEP, "single_step", regs, 5,
 			       5, SIGTRAP) == NOTIFY_STOP) {
diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index d8c6efb..a5f082a 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -156,6 +156,7 @@ static void __cpuinit ppc47x_pin_tlb(unsigned int virt, unsigned int phys)
 		 virt, phys, bolted);
 
 	mtspr(SPRN_MMUCR, 0);
+	isync();
 
 	__asm__ __volatile__(
 		"tlbwe	%2,%3,0\n"
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index e925cb5..7c890f7 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -92,6 +92,9 @@ _GLOBAL(__tlbil_va)
 	 */
 	wrteei	0
 	mtspr	SPRN_MMUCR,r5
+#ifdef CONFIG_PPC_47x
+	isync
+#endif
 	tlbsx.	r6,0,r3
 	bne	10f
 	sync

-- 
Dave Kleikamp
IBM Linux Technology Center

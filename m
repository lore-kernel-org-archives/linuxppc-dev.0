Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 866482C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 11:24:17 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: [PATCH v3 6/7] powerpc/fsl_booke: make sure PAGE_OFFSET map to
 memstart_addr for relocatable kernel
Date: Wed, 7 Aug 2013 09:18:34 +0800
Message-ID: <1375838315-27797-7-git-send-email-haokexin@gmail.com>
In-Reply-To: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
References: <1375838315-27797-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is always true for a non-relocatable kernel. Otherwise the kernel
would get stuck. But for a relocatable kernel, it seems a little
complicated. When booting a relocatable kernel, we just align the
kernel start addr to 64M and map the PAGE_OFFSET from there. The
relocation will base on this virtual address. But if this address
is not the same as the memstart_addr, we will have to change the
map of PAGE_OFFSET to the real memstart_addr and do another relocation
again.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v3:
  * Typo fix.
  * Refactor relocate_init, no function change.
  * Map only 64M memory before the second relocation.
  * Comments update.

v2: A new patch in v2.

 arch/powerpc/kernel/head_fsl_booke.S | 75 +++++++++++++++++++++++++++++++++---
 arch/powerpc/mm/fsl_booke_mmu.c      | 37 +++++++++++++++---
 arch/powerpc/mm/mmu_decl.h           |  2 +-
 3 files changed, 102 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 7e9724e..c3989d9 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -84,6 +84,39 @@ _ENTRY(_start);
 	mr	r23,r3
 	mr	r25,r4
 
+	bl	0f
+0:	mflr	r8
+	addis	r3,r8,(is_second_reloc - 0b)@ha
+	lwz	r19,(is_second_reloc - 0b)@l(r3)
+
+	/* Check if this is the second relocation. */
+	cmpwi	r19,1
+	bne	1f
+
+	/*
+	 * For the second relocation, we already get the real memstart_addr
+	 * from device tree. So we will map PAGE_OFFSET to memstart_addr,
+	 * then the virtual address of start kernel should be:
+	 *          PAGE_OFFSET + (kernstart_addr - memstart_addr)
+	 * Since the offset between kernstart_addr and memstart_addr should
+	 * never be beyond 1G, so we can just use the lower 32bit of them
+	 * for the calculation.
+	 */
+	lis	r3,PAGE_OFFSET@h
+
+	addis	r4,r8,(kernstart_addr - 0b)@ha
+	addi	r4,r4,(kernstart_addr - 0b)@l
+	lwz	r5,4(r4)
+
+	addis	r6,r8,(memstart_addr - 0b)@ha
+	addi	r6,r6,(memstart_addr - 0b)@l
+	lwz	r7,4(r6)
+
+	subf	r5,r7,r5
+	add	r3,r3,r5
+	b	2f
+
+1:
 	/*
 	 * We have the runtime (virutal) address of our base.
 	 * We calculate our shift of offset from a 64M page.
@@ -97,7 +130,7 @@ _ENTRY(_start);
 	subf	r3,r5,r6			/* r3 = r6 - r5 */
 	add	r3,r4,r3			/* Required Virtual Address */
 
-	bl	relocate
+2:	bl	relocate
 #endif
 
 /* We try to not make any assumptions about how the boot loader
@@ -121,10 +154,19 @@ _ENTRY(_start);
 
 _ENTRY(__early_start)
 
+#ifdef CONFIG_RELOCATABLE
+	/*
+	 * For the second relocation, we already set the right tlb entries
+	 * for the kernel space, so skip the code in fsl_booke_entry_mapping.S
+	*/
+	cmpwi	r19,1
+	beq	set_ivor
+#endif
 #define ENTRY_MAPPING_BOOT_SETUP
 #include "fsl_booke_entry_mapping.S"
 #undef ENTRY_MAPPING_BOOT_SETUP
 
+set_ivor:
 	/* Establish the interrupt vector offsets */
 	SET_IVOR(0,  CriticalInput);
 	SET_IVOR(1,  MachineCheck);
@@ -210,11 +252,13 @@ _ENTRY(__early_start)
 	bl	early_init
 
 #ifdef CONFIG_RELOCATABLE
+	mr	r3,r30
+	mr	r4,r31
 #ifdef CONFIG_PHYS_64BIT
-	mr	r3,r23
-	mr	r4,r25
+	mr	r5,r23
+	mr	r6,r25
 #else
-	mr	r3,r25
+	mr	r5,r25
 #endif
 	bl	relocate_init
 #endif
@@ -1220,6 +1264,9 @@ _GLOBAL(switch_to_as1)
 /*
  * Restore to the address space 0 and also invalidate the tlb entry created
  * by switch_to_as1.
+ * r3 - the tlb entry which should be invalidated
+ * r4 - __pa(PAGE_OFFSET in AS0) - __pa(PAGE_OFFSET in AS1)
+ * r5 - device tree virtual address. If r4 is 0, r5 is ignored.
 */
 _GLOBAL(restore_to_as0)
 	mflr	r0
@@ -1228,7 +1275,15 @@ _GLOBAL(restore_to_as0)
 0:	mflr	r9
 	addi	r9,r9,1f - 0b
 
-	mfmsr	r7
+	/*
+	 * We may map the PAGE_OFFSET in AS0 to a different physical address,
+	 * so we need calculate the right jump and device tree address based
+	 * on the offset passed by r4.
+	 */
+	subf	r9,r4,r9
+	subf	r5,r4,r5
+
+2:	mfmsr	r7
 	li	r8,(MSR_IS | MSR_DS)
 	andc	r7,r7,r8
 
@@ -1247,9 +1302,19 @@ _GLOBAL(restore_to_as0)
 	mtspr	SPRN_MAS1,r9
 	tlbwe
 	isync
+
+	cmpwi	r4,0
+	bne	3f
 	mtlr	r0
 	blr
 
+	/*
+	 * The PAGE_OFFSET will map to a different physical address,
+	 * jump to _start to do another relocation again.
+	*/
+3:	mr	r3,r5
+	bl	_start
+
 /*
  * We put a few things here that have to be page-aligned. This stuff
  * goes at the beginning of the data segment, which is page-aligned.
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 1d54f6d..048d716 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -224,7 +224,7 @@ void __init adjust_total_lowmem(void)
 
 	i = switch_to_as1();
 	__max_low_memory = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
-	restore_to_as0(i);
+	restore_to_as0(i, 0, 0);
 
 	pr_info("Memory CAM mapping: ");
 	for (i = 0; i < tlbcam_index - 1; i++)
@@ -245,17 +245,25 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 }
 
 #ifdef CONFIG_RELOCATABLE
-notrace void __init relocate_init(phys_addr_t start)
+int __initdata is_second_reloc;
+notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
 {
 	unsigned long base = KERNELBASE;
 
+	kernstart_addr = start;
+	if (is_second_reloc) {
+		virt_phys_offset = PAGE_OFFSET - memstart_addr;
+		return;
+	}
+
 	/*
 	 * Relocatable kernel support based on processing of dynamic
-	 * relocation entries.
-	 * Compute the virt_phys_offset :
+	 * relocation entries. Before we get the real memstart_addr,
+	 * We will compute the virt_phys_offset like this:
 	 * virt_phys_offset = stext.run - kernstart_addr
 	 *
-	 * stext.run = (KERNELBASE & ~0x3ffffff) + (kernstart_addr & 0x3ffffff)
+	 * stext.run = (KERNELBASE & ~0x3ffffff) +
+	 *				(kernstart_addr & 0x3ffffff)
 	 * When we relocate, we have :
 	 *
 	 *	(kernstart_addr & 0x3ffffff) = (stext.run & 0x3ffffff)
@@ -265,10 +273,27 @@ notrace void __init relocate_init(phys_addr_t start)
 	 *                              (kernstart_addr & ~0x3ffffff)
 	 *
 	 */
-	kernstart_addr = start;
 	start &= ~0x3ffffff;
 	base &= ~0x3ffffff;
 	virt_phys_offset = base - start;
+	early_get_first_memblock_info(__va(dt_ptr), NULL);
+	/*
+	 * We now get the memstart_addr, then we should check if this
+	 * address is the same as what the PAGE_OFFSET map to now. If
+	 * not we have to change the map of PAGE_OFFSET to memstart_addr
+	 * and do a second relocation.
+	 */
+	if (start != memstart_addr) {
+		int n, offset = memstart_addr - start;
+
+		is_second_reloc = 1;
+		n = switch_to_as1();
+		/* map a 64M area for the second relocation */
+		map_mem_in_cams(0x4000000UL, CONFIG_LOWMEM_CAM_NUM);
+		restore_to_as0(n, offset, __va(dt_ptr));
+		/* We should never reach here */
+		panic("Relocation error");
+	}
 }
 #endif
 #endif
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index eefbf7b..91da910 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -149,7 +149,7 @@ extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(unsigned long top);
 extern void adjust_total_lowmem(void);
 extern int switch_to_as1(void);
-extern void restore_to_as0(int esel);
+extern void restore_to_as0(int esel, int offset, void *dt_ptr);
 #endif
 extern void loadcam_entry(unsigned int index);
 
-- 
1.8.3.1

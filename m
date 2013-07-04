Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C1812C0420
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 22:55:52 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 7/8] powerpc/fsl_booke: make sure PAGE_OFFSET map to
 memstart_addr for relocatable kernel
Date: Thu, 4 Jul 2013 20:54:13 +0800
Message-ID: <1372942454-25191-8-git-send-email-haokexin@gmail.com>
In-Reply-To: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
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
kernel start addr to 256M and map the PAGE_OFFSET from there. The
relocation will base on this virtual address. But if this address
is not the same as the memstart_addr, we will have to change the
map of PAGE_OFFSET to the real memstart_addr and do another relocation
again.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
A new patch in v2.

 arch/powerpc/kernel/head_fsl_booke.S | 75 +++++++++++++++++++++++++++++++++---
 arch/powerpc/mm/fsl_booke_mmu.c      | 68 ++++++++++++++++++++++----------
 arch/powerpc/mm/mmu_decl.h           |  2 +-
 3 files changed, 118 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 0cbfe95..00cfb7e 100644
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
 	 * We calculate our shift of offset from a 256M page.
@@ -97,7 +130,7 @@ _ENTRY(_start);
 	subf	r3,r5,r6			/* r3 = r6 - r5 */
 	add	r3,r4,r3			/* Required Virutal Address */
 
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
@@ -1222,6 +1266,9 @@ _GLOBAL(switch_to_as1)
 /*
  * Restore to the address space 0 and also invalidate the tlb entry created
  * by switch_to_as1.
+ * r3 - the tlb entry which should be invalidated
+ * r4 - __pa(PAGE_OFFSET in AS0) - pa(PAGE_OFFSET in AS1)
+ * r5 - device tree virtual address
 */
 _GLOBAL(restore_to_as0)
 	mflr	r0
@@ -1230,7 +1277,15 @@ _GLOBAL(restore_to_as0)
 0:	mflr	r9
 	addi	r9,r9,1f - 0b
 
-	mfmsr	r7
+	/*
+	 * We may map the PAGE_OFFSET in AS0 to a different physical address,
+	 * so we need calculate the right jump and device tree address based
+	 * on the offset passed by r4.
+	*/
+	subf	r9,r4,r9
+	subf	r5,r4,r5
+
+2:	mfmsr	r7
 	li	r8,(MSR_IS | MSR_DS)
 	andc	r7,r7,r8
 
@@ -1249,9 +1304,19 @@ _GLOBAL(restore_to_as0)
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
index 8f60ef8..dd283fd 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -224,7 +224,7 @@ void __init adjust_total_lowmem(void)
 
 	i = switch_to_as1();
 	__max_low_memory = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
-	restore_to_as0(i);
+	restore_to_as0(i, 0, 0);
 
 	pr_info("Memory CAM mapping: ");
 	for (i = 0; i < tlbcam_index - 1; i++)
@@ -245,30 +245,56 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 }
 
 #ifdef CONFIG_RELOCATABLE
-notrace void __init relocate_init(phys_addr_t start)
+int __initdata is_second_reloc;
+notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
 {
 	unsigned long base = KERNELBASE;
 
-	/*
-	 * Relocatable kernel support based on processing of dynamic
-	 * relocation entries.
-	 * Compute the virt_phys_offset :
-	 * virt_phys_offset = stext.run - kernstart_addr
-	 *
-	 * stext.run = (KERNELBASE & ~0xfffffff) + (kernstart_addr & 0xfffffff)
-	 * When we relocate, we have :
-	 *
-	 *	(kernstart_addr & 0xfffffff) = (stext.run & 0xfffffff)
-	 *
-	 * hence:
-	 *  virt_phys_offset = (KERNELBASE & ~0xfffffff) -
-	 *                              (kernstart_addr & ~0xfffffff)
-	 *
-	 */
 	kernstart_addr = start;
-	start &= ~0xfffffff;
-	base &= ~0xfffffff;
-	virt_phys_offset = base - start;
+	if (!is_second_reloc) {
+		phys_addr_t size;
+
+		/*
+		 * Relocatable kernel support based on processing of dynamic
+		 * relocation entries. Before we get the real memstart_addr,
+		 * We will compute the virt_phys_offset like this:
+		 * virt_phys_offset = stext.run - kernstart_addr
+		 *
+		 * stext.run = (KERNELBASE & ~0xfffffff) +
+		 *				(kernstart_addr & 0xfffffff)
+		 * When we relocate, we have :
+		 *
+		 *	(kernstart_addr & 0xfffffff) = (stext.run & 0xfffffff)
+		 *
+		 * hence:
+		 *  virt_phys_offset = (KERNELBASE & ~0xfffffff) -
+		 *                              (kernstart_addr & ~0xfffffff)
+		 *
+		 */
+		start &= ~0xfffffff;
+		base &= ~0xfffffff;
+		virt_phys_offset = base - start;
+		early_get_first_memblock_info(__va(dt_ptr), &size);
+		/*
+		 * We now get the memstart_addr, then we should check if this
+		 * address is the same as what the PAGE_OFFSET map to now. If
+		 * not we have to change the map of PAGE_OFFSET to memstart_addr
+		 * and do a second relocation.
+		 */
+		if (start != memstart_addr) {
+			unsigned long ram;
+			int n, offset = memstart_addr - start;
+
+			is_second_reloc = 1;
+			ram = size;
+			n = switch_to_as1();
+			map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
+			restore_to_as0(n, offset, __va(dt_ptr));
+			/* We should never reach here */
+			panic("Relocation error");
+		}
+	} else
+		virt_phys_offset = PAGE_OFFSET - memstart_addr;
 }
 #endif
 #endif
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 3a65644..8280dbb 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -149,7 +149,7 @@ extern void MMU_init_hw(void);
 extern unsigned long mmu_mapin_ram(unsigned long top);
 extern void adjust_total_lowmem(void);
 extern int switch_to_as1(void);
-extern void restore_to_as0(int);
+extern void restore_to_as0(int, int, void *);
 #endif
 extern void loadcam_entry(unsigned int index);
 
-- 
1.8.1.4

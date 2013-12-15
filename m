Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 264012C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 02:10:02 +1100 (EST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, scottwood@freescale.com
Subject: [RFC PATCH v3] powerpc: Loading kernels over 8Mbytes without
 CONFIG_PIN_TLB
Message-Id: <20131215150957.1F5C143E5B@localhost.localdomain>
Date: Sun, 15 Dec 2013 16:09:57 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hereunder is a try to implement the sizing of the initial memory size based=
 on
initial-mapped-area size given by uboot in r7.
As this has an impact on all powerpc platforms due to the need to provide t=
he
info up to function setup_initial_memory_limit(), I'm not completly sure of=
 the
proper implementation.
Thanks to provide comments.

Today on the 8xx, the only way to load kernels whose size is greater than
8Mbytes is to activate CONFIG_PIN_TLB. Otherwise, the physical memory initi=
ally
mapped is limited to 8Mbytes. This patch uses the size of initial memory ma=
pped
by the bootloader and given to the kernel through register r7.
This is done regardless of whether CONFIG_PIN_TLB is active or not. It allo=
ws to
load "big" kernels (for instance when activating CONFIG_LOCKDEP_SUPPORT) wi=
thout
having to activate CONFIG_PIN_TLB.

Not-yet-signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Index: linux/arch/powerpc/include/asm/mmu.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/arch/powerpc/include/asm/mmu.h	(revision 5484)
+++ linux/arch/powerpc/include/asm/mmu.h	(copie de travail)
@@ -138,7 +138,8 @@
 extern void early_init_mmu_secondary(void);
 
 extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-				       phys_addr_t first_memblock_size);
+				       phys_addr_t first_memblock_size,
+				       u64 init_mem_size);
 
 #ifdef CONFIG_PPC64
 /* This is our real memory area size on ppc64 server, on embedded, we
Index: linux/arch/powerpc/kernel/head_8xx.S
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/arch/powerpc/kernel/head_8xx.S	(revision 5484)
+++ linux/arch/powerpc/kernel/head_8xx.S	(copie de travail)
@@ -31,6 +31,8 @@
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 
+#define EPAPR_MAGIC	0x65504150
+
 /* Macro to make the code more readable. */
 #ifdef CONFIG_8xx_CPU6
 #define DO_8xx_CPU6(val, reg)	\
@@ -77,10 +79,19 @@
 	.globl	__start
 __start:
 	mr	r31,r3			/* save device tree ptr */
+	li	r30,0
 
+	lis	r8,EPAPR_MAGIC@h
+	ori	r8,r8, EPAPR_MAGIC@l
+	cmpw	cr0,r8, r6
+	bne	1f
+
+	mr	r30,r7			/* save initial ram size */
+
 	/* We have to turn on the MMU right away so we get cache modes
 	 * set correctly.
 	 */
+1:
 	bl	initial_mmu
 
 /* We now have the lower 8 Meg mapped into TLB entries, and the caches
@@ -717,6 +728,8 @@
  */
 	li	r3,0
 	mr	r4,r31
+	li	r5,0
+	mr	r6,r30
 	bl	machine_init
 	bl	MMU_init
 
@@ -841,11 +854,17 @@
 	ori	r8, r8, MI_BOOTINIT|0x2 /* Inhibit cache -- Cort */
 	mtspr	SPRN_MD_RPN, r8
 
+	/* Map two more 8M kernel data pages if needed
+	 * We check how much memory is mapped by the bootloader
+	*/
+	lis	r8, 0x0100
+	cmplw	cr0, r8, r30
+	blt	2f
+
 #ifdef CONFIG_PIN_TLB
-	/* Map two more 8M kernel data pages.
-	*/
 	addi	r10, r10, 0x0100
 	mtspr	SPRN_MD_CTR, r10
+#endif
 
 	lis	r8, KERNELBASE@h	/* Create vaddr for TLB */
 	addis	r8, r8, 0x0080		/* Add 8M */
@@ -858,20 +877,26 @@
 	addis	r11, r11, 0x0080	/* Add 8M */
 	mtspr	SPRN_MD_RPN, r11
 
+	lis	r8, 0x0180
+	cmplw	cr0, r8, r30
+	blt	2f
+
+#ifdef CONFIG_PIN_TLB
 	addi	r10, r10, 0x0100
 	mtspr	SPRN_MD_CTR, r10
+#endif
 
 	addis	r8, r8, 0x0080		/* Add 8M */
 	mtspr	SPRN_MD_EPN, r8
 	mtspr	SPRN_MD_TWC, r9
 	addis	r11, r11, 0x0080	/* Add 8M */
 	mtspr	SPRN_MD_RPN, r11
-#endif
 
 	/* Since the cache is enabled according to the information we
 	 * just loaded into the TLB, invalidate and enable the caches here.
 	 * We should probably check/set other modes....later.
 	 */
+2:
 	lis	r8, IDC_INVALL@h
 	mtspr	SPRN_IC_CST, r8
 	mtspr	SPRN_DC_CST, r8
Index: linux/arch/powerpc/kernel/prom.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/arch/powerpc/kernel/prom.c	(revision 5484)
+++ linux/arch/powerpc/kernel/prom.c	(copie de travail)
@@ -649,7 +649,7 @@
 	}
 }
 
-void __init early_init_devtree(void *params)
+void __init early_init_devtree(void *params, u64 init_mem_size)
 {
 	phys_addr_t limit;
 
@@ -697,7 +697,7 @@
 	/* make sure we've parsed cmdline for mem=3D before this */
 	if (memory_limit)
 		first_memblock_size =3D min_t(u64, first_memblock_size, memory_limit);
-	setup_initial_memory_limit(memstart_addr, first_memblock_size);
+	setup_initial_memory_limit(memstart_addr, first_memblock_size, init_mem_s=
ize);
 	/* Reserve MEMBLOCK regions used by kernel, initrd, dt, etc... */
 	memblock_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
 	/* If relocatable, reserve first 32k for interrupt vectors etc. */
Index: linux/arch/powerpc/kernel/setup_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/arch/powerpc/kernel/setup_32.c	(revision 5484)
+++ linux/arch/powerpc/kernel/setup_32.c	(copie de travail)
@@ -119,7 +119,7 @@
  * This is called very early on the boot process, after a minimal
  * MMU environment has been set up but before MMU_init is called.
  */
-notrace void __init machine_init(u64 dt_ptr)
+notrace void __init machine_init(u64 dt_ptr, u64 init_mem_size)
 {
 	lockdep_init();
 
@@ -127,7 +127,7 @@
 	udbg_early_init();
 
 	/* Do some early initialization based on the flat device tree */
-	early_init_devtree(__va(dt_ptr));
+	early_init_devtree(__va(dt_ptr), init_mem_size);
 
 	epapr_paravirt_early_init();
 
Index: linux/arch/powerpc/kernel/setup_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/arch/powerpc/kernel/setup_64.c	(revision 5484)
+++ linux/arch/powerpc/kernel/setup_64.c	(copie de travail)
@@ -185,7 +185,7 @@
  * device-tree is not accessible via normal means at this point.
  */
 
-void __init early_setup(unsigned long dt_ptr)
+void __init early_setup(unsigned long dt_ptr, u64 init_mem_size)
 {
 	static __initdata struct paca_struct boot_paca;
 
@@ -214,7 +214,7 @@
 	 * tree, such as retrieving the physical memory map or
 	 * calculating/retrieving the hash table size.
 	 */
-	early_init_devtree(__va(dt_ptr));
+	early_init_devtree(__va(dt_ptr), init_mem_size);
 
 	epapr_paravirt_early_init();
 
Index: linux/arch/powerpc/mm/40x_mmu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/arch/powerpc/mm/40x_mmu.c	(revision 5484)
+++ linux/arch/powerpc/mm/40x_mmu.c	(copie de travail)
@@ -147,7 +147,8 @@
 }
 
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-				phys_addr_t first_memblock_size)
+				phys_addr_t first_memblock_size,
+				u64 init_mem_size)
 {
 	/* We don't currently support the first MEMBLOCK not mapping 0
 	 * physical on those processors
Index: linux/arch/powerpc/mm/44x_mmu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/arch/powerpc/mm/44x_mmu.c	(revision 5484)
+++ linux/arch/powerpc/mm/44x_mmu.c	(copie de travail)
@@ -212,7 +212,8 @@
 }
 
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-				phys_addr_t first_memblock_size)
+				phys_addr_t first_memblock_size,
+				u64 init_mem_size)
 {
 	u64 size;
 
Index: linux/arch/powerpc/mm/fsl_booke_mmu.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/arch/powerpc/mm/fsl_booke_mmu.c	(revision 5484)
+++ linux/arch/powerpc/mm/fsl_booke_mmu.c	(copie de travail)
@@ -234,7 +234,8 @@
 }
 
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-				phys_addr_t first_memblock_size)
+				phys_addr_t first_memblock_size,
+				u64 init_mem_size)
 {
 	phys_addr_t limit =3D first_memblock_base + first_memblock_size;
 
Index: linux/arch/powerpc/mm/hash_utils_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/arch/powerpc/mm/hash_utils_64.c	(revision 5484)
+++ linux/arch/powerpc/mm/hash_utils_64.c	(copie de travail)
@@ -1416,7 +1416,8 @@
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-				phys_addr_t first_memblock_size)
+				phys_addr_t first_memblock_size,
+				u64 init_mem_size)
 {
 	/* We don't currently support the first MEMBLOCK not mapping 0
 	 * physical on those processors
Index: linux/arch/powerpc/mm/init_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/arch/powerpc/mm/init_32.c	(revision 5484)
+++ linux/arch/powerpc/mm/init_32.c	(copie de travail)
@@ -206,19 +206,16 @@
 
 #ifdef CONFIG_8xx /* No 8xx specific .c file to put that in ... */
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-				phys_addr_t first_memblock_size)
+				phys_addr_t first_memblock_size,
+				u64 init_mem_size)
 {
 	/* We don't currently support the first MEMBLOCK not mapping 0
 	 * physical on those processors
 	 */
 	BUG_ON(first_memblock_base !=3D 0);
 
-#ifdef CONFIG_PIN_TLB
-	/* 8xx can only access 24MB at the moment */
-	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01800000));
-#else
-	/* 8xx can only access 8MB at the moment */
-	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x00800000));
-#endif
+	if (!init_mem_size)
+		init_mem_size =3D 0x00800000;
+	memblock_set_current_limit(min_t(u64, first_memblock_size, init_mem_size)=
);
 }
 #endif /* CONFIG_8xx */
Index: linux/arch/powerpc/mm/ppc_mmu_32.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/arch/powerpc/mm/ppc_mmu_32.c	(revision 5484)
+++ linux/arch/powerpc/mm/ppc_mmu_32.c	(copie de travail)
@@ -273,7 +273,8 @@
 }
 
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-				phys_addr_t first_memblock_size)
+				phys_addr_t first_memblock_size,
+				u64 init_mem_size)
 {
 	/* We don't currently support the first MEMBLOCK not mapping 0
 	 * physical on those processors
Index: linux/arch/powerpc/mm/tlb_nohash.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux/arch/powerpc/mm/tlb_nohash.c	(revision 5484)
+++ linux/arch/powerpc/mm/tlb_nohash.c	(copie de travail)
@@ -654,7 +654,8 @@
 }
 
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-				phys_addr_t first_memblock_size)
+				phys_addr_t first_memblock_size,
+				u64 init_mem_size)
 {
 	/* On non-FSL Embedded 64-bit, we adjust the RMA size to match
 	 * the bolted TLB entry. We know for now that only 1G

---
Ce courrier =C3=A9lectronique ne contient aucun virus ou logiciel malveilla=
nt parce que la protection avast! Antivirus est active.
http://www.avast.com

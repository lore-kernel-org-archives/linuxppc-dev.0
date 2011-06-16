Return-Path: <monstr@monstr.eu>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F297EB75C0
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2011 00:14:47 +1000 (EST)
Received: by mail-fx0-f42.google.com with SMTP id 1so1329371fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 07:14:47 -0700 (PDT)
From: Michal Simek <monstr@monstr.eu>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 7/7] powerpc: Support RELOCATABLE kernel for PPC44x
Date: Thu, 16 Jun 2011 16:14:28 +0200
Message-Id: <1308233668-24166-8-git-send-email-monstr@monstr.eu>
In-Reply-To: <1308233668-24166-7-git-send-email-monstr@monstr.eu>
References: <1308233668-24166-1-git-send-email-monstr@monstr.eu>
	<1308233668-24166-2-git-send-email-monstr@monstr.eu>
	<1308233668-24166-3-git-send-email-monstr@monstr.eu>
	<1308233668-24166-4-git-send-email-monstr@monstr.eu>
	<1308233668-24166-5-git-send-email-monstr@monstr.eu>
	<1308233668-24166-6-git-send-email-monstr@monstr.eu>
	<1308233668-24166-7-git-send-email-monstr@monstr.eu>
Cc: Michal Simek <monstr@monstr.eu>, arnd@arndb.de, tmarri@apm.com,
	suzuki@in.ibm.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changes:
- Find out address where kernel runs
- Create the first 256MB TLB from online detected address

Limitations:
- Kernel must be aligned to 256MB

Backport:
- Changes in page.h are backported from newer kernel version

mmu_mapin_ram function has to reflect offset in memory start.
memstart_addr and kernstart_addr are setup directly from asm
code to ensure that only ppc44x is affected.

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/powerpc/Kconfig            |    3 ++-
 arch/powerpc/include/asm/page.h |    7 ++++++-
 arch/powerpc/kernel/head_44x.S  |   28 ++++++++++++++++++++++++++++
 arch/powerpc/mm/44x_mmu.c       |    6 +++++-
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 45c9683..34c521e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -796,7 +796,8 @@ config LOWMEM_CAM_NUM
 
 config RELOCATABLE
 	bool "Build a relocatable kernel (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM && FSL_BOOKE
+	depends on EXPERIMENTAL && ADVANCED_OPTIONS && FLATMEM
+	depends on FSL_BOOKE || (44x && !SMP)
 	help
 	  This builds a kernel image that is capable of running at the
 	  location the kernel is loaded at (some alignment restrictions may
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 4940662..e813cc2 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -108,8 +108,13 @@ extern phys_addr_t kernstart_addr;
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
-#define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET - MEMORY_START))
+#ifdef CONFIG_BOOKE
+#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - PHYSICAL_START + KERNELBASE))
+#define __pa(x) ((unsigned long)(x) + PHYSICAL_START - KERNELBASE)
+#else
+#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + PAGE_OFFSET - MEMORY_START))
 #define __pa(x) ((unsigned long)(x) - PAGE_OFFSET + MEMORY_START)
+#endif
 
 /*
  * Unfortunately the PLT is in the BSS in the PPC32 ELF ABI,
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index d80ce05..6a63d32 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -59,6 +59,17 @@ _ENTRY(_start);
 	 * of abatron_pteptrs
 	 */
 	nop
+
+#ifdef CONFIG_RELOCATABLE
+	bl	jump                            /* Find our address */
+	nop
+jump:	mflr	r25                              /* Make it accessible */
+	/* just for and */
+	lis     r26, 0xfffffff0@h
+	ori     r26, r26, 0xfffffff0@l
+	and.	r21, r25, r26
+#endif
+
 /*
  * Save parameters we are passed
  */
@@ -135,9 +146,14 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	lis	r3,PAGE_OFFSET@h
 	ori	r3,r3,PAGE_OFFSET@l
 
+#ifdef CONFIG_RELOCATABLE
+	/* load physical address where kernel runs */
+	mr	r4,r21
+#else
 	/* Kernel is at PHYSICAL_START */
 	lis	r4,PHYSICAL_START@h
 	ori	r4,r4,PHYSICAL_START@l
+#endif
 
 	/* Load the kernel PID = 0 */
 	li	r0,0
@@ -258,6 +274,18 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	mr	r5,r29
 	mr	r6,r28
 	mr	r7,r27
+
+#ifdef CONFIG_RELOCATABLE
+	/* save kernel and memory start */
+	lis	r25,kernstart_addr@h
+	ori	r25,r25,kernstart_addr@l
+	stw	r21,4(r25)
+
+	lis	r25,memstart_addr@h
+	ori	r25,r25,memstart_addr@l
+	stw	r21,4(r25)
+#endif
+
 	bl	machine_init
 	bl	MMU_init
 
diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index 4a55061..ecf4a20 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -91,12 +91,16 @@ void __init MMU_init_hw(void)
 unsigned long __init mmu_mapin_ram(void)
 {
 	unsigned long addr;
+	unsigned long offset = 0;
 
+#if defined(CONFIG_RELOCATABLE)
+	offset = memstart_addr;
+#endif
 	/* Pin in enough TLBs to cover any lowmem not covered by the
 	 * initial 256M mapping established in head_44x.S */
 	for (addr = PHYSICAL_START + PPC_PIN_SIZE; addr < lowmem_end_addr;
 	     addr += PPC_PIN_SIZE)
-		ppc44x_pin_tlb(addr + PAGE_OFFSET, addr);
+		ppc44x_pin_tlb(addr + PAGE_OFFSET - offset, addr);
 
 	return total_lowmem;
 }
-- 
1.5.5.6

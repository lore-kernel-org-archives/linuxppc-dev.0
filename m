Return-Path: <SRS0=2pNn=QN=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 2285EDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 21:24:57 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc: 4xx: Fix TLB 0 problem with CONFIG_SERIAL_TEXT_DEBUG
Date: Tue, 20 Nov 2007 11:19:16 +0100
Message-Id: <1195553956-32505-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Right now TLB entry 0 ist used as UART0 mapping for the early debug
output (via CONFIG_SERIAL_TEXT_DEBUG). This causes problems when many
TLB's get used upon Linux bootup (e.g. while PCIe scanning behind
bridges and/or switches on 440SPe platforms). This will overwrite the
TLB 0 entry and further debug output's may crash/hang the system.

This patch moves the early debug UART0 TLB entry from 0 to 62 as done
in arch/powerpc. This way it is in the "pinned" area and will not get
overwritten. Also the arch/ppc/mm/44x_mmu.c code is now synced with the
newer code from arch/powerpc.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/ppc/kernel/head_44x.S |    2 +-
 arch/ppc/mm/44x_mmu.c      |   51 +++++++++++++------------------------------
 include/asm-ppc/mmu.h      |    6 +++++
 3 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/arch/ppc/kernel/head_44x.S b/arch/ppc/kernel/head_44x.S
index 75bbc93..ebb5a40 100644
--- a/arch/ppc/kernel/head_44x.S
+++ b/arch/ppc/kernel/head_44x.S
@@ -195,7 +195,7 @@ skpinv:	addi	r4,r4,1				/* Increment */
 	li	r5,0
 	ori	r5,r5,(PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_I | PPC44x_TLB_G)
 
-        li      r0,0                    /* TLB slot 0 */
+	li	r0,62			/* TLB slot 62 */
 
 	tlbwe	r3,r0,PPC44x_TLB_PAGEID	/* Load the pageid fields */
 	tlbwe	r4,r0,PPC44x_TLB_XLAT	/* Load the translation fields */
diff --git a/arch/ppc/mm/44x_mmu.c b/arch/ppc/mm/44x_mmu.c
index 6536a25..fbb577a 100644
--- a/arch/ppc/mm/44x_mmu.c
+++ b/arch/ppc/mm/44x_mmu.c
@@ -60,38 +60,28 @@ extern char etext[], _stext[];
  * Just needed it declared someplace.
  */
 unsigned int tlb_44x_index = 0;
-unsigned int tlb_44x_hwater = 62;
+unsigned int tlb_44x_hwater = PPC4XX_TLB_SIZE - 1 - PPC44x_EARLY_TLBS;
 int icache_44x_need_flush;
 
 /*
  * "Pins" a 256MB TLB entry in AS0 for kernel lowmem
  */
-static void __init
-ppc44x_pin_tlb(int slot, unsigned int virt, unsigned int phys)
+static void __init ppc44x_pin_tlb(unsigned int virt, unsigned int phys)
 {
-	unsigned long attrib = 0;
-
-	__asm__ __volatile__("\
-	clrrwi	%2,%2,10\n\
-	ori	%2,%2,%4\n\
-	clrrwi	%1,%1,10\n\
-	li	%0,0\n\
-	ori	%0,%0,%5\n\
-	tlbwe	%2,%3,%6\n\
-	tlbwe	%1,%3,%7\n\
-	tlbwe	%0,%3,%8"
+	__asm__ __volatile__(
+		"tlbwe	%2,%3,%4\n"
+		"tlbwe	%1,%3,%5\n"
+		"tlbwe	%0,%3,%6\n"
 	:
-	: "r" (attrib), "r" (phys), "r" (virt), "r" (slot),
-	  "i" (PPC44x_TLB_VALID | PPC44x_TLB_256M),
-	  "i" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44x_TLB_G),
+	: "r" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44x_TLB_G),
+	  "r" (phys),
+	  "r" (virt | PPC44x_TLB_VALID | PPC44x_TLB_256M),
+	  "r" (tlb_44x_hwater--), /* slot for this TLB entry */
 	  "i" (PPC44x_TLB_PAGEID),
 	  "i" (PPC44x_TLB_XLAT),
 	  "i" (PPC44x_TLB_ATTRIB));
 }
 
-/*
- * MMU_init_hw does the chip-specific initialization of the MMU hardware.
- */
 void __init MMU_init_hw(void)
 {
 	flush_instruction_cache();
@@ -99,22 +89,13 @@ void __init MMU_init_hw(void)
 
 unsigned long __init mmu_mapin_ram(void)
 {
-	unsigned int pinned_tlbs = 1;
-	int i;
-
-	/* Determine number of entries necessary to cover lowmem */
-	pinned_tlbs = (unsigned int)
-		(_ALIGN(total_lowmem, PPC_PIN_SIZE) >> PPC44x_PIN_SHIFT);
-
-	/* Write upper watermark to save location */
-	tlb_44x_hwater = PPC44x_LOW_SLOT - pinned_tlbs;
+	unsigned long addr;
 
-	/* If necessary, set additional pinned TLBs */
-	if (pinned_tlbs > 1)
-		for (i = (PPC44x_LOW_SLOT-(pinned_tlbs-1)); i < PPC44x_LOW_SLOT; i++) {
-			unsigned int phys_addr = (PPC44x_LOW_SLOT-i) * PPC_PIN_SIZE;
-			ppc44x_pin_tlb(i, phys_addr+PAGE_OFFSET, phys_addr);
-		}
+	/* Pin in enough TLBs to cover any lowmem not covered by the
+	 * initial 256M mapping established in head_44x.S */
+	for (addr = PPC_PIN_SIZE; addr < total_lowmem;
+	     addr += PPC_PIN_SIZE)
+		ppc44x_pin_tlb(addr + PAGE_OFFSET, addr);
 
 	return total_lowmem;
 }
diff --git a/include/asm-ppc/mmu.h b/include/asm-ppc/mmu.h
index 14584e5..d46b57b 100644
--- a/include/asm-ppc/mmu.h
+++ b/include/asm-ppc/mmu.h
@@ -383,6 +383,12 @@ typedef struct _P601_BAT {
 #define BOOKE_PAGESZ_256GB	14
 #define BOOKE_PAGESZ_1TB	15
 
+#ifndef CONFIG_SERIAL_TEXT_DEBUG
+#define PPC44x_EARLY_TLBS	1
+#else
+#define PPC44x_EARLY_TLBS	2
+#endif
+
 /*
  * Freescale Book-E MMU support
  */
-- 
1.5.3.5.788.gea559

Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11FF868978
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 07:40:29 +1100 (EST)
Date: Thu, 29 Dec 2005 18:40:40 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Matt Porter <mporter@kernel.crashing.org>
Message-ID: <20051229204040.GA9751@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] powerpc: generalize PPC44x_PIN_SIZE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi, 

The following patch generalizes PPC44x_PIN_SIZE by changing it to
PPC_PIN_SIZE, which can be defined by any board to automatically adjust
VMALLOC_START, avoiding conflicts with pinned virtual space.

Also define it for 8xx.

Matt, please review.

diff --git a/arch/ppc/mm/44x_mmu.c b/arch/ppc/mm/44x_mmu.c
index 3d79ce2..e0152a9 100644
--- a/arch/ppc/mm/44x_mmu.c
+++ b/arch/ppc/mm/44x_mmu.c
@@ -104,7 +104,7 @@ unsigned long __init mmu_mapin_ram(void)
 
 	/* Determine number of entries necessary to cover lowmem */
 	pinned_tlbs = (unsigned int)
-		(_ALIGN(total_lowmem, PPC44x_PIN_SIZE) >> PPC44x_PIN_SHIFT);
+		(_ALIGN(total_lowmem, PPC_PIN_SIZE) >> PPC44x_PIN_SHIFT);
 
 	/* Write upper watermark to save location */
 	tlb_44x_hwater = PPC44x_LOW_SLOT - pinned_tlbs;
@@ -112,7 +112,7 @@ unsigned long __init mmu_mapin_ram(void)
 	/* If necessary, set additional pinned TLBs */
 	if (pinned_tlbs > 1)
 		for (i = (PPC44x_LOW_SLOT-(pinned_tlbs-1)); i < PPC44x_LOW_SLOT; i++) {
-			unsigned int phys_addr = (PPC44x_LOW_SLOT-i) * PPC44x_PIN_SIZE;
+			unsigned int phys_addr = (PPC44x_LOW_SLOT-i) * PPC_PIN_SIZE;
 			ppc44x_pin_tlb(i, phys_addr+PAGE_OFFSET, phys_addr);
 		}
 
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
index f835066..3acc382 100644
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -29,7 +29,7 @@
 
 /* TLB entry offset/size used for pinning kernel lowmem */
 #define PPC44x_PIN_SHIFT	28
-#define PPC44x_PIN_SIZE		(1 << PPC44x_PIN_SHIFT)
+#define PPC_PIN_SIZE		(1 << PPC44x_PIN_SHIFT)
 
 /* Lowest TLB slot consumed by the default pinned TLBs */
 #define PPC44x_LOW_SLOT		63
diff --git a/include/asm-ppc/mpc8xx.h b/include/asm-ppc/mpc8xx.h
index 46f159c..73ec9a6 100644
--- a/include/asm-ppc/mpc8xx.h
+++ b/include/asm-ppc/mpc8xx.h
@@ -113,6 +113,8 @@ enum ppc_sys_devices {
 	MPC8xx_CPM_USB,
 };
 
+#define PPC_PIN_SIZE	(24 * 1024 * 1024)	/* 24Mbytes of data pinned */
+
 #ifndef BOARD_CHIP_NAME
 #define BOARD_CHIP_NAME ""
 #endif
diff --git a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
index 6d1c39e..3f8c38e 100644
--- a/include/asm-ppc/pgtable.h
+++ b/include/asm-ppc/pgtable.h
@@ -12,6 +12,7 @@
 #include <asm/processor.h>		/* For TASK_SIZE */
 #include <asm/mmu.h>
 #include <asm/page.h>
+#include <asm/irq.h>			/* For sub-arch specific PPC_PIN_SIZE */
 struct mm_struct;
 
 extern unsigned long va_to_phys(unsigned long address);
@@ -127,9 +128,8 @@ extern unsigned long ioremap_bot, iorema
  * of RAM.  -- Cort
  */
 #define VMALLOC_OFFSET (0x1000000) /* 16M */
-#ifdef CONFIG_44x
-#include <asm/ibm44x.h>
-#define VMALLOC_START (((_ALIGN((long)high_memory, PPC44x_PIN_SIZE) + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
+#ifdef PPC_PIN_SIZE
+#define VMALLOC_START (((_ALIGN((long)high_memory, PPC_PIN_SIZE) + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
 #else
 #define VMALLOC_START ((((long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1)))
 #endif

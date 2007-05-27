Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 493A5DDF00
	for <linuxppc-dev@ozlabs.org>; Sun, 27 May 2007 23:58:30 +1000 (EST)
Date: Sun, 27 May 2007 08:58:20 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Please pull powerpc.git for_paulus branch (fwd)
Message-ID: <Pine.LNX.4.64.0705270856560.4113@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

If you don't mind pulling this branch that would be great.  Paul seems to
have disappeared for a few days and I want to make sure we get these fixes
in before 2.6.22.

If you'd like a re-base on your tree let me know.

- k

---------- Forwarded message ----------
Date: Wed, 23 May 2007 09:53:20 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Please pull powerpc.git for_paulus branch

Please pull from 'for_paulus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for_paulus

to receive the following updates:

 arch/powerpc/Kconfig                      |    1 +
 arch/powerpc/boot/dts/lite5200.dts        |    2 +-
 arch/powerpc/boot/dts/lite5200b.dts       |    2 +-
 arch/powerpc/mm/pgtable_32.c              |    2 +-
 arch/powerpc/platforms/chrp/pegasos_eth.c |    2 +-
 arch/powerpc/platforms/powermac/setup.c   |    2 +-
 arch/powerpc/sysdev/qe_lib/Kconfig        |    4 +---
 arch/ppc/kernel/entry.S                   |   18 +++++++++++++++---
 arch/ppc/kernel/ppc_ksyms.c               |    2 --
 arch/ppc/mm/hashtable.S                   |   20 ++++++++++++++++----
 arch/ppc/mm/pgtable.c                     |    2 +-
 drivers/macintosh/Kconfig                 |    1 -
 drivers/net/Kconfig                       |    1 -
 13 files changed, 39 insertions(+), 20 deletions(-)

Domen Puncer (1):
      [POWERPC] 52xx: unbreak lite5200 dts (_pic vs. -pic)

Kumar Gala (5):
      [PPC] Fix COMMON symbol warnings
      [PPC] Remove duplicate export of __div64_32.
      [POWERPC] Fix modpost warning
      [PPC] Fix modpost warning
      [POWERPC] Fix Kconfig warning

Li Yang (1):
      [POWERPC] Fix Section mismatch warnings

Timur Tabi (1):
      [POWERPC] QE: fix Kconfig 'select' warning with UCC_FAST

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 56d3c0d..5eaeafd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -118,6 +118,7 @@ config GENERIC_BUG
 	depends on BUG

 config SYS_SUPPORTS_APM_EMULATION
+	default y if PMAC_APM_EMU
 	bool

 config DEFAULT_UIMAGE
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index eae68ab..d29308f 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -67,7 +67,7 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			device_type = "interrupt-controller";
-			compatible = "mpc5200_pic";
+			compatible = "mpc5200-pic";
 			reg = <500 80>;
 			built-in;
 		};
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 5185625..f242531 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -67,7 +67,7 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			device_type = "interrupt-controller";
-			compatible = "mpc5200b-pic\0mpc5200_pic";
+			compatible = "mpc5200b-pic\0mpc5200-pic";
 			reg = <500 80>;
 			built-in;
 		};
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index d8232b7..f6ae1a5 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -93,7 +93,7 @@ void pgd_free(pgd_t *pgd)
 	free_pages((unsigned long)pgd, PGDIR_ORDER);
 }

-pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+__init_refok pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
 	pte_t *pte;
 	extern int mem_init_done;
diff --git a/arch/powerpc/platforms/chrp/pegasos_eth.c b/arch/powerpc/platforms/chrp/pegasos_eth.c
index 7104567..5bcc58d 100644
--- a/arch/powerpc/platforms/chrp/pegasos_eth.c
+++ b/arch/powerpc/platforms/chrp/pegasos_eth.c
@@ -169,7 +169,7 @@ static int Enable_SRAM(void)

 /***********/
 /***********/
-int mv643xx_eth_add_pds(void)
+static int __init mv643xx_eth_add_pds(void)
 {
 	int ret = 0;
 	static struct pci_device_id pci_marvell_mv64360[] = {
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index a410bc7..07b1c4e 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -384,7 +384,7 @@ int boot_part;
 static dev_t boot_dev;

 #ifdef CONFIG_SCSI
-void __init note_scsi_host(struct device_node *node, void *host)
+void note_scsi_host(struct device_node *node, void *host)
 {
 	int l;
 	char *p;
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index 887739f..f611d34 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -5,15 +5,13 @@
 config UCC_SLOW
 	bool
 	default n
-	select UCC
 	help
 	  This option provides qe_lib support to UCC slow
 	  protocols: UART, BISYNC, QMC

 config UCC_FAST
 	bool
-	default n
-	select UCC
+	default y if UCC_GETH
 	help
 	  This option provides qe_lib support to UCC fast
 	  protocols: HDLC, Ethernet, ATM, transparent
diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
index ab64256..fba7ca1 100644
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -596,7 +596,11 @@ fast_exception_return:
 	mr	r12,r4		/* restart at exc_exit_restart */
 	b	2b

-	.comm	fee_restarts,4
+	.section .bss
+	.align	2
+fee_restarts:
+	.space	4
+	.previous

 /* aargh, a nonrecoverable interrupt, panic */
 /* aargh, we don't know which trap this is */
@@ -851,7 +855,11 @@ load_dbcr0:
 	mtspr	SPRN_DBSR,r11	/* clear all pending debug events */
 	blr

-	.comm	global_dbcr0,8
+	.section .bss
+	.align	4
+global_dbcr0:
+	.space	8
+	.previous
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE) */

 do_work:			/* r10 contains MSR_KERNEL here */
@@ -926,4 +934,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 	/* shouldn't return */
 	b	4b

-	.comm	ee_restarts,4
+	.section .bss
+	.align	2
+ee_restarts:
+	.space	4
+	.previous
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 4ad4996..a416520 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -40,7 +40,6 @@
 #include <asm/time.h>
 #include <asm/cputable.h>
 #include <asm/btext.h>
-#include <asm/div64.h>
 #include <asm/xmon.h>
 #include <asm/signal.h>
 #include <asm/dcr.h>
@@ -93,7 +92,6 @@ EXPORT_SYMBOL(strncpy);
 EXPORT_SYMBOL(strcat);
 EXPORT_SYMBOL(strlen);
 EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(__div64_32);

 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_generic);
diff --git a/arch/ppc/mm/hashtable.S b/arch/ppc/mm/hashtable.S
index e756942..5f364dc 100644
--- a/arch/ppc/mm/hashtable.S
+++ b/arch/ppc/mm/hashtable.S
@@ -30,7 +30,11 @@
 #include <asm/asm-offsets.h>

 #ifdef CONFIG_SMP
-	.comm	mmu_hash_lock,4
+	.section .bss
+	.align	2
+	.globl mmu_hash_lock
+mmu_hash_lock:
+	.space	4
 #endif /* CONFIG_SMP */

 /*
@@ -461,9 +465,17 @@ found_slot:
 	sync		/* make sure pte updates get to memory */
 	blr

-	.comm	next_slot,4
-	.comm	primary_pteg_full,4
-	.comm	htab_hash_searches,4
+	.section .bss
+	.align	2
+next_slot:
+	.space	4
+	.globl primary_pteg_full
+primary_pteg_full:
+	.space	4
+	.globl htab_hash_searches
+htab_hash_searches:
+	.space	4
+	.previous

 /*
  * Flush the entry for a particular page from the hash table.
diff --git a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
index c023b72..35ebb63 100644
--- a/arch/ppc/mm/pgtable.c
+++ b/arch/ppc/mm/pgtable.c
@@ -92,7 +92,7 @@ void pgd_free(pgd_t *pgd)
 	free_pages((unsigned long)pgd, PGDIR_ORDER);
 }

-pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+__init_refok pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
 {
 	pte_t *pte;
 	extern int mem_init_done;
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 58926da..f44c94a 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -113,7 +113,6 @@ config PMAC_SMU

 config PMAC_APM_EMU
 	tristate "APM emulation"
-	select SYS_SUPPORTS_APM_EMULATION
 	select APM_EMULATION
 	depends on ADB_PMU && PM

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index c5baa19..3b204ba 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2280,7 +2280,6 @@ config GFAR_NAPI
 config UCC_GETH
 	tristate "Freescale QE Gigabit Ethernet"
 	depends on QUICC_ENGINE
-	select UCC_FAST
 	help
 	  This driver supports the Gigabit Ethernet mode of the QUICC Engine,
 	  which is available on some Freescale SOCs.
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 671071A03D0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:55:26 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 3/4] powerpc: Remove stale function prototypes
Date: Wed, 20 Aug 2014 08:55:20 +1000
Message-Id: <1408488921-19187-3-git-send-email-anton@samba.org>
In-Reply-To: <1408488921-19187-1-git-send-email-anton@samba.org>
References: <1408488921-19187-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There were a number of prototypes for functions that no longer
exist. Remove them.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/bug.h           | 1 -
 arch/powerpc/include/asm/hydra.h         | 1 -
 arch/powerpc/include/asm/irq.h           | 5 -----
 arch/powerpc/include/asm/kexec.h         | 1 -
 arch/powerpc/include/asm/page_64.h       | 1 -
 arch/powerpc/include/asm/pgtable-ppc32.h | 2 --
 arch/powerpc/include/asm/prom.h          | 2 --
 arch/powerpc/include/asm/rio.h           | 1 -
 arch/powerpc/include/asm/tsi108.h        | 4 ----
 arch/powerpc/include/asm/udbg.h          | 1 -
 arch/powerpc/platforms/pseries/lpar.c    | 2 --
 11 files changed, 21 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 3eb53d7..3a39283 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -133,7 +133,6 @@ extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
 extern void _exception(int, struct pt_regs *, int, unsigned long);
 extern void die(const char *, struct pt_regs *, long);
-extern void print_backtrace(unsigned long *);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/hydra.h b/arch/powerpc/include/asm/hydra.h
index 5b0c98bd..1cb39c9 100644
--- a/arch/powerpc/include/asm/hydra.h
+++ b/arch/powerpc/include/asm/hydra.h
@@ -95,7 +95,6 @@ extern volatile struct Hydra __iomem *Hydra;
 #define HYDRA_INT_SPARE		19
 
 extern int hydra_init(void);
-extern void macio_adb_init(void);
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 41f13ce..e8e3a0a 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -31,11 +31,6 @@ extern atomic_t ppc_n_lost_interrupts;
 
 extern irq_hw_number_t virq_to_hw(unsigned int virq);
 
-/**
- * irq_early_init - Init irq remapping subsystem
- */
-extern void irq_early_init(void);
-
 static __inline__ int irq_canonicalize(int irq)
 {
 	return irq;
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 16d7e33..19c36cb 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -81,7 +81,6 @@ extern void default_machine_crash_shutdown(struct pt_regs *regs);
 extern int crash_shutdown_register(crash_shutdown_t handler);
 extern int crash_shutdown_unregister(crash_shutdown_t handler);
 
-extern void machine_kexec_simple(struct kimage *image);
 extern void crash_kexec_secondary(struct pt_regs *regs);
 extern int overlaps_crashkernel(unsigned long start, unsigned long size);
 extern void reserve_crashkernel(void);
diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index 88693ce..d0d6afb 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -104,7 +104,6 @@ extern unsigned long slice_get_unmapped_area(unsigned long addr,
 extern unsigned int get_slice_psize(struct mm_struct *mm,
 				    unsigned long addr);
 
-extern void slice_init_context(struct mm_struct *mm, unsigned int psize);
 extern void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
 extern void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 				  unsigned long len, unsigned int psize);
diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 47edde8..622672f 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -8,8 +8,6 @@
 #include <linux/threads.h>
 #include <asm/io.h>			/* For sub-arch specific PPC_PIN_SIZE */
 
-extern unsigned long va_to_phys(unsigned long address);
-extern pte_t *va_to_pte(unsigned long address);
 extern unsigned long ioremap_bot;
 
 #ifdef CONFIG_44x
diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index 74b79f0..7f436ba 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -76,8 +76,6 @@ void of_parse_dma_window(struct device_node *dn, const __be32 *dma_window,
 			 unsigned long *busno, unsigned long *phys,
 			 unsigned long *size);
 
-extern void kdump_move_device_tree(void);
-
 extern void of_instantiate_rtc(void);
 
 extern int of_get_ibm_chip_id(struct device_node *np);
diff --git a/arch/powerpc/include/asm/rio.h b/arch/powerpc/include/asm/rio.h
index b1d2dec..ec800f2 100644
--- a/arch/powerpc/include/asm/rio.h
+++ b/arch/powerpc/include/asm/rio.h
@@ -13,7 +13,6 @@
 #ifndef ASM_PPC_RIO_H
 #define ASM_PPC_RIO_H
 
-extern void platform_rio_init(void);
 #ifdef CONFIG_FSL_RIO
 extern int fsl_rio_mcheck_exception(struct pt_regs *);
 #else
diff --git a/arch/powerpc/include/asm/tsi108.h b/arch/powerpc/include/asm/tsi108.h
index f8b6079..d531d9e 100644
--- a/arch/powerpc/include/asm/tsi108.h
+++ b/arch/powerpc/include/asm/tsi108.h
@@ -84,10 +84,6 @@
 extern u32 tsi108_pci_cfg_base;
 /* Exported functions */
 
-extern int tsi108_bridge_init(struct pci_controller *hose, uint phys_csr_base);
-extern unsigned long tsi108_get_mem_size(void);
-extern unsigned long tsi108_get_cpu_clk(void);
-extern unsigned long tsi108_get_sdc_clk(void);
 extern int tsi108_direct_write_config(struct pci_bus *bus, unsigned int devfn,
 				      int offset, int len, u32 val);
 extern int tsi108_direct_read_config(struct pci_bus *bus, unsigned int devfn,
diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
index b51fba1..78f2675 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -52,7 +52,6 @@ extern void __init udbg_init_44x_as1(void);
 extern void __init udbg_init_40x_realmode(void);
 extern void __init udbg_init_cpm(void);
 extern void __init udbg_init_usbgecko(void);
-extern void __init udbg_init_wsp(void);
 extern void __init udbg_init_memcons(void);
 extern void __init udbg_init_ehv_bc(void);
 extern void __init udbg_init_ps3gelic(void);
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 34e6423..6affea7 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -59,8 +59,6 @@ EXPORT_SYMBOL(plpar_hcall);
 EXPORT_SYMBOL(plpar_hcall9);
 EXPORT_SYMBOL(plpar_hcall_norets);
 
-extern void pSeries_find_serial_port(void);
-
 void vpa_init(int cpu)
 {
 	int hwcpu = get_hard_smp_processor_id(cpu);
-- 
1.9.1

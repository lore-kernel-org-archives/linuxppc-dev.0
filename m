Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD2EF67A77
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Jun 2005 07:16:51 +1000 (EST)
Date: Sat, 25 Jun 2005 11:53:18 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050625145318.GA32117@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] 8xx: map_page() skip pinned region and tlbie debugging aid
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

The following patch adds code to skip flushing of tlb's in the pinned TLB region 
(assuming that it is contiguous), thus preserving the pinned region.

It also introduces CONFIG_DEBUG_PIN_TLBIE to catch for overlapping invalidates
(as suggested by Dan).

It could be smarter and aware of non-contiguous regions (instead of a simple 
<start,end> tuple), but I'm not sure if thats worth at the moment.

Dan: I dont think ioremap() is an issue because it never works inside the 
kernel's static virtual address space (which is the only one we're interested 
in having pinned at the moment).

Comments on improvements are very welcome.

tree d682449fa55448a446081d8e9fc0fed8f92bf812
parent f17c5c6e4e1d1b7e8b01f323dfd2bd2197a0743f
author Marcelo <marcelo@xeon.cnet> 1119729961 -0300
committer Marcelo Tosatti <marcelo.tosatti@cyclades.com> 1119729961 -0300

Introduce pin_area_start and pin_area_end to hold info about pinned area.

Use that information in map_page() to skip invalidation of TLB in case 
of overlapping address (to preserve the large pinned TLB).

Introduce a debugging aid in _tlbie() to catch overlapping invalidations, 
governed by CONFIG_DEBUG_PIN_TLBIE.

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -1296,6 +1296,11 @@ config BOOT_LOAD
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
 	depends on ADVANCED_OPTIONS && 8xx
+
+config DEBUG_PIN_TLBIE
+	bool "Check for overlapping TLB invalidates inside the pinned area"
+	depends on ADVANCED_OPTIONS && 8xx && PIN_TLB
+
 endmenu
 
 source "drivers/Kconfig"
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -565,6 +565,19 @@ _GLOBAL(_tlbie)
 	SYNC_601
 	isync
 #else /* CONFIG_SMP */
+#ifdef CONFIG_DEBUG_PIN_TLBIE
+/* check if the address being invalidated overlaps with the pinned region */
+	lis	r4,(pin_area_start)@ha
+	lwz	r5,(pin_area_start)@l(4)
+	cmplw	r3, r5
+	blt	11f
+	lis	r4,(pin_area_end)@ha
+	lwz	r5,(pin_area_end)@l(4)
+	cmplw	r3, r5
+	bge	11f
+	trap
+#endif
+11:
 	tlbie	r3
 	sync
 #endif /* CONFIG_SMP */
diff --git a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
--- a/arch/ppc/mm/init.c
+++ b/arch/ppc/mm/init.c
@@ -112,6 +112,12 @@ unsigned long __max_memory;
 /* max amount of low RAM to map in */
 unsigned long __max_low_memory = MAX_LOW_MEM;
 
+/* should be a per-platform definition */
+#ifdef CONFIG_PIN_TLB
+unsigned long pin_area_start = KERNELBASE;
+unsigned long pin_area_end = KERNELBASE + 0x00800000;
+#endif
+
 void show_mem(void)
 {
 	int i,free = 0,total = 0,reserved = 0;
diff --git a/arch/ppc/mm/pgtable.c b/arch/ppc/mm/pgtable.c
--- a/arch/ppc/mm/pgtable.c
+++ b/arch/ppc/mm/pgtable.c
@@ -274,6 +274,11 @@ void ioport_unmap(void __iomem *addr)
 EXPORT_SYMBOL(ioport_map);
 EXPORT_SYMBOL(ioport_unmap);
 
+#ifdef CONFIG_PIN_TLB
+extern unsigned long pin_area_start;
+extern unsigned long pin_area_end;
+#endif
+
 int
 map_page(unsigned long va, phys_addr_t pa, int flags)
 {
@@ -290,7 +295,10 @@ map_page(unsigned long va, phys_addr_t p
 		err = 0;
 		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT, __pgprot(flags)));
 		if (mem_init_done)
-			flush_HPTE(0, va, pmd_val(*pd));
+#ifdef CONFIG_PIN_TLB
+			if (va < pin_area_start || va >= pin_area_end)
+#endif
+				flush_HPTE(0, va, pmd_val(*pd));
 	}
 	spin_unlock(&init_mm.page_table_lock);
 	return err;

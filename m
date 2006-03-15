Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17431.43915.712222.861194@cargo.ozlabs.ibm.com>
Date: Wed, 15 Mar 2006 16:52:11 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc-merge.git
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do a pull from

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

There are 5 commits in there which fix bugs which need to be fixed for
2.6.16:

  Benjamin Herrenschmidt:
      powerpc: enable NAP only on cpus who support it to avoid memory corruption

  John Rose:
      powerpc: properly configure DDR/P5IOC children devs

  Michael Neuling:
      powerpc: RTC memory corruption

  Olaf Hering:
      powerpc: correct cacheflush loop in zImage

  Paul Mackerras:
      powerpc: Fix problem with time going backwards

plus a patch from Olaf Hering to remove some duplicate EXPORT_SYMBOLs,
which cause warnings at compile time (perhaps not critical, but still
should be fixed, and the fix is low-impact),

plus two patches which make minor changes to Kconfig files:

  Michael Ellerman:
      powerpc: Clarify wording for CRASH_DUMP Kconfig option

  Paul Mackerras:
      powerpc: Disallow lparcfg being a module

plus two commits that update defconfig files:

  Olaf Hering:
      powerpc/64: enable CONFIG_BLK_DEV_SL82C105

  Paul Mackerras:
      powerpc: update defconfigs

I have included the full commit message plus patch below for all
except the defconfig updates.

Thanks,
Paul.

 arch/powerpc/Kconfig                       |    2 -
 arch/powerpc/boot/crt0.S                   |    5 +
 arch/powerpc/configs/cell_defconfig        |   94 +++++++++++++++++++--------
 arch/powerpc/configs/iseries_defconfig     |   96 +++++++++++++++++-----------
 arch/powerpc/configs/maple_defconfig       |   50 ++++++++++++---
 arch/powerpc/configs/mpc834x_sys_defconfig |   32 +++++----
 arch/powerpc/configs/pmac32_defconfig      |   77 ++++++++++++++--------
 arch/powerpc/configs/ppc64_defconfig       |    2 -
 arch/powerpc/kernel/pci_64.c               |    5 +
 arch/powerpc/kernel/ppc_ksyms.c            |   10 ---
 arch/powerpc/kernel/rtas-rtc.c             |    2 -
 arch/powerpc/kernel/rtas_pci.c             |   24 -------
 arch/powerpc/kernel/time.c                 |   48 ++++++++++----
 arch/powerpc/mm/pgtable_32.c               |    5 +
 arch/powerpc/platforms/powermac/feature.c  |    9 +--
 arch/powerpc/platforms/powermac/setup.c    |    4 -
 arch/powerpc/platforms/pseries/Kconfig     |    2 -
 arch/powerpc/platforms/pseries/pci_dlpar.c |   28 ++++++++
 include/asm-powerpc/ppc-pci.h              |    1 
 19 files changed, 315 insertions(+), 181 deletions(-)

diff-tree bb32754f054f42455cac667daea62668035f427c (from 7177ee48eb3a9f042f10d5b4e49f1737b988123d)
Author: John Rose <johnrose@austin.ibm.com>
Date:   Tue Mar 14 17:46:45 2006 -0600

    [PATCH] powerpc: properly configure DDR/P5IOC children devs
    
    The dynamic add path for PCI Host Bridges can fail to configure children
    adapters under P5IOC controllers.  It fails to properly fixup bus/device
    resources, and it fails to properly enable EEH.  Both of these steps
    need to occur before any children devices are enabled in
    pci_bus_add_devices().
    
    Signed-off-by: John Rose <johnrose@austin.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index c367520..ba92bab 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -589,7 +589,6 @@ void __devinit scan_phb(struct pci_contr
 #endif /* CONFIG_PPC_MULTIPLATFORM */
 	if (mode == PCI_PROBE_NORMAL)
 		hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
-	pci_bus_add_devices(bus);
 }
 
 static int __init pcibios_init(void)
@@ -608,8 +607,10 @@ static int __init pcibios_init(void)
 	printk("PCI: Probing PCI hardware\n");
 
 	/* Scan all of the recorded PCI controllers.  */
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
 		scan_phb(hose);
+		pci_bus_add_devices(hose->bus);
+	}
 
 #ifndef CONFIG_PPC_ISERIES
 	if (pci_probe_only)
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 5579f65..7442775 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -280,8 +280,7 @@ static int phb_set_bus_ranges(struct dev
 	return 0;
 }
 
-static int __devinit setup_phb(struct device_node *dev,
-			       struct pci_controller *phb)
+int __devinit setup_phb(struct device_node *dev, struct pci_controller *phb)
 {
 	if (is_python(dev))
 		python_countermeasures(dev);
@@ -359,27 +358,6 @@ unsigned long __init find_and_init_phbs(
 	return 0;
 }
 
-struct pci_controller * __devinit init_phb_dynamic(struct device_node *dn)
-{
-	struct pci_controller *phb;
-	int primary;
-
-	primary = list_empty(&hose_list);
-	phb = pcibios_alloc_controller(dn);
-	if (!phb)
-		return NULL;
-	setup_phb(dn, phb);
-	pci_process_bridge_OF_ranges(phb, dn, primary);
-
-	pci_setup_phb_io_dynamic(phb, primary);
-
-	pci_devs_phb_init_dynamic(phb);
-	scan_phb(phb);
-
-	return phb;
-}
-EXPORT_SYMBOL(init_phb_dynamic);
-
 /* RPA-specific bits for removing PHBs */
 int pcibios_remove_root_bus(struct pci_controller *phb)
 {
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index f3bad90..44abdeb 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -27,6 +27,7 @@
 
 #include <linux/pci.h>
 #include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
 
 static struct pci_bus *
 find_bus_among_children(struct pci_bus *bus,
@@ -179,3 +180,30 @@ pcibios_add_pci_devices(struct pci_bus *
 	}
 }
 EXPORT_SYMBOL_GPL(pcibios_add_pci_devices);
+
+struct pci_controller * __devinit init_phb_dynamic(struct device_node *dn)
+{
+	struct pci_controller *phb;
+	int primary;
+
+	primary = list_empty(&hose_list);
+	phb = pcibios_alloc_controller(dn);
+	if (!phb)
+		return NULL;
+	setup_phb(dn, phb);
+	pci_process_bridge_OF_ranges(phb, dn, 0);
+
+	pci_setup_phb_io_dynamic(phb, primary);
+
+	pci_devs_phb_init_dynamic(phb);
+
+	if (dn->child)
+		eeh_add_device_tree_early(dn);
+
+	scan_phb(phb);
+	pcibios_fixup_new_pci_devices(phb->bus, 0);
+	pci_bus_add_devices(phb->bus);
+
+	return phb;
+}
+EXPORT_SYMBOL_GPL(init_phb_dynamic);
diff --git a/include/asm-powerpc/ppc-pci.h b/include/asm-powerpc/ppc-pci.h
index f80482c..cf79bc7 100644
--- a/include/asm-powerpc/ppc-pci.h
+++ b/include/asm-powerpc/ppc-pci.h
@@ -38,6 +38,7 @@ void *traverse_pci_devices(struct device
 
 void pci_devs_phb_init(void);
 void pci_devs_phb_init_dynamic(struct pci_controller *phb);
+int setup_phb(struct device_node *dev, struct pci_controller *phb);
 void __devinit scan_phb(struct pci_controller *hose);
 
 /* From rtas_pci.h */

diff-tree 7177ee48eb3a9f042f10d5b4e49f1737b988123d (from 33bcc33f7f445c9c43a0f4a67b24561821b3aeaa)
Author: Olaf Hering <olh@suse.de>
Date:   Tue Mar 14 21:21:11 2006 +0100

    [PATCH] powerpc: remove duplicate EXPORT_SYMBOLS
    
    remove warnings when building a 64bit kernel.
    smp_call_function triggers also with 32bit kernel.
    
    WARNING: vmlinux: duplicate symbol 'smp_call_function' previous definition was in vmlinux
    arch/powerpc/kernel/ppc_ksyms.c:164:EXPORT_SYMBOL(smp_call_function);
    arch/powerpc/kernel/smp.c:300:EXPORT_SYMBOL(smp_call_function);
    
    WARNING: vmlinux: duplicate symbol 'ioremap' previous definition was in vmlinux
    arch/powerpc/kernel/ppc_ksyms.c:113:EXPORT_SYMBOL(ioremap);
    arch/powerpc/mm/pgtable_64.c:321:EXPORT_SYMBOL(ioremap);
    
    WARNING: vmlinux: duplicate symbol '__ioremap' previous definition was in vmlinux
    arch/powerpc/kernel/ppc_ksyms.c:117:EXPORT_SYMBOL(__ioremap);
    arch/powerpc/mm/pgtable_64.c:322:EXPORT_SYMBOL(__ioremap);
    
    WARNING: vmlinux: duplicate symbol 'iounmap' previous definition was in vmlinux
    arch/powerpc/kernel/ppc_ksyms.c:118:EXPORT_SYMBOL(iounmap);
    arch/powerpc/mm/pgtable_64.c:323:EXPORT_SYMBOL(iounmap);
    
    Signed-off-by: Olaf Hering <olh@suse.de>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 8a731ea..63ecbec 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -110,15 +110,6 @@ EXPORT_SYMBOL(_insw_ns);
 EXPORT_SYMBOL(_outsw_ns);
 EXPORT_SYMBOL(_insl_ns);
 EXPORT_SYMBOL(_outsl_ns);
-EXPORT_SYMBOL(ioremap);
-#ifdef CONFIG_44x
-EXPORT_SYMBOL(ioremap64);
-#endif
-EXPORT_SYMBOL(__ioremap);
-EXPORT_SYMBOL(iounmap);
-#ifdef CONFIG_PPC32
-EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
-#endif
 
 #if defined(CONFIG_PPC32) && (defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE))
 EXPORT_SYMBOL(ppc_ide_md);
@@ -161,7 +152,6 @@ EXPORT_SYMBOL(__flush_icache_range);
 EXPORT_SYMBOL(flush_dcache_range);
 
 #ifdef CONFIG_SMP
-EXPORT_SYMBOL(smp_call_function);
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(smp_hw_index);
 #endif
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index f4e5ac1..d296eb6 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -37,6 +37,7 @@
 
 unsigned long ioremap_base;
 unsigned long ioremap_bot;
+EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 int io_bat_index;
 
 #if defined(CONFIG_6xx) || defined(CONFIG_POWER3)
@@ -153,6 +154,7 @@ ioremap64(unsigned long long addr, unsig
 {
 	return __ioremap(addr, size, _PAGE_NO_CACHE);
 }
+EXPORT_SYMBOL(ioremap64);
 
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
@@ -162,6 +164,7 @@ ioremap(phys_addr_t addr, unsigned long 
 	return ioremap64(addr64, size);
 }
 #endif /* CONFIG_PHYS_64BIT */
+EXPORT_SYMBOL(ioremap);
 
 void __iomem *
 __ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
@@ -247,6 +250,7 @@ __ioremap(phys_addr_t addr, unsigned lon
 out:
 	return (void __iomem *) (v + ((unsigned long)addr & ~PAGE_MASK));
 }
+EXPORT_SYMBOL(__ioremap);
 
 void iounmap(volatile void __iomem *addr)
 {
@@ -259,6 +263,7 @@ void iounmap(volatile void __iomem *addr
 	if (addr > high_memory && (unsigned long) addr < ioremap_bot)
 		vunmap((void *) (PAGE_MASK & (unsigned long)addr));
 }
+EXPORT_SYMBOL(iounmap);
 
 void __iomem *ioport_map(unsigned long port, unsigned int len)
 {

diff-tree 33bcc33f7f445c9c43a0f4a67b24561821b3aeaa (from 486154a6329aca598d1590d6fc6ea074a8e3d7bd)
Author: Michael Neuling <mikey@neuling.org>
Date:   Tue Mar 14 17:11:51 2006 +1100

    [PATCH] powerpc: RTC memory corruption
    
    We should be memset'ing the data we are pointing to, not the pointer
    itself.  This is in an error path so we probably don't hit it much.
    
    Signed-off-by: Michael Neuling <mikey@neuling.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/powerpc/kernel/rtas-rtc.c b/arch/powerpc/kernel/rtas-rtc.c
index 635d3b9..34d073f 100644
--- a/arch/powerpc/kernel/rtas-rtc.c
+++ b/arch/powerpc/kernel/rtas-rtc.c
@@ -52,7 +52,7 @@ void rtas_get_rtc_time(struct rtc_time *
 		error = rtas_call(rtas_token("get-time-of-day"), 0, 8, ret);
 		if (error == RTAS_CLOCK_BUSY || rtas_is_extended_busy(error)) {
 			if (in_interrupt() && printk_ratelimit()) {
-				memset(&rtc_tm, 0, sizeof(struct rtc_time));
+				memset(rtc_tm, 0, sizeof(struct rtc_time));
 				printk(KERN_WARNING "error: reading clock"
 				       " would delay interrupt\n");
 				return;	/* delay not allowed */

diff-tree 486154a6329aca598d1590d6fc6ea074a8e3d7bd (from 6275062d9d9f1709543667cb509755c2a1c9153a)
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Sun Mar 12 10:55:01 2006 +1100

    [PATCH] powerpc: enable NAP only on cpus who support it to avoid memory corruption
    
    This patch fixes incorrect setting of powersave_nap to 1 on all
    PowerMacs, potentially causing memory corruption on some models. This
    bug was introuced by me during the 32/64 bits merge.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 34714d3..bbe7948 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -2491,9 +2491,7 @@ found:
 			pmac_mb.model_id = PMAC_TYPE_COMET;
 		iounmap(mach_id_ptr);
 	}
-#endif /* CONFIG_POWER4 */
 
-#ifdef CONFIG_6xx
 	/* Set default value of powersave_nap on machines that support it.
 	 * It appears that uninorth rev 3 has a problem with it, we don't
 	 * enable it on those. In theory, the flush-on-lock property is
@@ -2522,10 +2520,11 @@ found:
 	 * NAP mode
 	 */
 	powersave_lowspeed = 1;
-#endif /* CONFIG_6xx */
-#ifdef CONFIG_POWER4
+
+#else /* CONFIG_POWER4 */
 	powersave_nap = 1;
-#endif
+#endif  /* CONFIG_POWER4 */
+
 	/* Check for "mobile" machine */
 	if (model && (strncmp(model, "PowerBook", 9) == 0
 		   || strncmp(model, "iBook", 5) == 0))
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 1955462..29c2946 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -621,10 +621,6 @@ static void __init pmac_init_early(void)
 	/* Probe motherboard chipset */
 	pmac_feature_init();
 
-	/* We can NAP */
-	powersave_nap = 1;
-	printk(KERN_INFO "Using native/NAP idle loop\n");
-
 	/* Initialize debug stuff */
 	udbg_scc_init(!!strstr(cmd_line, "sccdbg"));
 	udbg_adb_init(!!strstr(cmd_line, "btextdbg"));

diff-tree 6275062d9d9f1709543667cb509755c2a1c9153a (from 0406e1c8a64b329377cae662cfcb1efccbde754d)
Author: Michael Ellerman <michael@ellerman.id.au>
Date:   Fri Mar 10 15:01:08 2006 +1100

    [PATCH] powerpc: Clarify wording for CRASH_DUMP Kconfig option
    
    The wording of the CRASH_DUMP Kconfig option is not very clear. It gives you a
    kernel that can be used _as_ the kdump kernel, not a kernel that can boot into
    a kdump kernel.
    
    Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a834f9e..dfba817 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -580,7 +580,7 @@ config KEXEC
 	  strongly in flux, so no good recommendation can be made.
 
 config CRASH_DUMP
-	bool "kernel crash dumps (EXPERIMENTAL)"
+	bool "Build a kdump crash kernel (EXPERIMENTAL)"
 	depends on PPC_MULTIPLATFORM && PPC64 && EXPERIMENTAL
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.

diff-tree 8ff99aa6d36c4e568c85197e6e1439c15b206504 (from 17c3dec53d68857a5c9e3d671b6a2b82225ec202)
Author: Olaf Hering <olh@suse.de>
Date:   Sat Mar 4 13:15:40 2006 +0100

    [PATCH] powerpc: correct cacheflush loop in zImage
    
    Correct the loop for cacheflush. No idea where I copied the code from,
    but the original does not work correct. Maybe the flush is not needed.
    
    Signed-off-by: Olaf Hering <olh@suse.de>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index e0192c2..70e65b1 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -45,7 +45,8 @@ _zimage_start:
 	bdnz	2b
 
 	/* Do a cache flush for our text, in case OF didn't */
-3:	lis	r9,_start@h
+3:	lis	r9,_start@ha
+	addi	r9,r9,_start@l
 	add	r9,r0,r9
 	lis	r8,_etext@ha
 	addi	r8,r8,_etext@l
@@ -53,7 +54,7 @@ _zimage_start:
 4:	dcbf	r0,r9
 	icbi	r0,r9
 	addi	r9,r9,0x20
-	cmplwi	0,r9,8
+	cmplw	cr0,r9,r8
 	blt	4b
 	sync
 	isync

diff-tree 17c3dec53d68857a5c9e3d671b6a2b82225ec202 (from cdc1e86904587171e70e16f7b77e8d2879f06c3c)
Author: Paul Mackerras <paulus@samba.org>
Date:   Wed Mar 15 13:47:15 2006 +1100

    powerpc: Fix problem with time going backwards
    
    The recent changes to keep gettimeofday in sync with xtime had the side
    effect that it was occasionally possible for the time reported by
    gettimeofday to go back by a microsecond.  There were two reasons:
    (1) when we recalculated the offsets used by gettimeofday every 2^31
    timebase ticks, we lost an accumulated fractional microsecond, and
    (2) because the update is done some time after the notional start of
    jiffy, if ntp is slowing the clock, it is possible to see time go backwards
    when the timebase factor gets reduced.
    
    This fixes it by (a) slowing the gettimeofday clock by about 1us in
    2^31 timebase ticks (a factor of less than 1 in 3.7 million), and (b)
    adjusting the timebase offsets in the rare case that the gettimeofday
    result could possibly go backwards (i.e. when ntp is slowing the clock
    and the timer interrupt is late).  In this case the adjustment will
    reduce to zero eventually because of (a).
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 2a7ddc5..86f7e3d 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -283,9 +283,9 @@ static inline void update_gtod(u64 new_t
 	 * the two values of tb_update_count match and are even then the
 	 * tb_to_xs and stamp_xsec values are consistent.  If not, then it
 	 * loops back and reads them again until this criteria is met.
+	 * We expect the caller to have done the first increment of
+	 * vdso_data->tb_update_count already.
 	 */
-	++(vdso_data->tb_update_count);
-	smp_wmb();
 	vdso_data->tb_orig_stamp = new_tb_stamp;
 	vdso_data->stamp_xsec = new_stamp_xsec;
 	vdso_data->tb_to_xs = new_tb_to_xs;
@@ -310,20 +310,15 @@ static __inline__ void timer_recalc_offs
 	unsigned long offset;
 	u64 new_stamp_xsec;
 	u64 tlen, t2x;
+	u64 tb, xsec_old, xsec_new;
+	struct gettimeofday_vars *varp;
 
 	if (__USE_RTC())
 		return;
 	tlen = current_tick_length();
 	offset = cur_tb - do_gtod.varp->tb_orig_stamp;
-	if (tlen == last_tick_len && offset < 0x80000000u) {
-		/* check that we're still in sync; if not, resync */
-		struct timeval tv;
-		__do_gettimeofday(&tv, cur_tb);
-		if (tv.tv_sec <= xtime.tv_sec &&
-		    (tv.tv_sec < xtime.tv_sec ||
-		     tv.tv_usec * 1000 <= xtime.tv_nsec))
-			return;
-	}
+	if (tlen == last_tick_len && offset < 0x80000000u)
+		return;
 	if (tlen != last_tick_len) {
 		t2x = mulhdu(tlen << TICKLEN_SHIFT, ticklen_to_xs);
 		last_tick_len = tlen;
@@ -332,6 +327,21 @@ static __inline__ void timer_recalc_offs
 	new_stamp_xsec = (u64) xtime.tv_nsec * XSEC_PER_SEC;
 	do_div(new_stamp_xsec, 1000000000);
 	new_stamp_xsec += (u64) xtime.tv_sec * XSEC_PER_SEC;
+
+	++vdso_data->tb_update_count;
+	smp_mb();
+
+	/*
+	 * Make sure time doesn't go backwards for userspace gettimeofday.
+	 */
+	tb = get_tb();
+	varp = do_gtod.varp;
+	xsec_old = mulhdu(tb - varp->tb_orig_stamp, varp->tb_to_xs)
+		+ varp->stamp_xsec;
+	xsec_new = mulhdu(tb - cur_tb, t2x) + new_stamp_xsec;
+	if (xsec_new < xsec_old)
+		new_stamp_xsec += xsec_old - xsec_new;
+
 	update_gtod(cur_tb, new_stamp_xsec, t2x);
 }
 
@@ -564,6 +574,10 @@ int do_settimeofday(struct timespec *tv)
 	}
 #endif
 
+	/* Make userspace gettimeofday spin until we're done. */
+	++vdso_data->tb_update_count;
+	smp_mb();
+
 	/*
 	 * Subtract off the number of nanoseconds since the
 	 * beginning of the last tick.
@@ -724,10 +738,16 @@ void __init time_init(void)
 	 * It is computed as:
 	 * ticklen_to_xs = 2^N / (tb_ticks_per_jiffy * 1e9)
 	 * where N = 64 + 20 - TICKLEN_SCALE - TICKLEN_SHIFT
-	 * so as to give the result as a 0.64 fixed-point fraction.
+	 * which turns out to be N = 51 - SHIFT_HZ.
+	 * This gives the result as a 0.64 fixed-point fraction.
+	 * That value is reduced by an offset amounting to 1 xsec per
+	 * 2^31 timebase ticks to avoid problems with time going backwards
+	 * by 1 xsec when we do timer_recalc_offset due to losing the
+	 * fractional xsec.  That offset is equal to ppc_tb_freq/2^51
+	 * since there are 2^20 xsec in a second.
 	 */
-	div128_by_32(1ULL << (64 + 20 - TICKLEN_SCALE - TICKLEN_SHIFT), 0,
-		     tb_ticks_per_jiffy, &res);
+	div128_by_32((1ULL << 51) - ppc_tb_freq, 0,
+		     tb_ticks_per_jiffy << SHIFT_HZ, &res);
 	div128_by_32(res.result_high, res.result_low, NSEC_PER_SEC, &res);
 	ticklen_to_xs = res.result_low;
 

diff-tree 82dfdcae0d57c842e02f037758687eef42fb7af6 (from 3759fa9c55923f719ae944a3f8fbb029b36f759d)
Author: Paul Mackerras <paulus@samba.org>
Date:   Tue Mar 14 11:35:37 2006 +1100

    powerpc: Disallow lparcfg being a module
    
    The lparcfg code needs several things which are pretty arcane internal
    details and which we don't want to export, which means that lparcfg
    doesn't work when built as a module.  This makes it a bool instead of
    a tristate in the Kconfig so that users can't try to build it as a
    module.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 4e5c8f8..a57032c 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -19,7 +19,7 @@ config SCANLOG
 	depends on RTAS_PROC && PPC_PSERIES
 
 config LPARCFG
-	tristate "LPAR Configuration Data"
+	bool "LPAR Configuration Data"
 	depends on PPC_PSERIES || PPC_ISERIES
 	help
 	Provide system capacity information via human readable

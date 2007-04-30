Return-Path: <dgibson@ozlabs.org>
Date: Mon, 30 Apr 2007 15:37:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: powerpc: Fix STRICT_MM_TYPECHECKS
Message-ID: <20070430053705.GF6436@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since we don't have it active by default, the STRICT_MM_TYPECHECKS
option has bitrotted again.  This patch fixes a couple of simple build
fixes if the option is selected.  First, pud_t mustn't be defined in
page.h on 32-bit systems, because it conflicts with the version in the
generic pud-folding code.  Second, pci_32.c is missing a __pgprot()
wrapper call.  Third, a couple of PS3 files use constants of type
pgprot_t when they need the raw values, we add pgprot_val() calls to
fix this.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 arch/powerpc/kernel/pci_32.c      |    2 +-
 arch/powerpc/platforms/ps3/htab.c |    3 ++-
 arch/powerpc/platforms/ps3/spu.c  |    2 +-
 include/asm-powerpc/page.h        |    2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

Index: working-2.6/include/asm-powerpc/page.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/page.h	2007-04-30 15:33:05.000000000 +1000
+++ working-2.6/include/asm-powerpc/page.h	2007-04-30 15:36:20.000000000 +1000
@@ -126,7 +126,7 @@ typedef struct { unsigned long pmd; } pm
 #define __pmd(x)	((pmd_t) { (x) })
 
 /* PUD level exusts only on 4k pages */
-#ifndef CONFIG_PPC_64K_PAGES
+#if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_64K_PAGES)
 typedef struct { unsigned long pud; } pud_t;
 #define pud_val(x)	((x).pud)
 #define __pud(x)	((pud_t) { (x) })
Index: working-2.6/arch/powerpc/kernel/pci_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/kernel/pci_32.c	2007-04-30 15:33:00.000000000 +1000
+++ working-2.6/arch/powerpc/kernel/pci_32.c	2007-04-30 15:33:11.000000000 +1000
@@ -1658,7 +1658,7 @@ pgprot_t pci_phys_mem_access_prot(struct
 	int i;
 
 	if (page_is_ram(pfn))
-		return prot;
+		return __pgprot(prot);
 
 	prot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
 
Index: working-2.6/arch/powerpc/platforms/ps3/spu.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/ps3/spu.c	2007-04-30 15:33:00.000000000 +1000
+++ working-2.6/arch/powerpc/platforms/ps3/spu.c	2007-04-30 15:33:11.000000000 +1000
@@ -184,7 +184,7 @@ static int __init setup_areas(struct spu
 
 	spu_pdata(spu)->shadow = __ioremap(
 		spu_pdata(spu)->shadow_addr, sizeof(struct spe_shadow),
-		PAGE_READONLY | _PAGE_NO_CACHE | _PAGE_GUARDED);
+		pgprot_val(PAGE_READONLY) | _PAGE_NO_CACHE | _PAGE_GUARDED);
 	if (!spu_pdata(spu)->shadow) {
 		pr_debug("%s:%d: ioremap shadow failed\n", __func__, __LINE__);
 		goto fail_ioremap;
Index: working-2.6/arch/powerpc/platforms/ps3/htab.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/ps3/htab.c	2007-04-30 15:33:01.000000000 +1000
+++ working-2.6/arch/powerpc/platforms/ps3/htab.c	2007-04-30 15:33:11.000000000 +1000
@@ -273,7 +273,8 @@ void __init ps3_map_htab(void)
 
 	result = lv1_map_htab(0, &htab_addr);
 
-	htab = (hpte_t *)__ioremap(htab_addr, htab_size, PAGE_READONLY_X);
+	htab = (hpte_t *)__ioremap(htab_addr, htab_size,
+				   pgprot_val(PAGE_READONLY_X));
 
 	DBG("%s:%d: lpar %016lxh, virt %016lxh\n", __func__, __LINE__,
 		htab_addr, (unsigned long)htab);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

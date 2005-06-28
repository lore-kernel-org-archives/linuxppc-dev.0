Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id A373F67A77
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2005 06:22:48 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	j5SKRmpx001711
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2005 13:27:48 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j5SKQZHF011342
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2005 15:26:35 -0500 (CDT)
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1119990163.1798.40.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 28 Jun 2005 15:22:44 -0500
Subject: [Fwd: [PATCH] PPC32 mem_pieces interface cleanup]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Well, Ben suggested I send it here too...
And Kumar abused me too.  Want to see my scar?

jdl

-----Forwarded Message-----
From: Jon Loeliger <jdl@freescale.com>
To: linuxppc-embedded@ozlabs.org <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] PPC32 mem_pieces interface cleanup
Date: Mon, 27 Jun 2005 11:28:50 -0500

Guys,

As an initial step towards getting the OF Flat Dev tree
handled in the PPC32 tree, this patch cleans up some of
the interface parts of the very early mem_pieces manager
and adds some PPC64-LMB-like routines as well.

It has been built and booted on 85xx and pmac boards.

Thanks,
jdl


Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>


Index: arch/ppc/mm/init.c
===================================================================
--- 413e8c09a51b5e4ee6850da2b7a65f9a9af0be9c/arch/ppc/mm/init.c  (mode:100644)
+++ uncommitted/arch/ppc/mm/init.c  (mode:100644)
@@ -316,7 +316,7 @@
 	if (init_bootmem_done) {
 		p = alloc_bootmem_pages(PAGE_SIZE);
 	} else {
-		p = mem_pieces_find(PAGE_SIZE, PAGE_SIZE);
+		p = mem_pieces_find(&phys_avail, PAGE_SIZE, PAGE_SIZE);
 	}
 	return p;
 }
@@ -495,10 +495,8 @@
 	 * Initially, available physical memory is equivalent to all
 	 * physical memory.
 	 */
-
-	phys_avail.regions[0].address = PPC_MEMSTART;
-	phys_avail.regions[0].size = total_memory;
-	phys_avail.n_regions = 1;
+	mem_pieces_reset(&phys_avail);
+	mem_pieces_add(&phys_avail, PPC_MEMSTART, total_memory);
 
 	/*
 	 * Map out the kernel text/data/bss from the available physical
Index: arch/ppc/mm/mem_pieces.c
===================================================================
--- 413e8c09a51b5e4ee6850da2b7a65f9a9af0be9c/arch/ppc/mm/mem_pieces.c  (mode:100644)
+++ uncommitted/arch/ppc/mm/mem_pieces.c  (mode:100644)
@@ -22,19 +22,105 @@
 
 #include "mem_pieces.h"
 
-extern struct mem_pieces phys_avail;
 
-static void mem_pieces_print(struct mem_pieces *);
+static unsigned int __init mem_pieces_addrs_adjacent(unsigned int base1,
+						    unsigned int size1,
+						    unsigned int base2,
+						     unsigned int size2);
+static int __init mem_pieces_regions_adjacent(struct mem_pieces *mp,
+					      unsigned int r1,
+					      unsigned int r2);
+static void __init mem_pieces_coalesce_regions(struct mem_pieces *mp,
+					       unsigned int r1,
+					       unsigned int r2);
+
+
+void __init
+mem_pieces_reset(struct mem_pieces *mp)
+{
+	/*
+	 * Create a dummy zero size block which will get coalesced
+	 * away later.  This simplifies the mem_pieces_add() code below.
+	 */
+	mp->regions[0].address = 0;
+	mp->regions[0].size = 0;
+	mp->n_regions = 1;
+}
+
+
+/*
+ * mem_pieces_add() -- Add a memory block to a sorted region table,
+ *	merging adjacent blocks if possible.
+ *	Returns 0 on straight add, >0 on coallsced, -1 on failure.
+ */
+
+int __init
+mem_pieces_add(struct mem_pieces *mp, unsigned int base, unsigned int size)
+{
+	unsigned int i;
+	unsigned int coalesced;
+
+	/*
+	 * First try and coalesce this mem_piece with another.
+	 */
+	coalesced = 0;
+	for (i = 0; i < mp->n_regions; i++) {
+		unsigned int rgnbase = mp->regions[i].address;
+		unsigned int rgnsize = mp->regions[i].size;
+		int adjacent = mem_pieces_addrs_adjacent(base, size,
+							 rgnbase, rgnsize);
+		if (adjacent > 0) {
+			mp->regions[i].address -= size;
+			mp->regions[i].size += size;
+			coalesced++;
+			break;
+		} else if (adjacent < 0) {
+			mp->regions[i].size += size;
+			coalesced++;
+			break;
+		}
+	}
+
+	if ((i < mp->n_regions-1) && mem_pieces_regions_adjacent(mp, i, i+1)) {
+		mem_pieces_coalesce_regions(mp, i, i+1);
+		coalesced++;
+	}
+
+	if (coalesced) {
+		return coalesced;
+	} else if (mp->n_regions >= MEM_PIECES_MAX ) {
+		return -1;
+	}
+
+	/*
+	 * Couldn't coalesce the new mem_piece, so add it to the sorted table.
+	 */
+	for (i = mp->n_regions-1; i >= 0; i--) {
+		if (base < mp->regions[i].address) {
+			/* Shift up a slot. */
+			mp->regions[i+1].address = mp->regions[i].address;
+			mp->regions[i+1].size = mp->regions[i].size;
+		}  else {
+			/* Insert in newly opened slot. */
+			mp->regions[i+1].address = base;
+			mp->regions[i+1].size = size;
+			break;
+		}
+	}
+	++mp->n_regions;
+
+	return 0;
+}
+
 
 /*
  * Scan a region for a piece of a given size with the required alignment.
  */
 void __init *
-mem_pieces_find(unsigned int size, unsigned int align)
+mem_pieces_find(struct mem_pieces *mp, unsigned int size, unsigned int align)
 {
 	int i;
 	unsigned a, e;
-	struct mem_pieces *mp = &phys_avail;
 
 	for (i = 0; i < mp->n_regions; ++i) {
 		a = mp->regions[i].address;
@@ -50,6 +136,7 @@
 	return NULL;
 }
 
+
 /*
  * Remove some memory from an array of pieces
  */
@@ -59,7 +146,7 @@
 {
 	int i, j;
 	unsigned int end, rs, re;
-	struct reg_property *rp;
+	struct mem_pieces_property *rp;
 
 	end = start + size;
 	for (i = 0, rp = mp->regions; i < mp->n_regions; ++i, ++rp) {
@@ -109,17 +196,20 @@
 	}
 }
 
-static void __init
+
+void __init
 mem_pieces_print(struct mem_pieces *mp)
 {
 	int i;
 
-	for (i = 0; i < mp->n_regions; ++i)
+	for (i = 0; i < mp->n_regions; ++i) {
 		printk(" [%x, %x)", mp->regions[i].address,
 		       mp->regions[i].address + mp->regions[i].size);
+	}
 	printk("\n");
 }
 
+
 void __init
 mem_pieces_sort(struct mem_pieces *mp)
 {
@@ -139,6 +229,7 @@
 	}
 }
 
+
 void __init
 mem_pieces_coalesce(struct mem_pieces *mp)
 {
@@ -161,3 +252,66 @@
 	}
 	mp->n_regions = d;
 }
+
+
+unsigned int __init
+mem_pieces_get_phys_mem_size(struct mem_pieces *mp)
+{
+	int i;
+	unsigned int total = 0;
+
+	for (i = 0; i < mp->n_regions; i++) {
+		total += mp->regions[i].size;
+	}
+	return total;
+}
+
+
+static unsigned int __init
+mem_pieces_addrs_adjacent(unsigned int base1, unsigned int size1,
+			 unsigned int base2, unsigned int size2)
+{
+	if (base2 == base1 + size1) {
+		return 1;
+	} else if (base1 == base2 + size2) {
+		return -1;
+	}
+
+	return 0;
+}
+
+
+static int __init
+mem_pieces_regions_adjacent(struct mem_pieces *mp,
+			    unsigned int r1,
+			    unsigned int r2)
+{
+	unsigned int base1 = mp->regions[r1].address;
+	unsigned int size1 = mp->regions[r1].size;
+	unsigned int base2 = mp->regions[r2].address;
+	unsigned int size2 = mp->regions[r2].size;
+
+	return mem_pieces_addrs_adjacent(base1, size1, base2, size2);
+}
+
+
+/*
+ * Coalesce block r2 into block r1.
+ * Assumes base addr of region 1 < base addr of region 2
+ */
+
+static void __init
+mem_pieces_coalesce_regions(struct mem_pieces *mp,
+			    unsigned int r1,
+			    unsigned int r2)
+{
+	unsigned int i;
+
+	mp->regions[r1].size += mp->regions[r2].size;
+	for (i = r2; i < mp->n_regions-1; i++) {
+		mp->regions[i].address = mp->regions[i+1].address;
+		mp->regions[i].size = mp->regions[i+1].size;
+	}
+	--mp->n_regions;
+
+}
Index: arch/ppc/mm/mem_pieces.h
===================================================================
--- 413e8c09a51b5e4ee6850da2b7a65f9a9af0be9c/arch/ppc/mm/mem_pieces.h  (mode:100644)
+++ uncommitted/arch/ppc/mm/mem_pieces.h  (mode:100644)
@@ -17,8 +17,6 @@
 #ifndef __MEM_PIECES_H__
 #define	__MEM_PIECES_H__
 
-#include <asm/prom.h>
-
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -26,20 +24,34 @@
 
 /* Type Definitions */
 
+struct mem_pieces_property {
+	unsigned int address;
+	unsigned int size;
+};
+
+
 #define	MEM_PIECES_MAX	32
 
 struct mem_pieces {
     int n_regions;
-    struct reg_property regions[MEM_PIECES_MAX];
+    struct mem_pieces_property regions[MEM_PIECES_MAX];
 };
 
 /* Function Prototypes */
 
-extern void	*mem_pieces_find(unsigned int size, unsigned int align);
-extern void	 mem_pieces_remove(struct mem_pieces *mp, unsigned int start,
+extern void	 mem_pieces_reset(struct mem_pieces *mp);
+extern int	 mem_pieces_add(struct mem_pieces *mp,
+				unsigned int base, unsigned int size);
+extern void	*mem_pieces_find(struct mem_pieces *mp,
+				 unsigned int size, unsigned int align);
+extern void	 mem_pieces_remove(struct mem_pieces *mp,
+				   unsigned int start,
 				   unsigned int size, int must_exist);
 extern void	 mem_pieces_coalesce(struct mem_pieces *mp);
 extern void	 mem_pieces_sort(struct mem_pieces *mp);
+extern unsigned int mem_pieces_get_phys_mem_size(struct mem_pieces *mp);
+extern void	 mem_pieces_print(struct mem_pieces *);
+
 
 #ifdef __cplusplus
 }
Index: arch/ppc/mm/ppc_mmu.c
===================================================================
--- 413e8c09a51b5e4ee6850da2b7a65f9a9af0be9c/arch/ppc/mm/ppc_mmu.c  (mode:100644)
+++ uncommitted/arch/ppc/mm/ppc_mmu.c  (mode:100644)
@@ -186,6 +186,7 @@
 	unsigned int hmask, mb, mb2;
 	unsigned int n_hpteg, lg_n_hpteg;
 
+	extern struct mem_pieces phys_avail;
 	extern unsigned int hash_page_patch_A[];
 	extern unsigned int hash_page_patch_B[], hash_page_patch_C[];
 	extern unsigned int hash_page[];
@@ -245,7 +246,7 @@
 	 * Find some memory for the hash table.
 	 */
 	if ( ppc_md.progress ) ppc_md.progress("hash:find piece", 0x322);
-	Hash = mem_pieces_find(Hash_size, Hash_size);
+	Hash = mem_pieces_find(&phys_avail, Hash_size, Hash_size);
 	cacheable_memzero(Hash, Hash_size);
 	_SDR1 = __pa(Hash) | SDR1_LOW_BITS;
 #endif /* CONFIG_POWER4 */
Index: arch/ppc/platforms/pmac_setup.c
===================================================================
--- 413e8c09a51b5e4ee6850da2b7a65f9a9af0be9c/arch/ppc/platforms/pmac_setup.c  (mode:100644)
+++ uncommitted/arch/ppc/platforms/pmac_setup.c  (mode:100644)
@@ -575,7 +575,6 @@
 static int __init
 get_mem_prop(char *name, struct mem_pieces *mp)
 {
-	struct reg_property *rp;
 	int i, s;
 	unsigned int *ip;
 	int nac = prom_n_addr_cells(memory_node);
@@ -588,18 +587,16 @@
 		return 0;
 	}
 	s /= (nsc + nac) * 4;
-	rp = mp->regions;
 	for (i = 0; i < s; ++i, ip += nac+nsc) {
+		unsigned int size;
 		if (nac >= 2 && ip[nac-2] != 0)
 			continue;
-		rp->address = ip[nac-1];
 		if (nsc >= 2 && ip[nac+nsc-2] != 0)
-			rp->size = ~0U;
+			size = ~0U;
 		else
-			rp->size = ip[nac+nsc-1];
-		++rp;
+			size = ip[nac+nsc-1];
+		mem_pieces_add(mp, ip[nac-1], size);
 	}
-	mp->n_regions = rp - mp->regions;
 
 	/* Make sure the pieces are sorted. */
 	mem_pieces_sort(mp);
@@ -620,6 +617,8 @@
 	unsigned long a, total;
 	struct mem_pieces phys_mem;
 
+	mem_pieces_reset(&phys_mem);
+
 	/*
 	 * Find out where physical memory is, and check that it
 	 * starts at 0 and is contiguous.  It seems that RAM is

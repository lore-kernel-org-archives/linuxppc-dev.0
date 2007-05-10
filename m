Return-Path: <dgibson@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 7/7] Kill typedef-ed structs for hash PTEs and BATs
In-Reply-To: <20070510060449.GA3118@localhost.localdomain>
Message-Id: <20070510060556.EC321DDEB9@ozlabs.org>
Date: Thu, 10 May 2007 16:05:56 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Using typedefs to rename structure types if frowned on by CodingStyle.
However, we do so for the hash PTE structure on both ppc32 (where it's
called "PTE") and ppc64 (where it's called "hpte_t").  On ppc32 we
also have such a typedef for the BATs ("BAT").

This patch removes this unhelpful use of typedefs, in the process
bringing ppc32 and ppc64 closer together, by using the name "struct
hash_pte" in both cases.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/mm/hash_native_64.c  |   22 +++++++++++-----------
 arch/powerpc/mm/hash_utils_64.c   |    2 +-
 arch/powerpc/mm/mmu_decl.h        |    4 ++--
 arch/powerpc/mm/ppc_mmu_32.c      |    6 +++---
 arch/powerpc/platforms/ps3/htab.c |   14 +++++++-------
 include/asm-powerpc/mmu-hash32.h  |    8 ++++----
 include/asm-powerpc/mmu-hash64.h  |    6 +++---
 7 files changed, 31 insertions(+), 31 deletions(-)

Index: working-2.6/include/asm-powerpc/mmu-hash32.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/mmu-hash32.h	2007-05-10 15:51:06.000000000 +1000
+++ working-2.6/include/asm-powerpc/mmu-hash32.h	2007-05-10 15:51:20.000000000 +1000
@@ -28,7 +28,7 @@
 #define BPP_RW	0x02		/* Read/write */
 
 #ifndef __ASSEMBLY__
-typedef struct _BAT {
+struct ppc_bat {
 	struct {
 		unsigned long bepi:15;	/* Effective page index (virtual address) */
 		unsigned long :4;	/* Unused */
@@ -46,7 +46,7 @@ typedef struct _BAT {
 		unsigned long :1;	/* Unused */
 		unsigned long pp:2;	/* Page access protections */
 	} batl;			/* Lower register */
-} BAT;
+};
 #endif /* !__ASSEMBLY__ */
 
 /*
@@ -62,7 +62,7 @@ typedef struct _BAT {
 #ifndef __ASSEMBLY__
 
 /* Hardware Page Table Entry */
-typedef struct _PTE {
+struct hash_pte {
 	unsigned long v:1;	/* Entry is valid */
 	unsigned long vsid:24;	/* Virtual segment identifier */
 	unsigned long h:1;	/* Hash algorithm indicator */
@@ -77,7 +77,7 @@ typedef struct _PTE {
 	unsigned long g:1;	/* Guarded */
 	unsigned long  :1;	/* Unused */
 	unsigned long pp:2;	/* Page protection */
-} PTE;
+};
 
 typedef struct {
 	unsigned long id;
Index: working-2.6/arch/powerpc/mm/ppc_mmu_32.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/ppc_mmu_32.c	2007-05-10 15:51:06.000000000 +1000
+++ working-2.6/arch/powerpc/mm/ppc_mmu_32.c	2007-05-10 15:51:20.000000000 +1000
@@ -34,12 +34,12 @@
 
 #include "mmu_decl.h"
 
-PTE *Hash, *Hash_end;
+struct hash_pte *Hash, *Hash_end;
 unsigned long Hash_size, Hash_mask;
 unsigned long _SDR1;
 
 union ubat {			/* BAT register values to be loaded */
-	BAT	bat;
+	struct ppc_bat bat;
 	u32	word[2];
 } BATS[8][2];			/* 8 pairs of IBAT, DBAT */
 
@@ -244,7 +244,7 @@ void __init MMU_init_hw(void)
 	cacheable_memzero(Hash, Hash_size);
 	_SDR1 = __pa(Hash) | SDR1_LOW_BITS;
 
-	Hash_end = (PTE *) ((unsigned long)Hash + Hash_size);
+	Hash_end = (struct hash_pte *) ((unsigned long)Hash + Hash_size);
 
 	printk("Total memory = %ldMB; using %ldkB for hash table (at %p)\n",
 	       total_memory >> 20, Hash_size >> 10, Hash);
Index: working-2.6/arch/powerpc/mm/mmu_decl.h
===================================================================
--- working-2.6.orig/arch/powerpc/mm/mmu_decl.h	2007-05-10 15:51:06.000000000 +1000
+++ working-2.6/arch/powerpc/mm/mmu_decl.h	2007-05-10 15:51:20.000000000 +1000
@@ -39,8 +39,8 @@ extern int __map_without_bats;
 extern unsigned long ioremap_base;
 extern unsigned int rtas_data, rtas_size;
 
-struct _PTE;
-extern struct _PTE *Hash, *Hash_end;
+struct hash_pte;
+extern struct hash_pte *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
 
 extern unsigned int num_tlbcam_entries;
Index: working-2.6/include/asm-powerpc/mmu-hash64.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/mmu-hash64.h	2007-05-10 15:51:06.000000000 +1000
+++ working-2.6/include/asm-powerpc/mmu-hash64.h	2007-05-10 15:51:20.000000000 +1000
@@ -102,12 +102,12 @@ extern char initial_stab[];
 
 #ifndef __ASSEMBLY__
 
-typedef struct {
+struct hash_pte {
 	unsigned long v;
 	unsigned long r;
-} hpte_t;
+};
 
-extern hpte_t *htab_address;
+extern struct hash_pte *htab_address;
 extern unsigned long htab_size_bytes;
 extern unsigned long htab_hash_mask;
 
Index: working-2.6/arch/powerpc/mm/hash_native_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hash_native_64.c	2007-05-10 15:51:06.000000000 +1000
+++ working-2.6/arch/powerpc/mm/hash_native_64.c	2007-05-10 15:51:20.000000000 +1000
@@ -104,7 +104,7 @@ static inline void tlbie(unsigned long v
 		spin_unlock(&native_tlbie_lock);
 }
 
-static inline void native_lock_hpte(hpte_t *hptep)
+static inline void native_lock_hpte(struct hash_pte *hptep)
 {
 	unsigned long *word = &hptep->v;
 
@@ -116,7 +116,7 @@ static inline void native_lock_hpte(hpte
 	}
 }
 
-static inline void native_unlock_hpte(hpte_t *hptep)
+static inline void native_unlock_hpte(struct hash_pte *hptep)
 {
 	unsigned long *word = &hptep->v;
 
@@ -128,7 +128,7 @@ static long native_hpte_insert(unsigned 
 			unsigned long pa, unsigned long rflags,
 			unsigned long vflags, int psize)
 {
-	hpte_t *hptep = htab_address + hpte_group;
+	struct hash_pte *hptep = htab_address + hpte_group;
 	unsigned long hpte_v, hpte_r;
 	int i;
 
@@ -177,7 +177,7 @@ static long native_hpte_insert(unsigned 
 
 static long native_hpte_remove(unsigned long hpte_group)
 {
-	hpte_t *hptep;
+	struct hash_pte *hptep;
 	int i;
 	int slot_offset;
 	unsigned long hpte_v;
@@ -217,7 +217,7 @@ static long native_hpte_remove(unsigned 
 static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 				 unsigned long va, int psize, int local)
 {
-	hpte_t *hptep = htab_address + slot;
+	struct hash_pte *hptep = htab_address + slot;
 	unsigned long hpte_v, want_v;
 	int ret = 0;
 
@@ -251,7 +251,7 @@ static long native_hpte_updatepp(unsigne
 
 static long native_hpte_find(unsigned long va, int psize)
 {
-	hpte_t *hptep;
+	struct hash_pte *hptep;
 	unsigned long hash;
 	unsigned long i, j;
 	long slot;
@@ -294,7 +294,7 @@ static void native_hpte_updateboltedpp(u
 {
 	unsigned long vsid, va;
 	long slot;
-	hpte_t *hptep;
+	struct hash_pte *hptep;
 
 	vsid = get_kernel_vsid(ea);
 	va = (vsid << 28) | (ea & 0x0fffffff);
@@ -315,7 +315,7 @@ static void native_hpte_updateboltedpp(u
 static void native_hpte_invalidate(unsigned long slot, unsigned long va,
 				   int psize, int local)
 {
-	hpte_t *hptep = htab_address + slot;
+	struct hash_pte *hptep = htab_address + slot;
 	unsigned long hpte_v;
 	unsigned long want_v;
 	unsigned long flags;
@@ -345,7 +345,7 @@ static void native_hpte_invalidate(unsig
 #define LP_BITS		8
 #define LP_MASK(i)	((0xFF >> (i)) << LP_SHIFT)
 
-static void hpte_decode(hpte_t *hpte, unsigned long slot,
+static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
 			int *psize, unsigned long *va)
 {
 	unsigned long hpte_r = hpte->r;
@@ -418,7 +418,7 @@ static void hpte_decode(hpte_t *hpte, un
 static void native_hpte_clear(void)
 {
 	unsigned long slot, slots, flags;
-	hpte_t *hptep = htab_address;
+	struct hash_pte *hptep = htab_address;
 	unsigned long hpte_v, va;
 	unsigned long pteg_count;
 	int psize;
@@ -465,7 +465,7 @@ static void native_hpte_clear(void)
 static void native_flush_hash_range(unsigned long number, int local)
 {
 	unsigned long va, hash, index, hidx, shift, slot;
-	hpte_t *hptep;
+	struct hash_pte *hptep;
 	unsigned long hpte_v;
 	unsigned long want_v;
 	unsigned long flags;
Index: working-2.6/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hash_utils_64.c	2007-05-10 15:51:06.000000000 +1000
+++ working-2.6/arch/powerpc/mm/hash_utils_64.c	2007-05-10 15:51:20.000000000 +1000
@@ -87,7 +87,7 @@ extern unsigned long dart_tablebase;
 static unsigned long _SDR1;
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
-hpte_t *htab_address;
+struct hash_pte *htab_address;
 unsigned long htab_size_bytes;
 unsigned long htab_hash_mask;
 int mmu_linear_psize = MMU_PAGE_4K;
Index: working-2.6/arch/powerpc/platforms/ps3/htab.c
===================================================================
--- working-2.6.orig/arch/powerpc/platforms/ps3/htab.c	2007-05-10 15:51:06.000000000 +1000
+++ working-2.6/arch/powerpc/platforms/ps3/htab.c	2007-05-10 15:51:20.000000000 +1000
@@ -34,7 +34,7 @@
 #define DBG(fmt...) do{if(0)printk(fmt);}while(0)
 #endif
 
-static hpte_t *htab;
+static struct hash_pte *htab;
 static unsigned long htab_addr;
 static unsigned char *bolttab;
 static unsigned char *inusetab;
@@ -44,8 +44,8 @@ static DEFINE_SPINLOCK(ps3_bolttab_lock)
 #define debug_dump_hpte(_a, _b, _c, _d, _e, _f, _g) \
 	_debug_dump_hpte(_a, _b, _c, _d, _e, _f, _g, __func__, __LINE__)
 static void _debug_dump_hpte(unsigned long pa, unsigned long va,
-	unsigned long group, unsigned long bitmap, hpte_t lhpte, int psize,
-	unsigned long slot, const char* func, int line)
+	unsigned long group, unsigned long bitmap, struct hash_pte lhpte,
+	int psize, unsigned long slot, const char* func, int line)
 {
 	DBG("%s:%d: pa     = %lxh\n", func, line, pa);
 	DBG("%s:%d: lpar   = %lxh\n", func, line,
@@ -63,7 +63,7 @@ static long ps3_hpte_insert(unsigned lon
 	unsigned long pa, unsigned long rflags, unsigned long vflags, int psize)
 {
 	unsigned long slot;
-	hpte_t lhpte;
+	struct hash_pte lhpte;
 	int secondary = 0;
 	unsigned long result;
 	unsigned long bitmap;
@@ -255,7 +255,7 @@ void __init ps3_hpte_init(unsigned long 
 
 	ppc64_pft_size = __ilog2(htab_size);
 
-	bitmap_size = htab_size / sizeof(hpte_t) / 8;
+	bitmap_size = htab_size / sizeof(struct hash_pte) / 8;
 
 	bolttab = __va(lmb_alloc(bitmap_size, 1));
 	inusetab = __va(lmb_alloc(bitmap_size, 1));
@@ -273,8 +273,8 @@ void __init ps3_map_htab(void)
 
 	result = lv1_map_htab(0, &htab_addr);
 
-	htab = (hpte_t *)__ioremap(htab_addr, htab_size,
-				   pgprot_val(PAGE_READONLY_X));
+	htab = (struct hash_pte *)__ioremap(htab_addr, htab_size,
+					    pgprot_val(PAGE_READONLY_X));
 
 	DBG("%s:%d: lpar %016lxh, virt %016lxh\n", __func__, __LINE__,
 		htab_addr, (unsigned long)htab);

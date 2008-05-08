Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <a584aeae7fe189fd7cadab2de1dfdbaad64290ba.1210220828.git.michael@ellerman.id.au>
In-Reply-To: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
References: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 02/12] Fix sparse warnings in arch/powerpc/mm
Date: Thu,  8 May 2008 14:27:07 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make two vmemmap helpers static in init_64.c.
Make stab variables static in stab.c
Make psize defs static in hash_utils_64.c

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/hash_utils_64.c |    4 ++--
 arch/powerpc/mm/init_64.c       |    4 ++--
 arch/powerpc/mm/stab.c          |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 2b5a399..1a4b4b3 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -117,7 +117,7 @@ static DEFINE_SPINLOCK(linear_map_hash_lock);
 
 /* Pre-POWER4 CPUs (4k pages only)
  */
-struct mmu_psize_def mmu_psize_defaults_old[] = {
+static struct mmu_psize_def mmu_psize_defaults_old[] = {
 	[MMU_PAGE_4K] = {
 		.shift	= 12,
 		.sllp	= 0,
@@ -131,7 +131,7 @@ struct mmu_psize_def mmu_psize_defaults_old[] = {
  *
  * Support for 16Mb large pages
  */
-struct mmu_psize_def mmu_psize_defaults_gp[] = {
+static struct mmu_psize_def mmu_psize_defaults_gp[] = {
 	[MMU_PAGE_4K] = {
 		.shift	= 12,
 		.sllp	= 0,
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index c5ac532..1e52e97 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -183,7 +183,7 @@ void pgtable_cache_init(void)
  * do this by hand as the proffered address may not be correctly aligned.
  * Subtraction of non-aligned pointers produces undefined results.
  */
-unsigned long __meminit vmemmap_section_start(unsigned long page)
+static unsigned long __meminit vmemmap_section_start(unsigned long page)
 {
 	unsigned long offset = page - ((unsigned long)(vmemmap));
 
@@ -196,7 +196,7 @@ unsigned long __meminit vmemmap_section_start(unsigned long page)
  * which overlaps this vmemmap page is initialised then this page is
  * initialised already.
  */
-int __meminit vmemmap_populated(unsigned long start, int page_size)
+static int __meminit vmemmap_populated(unsigned long start, int page_size)
 {
 	unsigned long end = start + page_size;
 
diff --git a/arch/powerpc/mm/stab.c b/arch/powerpc/mm/stab.c
index efbbd13..60e6032 100644
--- a/arch/powerpc/mm/stab.c
+++ b/arch/powerpc/mm/stab.c
@@ -30,8 +30,8 @@ struct stab_entry {
 };
 
 #define NR_STAB_CACHE_ENTRIES 8
-DEFINE_PER_CPU(long, stab_cache_ptr);
-DEFINE_PER_CPU(long, stab_cache[NR_STAB_CACHE_ENTRIES]);
+static DEFINE_PER_CPU(long, stab_cache_ptr);
+static DEFINE_PER_CPU(long, stab_cache[NR_STAB_CACHE_ENTRIES]);
 
 /*
  * Create a segment table entry for the given esid/vsid pair.
-- 
1.5.5

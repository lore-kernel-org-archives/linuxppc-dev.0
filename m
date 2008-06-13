Return-Path: <bgill@monty.am.freescale.net>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79812DDF8E
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 09:48:09 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m5DNm3Bt027554
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 16:48:03 -0700 (MST)
Received: from monty.am.freescale.net (monty.am.freescale.net [10.82.19.26])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5DNm2gT013068
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 18:48:02 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: Change BAT code to use phys_addr_t
Date: Fri, 13 Jun 2008 18:41:42 -0500
Message-Id: <1213400503-22839-1-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, the physical address is an unsigned long, but it should
be phys_addr_t in set_bat, [v/p]_mapped_by_bat.  Also, create a
macro that can convert a large physical address into the correct
format for programming the BAT registers.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/mm/mmu_decl.h       |    2 +-
 arch/powerpc/mm/pgtable_32.c     |    6 +++---
 arch/powerpc/mm/ppc_mmu_32.c     |   10 +++++-----
 include/asm-powerpc/mmu-hash32.h |    9 +++++++++
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 0480225..46585b7 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -29,7 +29,7 @@ extern void hash_preload(struct mm_struct *mm, unsigned long ea,
 #ifdef CONFIG_PPC32
 extern void mapin_ram(void);
 extern int map_page(unsigned long va, phys_addr_t pa, int flags);
-extern void setbat(int index, unsigned long virt, unsigned long phys,
+extern void setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, int flags);
 extern void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 		      unsigned int size, int flags, unsigned int pid);
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index e0ff59f..c758407 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -53,9 +53,9 @@ extern void hash_page_sync(void);
 #endif
 
 #ifdef HAVE_BATS
-extern unsigned long v_mapped_by_bats(unsigned long va);
-extern unsigned long p_mapped_by_bats(unsigned long pa);
-void setbat(int index, unsigned long virt, unsigned long phys,
+extern phys_addr_t v_mapped_by_bats(unsigned long va);
+extern unsigned long p_mapped_by_bats(phys_addr_t pa);
+void setbat(int index, unsigned long virt, phys_addr_t phys,
 	    unsigned int size, int flags);
 
 #else /* !HAVE_BATS */
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index cef9f15..55ec17e 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -46,13 +46,13 @@ union ubat {			/* BAT register values to be loaded */
 struct batrange {		/* stores address ranges mapped by BATs */
 	unsigned long start;
 	unsigned long limit;
-	unsigned long phys;
+	phys_addr_t phys;
 } bat_addrs[8];
 
 /*
  * Return PA for this VA if it is mapped by a BAT, or 0
  */
-unsigned long v_mapped_by_bats(unsigned long va)
+phys_addr_t v_mapped_by_bats(unsigned long va)
 {
 	int b;
 	for (b = 0; b < 4; ++b)
@@ -64,7 +64,7 @@ unsigned long v_mapped_by_bats(unsigned long va)
 /*
  * Return VA for a given PA or 0 if not mapped
  */
-unsigned long p_mapped_by_bats(unsigned long pa)
+unsigned long p_mapped_by_bats(phys_addr_t pa)
 {
 	int b;
 	for (b = 0; b < 4; ++b)
@@ -119,7 +119,7 @@ unsigned long __init mmu_mapin_ram(void)
  * The parameters are not checked; in particular size must be a power
  * of 2 between 128k and 256M.
  */
-void __init setbat(int index, unsigned long virt, unsigned long phys,
+void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, int flags)
 {
 	unsigned int bl;
@@ -138,7 +138,7 @@ void __init setbat(int index, unsigned long virt, unsigned long phys,
 				   | _PAGE_COHERENT | _PAGE_GUARDED);
 		wimgxpp |= (flags & _PAGE_RW)? BPP_RW: BPP_RX;
 		bat[1].word[0] = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
-		bat[1].word[1] = phys | wimgxpp;
+		bat[1].word[1] = BAT_PHYS_ADDR(phys) | wimgxpp;
 #ifndef CONFIG_KGDB /* want user access for breakpoints */
 		if (flags & _PAGE_USER)
 #endif
diff --git a/include/asm-powerpc/mmu-hash32.h b/include/asm-powerpc/mmu-hash32.h
index 6e21ca6..f39ff98 100644
--- a/include/asm-powerpc/mmu-hash32.h
+++ b/include/asm-powerpc/mmu-hash32.h
@@ -28,6 +28,15 @@
 #define BPP_RW	0x02		/* Read/write */
 
 #ifndef __ASSEMBLY__
+/* Contort a phys_addr_t into the right format/bits for a BAT */
+#ifdef CONFIG_PHYS_64BIT
+#define BAT_PHYS_ADDR(x) ((u32)((x & 0x00000000fffe0000ULL) | \
+				((x & 0x0000000e00000000ULL) >> 24) | \
+				((x & 0x0000000100000000ULL) >> 30)))
+#else
+#define BAT_PHYS_ADDR(x) (x)
+#endif
+
 struct ppc_bat {
 	struct {
 		unsigned long bepi:15;	/* Effective page index (virtual address) */
-- 
1.5.4.1

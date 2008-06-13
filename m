Return-Path: <bgill@monty.am.freescale.net>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EFED8DDF86
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 09:48:10 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m5DNm35w010781
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 16:48:04 -0700 (MST)
Received: from monty.am.freescale.net (monty.am.freescale.net [10.82.19.26])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m5DNm3aw013074
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 18:48:03 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Get rid of bitfields in ppc_bat struct
Date: Fri, 13 Jun 2008 18:41:43 -0500
Message-Id: <1213400503-22839-2-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While working on the 36-bit physical support, I noticed that there
was exactly one line of code that actually referenced the bitfields.
So I got rid of them and redefined ppc_bat as a struct of 2 u32's:
batu and batl.  I also got rid of the previous union that held the
bitfield structs and a word representation of the batu/l values.

This seems like a nicer solution than adding in a bunch of
new bitfields to support extended bat addressing that would never
get used, and just leaving the struct as-is would have been
incomplete in the face of large physical addressing.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/mm/ppc_mmu_32.c     |   19 ++++++++-----------
 include/asm-powerpc/mmu-hash32.h |   19 ++-----------------
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 55ec17e..c53145f 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -38,10 +38,7 @@ struct hash_pte *Hash, *Hash_end;
 unsigned long Hash_size, Hash_mask;
 unsigned long _SDR1;
 
-union ubat {			/* BAT register values to be loaded */
-	struct ppc_bat bat;
-	u32	word[2];
-} BATS[8][2];			/* 8 pairs of IBAT, DBAT */
+struct ppc_bat BATS[8][2];	/* 8 pairs of IBAT, DBAT */
 
 struct batrange {		/* stores address ranges mapped by BATs */
 	unsigned long start;
@@ -124,7 +121,7 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 {
 	unsigned int bl;
 	int wimgxpp;
-	union ubat *bat = BATS[index];
+	struct ppc_bat *bat = BATS[index];
 
 	if (((flags & _PAGE_NO_CACHE) == 0) &&
 	    cpu_has_feature(CPU_FTR_NEED_COHERENT))
@@ -137,15 +134,15 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 		wimgxpp = flags & (_PAGE_WRITETHRU | _PAGE_NO_CACHE
 				   | _PAGE_COHERENT | _PAGE_GUARDED);
 		wimgxpp |= (flags & _PAGE_RW)? BPP_RW: BPP_RX;
-		bat[1].word[0] = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
-		bat[1].word[1] = BAT_PHYS_ADDR(phys) | wimgxpp;
+		bat[1].batu = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
+		bat[1].batl = BAT_PHYS_ADDR(phys) | wimgxpp;
 #ifndef CONFIG_KGDB /* want user access for breakpoints */
 		if (flags & _PAGE_USER)
 #endif
-			bat[1].bat.batu.vp = 1;
+			bat[1].batu |= 1; 	/* Vp = 1 */
 		if (flags & _PAGE_GUARDED) {
 			/* G bit must be zero in IBATs */
-			bat[0].word[0] = bat[0].word[1] = 0;
+			bat[0].batu = bat[0].batl = 0;
 		} else {
 			/* make IBAT same as DBAT */
 			bat[0] = bat[1];
@@ -158,8 +155,8 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 				   | _PAGE_COHERENT);
 		wimgxpp |= (flags & _PAGE_RW)?
 			((flags & _PAGE_USER)? PP_RWRW: PP_RWXX): PP_RXRX;
-		bat->word[0] = virt | wimgxpp | 4;	/* Ks=0, Ku=1 */
-		bat->word[1] = phys | bl | 0x40;	/* V=1 */
+		bat->batu = virt | wimgxpp | 4;	/* Ks=0, Ku=1 */
+		bat->batl = phys | bl | 0x40;	/* V=1 */
 	}
 
 	bat_addrs[index].start = virt;
diff --git a/include/asm-powerpc/mmu-hash32.h b/include/asm-powerpc/mmu-hash32.h
index f39ff98..16b1a1e 100644
--- a/include/asm-powerpc/mmu-hash32.h
+++ b/include/asm-powerpc/mmu-hash32.h
@@ -38,23 +38,8 @@
 #endif
 
 struct ppc_bat {
-	struct {
-		unsigned long bepi:15;	/* Effective page index (virtual address) */
-		unsigned long :4;	/* Unused */
-		unsigned long bl:11;	/* Block size mask */
-		unsigned long vs:1;	/* Supervisor valid */
-		unsigned long vp:1;	/* User valid */
-	} batu; 		/* Upper register */
-	struct {
-		unsigned long brpn:15;	/* Real page index (physical address) */
-		unsigned long :10;	/* Unused */
-		unsigned long w:1;	/* Write-thru cache */
-		unsigned long i:1;	/* Cache inhibit */
-		unsigned long m:1;	/* Memory coherence */
-		unsigned long g:1;	/* Guarded (MBZ in IBAT) */
-		unsigned long :1;	/* Unused */
-		unsigned long pp:2;	/* Page access protections */
-	} batl;			/* Lower register */
+	u32 batu;
+	u32 batl;
 };
 #endif /* !__ASSEMBLY__ */
 
-- 
1.5.4.1

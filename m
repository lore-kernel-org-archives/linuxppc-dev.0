Return-Path: <rupert@ces.ch>
Received: from server1.serv-net.de (31.204.203.213.rev.inetbone.net
	[213.203.204.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15FBB6864D
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2005 23:02:27 +1000 (EST)
From: Rupert Eibauer <rupert@ces.ch>
To: linuxppc-dev@ozlabs.org
Date: Fri, 21 Oct 2005 14:17:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200510211417.49651.rupert@ces.ch>
Cc: rupert@ces.ch
Subject: [PATCH][RFT] Make PPC7450Features useable
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Please CC to me, I am not subscribed)

Hello,

This patch makes 3 of the 7450 features useable. These are:

- High BAT (BATs 4-7)
- Extended BAT Block Size (In this mode a BAT can cover
  up to 4GB)
- 36-Bit Physical addressing with BATs

I was able to test the High BAT and the 36-Bit addressing on a
7447A, for the large BAT, I don't have enough memory. Maybe somebody
with at least 512 MB of memory should test it.

I don't have much experience in submitting, kernel patches, so
if there is anything wrong with my patch, please point it out.

However, I did not manage to adjust the page tables to do the
same trick (36-Bit Addressing). The page tables seem a lot more
magic to me.

Here is the patch:

diff -urN linux-2.6.13.3.orig/arch/ppc/Kconfig linux-2.6.13.3/arch/ppc/Kconfig
--- linux-2.6.13.3.orig/arch/ppc/Kconfig	Fri Oct 21 05:42:59 2005
+++ linux-2.6.13.3/arch/ppc/Kconfig	Fri Oct 21 05:53:49 2005
@@ -115,14 +115,28 @@
 	default y if E500 && PHYS_64BIT
 
 config PHYS_64BIT
-	bool 'Large physical address support' if E500
-	depends on 44x || E500
+	bool 'Large physical address support' if E500 || 6xx
+	depends on 44x || E500 || 6xx
 	default y if 44x
 	---help---
 	  This option enables kernel support for larger than 32-bit physical
 	  addresses.  This features is not be available on all e500 cores.
 
 	  If in doubt, say N here.
+
+config PPC_LARGE_BATS
+	bool 'Extended BAT Block Bize Support' if 6xx
+	depends on 6xx
+	---help---
+	 This option enables kernel support for large BAT
+	 addressing mode, which is present on some 7450 chips.
+
+config PPC_HIGH_BATS
+	bool 'High BAT Support' if 6xx
+	depends on 6xx
+	---help---
+	 This option enables kernel support for the 4 additional
+	 BATS, which is present on some 7450 chips.
 
 config ALTIVEC
 	bool "AltiVec Support"
diff -urN linux-2.6.13.3.orig/arch/ppc/kernel/cpu_setup_6xx.S linux-2.6.13.3/arch/ppc/kernel/cpu_setup_6xx.S
--- linux-2.6.13.3.orig/arch/ppc/kernel/cpu_setup_6xx.S	Fri Oct 21 05:49:53 2005
+++ linux-2.6.13.3/arch/ppc/kernel/cpu_setup_6xx.S	Fri Oct 21 05:53:49 2005
@@ -229,13 +229,19 @@
 	 */
 	ori	r11,r11,HID0_SGE | HID0_FOLD | HID0_BHTE
 	ori	r11,r11,HID0_LRSTK | HID0_BTIC
-	oris	r11,r11,HID0_DPM@h
+	oris	r11,r11,HID0_DPM@h | HID0_XAEN@h
 BEGIN_FTR_SECTION
 	xori	r11,r11,HID0_BTIC
 END_FTR_SECTION_IFSET(CPU_FTR_NO_BTIC)
 BEGIN_FTR_SECTION
 	xoris	r11,r11,HID0_DPM@h	/* disable dynamic power mgmt */
 END_FTR_SECTION_IFSET(CPU_FTR_NO_DPM)
+BEGIN_FTR_SECTION
+	xoris	r11,r11,HID0_XAEN@h
+END_FTR_SECTION_IFCLR(CPU_FTR_BIG_PHYS)
+BEGIN_FTR_SECTION
+	ori	r11,r11,HID0_XBSEN
+END_FTR_SECTION_IFSET(CPU_FTR_LARGE_BATS)
 
 	/* All of the bits we have to clear....
 	 */
diff -urN linux-2.6.13.3.orig/arch/ppc/kernel/cputable.c linux-2.6.13.3/arch/ppc/kernel/cputable.c
--- linux-2.6.13.3.orig/arch/ppc/kernel/cputable.c	Fri Oct 21 05:49:53 2005
+++ linux-2.6.13.3/arch/ppc/kernel/cputable.c	Fri Oct 21 05:53:49 2005
@@ -62,6 +62,18 @@
 #define PPC_FEATURE_SPE_COMP       	0
 #endif
 
+#ifdef CONFIG_PPC_LARGE_BATS
+#define CPU_FTR_LARGE_BATS_COMP		CPU_FTR_LARGE_BATS
+#else
+#define CPU_FTR_LARGE_BATS_COMP		0
+#endif
+
+#ifndef CONFIG_PHYS_64BIT
+#define CPU_FTR_BIG_PHYS_COMP		CPU_FTR_BIG_PHYS
+#else
+#define CPU_FTR_BIG_PHYS_COMP		0
+#endif
+
 /* We need to mark all pages as being coherent if we're SMP or we
  * have a 74[45]x and an MPC107 host bridge.
  */
@@ -428,6 +440,7 @@
 			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 			CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_BIG_PHYS_COMP | CPU_FTR_LARGE_BATS_COMP |
 			CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
@@ -445,6 +458,7 @@
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP |
+			CPU_FTR_BIG_PHYS_COMP | CPU_FTR_LARGE_BATS_COMP |
 			CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
@@ -462,6 +476,7 @@
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
+			CPU_FTR_BIG_PHYS_COMP | CPU_FTR_LARGE_BATS_COMP |
 			CPU_FTR_NEED_COHERENT,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
@@ -478,6 +493,7 @@
 			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_BIG_PHYS_COMP | CPU_FTR_LARGE_BATS_COMP |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
 			CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
@@ -496,6 +512,7 @@
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
+			CPU_FTR_BIG_PHYS_COMP | CPU_FTR_LARGE_BATS_COMP |
 			CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
@@ -513,6 +530,7 @@
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
+			CPU_FTR_BIG_PHYS_COMP | CPU_FTR_LARGE_BATS_COMP |
 			CPU_FTR_NEED_COHERENT,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
@@ -529,6 +547,7 @@
 			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
 			CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+			CPU_FTR_BIG_PHYS_COMP | CPU_FTR_LARGE_BATS_COMP |
 			CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
diff -urN linux-2.6.13.3.orig/arch/ppc/kernel/head.S linux-2.6.13.3/arch/ppc/kernel/head.S
--- linux-2.6.13.3.orig/arch/ppc/kernel/head.S	Fri Oct 21 05:49:53 2005
+++ linux-2.6.13.3/arch/ppc/kernel/head.S	Fri Oct 21 05:53:49 2005
@@ -1165,6 +1165,14 @@
 	LOAD_BAT(1,r3,r4,r5)
 	LOAD_BAT(2,r3,r4,r5)
 	LOAD_BAT(3,r3,r4,r5)
+#ifdef CONFIG_PPC_HIGH_BATS
+BEGIN_FTR_SECTION
+	LOAD_BAT(4,r3,r4,r5)
+	LOAD_BAT(5,r3,r4,r5)
+	LOAD_BAT(6,r3,r4,r5)
+	LOAD_BAT(7,r3,r4,r5)
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
+#endif /* CONFIG_PPC_HIGH_BATS */
 #endif /* CONFIG_POWER4 */
 	blr
 
diff -urN linux-2.6.13.3.orig/arch/ppc/mm/pgtable.c linux-2.6.13.3/arch/ppc/mm/pgtable.c
--- linux-2.6.13.3.orig/arch/ppc/mm/pgtable.c	Fri Oct 21 05:49:53 2005
+++ linux-2.6.13.3/arch/ppc/mm/pgtable.c	Fri Oct 21 05:53:49 2005
@@ -55,8 +55,8 @@
 
 #ifdef HAVE_BATS
 extern unsigned long v_mapped_by_bats(unsigned long va);
-extern unsigned long p_mapped_by_bats(unsigned long pa);
-void setbat(int index, unsigned long virt, unsigned long phys,
+extern unsigned long p_mapped_by_bats(phys_addr_t pa);
+void setbat(int index, unsigned long virt, phys_addr_t phys,
 	    unsigned int size, int flags);
 
 #else /* !HAVE_BATS */
@@ -339,7 +339,7 @@
 	/*
 	 * Use a BAT for this if possible...
 	 */
-	if (io_bat_index < 2 && is_power_of_2(size)
+	if (io_bat_index < (ppc_bat_count() - 2) && is_power_of_2(size)
 	    && (virt & (size - 1)) == 0 && (phys & (size - 1)) == 0) {
 		setbat(io_bat_index, virt, phys, size, flags);
 		++io_bat_index;
diff -urN linux-2.6.13.3.orig/arch/ppc/mm/ppc_mmu.c linux-2.6.13.3/arch/ppc/mm/ppc_mmu.c
--- linux-2.6.13.3.orig/arch/ppc/mm/ppc_mmu.c	Fri Oct 21 05:49:53 2005
+++ linux-2.6.13.3/arch/ppc/mm/ppc_mmu.c	Fri Oct 21 05:53:49 2005
@@ -36,6 +36,7 @@
 #include "mmu_decl.h"
 #include "mem_pieces.h"
 
+
 PTE *Hash, *Hash_end;
 unsigned long Hash_size, Hash_mask;
 unsigned long _SDR1;
@@ -47,13 +48,13 @@
 #else
 	u32	word[2];
 #endif
-} BATS[4][2];			/* 4 pairs of IBAT, DBAT */
+} BATS[PPC_BAT_COUNT][2];			/* 4 pairs of IBAT, DBAT */
 
 struct batrange {		/* stores address ranges mapped by BATs */
 	unsigned long start;
 	unsigned long limit;
-	unsigned long phys;
-} bat_addrs[4];
+	phys_addr_t phys;
+} bat_addrs[PPC_BAT_COUNT];
 
 /*
  * Return PA for this VA if it is mapped by a BAT, or 0
@@ -61,7 +62,7 @@
 unsigned long v_mapped_by_bats(unsigned long va)
 {
 	int b;
-	for (b = 0; b < 4; ++b)
+	for (b = 0; b < PPC_BAT_COUNT; ++b)
 		if (va >= bat_addrs[b].start && va < bat_addrs[b].limit)
 			return bat_addrs[b].phys + (va - bat_addrs[b].start);
 	return 0;
@@ -70,10 +71,10 @@
 /*
  * Return VA for a given PA or 0 if not mapped
  */
-unsigned long p_mapped_by_bats(unsigned long pa)
+unsigned long p_mapped_by_bats(phys_addr_t pa)
 {
 	int b;
-	for (b = 0; b < 4; ++b)
+	for (b = 0; b < PPC_BAT_COUNT; ++b)
 		if (pa >= bat_addrs[b].phys
 	    	    && pa < (bat_addrs[b].limit-bat_addrs[b].start)
 		              +bat_addrs[b].phys)
@@ -87,13 +88,14 @@
 	return 0;
 #else
 	unsigned long tot, bl, done;
-	unsigned long max_size = (256<<20);
+	unsigned long max_size = max_bat_size();
 	unsigned long align;
+	int bat_nbr = ppc_bat_count() - 2;
 
 	if (__map_without_bats)
 		return 0;
 
-	/* Set up BAT2 and if necessary BAT3 to cover RAM. */
+	/* Set up BAT[2|6] and if necessary BAT[3|7] to cover RAM. */
 
 	/* Make sure we don't map a block larger than the
 	   smallest alignment of the physical address. */
@@ -109,16 +111,17 @@
 			break;
 	}
 
-	setbat(2, KERNELBASE, PPC_MEMSTART, bl, _PAGE_RAM);
-	done = (unsigned long)bat_addrs[2].limit - KERNELBASE + 1;
-	if ((done < tot) && !bat_addrs[3].limit) {
-		/* use BAT3 to cover a bit more */
+	setbat(bat_nbr, KERNELBASE, PPC_MEMSTART, bl, _PAGE_RAM);
+	done = (unsigned long)bat_addrs[bat_nbr].limit - KERNELBASE + 1;
+	bat_nbr++;
+	if ((done < tot) && !bat_addrs[bat_nbr].limit) {
+		/* use BAT[3|7] to cover a bit more */
 		tot -= done;
 		for (bl = 128<<10; bl < max_size; bl <<= 1)
 			if (bl * 2 > tot)
 				break;
-		setbat(3, KERNELBASE+done, PPC_MEMSTART+done, bl, _PAGE_RAM);
-		done = (unsigned long)bat_addrs[3].limit - KERNELBASE + 1;
+		setbat(bat_nbr, KERNELBASE+done, PPC_MEMSTART+done, bl, _PAGE_RAM);
+		done = (unsigned long)bat_addrs[bat_nbr].limit - KERNELBASE + 1;
 	}
 
 	return done;
@@ -130,7 +133,7 @@
  * The parameters are not checked; in particular size must be a power
  * of 2 between 128k and 256M.
  */
-void __init setbat(int index, unsigned long virt, unsigned long phys,
+void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, int flags)
 {
 	unsigned int bl;
@@ -148,6 +151,9 @@
 		wimgxpp = flags & (_PAGE_WRITETHRU | _PAGE_NO_CACHE
 				   | _PAGE_COHERENT | _PAGE_GUARDED);
 		wimgxpp |= (flags & _PAGE_RW)? BPP_RW: BPP_RX;
+#ifdef CONFIG_PHYS_64BIT
+		wimgxpp |= ((phys >> 30) & 4) | ((phys >> 24) & 0xe00);
+#endif
 		bat[1].word[0] = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
 		bat[1].word[1] = phys | wimgxpp;
 #ifndef CONFIG_KGDB /* want user access for breakpoints */
diff -urN linux-2.6.13.3.orig/include/asm-ppc/cputable.h linux-2.6.13.3/include/asm-ppc/cputable.h
--- linux-2.6.13.3.orig/include/asm-ppc/cputable.h	Thu Jun 30 01:00:53 2005
+++ linux-2.6.13.3/include/asm-ppc/cputable.h	Fri Oct 21 05:53:49 2005
@@ -89,6 +89,7 @@
 #define CPU_FTR_NEED_COHERENT		0x00020000
 #define CPU_FTR_NO_BTIC			0x00040000
 #define CPU_FTR_BIG_PHYS		0x00080000
+#define CPU_FTR_LARGE_BATS		0x00100000
 
 #ifdef __ASSEMBLY__
 
diff -urN linux-2.6.13.3.orig/include/asm-ppc/mmu.h linux-2.6.13.3/include/asm-ppc/mmu.h
--- linux-2.6.13.3.orig/include/asm-ppc/mmu.h	Fri Oct 21 05:44:49 2005
+++ linux-2.6.13.3/include/asm-ppc/mmu.h	Fri Oct 21 05:53:49 2005
@@ -18,11 +18,30 @@
 #ifndef CONFIG_PHYS_64BIT
 typedef unsigned long phys_addr_t;
 #define PHYS_FMT	"%.8lx"
+#define cpu_has_bigphys() 0
 #else
 typedef unsigned long long phys_addr_t;
 extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);
 #define PHYS_FMT	"%16Lx"
+#define cpu_has_bigphys() cpu_has_feature(CPU_FTR_BIG_PHYS)
 #endif
+
+#ifdef CONFIG_PPC_LARGE_BATS
+/* We don't allow 4G Bat's because it doesn't fit into size_t */
+#define max_bat_size() (cpu_has_feature(CPU_FTR_LARGE_BATS)?(2<<30):(256<<20))
+#else
+#define max_bat_size() (256<<20)
+#endif
+
+/* High BAT support */
+#ifdef CONFIG_PPC_HIGH_BATS
+#define PPC_BAT_COUNT 8
+#define ppc_bat_count() (cpu_has_feature(CPU_FTR_HAS_HIGH_BATS)?8:4)
+#else
+#define PPC_BAT_COUNT 4
+#define ppc_bat_count() (4)
+#endif
+
 
 /* Default "unsigned long" context */
 typedef unsigned long mm_context_t;

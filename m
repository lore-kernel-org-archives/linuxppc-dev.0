Return-Path: <rupert@ces.ch>
Received: from server1.serv-net.de (unknown [213.203.204.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C138E685B3
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2005 23:38:42 +1000 (EST)
From: Rupert Eibauer <rupert@ces.ch>
To: Kumar Gala <kumar.gala@freescale.com>
Date: Sat, 22 Oct 2005 15:54:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200510221554.03810.rupert@ces.ch>
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH][RFT] Extended BAT features, take 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

Here is the updated patch. Please test.

What this patch actually does:
- Make CONFIG_PHYS_64BIT selectable for the 6xx family
- Make the BATs use 36-Bit addressing and use large BATs
  when available on the processor.
- Make use of the 4 additional BATs on some processors.

Changes to the old patch:
- Removed all additional configuration options
- Merged LARGE_BATS with PHYS_64BIT because there seems to be no processor 
  supporting only one of these features (I am not sure about the e500v2, 
  but maybe somebody else is sure)

Rupert

diff -urN linux-2.6.13.3.orig/arch/ppc/Kconfig linux-2.6.13.3/arch/ppc/Kconfig
--- linux-2.6.13.3.orig/arch/ppc/Kconfig	Fri Oct 21 05:42:59 2005
+++ linux-2.6.13.3/arch/ppc/Kconfig	Fri Oct 21 21:05:09 2005
@@ -115,8 +115,8 @@
 	default y if E500 && PHYS_64BIT
 
 config PHYS_64BIT
-	bool 'Large physical address support' if E500
-	depends on 44x || E500
+	bool 'Large physical address support' if E500 || 6xx
+	depends on 44x || E500 || 6xx
 	default y if 44x
 	---help---
 	  This option enables kernel support for larger than 32-bit physical
diff -urN linux-2.6.13.3.orig/arch/ppc/kernel/cpu_setup_6xx.S linux-2.6.13.3/arch/ppc/kernel/cpu_setup_6xx.S
--- linux-2.6.13.3.orig/arch/ppc/kernel/cpu_setup_6xx.S	Fri Oct 21 05:49:53 2005
+++ linux-2.6.13.3/arch/ppc/kernel/cpu_setup_6xx.S	Fri Oct 21 21:07:06 2005
@@ -228,14 +228,18 @@
 	/* All of the bits we have to set.....
 	 */
 	ori	r11,r11,HID0_SGE | HID0_FOLD | HID0_BHTE
-	ori	r11,r11,HID0_LRSTK | HID0_BTIC
-	oris	r11,r11,HID0_DPM@h
+	ori	r11,r11,HID0_LRSTK | HID0_BTIC | HID0_XBSEN
+	oris	r11,r11,(HID0_DPM | HID0_XAEN)@h
 BEGIN_FTR_SECTION
 	xori	r11,r11,HID0_BTIC
 END_FTR_SECTION_IFSET(CPU_FTR_NO_BTIC)
 BEGIN_FTR_SECTION
 	xoris	r11,r11,HID0_DPM@h	/* disable dynamic power mgmt */
 END_FTR_SECTION_IFSET(CPU_FTR_NO_DPM)
+BEGIN_FTR_SECTION
+	xori	r11,r11,HID0_XBSEN
+	xoris	r11,r11,HID0_XAEN@h
+END_FTR_SECTION_IFCLR(CPU_FTR_BIG_PHYS)
 
 	/* All of the bits we have to clear....
 	 */
diff -urN linux-2.6.13.3.orig/arch/ppc/kernel/cputable.c linux-2.6.13.3/arch/ppc/kernel/cputable.c
--- linux-2.6.13.3.orig/arch/ppc/kernel/cputable.c	Fri Oct 21 05:49:53 2005
+++ linux-2.6.13.3/arch/ppc/kernel/cputable.c	Fri Oct 21 21:11:55 2005
@@ -62,6 +62,12 @@
 #define PPC_FEATURE_SPE_COMP       	0
 #endif
 
+#ifndef CONFIG_PHYS_64BIT
+#define CPU_FTR_BIG_PHYS_COMP		CPU_FTR_BIG_PHYS
+#else
+#define CPU_FTR_BIG_PHYS_COMP		0
+#endif
+
 /* We need to mark all pages as being coherent if we're SMP or we
  * have a 74[45]x and an MPC107 host bridge.
  */
@@ -428,6 +434,7 @@
 			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 			CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_BIG_PHYS_COMP |
 			CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
@@ -445,6 +452,7 @@
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP |
+			CPU_FTR_BIG_PHYS_COMP |
 			CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
@@ -462,6 +470,7 @@
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
+			CPU_FTR_BIG_PHYS_COMP |
 			CPU_FTR_NEED_COHERENT,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
@@ -478,6 +487,7 @@
 			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
+			CPU_FTR_BIG_PHYS_COMP |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
 			CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
@@ -496,6 +506,7 @@
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
+			CPU_FTR_BIG_PHYS_COMP |
 			CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
@@ -513,6 +524,7 @@
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
+			CPU_FTR_BIG_PHYS_COMP |
 			CPU_FTR_NEED_COHERENT,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
@@ -529,6 +541,7 @@
 			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
 			CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
+			CPU_FTR_BIG_PHYS_COMP |
 			CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
diff -urN linux-2.6.13.3.orig/arch/ppc/kernel/head.S linux-2.6.13.3/arch/ppc/kernel/head.S
--- linux-2.6.13.3.orig/arch/ppc/kernel/head.S	Fri Oct 21 05:49:53 2005
+++ linux-2.6.13.3/arch/ppc/kernel/head.S	Fri Oct 21 21:12:17 2005
@@ -1165,6 +1165,12 @@
 	LOAD_BAT(1,r3,r4,r5)
 	LOAD_BAT(2,r3,r4,r5)
 	LOAD_BAT(3,r3,r4,r5)
+BEGIN_FTR_SECTION
+	LOAD_BAT(4,r3,r4,r5)
+	LOAD_BAT(5,r3,r4,r5)
+	LOAD_BAT(6,r3,r4,r5)
+	LOAD_BAT(7,r3,r4,r5)
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
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
+++ linux-2.6.13.3/arch/ppc/mm/ppc_mmu.c	Fri Oct 21 21:15:07 2005
@@ -47,13 +47,13 @@
 #else
 	u32	word[2];
 #endif
-} BATS[4][2];			/* 4 pairs of IBAT, DBAT */
+} BATS[8][2];			/* 8 pairs of IBAT, DBAT */
 
 struct batrange {		/* stores address ranges mapped by BATs */
 	unsigned long start;
 	unsigned long limit;
-	unsigned long phys;
-} bat_addrs[4];
+	phys_addr_t phys;
+} bat_addrs[8];
 
 /*
  * Return PA for this VA if it is mapped by a BAT, or 0
@@ -70,7 +70,7 @@
 /*
  * Return VA for a given PA or 0 if not mapped
  */
-unsigned long p_mapped_by_bats(unsigned long pa)
+unsigned long p_mapped_by_bats(phys_addr_t pa)
 {
 	int b;
 	for (b = 0; b < 4; ++b)
@@ -87,13 +87,14 @@
 	return 0;
 #else
 	unsigned long tot, bl, done;
-	unsigned long max_size = (256<<20);
+	unsigned long max_size = ppc_max_bat_size();
 	unsigned long align;
+	int bat_nbr = ppc_bat_count() - 2;
 
 	if (__map_without_bats)
 		return 0;
 
-	/* Set up BAT2 and if necessary BAT3 to cover RAM. */
+	/* Set up BAT[2|6] and if necessary BAT[3|7] to cover RAM. */
 
 	/* Make sure we don't map a block larger than the
 	   smallest alignment of the physical address. */
@@ -109,16 +110,17 @@
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
@@ -130,7 +132,7 @@
  * The parameters are not checked; in particular size must be a power
  * of 2 between 128k and 256M.
  */
-void __init setbat(int index, unsigned long virt, unsigned long phys,
+void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, int flags)
 {
 	unsigned int bl;
@@ -148,6 +150,9 @@
 		wimgxpp = flags & (_PAGE_WRITETHRU | _PAGE_NO_CACHE
 				   | _PAGE_COHERENT | _PAGE_GUARDED);
 		wimgxpp |= (flags & _PAGE_RW)? BPP_RW: BPP_RX;
+#ifdef CONFIG_PHYS_64BIT
+		wimgxpp |= ((phys >> 30) & 4) | ((phys >> 24) & 0xe00);
+#endif
 		bat[1].word[0] = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
 		bat[1].word[1] = phys | wimgxpp;
 #ifndef CONFIG_KGDB /* want user access for breakpoints */
diff -urN linux-2.6.13.3.orig/include/asm-ppc/mmu.h linux-2.6.13.3/include/asm-ppc/mmu.h
--- linux-2.6.13.3.orig/include/asm-ppc/mmu.h	Fri Oct 21 05:44:49 2005
+++ linux-2.6.13.3/include/asm-ppc/mmu.h	Fri Oct 21 21:23:55 2005
@@ -18,11 +18,19 @@
 #ifndef CONFIG_PHYS_64BIT
 typedef unsigned long phys_addr_t;
 #define PHYS_FMT	"%.8lx"
+#define cpu_has_bigphys() 0
+#define ppc_max_bat_size() (256<<20)
 #else
 typedef unsigned long long phys_addr_t;
 extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);
 #define PHYS_FMT	"%16Lx"
+#define cpu_has_bigphys() cpu_has_feature(CPU_FTR_BIG_PHYS)
+/* We don't allow 4G Bat's because it doesn't fit into size_t */
+#define ppc_max_bat_size() \
+	(cpu_has_feature(CPU_FTR_BIG_PHYS)?(2<<30):(256<<20))
 #endif
+
+#define ppc_bat_count() (cpu_has_feature(CPU_FTR_HAS_HIGH_BATS) ? 8 : 4)
 
 /* Default "unsigned long" context */
 typedef unsigned long mm_context_t;

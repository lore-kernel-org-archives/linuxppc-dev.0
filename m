To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BAT mapping
References: <1088518106.14216.1415.camel@hades.cambridge.redhat.com>
	<wn5isdatmk8.fsf@linhd-2.ca.nortel.com>
From: "Linh Dang" <linhd@nortelnetworks.com>
Date: Tue, 29 Jun 2004 13:59:37 -0400
In-Reply-To: <wn5isdatmk8.fsf@linhd-2.ca.nortel.com> (Linh Dang's message of
 "Tue, 29 Jun 2004 11:23:51 -0400")
Message-ID: <wn53c4etfcm.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


this the hibats mapping patch. I have to manually edit out things that
are only relevant on our board.

--- 2.6.7/linux/arch/ppc/mm/pgtable.c Fri, 18 Jun 2004 13:35:07 -0400 linhd (k26/O/c/1_pgtable.c 1.1 644)
+++ local-2.6.7/arch/ppc/mm/pgtable.c Thu, 24 Jun 2004 15:24:06 -0400 linhd (k26/O/c/1_pgtable.c 1.3 644)
@@ -34,9 +34,11 @@

 #include "mmu_decl.h"

+extern int bat_map_io_succeed(unsigned long virt, phys_addr_t phys,
+                              unsigned int  size, int flags);
+
 unsigned long ioremap_base;
 unsigned long ioremap_bot;
-int io_bat_index;

 #if defined(CONFIG_6xx) || defined(CONFIG_POWER3)
 #define HAVE_BATS	1
@@ -297,9 +299,6 @@
 	}
 }

-/* is x a power of 2? */
-#define is_power_of_2(x)	((x) != 0 && (((x) & ((x) - 1)) == 0))
-
 /*
  * Set up a mapping for a block of I/O.
  * virt, phys, size must all be page-aligned.
@@ -317,13 +316,9 @@
 	/*
 	 * Use a BAT for this if possible...
 	 */
-	if (io_bat_index < 2 && is_power_of_2(size)
-	    && (virt & (size - 1)) == 0 && (phys & (size - 1)) == 0) {
-		setbat(io_bat_index, virt, phys, size, flags);
-		++io_bat_index;
+        if (bat_map_io_succeed(virt, phys, size, flags))
 		return;
-	}
 #endif /* HAVE_BATS */

 	/* No BATs available, put it in the page tables. */
--- 2.6.7/linux/arch/ppc/mm/ppc_mmu.c Fri, 18 Jun 2004 13:35:07 -0400 linhd (k26/O/c/2_ppc_mmu.c 1.1 644)
+++ local-2.6.7/arch/ppc/mm/ppc_mmu.c Tue, 29 Jun 2004 11:11:15 -0400 linhd (k26/O/c/2_ppc_mmu.c 1.3 644)
@@ -40,6 +40,17 @@
 unsigned long Hash_size, Hash_mask;
 unsigned long _SDR1;

+
+#define PPC32_MAX_BAT_PAIRS 8   /* maximum 8  dbats and 8  ibats */
+
+unsigned cpu_num_bat_pairs = 4; /* the actual number of bat pairs for
+                                 * this CPU. default to 4 for most
+                                 * ppc32  */
+
+unsigned cpu_num_ram_bats;
+
+int io_bat_index;               /* the 1st bat for I/O mapping */
+
 union ubat {			/* BAT register values to be loaded */
 	BAT	bat;
 #ifdef CONFIG_PPC64BRIDGE
@@ -47,13 +58,14 @@
 #else
 	u32	word[2];
 #endif
-} BATS[4][2];			/* 4 pairs of IBAT, DBAT */
+} BATS[PPC32_MAX_BAT_PAIRS][2];			/* 8 pairs of IBAT, DBAT */

 struct batrange {		/* stores address ranges mapped by BATs */
 	unsigned long start;
 	unsigned long limit;
 	unsigned long phys;
-} bat_addrs[4];
+} bat_addrs[PPC32_MAX_BAT_PAIRS];
+

 /*
  * Return PA for this VA if it is mapped by a BAT, or 0
@@ -61,7 +73,7 @@
 unsigned long v_mapped_by_bats(unsigned long va)
 {
 	int b;
-	for (b = 0; b < 4; ++b)
+	for (b = 0; b < cpu_num_bat_pairs; ++b)
 		if (va >= bat_addrs[b].start && va < bat_addrs[b].limit)
 			return bat_addrs[b].phys + (va - bat_addrs[b].start);
 	return 0;
@@ -73,7 +85,7 @@
 unsigned long p_mapped_by_bats(unsigned long pa)
 {
 	int b;
-	for (b = 0; b < 4; ++b)
+	for (b = 0; b < cpu_num_bat_pairs; ++b)
 		if (pa >= bat_addrs[b].phys
 	    	    && pa < (bat_addrs[b].limit-bat_addrs[b].start)
 		              +bat_addrs[b].phys)
@@ -81,14 +93,35 @@
 	return 0;
 }

+
+int
+bat_map_io_succeed(unsigned long virt, phys_addr_t phys,
+                   unsigned int size, int flags)
+{
+/* is x a power of 2? */
+#define is_power_of_2(x)	((x) != 0 && (((x) & ((x) - 1)) == 0))
+
+#if defined(CONFIG_6xx) || defined(CONFIG_POWER3)
+        if (io_bat_index < cpu_num_bat_pairs && is_power_of_2(size)
+                 && (virt & (size - 1)) == 0 && (phys & (size - 1)) == 0) {
+		setbat(io_bat_index, virt, phys, size, flags);
+		++io_bat_index;
+                return 1;
+	}
+#endif
+        return 0;
+}
+
+
 unsigned long __init mmu_mapin_ram(void)
 {
 #ifdef CONFIG_POWER4
 	return 0;
 #else
-	unsigned long tot, bl, done;
+	unsigned long tot, bl, done = 0;
 	unsigned long max_size = (256<<20);
 	unsigned long align;
+        unsigned i;

 	if (__map_without_bats)
 		return 0;
@@ -103,24 +136,29 @@
 	if (align && align < max_size)
 		max_size = align;

+        cpu_num_ram_bats = cpu_num_bat_pairs / 2;
+/*         if (cpu_num_bat_pairs > 4) */
+/*                 cpu_num_ram_bats++; */
+
+        /*
+         * cpu_num_ram_bats bats registers from bat0 will be used to
+         * map ram. the rest will be used to map I/O
+         */
+
 	tot = total_lowmem;
-	for (bl = 128<<10; bl < max_size; bl <<= 1) {
-		if (bl * 2 > tot)
-			break;
-	}

-	setbat(2, KERNELBASE, PPC_MEMSTART, bl, _PAGE_RAM);
-	done = (unsigned long)bat_addrs[2].limit - KERNELBASE + 1;
-	if ((done < tot) && !bat_addrs[3].limit) {
-		/* use BAT3 to cover a bit more */
-		tot -= done;
-		for (bl = 128<<10; bl < max_size; bl <<= 1)
-			if (bl * 2 > tot)
-				break;
-		setbat(3, KERNELBASE+done, PPC_MEMSTART+done, bl, _PAGE_RAM);
-		done = (unsigned long)bat_addrs[3].limit - KERNELBASE + 1;
+        for (i = 0, bl = 1UL << __ilog2(tot - done);
+
+             i < cpu_num_ram_bats && done < tot && bat_addrs[i].limit == 0;
+
+             i++, bl = 1UL << __ilog2(tot - done))
+        {
+                setbat(i, KERNELBASE+done, PPC_MEMSTART+done, bl, _PAGE_RAM);
+                done = (unsigned long) bat_addrs[i].limit - KERNELBASE + 1;
 	}

+        io_bat_index = i;       /* set the 1st bat used for I/O mapping */
+
 	return done;
 #endif
 }
@@ -203,7 +241,16 @@
 		return;
 	}

+        if (cur_cpu_spec[0]->cpu_features & CPU_FTR_HAS_HIGH_BATS)
+        {
+                cpu_num_bat_pairs = 8;
+                if ( ppc_md.progress ) ppc_md.progress("cpu has hi bat registers", 8);
+        }
+
+        if ( ppc_md.progress ) ppc_md.progress("num bat pairs:", cpu_num_bat_pairs);
+
+
 	if ( ppc_md.progress ) ppc_md.progress("hash:enter", 0x105);

 #ifdef CONFIG_PPC64BRIDGE
--- 2.6.7/linux/arch/ppc/kernel/head.S Fri, 18 Jun 2004 13:35:07 -0400 linhd (k26/P/c/20_head.S 1.1 644)
+++ local-2.6.7/arch/ppc/kernel/head.S Thu, 24 Jun 2004 15:25:46 -0400 linhd (k26/P/c/20_head.S 1.2 644)
@@ -1328,7 +1328,13 @@
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

--- 2.6.7/linux/arch/ppc/kernel/cpu_setup_6xx.S Fri, 18 Jun 2004 13:35:07 -0400 linhd (k26/P/c/32_cpu_setup_ 1.1 644)
+++ local-2.6.7/arch/ppc/kernel/cpu_setup_6xx.S Thu, 24 Jun 2004 09:00:55 -0400 linhd (k26/P/c/32_cpu_setup_ 1.2 644)
@@ -223,6 +223,10 @@
 	oris	r11,r11,HID0_DPM@h	/* enable dynamic power mgmt */
 END_FTR_SECTION_IFCLR(CPU_FTR_NO_DPM)

+BEGIN_FTR_SECTION
+        oris     r11,r11,HID0_HIGH_BAT@h
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
+
 	/* All of the bits we have to clear....
 	 */
 	li	r3,HID0_SPD | HID0_NOPDST | HID0_NOPTI

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <anton@ozlabs.org>
Date: Sat, 10 Jun 2006 20:32:01 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Remove stale 64bit on 32bit kernel code
Message-ID: <20060610103201.GK23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove some stale POWER3/POWER4/970 on 32bit kernel support.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/cputable.c
===================================================================
--- build.orig/arch/powerpc/kernel/cputable.c	2006-06-10 11:37:31.000000000 +1000
+++ build/arch/powerpc/kernel/cputable.c	2006-06-10 11:39:51.000000000 +1000
@@ -189,17 +189,11 @@ struct cpu_spec	cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "ppc970",
 	},
-#endif /* CONFIG_PPC64 */
-#if defined(CONFIG_PPC64) || defined(CONFIG_POWER4)
 	{	/* PPC970FX */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x003c0000,
 		.cpu_name		= "PPC970FX",
-#ifdef CONFIG_PPC32
-		.cpu_features		= CPU_FTRS_970_32,
-#else
 		.cpu_features		= CPU_FTRS_PPC970,
-#endif
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
 		.icache_bsize		= 128,
@@ -210,8 +204,6 @@ struct cpu_spec	cpu_specs[] = {
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.platform		= "ppc970",
 	},
-#endif /* defined(CONFIG_PPC64) || defined(CONFIG_POWER4) */
-#ifdef CONFIG_PPC64
 	{	/* PPC970MP */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00440000,
Index: build/include/asm-powerpc/cputable.h
===================================================================
--- build.orig/include/asm-powerpc/cputable.h	2006-06-10 11:37:33.000000000 +1000
+++ build/include/asm-powerpc/cputable.h	2006-06-10 11:39:51.000000000 +1000
@@ -300,13 +300,6 @@ extern void do_cpu_ftr_fixups(unsigned l
 	    CPU_FTR_COMMON)
 #define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE)
-#define CPU_FTRS_POWER3_32	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
-	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE)
-#define CPU_FTRS_POWER4_32	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
-	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_NODSISRALIGN)
-#define CPU_FTRS_970_32	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
-	    CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN)
 #define CPU_FTRS_8XX	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB)
 #define CPU_FTRS_40X	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_NODSISRALIGN)
@@ -367,12 +360,6 @@ enum {
 #else
 	    CPU_FTRS_GENERIC_32 |
 #endif
-#ifdef CONFIG_PPC64BRIDGE
-	    CPU_FTRS_POWER3_32 |
-#endif
-#ifdef CONFIG_POWER4
-	    CPU_FTRS_POWER4_32 | CPU_FTRS_970_32 |
-#endif
 #ifdef CONFIG_8xx
 	    CPU_FTRS_8XX |
 #endif
@@ -412,12 +399,6 @@ enum {
 #else
 	    CPU_FTRS_GENERIC_32 &
 #endif
-#ifdef CONFIG_PPC64BRIDGE
-	    CPU_FTRS_POWER3_32 &
-#endif
-#ifdef CONFIG_POWER4
-	    CPU_FTRS_POWER4_32 & CPU_FTRS_970_32 &
-#endif
 #ifdef CONFIG_8xx
 	    CPU_FTRS_8XX &
 #endif
Index: build/arch/powerpc/Makefile
===================================================================
--- build.orig/arch/powerpc/Makefile	2006-06-10 11:36:57.000000000 +1000
+++ build/arch/powerpc/Makefile	2006-06-10 11:39:51.000000000 +1000
@@ -108,7 +108,6 @@ ifeq ($(CONFIG_6xx),y)
 CFLAGS		+= -mcpu=powerpc
 endif
 
-cpu-as-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
Index: build/arch/powerpc/mm/hash_low_32.S
===================================================================
--- build.orig/arch/powerpc/mm/hash_low_32.S	2006-06-10 11:36:57.000000000 +1000
+++ build/arch/powerpc/mm/hash_low_32.S	2006-06-10 11:39:51.000000000 +1000
@@ -74,12 +74,6 @@ _GLOBAL(hash_page_sync)
  */
 	.text
 _GLOBAL(hash_page)
-#ifdef CONFIG_PPC64BRIDGE
-	mfmsr	r0
-	clrldi	r0,r0,1		/* make sure it's in 32-bit mode */
-	MTMSRD(r0)
-	isync
-#endif
 	tophys(r7,0)			/* gets -KERNELBASE into r7 */
 #ifdef CONFIG_SMP
 	addis	r8,r7,mmu_hash_lock@h
@@ -285,7 +279,6 @@ Hash_base = 0xc0180000
 Hash_bits = 12				/* e.g. 256kB hash table */
 Hash_msk = (((1 << Hash_bits) - 1) * 64)
 
-#ifndef CONFIG_PPC64BRIDGE
 /* defines for the PTE format for 32-bit PPCs */
 #define PTE_SIZE	8
 #define PTEG_SIZE	64
@@ -299,21 +292,6 @@ Hash_msk = (((1 << Hash_bits) - 1) * 64)
 #define SET_V(r)	oris r,r,PTE_V@h
 #define CLR_V(r,t)	rlwinm r,r,0,1,31
 
-#else
-/* defines for the PTE format for 64-bit PPCs */
-#define PTE_SIZE	16
-#define PTEG_SIZE	128
-#define LG_PTEG_SIZE	7
-#define LDPTEu		ldu
-#define STPTE		std
-#define CMPPTE		cmpd
-#define PTE_H		2
-#define PTE_V		1
-#define TST_V(r)	andi. r,r,PTE_V
-#define SET_V(r)	ori r,r,PTE_V
-#define CLR_V(r,t)	li t,PTE_V; andc r,r,t
-#endif /* CONFIG_PPC64BRIDGE */
-
 #define HASH_LEFT	31-(LG_PTEG_SIZE+Hash_bits-1)
 #define HASH_RIGHT	31-LG_PTEG_SIZE
 
@@ -331,14 +309,8 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_NEED_COHERENT)
 
 	/* Construct the high word of the PPC-style PTE (r5) */
-#ifndef CONFIG_PPC64BRIDGE
 	rlwinm	r5,r3,7,1,24		/* put VSID in 0x7fffff80 bits */
 	rlwimi	r5,r4,10,26,31		/* put in API (abbrev page index) */
-#else /* CONFIG_PPC64BRIDGE */
-	clrlwi	r3,r3,8			/* reduce vsid to 24 bits */
-	sldi	r5,r3,12		/* shift vsid into position */
-	rlwimi	r5,r4,16,20,24		/* put in API (abbrev page index) */
-#endif /* CONFIG_PPC64BRIDGE */
 	SET_V(r5)			/* set V (valid) bit */
 
 	/* Get the address of the primary PTE group in the hash table (r3) */
@@ -516,14 +488,8 @@ _GLOBAL(flush_hash_pages)
 	add	r3,r3,r0		/* note code below trims to 24 bits */
 
 	/* Construct the high word of the PPC-style PTE (r11) */
-#ifndef CONFIG_PPC64BRIDGE
 	rlwinm	r11,r3,7,1,24		/* put VSID in 0x7fffff80 bits */
 	rlwimi	r11,r4,10,26,31		/* put in API (abbrev page index) */
-#else /* CONFIG_PPC64BRIDGE */
-	clrlwi	r3,r3,8			/* reduce vsid to 24 bits */
-	sldi	r11,r3,12		/* shift vsid into position */
-	rlwimi	r11,r4,16,20,24		/* put in API (abbrev page index) */
-#endif /* CONFIG_PPC64BRIDGE */
 	SET_V(r11)			/* set V (valid) bit */
 
 #ifdef CONFIG_SMP
Index: build/arch/powerpc/mm/ppc_mmu_32.c
===================================================================
--- build.orig/arch/powerpc/mm/ppc_mmu_32.c	2006-06-10 11:36:57.000000000 +1000
+++ build/arch/powerpc/mm/ppc_mmu_32.c	2006-06-10 11:39:51.000000000 +1000
@@ -42,11 +42,7 @@ unsigned long _SDR1;
 
 union ubat {			/* BAT register values to be loaded */
 	BAT	bat;
-#ifdef CONFIG_PPC64BRIDGE
-	u64	word[2];
-#else
 	u32	word[2];
-#endif
 } BATS[4][2];			/* 4 pairs of IBAT, DBAT */
 
 struct batrange {		/* stores address ranges mapped by BATs */
@@ -220,15 +216,9 @@ void __init MMU_init_hw(void)
 
 	if ( ppc_md.progress ) ppc_md.progress("hash:enter", 0x105);
 
-#ifdef CONFIG_PPC64BRIDGE
-#define LG_HPTEG_SIZE	7		/* 128 bytes per HPTEG */
-#define SDR1_LOW_BITS	(lg_n_hpteg - 11)
-#define MIN_N_HPTEG	2048		/* min 256kB hash table */
-#else
 #define LG_HPTEG_SIZE	6		/* 64 bytes per HPTEG */
 #define SDR1_LOW_BITS	((n_hpteg - 1) >> 10)
 #define MIN_N_HPTEG	1024		/* min 64kB hash table */
-#endif
 
 	/*
 	 * Allow 1 HPTE (1/8 HPTEG) for each page of memory.
Index: build/include/asm-ppc/mmu.h
===================================================================
--- build.orig/include/asm-ppc/mmu.h	2006-06-10 11:36:57.000000000 +1000
+++ build/include/asm-ppc/mmu.h	2006-06-10 11:39:51.000000000 +1000
@@ -29,20 +29,11 @@ typedef unsigned long mm_context_t;
 
 /* Hardware Page Table Entry */
 typedef struct _PTE {
-#ifdef CONFIG_PPC64BRIDGE
-	unsigned long long vsid:52;
-	unsigned long api:5;
-	unsigned long :5;
-	unsigned long h:1;
-	unsigned long v:1;
-	unsigned long long rpn:52;
-#else /* CONFIG_PPC64BRIDGE */
 	unsigned long v:1;	/* Entry is valid */
 	unsigned long vsid:24;	/* Virtual segment identifier */
 	unsigned long h:1;	/* Hash algorithm indicator */
 	unsigned long api:6;	/* Abbreviated page index */
 	unsigned long rpn:20;	/* Real (physical) page number */
-#endif /* CONFIG_PPC64BRIDGE */
 	unsigned long    :3;	/* Unused */
 	unsigned long r:1;	/* Referenced */
 	unsigned long c:1;	/* Changed */
@@ -83,11 +74,7 @@ typedef struct _P601_BATU {	/* Upper par
 } P601_BATU;
 
 typedef struct _BATU {		/* Upper part of BAT (all except 601) */
-#ifdef CONFIG_PPC64BRIDGE
-	unsigned long long bepi:47;
-#else /* CONFIG_PPC64BRIDGE */
 	unsigned long bepi:15;	/* Effective page index (virtual address) */
-#endif /* CONFIG_PPC64BRIDGE */
 	unsigned long :4;	/* Unused */
 	unsigned long bl:11;	/* Block size mask */
 	unsigned long vs:1;	/* Supervisor valid */
@@ -102,11 +89,7 @@ typedef struct _P601_BATL {	/* Lower par
 } P601_BATL;
 
 typedef struct _BATL {		/* Lower part of BAT (all except 601) */
-#ifdef CONFIG_PPC64BRIDGE
-	unsigned long long brpn:47;
-#else /* CONFIG_PPC64BRIDGE */
 	unsigned long brpn:15;	/* Real page index (physical address) */
-#endif /* CONFIG_PPC64BRIDGE */
 	unsigned long :10;	/* Unused */
 	unsigned long w:1;	/* Write-thru cache */
 	unsigned long i:1;	/* Cache inhibit */
Index: build/arch/um/sys-ppc/misc.S
===================================================================
--- build.orig/arch/um/sys-ppc/misc.S	2006-06-10 11:36:57.000000000 +1000
+++ build/arch/um/sys-ppc/misc.S	2006-06-10 11:39:51.000000000 +1000
@@ -23,14 +23,10 @@
 #define CACHE_LINE_SIZE		16
 #define LG_CACHE_LINE_SIZE	4
 #define MAX_COPY_PREFETCH	1
-#elif !defined(CONFIG_PPC64BRIDGE)
+#else
 #define CACHE_LINE_SIZE		32
 #define LG_CACHE_LINE_SIZE	5
 #define MAX_COPY_PREFETCH	4
-#else
-#define CACHE_LINE_SIZE		128
-#define LG_CACHE_LINE_SIZE	7
-#define MAX_COPY_PREFETCH	1
 #endif /* CONFIG_4xx || CONFIG_8xx */
 
 	.text

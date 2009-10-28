Return-Path: <anton@ozlabs.org>
Date: Wed, 28 Oct 2009 15:31:29 +1100
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org
Subject: [PATCH] powerpc/perf_counter: Enable SDAR in continous sample mode
Message-ID: <20091028043129.GJ3085@kryten>
References: <20090922030109.GG31801@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090922030109.GG31801@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


In continuous sampling mode we want the SDAR to update. While we can
select between dcache misses and erat misses, a decent default is to
enable both.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Moved MMCRA definitions into asm/reg.h.

Index: linux.trees.git/arch/powerpc/kernel/power7-pmu.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/power7-pmu.c	2009-10-28 14:02:08.000000000 +1100
+++ linux.trees.git/arch/powerpc/kernel/power7-pmu.c	2009-10-28 14:03:04.000000000 +1100
@@ -51,10 +51,6 @@
 #define MMCR1_PMCSEL_MSK	0xff
 
 /*
- * Bits in MMCRA
- */
-
-/*
  * Layout of constraint bits:
  * 6666555555555544444444443333333333222222222211111111110000000000
  * 3210987654321098765432109876543210987654321098765432109876543210
@@ -230,7 +226,7 @@ static int power7_compute_mmcr(u64 event
 			       unsigned int hwc[], unsigned long mmcr[])
 {
 	unsigned long mmcr1 = 0;
-	unsigned long mmcra = 0;
+	unsigned long mmcra = MMCRA_SDAR_DCACHE_MISS | MMCRA_SDAR_ERAT_MISS;
 	unsigned int pmc, unit, combine, l2sel, psel;
 	unsigned int pmc_inuse = 0;
 	int i;
Index: linux.trees.git/arch/powerpc/kernel/power5-pmu.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/power5-pmu.c	2009-10-28 14:02:08.000000000 +1100
+++ linux.trees.git/arch/powerpc/kernel/power5-pmu.c	2009-10-28 14:03:04.000000000 +1100
@@ -73,10 +73,6 @@
 #define MMCR1_PMCSEL_MSK	0x7f
 
 /*
- * Bits in MMCRA
- */
-
-/*
  * Layout of constraint bits:
  * 6666555555555544444444443333333333222222222211111111110000000000
  * 3210987654321098765432109876543210987654321098765432109876543210
@@ -390,7 +386,7 @@ static int power5_compute_mmcr(u64 event
 			       unsigned int hwc[], unsigned long mmcr[])
 {
 	unsigned long mmcr1 = 0;
-	unsigned long mmcra = 0;
+	unsigned long mmcra = MMCRA_SDAR_DCACHE_MISS | MMCRA_SDAR_ERAT_MISS;
 	unsigned int pmc, unit, byte, psel;
 	unsigned int ttm, grp;
 	int i, isbus, bit, grsel;
Index: linux.trees.git/arch/powerpc/kernel/power6-pmu.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/power6-pmu.c	2009-10-28 14:02:08.000000000 +1100
+++ linux.trees.git/arch/powerpc/kernel/power6-pmu.c	2009-10-28 14:03:04.000000000 +1100
@@ -178,7 +178,7 @@ static int p6_compute_mmcr(u64 event[], 
 			   unsigned int hwc[], unsigned long mmcr[])
 {
 	unsigned long mmcr1 = 0;
-	unsigned long mmcra = 0;
+	unsigned long mmcra = MMCRA_SDAR_DCACHE_MISS | MMCRA_SDAR_ERAT_MISS;
 	int i;
 	unsigned int pmc, ev, b, u, s, psel;
 	unsigned int ttmset = 0;
Index: linux.trees.git/arch/powerpc/include/asm/reg.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/reg.h	2009-10-28 14:02:08.000000000 +1100
+++ linux.trees.git/arch/powerpc/include/asm/reg.h	2009-10-28 14:03:33.000000000 +1100
@@ -489,6 +489,8 @@
 #define SPRN_MMCR1	798
 #define SPRN_MMCRA	0x312
 #define   MMCRA_SDSYNC	0x80000000UL /* SDAR synced with SIAR */
+#define   MMCRA_SDAR_DCACHE_MISS 0x40000000UL
+#define   MMCRA_SDAR_ERAT_MISS   0x20000000UL
 #define   MMCRA_SIHV	0x10000000UL /* state of MSR HV when SIAR set */
 #define   MMCRA_SIPR	0x08000000UL /* state of MSR PR when SIAR set */
 #define   MMCRA_SLOT	0x07000000UL /* SLOT bits (37-39) */
Index: linux.trees.git/arch/powerpc/kernel/power5+-pmu.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/power5+-pmu.c	2009-10-28 14:03:57.000000000 +1100
+++ linux.trees.git/arch/powerpc/kernel/power5+-pmu.c	2009-10-28 14:03:58.000000000 +1100
@@ -73,10 +73,6 @@
 #define MMCR1_PMCSEL_MSK	0x7f
 
 /*
- * Bits in MMCRA
- */
-
-/*
  * Layout of constraint bits:
  * 6666555555555544444444443333333333222222222211111111110000000000
  * 3210987654321098765432109876543210987654321098765432109876543210
Index: linux.trees.git/arch/powerpc/kernel/ppc970-pmu.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/ppc970-pmu.c	2009-10-28 14:03:57.000000000 +1100
+++ linux.trees.git/arch/powerpc/kernel/ppc970-pmu.c	2009-10-28 14:03:58.000000000 +1100
@@ -84,10 +84,6 @@ static short mmcr1_adder_bits[8] = {
 };
 
 /*
- * Bits in MMCRA
- */
-
-/*
  * Layout of constraint bits:
  * 6666555555555544444444443333333333222222222211111111110000000000
  * 3210987654321098765432109876543210987654321098765432109876543210

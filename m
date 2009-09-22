Return-Path: <anton@ozlabs.org>
Date: Tue, 22 Sep 2009 13:01:09 +1000
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org, benh@kernel.crashing.org, a.p.zijlstra@chello.nl,
	mingo@elte.hu
Subject: [PATCH] powerpc/perf_counter: Enable SDAR in continous sample mode
Message-ID: <20090922030109.GG31801@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Index: linux.trees.git/arch/powerpc/kernel/power7-pmu.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/power7-pmu.c	2009-07-22 08:41:50.000000000 +1000
+++ linux.trees.git/arch/powerpc/kernel/power7-pmu.c	2009-07-22 09:22:54.000000000 +1000
@@ -54,6 +54,10 @@
  * Bits in MMCRA
  */
 
+/* These bits control when the SDAR updates when in continous sampling mode */
+#define MMCRA_SDAR_DCACHE_MISS	30
+#define MMCRA_SDAR_ERAT_MISS	29
+
 /*
  * Layout of constraint bits:
  * 6666555555555544444444443333333333222222222211111111110000000000
@@ -230,7 +234,8 @@ static int power7_compute_mmcr(u64 event
 			       unsigned int hwc[], unsigned long mmcr[])
 {
 	unsigned long mmcr1 = 0;
-	unsigned long mmcra = 0;
+	unsigned long mmcra = (1 << MMCRA_SDAR_DCACHE_MISS) |
+				(1 << MMCRA_SDAR_ERAT_MISS);
 	unsigned int pmc, unit, combine, l2sel, psel;
 	unsigned int pmc_inuse = 0;
 	int i;
Index: linux.trees.git/arch/powerpc/kernel/power5-pmu.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/power5-pmu.c	2009-07-22 09:07:17.000000000 +1000
+++ linux.trees.git/arch/powerpc/kernel/power5-pmu.c	2009-07-22 09:22:52.000000000 +1000
@@ -76,6 +76,10 @@
  * Bits in MMCRA
  */
 
+/* These bits control when the SDAR updates when in continous sampling mode */
+#define MMCRA_SDAR_DCACHE_MISS	30
+#define MMCRA_SDAR_ERAT_MISS	29
+
 /*
  * Layout of constraint bits:
  * 6666555555555544444444443333333333222222222211111111110000000000
@@ -390,7 +394,8 @@ static int power5_compute_mmcr(u64 event
 			       unsigned int hwc[], unsigned long mmcr[])
 {
 	unsigned long mmcr1 = 0;
-	unsigned long mmcra = 0;
+	unsigned long mmcra = (1 << MMCRA_SDAR_DCACHE_MISS) |
+				(1 << MMCRA_SDAR_ERAT_MISS);
 	unsigned int pmc, unit, byte, psel;
 	unsigned int ttm, grp;
 	int i, isbus, bit, grsel;
Index: linux.trees.git/arch/powerpc/kernel/power6-pmu.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/power6-pmu.c	2009-07-22 09:07:14.000000000 +1000
+++ linux.trees.git/arch/powerpc/kernel/power6-pmu.c	2009-07-22 09:22:45.000000000 +1000
@@ -51,6 +51,14 @@
 #define MMCR1_PMCSEL_MSK	0xff
 
 /*
+ * Bits in MMCRA
+ */
+
+/* These bits control when the SDAR updates when in continous sampling mode */
+#define MMCRA_SDAR_DCACHE_MISS	30
+#define MMCRA_SDAR_ERAT_MISS	29
+
+/*
  * Map of which direct events on which PMCs are marked instruction events.
  * Indexed by PMCSEL value >> 1.
  * Bottom 4 bits are a map of which PMCs are interesting,
@@ -178,7 +186,8 @@ static int p6_compute_mmcr(u64 event[], 
 			   unsigned int hwc[], unsigned long mmcr[])
 {
 	unsigned long mmcr1 = 0;
-	unsigned long mmcra = 0;
+	unsigned long mmcra = (1 << MMCRA_SDAR_DCACHE_MISS) |
+				(1 << MMCRA_SDAR_ERAT_MISS);
 	int i;
 	unsigned int pmc, ev, b, u, s, psel;
 	unsigned int ttmset = 0;

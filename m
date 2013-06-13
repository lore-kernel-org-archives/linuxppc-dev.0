Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/perf: Freeze PMC5/6 if we're not using them on Power8
Date: Thu, 13 Jun 2013 11:16:40 +1000
Message-Id: <1371086200-16778-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Power8 we can freeze PMC5 and 6 if we're not using them. Normally they
run all the time.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/reg.h |    1 +
 arch/powerpc/perf/power8-pmu.c |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 4a9e408..362142b 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -626,6 +626,7 @@
 #define   MMCR0_TRIGGER	0x00002000UL /* TRIGGER enable */
 #define   MMCR0_PMAO	0x00000080UL /* performance monitor alert has occurred, set to 0 after handling exception */
 #define   MMCR0_SHRFC	0x00000040UL /* SHRre freeze conditions between threads */
+#define   MMCR0_FC56	0x00000010UL /* freeze counters 5 and 6 */
 #define   MMCR0_FCTI	0x00000008UL /* freeze counters in tags inactive mode */
 #define   MMCR0_FCTA	0x00000004UL /* freeze counters in tags active mode */
 #define   MMCR0_FCWAIT	0x00000002UL /* freeze counter in WAIT state */
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index f7d1c4f..e791c68 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -378,6 +378,10 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
 	if (pmc_inuse & 0x7c)
 		mmcr[0] |= MMCR0_PMCjCE;
 
+	/* If we're not using PMC 5 or 6, freeze them */
+	if (!(pmc_inuse & 0x60))
+		mmcr[0] |= MMCR0_FC56;
+
 	mmcr[1] = mmcr1;
 	mmcr[2] = mmcra;
 
-- 
1.7.10.4

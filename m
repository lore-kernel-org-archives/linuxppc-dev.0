Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/9] powerpc/perf: Freeze PMC5/6 if we're not using them
Date: Fri, 28 Jun 2013 18:15:12 +1000
Message-Id: <1372407319-718-3-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1372407319-718-1-git-send-email-michael@ellerman.id.au>
References: <1372407319-718-1-git-send-email-michael@ellerman.id.au>
Cc: sukadev@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>,
 khandual@linux.vnet.ibm.com
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

As noticed by Anshuman, we should unfreeze them when we disable the PMU
as there are legacy tools which expect them to run all the time.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/reg.h  |    1 +
 arch/powerpc/perf/core-book3s.c |    5 +++--
 arch/powerpc/perf/power8-pmu.c  |    4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

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
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 1ab3068..3d566ee 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -75,6 +75,7 @@ static unsigned int freeze_events_kernel = MMCR0_FCS;
 
 #define MMCR0_FCHV		0
 #define MMCR0_PMCjCE		MMCR0_PMCnCE
+#define MMCR0_FC56		0
 #define MMCR0_PMAO		0
 
 #define SPRN_MMCRA		SPRN_MMCR2
@@ -870,11 +871,11 @@ static void power_pmu_disable(struct pmu *pmu)
 		}
 
 		/*
-		 * Set the 'freeze counters' bit, clear PMAO.
+		 * Set the 'freeze counters' bit, clear PMAO/FC56.
 		 */
 		val  = mfspr(SPRN_MMCR0);
 		val |= MMCR0_FC;
-		val &= ~MMCR0_PMAO;
+		val &= ~(MMCR0_PMAO | MMCR0_FC56);
 
 		/*
 		 * The barrier is to make sure the mtspr has been
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 84cdc6d..d59f5b2 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -391,6 +391,10 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
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

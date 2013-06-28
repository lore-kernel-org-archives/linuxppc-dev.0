Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/9] powerpc/perf: Rework disable logic in pmu_disable()
Date: Fri, 28 Jun 2013 18:15:11 +1000
Message-Id: <1372407319-718-2-git-send-email-michael@ellerman.id.au>
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

In pmu_disable() we disable the PMU by setting the FC (Freeze Counters)
bit in MMCR0. In order to do this we have to read/modify/write MMCR0.

It's possible that we read a value from MMCR0 which has PMAO (PMU Alert
Occurred) set. When we write that value back it will cause an interrupt
to occur. We will then end up in the PMU interrupt handler even though
we are supposed to have just disabled the PMU.

We can avoid this by making sure we never write PMAO back. We should not
lose interrupts because when the PMU is re-enabled the overflowed values
will cause another interrupt.

We also reorder the clearing of SAMPLE_ENABLE so that is done after the
PMU is frozen. Otherwise there is a small window between the clearing of
SAMPLE_ENABLE and the setting of FC where we could take an interrupt and
incorrectly see SAMPLE_ENABLE not set. This would for example change the
logic in perf_read_regs().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c |   31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 29c6482..1ab3068 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -75,6 +75,7 @@ static unsigned int freeze_events_kernel = MMCR0_FCS;
 
 #define MMCR0_FCHV		0
 #define MMCR0_PMCjCE		MMCR0_PMCnCE
+#define MMCR0_PMAO		0
 
 #define SPRN_MMCRA		SPRN_MMCR2
 #define MMCRA_SAMPLE_ENABLE	0
@@ -852,7 +853,7 @@ static void write_mmcr0(struct cpu_hw_events *cpuhw, unsigned long mmcr0)
 static void power_pmu_disable(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuhw;
-	unsigned long flags;
+	unsigned long flags, val;
 
 	if (!ppmu)
 		return;
@@ -860,9 +861,6 @@ static void power_pmu_disable(struct pmu *pmu)
 	cpuhw = &__get_cpu_var(cpu_hw_events);
 
 	if (!cpuhw->disabled) {
-		cpuhw->disabled = 1;
-		cpuhw->n_added = 0;
-
 		/*
 		 * Check if we ever enabled the PMU on this cpu.
 		 */
@@ -872,6 +870,21 @@ static void power_pmu_disable(struct pmu *pmu)
 		}
 
 		/*
+		 * Set the 'freeze counters' bit, clear PMAO.
+		 */
+		val  = mfspr(SPRN_MMCR0);
+		val |= MMCR0_FC;
+		val &= ~MMCR0_PMAO;
+
+		/*
+		 * The barrier is to make sure the mtspr has been
+		 * executed and the PMU has frozen the events etc.
+		 * before we return.
+		 */
+		write_mmcr0(cpuhw, val);
+		mb();
+
+		/*
 		 * Disable instruction sampling if it was enabled
 		 */
 		if (cpuhw->mmcr[2] & MMCRA_SAMPLE_ENABLE) {
@@ -880,14 +893,8 @@ static void power_pmu_disable(struct pmu *pmu)
 			mb();
 		}
 
-		/*
-		 * Set the 'freeze counters' bit.
-		 * The barrier is to make sure the mtspr has been
-		 * executed and the PMU has frozen the events
-		 * before we return.
-		 */
-		write_mmcr0(cpuhw, mfspr(SPRN_MMCR0) | MMCR0_FC);
-		mb();
+		cpuhw->disabled = 1;
+		cpuhw->n_added = 0;
 	}
 	local_irq_restore(flags);
 }
-- 
1.7.10.4

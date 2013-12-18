Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc,
 perf: Configure BHRB filter before enabling PMU interrupts
Date: Wed, 18 Dec 2013 13:14:53 +1100
Message-Id: <1387332893-14407-1-git-send-email-mpe@ellerman.id.au>
Cc: khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Right now the config_bhrb() PMU specific call happens after
write_mmcr0(), which actually enables the PMU for event counting and
interrupts. So there is a small window of time where the PMU and BHRB
runs without the required HW branch filter (if any) enabled in BHRB.

This can cause some of the branch samples to be collected through BHRB
without any filter applied and hence affects the correctness of
the results. This patch moves the BHRB config function call before
enabling interrupts.

Here are some data points captured via trace prints which depicts how we
could get PMU interrupts with BHRB filter NOT enabled with a standard
perf record command line (asking for branch record information as well).

    $ perf record -j any_call ls

Before the patch:-

    ls-1962  [003] d...  2065.299590: .perf_event_interrupt: MMCRA: 40000000000
    ls-1962  [003] d...  2065.299603: .perf_event_interrupt: MMCRA: 40000000000
    ...

    All the PMU interrupts before this point did not have the requested
    HW branch filter enabled in the MMCRA.

    ls-1962  [003] d...  2065.299647: .perf_event_interrupt: MMCRA: 40040000000
    ls-1962  [003] d...  2065.299662: .perf_event_interrupt: MMCRA: 40040000000

After the patch:-

    ls-1850  [008] d...   190.311828: .perf_event_interrupt: MMCRA: 40040000000
    ls-1850  [008] d...   190.311848: .perf_event_interrupt: MMCRA: 40040000000

    All the PMU interrupts have the requested HW BHRB branch filter
    enabled in MMCRA.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
[mpe: Fixed up whitespace and cleaned up changelog]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Ben this is a bug fix so would be nice for 3.13.

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 29b89e8..67cf220 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1147,6 +1147,9 @@ static void power_pmu_enable(struct pmu *pmu)
 	mmcr0 = ebb_switch_in(ebb, cpuhw->mmcr[0]);
 
 	mb();
+	if (cpuhw->bhrb_users)
+		ppmu->config_bhrb(cpuhw->bhrb_filter);
+
 	write_mmcr0(cpuhw, mmcr0);
 
 	/*
@@ -1158,8 +1161,6 @@ static void power_pmu_enable(struct pmu *pmu)
 	}
 
  out:
-	if (cpuhw->bhrb_users)
-		ppmu->config_bhrb(cpuhw->bhrb_filter);
 
 	local_irq_restore(flags);
 }
-- 
1.8.3.2

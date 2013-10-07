Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 624042C00BD
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Oct 2013 15:31:50 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 7 Oct 2013 14:31:50 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0D99B2BB0054
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Oct 2013 15:31:37 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r974EW4s9699594
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Oct 2013 15:14:34 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r974VY5O014536
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Oct 2013 15:31:34 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc,
 perf: Configure BHRB filter before enabling PMU interrupts
Date: Mon,  7 Oct 2013 10:00:26 +0530
Message-Id: <1381120226-14838-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Right now the `config_bhrb` PMU specific call happens after write_mmcr0
which actually enables the PMU for event counting and interrupt. So
there is a small window of time where the PMU and BHRB runs without the
required HW branch filter (if any) enabled in BHRB. This can cause some
of the branch samples to be collected through BHRB without any filter
being applied and hence affecting the correctness of the results. This
patch moves the BHRB config function call before enabling the interrupts.

Here are some data points captured via trace prints which depicts how we
could get PMU interrupts with BHRB filter NOT enabled with a standard
perf record command line (asking for branch record information as well).

	perf record -j any_call ls

Before the patch:-

              ls-1962  [003] d...  2065.299590: .perf_event_interrupt: MMCRA: 40000000000
              ls-1962  [003] d...  2065.299603: .perf_event_interrupt: MMCRA: 40000000000
              ls-1962  [003] d...  2065.299611: .perf_event_interrupt: MMCRA: 40000000000
              ls-1962  [003] d...  2065.299618: .perf_event_interrupt: MMCRA: 40000000000
              ls-1962  [003] d...  2065.299625: .perf_event_interrupt: MMCRA: 40000000000
              ls-1962  [003] d...  2065.299632: .perf_event_interrupt: MMCRA: 40000000000
              ls-1962  [003] d...  2065.299639: .perf_event_interrupt: MMCRA: 40000000000

	      --> All the PMU interrupts before this point did not have the
	      --> requested HW branch filter enabled in the MMCRA.

              ls-1962  [003] d...  2065.299647: .perf_event_interrupt: MMCRA: 40040000000
              ls-1962  [003] d...  2065.299662: .perf_event_interrupt: MMCRA: 40040000000
              ls-1962  [003] d...  2065.299700: .perf_event_interrupt: MMCRA: 40040000000
              ls-1962  [003] d...  2065.299798: .perf_event_interrupt: MMCRA: 40040000000
              ls-1962  [003] d...  2065.299956: .perf_event_interrupt: MMCRA: 40040000000
              ls-1962  [003] d...  2065.300145: .perf_event_interrupt: MMCRA: 40040000000
              ls-1962  [003] d...  2065.300347: .perf_event_interrupt: MMCRA: 40040000000
              ls-1962  [003] d...  2065.300556: .perf_event_interrupt: MMCRA: 40040000000
              ls-1962  [003] d...  2065.300771: .perf_event_interrupt: MMCRA: 40040000000

After the patch:-

              ls-1850  [008] d...   190.311828: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.311848: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.311856: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.311863: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.311869: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.311876: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.311884: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.311892: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.311907: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.311945: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.312044: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.312206: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.312397: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d..2   190.312626: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.312814: .perf_event_interrupt: MMCRA: 40040000000
              ls-1850  [008] d...   190.313004: .perf_event_interrupt: MMCRA: 40040000000

	      --> All the PMU interrupts have the requested
	      --> HW BHRB branch filter enabled in MMCRA.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 29b89e8..7d2f13c 100644
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
1.7.11.7

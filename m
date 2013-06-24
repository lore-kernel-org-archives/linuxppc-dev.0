Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/8] powerpc/perf: Don't enable if we have zero events
Date: Mon, 24 Jun 2013 21:28:53 +1000
Message-Id: <1372073336-8189-5-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
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

In power_pmu_enable() we still enable the PMU even if we have zero
events. This should have no effect but doesn't make much sense. Instead
just return after telling the hypervisor that we are not using the PMCs.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/perf/core-book3s.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index af4b4b1..d3ee2e5 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -926,6 +926,11 @@ static void power_pmu_enable(struct pmu *pmu)
 	if (!cpuhw->disabled)
 		goto out;
 
+	if (cpuhw->n_events == 0) {
+		ppc_set_pmu_inuse(0);
+		goto out;
+	}
+
 	cpuhw->disabled = 0;
 
 	/*
@@ -937,8 +942,6 @@ static void power_pmu_enable(struct pmu *pmu)
 	if (!cpuhw->n_added) {
 		mtspr(SPRN_MMCRA, cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
 		mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
-		if (cpuhw->n_events == 0)
-			ppc_set_pmu_inuse(0);
 		goto out_enable;
 	}
 
-- 
1.7.10.4

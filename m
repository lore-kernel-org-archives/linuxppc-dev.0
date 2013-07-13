Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/perf: Set PPC_FEATURE2_EBB when we register the
 power8 PMU
Date: Sat, 13 Jul 2013 12:53:40 +1000
Message-Id: <1373684020-19203-1-git-send-email-michael@ellerman.id.au>
Cc: azanella@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The presence or absence of EBB is advertised to userspace via the presence
or absence of PPC_FEATURE2_EBB in cpu_user_features2.

Because the kernel can be built without PMU support, we should only add
PPC_FEATURE2_EBB to cpu_user_features2 when we successfully register the
power8 PMU support.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/perf/power8-pmu.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 96a64d6..09def19 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -621,10 +621,19 @@ static struct power_pmu power8_pmu = {
 
 static int __init init_power8_pmu(void)
 {
+	int rc;
+
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power8"))
 		return -ENODEV;
 
-	return register_power_pmu(&power8_pmu);
+	rc = register_power_pmu(&power8_pmu);
+	if (rc)
+		return rc;
+
+	/* Tell userspace that EBB is supported */
+	cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_EBB;
+
+	return 0;
 }
 early_initcall(init_power8_pmu);
-- 
1.7.10.4

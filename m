Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/perf: Add missing L2 constraint handling in Power7 PMU
Date: Wed, 31 Oct 2012 13:09:56 +1100
Message-Id: <1351649396-31639-1-git-send-email-michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we have two cache events that require different settings of the L2SEL
bits in MMCR1 then we can not schedule those events simultaneously. Add
logic to the constraint handling to express that.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/perf/power7-pmu.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 441af08..2ee01e3 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -54,8 +54,10 @@
  * Layout of constraint bits:
  * 6666555555555544444444443333333333222222222211111111110000000000
  * 3210987654321098765432109876543210987654321098765432109876543210
- *                                                 [  ><><><><><><>
- *                                                  NC P6P5P4P3P2P1
+ *                                              < ><  ><><><><><><>
+ *                                              L2  NC P6P5P4P3P2P1
+ *
+ * L2 - 16-18 - Required L2SEL value (select field)
  *
  * NC - number of counters
  *     15: NC error 0x8000
@@ -72,7 +74,7 @@
 static int power7_get_constraint(u64 event, unsigned long *maskp,
 				 unsigned long *valp)
 {
-	int pmc, sh;
+	int pmc, sh, unit;
 	unsigned long mask = 0, value = 0;
 
 	pmc = (event >> PM_PMC_SH) & PM_PMC_MSK;
@@ -90,6 +92,15 @@ static int power7_get_constraint(u64 event, unsigned long *maskp,
 		mask  |= 0x8000;
 		value |= 0x1000;
 	}
+
+	unit = (event >> PM_UNIT_SH) & PM_UNIT_MSK;
+	if (unit == 6) {
+		/* L2SEL must be identical across events */
+		int l2sel = (event >> PM_L2SEL_SH) & PM_L2SEL_MSK;
+		mask  |= 0x7 << 16;
+		value |= l2sel << 16;
+	}
+
 	*maskp = mask;
 	*valp = value;
 	return 0;
-- 
1.7.9.5

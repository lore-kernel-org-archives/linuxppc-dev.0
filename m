Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <^Cnh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/perf: Fix for PMCs not making progress
Date: Tue,  6 Nov 2012 12:08:38 +1100
Message-Id: <1352164118-19450-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1352164118-19450-1-git-send-email-mikey@neuling.org>
References: <20120921003805.GA4507@us.ibm.com>
 <1352164118-19450-1-git-send-email-mikey@neuling.org>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER7 when we have really small counts left before overflow, we can take a
PMU IRQ, but the PMC gets wound back to just before the overflow.

If the kernel is setting the PMC to a value just before the overflow, we can
get interrupted again without the PMC making any progress (ie another buggy
overflow).  In this case, we can end up making no forward progress, with the
PMC interrupt returning us to the same count over and over.

The below detects when we are making no forward progress (ie. delta = 0) and
then increases the amount left before the overflow.  This stops us from locking
up.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
cc: Paul Mackerras <paulus@samba.org>
cc: Anton Blanchard <anton@samba.org>
cc: Linux PPC dev <linuxppc-dev@ozlabs.org>
---
 arch/powerpc/perf/core-book3s.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 3575def..f1018c8 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1349,6 +1349,8 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 	 */
 	val = 0;
 	left = local64_read(&event->hw.period_left) - delta;
+	if (delta == 0)
+		left++;
 	if (period) {
 		if (left <= 0) {
 			left += period;
-- 
1.7.9.5

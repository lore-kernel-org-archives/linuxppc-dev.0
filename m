Return-Path: <matt@ozlabs.org>
Message-ID: <4C32A4C0.3000600@ozlabs.org>
Date: Tue, 06 Jul 2010 13:36:32 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] perf_event: Fix for power_pmu_disable()
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When power_pmu_disable() removes the given event from a particular index into
cpuhw->event[], it shuffles down higher event[] entries.  But, this array is
paired with cpuhw->events[] and cpuhw->flags[] so should shuffle them
similarly.

If these arrays get out of sync, code such as power_check_constraints() will
fail.  This caused a bug where events were temporarily disabled and then failed
to be re-enabled; subsequent code tried to write_pmc() with its (disabled) idx
of 0, causing a message "oops trying to write PMC0".  This triggers this bug on
POWER7, running a miss-heavy test:

  perf record -e L1-dcache-load-misses -e L1-dcache-store-misses ./misstest

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 arch/powerpc/kernel/perf_event.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/perf_event.c b/arch/powerpc/kernel/perf_event.c
index 08460a2..3766398 100644
--- a/arch/powerpc/kernel/perf_event.c
+++ b/arch/powerpc/kernel/perf_event.c
@@ -838,8 +838,11 @@ static void power_pmu_disable(struct perf_event *event)
 	cpuhw = &__get_cpu_var(cpu_hw_events);
 	for (i = 0; i < cpuhw->n_events; ++i) {
 		if (event == cpuhw->event[i]) {
-			while (++i < cpuhw->n_events)
+			while (++i < cpuhw->n_events) {
 				cpuhw->event[i-1] = cpuhw->event[i];
+				cpuhw->events[i-1] = cpuhw->events[i];
+				cpuhw->flags[i-1] = cpuhw->flags[i];
+			}
 			--cpuhw->n_events;
 			ppmu->disable_pmc(event->hw.idx - 1, cpuhw->mmcr);
 			if (event->hw.idx) {
-- 
1.6.3.3

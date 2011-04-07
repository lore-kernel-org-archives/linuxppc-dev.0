Return-Path: <emunson@mgebm.net>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 671C01007DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 02:53:11 +1000 (EST)
Received: by vxi40 with SMTP id 40so2307148vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 07 Apr 2011 09:53:07 -0700 (PDT)
From: Eric B Munson <emunson@mgebm.net>
To: benh@kernel.crashing.org
Subject: [PATCH V3] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
Date: Thu,  7 Apr 2011 12:52:54 -0400
Message-Id: <1302195174-9115-1-git-send-email-emunson@mgebm.net>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, paulus@samba.org,
	anton@samba.org, acme@ghostprotocols.net, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org, stable@kernel.org,
	Eric B Munson <emunson@mgebm.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Because of speculative event roll back, it is possible for some event coutners
to decrease between reads on POWER7.  This causes a problem with the way that
counters are updated.  Delta calues are calculated in a 64 bit value and the
top 32 bits are masked.  If the register value has decreased, this leaves us
with a very large positive value added to the kernel counters.  This patch
protects against this by skipping the update if the delta would be negative.
This can lead to a lack of precision in the coutner values, but from my testing
the value is typcially fewer than 10 samples at a time.

Signed-off-by: Eric B Munson <emunson@mgebm.net>
Cc: stable@kernel.org
---
Changes from V2:
 Create a helper that should handle counter roll back as well as registers that
might be allowed to roll over

Changes from V1:
 Updated patch leader
 Added stable CC
 Use an s32 to hold delta values and discard any values that are less than 0

 arch/powerpc/kernel/perf_event.c |   40 +++++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/perf_event.c b/arch/powerpc/kernel/perf_event.c
index 97e0ae4..78bf933 100644
--- a/arch/powerpc/kernel/perf_event.c
+++ b/arch/powerpc/kernel/perf_event.c
@@ -398,6 +398,28 @@ static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
 	return 0;
 }
 
+static u64 check_and_compute_delta(s64 prev, s64 val)
+{
+	/*
+	 * Because the PerfMon registers are only 32 bits wide, the delta
+	 * should not overflow.
+	 */
+	u64 delta = 0;
+
+	/*
+	 * POWER7 can roll back counter values, if the new value is smaller
+	 * than the previous value it will cause the delta and the counter to
+	 * have bogus values unless we rolled a counter over.  If this is the
+	 * case or prev < val, calculate the delta nd return it, otherwise
+	 * return 0.  This can lead to a small lack of precision in the
+	 * counters.
+	 */
+	if (((prev & 0x80000000) && !(val & 0x80000000)) || (val > prev))
+		delta = (val - prev) & 0xfffffffful;
+
+	return delta;
+}
+
 static void power_pmu_read(struct perf_event *event)
 {
 	s64 val, delta, prev;
@@ -416,10 +438,11 @@ static void power_pmu_read(struct perf_event *event)
 		prev = local64_read(&event->hw.prev_count);
 		barrier();
 		val = read_pmc(event->hw.idx);
+		delta = check_and_compute_delta(prev, val);
+		if (!delta)
+			return;
 	} while (local64_cmpxchg(&event->hw.prev_count, prev, val) != prev);
 
-	/* The counters are only 32 bits wide */
-	delta = (val - prev) & 0xfffffffful;
 	local64_add(delta, &event->count);
 	local64_sub(delta, &event->hw.period_left);
 }
@@ -449,8 +472,9 @@ static void freeze_limited_counters(struct cpu_hw_events *cpuhw,
 		val = (event->hw.idx == 5) ? pmc5 : pmc6;
 		prev = local64_read(&event->hw.prev_count);
 		event->hw.idx = 0;
-		delta = (val - prev) & 0xfffffffful;
-		local64_add(delta, &event->count);
+		delta = check_and_compute_delta(prev, val);
+		if (delta)
+			local64_add(delta, &event->count);
 	}
 }
 
@@ -458,14 +482,16 @@ static void thaw_limited_counters(struct cpu_hw_events *cpuhw,
 				  unsigned long pmc5, unsigned long pmc6)
 {
 	struct perf_event *event;
-	u64 val;
+	u64 val, prev;
 	int i;
 
 	for (i = 0; i < cpuhw->n_limited; ++i) {
 		event = cpuhw->limited_counter[i];
 		event->hw.idx = cpuhw->limited_hwidx[i];
 		val = (event->hw.idx == 5) ? pmc5 : pmc6;
-		local64_set(&event->hw.prev_count, val);
+		prev = local64_read(&event->hw.prev_count);
+		if (check_and_compute_delta(prev, val))
+			local64_set(&event->hw.prev_count, val);
 		perf_event_update_userpage(event);
 	}
 }
@@ -1197,7 +1223,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 	/* we don't have to worry about interrupts here */
 	prev = local64_read(&event->hw.prev_count);
-	delta = (val - prev) & 0xfffffffful;
+	delta = check_and_compute_delta(prev, val);
 	local64_add(delta, &event->count);
 
 	/*
-- 
1.7.1

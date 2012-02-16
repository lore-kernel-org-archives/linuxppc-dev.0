Return-Path: <anton@samba.org>
Date: Thu, 16 Feb 2012 15:48:22 +1100
From: Anton Blanchard <anton@samba.org>
To: eranian@google.com, paulus@samba.org, peterz@infradead.org,
 mingo@elte.hu,  gleb@redhat.com, wcohen@redhat.com, vince@deater.net,
 asharma@fb.com, andi@firstfloor.org, emunson@mgebm.net,
 imunsie@au1.ibm.com, benh@kernel.crashing.org, sukadev@linux.vnet.ibm.com
Subject: [PATCH] powerpc: perf: power_pmu_start restores incorrect values,
 breaking frequency events
Message-ID: <20120216154822.5bfad11d@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


perf on POWER stopped working after commit e050e3f0a71b (perf: Fix
broken interrupt rate throttling). That patch exposed a bug in
the POWER perf_events code.

Since the PMCs count upwards and take an exception when the top bit
is set, we want to write 0x80000000 - left in power_pmu_start. We were
instead programming in left which effectively disables the counter
until we eventually hit 0x80000000. This could take seconds or longer.

With the patch applied I get the expected number of samples:

# taskset -c 0 yes > /dev/null &
# perf record -C 0 -a sleep 10
# perf report -D | grep SAMPLE | tail -1
          SAMPLE events:       9948

Signed-off-by: Anton Blanchard <anton@samba.org>
---
Cc: <stable@kernel.org>

Index: linux-build/arch/powerpc/kernel/perf_event.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/perf_event.c	2012-02-16 15:07:57.465384699 +1100
+++ linux-build/arch/powerpc/kernel/perf_event.c	2012-02-16 15:11:48.449579581 +1100
@@ -865,6 +865,7 @@ static void power_pmu_start(struct perf_
 {
 	unsigned long flags;
 	s64 left;
+	unsigned long val;
 
 	if (!event->hw.idx || !event->hw.sample_period)
 		return;
@@ -880,7 +881,12 @@ static void power_pmu_start(struct perf_
 
 	event->hw.state = 0;
 	left = local64_read(&event->hw.period_left);
-	write_pmc(event->hw.idx, left);
+
+	val = 0;
+	if (left < 0x80000000L)
+		val = 0x80000000L - left;
+
+	write_pmc(event->hw.idx, val);
 
 	perf_event_update_userpage(event);
 	perf_pmu_enable(event->pmu);

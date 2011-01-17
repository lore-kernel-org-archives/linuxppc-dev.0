Return-Path: <anton@samba.org>
Date: Mon, 17 Jan 2011 16:17:42 +1100
From: Anton Blanchard <anton@samba.org>
To: Paul Mackerras <paulus@samba.org>, Peter Zijlstra
	<a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de
	Melo <acme@ghostprotocols.net>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH] powerpc: perf: Fix frequency calculation for overflowing
	counters
Message-ID: <20110117161742.5feb3761@kryten>
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


When profiling a benchmark that is almost 100% userspace, I noticed some
wildly inaccurate profiles that showed almost all time spent in the kernel.
Closer examination shows we were programming a tiny number of cycles into
the PMU after each overflow (about ~200 away from the next overflow). This
gets us stuck in a loop which we eventually break out of by throttling the
PMU (there are regular throttle/unthrottle events in the log).

It looks like we aren't setting event->hw.last_period to something same
and the frequency to period calculations in perf are going haywire. With
the following patch we find the correct period after a few interrupts and
stay there. I also see no more throttle events.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/perf_event.c b/arch/powerpc/kernel/perf_event.c
index 5674807..ab6f6be 100644
--- a/arch/powerpc/kernel/perf_event.c
+++ b/arch/powerpc/kernel/perf_event.c
@@ -1212,6 +1212,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			if (left <= 0)
 				left = period;
 			record = 1;
+			event->hw.last_period = event->hw.sample_period;
 		}
 		if (left < 0x80000000LL)
 			val = 0x80000000LL - left;

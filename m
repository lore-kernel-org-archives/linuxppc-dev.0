Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19127.8400.376239.586120@drongo.ozlabs.ibm.com>
Date: Mon, 21 Sep 2009 16:44:32 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra
   <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf_counter/powerpc: Fix compilation after
	perf_counter_overflow change
Cc: Markus Metzger <markus.t.metzger@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 5622f295 ("x86, perf_counter, bts: Optimize BTS overflow
handling") removed the regs field from struct perf_sample_data and
added a regs parameter to perf_counter_overflow().  This breaks the
build on powerpc as reported by Sachin Sant:

arch/powerpc/kernel/perf_counter.c: In function 'record_and_restart':
arch/powerpc/kernel/perf_counter.c:1165: error: unknown field 'regs' specified in initializer
cc1: warnings being treated as errors
arch/powerpc/kernel/perf_counter.c:1165: error: initialization makes integer from pointer without a cast
arch/powerpc/kernel/perf_counter.c:1173: error: too few arguments to function 'perf_counter_overflow'
make[1]: *** [arch/powerpc/kernel/perf_counter.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

This adjusts arch/powerpc/kernel/perf_counter.c to correspond with the
new struct perf_sample_data and perf_counter_overflow().

Reported-by: Sachin Sant <sachinp@in.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
I missed this problem when the "x86, perf_counter, bts: Optimize BTS
overflow handling" patch was posted because the headline made it seem
entirely x86-specific, and the changes to struct perf_sample_data and
perf_counter_overflow() were not mentioned in the changelog.

Markus, please take care in future to mention it in the changelog if
your patches touch definitions used by other architectures.  If you
could go so far as to use grep a bit more and fix up other
architectures' callsites for the things you're changing, that would be
very much appreciated.  Thanks.

diff --git a/arch/powerpc/kernel/perf_counter.c b/arch/powerpc/kernel/perf_counter.c
index 7ceefaf..5ccf9bc 100644
--- a/arch/powerpc/kernel/perf_counter.c
+++ b/arch/powerpc/kernel/perf_counter.c
@@ -1162,7 +1162,6 @@ static void record_and_restart(struct perf_counter *counter, unsigned long val,
 	 */
 	if (record) {
 		struct perf_sample_data data = {
-			.regs	= regs,
 			.addr	= 0,
 			.period	= counter->hw.last_period,
 		};
@@ -1170,7 +1169,7 @@ static void record_and_restart(struct perf_counter *counter, unsigned long val,
 		if (counter->attr.sample_type & PERF_SAMPLE_ADDR)
 			perf_get_data_addr(regs, &data.addr);
 
-		if (perf_counter_overflow(counter, nmi, &data)) {
+		if (perf_counter_overflow(counter, nmi, &data, regs)) {
 			/*
 			 * Interrupts are coming too fast - throttle them
 			 * by setting the counter to 0, so it will be

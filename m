Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6945B6F53
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 07:59:32 +1000 (EST)
Date: Mon, 27 Jun 2011 16:56:13 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/timebase_read: don't return time older than cycle_last
Message-ID: <20110627215613.GA13676@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As is done in read_tsc() on x86, make sure that we don't return a timebase
value smaller than cycle_last, which can happen on SMP if the timebases are
not perfectly synchronized.  It is less expensive than total enforcement of
monotonicity, since we don't need to add another variable and update it on
each read, but it will prevent core timekeeping functions from translating
a small timebase regression into a large jump forward.

Based on commit d8bb6f4c1670c8324e4135c61ef07486f7f17379 for x86.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/time.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index f33acfd..b66ce41 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -806,9 +806,22 @@ static cycle_t rtc_read(struct clocksource *cs)
 	return (cycle_t)get_rtc();
 }
 
+/*
+ * We compare the timebase to the cycle_last value in the clocksource
+ * structure to avoid a nasty time-warp.  This can be observed in a very
+ * small window right after one CPU updated cycle_last under the xtime lock,
+ * and the other CPU reads a TSC value which is smaller than the cycle_last
+ * reference value due to a TSC which is slighty behind.  This delta is
+ * nowhere else observable, but in that case it results in a large forward
+ * time jump due to the unsigned delta calculation of the time keeping core
+ * code, which is necessary to support wrapping clocksources like pm timer.
+ */
 static cycle_t timebase_read(struct clocksource *cs)
 {
-	return (cycle_t)get_tb();
+	cycle_t ret = (cycle_t)get_tb();
+
+	return ret >= clocksource_timebase.cycle_last ?
+	       ret : clocksource_timebase.cycle_last;
 }
 
 void update_vsyscall(struct timespec *wall_time, struct timespec *wtm,
-- 
1.7.4.1

Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9BCF42C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 11:08:14 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Aug 2012 19:08:11 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DAB5019D803C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 01:07:48 +0000 (WET)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q7817NfY123296
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Aug 2012 19:07:38 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q78177jt023726
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Aug 2012 19:07:07 -0600
Date: Tue, 7 Aug 2012 18:07:19 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Use pmc_overflow() to detect rolled back events
Message-ID: <20120808010719.GA32730@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 Maynard Johnson <mpjohn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>From 21e9d1775f0c6f37a39e5d682ff74693fa9a4004 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 7 Aug 2012 17:53:24 -0700
Subject: [PATCH] Use pmc_overflow to detect rolled back events.

For certain speculative events on Power7, 'perf stat' reports far higher
event count than 'perf record' for the same event.

As described in following commit, a performance monitor exception is raised
even when the the performance events are rolled back.

        commit 0837e3242c73566fc1c0196b4ec61779c25ffc93
        Author: Anton Blanchard <anton@samba.org>
        Date:   Wed Mar 9 14:38:42 2011 +1100

perf_event_interrupt() records an event only when an overflow occurs. But
this check for overflow is a simple 'if (val < 0)'.

Because the events are rolled back, this check for overflow fails and the
event is not recorded. perf_event_interrupt() later uses pmc_overflow() to
detect the overflow and resets the counters and the events are lost completely.

To properly detect the overflow of rolled back events, use pmc_overflow()
even when recording events.

To reproduce:
        $ cat strcpy.c
        #include <stdio.h>
        #include <string.h>
        main()
        {
                char buf[256];

                alarm(5);
                while(1)
                        strcpy(buf, "string1");
        }

        $ perf record -e r20014 ./strcpy
        $ perf report -n > report.1
        $ perf stat -e r20014 > report.2
        # Compare report.1 and report.2

Reported-by: Maynard Johnson <mpjohn@us.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 8f84bcb..f74b90d 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1394,7 +1394,7 @@ static void perf_event_interrupt(struct pt_regs *regs)
 		if (!event->hw.idx || is_limited_pmc(event->hw.idx))
 			continue;
 		val = read_pmc(event->hw.idx);
-		if ((int)val < 0) {
+		if (pmc_overflow(val)) {
 			/* event has overflowed */
 			found = 1;
 			record_and_restart(event, val, regs);
-- 
1.7.1

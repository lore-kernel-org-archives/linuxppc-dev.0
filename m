Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B60761A02D3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jan 2016 14:07:59 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 29 Jan 2016 20:07:57 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6B6791FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 19:56:03 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0U37rsw29491356
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 20:07:53 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0U37rhp021919
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 20:07:53 -0700
Date: Fri, 29 Jan 2016 19:07:45 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc/perf/hv-24x7: Display change in counter values
Message-ID: <20160130030744.GB7330@us.ibm.com>
References: <20160130030710.GA7330@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160130030710.GA7330@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From a1aa992fb25fb8e98a5c5724376ae8cc91463de3 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Mon, 25 Jan 2016 23:05:36 -0500
Subject: [PATCH 2/2] powerpc/perf/hv-24x7: Display change in counter values

For 24x7 counters, perf displays the raw value of the 24x7 counter, which
is a monotonically increasing value.

	perf stat -C 0 -e \
		'hv_24x7/HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE,core=1/' \
		sleep 1

 Performance counter stats for 'CPU(s) 0':

     9,105,403,170      hv_24x7/HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE,core=1/

       0.000425751 seconds time elapsed

In the typical usage of 'perf stat' this counter value is not as useful
as the _change_ in the counter value over the duration of the application.

Have h_24x7_event_init() set the event's prev_count to the raw value of
the 24x7 counter at the time of initialization. When the application
terminates, hv_24x7_event_read() will compute the change in value and
report to the perf tool. Similarly, for the transaction interface, clear
the event count to 0 at the beginning of the transaction.

	perf stat -C 0 -e \
		'hv_24x7/HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE,core=1/' \
		sleep 1

 Performance counter stats for 'CPU(s) 0':

           245,758      hv_24x7/HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE,core=1/

       1.006366383 seconds time elapsed

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index b7a9a03..77b958f 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1222,11 +1222,12 @@ static int h_24x7_event_init(struct perf_event *event)
 		return -EACCES;
 	}
 
-	/* see if the event complains */
+	/* Get the initial value of the counter for this event */
 	if (single_24x7_request(event, &ct)) {
 		pr_devel("test hcall failed\n");
 		return -EIO;
 	}
+	(void)local64_xchg(&event->hw.prev_count, ct);
 
 	return 0;
 }
@@ -1289,6 +1290,16 @@ static void h_24x7_event_read(struct perf_event *event)
 			h24x7hw = &get_cpu_var(hv_24x7_hw);
 			h24x7hw->events[i] = event;
 			put_cpu_var(h24x7hw);
+			/*
+			 * Clear the event count so we can compute the _change_
+			 * in the 24x7 raw counter value at the end of the txn.
+			 *
+			 * Note that we could alternatively read the 24x7 value
+			 * now and save its value in event->hw.prev_count. But
+			 * that would require issuing a hcall, which would then
+			 * defeat the purpose of using the txn interface.
+			 */
+			local64_set(&event->count, 0);
 		}
 
 		put_cpu_var(hv_24x7_reqb);
-- 
2.5.3

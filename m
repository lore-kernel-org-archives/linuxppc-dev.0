Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 14B132C0349
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2013 06:11:20 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 11 Jan 2013 12:11:16 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 4426319D803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 12:11:10 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0BJB6ZO161536
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 12:11:09 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0BJB3lt023254
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 12:11:04 -0700
Date: Fri, 11 Jan 2013 11:11:17 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] perf/Power: PERF_EVENT_IOC_ENABLE does not reenable event
Message-ID: <20130111191117.GA9407@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maynard Johnson <mpjohn@us.ibm.com>, Anton Blanchard <anton@au1.ibm.com>,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we disable a perf event because we exceeded the specified ->event_limit,
power_pmu_stop() sets the PERF_HES_STOPPED flag on the event.

If the application then re-enables the event using PERF_EVENT_IOC_ENABLE
ioctl, we don't seem to ever clear this STOPPED flag. Consequently, the
user space is never notified of the event.

Following message has more background and test case.

    http://lists.eecs.utk.edu/pipermail/ptools-perfapi/2012-October/002528.html

The problem reported there does not seem to occur on x86. My unverified theory:

Both x86 and Power clear the event->hw.state flag to 0 in their ->pmu_start()
operations. On X86 x86_pmu_start() is called from x86_pmu_enable(). But on
Power, power_pmu_start() is not called from power_pmu_enable().

Used the following test cases to verify that this patch works on latest PAPI.

	$ papi.git/src/ctests/nonthread PAPI_TOT_CYC@5000000

	$ papi.git/src/ctests/overflow_single_event

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index aa2465e..a6faada 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -880,8 +880,16 @@ static int power_pmu_add(struct perf_event *event, int ef_flags)
 	cpuhw->events[n0] = event->hw.config;
 	cpuhw->flags[n0] = event->hw.event_base;
 
+	/*
+	 * If this event was disabled in record_and_restart() because we
+	 * exceeded the ->event_limit, this is probably a good time to
+	 * re-enable the event ? If we don't reenable the event, we will
+	 * never notify the user again about this event.
+	 */
 	if (!(ef_flags & PERF_EF_START))
 		event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	else
+		event->hw.state &= ~PERF_HES_STOPPED;
 
 	/*
 	 * If group events scheduling transaction was started,
-- 
1.7.1

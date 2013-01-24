Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e37.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA8B92C0080
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2013 10:25:29 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 24 Jan 2013 16:25:26 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3DAD51FF0038
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2013 16:25:24 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0ONPNnu351090
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2013 16:25:24 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0ONPMxU001958
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2013 16:25:23 -0700
Date: Thu, 24 Jan 2013 15:25:23 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH][v2] perf/Power: PERF_EVENT_IOC_ENABLE does not reenable event
Message-ID: <20130124232523.GA12162@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maynard Johnson <mpjohn@us.ibm.com>, Anton Blanchard <anton@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf/Power: PERF_EVENT_IOC_ENABLE does not reenable event

If we disable a perf event because we exceeded the specified ->event_limit,
power_pmu_stop() sets the PERF_HES_STOPPED flag on the event.

If the application then re-enables the event using PERF_EVENT_IOC_ENABLE
ioctl, we don't ever clear this STOPPED flag. Consequently, the user space
is never notified of the event.

Following message has more background and test case.

    http://lists.eecs.utk.edu/pipermail/ptools-perfapi/2012-October/002528.html

Used the following test cases to verify that this patch works on latest PAPI.

	$ papi.git/src/ctests/nonthread PAPI_TOT_CYC@5000000

	$ papi.git/src/ctests/overflow_single_event

Changelog[v2]:
	- [Paul Mackerras] Also clear PERF_HES_UPTODATE flag since we are
	  restarting the event; cleanup comments and patch description.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index aa2465e..4b1e584 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -880,8 +880,16 @@ static int power_pmu_add(struct perf_event *event, int ef_flags)
 	cpuhw->events[n0] = event->hw.config;
 	cpuhw->flags[n0] = event->hw.event_base;
 
+	/*
+	 * This event may have been disabled/stopped in record_and_restart()
+	 * because we exceeded the ->event_limit. If re-starting the event,
+	 * clear the ->hw.state (STOPPED and UPTODATE flags), so the user
+	 * notification is re-enabled.
+	 */
 	if (!(ef_flags & PERF_EF_START))
 		event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	else
+		event->hw.state = 0;
 
 	/*
 	 * If group events scheduling transaction was started,
-- 
1.7.1

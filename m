Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e3.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 585D12C00FE
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2012 12:36:40 +1100 (EST)
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 7 Nov 2012 20:36:38 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 29F226E8054
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2012 20:09:25 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA819Ots62193724
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2012 20:09:24 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA819NXH012065
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2012 20:09:24 -0500
Date: Wed, 7 Nov 2012 17:10:35 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anton Blanchard <anton@au1.ibm.com>, robert.richter@amd.com,
 eranian@google.com
Subject: perf: POWER-event translation questions
Message-ID: <20121108011035.GA20670@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Looking for feedback on this prototype for making POWER-specific event
translations available in sysfs. It is based on the patchset:

	https://lkml.org/lkml/2012/11/7/402

which makes the translations for _generic_ events in POWER available in sysfs:

Since this is in POWER7 specific code I am assigning the names given in the
POWER7 CPU spec for now.

I had earlier tried mapping these events to generic names outside sysfs:

	Power7 name		Generic name

	cmpl-stall-fxu		stalled-cycles-fixed-point
	cmpl-stall-lsu		stalled-cycles-load-store
	cmpl-stall-ifu		stalled-cycles-instruction-fetch
	cmpl-stall-bru 		stalled-cycles-branch-unit

But like Stephane Eranian pointed out mapping such events across architectures
can be confusing.

Another challenge I suspect we will have is the extremely long generic names
we could end up with as the events get more specific.

1. Can we have more than one name for an event ? i.e two sysfs entries,
   eg: 'cmpl-stall-fxu' and 'stalled-cycles-fixed-point' for an event ?

2. Can we allow hyphens in the {name} token  (please see my change to
   util/parse-events.l below). With this change, I can run:

	  perf stat -e cpu/cmplu-stall-bru /tmp/nop

   without any changes to the user level tool (parse-events.l) I have
   tested some common cases, not sure if it will break something :-)

   If we are going to create generic or arch specific sysfs entries in
   /sys/bus/event_source/devices/cpu/events, do we need to add corresponding
   entry in tools/perf/util/parse-events.l ?

Sukadev

---
 arch/powerpc/perf/power7-pmu.c |   13 +++++++++++++
 tools/perf/util/parse-events.l |    2 +-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index aa9f588..9f46abc 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -303,6 +303,10 @@ static void power7_disable_pmc(unsigned int pmc, unsigned long mmcr[])
 #define	PM_LD_MISS_L1			0x400f0
 #define	PM_BRU_FIN			0x10068
 #define	PM_BRU_MPRED			0x400f6
+#define	PM_CMPLU_STALL_FXU		0x20014
+#define	PM_CMPLU_STALL_LSU		0x20012
+#define	PM_CMPLU_STALL_IFU		0x4004c
+#define	PM_CMPLU_STALL_BRU		0x4004e
 
 static int power7_generic_events[] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = 			PM_CYC,
@@ -369,6 +373,11 @@ EVENT_ATTR(cache-misses,               LD_MISS_L1);
 EVENT_ATTR(branch-instructions,        BRU_FIN);
 EVENT_ATTR(branch-misses,              BRU_MPRED);
 
+EVENT_ATTR(cmplu-stall-fxu,            CMPLU_STALL_FXU);
+EVENT_ATTR(cmplu-stall-lsu,            CMPLU_STALL_LSU);
+EVENT_ATTR(cmplu-stall-ifu,            CMPLU_STALL_IFU);
+EVENT_ATTR(cmplu-stall-bru,            CMPLU_STALL_BRU);
+
 static struct attribute *power7_events_attr[] = {
 	EVENT_PTR(CYC),
 	EVENT_PTR(GCT_NOSLOT_CYC),
@@ -378,6 +387,10 @@ static struct attribute *power7_events_attr[] = {
 	EVENT_PTR(LD_MISS_L1),
 	EVENT_PTR(BRU_FIN),
 	EVENT_PTR(BRU_MPRED),
+	EVENT_PTR(CMPLU_STALL_FXU),
+	EVENT_PTR(CMPLU_STALL_LSU),
+	EVENT_PTR(CMPLU_STALL_IFU),
+	EVENT_PTR(CMPLU_STALL_BRU),
 	NULL,
 };
 
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index c87efc1..1967bb2 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -80,7 +80,7 @@ event		[^,{}/]+
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
-name		[a-zA-Z_*?][a-zA-Z0-9_*?]*
+name		[-a-zA-Z_*?][-a-zA-Z0-9_*?]*
 modifier_event	[ukhpGH]{1,8}
 modifier_bp	[rwx]{1,3}
 
-- 
1.7.1

Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ABD692C00AE
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 17:25:37 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 22 Jan 2013 23:25:34 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2F42B19D803E
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2013 23:25:32 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0N6PV8f291318
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2013 23:25:31 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0N6PTth030854
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2013 23:25:31 -0700
Date: Tue, 22 Jan 2013 22:25:29 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 4/6][v4]: perf/POWER7: Make some POWER7 events available in
 sysfs
Message-ID: <20130123062528.GE13720@us.ibm.com>
References: <20130123062201.GA13720@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130123062201.GA13720@us.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>, robert.richter@amd.com,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


[PATCH 4/6][v4]: perf/POWER7: Make some POWER7 events available in sysfs

Make some POWER7-specific perf events available in sysfs.

	$ /bin/ls -1 /sys/bus/event_source/devices/cpu/events/
	branch-instructions
	branch-misses
	cache-misses
	cache-references
	cpu-cycles
	instructions
	PM_BRU_FIN
	PM_BRU_MPRED
	PM_CMPLU_STALL
	PM_CYC
	PM_GCT_NOSLOT_CYC
	PM_INST_CMPL
	PM_LD_MISS_L1
	PM_LD_REF_L1
	stalled-cycles-backend
	stalled-cycles-frontend

where the 'PM_*' events are POWER specific and the others are the
generic events.

This will enable users to specify these events with their symbolic
names rather than with their raw code.

	perf stat -e 'cpu/PM_CYC' ...

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |    2 ++
 arch/powerpc/perf/power7-pmu.c               |   18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 3f21d89..b29fcc6 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -133,3 +133,5 @@ extern ssize_t power_events_sysfs_show(struct device *dev,
 #define	GENERIC_EVENT_ATTR(_name, _id)	EVENT_ATTR(_name, _id, _g)
 #define	GENERIC_EVENT_PTR(_id)		EVENT_PTR(_id, _g)
 
+#define	POWER_EVENT_ATTR(_name, _id)	EVENT_ATTR(PM_##_name, _id, _p)
+#define	POWER_EVENT_PTR(_id)		EVENT_PTR(_id, _p)
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index ae5d757..5627940 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -373,6 +373,15 @@ GENERIC_EVENT_ATTR(cache-misses,		LD_MISS_L1);
 GENERIC_EVENT_ATTR(branch-instructions,		BRU_FIN);
 GENERIC_EVENT_ATTR(branch-misses,		BRU_MPRED);
 
+POWER_EVENT_ATTR(CYC,				CYC);
+POWER_EVENT_ATTR(GCT_NOSLOT_CYC,		GCT_NOSLOT_CYC);
+POWER_EVENT_ATTR(CMPLU_STALL,			CMPLU_STALL);
+POWER_EVENT_ATTR(INST_CMPL,			INST_CMPL);
+POWER_EVENT_ATTR(LD_REF_L1,			LD_REF_L1);
+POWER_EVENT_ATTR(LD_MISS_L1,			LD_MISS_L1);
+POWER_EVENT_ATTR(BRU_FIN,			BRU_FIN)
+POWER_EVENT_ATTR(BRU_MPRED,			BRU_MPRED);
+
 static struct attribute *power7_events_attr[] = {
 	GENERIC_EVENT_PTR(CYC),
 	GENERIC_EVENT_PTR(GCT_NOSLOT_CYC),
@@ -382,6 +391,15 @@ static struct attribute *power7_events_attr[] = {
 	GENERIC_EVENT_PTR(LD_MISS_L1),
 	GENERIC_EVENT_PTR(BRU_FIN),
 	GENERIC_EVENT_PTR(BRU_MPRED),
+
+	POWER_EVENT_PTR(CYC),
+	POWER_EVENT_PTR(GCT_NOSLOT_CYC),
+	POWER_EVENT_PTR(CMPLU_STALL),
+	POWER_EVENT_PTR(INST_CMPL),
+	POWER_EVENT_PTR(LD_REF_L1),
+	POWER_EVENT_PTR(LD_MISS_L1),
+	POWER_EVENT_PTR(BRU_FIN),
+	POWER_EVENT_PTR(BRU_MPRED),
 	NULL
 };
 
-- 
1.7.1

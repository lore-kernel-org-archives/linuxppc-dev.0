Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynVz90YlKzDrq7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 19:33:08 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAU8WQd5120536
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 03:33:06 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eje6710rj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 03:33:06 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 30 Nov 2017 08:33:03 -0000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, maddy@linux.vnet.ibm.com,
 tglx@linutronix.de, kan.liang@intel.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Fix oops when grouping different pmu events
Date: Thu, 30 Nov 2017 14:03:22 +0530
Message-Id: <20171130083322.31206-1-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When user tries to group imc (In-Memory Collections) event with
normal event, (sometime) kernel crashes with following log:

    Faulting instruction address: 0x00000000
    [link register   ] c00000000010ce88 power_check_constraints+0x128/0x980
    ...
    c00000000010e238 power_pmu_event_init+0x268/0x6f0
    c0000000002dc60c perf_try_init_event+0xdc/0x1a0
    c0000000002dce88 perf_event_alloc+0x7b8/0xac0
    c0000000002e92e0 SyS_perf_event_open+0x530/0xda0
    c00000000000b004 system_call+0x38/0xe0

'event_base' field of 'struct hw_perf_event' is used as flags for
normal hw events and used as memory address for imc events. While
grouping these two types of events, collect_events() tries to
interpret imc 'event_base' as a flag, which causes a corruption
resulting in a crash.

Consider only those events which belongs to 'perf_hw_context' in
collect_events().

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 9e3da16..1538129 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1415,7 +1415,7 @@ static int collect_events(struct perf_event *group, int max_count,
 	int n = 0;
 	struct perf_event *event;
 
-	if (!is_software_event(group)) {
+	if (group->pmu->task_ctx_nr == perf_hw_context) {
 		if (n >= max_count)
 			return -1;
 		ctrs[n] = group;
@@ -1423,7 +1423,7 @@ static int collect_events(struct perf_event *group, int max_count,
 		events[n++] = group->hw.config;
 	}
 	list_for_each_entry(event, &group->sibling_list, group_entry) {
-		if (!is_software_event(event) &&
+		if (event->pmu->task_ctx_nr == perf_hw_context &&
 		    event->state != PERF_EVENT_STATE_OFF) {
 			if (n >= max_count)
 				return -1;
-- 
1.8.3.1

Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 521DC1A119D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 19:29:45 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 28 May 2015 14:59:42 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 65B15E0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 15:02:51 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4S9TdxR2163154
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 14:59:39 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4S8iCJZ019020
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 14:14:12 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH]perf/core: remove newline char in perf_event_sysfs_show
Date: Thu, 28 May 2015 14:59:26 +0530
Message-Id: <1432805366-15854-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When a event also carries a event.unit file, having newline char
will make perf userspace tool to print the event name in
the next line when dumping counter data.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1a3bf48..3b5a372 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8982,7 +8982,7 @@ ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
 		container_of(attr, struct perf_pmu_events_attr, attr);
 
 	if (pmu_attr->event_str)
-		return sprintf(page, "%s\n", pmu_attr->event_str);
+		return sprintf(page, "%s", pmu_attr->event_str);
 
 	return 0;
 }
-- 
1.9.1

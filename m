Return-Path: <linuxppc-dev+bounces-25599-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99370C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:42:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGn0z1Hwnz3cYK;
	Sat, 08 Aug 2026 00:42:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786113731;
	cv=none; b=gfU72r1G+fD5ZLj2hvTyzwqtKnFfJtYUKFz++0pvWGviPePiehxYLzkPqx2qGLbE+OloFbgQCafLQMqx6cEjYYPVyWY9I03miHA7loe0oaS5PjBX2R+7sTvBbtSEZsg74OVWYweXFnLHOPhtS96+4ZzZjzwyL4v3zkRXp7ltmxriCwJBiWnhiEcc2bd/LjX/tJ4YmqJekEARz+qcjpWEkBN2ZbfOmum0dMymbtdjbHv4kkUOXl9qSveBktcc9umAZuqTDlBnavSiEYkCvsMLD1hxfHE/3wEL1mhKFd+HVQeubzb2tVBie1HVqp6TH5Rytbals5mPx+zxlSncvTYsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786113731; c=relaxed/relaxed;
	bh=63dtIXsgy3rFxszaDJccHWJdsndg1SQghYACvBaUkDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NpLBJoC7k4eeL8yup+Le1ajZdr2G5ayLVv0yJ9LjIoKcMguq7eIPZoE3hEQxVm0M8Jiyk7PIdC6zGY+Y85b/ui2gPeBTiIzufKZYTH0yccXwqxCdXW5A77k/ejM5nosfJXxAwIzXzu/RiGEBVTUjA5P/3J1aOMtuO4DAKkGcAOP6f3e1q7lDnJccr8TM428HgezHYv1xFWQUue73oHG+DCW7dyUvpJ+CNdA6fBn/DsbagUlQWAczKjVnQBg+4l+qKgSMo5oFapOnaugtPloYkdo4s/1RgLxqziwNXYKlpKV0pWWaQYphGs6w+zeVM6XF5pjzFYnWWmQIarWoLYcAvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lLHHNcsw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lLHHNcsw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGn0y23x4z3cY7
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 00:42:10 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CmuUX1422043;
	Fri, 7 Aug 2026 14:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=63dtIXsgy3rFxszaD
	JccHWJdsndg1SQghYACvBaUkDM=; b=lLHHNcsw0Y9vBbbb1Wapx7u9ev1W4eOJt
	f8azVYvH1V8oVtFvp6LpoX+97x3NAvOdc/Oao826zSx4jdC8K6ZxoxToGlzezxF2
	z0TAxVF87f3fROs1/R56MTVljsWPleF1sAFB0FLrUTldJ2kmopaxQUlBf2UheE8I
	PVcTT5+yX0z0Z3sLvztpyAQBWc8QbbzlirlVV4yizM7wJnp3n4WUoKGOxuA5h2M8
	95iKEQYh6ri73irAooGVykeXXyJtW4BeOSJlBqfMRlRlHc0s+2sWRwDgoOVREAhX
	pXkf4dm6/cL2HK0yIlBey8njsJXE9pHsZeobLXrxFAxTpKxP/5g1g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy0247hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:42:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EfMsL027585;
	Fri, 7 Aug 2026 14:42:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kg33w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:42:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677EfxUa27263414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:41:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E62D20040;
	Fri,  7 Aug 2026 14:41:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C44E20043;
	Fri,  7 Aug 2026 14:41:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:41:55 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V5 4/6] tools/perf: Add powerpc callback support for arch_perf_record__need_read
Date: Fri,  7 Aug 2026 20:11:33 +0530
Message-Id: <20260807144135.2607-5-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260807144135.2607-1-atrajeev@linux.ibm.com>
References: <20260807144135.2607-1-atrajeev@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 8yhtSy0WS0bNB43mSvDVSLFFHE9OHaUx
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a75eebc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=71wvzhwaigeaYP0xXloA:9
X-Proofpoint-GUID: cztw89dxhNrkd3zxm0PtX_axROxWmi9q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX0LRnS1CU+IHB
 KuBU8XqmyuSa4wnTu/wAjUyJJVsOf8SCVu6cNDVDwxXsMhDuPkkVNVZVrOSqstnTFb3PoUw/jzF
 5ghV7TyX7C90PxeX8gIifT89VL4wRPvLxqSynbpQBnkQ4gX0QSMdLQ4Du+S1g5HDQ0KXWRC3SO+
 /nG9trbCjbY8sYEQPHBiiabf/wT68WJrL47tqW84hyNYA5DfG3Wz7BSB0BM1MolxIjtYOjSmRnI
 UQUUBlrnVg8N+it0E1yidxEQF0/ZIuzP4SVhzlzPNWY1Cg5vCpBh7H3zOOHGCidIVRwNhawWdFB
 UTmJb8xqPCPP7wuMJdjTgpfgN6GoOBSm2NoVrhOkcpN4t35pFJMvHRUec4GZfqJDcaxj1g80v/Q
 xEoWBV4e1BON8cOQqlwvLU/E/ffIQtOGw8oJDTuecgMzoJdoXebdB08+6qRgbbQvUCMDVO9Fy0R
 vjbHJAQRaAh5R3zTP/g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfXyll6+GWOUKuj
 APMZXHjxWmruisYppJhFp9XWXii0rKJynF0qB6nLgFxAJbIUxoKLYS/heORlO1ti4PwXYoyrUjt
 upAW8+cSjGrQw2zS5xLug73TK4tHxdQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070112

Implement the arch_perf_record__need_read() architecture-specific hook
for powerpc in arch/powerpc/util/evsel.c.

The HTM kernel driver sets event->count to the number of records still
staged in its internal buffers (total_size / record_size), and to 0
once the stream is exhausted.  This hook reads that count for every open
htm evsel via perf_evsel__read() and accumulates the values into
total_pending_records.  A non-zero total means at least one HTM target
still has records pending; the recording loop added in the previous
patch will perform another mmap-read pass.

The drain uses a two-layer safety check: event->count detects records
staged by the driver, and record__bytes_written() in the drain loop
confirms data was actually moved into perf.data.  This combination
handles the case where the driver count is briefly stale while hardware
is still flushing.

The implementation scans the evlist using evsel__pmu_name() to identify
HTM events by their kernel-assigned PMU name rather than the
user-visible event name, preventing false matches.  It iterates the fd/
sample-id xyarray, and skips any evsel whose fd and sample-id arrays are
mismatched to avoid reading stale state.  When the accumulated record
count reaches zero the hook returns 0 and the recording loop proceeds to
disable and close the events.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V5:
- When an HTM evsel is a group sibling (evsel->core.leader !=
  &evsel->core), read through its group leader's struct perf_evsel
  instead of the sibling directly.  perf_evsel__read_size() uses
  evsel->nr_members to compute the read buffer size; nr_members is 0
  for siblings, so size=0 is passed to readn(), which returns <=0 and
  leaves count.val=0, causing the drain loop to terminate prematurely.
  Reading through the leader avoids the zero-size buffer and correctly
  accumulates the leader's pending count.  HTM events are always
  standalone or per-target leaders in practice; the leader redirect
  handles any grouped configuration without losing counts.

Changes in V4:
- No changes from V3.

Changes in V3:
- Use evsel__pmu_name(evsel) instead of strstarts(evsel->name, "htm")
to identify HTM events, matching by kernel-assigned PMU name rather
than user-visible event name.
- Remove the redundant two-pass loop (first pass to set found_htm,
second to accumulate counts); a single pass with evsel__pmu_name()
is sufficient. if no HTM event exists total_pending_records stays 0
and the function returns 0.
- Remove the dead !strcmp(evsel->name, "dummy:u") check;
- evsel__pmu_name() will never return "htm" for a dummy:u software
event.
- Rename total_pending_bytes -> total_pending_records to match what
the driver actually reports (event->count = total_size / record_size,
a record count, not a byte count).
- Add #include <string.h> for musl compatibility (strcmp() without
it warns on some toolchains).

Changes in V2:
- Implements the renamed arch_perf_record__need_read() hook (V1
  implemented arch_record__collect_final_data()).
- Skips evsels whose fd and sample-id xyarrays are mismatched, avoiding
  stale-state reads.  V1 had no such guard.
- evlist__enable cycling is removed; that responsibility now belongs to
  the drain loop in builtin-record.c added in patch 3.
- File location changed to arch/powerpc/util/evsel.c (V1 used
  arch/powerpc/util/powerpc-htm.c).
- Patch is now 4/6 instead of 4/9.

 tools/perf/arch/powerpc/util/evsel.c | 77 ++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/evsel.c b/tools/perf/arch/powerpc/util/evsel.c
index 2f733cdc8dbb..2b7851c70677 100644
--- a/tools/perf/arch/powerpc/util/evsel.c
+++ b/tools/perf/arch/powerpc/util/evsel.c
@@ -1,8 +1,85 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <linux/string.h>
 #include "util/evsel.h"
+#include "util/record.h"
+#include "util/evlist.h"
+#include "util/debug.h"
+#include <internal/xyarray.h>
+#include <internal/lib.h>
 
 void arch_evsel__set_sample_weight(struct evsel *evsel)
 {
 	evsel__set_sample_bit(evsel, WEIGHT_STRUCT);
 }
+
+/*
+ * powerpc implementation of arch_perf_record__need_read().
+ *
+ * Reads event->count for every open HTM evsel by issuing a direct
+ * read() on the event fd with a plain u64 buffer, bypassing the
+ * PERF_FORMAT_GROUP path in perf_evsel__read().  When an HTM evsel is
+ * a group sibling, evsel__config() sets PERF_FORMAT_GROUP on its attr;
+ * perf_evsel__read() would then call perf_evsel__read_group() which
+ * sizes the buffer by evsel->nr_members (0 for siblings), causing the
+ * kernel to return -ENOSPC.  Reading the fd directly with sizeof(u64)
+ * retrieves the HTM driver's plain pending-record count regardless of
+ * group membership.
+ *
+ * Returns: 1 if more data exists, 0 if collection is complete
+ */
+int arch_perf_record__need_read(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	u64 total_pending_records = 0;
+	int x, y;
+
+	/* there was an error during record__open */
+	if (!evlist)
+		return 0;
+
+	/* Read HTM event counts to check if more data is available */
+	evlist__for_each_entry(evlist, evsel) {
+		struct perf_evsel *rd_evsel;
+		struct xyarray *xy;
+
+		if (strcmp(evsel__pmu_name(evsel), "htm"))
+			continue;
+
+		/*
+		 * For group siblings nr_members == 0, which makes
+		 * perf_evsel__read_size() return 0 and readn() fail.
+		 * Read through the leader instead; perf_evsel__read_group()
+		 * extracts the leader's own count from the group buffer.
+		 */
+		if (evsel->core.leader != &evsel->core)
+			rd_evsel = evsel->core.leader;
+		else
+			rd_evsel = &evsel->core;
+
+		xy = rd_evsel->sample_id;
+
+		if (xy == NULL || rd_evsel->fd == NULL)
+			continue;
+
+		if (xyarray__max_x(rd_evsel->fd) != xyarray__max_x(xy) ||
+		    xyarray__max_y(rd_evsel->fd) != xyarray__max_y(xy)) {
+			pr_debug("Unmatched FD vs sample ID array for HTM event\n");
+			continue;
+		}
+
+		for (x = 0; x < xyarray__max_x(xy); x++) {
+			for (y = 0; y < xyarray__max_y(xy); y++) {
+				struct perf_counts_values count = { .val = 0 };
+
+				if (perf_evsel__read(rd_evsel, x, y, &count) == 0)
+					total_pending_records += count.val;
+			}
+		}
+	}
+
+	/* Collection is complete only when ALL hardware queues have no pending records */
+	return (total_pending_records > 0) ? 1 : 0;
+}
-- 
2.53.0



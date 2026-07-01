Return-Path: <linuxppc-dev+bounces-23288-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E4DC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:42:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqtmB5ys7z2xPb;
	Wed, 01 Jul 2026 18:41:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895306;
	cv=none; b=jjKhFfE6YdY1qbSm41dBEJPhJubJ+MoWSicB2uXXUuuqURhhH29FFEGRkXzGRYDHdxDSgx+bdxzSdZsgrFnRTFiTaz7/NVSHtm3WSwwctNOCBByBp63UK18CCEdAX1CO6dpts+RyrVe42buZquRRy3VIzv2jc2elOZueTXbk/fHip60z0HHFjVt7v4GwuqsJKWUsjjMzJVQJyFkgT96ef3fT+NqJg4oBdsXbzGXEfswswzQCOuqhC2LNIIuF6dHHoRdX0jkP6Q3dCPR9MxufB3p9iOvCUS0qIEV34XmKIXByLGEDiypbK3T18c+ULzaQraVa3iOlfROG0TWpK/XGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895306; c=relaxed/relaxed;
	bh=R/hVg3BFva1j+uMZFurQaDTsfA8yM/HyeJDYhATtGpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5ax5RhDQZranpy8IFbDcMR85EaNzjcqGvgaJ31USwElfBbdgAJbdgDEaX9bFK+MK7MqEQTKDPtxD5xYNcAhTPd9f2Wiri9F/siBzQVy3lfVvx3GHlJPYM+Ejfr1YqkfcPDHeHM5dG/+SwSM2hXiQrJCEtDdNVp8ypjmrpsSsbqazntzSWiOOQ5kzDUVeQx8yhD2CFR3fyqlMlxh7t8IBki739SrN2m6sN/DaJiM7e2+67gLHPM4KztK+xao/XrrmLtHDEzqqwlYtG5Dvv9i/hnUovlzfZN39QlIbnpwESGrBas4iBDCPmCzmPqbMya+cCNiyFXTzcLM7KHOdLV9hA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ppR0uDYa; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ppR0uDYa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtmB13s1z2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:41:45 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618IBwm493301;
	Wed, 1 Jul 2026 08:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=R/hVg3BFva1j+uMZF
	urQaDTsfA8yM/HyeJDYhATtGpI=; b=ppR0uDYaFUjJZlE9vrTF1NfiqX5DPaIq7
	Jb+mk++Ch1As6wrhmXygcKmUdZYJJH3h5Sm80NWs0aQlTnKAr/z3t/56Ioa4Rl29
	mk9zhTo64wj5Tu39jAkWLUeSOWlycGbu1MB+uT5VfGFVEjkEhun078OfUEXxQ+Jj
	NGrqEPsE1WEmnsqCsbaw/f3dn/LyVYjVmufdo3TrenD09FLzv2ip615TDvvvucui
	XqzCvs+KU42QDLm5KuUQjk6kbD3Vntm/PywIAJXdJL8tinC3dXEH8Qxp0Wzg+vyz
	FEUW/II71b2WmfAFaFCvKUcAvaVmI+6nU0GAGSyLF7BBl8TWSkVPg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg3dv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618Yd0H000669;
	Wed, 1 Jul 2026 08:41:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhye6x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618fb7i54985042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:41:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D45932004D;
	Wed,  1 Jul 2026 08:41:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1192F20040;
	Wed,  1 Jul 2026 08:41:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:41:33 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com
Subject: [PATCH 4/9] tools/perf: Add powerpc callback support for arch_record__collect_final_data
Date: Wed,  1 Jul 2026 14:11:10 +0530
Message-Id: <20260701084115.80383-5-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260701084115.80383-1-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a44d2c6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1h1E0ngRdhXPlPQLIiAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX9RLZT0rN8aWT
 At3cxQ9x5K1zVqVhGe2tcHO3Q1W7f+85Gx8lOw57DX+JpJvA2GjUEBdJtjcOSjR/gqn6OvMrs5/
 xbe8oM76tDJV+08IJYhcQd6VH8gEI4A=
X-Proofpoint-GUID: 2L6QUMFHQ5HVDHbja6tTiDoeQfWh6FjR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX07m6uygzX7rB
 Zg122UYcXuuO6/bNMejJ/O9pGuObmNuwHN8lPZ18HmXWbleAtDCJY7uzUBeXYLJ7pa0zeVm+0IF
 p9JEzNxQcAiUCAzmdLIxYL9ONjIiNHutrKUOvfXBqR+0aQGvz4N4R3OWt+zYc4Ifb1ZfD1xVRcZ
 ce6MDBV8S9A5jjswuaHt3jAeeZe1XtVi3b48E8bm9AJ7o89HN0HzWfuaSTbn2qf+Up0FccTmibM
 T26YcJ7mt+pdF9U6DhQpOz1aVrf1ozsxVURFz+mrOHB412GDGCq2UJwy7sDeGd9QWLJI8jWyd0k
 tbtYYJU3+4KGZFbjpnKWv1b9yjsivBfW4pRlaqxHHYL5PgHns6TwMvsfpru1DlvfvgSApOP2VQd
 WdadIFI/zZg7Q5j2HG7q5J4hVFpKfME/rotWWoMi+1GPc8K6FCX4mlifUeJoq9PSrsIFiyVSjr3
 73lZy+HdA1ioRVZP30w==
X-Proofpoint-ORIG-GUID: m-UT0SwGY_qmPQdKVfTe7sN-cm9ATVw_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

Add arch_record__collect_final_data to collect additional
data before closing the event. Define the callback in
util/powerpc-htm.c

Invoke record__mmap_read_all till the complete trace
data is collected in auxtrace buffer and copied to
perf.data . When the auxtrace buffer is full, perf_aux_output_end
will disable the event till data is written. Hence enable
the event using evlist__enable after reading event using
htm_read_data function. The perf_evsel__read returns zero, when
the trace data is completely read and completed. If the count
returns zero for the event, stop the data collection.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/util/Build         |  1 +
 tools/perf/util/powerpc-htm.c | 74 +++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/perf/util/powerpc-htm.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 330311cac550..7fa354853d2a 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -141,6 +141,7 @@ perf-util-y += hisi-ptt.o
 perf-util-y += hisi-ptt-decoder/
 perf-util-y += s390-cpumsf.o
 perf-util-y += powerpc-vpadtl.o
+perf-util-y += powerpc-htm.o
 
 ifdef CONFIG_LIBOPENCSD
 perf-util-y += cs-etm.o
diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
new file mode 100644
index 000000000000..5043ff41a609
--- /dev/null
+++ b/tools/perf/util/powerpc-htm.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HTM support
+ */
+
+#include "../../../util/record.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "session.h"
+#include "debug.h"
+#include <internal/xyarray.h>
+
+/*
+ * Check if HTM events have more data to collect.
+ *
+ * This function reads the HTM event counts. When the kernel driver
+ * has more data available, it returns a non-zero count. When all
+ * data has been collected, it returns zero.
+ *
+ * Returns: 1 if more data exists, 0 if collection is complete
+ */
+int arch_perf_record__need_read(struct evlist *evlist)
+{
+	struct evsel *evsel;
+	int found_htm = 0;
+
+	/* there was an error during record__open */
+	if (!evlist)
+		return 0;
+
+	/* First, check if any HTM events exist */
+	evlist__for_each_entry(evlist, evsel) {
+		if (strstr(evsel->name, "htm") != NULL)
+			found_htm = 1;
+	}
+
+	if (!found_htm)
+		return 0;
+
+	/* Read HTM event counts to check if more data is available */
+	evlist__for_each_entry(evlist, evsel) {
+		struct xyarray *xy = evsel->core.sample_id;
+
+		if (strstr(evsel->name, "htm") == NULL)
+			continue;
+
+		if (xy == NULL || evsel->core.fd == NULL)
+			continue;
+		if (xyarray__max_x(evsel->core.fd) != xyarray__max_x(xy) ||
+			xyarray__max_y(evsel->core.fd) != xyarray__max_y(xy)) {
+			pr_debug("Unmatched FD vs. sample ID: skip reading LOST count\n");
+			continue;
+		}
+
+		for (int x = 0; x < xyarray__max_x(xy); x++) {
+			for (int y = 0; y < xyarray__max_y(xy); y++) {
+				struct perf_counts_values count;
+
+				if (!strcmp(evsel->name, "dummy:u"))
+					continue;
+
+				if (strstr(evsel->name, "htm")) {
+					perf_evsel__read(&evsel->core, x, y, &count);
+					y = xyarray__max_y(xy);
+					x = xyarray__max_x(xy);
+				}
+				if (!count.val)
+					return 0;
+			}
+		}
+	}
+
+	return 1;
+}
-- 
2.52.0



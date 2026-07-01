Return-Path: <linuxppc-dev+bounces-23285-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065F5C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:41:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqtm329DKz2yhv;
	Wed, 01 Jul 2026 18:41:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895299;
	cv=none; b=L+WF5E4D5LYXLNt3KJh92DDT80QSwzVDX7T2zaEkS8LSrw6NjDQHpC1xCvtTSe81vztf872ArOjb3FU8HO3SS8iVgK2Aix7ebxVHL/pBGo8S45LwKZ69TLlKCUxmDqgC2mgOd8BVjYNjQP5mimQes5+3yA7htlelOuiksAc6XvbknZ+K3qbF3TW+njG/+GKAbUyeCOoce6I+KEBWUb7tSivqO4mlcdsn2oYyxdS6ziWV9y5U74W/cx+t7z/rKEcGnzh1CGPIpfK90pnEtyDwKaB/NquS7FBDPn2umHVdJxQ1y6sNORDdi/+4NQRXyg9J1dtnFzGfhQYkLy17K+9QVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895299; c=relaxed/relaxed;
	bh=VtvW3YTEt9qQduYIzeeSEU+b2M1fRiRrVGC8ufc9h/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=osNqC6ZE42VTEQ4J/jDe3t98AOtVqh97sBX//lJalUNWfNfe3d3UUiC5vwEB82VXzaAkMjzWc9CsRPSuKxuJPFuAqXTlnXPYpxj9D8adtRbO0z14r8IYaA+CmZa4n4X3mRkEwGkuWedDfcGvC32ZuM6gxcWO2Y/C+ZuA4dP89f27TdLblUCtnvQKpqRqSpcfJxWS2ksCAVLPnPS9X9FpKso5zByFkGAQxrTvKSoeSGpVrFR9/GaW064m3RJK0LDDxDfoGgukp4sJzYOhjq+cGhe/F71Hu3MylayLJhAzNMBPfc44bNhh8M4Z3kXlwfzsqyscs8IeO0qtwemETVkKYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S0/j8okc; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S0/j8okc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtm24GKzz2yQG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:41:38 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618IXL7299059;
	Wed, 1 Jul 2026 08:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VtvW3YTEt9qQduYIz
	eeSEU+b2M1fRiRrVGC8ufc9h/Q=; b=S0/j8okc31tfMwzwn92T7qb5ypIgrwhIs
	x6ZiLWec7C2Fuy9QFZKZesuJBw6GPBjm1o3ItJE5DJ+0ulV20pVD40+tUhsb2stz
	q/6YQTWrBCUV0zv6sSEOizf8jT6dcJk0IcBfZiJ0tRmEebureJ5Ja3589FfcN9ao
	/OMjdeF/xi1lPHiME6Ais2i4xRdO/KXUG+5/gBYHuKUMifmAP3abse6gx6JlLnSl
	0MWuqLNgpld0m5SP1Mtho2Ti70UK59C+kwvKF2ZiQMjVcxpr827CJddDOj0xe2fL
	AX/ocG5Km962HbPkD32aUe2H72lpsxe4HJSp/HJdU2pMpo7t/Ezxg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5ufmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618YcSP001241;
	Wed, 1 Jul 2026 08:41:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhecg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:41:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618fT6B43581786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:41:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C590720043;
	Wed,  1 Jul 2026 08:41:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7203420040;
	Wed,  1 Jul 2026 08:41:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:41:26 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com
Subject: [PATCH 2/9] tools/perf: Add CONFIG_AUXTRACE support for HTM pmu on powerpc
Date: Wed,  1 Jul 2026 14:11:08 +0530
Message-Id: <20260701084115.80383-3-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX9t56i95xohle
 zrC+02Et83XYZDJ2mHEWfYX+1ndFDoNoId+xILCyL1F7li9uAb0HFkJ8TEqJlhVy/p8yRQxatw7
 h3airV6eSZTDveVNEjSOzB+NOVAcxITPMgwxGYSZu6+51qM0eBGW5GlK5NGdsNtQd2UVNn6eAfp
 MAzdPHkuOkCpHyYCENZAapOps/2TWukLEOvs+AiBEIPeRx+cGD6q6tamPHRrqTirBJqcmZzINiy
 iiRDcdzbbP+RMmaxZuyjqvlRL5whet7F6pmhvEAVMA4dk2EGUiXT6ug4QT/X0/71yUjCZ7XM+8M
 kF8/RNouWHYLUPQ6J+/fnU8vdiHdXctJTj079jg6Dz+PbERyT8n5B9dJQbzgGQQouSmo4d4qAZ9
 T5WA0VdJXR5uPoYxbTNACfc7xyQ0CcuAWC4g+AU/8+XH2psY2j7IaAeerzwrKljgCvTp4sHomOL
 ZOUMx7I7ValO5NWjlLg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a44d2bf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=f_hrB--NwkKjYsyAjoUA:9
X-Proofpoint-ORIG-GUID: 9X9U4YftbR8k2ssNeWkyezIz3t7TYL6L
X-Proofpoint-GUID: Qsd7mo6NZ55uDZkVh2gX-HfpD5ZhZY8c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX5hKdgJUKp74i
 yDmv8Iq3etHFuKtsjEEAceyGlIKYITdf3Aak3bgWnlQypRkkjO5Ea1A6i5lsmbwF0enGgXliz0a
 usGLqb4E0rFCH7QFMZIp5lwSdPqRT50=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

The powerpc PMU collecting Hardware Trace Macro (HTM) entries makes use of
AUX support in perf infrastructure. The PMU driver has the functionality
to collect trace entries in the aux buffer. On the tools side, this data
is made available as PERF_RECORD_AUXTRACE records. This record is
generated by "perf record" command. To enable the creation of
PERF_RECORD_AUXTRACE, add functions to initialize auxtrace records ie
"htm_recording_init()". Fill in fields for other callbacks like
info_priv_size, info_fill, free, recording options etc. Add header file
to define htm pmu specific details.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 tools/perf/arch/powerpc/util/Build      |   1 +
 tools/perf/arch/powerpc/util/auxtrace.c |  10 ++-
 tools/perf/arch/powerpc/util/htm.c      | 113 ++++++++++++++++++++++++
 tools/perf/util/powerpc-htm.h           |  23 +++++
 4 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/arch/powerpc/util/htm.c
 create mode 100644 tools/perf/util/powerpc-htm.h

diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 7819c8f5af2d..297152591046 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -8,3 +8,4 @@ perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
 
 perf-util-y += auxtrace.o
 perf-util-y += vpa-dtl.o
+perf-util-y += htm.o
diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
index 0053526329e0..ec84f8876a4a 100644
--- a/tools/perf/arch/powerpc/util/auxtrace.c
+++ b/tools/perf/arch/powerpc/util/auxtrace.c
@@ -12,6 +12,7 @@
 #include "../../util/debug.h"
 #include "../../util/auxtrace.h"
 #include "../../util/powerpc-vpadtl.h"
+#include "../../util/powerpc-htm.h"
 #include "../../util/record.h"
 
 struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
@@ -19,6 +20,7 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 {
 	struct evsel *pos;
 	int found_vpa_dtl = 0;
+	int found_htm = 0;
 
 	/*
 	 * Set err value to zero here. Any fail later
@@ -31,13 +33,19 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 			found_vpa_dtl = 1;
 			pos->needs_auxtrace_mmap = true;
 			break;
+		} else if (strstarts(pos->name, "htm")) {
+			found_htm = 1;
+			pos->needs_auxtrace_mmap = true;
+			break;
 		}
 	}
 
 	if (found_vpa_dtl)
 		return vpa_dtl_recording_init(pos);
+	else if (found_htm)
+		return htm_recording_init(pos);
 	else {
-		*err = -EINVAL;
+		*err = 0;
 		return NULL;
 	}
 }
diff --git a/tools/perf/arch/powerpc/util/htm.c b/tools/perf/arch/powerpc/util/htm.c
new file mode 100644
index 000000000000..cc733f45ac9b
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/htm.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HTM support
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/log2.h>
+#include <linux/string.h>
+#include <time.h>
+
+#include "../../util/cpumap.h"
+#include "../../util/evsel.h"
+#include "../../util/evlist.h"
+#include "../../util/session.h"
+#include "../../util/util.h"
+#include "../../util/pmu.h"
+#include "../../util/debug.h"
+#include "../../util/auxtrace.h"
+#include "../../util/powerpc-htm.h"
+#include "../../util/record.h"
+#include <internal/lib.h> // page_size
+#include <errno.h>
+
+#define KiB(x) ((x) * 1024)
+
+static int
+htm_recording_options(struct auxtrace_record *ar __maybe_unused,
+			struct evlist *evlist __maybe_unused,
+			struct record_opts *opts)
+{
+	struct evsel *pos;
+
+	opts->full_auxtrace = true;
+
+	if (opts->target.system_wide) {
+		pr_info("System wide monitoring not supported, specify -C <cpu>\n");
+		return -EINVAL;
+	} else if (!opts->target.cpu_list) {
+		pr_info("-C option not provided, specify -C <cpu> to use HTM event\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Set auxtrace_mmap_pages to minimum
+	 * two pages
+	 */
+	if (!opts->auxtrace_mmap_pages) {
+		opts->auxtrace_mmap_pages = KiB(128) / page_size;
+		if (opts->mmap_pages == UINT_MAX)
+			opts->mmap_pages = KiB(256) / page_size;
+	}
+
+	evlist__for_each_entry(evlist, pos) {
+		if (strstarts(pos->name, "htm")) {
+			pos->needs_auxtrace_mmap = true;
+			pos->core.attr.aux_watermark = opts->auxtrace_mmap_pages * (size_t)page_size;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static size_t htm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+					struct evlist *evlist __maybe_unused)
+{
+	return HTM_AUXTRACE_PRIV_SIZE;
+}
+
+static int
+htm_info_fill(struct auxtrace_record *itr __maybe_unused,
+		struct perf_session *session __maybe_unused,
+		struct perf_record_auxtrace_info *auxtrace_info __maybe_unused,
+		size_t priv_size __maybe_unused)
+{
+	return 0;
+}
+
+static u64 htm_reference(struct auxtrace_record *itr __maybe_unused)
+{
+	return 0;
+}
+
+static void htm_free(struct auxtrace_record *itr)
+{
+	free(itr);
+}
+
+struct auxtrace_record *htm_recording_init(struct evsel *pos)
+{
+	struct auxtrace_record *aux;
+
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
+	 * must come first.
+	 */
+	evlist__to_front(pos->evlist, pos);
+
+	aux = zalloc(sizeof(*aux));
+	if (aux == NULL) {
+		pr_debug("aux record is NULL\n");
+		return NULL;
+	}
+
+	aux->recording_options = htm_recording_options;
+	aux->info_priv_size = htm_info_priv_size;
+	aux->info_fill = htm_info_fill;
+	aux->free = htm_free;
+	aux->reference = htm_reference;
+	return aux;
+}
diff --git a/tools/perf/util/powerpc-htm.h b/tools/perf/util/powerpc-htm.h
new file mode 100644
index 000000000000..be7f8c03e161
--- /dev/null
+++ b/tools/perf/util/powerpc-htm.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * HTM PMU Support
+ */
+
+#ifndef INCLUDE__PERF_POWERPC_HTM_H__
+#define INCLUDE__PERF_POWERPC_HTM_H__
+
+#define POWERPC_HTM_NAME "powerpc_htm_"
+
+enum {
+	POWERPC_HTM_TYPE,
+	HTM_AUXTRACE_PRIV_MAX,
+};
+
+#define HTM_AUXTRACE_PRIV_SIZE (HTM_AUXTRACE_PRIV_MAX * sizeof(u64))
+
+union perf_event;
+struct perf_session;
+struct perf_pmu;
+
+struct auxtrace_record *htm_recording_init(struct evsel *pos);
+#endif
-- 
2.52.0



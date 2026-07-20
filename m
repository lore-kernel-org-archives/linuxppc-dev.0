Return-Path: <linuxppc-dev+bounces-24478-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19543C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 11:04:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3d1p0gs2z2yYY;
	Mon, 20 Jul 2026 21:04:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784545453;
	cv=none; b=loNHqX0Ugur0tb+JsgX4ZuacjgatbRFLnZoOzDoPtz+5tFqIWC69aVhMwI81ovtPsE/oI8L6k5sCGgMs9Kpaq2nOx2hkbORwF7tQUOe6bUQbbmX8oQmivzmdM5rh9jCFRfx0wS6y/STCwkTtpLp0AQ0f+wSAq0GaN9P2hRet26qE0/fEStOL1Vn9E7Mw+lbfeBiKEW/w3Y7ZgCjXeLjhUBOzwcfuGW3+orzQ3YBep5kG6ljNy/JpBGkUcsWeHgQt+L35ZSC9JRMnB+BCtHDzeGYuZyvYgHmyyB8Nsitj1t/i/G9hpJiNXoj86fcqqAMgJIJ0JLFj0b6ItkEzYlwTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784545453; c=relaxed/relaxed;
	bh=wjHXq326BZVZ7WsGpNt4gCegdC28/0h9RwFjJtnp7A0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jcsg/HDb3azPecujDlGJMdk8n2tr2uS4kLJW17GyTR9BUtVeish1KMX27dsB+xKnTKH2g9x8yZxbFb6o8pK0JlS18GczjjgtfIKcHzcz8pMMI9BVHtFRNC1gsuqFjPgf3vyLK8Kpb5X2HpoRcVU7y5sM/tAj64MNziYFqLhwEXGRKvJdOiiuDT8cia16WHMQOACJXDjTno3djzJndEqH0HHbl9xfF7i00MEl9I5LO0P4Qtc35WEPQ/t7m09Tv5q0oVmn2IZPPHnwi2r8PsWlMADHfyVUrcPIgK3yhZbS57IJ9Ki1AlpwvZj6B8rTI67ZDPETwxsFHd4BDJflrrw7/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wp9Nozcz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wp9Nozcz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3d1n1dlzz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 21:04:12 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABZYt026423;
	Mon, 20 Jul 2026 11:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wjHXq326BZVZ7WsGp
	Nt4gCegdC28/0h9RwFjJtnp7A0=; b=Wp9NozczEcRHqWwbOF9OIqDQ5OeAdGIY9
	9iz1JUN+JBVCPlYihUgl0ZYDm4zRHuRjg3C6+f55mAiHDAVo1Jg9khCYeK5ImP0e
	UM9BSArSZHJzPNla7ds59vfxepR+SGvrWl6srLc8FdKIlDwOeH/zVt+6NU9tDSvd
	xmzKX74TTRO37W4+scDiKIcGdZLAGuImfINZy4kU+oVK49Ya3z8IvlMt4viKjs56
	Ea126WlST+AiYoR2uq8HDeN9hUy3WuqqbkMx/wv8nX8lueJZubIuWPnZvHXXAdsO
	ojADCiDLIEo6DAZSLiYJ0+tYa3lThM9sPr0mwlrdC2Pm7OECydAuQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77a731p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAnmwh009668;
	Mon, 20 Jul 2026 11:04:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy4yr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KB44Ts41025914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 11:04:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 786DA20040;
	Mon, 20 Jul 2026 11:04:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2705820043;
	Mon, 20 Jul 2026 11:04:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 11:04:00 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V2 1/6] tools/perf: Move powerpc VPA-DTL auxtrace init into a separate file
Date: Mon, 20 Jul 2026 16:22:13 +0530
Message-Id: <20260720105218.14277-2-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260720105218.14277-1-atrajeev@linux.ibm.com>
References: <20260720105218.14277-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: hOH7O4QIXNN69SO5GUKjCvklRhcQ90SK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfXwtEFEceJYzj+
 pVR2UFgfa9hAEPSn9N1Jchzy4JpEmToOKwyhpthkqVsbTmHfGmJ/P+mxbNijuUQBQLqTBWeIn8P
 UmQ3E6/VY0ep/ZhAuvRgifSF4nfrmJ0=
X-Proofpoint-GUID: HodnxdbkklGz034dZZboGJgZFLCvTLLJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX1HqQCUbmPPip
 dz0l6rAj6YgeBhLxm9mHU9FFkOkmDgO1jwnPeaNDJC2AIOCUkGwIDKmfihKU7j/GX7v2kmDtzWJ
 Ig4l9RvY7pdrh08nJd3LHZal6rqwsZ3HR1gUoDmybFBTXBGp/j5AKIqlew8BgUk323YWieDKzPM
 rQSX8jlbXobgdGE8bqsgrMAja8yI/1D6NmPS/O7octoJ8/xe2bIVrSMEfOHh3SEfKnaBx8lTcQ0
 dqmOMg1qrPxCshOlamjfy66+ypJ2s2nfirYvR0IeqxqEqzEmOm6hads4iX8fmiVUp7yuG1Yc19W
 Kq6B430B0rDhVh0mttUysMZkBYxohu4+iFl7IdCgUoa6F0zxbmV3T+Y5Vgygw1RYSfSOJtoT1Z2
 IwDXoDU5g7O96R/th1RDtOZcHtSrOQYT4VIchWfzcIMo/TqnYq7lKe+FUtVNVErpQg64TjrEj+n
 s+BP5w77n6DeaAa2HMg==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5e00a9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=MVjHk6Situ9G2c-KtHgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200119

The powerpc auxtrace dispatch lives entirely in
arch/powerpc/util/auxtrace.c.  As new PMUs such as HTM are added, this
file would grow to contain the recording logic for all of them.

Factor out the VPA-DTL recording initializer into its own file,
arch/powerpc/util/vpa-dtl.c, and reduce auxtrace.c to a thin dispatch
layer.  auxtrace_record__init() now detects the PMU by name and calls
the appropriate per-PMU init function:

  - vpa_dtl_recording_init() for VPA-DTL events (unchanged behaviour)
  - Further PMU entries will follow in subsequent patches

This makes room in auxtrace_record__init() for the HTM recording path
added in the next patch without growing a single monolithic file.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V2:
- Renamed the destination file from arch/powerpc/util/vpa-dtl.c (same
  name, unchanged) but the subject and commit message are reworded to
  clearly state that the goal is to make auxtrace_record__init() a thin
  per-PMU dispatcher, not merely to "allow multiple PMUs to use auxtrace".
- Handle failure from memory allocation
- Included stdlib and limits.h
- No functional change to the VPA-DTL path itself.
- Patch is now 1/6 instead of 1/9.

 tools/perf/arch/powerpc/util/Build      |  1 +
 tools/perf/arch/powerpc/util/auxtrace.c | 84 +++-------------------
 tools/perf/arch/powerpc/util/vpa-dtl.c  | 95 +++++++++++++++++++++++++
 tools/perf/util/powerpc-vpadtl.h        |  1 +
 4 files changed, 105 insertions(+), 76 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/vpa-dtl.c

diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index ae928050e07a..7819c8f5af2d 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -7,3 +7,4 @@ perf-util-y += evsel.o
 perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
 
 perf-util-y += auxtrace.o
+perf-util-y += vpa-dtl.o
diff --git a/tools/perf/arch/powerpc/util/auxtrace.c b/tools/perf/arch/powerpc/util/auxtrace.c
index 4600a1661b4f..e04a0bd61755 100644
--- a/tools/perf/arch/powerpc/util/auxtrace.c
+++ b/tools/perf/arch/powerpc/util/auxtrace.c
@@ -13,63 +13,12 @@
 #include "../../util/auxtrace.h"
 #include "../../util/powerpc-vpadtl.h"
 #include "../../util/record.h"
-#include <internal/lib.h> // page_size
-
-#define KiB(x) ((x) * 1024)
-
-static int
-powerpc_vpadtl_recording_options(struct auxtrace_record *ar __maybe_unused,
-			struct evlist *evlist __maybe_unused,
-			struct record_opts *opts)
-{
-	opts->full_auxtrace = true;
-
-	/*
-	 * Set auxtrace_mmap_pages to minimum
-	 * two pages
-	 */
-	if (!opts->auxtrace_mmap_pages) {
-		opts->auxtrace_mmap_pages = KiB(128) / page_size;
-		if (opts->mmap_pages == UINT_MAX)
-			opts->mmap_pages = KiB(256) / page_size;
-	}
-
-	return 0;
-}
-
-static size_t powerpc_vpadtl_info_priv_size(struct auxtrace_record *itr __maybe_unused,
-					struct evlist *evlist __maybe_unused)
-{
-	return VPADTL_AUXTRACE_PRIV_SIZE;
-}
-
-static int
-powerpc_vpadtl_info_fill(struct auxtrace_record *itr __maybe_unused,
-		struct perf_session *session __maybe_unused,
-		struct perf_record_auxtrace_info *auxtrace_info,
-		size_t priv_size __maybe_unused)
-{
-	auxtrace_info->type = PERF_AUXTRACE_VPA_DTL;
-
-	return 0;
-}
-
-static void powerpc_vpadtl_free(struct auxtrace_record *itr)
-{
-	free(itr);
-}
-
-static u64 powerpc_vpadtl_reference(struct auxtrace_record *itr __maybe_unused)
-{
-	return 0;
-}
 
 struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 						int *err)
 {
-	struct auxtrace_record *aux;
 	struct evsel *pos;
-	int found = 0;
+	struct evsel *vpa_dtl_evsel = NULL;
 
 	/*
 	 * Set err value to zero here. Any fail later
@@ -78,33 +27,16 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 	*err = 0;
 
 	evlist__for_each_entry(evlist, pos) {
-		if (strstarts(pos->name, "vpa_dtl")) {
-			found = 1;
+		if (pos->name && strstarts(pos->name, "vpa_dtl")) {
 			pos->needs_auxtrace_mmap = true;
-			break;
+			/* Remember the first matching VPA DTL event */
+			if (!vpa_dtl_evsel)
+				vpa_dtl_evsel = pos;
 		}
 	}
 
-	if (!found)
-		return NULL;
-
-	/*
-	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
-	 * must come first.
-	 */
-	evlist__to_front(pos->evlist, pos);
-
-	aux = zalloc(sizeof(*aux));
-	if (aux == NULL) {
-		pr_debug("aux record is NULL\n");
-		*err = -ENOMEM;
-		return NULL;
-	}
+	if (vpa_dtl_evsel)
+		return vpa_dtl_recording_init(vpa_dtl_evsel, err);
 
-	aux->recording_options = powerpc_vpadtl_recording_options;
-	aux->info_priv_size = powerpc_vpadtl_info_priv_size;
-	aux->info_fill = powerpc_vpadtl_info_fill;
-	aux->free = powerpc_vpadtl_free;
-	aux->reference = powerpc_vpadtl_reference;
-	return aux;
+	return NULL;
 }
diff --git a/tools/perf/arch/powerpc/util/vpa-dtl.c b/tools/perf/arch/powerpc/util/vpa-dtl.c
new file mode 100644
index 000000000000..fde388d87477
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/vpa-dtl.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * VPA DTL AUX tracing support
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <limits.h>
+#include "../../util/cpumap.h"
+#include "../../util/evsel.h"
+#include "../../util/evlist.h"
+#include "../../util/session.h"
+#include "../../util/util.h"
+#include "../../util/debug.h"
+#include "../../util/auxtrace.h"
+#include "../../util/powerpc-vpadtl.h"
+#include "../../util/record.h"
+#include <internal/lib.h> // page_size
+
+#define KiB(x) ((x) * 1024)
+
+static int
+powerpc_vpadtl_recording_options(struct auxtrace_record *ar __maybe_unused,
+			struct evlist *evlist __maybe_unused,
+			struct record_opts *opts)
+{
+	opts->full_auxtrace = true;
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
+	return 0;
+}
+
+static size_t powerpc_vpadtl_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+					struct evlist *evlist __maybe_unused)
+{
+	return VPADTL_AUXTRACE_PRIV_SIZE;
+}
+
+static int
+powerpc_vpadtl_info_fill(struct auxtrace_record *itr __maybe_unused,
+		struct perf_session *session __maybe_unused,
+		struct perf_record_auxtrace_info *auxtrace_info,
+		size_t priv_size __maybe_unused)
+{
+	auxtrace_info->type = PERF_AUXTRACE_VPA_DTL;
+
+	return 0;
+}
+
+static void powerpc_vpadtl_free(struct auxtrace_record *itr)
+{
+	free(itr);
+}
+
+static u64 powerpc_vpadtl_reference(struct auxtrace_record *itr __maybe_unused)
+{
+	return 0;
+}
+
+struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos, int *err)
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
+		pr_debug("aux record allocation failed (-ENOMEM)\n");
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	aux->recording_options = powerpc_vpadtl_recording_options;
+	aux->info_priv_size = powerpc_vpadtl_info_priv_size;
+	aux->info_fill = powerpc_vpadtl_info_fill;
+	aux->free = powerpc_vpadtl_free;
+	aux->reference = powerpc_vpadtl_reference;
+	return aux;
+}
diff --git a/tools/perf/util/powerpc-vpadtl.h b/tools/perf/util/powerpc-vpadtl.h
index ca809660b9bb..41e09b17a353 100644
--- a/tools/perf/util/powerpc-vpadtl.h
+++ b/tools/perf/util/powerpc-vpadtl.h
@@ -20,4 +20,5 @@ struct perf_pmu;
 int powerpc_vpadtl_process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 
+struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos, int *err);
 #endif
-- 
2.43.0



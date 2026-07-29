Return-Path: <linuxppc-dev+bounces-25008-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749FAC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 12:44:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9BqD1Xb0z2yqP;
	Wed, 29 Jul 2026 22:44:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785329064;
	cv=none; b=cQDDRbmcrukrhDMo25g/2VMeyXCgpslzqerD4zQh3DdrkPg+6pTn73YcQTW9X3tyi4mNTcT7+1ldafYO1ZOIpCEprET/lXu2rV99eDUpVTGuo+XVt1DwhCWhvhJRK7/+oSdWoYAyKvznszwtXUzlTGJqaoCY0QiqRxDcYM7qKdR+36Ov7W56kbV6sx+9ZAjlpmkdcl1Yk3PrINudc+C9laU/3wAn9dI2P6nBdBbUuKlY3BH90rfrHL67Ji2EQgM4HQU7MCqfi9tRtBkUBjRmYTg6nb+KD5KGcP/S/x4tHFjC3t2eHXEyt99KWh0K0XrDSw7h7vv0T9yPXnnyPmv1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785329064; c=relaxed/relaxed;
	bh=4pWCId6B+KmmOP+72E8DoFhHIod+LTKaTs3/zXTzVWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ayrz/i6ppmKQ/4MgN6UfVbTi54xOL8UhdyuT69oAbdVCjhcAn/WD38+PJnd49z4kL3S+oB2muo265uylQisVu/5NxvF9nZTiB5rIEEpXi5+D8jjof8vXZKTYoDMh97FUswl7JVyGEfclv6q1JQoz0OSBb/lKE80L2bcoyX0ybXcw2t4XXTawG7OFBBLz5m5omi13MUeizNWLjF9jznZQRjaHEUHzh/nkSzJ3/QgNIFl61NFcDZsHGQVuWMwXAe1LLO6k1owfb+ltv3lVVuTeWZH0lLA6ybQcfagZgV2YKAjAx9hB62i3k419ypwM10f54+mtZTVCEzRGqj4UENvXow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Sv4B5az/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Sv4B5az/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9BqC0G1Bz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 22:44:22 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBISFx2165879;
	Wed, 29 Jul 2026 12:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4pWCId6B+KmmOP+72
	E8DoFhHIod+LTKaTs3/zXTzVWc=; b=Sv4B5az/4FFPZQWgHjz0rq8eNXa9shbbt
	jNis18bB0BHkXanRGusXVnOi1YC+JSurxHUqxqXV7pLzjj9J0XpcqIKu12I8rmaT
	TRv2OsIrmJYG6zj8HmLfoRs0PD61uBOVF6vlYtcYFUEJMtDFzJd1FvZ3STSTVTr9
	frBV5RDIclI17NTYlCnSifdoDmWPuanLbfkFLBBvm2yMv+kywTtvkOP6StUdgT5+
	ZxcST/mvzZ6bpgqK79/LdlzVwGHVUMGMfijZqvlDRaJ2bBHdWavkr03g0SvVwfnb
	tJTKBAGEH2wzT3YD78xVvGNzTnjs4vqFE/CrN0k83s5qYhRiw6FQg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycjmb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:44:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCfQRv027181;
	Wed, 29 Jul 2026 12:44:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw6u4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:44:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCiDUL36241762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:44:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61DD520043;
	Wed, 29 Jul 2026 12:44:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9CC720040;
	Wed, 29 Jul 2026 12:44:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 12:44:09 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V4 2/6] tools/perf: Add AUXTRACE recording support for powerpc HTM
Date: Wed, 29 Jul 2026 18:13:56 +0530
Message-Id: <20260729124400.65009-3-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260729124400.65009-1-atrajeev@linux.ibm.com>
References: <20260729124400.65009-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Mw4seqrCxRCWvtakDW03E3qRSqX1XqiH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX1p78WkfrznwW
 acIp9TQfiRPZjch8BRzR61SMwYnuWMLRkMH94y60pSKLWwMctFPsgWfwFCTJ35GLEcVucUbkft9
 2SlMBqbuBnmFaXjGSqtyXrNaHVRCNySzPNkkiIj2cCLHnDgiH2w1wmi3Xw7aJonq6i9vKAAdh9/
 YgHDUNbyLawvFhvWbCOGDhPVVq3Y7FvW4Tt38vD1L+l++/Y2Se1KiG8f0yP5/6GY6sD9aJnLMgY
 TNrld7Y16L1r0lhQgHf1ptXjgz8idvzaPe6JugGeJLNAqXJEpJNWeqJV9131TNGrBBON3BcBe6w
 wYZRNC36C/6OGqfpK7oA5G+hA7e2gNkt++Md365K9f0lyKSS7C4Hlg5kSjV2HmU0H4spjBcmsTh
 Gm8Q+CRJLdrnlCbCRw2H5vzrPcCbz+LHPApq2Qwev3SKBpqyM+wML5vhc29ZxOGqJj1Qsx3dmNc
 NchdI4W7Vsx/wBxWv+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX3yBoooVpqOro
 I8iw5b1wwiPHcnJq/nvZg9xNv+66sKQjFTSr3sRSO4mujTN7xNSSY2LGIcXb1HTmowF13T0Bvte
 l9kD1Ktn5J1EocgRyyT1g88X67sYn5g=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a69f5a3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=4EnaXKK5IqdJy50f37cA:9
X-Proofpoint-GUID: qb8b2A42MfhsNxw6jByH2_SVSeyNq_FR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

Add powerpc perf tool support for the HTM PMU AUXTRACE recording path.

Introduce htm_recording_init() and the associated auxtrace callbacks so
perf record can create PERF_RECORD_AUXTRACE records for HTM data.

htm_info_fill() stores the PMU type, number of HTM evsels, and a
(cpu, attr.config) pair for each evsel into PERF_RECORD_AUXTRACE_INFO
priv[].  The decode side reads these back to map each AUX buffer
(identified by event->auxtrace.cpu) to the correct (node, chip, core)
target when writing htm.bin.* output files.

Update auxtrace_record__init() to detect HTM events and dispatch to the
HTM-specific recording initializer.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V4:
- Add explicit mutual-exclusion check in auxtrace_record__init(): if
  both vpa_dtl_evsel and htm_evsel are set after scanning the evlist,
  print an error, set *err = -EINVAL, and return NULL.  V3 silently
  fell through to prefer VPA-DTL when both PMU types were present,
  leaving HTM AUX buffers collected without a
  PERF_RECORD_AUXTRACE_INFO record and the trace undecodable.
- Drop the superfluous pos->name && null-guard from the HTM detection
  condition in auxtrace_record__init(): the condition becomes
  !strcmp(evsel__pmu_name(pos), "htm") without the leading check.
  evsel__pmu_name() handles a NULL name internally so the guard is
  redundant.
- Apply the same simplification in htm_recording_options() and
  htm_nr_events() in htm.c: remove the !pos->name || prefix from
  the evsel__pmu_name() comparisons, consistent with the dispatcher
  change above.
- Set pos->core.attr.sample_period = 1 for each HTM evsel inside
  htm_recording_options().  V3 set freq=0 and aux_watermark but did
  not set sample_period, leaving the kernel to use whatever default
  value was in the attr, which could cause the HTM event to fire at
  an unintended rate.

Changes in V3:
- Switch HTM event detection in auxtrace_record__init() from
strstarts(pos->name, "htm") to !strcmp(evsel__pmu_name(pos), "htm"),
matching the kernel-assigned PMU name and preventing false
matches on user-named events.
- Switch htm_recording_options(), htm_nr_events(), and the
loop in htm_info_fill() from strstarts(pos->name, "htm")
to evsel__pmu_name(), consistent with the above and with
patches 4 and 6.
- Add #include <linux/zalloc.h> to htm.c for zalloc().
- Set auxtrace_info->type = PERF_AUXTRACE_POWERPC_HTM directly
in htm_info_fill(), removing the placeholder comment. (V2
deferred this to patch 5; it is cleaner to set it in the same
patch that defines the enum.)
- Set aux_watermark to half the AUX ring-buffer size
(auxtrace_mmap_pages * page_size / 2) so there is always
headroom for hardware to write while userspace drains. V2 set
it to the full buffer size, risking data loss under back-pressure.
- Add PERF_AUXTRACE_POWERPC_HTM to the enum auxtrace_type in
util/auxtrace.h and add #include "powerpc-htm.h" plus a stub
case PERF_AUXTRACE_POWERPC_HTM: (falls through to
PERF_AUXTRACE_UNKNOWN) in util/auxtrace.c in this patch, so
the enum is defined before it is used in htm_info_fill().
(V2 did this in patch 5.)

Changes in V2:
- htm_info_fill() now stores a (cpu, attr.config) pair for every HTM
  evsel into PERF_RECORD_AUXTRACE_INFO priv[].  V1 stored only the PMU
  type and a single config value; there was no per-CPU mapping.
- The priv[] layout is formalised in util/powerpc-htm.h with enum
  constants POWERPC_HTM_PMU_TYPE, POWERPC_HTM_NUM_EVENTS, and
  POWERPC_HTM_EVENT_DATA and the helper macros HTM_AUXTRACE_PRIV_FIXED
  and HTM_AUXTRACE_PRIV_SIZE(n).  V1 used bare numeric offsets.
- PERF_SAMPLE_RAW is enabled in the recording options so that memory
  configuration records emitted by the kernel driver are captured
  alongside the AUX stream.  V1 added this in a later patch.
- PERF_AUXTRACE_POWERPC_HTM type constant is set in htm_info_fill()
  (wired up in patch 5 once the enum is defined).
- Patch is now 2/6 instead of 2/9.

 tools/perf/arch/powerpc/util/Build      |   1 +
 tools/perf/arch/powerpc/util/auxtrace.c |  21 +++
 tools/perf/arch/powerpc/util/htm.c      | 171 ++++++++++++++++++++++++
 tools/perf/util/auxtrace.c              |   2 +
 tools/perf/util/auxtrace.h              |   1 +
 tools/perf/util/powerpc-htm.h           |  43 ++++++
 6 files changed, 239 insertions(+)
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
index e04a0bd61755..c77ffc4c6a9d 100644
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
 	struct evsel *vpa_dtl_evsel = NULL;
+	struct evsel *htm_evsel = NULL;
 
 	/*
 	 * Set err value to zero here. Any fail later
@@ -32,11 +34,30 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
 			/* Remember the first matching VPA DTL event */
 			if (!vpa_dtl_evsel)
 				vpa_dtl_evsel = pos;
+		} else if (!strcmp(evsel__pmu_name(pos), "htm")) {
+			pos->needs_auxtrace_mmap = true;
+			/* Remember the first matching HTM event */
+			if (!htm_evsel)
+				htm_evsel = pos;
 		}
 	}
 
+	/*
+	 * Only one auxtrace PMU can be initialised per session.  Reject
+	 * concurrent VPA DTL and HTM events: HTM AUX buffers would be
+	 * collected without a PERF_RECORD_AUXTRACE_INFO record, making
+	 * the trace undecodable.
+	 */
+	if (vpa_dtl_evsel && htm_evsel) {
+		pr_err("Cannot record VPA DTL and HTM auxtrace events simultaneously\n");
+		*err = -EINVAL;
+		return NULL;
+	}
+
 	if (vpa_dtl_evsel)
 		return vpa_dtl_recording_init(vpa_dtl_evsel, err);
+	else if (htm_evsel)
+		return htm_recording_init(htm_evsel, err);
 
 	return NULL;
 }
diff --git a/tools/perf/arch/powerpc/util/htm.c b/tools/perf/arch/powerpc/util/htm.c
new file mode 100644
index 000000000000..7757f548ef22
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/htm.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HTM AUX tracing support
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/zalloc.h>
+#include <stdlib.h>
+#include <limits.h>
+#include "../../util/evsel.h"
+#include "../../util/evlist.h"
+#include "../../util/session.h"
+#include "../../util/debug.h"
+#include "../../util/auxtrace.h"
+#include "../../util/powerpc-htm.h"
+#include "../../util/record.h"
+#include <internal/lib.h> /* page_size */
+#include <errno.h>
+
+#define KiB(x) ((x) * 1024)
+
+struct htm_recording {
+	struct auxtrace_record	itr;
+	struct evsel		*evsel;
+};
+
+static int
+htm_recording_options(struct auxtrace_record *itr __maybe_unused,
+		      struct evlist *evlist,
+		      struct record_opts *opts)
+{
+	struct evsel *pos;
+
+	opts->full_auxtrace = true;
+
+	if (!opts->auxtrace_mmap_pages) {
+		opts->auxtrace_mmap_pages = KiB(128) / page_size;
+		if (opts->mmap_pages == UINT_MAX)
+			opts->mmap_pages = KiB(256) / page_size;
+	}
+
+	evlist__for_each_entry(evlist, pos) {
+		if (strcmp(evsel__pmu_name(pos), "htm"))
+			continue;
+		pos->core.attr.aux_watermark =
+			opts->auxtrace_mmap_pages * (size_t)page_size / 2;
+		pos->core.attr.sample_type |= PERF_SAMPLE_RAW;
+		pos->core.attr.freq = 0;
+		pos->core.attr.sample_period = 1;
+		pos->needs_auxtrace_mmap = true;
+	}
+
+	return 0;
+}
+
+/* Count htm evsels in the evlist */
+static int htm_nr_events(struct evlist *evlist)
+{
+	struct evsel *pos;
+	int n = 0;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (!strcmp(evsel__pmu_name(pos), "htm"))
+			n++;
+	}
+	return n;
+}
+
+static size_t htm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
+				 struct evlist *evlist)
+{
+	return HTM_AUXTRACE_PRIV_SIZE(htm_nr_events(evlist));
+}
+
+/*
+ * Fill the PERF_RECORD_AUXTRACE_INFO private data with:
+ *   priv[POWERPC_HTM_PMU_TYPE]   = pmu->type of the first htm evsel
+ *   priv[POWERPC_HTM_NUM_EVENTS] = number of htm evsels
+ *   priv[POWERPC_HTM_EVENT_DATA + n*2]     = CPU for nth htm evsel
+ *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 1] = attr.config for nth htm evsel
+ *
+ * The CPU is the first CPU in the evsel's cpu map; for events opened with
+ * cpu=N there is exactly one CPU.  The decode side uses event->auxtrace.cpu
+ * to look up the matching config and derive (node, chip, core) for the
+ * output file name.
+ */
+static int
+htm_info_fill(struct auxtrace_record *itr,
+	      struct perf_session *session,
+	      struct perf_record_auxtrace_info *auxtrace_info,
+	      size_t priv_size)
+{
+	struct htm_recording *htm_r = container_of(itr, struct htm_recording, itr);
+	struct evlist *evlist = session->evlist;
+	struct evsel *pos;
+	int n = 0;
+	int expected_n = htm_nr_events(evlist);
+
+	if (priv_size != HTM_AUXTRACE_PRIV_SIZE(expected_n))
+		return -EINVAL;
+
+	auxtrace_info->type = PERF_AUXTRACE_POWERPC_HTM;
+	auxtrace_info->priv[POWERPC_HTM_PMU_TYPE] = htm_r->evsel->core.attr.type;
+	auxtrace_info->priv[POWERPC_HTM_NUM_EVENTS] = expected_n;
+
+	evlist__for_each_entry(evlist, pos) {
+		struct perf_cpu_map *cpus;
+		int cpu;
+
+		if (strcmp(evsel__pmu_name(pos), "htm"))
+			continue;
+
+		/*
+		 * Get the CPU this evsel is pinned to.  For events opened
+		 * with cpu=N, evsel__cpus() returns a single-entry map {N}
+		 * at record time (not during replay).
+		 */
+		cpus = evsel__cpus(pos);
+		if (cpus && perf_cpu_map__nr(cpus) > 0)
+			cpu = perf_cpu_map__cpu(cpus, 0).cpu;
+		else
+			cpu = -1;
+
+		auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2]     = cpu;
+		auxtrace_info->priv[POWERPC_HTM_EVENT_DATA + n * 2 + 1] =
+							pos->core.attr.config;
+		n++;
+	}
+
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
+	struct htm_recording *htm_r = container_of(itr, struct htm_recording, itr);
+
+	free(htm_r);
+}
+
+struct auxtrace_record *htm_recording_init(struct evsel *pos, int *err)
+{
+	struct htm_recording *htm_r;
+
+	/*
+	 * To obtain the auxtrace buffer file descriptor, the auxtrace event
+	 * must come first.
+	 */
+	evlist__to_front(pos->evlist, pos);
+
+	htm_r = zalloc(sizeof(*htm_r));
+	if (!htm_r) {
+		pr_debug("htm_recording allocation failed (-ENOMEM)\n");
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	htm_r->evsel = pos;
+	htm_r->itr.recording_options = htm_recording_options;
+	htm_r->itr.info_priv_size    = htm_info_priv_size;
+	htm_r->itr.info_fill         = htm_info_fill;
+	htm_r->itr.free              = htm_free;
+	htm_r->itr.reference         = htm_reference;
+	return &htm_r->itr;
+}
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 0b851f32e98c..31c0db933f61 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -56,6 +56,7 @@
 #include "s390-cpumsf.h"
 #include "util/mmap.h"
 #include "powerpc-vpadtl.h"
+#include "powerpc-htm.h"
 
 #include <linux/ctype.h>
 #include "symbol/kallsyms.h"
@@ -1427,6 +1428,7 @@ int perf_event__process_auxtrace_info(const struct perf_tool *tool __maybe_unuse
 	case PERF_AUXTRACE_VPA_DTL:
 		err = powerpc_vpadtl_process_auxtrace_info(event, session);
 		break;
+	case PERF_AUXTRACE_POWERPC_HTM:
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 6947f3f284c0..68b17802a419 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -46,6 +46,7 @@ enum auxtrace_type {
 	PERF_AUXTRACE_S390_CPUMSF,
 	PERF_AUXTRACE_HISI_PTT,
 	PERF_AUXTRACE_VPA_DTL,
+	PERF_AUXTRACE_POWERPC_HTM,
 };
 
 enum itrace_period_type {
diff --git a/tools/perf/util/powerpc-htm.h b/tools/perf/util/powerpc-htm.h
new file mode 100644
index 000000000000..18e39417d556
--- /dev/null
+++ b/tools/perf/util/powerpc-htm.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __POWERPC_HTM_H
+#define __POWERPC_HTM_H
+
+#include <linux/types.h>
+
+/*
+ * Layout of the private data in PERF_RECORD_AUXTRACE_INFO for HTM.
+ *
+ * priv[POWERPC_HTM_PMU_TYPE]   = htm PMU type ID (pmu->type from kernel)
+ * priv[POWERPC_HTM_NUM_EVENTS] = number of htm evsels recorded (N)
+ *
+ * Followed by N pairs (2 u64 each):
+ *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 0] = CPU number for nth htm evsel
+ *   priv[POWERPC_HTM_EVENT_DATA + n*2 + 1] = attr.config for nth htm evsel
+ *
+ * Total priv entries: POWERPC_HTM_EVENT_DATA + N * 2
+ */
+enum {
+	POWERPC_HTM_PMU_TYPE  = 0,
+	POWERPC_HTM_NUM_EVENTS,
+	POWERPC_HTM_EVENT_DATA,	/* variable-length: 2 u64 per event */
+};
+
+/* Fixed header size (everything before the per-event data) */
+#define HTM_AUXTRACE_PRIV_FIXED  (POWERPC_HTM_EVENT_DATA * sizeof(u64))
+
+/* Total priv size for N htm evsels */
+#define HTM_AUXTRACE_PRIV_SIZE(n) \
+	(HTM_AUXTRACE_PRIV_FIXED + (n) * 2 * sizeof(u64))
+
+struct evsel;
+struct evlist;
+union perf_event;
+struct perf_session;
+struct auxtrace_record;
+
+struct auxtrace_record *htm_recording_init(struct evsel *pos, int *err);
+
+int powerpc_htm_process_auxtrace_info(union perf_event *event,
+				      struct perf_session *session);
+
+#endif /* __POWERPC_HTM_H */
-- 
2.43.0



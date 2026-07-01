Return-Path: <linuxppc-dev+bounces-23278-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE94C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:38:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqthN2ZHdz2xJT;
	Wed, 01 Jul 2026 18:38:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895108;
	cv=none; b=A9oX7vIVb/YHY4AKNh0xAbw3KbPsopmJi1COrd6NKC8aKUHYQUbqoy1UkSR9gZpRsfeYFFj5UUolWzqO/wZuGaIBhtEzG2n3KffqE91HzGwLIvbTcXHPRSk33L8Obw0mpeG4+Oa2uSOVbfQ0qKry49/mr7SMltilXac7Ua6vjC5tpM3xmvfcV6BWd3FDAn9Xjaop2RsNarFUNw2ZMINUuGILUHpyx2bxrSeVO08R4R+xXAvZEzV3YoFd2Tmg+dgPHQ58JiEAW97+OGmcjTU2uDt4yirBPe/4adm7QCA2TNDKIct/Vwo6h/ERwGLwcUlPMi6m6fOCAP2XQZiaU623/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895108; c=relaxed/relaxed;
	bh=FpDxRemR4zDxIdlRWs3MQVoVDdCNEBnN32GvWbzQKqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cbxig+N5qvylaPFvg/7S8megPrOh+LvYOR0Mi4l6EgGiOEKAmCKbukELpJUrEjUjjACEkXaLfJZ/jUAOqMmSxAkpHzY1lzxT8l4rKbdU6ahYXMb5Ix9dimkWrkGIxNeLL+IP/wbUB49CD/AQInPk4JI/DM/vtkRTB58asYTa3oZGwVAz5uUPjgbJm11fXYJovHO7Ztdl5ioxBEz6bf01vQ/z7gPUtY5DgMsttFZxZbGrVrpecqV46XoU7Ojt1ETn0dcOT6v7x3hWbhUqWOLx7RObMv/k+8OM8oGyKWYg4sytJrr3p5hrqqxi6p51b+UoZVW3uFnA9K6i88exGDazVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cp7b+nxl; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cp7b+nxl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqthL6n67z2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:38:26 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618JDSI237017;
	Wed, 1 Jul 2026 08:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FpDxRemR4zDxIdlRW
	s3MQVoVDdCNEBnN32GvWbzQKqw=; b=cp7b+nxls1drCtXy6yQtlCZK4+aYqghVH
	PwIhhLM9ByhHMa1U6bLCFMdY6DQ/X505Vqys+nuxFrgY2cde+lVwPaD6QdIi+vQ5
	Ugi+kX4EzmFlrK020T03rHJHZmZ7QBOHtCGK89mprLhzpJ3Hmku3XVqr3lyvqJ08
	eXCuvhWv6xwYVLb2wB1ifsePFgQ7Mtgf5ufAoxlWAG4TJiN7J38/LrMjM269NzwB
	57fgHXxavhRc1rDh7Kt7o7mWTzKiJ/VbtIf+yWEFAhXi2swZUk6/rPfsLLqnAiRv
	nhQC0mv71nrQ2ALnX7s9LjDqdhCWCra4qZ7u0wUBdlAaX5bvOq5Tg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa34xm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:38:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618YhVG026609;
	Wed, 1 Jul 2026 08:38:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w6h9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:38:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618cIjH47645030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:38:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 808FC20043;
	Wed,  1 Jul 2026 08:38:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3295320040;
	Wed,  1 Jul 2026 08:38:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:38:15 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com
Subject: [PATCH 1/5] powerpc/htm: Add interface to expose HTM trace data via perf
Date: Wed,  1 Jul 2026 14:08:02 +0530
Message-Id: <20260701083806.79358-2-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260701083806.79358-1-atrajeev@linux.ibm.com>
References: <20260701083806.79358-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX/5frvHIND1ir
 u9/H67N28VMN5pjCMwSVgNEL7nasgQN8hWtYxR880uWFA2lk/6l8Ywk9erfa3GaFQTbNP7jm6gc
 tEXVNRm6N+Oj5liCe4+Wimu/7+lOAWfhIyFZEIpAYY4yL9XDx2v1jTknJTMd+51nA5g64qwluaE
 urcAqMcptkl2Uves2hRrpkFfo2M3hCPKxAH7bg508gPR+D/D8KVJOIjt2VYT+bWJPcbBLcFW5XS
 FU16HOcOGOIsaU11bGkqhMAlH5X4ZlqbNtzf9SGKBCukahX2TGWBas5Py7bTIvqE2Asoll5UdH3
 KB8zjrQFvI3OW0HZiOY6GFtJJe7hYb37c6GpuzNImdDjDYnfXHtYNtB4nuzB8HL07yI3eO30Mot
 GPXDE3fRaqKV8Lpkvoxh56F9nGABj8P7ae2SCseCQ8Owgx+f7kMnWQWD51KJIXuG7UjbB34H7Sw
 XxVGF4h9gqrhWNRldQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX2PY22/BsxtL+
 5AOImYkmlf5frO5kTBdzGQ1Eb2ypCA4j5TIvl7lbG5YFJWMBIdLGiVSvqfpQfp/OYMpZVcFzfRP
 1g7/zMCuxWOIH0qMun4Aqh+27HAbgyc=
X-Proofpoint-GUID: a8rNRzs-8MJkmS9qemCJ96CO2HLou0Qo
X-Proofpoint-ORIG-GUID: a8rNRzs-8MJkmS9qemCJ96CO2HLou0Qo
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a44d200 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=FOg5O_DKp05u7t18ZasA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010084

H_HTM (Hardware Trace Macro) hypervisor call is an HCALL to export data
from Hardware Trace Macro (HTM) function. Add support for setup,
configuration and control of HTM function via PMU.

H_HTM is used as an interface for executing Hardware Trace Macro (HTM)
functions, including setup, configuration, control and dumping of the
HTM data. HTM operations can be controlled using the H_HTM hcall. The
hcall can be invoked for any core/chip of the system from within a
partition itself.

To use this, expose event as part of "htm" PMU. The event code or config
is 28 bit value, where user can specify below required fields:

event: "config:0-27"
htm_type: "config:0-3"
nodeindex: "config:4-11"
nodalchipindex: "config:12-19"
coreindexonchip: "config:20-27"

1) nodeindex, nodalchipindex, coreindexonchip: this specifies
   which partition to configure the HTM for.
2) htmtype: specifies the type of HTM.

In htm_event_add: configure and start the tracing using htm_hcall_wrapper
which is defined in plpar_wrappers.h header file
In htm_event_del: stop and deconfigure the tracing using
htm_hcall_wrapper

With the changes:

 # ls /sys/bus/event_source/devices/ |grep htm
 htm

 # ls /sys/bus/event_source/devices/htm/
 events  format  perf_event_mux_interval_ms  power  subsystem  type  uevent

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 arch/powerpc/perf/Makefile   |   2 +-
 arch/powerpc/perf/htm-perf.c | 307 +++++++++++++++++++++++++++++++++++
 2 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/perf/htm-perf.c

diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index 78dd7e25219e..26ef30c0693c 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_PPC_POWERNV)	+= imc-pmu.o
 obj-$(CONFIG_FSL_EMB_PERF_EVENT) += core-fsl-emb.o
 obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o e6500-pmu.o
 
-obj-$(CONFIG_HV_PERF_CTRS) += hv-24x7.o hv-gpci.o hv-common.o vpa-dtl.o
+obj-$(CONFIG_HV_PERF_CTRS) += hv-24x7.o hv-gpci.o hv-common.o vpa-dtl.o htm-perf.o
 
 obj-$(CONFIG_VPA_PMU) += vpa-pmu.o
 
diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
new file mode 100644
index 000000000000..e22a7fdce2f5
--- /dev/null
+++ b/arch/powerpc/perf/htm-perf.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Perf interface to expose HTM Trace data.
+ *
+ * Copyright (C) 2025 Athira Rajeev, IBM Corporation
+ */
+
+#define pr_fmt(fmt) "htm: " fmt
+
+#include <asm/dtl.h>
+#include <linux/perf_event.h>
+#include <asm/plpar_wrappers.h>
+#include <linux/vmalloc.h>
+
+extern void perf_event_wakeup(struct perf_event *event);
+#define EVENT(_name, _code)     enum{_name = _code}
+
+/*
+ * H_HTM (Hardware Trace Macro) hypervisor call is an HCALL to export
+ * data from Hardware Trace Macro (HTM) function.
+ *
+ * Event codes based on HTM type.
+ */
+EVENT(HTM_CORE,         0x2);
+EVENT(HTM_NEST,	        0x1);
+
+GENERIC_EVENT_ATTR(htm_core, HTM_CORE);
+GENERIC_EVENT_ATTR(htm_nest, HTM_NEST);
+
+PMU_FORMAT_ATTR(event, "config:0-27");
+PMU_FORMAT_ATTR(htm_type, "config:0-3");
+PMU_FORMAT_ATTR(nodeindex, "config:4-11");
+PMU_FORMAT_ATTR(nodalchipindex, "config:12-19");
+PMU_FORMAT_ATTR(coreindexonchip, "config:20-27");
+
+static struct attribute *events_attr[] = {
+	GENERIC_EVENT_PTR(HTM_NEST),
+	GENERIC_EVENT_PTR(HTM_CORE),
+	NULL
+};
+
+static struct attribute_group event_group = {
+	.name = "events",
+	.attrs = events_attr,
+};
+
+static struct attribute *format_attrs[] = {
+	&format_attr_event.attr,
+	&format_attr_htm_type.attr,
+	&format_attr_nodeindex.attr,
+	&format_attr_nodalchipindex.attr,
+	&format_attr_coreindexonchip.attr,
+	NULL,
+};
+
+static const struct attribute_group format_group = {
+	.name = "format",
+	.attrs = format_attrs,
+};
+
+static const struct attribute_group *attr_groups[] = {
+	&format_group,
+	&event_group,
+	NULL,
+};
+
+static u64 htmflags = H_HTM_FLAGS_NOWRAP;
+
+/*
+ * Check the return code for H_HTM hcall.
+ * Return non-zero value (1) if either H_PARTIAL or H_SUCCESS
+ * is returned. For other return codes:
+ * Return zero if H_NOT_AVAILABLE.
+ * Return -EBUSY if hcall return busy.
+ * Return -EINVAL if any parameter or operation is not valid.
+ * Return -EPERM if HTM Virtualization Engine Technology code
+ * is not applied.
+ * Return -EIO if the HTM state is not valid.
+ */
+static ssize_t htm_return_check(int rc)
+{
+	switch (rc) {
+	case H_SUCCESS:
+		break;
+	/* H_PARTIAL for the case where all available data can't be
+	 * returned due to buffer size constraint.
+	 */
+	case H_PARTIAL:
+		break;
+	/* H_NOT_AVAILABLE indicates reading from an offset outside the range,
+	 * i.e. past end of file.
+	 */
+	case H_NOT_AVAILABLE:
+		return 0;
+	case H_BUSY:
+	case H_LONG_BUSY_ORDER_1_MSEC:
+	case H_LONG_BUSY_ORDER_10_MSEC:
+	case H_LONG_BUSY_ORDER_100_MSEC:
+	case H_LONG_BUSY_ORDER_1_SEC:
+	case H_LONG_BUSY_ORDER_10_SEC:
+	case H_LONG_BUSY_ORDER_100_SEC:
+		return -EBUSY;
+	case H_PARAMETER:
+		goto out;
+	case H_P2:
+		goto out;
+	case H_P3:
+		goto out;
+	case H_P4:
+		goto out;
+	case H_P5:
+		goto out;
+	case H_P6:
+		return -EINVAL;
+	case H_STATE:
+		return -EIO;
+	case H_AUTHORITY:
+		return -EPERM;
+	}
+
+	/*
+	 * Return 1 for H_SUCCESS/H_PARTIAL
+	 */
+	return 1;
+out:
+	return -EINVAL;
+}
+
+static int htm_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 config = event->attr.config;
+	u32 htmtype;
+
+	if (event->attr.inherit)
+		return -EOPNOTSUPP;
+
+	/* test the event attr type for PMU enumeration */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (!perfmon_capable())
+		return -EACCES;
+
+	/* Return if this is a counting event */
+	if (!is_sampling_event(event))
+		return -EOPNOTSUPP;
+
+	/* no branch sampling */
+	if (has_branch_stack(event))
+		return -EOPNOTSUPP;
+
+	htmtype = config & 0xf;
+	/* Invalid eventcode */
+	switch (htmtype) {
+	case HTM_CORE:
+	case HTM_NEST:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	htmflags = H_HTM_FLAGS_NOWRAP;
+
+	if (event->attr.freq) {
+		hwc->sample_period = event->attr.sample_period;
+		local64_set(&hwc->period_left, hwc->sample_period);
+		hwc->last_period = hwc->sample_period;
+		event->attr.freq = 0;
+	}
+
+	return 0;
+}
+
+static int htm_event_add(struct perf_event *event, int flags)
+{
+	int rc, ret;
+	unsigned long param1 = -1, param2 = -1;
+	int retries = 0;
+	u64 config = event->attr.config;
+	u32 htmtype, nodeindex, nodalchipindex, coreindexonchip;
+
+	/*
+	 * Invoke H_HTM call with:
+	 * operation as htm configure (H_HTM_OP_CONFIGURE)
+	 * last three values are unused, hence set to zero
+	 */
+	htmtype = config & 0xf;
+	nodeindex = (config >> 4) & 0xff;
+	nodalchipindex = (config >> 12) & 0xff;
+	coreindexonchip = (config >> 20) & 0xff;
+	do {
+		rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
+			htmtype, H_HTM_OP_CONFIGURE, param1, param2, 0);
+		ret = htm_return_check(rc);
+	} while (ret <= 0 && ++retries < 100);
+	if (ret <= 0)
+		return -1;
+
+	/* Reset retries */
+	retries = 0;
+
+	/*
+	 * Invoke H_HTM call with:
+	 * operation as htm  start (H_HTM_OP_START)
+	 * last three values are unused, hence set to zero
+	 */
+	do {
+		rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
+				htmtype, H_HTM_OP_START, 0, 0, 0);
+		ret = htm_return_check(rc);
+	} while (ret == -EBUSY && ++retries < 100);
+
+	if (htm_return_check(rc) <= 0)
+		return -1;
+
+	return 0;
+}
+
+static void htm_event_del(struct perf_event *event, int flags)
+{
+	long rc;
+	int ret;
+	int retries = 0;
+	u64 config = event->attr.config;
+	u32 htmtype, nodeindex, nodalchipindex, coreindexonchip;
+
+	/*
+	 * Invoke H_HTM call with:
+	 * operation as htm  stop (H_HTM_OP_STOP)
+	 * last three values are unused, hence set to zero
+	 */
+	htmtype = config & 0xf;
+	nodeindex = (config >> 4) & 0xff;
+	nodalchipindex = (config >> 12) & 0xff;
+	coreindexonchip = (config >> 20) & 0xff;
+	do {
+		rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
+				htmtype, H_HTM_OP_STOP, 0, 0, 0);
+		ret = htm_return_check(rc);
+	} while (ret == -EBUSY && ++retries < 100);
+
+	/* Reset retries */
+	retries = 0;
+
+	/*
+	 * Invoke H_HTM call with:
+	 * operation as htm configure (H_HTM_OP_DECONFIGURE)
+	 * last three values are unused, hence set to zero
+	 */
+	do {
+		rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
+			htmtype, H_HTM_OP_DECONFIGURE, 0, 0, 0);
+		ret = htm_return_check(rc);
+	} while (ret <= 0 && ++retries < 100);
+}
+
+/*
+ * This function definition is empty as htm_dump_sample_data
+ * is used to parse and dump the HTM trace data,
+ * to perf data.
+ */
+static void htm_event_read(struct perf_event *event)
+{
+	return;
+}
+
+static void htm_event_start(struct perf_event *event, int flags)
+{
+}
+
+static void htm_event_stop(struct perf_event *event, int flags)
+{
+}
+
+static struct pmu htm_pmu = {
+	.task_ctx_nr = perf_invalid_context,
+
+	.name = "htm",
+	.attr_groups = attr_groups,
+	.event_init  = htm_event_init,
+	.add         = htm_event_add,
+	.del         = htm_event_del,
+	.read        = htm_event_read,
+	.start	     = htm_event_start,
+	.stop	     = htm_event_stop,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_EXCLUSIVE,
+};
+
+static int htm_init(void)
+{
+	int r;
+
+	/* This driver is intended only for L1 host. */
+	if (is_kvm_guest()) {
+		pr_debug("Only supported for L1 host system\n");
+		return -ENODEV;
+	}
+
+	r = perf_pmu_register(&htm_pmu, htm_pmu.name, -1);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+device_initcall(htm_init);
-- 
2.52.0



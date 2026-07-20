Return-Path: <linuxppc-dev+bounces-24470-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A95C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:45:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3cc26NWpz2yXj;
	Mon, 20 Jul 2026 20:45:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784544322;
	cv=none; b=Xx3X0Tq4pYdcKYNYagRp1uFgbOwheUc2+WGVws3m9vJVuYr7Cn8yLorswUKWh3OuDPs89e3/uNmYcYZiFg3v0INybfNNd62Hko19n4q+g5x2sNvBch0DqVSfC/Iz5gjeFepNG8AxqaAv5qvcvhdx5Srq55ClBqrGzHyWjhTN69JnprWVIXw9o1Xu4qvN10u4iXwstPK9oYb93g3Wfm61ElsH0BFWAubEknYFFBZhvNnl299COtmSnIw70Akfru8CjsdFusKHS9oGz5v/yb5BWGyb2tP1O4FHGEDCUe9ekyADqBeHMhNDcEufceHWpifrjSeY3UmLsg14s+rlxteFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784544322; c=relaxed/relaxed;
	bh=X7B+rO0uk5VvDP+WyNkFsP4wMufza7Yvi+ZLjGWz1WU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IwPykfh3NyUihhbhIXCQFXftnKkgAaqN+M2i/PN2vgUAiGdD0yYbkgj0iKIJSaXQP1TRJnr8nvtskLTXHuASVjhAac0G4GHpBpziXL73MPPgKIwQk8+WXa2aNxNBEOtniDA/sloSX5CyUgl7rqNtLZKHMhKlBJUAsOpw5RQbVCFsDPN5Iem/1blSXC3Z6t8ZoGALi//RrhYyvLv49/qAY/kLd44/c1UaYO5Mzrf8451Hjx6aKOl2ZpL8YOIfJZRS4IemBx4Ll0hb64NuP58J5tM7PDhIRLRrNudD6zRKosTPpmIA6lsxDuGf9R9ARodplrc8gIk74TjR+It+nT7C/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rbVYanp8; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rbVYanp8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3cc16tBjz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 20:45:21 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KABmsD1913539;
	Mon, 20 Jul 2026 10:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=X7B+rO0uk5VvDP+Wy
	NkFsP4wMufza7Yvi+ZLjGWz1WU=; b=rbVYanp83TzjJFuLpvhgQTyW4Usmg1YIE
	g5l2JdUrVY7we9HlfYpMmVnWMg7l8o6o4U4k5R4IdWnBM8jQYLZ6Or1TVeNS5Wh9
	Hrz+Lj31d3sqU1HQpdtX9LHjXbGHQN7QNe3iNV1+yBhR3YxX1dlNiK76Ut6pT41U
	jU5zfrSQd30CZD4yWOgXIYo9N7BIB/yLOvG4pBY3Z4CpEId9+yODj9/lgDtoj+VH
	eOlUftVeHsmVqwvp2RKxXF+wsXES75M4R9LV3+fbbsITXAFLwCxegHhoBNsYnog4
	mtiGg8nS6EpNie0BY3mdTErb3PBANBpOAZxdQnV6pDG+gbPtB0afQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790q0w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAYdu0012984;
	Mon, 20 Jul 2026 10:45:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g50yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAjDdA39977340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:45:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C4AE2004E;
	Mon, 20 Jul 2026 10:45:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFB5B2004B;
	Mon, 20 Jul 2026 10:45:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:45:10 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V2 1/6] powerpc/perf: Add HTM PMU driver to expose Hardware Trace Macro data
Date: Mon, 20 Jul 2026 16:14:42 +0530
Message-Id: <20260720104447.11843-2-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260720104447.11843-1-atrajeev@linux.ibm.com>
References: <20260720104447.11843-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: vwaks7bePSmHPECytW27Ps734HuDcWsv
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5dfc3f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=BrJbKb1y8XBlBzz4AjEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX0kSqAlLCcwiG
 3XGQP9F1wOO3sMYWf0SOFkIPw8sHX+np5GjNQRnsdNDymtWqxJK4zAiDlcLQc6EThN8ds6moLg1
 EkvyzOJtn9UU1sJBEXyIUu4HTCQpLCQ=
X-Proofpoint-GUID: vwaks7bePSmHPECytW27Ps734HuDcWsv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX+yR/tHFqLcuw
 neJyfneXryqdkrRo5WusGsdbdbX1n35wAZtTc0JWfmz5UH30lc6BQ2xTpjj5IfWtyxLg8tennGf
 NPu/Hwd5el7IqYjrP/cNTwTPfu9spXUecQiopvGEV/bQsr2vii2X0hO8bjZ1LVLkIRZI9z2VqHb
 e/+Kd414j54Ozgr90jKF6LkyhpeleTZ0fyFQI5ZPIFv9RbgnlXVxW0X8+IIP+ufO0JmYTYhj1kj
 FKpz/p+3tYeUHXtRvj59/hBQh8Y42YcRxA0U2x6FQuP1KnTsDU2oFrsI1lVUErTB8TFIsTmTkNs
 m5jOhOOLQ7ekgHcfOnZxqaqL6g6fZ06fiulF4P1tXkHCfO0OBB5SPNLT2krmtV5YzoynFFVFJTi
 8yyaSwyIAyE3z0c1Z8K0FfuGBNuIBNkbmVM2V3tXLMv09wvBa+B95zK2H20DT913Jt2YLaPOgyn
 bIX1Yh03oj0gOsNoX0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200119

The H_HTM hypervisor call (hcall) provides an interface to the Hardware
Trace Macro (HTM) function on POWER systems.  HTM captures hardware-level
trace data for a specific node/chip/core target within a logical partition.

Add a new "htm" Performance Monitoring Unit (PMU) that exposes HTM control
via the standard perf interface.  The event configuration is a 28-bit value
packed into the perf config field:

  bits  0-3:  htm_type         (HTM_CORE=2, HTM_NEST=1)
  bits  4-11: nodeindex
  bits 12-19: nodalchipindex
  bits 20-27: coreindexonchip

PMU lifecycle:

  add/del:    Issue H_HTM_OP_CONFIGURE / H_HTM_OP_DECONFIGURE to reserve
              and release the hardware trace resource.

  start/stop: Issue H_HTM_OP_START / H_HTM_OP_STOP to control tracing.
              HTM traces at node/chip/core scope continuously for the
              duration of the event.  Context-switch-triggered start/stop
              callbacks (PERF_EF_RELOAD / PERF_EF_UPDATE) are ignored to
              keep tracing uninterrupted.  Explicit ioctl(ENABLE/DISABLE)
              and event deletion do control the hardware.

State tracking uses event->pmu_private (HTM_TRACING_ACTIVE/INACTIVE) as
the source of information, with event->hw.state kept in sync as
a hint for the perf core.  This avoids conflicts with infrastructure
writes to event->hw.state.

The H_HTM hcall may return H_BUSY (transient, retried up to MAX_RETRIES)
or H_LONG_BUSY_* (long delay required, not retried to avoid deadlocks in
atomic contexts).

After this patch the PMU is visible under sysfs:

 # ls /sys/bus/event_source/devices/ |grep htm
 htm

 # ls /sys/bus/event_source/devices/htm/
 events  format  perf_event_mux_interval_ms  power  subsystem  type  uevent

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V2:
- Replaced direct H_HTM_OP_CONFIGURE/DECONFIGURE calls in htm_event_add()
  and htm_event_del() with separate htm_event_init() and destroy paths.
  State tracking is now via event->pmu_private (HTM_TRACING_ACTIVE /
  HTM_TRACING_INACTIVE) as the authoritative source, with event->hw.state
  kept in sync as a hint for the perf core, avoiding conflicts with
  infrastructure writes to event->hw.state.
- Context-switch callbacks (PERF_EF_RELOAD / PERF_EF_UPDATE) are now
  explicitly ignored in htm_event_start()/stop() to keep tracing
  uninterrupted across task switches; previously these paths were absent.
- H_BUSY retry loop is capped at MAX_RETRIES; H_LONG_BUSY_* is not
  retried in atomic context to avoid deadlocks (was unconditionally
  retried in V1).

 arch/powerpc/perf/Makefile   |   2 +-
 arch/powerpc/perf/htm-perf.c | 379 +++++++++++++++++++++++++++++++++++
 2 files changed, 380 insertions(+), 1 deletion(-)
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
index 000000000000..abecc9bb58dc
--- /dev/null
+++ b/arch/powerpc/perf/htm-perf.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Perf interface to expose HTM Trace data.
+ *
+ * Copyright (C) 2026 Athira Rajeev, IBM Corporation
+ */
+
+#define pr_fmt(fmt) "htm: " fmt
+
+#include <asm/dtl.h>
+#include <linux/perf_event.h>
+#include <asm/plpar_wrappers.h>
+#include <asm/firmware.h>
+
+#define EVENT(_name, _code)	enum{_name = _code}
+#define	MAX_RETRIES	100
+
+EVENT(HTM_CORE,		0x2);
+EVENT(HTM_NEST,		0x1);
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
+struct htm_config {
+	u32 htmtype;
+	u32 nodeindex;
+	u32 nodalchipindex;
+	u32 coreindexonchip;
+};
+
+/*
+ * Per-event private state.  Allocated in htm_event_init(), freed via the
+ * event->destroy callback (reset_htm_active()).
+ *
+ * cfg stores the HTM target identity parsed from event->attr.config.
+ * tracing_active tracks whether H_HTM_OP_START has been successfully issued
+ * for this event. It is the source of information used by
+ * htm_event_start() and htm_event_stop() to make hcall decisions.
+ * event->hw.state is kept in sync for the perf core only.
+ */
+struct htm_target_id {
+	struct htm_config cfg;
+	int tracing_active;		/* HTM_TRACING_ACTIVE / HTM_TRACING_INACTIVE */
+};
+
+/* Helper to parse the 28-bit event config into distinct fields */
+static inline void parse_htm_config(u64 config, struct htm_config *cfg)
+{
+	cfg->htmtype = config & 0xf;
+	cfg->nodeindex = (config >> 4) & 0xff;
+	cfg->nodalchipindex = (config >> 12) & 0xff;
+	cfg->coreindexonchip = (config >> 20) & 0xff;
+}
+
+/*
+ * Check the return code for H_HTM hcall.
+ * Return 1 if either H_PARTIAL or H_SUCCESS is returned.
+ * Return 0 if H_NOT_AVAILABLE.
+ * Return exact negative error codes for expected issues.
+ */
+static ssize_t htm_return_check(int rc)
+{
+	switch (rc) {
+	case H_SUCCESS:
+	case H_PARTIAL:
+		return 1;
+	case H_NOT_AVAILABLE:
+		return 0;
+	case H_BUSY:
+		/* Transient busy: retry loop will spin up to MAX_RETRIES */
+		return -EBUSY;
+	case H_LONG_BUSY_ORDER_1_MSEC:
+	case H_LONG_BUSY_ORDER_10_MSEC:
+	case H_LONG_BUSY_ORDER_100_MSEC:
+	case H_LONG_BUSY_ORDER_1_SEC:
+	case H_LONG_BUSY_ORDER_10_SEC:
+	case H_LONG_BUSY_ORDER_100_SEC:
+		/*
+		 * Hypervisor requests a long delay before retry (1ms-100s).
+		 * Spinning in a kernel retry loop for this duration risks
+		 * deadlocks in atomic contexts.  Return -EAGAIN so callers
+		 * exit immediately; the operation will fail and userspace
+		 * can retry the perf_event_open() call.
+		 * Note: all retry loops check ret == -EBUSY only, so
+		 * -EAGAIN exits without retrying, this is intentional.
+		 */
+		return -EAGAIN;
+	case H_PARAMETER:
+	case H_P2:
+	case H_P3:
+	case H_P4:
+	case H_P5:
+	case H_P6:
+		return -EINVAL;
+	case H_STATE:
+		return -EIO;
+	case H_AUTHORITY:
+		return -EPERM;
+	default:
+		/* Prevent silent fallthrough mapping of unhandled errors to 1 */
+		return -EIO;
+	}
+}
+
+/*
+ * HTM_TRACING_ACTIVE/INACTIVE: values for htm_target_id.tracing_active.
+ * Tracks whether H_HTM_OP_START has been successfully issued.
+ * HTM traces at node/chip/core scope, not per-task. Once started,
+ * context-switch-triggered stop/start (PERF_EF_UPDATE / PERF_EF_RELOAD)
+ * must not stop/restart the hardware. Only explicit API calls
+ * (ioctl DISABLE/ENABLE) and event_del should control the hcall.
+ */
+#define HTM_TRACING_ACTIVE	1
+#define HTM_TRACING_INACTIVE	0
+
+static void reset_htm_active(struct perf_event *event)
+{
+	kfree(event->pmu_private);
+	event->pmu_private = NULL;
+}
+
+static int htm_event_init(struct perf_event *event)
+{
+	u64 config = event->attr.config;
+	struct htm_config cfg;
+
+	if (event->attr.inherit)
+		return -EOPNOTSUPP;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (!perfmon_capable())
+		return -EACCES;
+
+	if (!is_sampling_event(event))
+		return -EOPNOTSUPP;
+
+	if (has_branch_stack(event))
+		return -EOPNOTSUPP;
+
+	parse_htm_config(config, &cfg);
+	switch (cfg.htmtype) {
+	case HTM_CORE:
+	case HTM_NEST:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Allocate per-event private state; freed via event->destroy */
+	event->pmu_private = kzalloc(sizeof(struct htm_target_id), GFP_KERNEL);
+	if (!event->pmu_private)
+		return -ENOMEM;
+
+	((struct htm_target_id *)event->pmu_private)->cfg = cfg;
+	event->destroy = reset_htm_active;
+	return 0;
+}
+
+static void htm_event_start(struct perf_event *event, int flags)
+{
+	int rc, ret, retries = 0;
+	struct htm_config cfg;
+	struct htm_target_id *target = event->pmu_private;
+
+	/*
+	 * Ignore context-switch re-enables. The perf core passes
+	 * PERF_EF_RELOAD on context-switch-in. HTM tracing is
+	 * continuous at hardware level, no hcall needed.
+	 */
+	if (flags & PERF_EF_RELOAD)
+		return;
+
+	/* Already tracing, don't issue a second start hcall */
+	if (target->tracing_active == HTM_TRACING_ACTIVE)
+		return;
+
+	cfg = target->cfg;
+
+	/* Only retry on transient H_BUSY; H_LONG_BUSY_* (-EAGAIN) exits immediately */
+	do {
+		rc = htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
+				       cfg.coreindexonchip, cfg.htmtype,
+				       H_HTM_OP_START, 0, 0, 0);
+		ret = htm_return_check(rc);
+	} while (ret == -EBUSY && ++retries < MAX_RETRIES);
+
+	if (ret > 0) {
+		target->tracing_active = HTM_TRACING_ACTIVE;
+		event->hw.state &= ~PERF_HES_STOPPED;
+	}
+}
+
+static void htm_event_stop(struct perf_event *event, int flags)
+{
+	int rc, ret, retries = 0;
+	struct htm_config cfg;
+	struct htm_target_id *target = event->pmu_private;
+
+	/*
+	 * Ignore context-switch-out stops. The perf core passes
+	 * PERF_EF_UPDATE on context-switch-out. Do not stop the hcall.
+	 */
+	if (flags & PERF_EF_UPDATE)
+		return;
+
+	/* Not tracing, nothing to stop */
+	if (target->tracing_active == HTM_TRACING_INACTIVE)
+		return;
+
+	cfg = target->cfg;
+
+	/* Only retry on transient H_BUSY; H_LONG_BUSY_* (-EAGAIN) exits immediately */
+	do {
+		rc = htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
+				       cfg.coreindexonchip, cfg.htmtype,
+				       H_HTM_OP_STOP, 0, 0, 0);
+		ret = htm_return_check(rc);
+	} while (ret == -EBUSY && ++retries < MAX_RETRIES);
+
+	/*
+	 * Only mark stopped if the hcall succeeded.  If the stop failed
+	 * (e.g. -EAGAIN on long-busy), leave tracing_active as ACTIVE so
+	 * that htm_event_del will retry the stop hcall rather than
+	 * skipping it and leaving the hypervisor permanently configured.
+	 */
+	if (ret > 0) {
+		target->tracing_active = HTM_TRACING_INACTIVE;
+		event->hw.state |= PERF_HES_STOPPED;
+	}
+}
+
+static int htm_event_add(struct perf_event *event, int flags)
+{
+	int rc, ret, retries = 0;
+	unsigned long param1 = -1, param2 = -1;
+	struct htm_target_id *target = event->pmu_private;
+	struct htm_config cfg = target->cfg;
+
+	/* Configure the hardware, only retry on transient H_BUSY */
+	do {
+		rc = htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
+				       cfg.coreindexonchip, cfg.htmtype,
+				       H_HTM_OP_CONFIGURE, param1, param2, 0);
+		ret = htm_return_check(rc);
+	} while (ret == -EBUSY && ++retries < MAX_RETRIES);
+
+	if (ret <= 0)
+		return (ret == 0) ? -ENODEV : ret;
+
+	/*
+	 * htm_event_init() allocated event->pmu_private (struct htm_target_id)
+	 * and set event->destroy = reset_htm_active to free it on teardown.
+	 * Initialise the tracing state and hw.state before calling start.
+	 */
+	target->tracing_active = HTM_TRACING_INACTIVE;
+	event->hw.state = PERF_HES_STOPPED;
+
+	/*
+	 * Start tracing via the .start callback so the standard
+	 * PERF_EF_START / ioctl(ENABLE) path is honoured.
+	 */
+	if (flags & PERF_EF_START) {
+		htm_event_start(event, 0);	/* flags=0: not a context switch */
+		if (target->tracing_active == HTM_TRACING_INACTIVE) {
+			/* Start failed, deconfigure to avoid resource leak */
+			retries = 0;
+			do {
+				rc = htm_hcall_wrapper(htmflags, cfg.nodeindex,
+						       cfg.nodalchipindex, cfg.coreindexonchip,
+						       cfg.htmtype, H_HTM_OP_DECONFIGURE, 0, 0, 0);
+				ret = htm_return_check(rc);
+			} while (ret == -EBUSY && ++retries < MAX_RETRIES);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static void htm_event_del(struct perf_event *event, int flags)
+{
+	int rc, ret, retries = 0;
+	struct htm_target_id *target = event->pmu_private;
+	struct htm_config cfg = target->cfg;
+
+	/* Stop tracing, flags=0 so htm_event_stop issues the hcall */
+	htm_event_stop(event, 0);
+
+	/* Deconfigure */
+	do {
+		rc = htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
+				       cfg.coreindexonchip, cfg.htmtype,
+				       H_HTM_OP_DECONFIGURE, 0, 0, 0);
+		ret = htm_return_check(rc);
+	} while (ret == -EBUSY && ++retries < MAX_RETRIES);
+
+	/* pmu_private freed by event->destroy = reset_htm_active */
+}
+
+static void htm_event_read(struct perf_event *event)
+{
+}
+
+static struct pmu htm_pmu = {
+	.task_ctx_nr  = perf_invalid_context,
+	.name         = "htm",
+	.attr_groups  = attr_groups,
+	.event_init   = htm_event_init,
+	.add          = htm_event_add,
+	.del          = htm_event_del,
+	.read         = htm_event_read,
+	.start        = htm_event_start,
+	.stop         = htm_event_stop,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_EXCLUSIVE,
+};
+
+static int htm_init(void)
+{
+	int r;
+
+	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
+		pr_debug("Only supported on LPAR platforms running under a Hypervisor\n");
+		return -ENODEV;
+	}
+
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
2.43.0



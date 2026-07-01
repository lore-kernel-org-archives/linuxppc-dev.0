Return-Path: <linuxppc-dev+bounces-23279-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A275FC43602
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:38:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqthQ1wjLz2ydn;
	Wed, 01 Jul 2026 18:38:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895110;
	cv=none; b=as5LR8A1iMGbDhsdBm5Pf3u/vhLuFL0TCw5kg6NuXwa6sQRz2vVu3WU04RSL9rWx4hfrXKVEoKEtE23IIcVvKUf07TUJNAWOQw9i4mVkdlqWqyx8HVMaaCp1XPhvQXBOrSdl5Diehoc+dc3u4sTgjWbZuK+iJYvWqNVOqYvNKWw36Ql8nkc0GT+5RapojPt3U2ZhDiiSDj3pyPyic6s/WYEkmJysEqCwiYzgIWtFMrThRCzl/QUk2gnF5fyun2rUSaB5vk8se5Dhr0BfyKnW6ICzBxCxv+k0P5fErVqBeC1qqnkrlK4Twvtgjjsp1qYoselfWt+xDCaUv3Dk+NP6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895110; c=relaxed/relaxed;
	bh=8iRXX9ZRp/yWU7mQB1P9LqQOQ51LdAn9k1m3KcGBdFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ugz/JxE7wCAAimA0DrmiFXM/XURwmiBjc299v+PVjzqHnglNLU0RuMPG4Nf1ZbiaedRIpv+sDvZmUwcyNT8buYZpZUt7975ptQsb32kUB9EyvDvudPemV5rxUEzWeV2ODlF618DleoCGSirXafhXPo+h3NxE0BNmTtrslwDN5KSpAaPbmXqUWgr49NK0fVq8ZZ5KAuv83U5V/K818/yhbtJFDXw6wyyUrctyLa9lpqjjSV6gBseono4m3NhFBIv0X9vs8udob/+LAWpGiARsP6Ca6+ct8LGv4vapTC06ms1UsP1RFF2C+pHDk5ZBlVd75K+zBcVhyBiASGOVnT1yWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=svN5jDih; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=svN5jDih;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqthP2MXfz2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:38:28 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618ISLg298962;
	Wed, 1 Jul 2026 08:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8iRXX9ZRp/yWU7mQB
	1P9LqQOQ51LdAn9k1m3KcGBdFg=; b=svN5jDihHjhHxHdBXgTq6b9FfJPoezFs8
	rTYHN3mYgjXAFvCTZbQ2vpNjeAWzyJAPvtu2ysRGLaGop8Somi4OmFSJci6nPpMt
	XhQhPmUCBINUhlL4iPrMeHJOEf/L/9AFxiPKSBQTiMa7vnZ5RRKkqOy7VR15dnP0
	PzmOuTnxDCyOwKjh7zMR/5hdoqf4C/x4xjXmT1FH2wGjUJVnHoiLk2+SsXS12dkF
	ezVITl1qRtWe0qNaO/NZVGiWhsvtAZVMoVB/utYtbZn6ZUkWgK4gsnDTXPdp5Bo/
	qjJ/l/iTlPWXQ3bUJ9XTkPlTn6EI/oPWZFtqdmGtaXC1FHoF6CV4w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5uf8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:38:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618Ybw0023547;
	Wed, 1 Jul 2026 08:38:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2ge9mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:38:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618cLWg50987304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:38:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D7072004B;
	Wed,  1 Jul 2026 08:38:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E583D20040;
	Wed,  1 Jul 2026 08:38:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:38:18 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com
Subject: [PATCH 2/5] powerpc/htm: Add support to setup and free aux buffer for capturing HTM data
Date: Wed,  1 Jul 2026 14:08:03 +0530
Message-Id: <20260701083806.79358-3-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX4TdpKe78qDZC
 N2MJVBsgIeiu1/BwGA36DtNRlHXd+PAVoA9S1fWW8u2kI3cgRAVYMJcOm+nmJ6HLuzK/pSbFG0q
 R/oVHmhT3Xrb/OtxUcKDWFBvgpY00Rj4pQPxmn0y08p51/3TadFb3QVNHuyZXVgkW3DqRklFl6n
 miu2F0hDXl/09g8d/JRKIj85WlgvxgtbGuqHem0ZDtSWOaANeh8nzLlQapQw7YKE2SCEYbkniCw
 4HvfmMxzJWPiJzSQLWbIWT5QpqeGYcbTgFNfHj5tCL+Cv0wPO0uXCiiLv2neKRCy+/fZQmcOCNx
 n96bP+XRnBg5UpaAF/VAxZXC+b8TBUeorN3DtUPjbx/x/UR4sJ3Rlc/WF06kXm1ljM/aNXY9ewh
 FBSLCEXJ0ex8cmuBz68/1fiwlqOC+xCKW+gJiHTf453kYoKQ/T24n2idCBrdxlowUyCQT/RVENq
 iuqk3ePNLUwPjJ7HI/Q==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a44d202 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=a0-DFueL1vjxSWpYO0sA:9
X-Proofpoint-ORIG-GUID: G2TPwCQO58GLYXealNJdK8X36ZkAto_i
X-Proofpoint-GUID: G2TPwCQO58GLYXealNJdK8X36ZkAto_i
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX32Oks2q8utm/
 UG0Ldwe3lkL30LfPdzxPwwZ0gqz2aEm90jbXijPBU73FlDe7yFdjeUfTAq9USAgo7UKHPzycMY5
 9OlFNfk5+uJ3DBLrORJjDAwBcLRZNsI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

HTM trace data is saved to perf.data when monitoring completes.
We directly copy the trace data as part of auxiliary buffer and it
will be postprocessed later. To enable the support for aux buffer,
add the PMU callbacks for setup_aux and free_aux.

In setup_aux, set up pmu-private data structures for an AUX
area. rb_alloc_aux uses "alloc_pages_node" and returns pointer to each
page address. "struct htm_pmu_buf" mainly saves:
1. buf->base: aux buffer base address
2. buf->head: offset from base address where data will be written to.
3. buf->size: Size of allocated memory

free_aux will free pmu-private AUX data structures.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 arch/powerpc/perf/htm-perf.c | 162 ++++++++++++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
index e22a7fdce2f5..ae7f469b6840 100644
--- a/arch/powerpc/perf/htm-perf.c
+++ b/arch/powerpc/perf/htm-perf.c
@@ -66,6 +66,23 @@ static const struct attribute_group *attr_groups[] = {
 
 static u64 htmflags = H_HTM_FLAGS_NOWRAP;
 
+struct htm_pmu_buf {
+	int     nr_pages;
+	bool    snapshot;
+	void     *base;
+	u64     size;
+	u64     head;
+	u64     head_size;
+	bool    full;
+	int	htm_stopped;
+	int	collect_htm_trace;
+};
+
+struct htm_pmu_ctx {
+	struct perf_output_handle handle;
+};
+
+static DEFINE_PER_CPU(struct htm_pmu_ctx, htm_pmu_ctx);
 /*
  * Check the return code for H_HTM hcall.
  * Return non-zero value (1) if either H_PARTIAL or H_SUCCESS
@@ -126,6 +143,74 @@ static ssize_t htm_return_check(int rc)
 	return -EINVAL;
 }
 
+static int htm_dump_sample_data(struct perf_event *event)
+{
+	struct htm_pmu_ctx *htm_ctx = this_cpu_ptr(&htm_pmu_ctx);
+	struct htm_pmu_buf *aux_buf;
+	u64 config = event->attr.config;
+	u32 htmtype, nodeindex, nodalchipindex, coreindexonchip;
+	long rc;
+	int ret = 0;
+	int retries = 0;
+
+	htmtype = config & 0xf;
+	nodeindex = (config >> 4) & 0xff;
+	nodalchipindex = (config >> 12) & 0xff;
+	coreindexonchip = (config >> 20) & 0xff;
+
+	aux_buf = perf_aux_output_begin(&htm_ctx->handle, event);
+	if (!aux_buf)
+		return -1;
+
+	if (!aux_buf->collect_htm_trace) {
+		perf_aux_output_end(&htm_ctx->handle, 0);
+		return 0;
+	}
+
+	if (!aux_buf->htm_stopped) {
+		do {
+			rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
+				htmtype, H_HTM_OP_STOP, 0, 0, 0);
+			ret = htm_return_check(rc);
+		} while (ret == -EBUSY && ++retries < 100);
+
+		if (ret > 0) {
+			/* HTM stopped trace collection */
+			aux_buf->htm_stopped = 1;
+		} else {
+			/* Failed to stop tracing, don't proceed to trace collection */
+			perf_aux_output_end(&htm_ctx->handle, 0);
+			return ret;
+		}
+		/* Reset the retries */
+		retries = 0;
+	}
+
+	/*
+	 * Invoke H_HTM call with:
+	 * - operation as htm dump (H_HTM_OP_DUMP_DATA)
+	 * - last three values are address, size and offset
+	 */
+	if (aux_buf->collect_htm_trace) {
+		do {
+			rc = htm_hcall_wrapper(htmflags, nodeindex, nodalchipindex, coreindexonchip,
+				htmtype, H_HTM_OP_DUMP_DATA, virt_to_phys(aux_buf->base),
+				(aux_buf->nr_pages * PAGE_SIZE), aux_buf->head);
+			ret = htm_return_check(rc);
+		} while (ret == -EBUSY && ++retries < 100);
+
+		if (ret > 0) {
+			aux_buf->head += (aux_buf->nr_pages * PAGE_SIZE);
+			perf_aux_output_end(&htm_ctx->handle, (aux_buf->nr_pages * PAGE_SIZE));
+		} else {
+			aux_buf->collect_htm_trace = 0;
+			perf_aux_output_end(&htm_ctx->handle, 0);
+		}
+	}
+
+	return ret;
+}
+
 static int htm_event_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -262,7 +347,77 @@ static void htm_event_del(struct perf_event *event, int flags)
  */
 static void htm_event_read(struct perf_event *event)
 {
-	return;
+	int ret;
+
+	if (event->state != PERF_EVENT_STATE_ACTIVE)
+		return;
+
+	ret = htm_dump_sample_data(event);
+
+	if (ret <= 0)
+		local64_set(&event->count, 0);
+	else
+		local64_set(&event->count, 1);
+}
+
+/*
+ * Set up pmu-private data structures for an AUX area
+ * **pages contains the aux buffer allocated for this event
+ * for the corresponding cpu. rb_alloc_aux uses "alloc_pages_node"
+ * and returns pointer to each page address. Map these pages to
+ * contiguous space using vmap and use that as base address.
+ *
+ * The aux private data structure ie, "struct htm_pmu_buf" mainly
+ * saves
+ * - buf->base: aux buffer base address
+ * - buf->head: offset from base address where data will be written to.
+ * - buf->size: Size of allocated memory
+ */
+static void *htm_setup_aux(struct perf_event *event, void **pages,
+		int nr_pages, bool snapshot)
+{
+	int cpu = event->cpu;
+	struct htm_pmu_buf *buf;
+
+	/* We need at least one page for this to work. */
+	if (!nr_pages)
+		return NULL;
+
+	if (cpu == -1)
+		cpu = raw_smp_processor_id();
+
+	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, cpu_to_node(cpu));
+	if (!buf)
+		return NULL;
+
+	buf->base = pages[0];
+
+	if (!buf->base) {
+		kfree(buf);
+		return NULL;
+	}
+
+	buf->nr_pages = nr_pages;
+	buf->snapshot = false;
+	buf->size = nr_pages << PAGE_SHIFT;
+	buf->head = 0;
+	buf->head_size = 0;
+	buf->htm_stopped = 0;
+	buf->collect_htm_trace = 1;
+	return buf;
+}
+
+/*
+ * free pmu-private AUX data structures
+ */
+static void htm_free_aux(void *aux)
+{
+	struct htm_pmu_buf *buf = aux;
+
+	if (!buf)
+		return;
+
+	kfree(buf);
 }
 
 static void htm_event_start(struct perf_event *event, int flags)
@@ -284,7 +439,10 @@ static struct pmu htm_pmu = {
 	.read        = htm_event_read,
 	.start	     = htm_event_start,
 	.stop	     = htm_event_stop,
-	.capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_EXCLUSIVE,
+	.setup_aux   = htm_setup_aux,
+	.free_aux    = htm_free_aux,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_EXCLUSIVE
+			| PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE,
 };
 
 static int htm_init(void)
-- 
2.52.0



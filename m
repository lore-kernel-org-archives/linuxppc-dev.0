Return-Path: <linuxppc-dev+bounces-23280-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF67EC43602
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 08:38:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqthT71SXz2ygh;
	Wed, 01 Jul 2026 18:38:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782895113;
	cv=none; b=Tj8ko8XxL/sPA24jwLKyrK1kN0Qz2oXqyCoK/clQTiB0l1YT0rqVJD3/xjNcQEbh0IExPEZ4vbmylkPbggzpwPGW3s6pPmBh14C51WPNNBc5dgPQCKkLjnHaEDjE1WpgbVNN1c7w17eBuguMZ8YgQBXojBhUis+iMayb1/VHv901qDXj5bwRiG8QYv8HszfH4L2I5jZlGsP/poAdpns4CtRxC9euXDZySftjbXxpqNjZnwQsoMUUAg9oTsXw7o63VtYs6ETFo3u5GooYgX1spQIFSlsfg3DqgWciTtLHQRR2WK9LA5U0MqA9Rzac7EDTKcrbxUzKnE69Wo5o37nGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782895113; c=relaxed/relaxed;
	bh=npkEsmrgFd6gQ2plwBLxXVWRay/PdccIqlEOETdBHYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCWtFnbsGuzuwQZyNFlvr9ScZrFPZgz8HlomKxsrLtC0jiKkLEG4aC2qM6QBkv6AsYUE3iXIrxqaWDRwC4FTvoMuSVZB1zVWj3cUO9oauP8+/JaeGmutmV+2KZBBH1EXCX2Cnbf2ntDRxdA63B5fLxFCj3JR+lnon/Xy9/G8nDqVPSJWoyB4swi3QbW15cwL2yD87TCNbjK7Y388dKab61bLGTND2qrIOTnqmIvLU2TE9T/I/rKLw4/qlaAMYcShdRUAALdD8ZCpprNi4iHNMbScmKHdXVv5Kj/bwamMYk801L5H0BQPnHhdh9XEnitBD6GDyFYEHF41NYQ9RdoVMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YaR/36pV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YaR/36pV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqthT1F0Gz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:38:32 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618ITcx238703;
	Wed, 1 Jul 2026 08:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=npkEsmrgFd6gQ2plw
	BLxXVWRay/PdccIqlEOETdBHYs=; b=YaR/36pVtu3Sq8GcOrKHRCjQfLK3HTs+P
	4QUrYOx4C2OjThxKk0IXUcKFRdKm7GUSU/8y+nPXlh2NZRglXbnaVSo2+9ovdxw/
	g2n3SNpHF8hLj8+7Yb+7xYqHI7j93m6V8uZQiGm+p1qnNcpVZ3Q+7DpduMgYgcbD
	tbxzsC0oMGhI61ZBvo+wxh5a17yxBYYQQTfavp4kr0BLvOQjJOjAPbMFF20guDoX
	fBSptPiUE8sHTjNffXmFxdUI7ycN0WNhjpDgJI/7UJM1HbtjxFEV5Xd8tM7LCMeF
	afjuWXeB2Xwk2b7dgxKN/qiOJLMIuxHEu7Muyepv6K9h7QNLmjrUg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf32cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:38:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618YcAs021670;
	Wed, 1 Jul 2026 08:38:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk6eh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:38:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618cOf415073772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:38:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C1D42004D;
	Wed,  1 Jul 2026 08:38:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A645C20040;
	Wed,  1 Jul 2026 08:38:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.11])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:38:21 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com
Subject: [PATCH 3/5] powerpc/perf: Capture the HTM memory configuration as part of perf data
Date: Wed,  1 Jul 2026 14:08:04 +0530
Message-Id: <20260701083806.79358-4-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a44d206 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=sal8ioI6UKTfXR3xk6kA:9
X-Proofpoint-ORIG-GUID: vmjLbpeRcwK-stO5WMzQzs0AVxgmzV_K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX1vK4pedquujF
 YDGYxtrlFhqbd7L80PUr8go10m5ULxykNjDemV1Epwe7RNdId/s8FY/PhHqrtAcUfG3YSUshVQE
 SmG7e+9WypzAVf7krMzQbmnuSL4HUsHcKCc+OOJEk6ASKGTmNB4c0S6WdyM+U/aTByw0LpNK5zT
 3lYc0Vuv5tRjRPGo9nbwbW6hS3j8uye+o3hAOMgSstLvJULn+x83u32RQusIIVokAv0Hf1t3CUo
 Ury/Y/FtkEc9Ag62ttQXGYXwEJX9AXhr3kZsHy3yD2Qmj5aJaoR2FG/PP8lc6qMTyMaFzrEH+Ng
 N1RhOPoq8X8BRpv0vy/Xl/TfdFRxrqjZc01NUMo2jfMvqqWwn6cjSVeAyHNaRrnU5L16t4t/lDS
 bS5kytP91eV/smNnUYVilmFqd+62LCQKd06FRS9te2UkaOhjBz1k1kr6vMIR3vZG9H+eE/Po0pd
 EwqQYloUN5k3EoTg6Fw==
X-Proofpoint-GUID: vmjLbpeRcwK-stO5WMzQzs0AVxgmzV_K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX3wlccIXcimj5
 XrQ0+2wS8qi/qpLkLAYYMtuQbRP8nXRpay/Suv8sWxpo4RjcRV1FOU4jbMDUg5tXJB5W6LdreDU
 HHGDp08cEq94+z6Nlg+3usNuC1V3qdM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

H_HTM (Hardware Trace Macro) hypervisor call has capability
to capture SystemMemory Configuration for a system. This
information helps to understand the physical to logical real
address mapping for the logical partitions in the system.

Along with saving HTM trace data, add support to capture
the memory mapping information also using the hcall.
Patch adds support in perf driver to expose HTM memory
configuration as part of perf.data

When monitoring the HTM pmu, auxiliary buffer captures
the "trace" data and SystemMemory Configuration. This
will be post processed later using perf. The size of memory
mapping data captured depends on how large is the system
and how much memory is allocated. To help with relating
and identifying the start of memory mapping data in the
auxiliary buffer, insert two PERF_SAMPLE_RAW records in the
ring buffer. First PERF_SAMPLE_RAW record will mark the
beginning of system memory mapping data in aux buffer. And second
PERF_SAMPLE_RAW record will be written at the end to make the
end of the data in aux buffer and also contains the total size
of the memory map data. These sample raw records
will be used during post processing in perf report.

Use sample raw to mark memory mapping in aux buffer.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
 arch/powerpc/perf/htm-perf.c | 110 ++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
index ae7f469b6840..fe458bc3ec05 100644
--- a/arch/powerpc/perf/htm-perf.c
+++ b/arch/powerpc/perf/htm-perf.c
@@ -76,6 +76,10 @@ struct htm_pmu_buf {
 	bool    full;
 	int	htm_stopped;
 	int	collect_htm_trace;
+	u64	mem_head;
+	void	*htm_mem_buf;
+	u64	mem_start;
+	int	collect_htm_mem;
 };
 
 struct htm_pmu_ctx {
@@ -143,6 +147,86 @@ static ssize_t htm_return_check(int rc)
 	return -EINVAL;
 }
 
+static int htm_collect_memory_config(struct perf_event *event,
+					struct htm_pmu_buf *aux_buf)
+{
+	struct perf_sample_data data;
+	struct perf_raw_record raw;
+	struct pt_regs regs;
+	u64 *num_entries;
+	u64 to_copy = 0;
+	int htm_val;
+	long rc;
+	int ret;
+	int retries = 0;
+	size_t size;
+	size_t space_to_end = aux_buf->size - aux_buf->mem_head;
+
+	/* Capture HTM system memory configuration in aux buffer */
+	do {
+		rc = htm_hcall_wrapper(htmflags, 0, 0, 0,
+				0, H_HTM_OP_DUMP_SYSMEM_CONF, virt_to_phys(aux_buf->htm_mem_buf),
+				PAGE_SIZE, aux_buf->mem_start);
+		ret = htm_return_check(rc);
+	} while (ret == -EBUSY && ++retries < 100);
+
+	/* Return once there is no more data in HTM buffer */
+	if (ret <= 0) {
+		perf_sample_data_init(&data, 0, event->hw.last_period);
+		memset(&raw, 0, sizeof(raw));
+		memset(&regs, 0, sizeof(regs));
+
+		htm_val = (aux_buf->head/((aux_buf->nr_pages * PAGE_SIZE)));
+		raw.frag.data = &htm_val;
+		raw.frag.size = sizeof(htm_val);
+
+		aux_buf->collect_htm_mem = 0;
+		perf_sample_save_raw_data(&data, event, &raw);
+		perf_event_overflow(event, &data, &regs);
+		return 0;
+	}
+
+	/*
+	 * Find how much data to copy to aux buffer
+	 * If hcall returned H_PARTIAL, set mem_start to
+	 * indicate next offset of memory to read from
+	 */
+	num_entries = aux_buf->htm_mem_buf + 0x10;
+	aux_buf->mem_start = be64_to_cpu(*(u64 *)(aux_buf->htm_mem_buf + 0x8));
+
+	to_copy = 32 + (be64_to_cpu(*num_entries) * 32);
+
+	if (to_copy <= space_to_end) {
+		if ((to_copy + aux_buf->mem_head) >= ((aux_buf->nr_pages * PAGE_SIZE)/2)) {
+			/*
+			 * Crossing 50% threshold - flush and wrap.
+			 * Write current chunk, then pad to end of buffer.
+			 * This ensures next write starts at beginning with
+			 * perf head also at beginning (synchronized).
+			 */
+			memcpy(aux_buf->base + aux_buf->mem_head, aux_buf->htm_mem_buf, to_copy);
+			aux_buf->mem_head = 0;
+
+			/*
+			 * Return space_to_end to include padding.
+			 * Perf will advance head to end (wrapping to 0),
+			 * matching our mem_head position.
+			 */
+			size = space_to_end;
+		} else {
+			/* Normal case - chunk fits without crossing threshold */
+			memcpy(aux_buf->base + aux_buf->mem_head, aux_buf->htm_mem_buf, to_copy);
+			aux_buf->mem_head += to_copy;
+			size = to_copy;
+		}
+	} else {
+		return 0;
+	}
+
+	/* Return non-zero to indicate that one record is written to aux buffer */
+	return size;
+}
+
 static int htm_dump_sample_data(struct perf_event *event)
 {
 	struct htm_pmu_ctx *htm_ctx = this_cpu_ptr(&htm_pmu_ctx);
@@ -162,7 +246,7 @@ static int htm_dump_sample_data(struct perf_event *event)
 	if (!aux_buf)
 		return -1;
 
-	if (!aux_buf->collect_htm_trace) {
+	if (!aux_buf->collect_htm_mem && !aux_buf->collect_htm_trace) {
 		perf_aux_output_end(&htm_ctx->handle, 0);
 		return 0;
 	}
@@ -202,12 +286,17 @@ static int htm_dump_sample_data(struct perf_event *event)
 		if (ret > 0) {
 			aux_buf->head += (aux_buf->nr_pages * PAGE_SIZE);
 			perf_aux_output_end(&htm_ctx->handle, (aux_buf->nr_pages * PAGE_SIZE));
+			return ret;
 		} else {
 			aux_buf->collect_htm_trace = 0;
-			perf_aux_output_end(&htm_ctx->handle, 0);
 		}
 	}
 
+	if (aux_buf->collect_htm_mem) {
+		ret = htm_collect_memory_config(event, aux_buf);
+		perf_aux_output_end(&htm_ctx->handle, ret);
+	}
+
 	return ret;
 }
 
@@ -397,6 +486,13 @@ static void *htm_setup_aux(struct perf_event *event, void **pages,
 		return NULL;
 	}
 
+	buf->htm_mem_buf = kmalloc_node(PAGE_SIZE, GFP_KERNEL, cpu_to_node(cpu));
+	if (!buf->htm_mem_buf) {
+		kfree(buf);
+		pr_err("Failed to allocate htm mem buf\n");
+		return NULL;
+	}
+
 	buf->nr_pages = nr_pages;
 	buf->snapshot = false;
 	buf->size = nr_pages << PAGE_SHIFT;
@@ -404,6 +500,9 @@ static void *htm_setup_aux(struct perf_event *event, void **pages,
 	buf->head_size = 0;
 	buf->htm_stopped = 0;
 	buf->collect_htm_trace = 1;
+	buf->mem_head = 0;
+	buf->collect_htm_mem = 1;
+	buf->mem_start = 0;
 	return buf;
 }
 
@@ -413,10 +512,17 @@ static void *htm_setup_aux(struct perf_event *event, void **pages,
 static void htm_free_aux(void *aux)
 {
 	struct htm_pmu_buf *buf = aux;
+	void *free_mem;
 
 	if (!buf)
 		return;
 
+	free_mem = buf->htm_mem_buf;
+	buf->htm_mem_buf = NULL;
+
+	smp_mb();
+
+	kfree(free_mem);
 	kfree(buf);
 }
 
-- 
2.52.0



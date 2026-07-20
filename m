Return-Path: <linuxppc-dev+bounces-24473-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E946C44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:45:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3cc80d20z309L;
	Mon, 20 Jul 2026 20:45:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784544328;
	cv=none; b=jcDzyg/Onw92meSx/Gc+e5Rd6rmvLa9G5/m90SDs3/nA3B+wFN7/YSyW+i5bNsUpvVafm5Q39Cgovbg/QdK9LrzNAflF8gZLdXnLxSWQurvkl7G9Awv9vrLGegVaswuo8NWqLCNsavY5/V/9+uqcX0o/9AtWOuyG8HALvcG/xPIacpJTR/iQStUsNVBxqATG3gk6goxcUxV8aNAQlI+XGDJWEC3AqweNbjoFL59jnUI97i5fwXX93yu8uptzz9ZBehlIbu3B3EZqxt/7WsX+UjcmmodpnlhgZNJGGqcHvTOlv5hE6wTZ6v3G8tMV8hHnXiGXK+zA5DpIoK4YpNUPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784544328; c=relaxed/relaxed;
	bh=QMVEGbLwtIbPPwm3EazxWetMme9AhebRsRVfMdI5y8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmYx5WSBcrg5ky5yDbA6OqL5/1ORt+zm4FuRyxJtW609eod9NmlkrYWMWoFIAoGbNAusOJzJYInyrZoECpqjYF4CVpbQhQuA1aY+7Z138dOn4kELXUPD3kaki3+1OM+eIYv9hcOtCVPpiz1ZXefUseov6LDDQ7MNY277Sr5MTcQIVQnoWsqfuwJTbGsa8OO0w6h30Z3jGeF9VeXEu7b+s+ImlYPSzaAsnZgja+pRAxOnnQTNzeCZXoPK8qQ/q5dsFcslgdoDnGAmDkjPSuO5JE0satSXmSxT/czwZH/XEmQ5P2xwCtSYC2EO25ztXU8kJgYcBKGa3lruVbNNLVnZ5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gt3OBlr2; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gt3OBlr2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3cc71Wg4z2yll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 20:45:26 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KACGb11906658;
	Mon, 20 Jul 2026 10:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QMVEGbLwtIbPPwm3E
	azxWetMme9AhebRsRVfMdI5y8U=; b=gt3OBlr2OiE9GXO3C00MBC9P/bcAsaJOb
	nHxm2vs6GsqFuUDGxB44dSKlZRbL9xvBehUhG2DP1t8DCqhi27mQHICGvcWgvbkh
	F5GXA27x3ACaBLNV8kamsrAZeLRkPxxoOQlF7ICZ4BiF8ph4VNpe6niNmN1ZuEwR
	NK4BcPqOl07QOXOb+iMRcFU0pbq2eKfY9l10W8v4MA9j6nBjRs1zWfN4DOby10s8
	DVq2vvuitRJu6mFIJECENxMnoV8Rd0ql0XVorM9tnjmpg6uON3tdCR3SAdWKGhxX
	a7hMORAZsky8n6AGta7vwpBjCHLhRFzzWC1h0coHN+RCIS4OtuGQg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ab7155-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAYcU4026290;
	Mon, 20 Jul 2026 10:45:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy4ws4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAjIbG28770584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:45:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AABA2004E;
	Mon, 20 Jul 2026 10:45:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D1F12004B;
	Mon, 20 Jul 2026 10:45:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:45:15 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V2 3/6] powerpc/perf: Add AUX buffer management to capture HTM trace data
Date: Mon, 20 Jul 2026 16:14:44 +0530
Message-Id: <20260720104447.11843-4-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX3umHg+9WHe66
 0ICNgo39saHoUrVITb2XWRvoyYmzBBhiPSggdm4RUDihUqCIofqs/XhnrE08Kh9WS5TvtK8ScKA
 +HEtk4SrT9iSpNwhha8MIywoumiBjM7+f9nSyRbg3yT/is754jUyyH54zf1nDGDhDIPaYOv3+ZS
 V/yIY8B66e6KNmcrWrqm3IR306mbo2GjFy+sV23KO5ey+Bze1aDvEy71xqKZqb5omQDY56jkS6H
 7OfVr8T0tcSoCJA7ndblA+ZqAyrCfG74ipx+/thi6/wWZrodCbLV7+Ke38W71h5+UJLbecv/ktq
 D/vUHxmxYv16J/7vgPbTjvdh8zRHYSyzJDeSLTSnio4Lr5psvWuPVLyJEB3k97Oum7F04uPStze
 UBecKORvQ/ChroX2nv87Ow81utGpraJqGhu+kuqNtOkfjVDUovrkLSTZEDQclz4NIAtQbmzOLLJ
 pqmKrOIHcoUPHeI4A4A==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5dfc44 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=dCW6ix3TRNtaVsfqAvQA:9
X-Proofpoint-ORIG-GUID: thQvBvq4OWl3Q-yhWlhMO_KmdAF0dz4N
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX6Cn48E/zXk04
 ueC+vCPTTSOOyhAWfj3SkKMjVaAn9+Y8Q4qFvLqLff9QyXkl867qJ6UVCptbBzx7mjksaTgmjrf
 DWpbRdB0OUSX73TFeHaqlDAMgUSIa3M=
X-Proofpoint-GUID: thQvBvq4OWl3Q-yhWlhMO_KmdAF0dz4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200119

Implement support for auxiliary (AUX) ring buffers in the HTM PMU driver.
This enables high-volume trace data to be streamed directly into a perf
AUX buffer for deferred post-processing by the perf tool.

Introduce the PMU data structures htm_pmu_buf and htm_pmu_ctx, and
implement the core lifecycle hooks:

  htm_setup_aux():  Allocates per-CPU context and records the AUX buffer
                    base, head, and size for the active trace window.
  htm_free_aux():   Releases the PMU-private tracking allocations.

The perf core AUX allocator (rb_alloc_aux) may return a page array with
physical fragmentation gaps.  H_HTM_OP_DUMP_DATA operates on raw physical
addresses and requires a strictly contiguous region; crossing a gap would
cause silent memory corruption.

To prevent this, opt into PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE
to request large, physically contiguous allocations, and perform a
page-by-page physical continuity scan in htm_event_read() before each
H_HTM_OP_DUMP_DATA call.  The scan verifies that
virt_to_phys(page[n]) + PAGE_SIZE == virt_to_phys(page[n+1]) and
breaks the loop on the first discontinuity, ensuring the dump to the
verified safe window.

Update htm_event_read() to set event->count to 1 when data is present
in the buffer and 0 when the stream is exhausted.  This binary flag is
used by the perf tool drain hook to decide whether another read pass is
needed before closing the event.  It does not represent an instruction
or cycle count; the actual trace records are decoded in userspace.

HTM target identity and tracing state are kept in event->pmu_private
(htm_target_id).  AUX-private state holds only buffer metadata and
dump progress; htm_target_id.tracing_active remains the source for
tracing state.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V2:
- Opted into PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE to
  request physically contiguous allocations, which H_HTM_OP_DUMP_DATA
  requires.  V1 didn't handle no contiguity requirement.
- Added a page-by-page physical-continuity scan in htm_event_read()
  before every H_HTM_OP_DUMP_DATA call.  The scan verifies that
  virt_to_phys(page[n]) + PAGE_SIZE == virt_to_phys(page[n+1]) and
  stops at the first gap, bounding the dump to a verified safe window.
  V1 had no such guard and could silently corrupt memory across gaps.
- event->count is now set to 1 when trace data is present and 0 when
  the stream is exhausted.  The perf tool uses this as a drain signal.
  V1 relied on a separate arch_record__collect_final_data callback loop
  with explicit evlist__enable cycling; this version doesn't need
  explicit evlist__enable

 arch/powerpc/perf/htm-perf.c | 216 ++++++++++++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
index 01c6bd2104cf..edfca63e1e9b 100644
--- a/arch/powerpc/perf/htm-perf.c
+++ b/arch/powerpc/perf/htm-perf.c
@@ -95,6 +95,23 @@ static inline void parse_htm_config(u64 config, struct htm_config *cfg)
 	cfg->coreindexonchip = (config >> 20) & 0xff;
 }
 
+struct htm_pmu_buf {
+	int     nr_pages;
+	bool    snapshot;
+	void    *base;
+	void	**pages;
+	u64	head;
+	u64     size;
+	int     collect_htm_trace;
+	u64	trace_records;
+};
+
+struct htm_pmu_ctx {
+	struct perf_output_handle handle;
+};
+
+static DEFINE_PER_CPU(struct htm_pmu_ctx, htm_pmu_ctx);
+
 /*
  * Check the return code for H_HTM hcall.
  * Return 1 if either H_PARTIAL or H_SUCCESS is returned.
@@ -372,8 +389,202 @@ static void htm_event_del(struct perf_event *event, int flags)
 	/* pmu_private freed by event->destroy = reset_htm_active */
 }
 
+static int htm_dump_sample_data(struct perf_event *event)
+{
+	struct htm_pmu_ctx *htm_ctx = this_cpu_ptr(&htm_pmu_ctx);
+	struct htm_target_id *target = event->pmu_private;
+	struct htm_pmu_buf *aux_buf;
+	struct htm_config cfg = target->cfg;
+	u64 chunk_size, dump_offset, page_index, page_offset;
+	u64 max_contiguous_bytes, expected_phys, scan_index, actual_phys;
+	u64 hypervisor_target_phys;
+	void *target_page_virt;
+	int ret = 0, retries = 0;
+	long rc;
+
+	/* Start AUX transaction session framework */
+	aux_buf = perf_aux_output_begin(&htm_ctx->handle, event);
+	if (!aux_buf)
+		return 0;
+
+	if (!aux_buf->collect_htm_trace) {
+		perf_aux_output_end(&htm_ctx->handle, 0);
+		return 0;
+	}
+
+	if (target->tracing_active == HTM_TRACING_ACTIVE) {
+		htm_event_stop(event, 0);
+		if (target->tracing_active == HTM_TRACING_ACTIVE) {
+			perf_aux_output_end(&htm_ctx->handle, 0);
+			return -EAGAIN;
+		}
+	}
+
+	/* Derive the exact target destination point directly out of active ring pointers */
+	dump_offset = htm_ctx->handle.head & (aux_buf->size - 1);
+	page_index = dump_offset >> PAGE_SHIFT;
+	page_offset = dump_offset & (PAGE_SIZE - 1);
+
+	/*
+	 * Assess constraints regarding space remaining across the mapping
+	 * context boundary
+	 */
+	chunk_size = htm_ctx->handle.size;
+	chunk_size &= PAGE_MASK;
+
+	if (chunk_size > (aux_buf->size - dump_offset))
+		chunk_size = aux_buf->size - dump_offset;
+
+	/*
+	 * HTM driver uses these capabilities:
+	 * PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE
+	 * the core perf ring-buffer allocator (rb_alloc_aux) tries to allocate
+	 * physically contiguous page block. If not available, it tries to allocate
+	 * largest possible contiguous block.
+	 *
+	 * Example: If we ask perf for 1024 pages (64MB), the kernel executes a loop
+	 * inside rb_alloc_aux() to fulfill that request using the buddy allocator. it
+	 * always tries to grab the largest possible contiguous block of memory it can
+	 * find first, then takes the next largest, and repeats until request is
+	 * completely filled. Here while writing to aux buffer, to eliminate any
+	 * virtual or physical boundary overruns, check for the page boundary.
+	 *
+	 * Dynamically scan forward page-by-page from our active page_index to
+	 * calculate the absolute boundary limit of this current physically
+	 * contiguous block chunk. Prevents hypervisor macro overruns across
+	 * asymmetrical fragmentation gaps.
+	 */
+	max_contiguous_bytes = PAGE_SIZE - page_offset;
+	scan_index = page_index + 1;
+	expected_phys = (u64)virt_to_phys(aux_buf->pages[page_index]) + PAGE_SIZE;
+
+	while (scan_index < aux_buf->nr_pages && max_contiguous_bytes < chunk_size) {
+		actual_phys = (u64)virt_to_phys(aux_buf->pages[scan_index]);
+
+		if (actual_phys != expected_phys)
+			break; /* Intersected a fragmentation boundary block link! */
+
+		max_contiguous_bytes += PAGE_SIZE;
+		expected_phys += PAGE_SIZE;
+		scan_index++;
+	}
+
+	/* Bound transfer length tightly within the validated contiguous window */
+	if (chunk_size > max_contiguous_bytes)
+		chunk_size = max_contiguous_bytes;
+
+	if (!chunk_size) {
+		aux_buf->collect_htm_trace = 0;
+		perf_aux_output_end(&htm_ctx->handle, 0);
+		return 0;
+	}
+
+	/*
+	 * Compute the precise base target address using
+	 * localized page offset rules
+	 */
+	target_page_virt = aux_buf->pages[page_index];
+	hypervisor_target_phys = (u64)virt_to_phys(target_page_virt) + page_offset;
+
+	do {
+		/*
+		 * Invoke H_HTM call with:
+		 * - operation as htm dump (H_HTM_OP_DUMP_DATA)
+		 * - last three values are address, size and offset
+		 */
+		rc = htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
+				cfg.coreindexonchip, cfg.htmtype, H_HTM_OP_DUMP_DATA,
+				hypervisor_target_phys, chunk_size, aux_buf->head);
+		ret = htm_return_check(rc);
+	} while (ret == -EBUSY && ++retries < MAX_RETRIES);
+
+	if (ret > 0) {
+		aux_buf->head += chunk_size;
+		aux_buf->trace_records++;
+		perf_aux_output_end(&htm_ctx->handle, chunk_size);
+		return ret;
+	}
+
+	aux_buf->collect_htm_trace = 0;
+	perf_aux_output_end(&htm_ctx->handle, 0);
+	return ret;
+}
+
 static void htm_event_read(struct perf_event *event)
 {
+	int ret;
+
+	/*
+	 * Update event->count as a binary indicator:
+	 * 1 if data was dumped into the
+	 * AUX buffer, 0 otherwise. Actual trace record
+	 * decoding is left to userspace.
+	 */
+	ret = htm_dump_sample_data(event);
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
+ * and returns pointer to each page address.
+ * PMU capabilities: PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE
+ * to try get closest possible physically contiguous page blocks.
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
+	buf->nr_pages = nr_pages;
+	buf->snapshot = snapshot;
+	buf->size = (u64)nr_pages << PAGE_SHIFT;
+	buf->pages = pages;
+
+	buf->base = pages[0];
+	if (!buf->base) {
+		kfree(buf);
+		return NULL;
+	}
+
+	buf->collect_htm_trace = 1;
+	buf->trace_records = 0;
+	buf->head = 0;
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
 
 static struct pmu htm_pmu = {
@@ -386,7 +597,10 @@ static struct pmu htm_pmu = {
 	.read         = htm_event_read,
 	.start        = htm_event_start,
 	.stop         = htm_event_stop,
-	.capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_EXCLUSIVE,
+	.setup_aux    = htm_setup_aux,
+	.free_aux     = htm_free_aux,
+	.capabilities = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_EXCLUSIVE
+			| PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE,
 };
 
 static int htm_init(void)
-- 
2.43.0



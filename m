Return-Path: <linuxppc-dev+bounces-25001-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88DBC54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 12:38:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9BhG0TX4z2yqs;
	Wed, 29 Jul 2026 22:38:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785328702;
	cv=none; b=AXO1bollfqmUF5blQbOCwQmk+9GsZj6yPIGK69GcHj36PIZPUCNGIhkNSgm9A7q+nOxpcZ78hFalcvvh+kXeUq/tp/myYYh9XOhFOXTid06AtL2HjP8e5PlB9pGp5FcCy+4Rz48dzZtoHOTuTy9h3yUjgiqXxc5vnX3mBQWqcGSIhAFlTvZuxw1Cp3rIh9sEq7x21MLpq2J/xWgA42qIL/u9Cv6anLQUoUoUzpg3crNMx0YlG800d8OUdJUk6wM0LPayw9Qg03ys1UgLLj9Su4rmNSAbWfQbs8CpNlHgJpq7PoBge4SqyNSnbuLf2CzKHS+j9ZpypGRlOzbWvr2MXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785328702; c=relaxed/relaxed;
	bh=d19cftgp9K/1so6ookkGjBAMHf/pvDTWmC7RQblNtpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLLjPkFIHF6d+vBe+aFhm+Jb5J81D6yCeuQD3sZdu2+bBWFySnAo61J3zKkBoHwr7rkK2IVfOAMl0lYEdePwbt/zH2iYjWyAI7oM4HhDgTsqZ88LDM5zON/nHxHJ5mFa52gEF13WCubiTPEEq71NjjMoPH++WNWTEx6na0mNgU/mavnf6IF27vOaU9RZ8oZ5E2wrYnMKl94Nd28pATop9v3Fsr2XjD1/GVJsq1iDhMhi+RCJXO3PyvjLVyjANkux8xOEUg183eQwUeIG++Nd2KT0jmT6R525tv4RirAK6DdPzCR+0E14bJTPPS4riwmYweFdHRKc43/cIUX1K0Ss2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dAE67pku; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dAE67pku;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9BhD6j7gz2yn2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 22:38:20 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBI9Z63956507;
	Wed, 29 Jul 2026 12:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=d19cftgp9K/1so6oo
	kkGjBAMHf/pvDTWmC7RQblNtpE=; b=dAE67pkufMmmF3t1Gi8daVsRbLRJfTx6W
	EH+MfgRNy4rKf3Cas+soNJq1lQeloPO5jzH+tzAgHmmHP2oSLK//jlHqWZCzb/8H
	XHTdV8OT7L1IDBWo5gSMJec4tHLl3PI1644tGWlNBLyEu3hG3zAjV+VbJoLxdFml
	Izd4dHC9VyoLpwmRyTF3kJOm2hBMQM0LfHcxOR8hBL8jcYG2OG9vW6ca67tG615A
	GPGuScBMuohjqgPYovmJ6BtUqra6Xu8/UKAoDXMdiHrp7JGr3+LDZBB5+vUs/j75
	FKijPfc/NsVkppwurpj5NZIbsSsnZ5Igews1KLYO8U/MJwGoYFv7g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nsuen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:38:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCQIlo031858;
	Wed, 29 Jul 2026 12:38:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk6pw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:38:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCcBvl25952822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:38:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7C3820040;
	Wed, 29 Jul 2026 12:38:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B7D020043;
	Wed, 29 Jul 2026 12:38:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 12:38:09 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V4 3/6] powerpc/perf: Add AUX buffer management to capture HTM trace data
Date: Wed, 29 Jul 2026 18:07:49 +0530
Message-Id: <20260729123752.63010-4-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260729123752.63010-1-atrajeev@linux.ibm.com>
References: <20260729123752.63010-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX8IgEacpK03zV
 bNSOidieidOr5ZgAoCUAGbJru9ZsgHeShoCcDuDCOhEcSgg0Yt5Tcwq1B+GQGdVw2WNrr4XTDpE
 UqPOH5duCEElB/h8YJB7y80uzeQVBDE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX/bmyUMbyId8V
 1OkpuwNM6HGK6/tZQ49IsHkDoEPCWkfnwzMST7DJT0zjev+tl/zeyokoNIt05JQKrFugWxv7hen
 BZcmR00Z/U1znKDSpxkZCh34Q5+VovsP+FQ/Xr0aApDCAGDC6uA/15oUtfet3EWc/VYfdFFUO2m
 9O4OQ85GML3WS3bhV+QJ6h5BdEYRNizdg8hojAeg4bNiALMktPC2erdoo8AKzuhx5dSu5YuupPW
 WZERfoyWSpOfCAnZaCPbVYmbUvqW/+Bmst36cndfb34MC0uYQGRKkOZW5rZf94SCiHVtHswCIjk
 TgzKXEXLnLvmNn5BzaKUkRaoEHE9FN7fYHLo32+AGFcZhhXGPnt5QnmK8m3UVIeYXbnyv0q4nQJ
 k6KEGYcCiRioC6aTgTjALttNYd00MpwRd0PD929OzPutzSmdOtxvuWDkwphRmP4+uhfBrEH+aV4
 ZrA9a/KPrdBQNHpGCvQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a69f43a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=wbqx9YorgkV9QHrDWlcA:9
X-Proofpoint-GUID: OH4Zaxp6F9oFaboL5AAmdo9tbgAGm0Te
X-Proofpoint-ORIG-GUID: OH4Zaxp6F9oFaboL5AAmdo9tbgAGm0Te
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

Implement support for auxiliary (AUX) ring buffers in the HTM PMU driver.
This enables high-volume trace data to be streamed directly into a perf
AUX buffer for deferred post-processing by the perf tool.

Introduce the PMU data structures htm_pmu_buf and htm_pmu_ctx, and
implement the core lifecycle hooks:

  htm_setup_aux():  Allocates per-CPU context and records the AUX buffer
                    base, head, and size for the active trace window.
  htm_free_aux():   Releases the PMU-private tracking allocations.

htm_pmu_ctx embeds a struct perf_output_handle as a per-CPU variable,
following the established upstream pattern.  Reentrancy is handled by
perf_aux_output_begin() itself via rb->aux_nest: when a nested caller
(e.g. from NMI context) detects that aux_nest is already non-zero, it
falls through to the err path, which sets the *nested* handle->event to
NULL and returns NULL to the nested caller.  The outer handle is never
touched; its handle->event remains valid throughout the outer
perf_aux_output_end() call.

Physical contiguity requirement:

   The perf core AUX allocator (rb_alloc_aux) may return a page array with
   physical fragmentation gaps.  H_HTM_OP_DUMP_DATA operates on raw
   physical addresses and requires a strictly contiguous region; crossing
   a gap would cause silent memory corruption.

   To prevent this, opt into PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE
   to request large, physically contiguous allocations, and perform a
   page-by-page physical continuity scan in htm_event_read() before each
   H_HTM_OP_DUMP_DATA call.  The scan verifies that
   virt_to_phys(page[n]) + PAGE_SIZE == virt_to_phys(page[n+1]) and
   breaks the loop on the first discontinuity, ensuring the dump to the
   verified safe window.

htm_dump_sample_data() returns the record count directly (already
divided by the per-format record size) so htm_event_read() uses the
value without format knowledge:
  - AUX trace path:   chunk_size / 128  (128-byte HTM records)
  - Memory cfg path:  to_copy    /  32  (32-byte entries, patch 4)

htm_event_read() sets event->count as follows:
  - ret > 0: record count written; used directly as event->count.
  - ret == -ENOSPC (AUX ring buffer full): event->count = 1 so the
    perf tool drain loop keeps retrying after the consumer drains the
    buffer.
  - all other non-success paths: event->count = 0 so the drain loop
    stops cleanly.
event->count does not represent an instruction or cycle count; actual
trace records are decoded in userspace by the perf tool.

HTM target identity and tracing state are kept in event->pmu_private
(htm_target_id).  AUX-private state holds only buffer metadata and
dump progress; htm_target_id.tracing_active remains the source for
tracing state.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V4:
- htm_event_start(): on a genuine start (not PERF_EF_RELOAD), open a brief
  perf_aux_output_begin()/perf_aux_output_end(0) transaction to reset
  collect_htm_trace=1 and head=0 on the AUX buffer.  Without this,
  collect_htm_trace cleared by a prior hard hcall error would permanently
  prevent trace data from being written for all subsequent sessions.
- htm_setup_aux(): reject snapshot (overwrite) mode by returning NULL when
  snapshot is true.  In overwrite mode perf_aux_output_begin() leaves
  handle->size as zero, which causes htm_dump_sample_data() to return ENOSPC
  on every call and htm_event_read() to set event->count=1, creating an
  infinite drain loop in userspace.  Returning NULL causes perf_event_open()
  to return EINVAL to the caller.
- Commit body: clarified the reentrancy description to make explicit that
  on a nested perf_aux_output_begin() call (e.g. from NMI context), it is
  the *nested* handle->event that is set to NULL in the err path, not the
  outer handle.  The outer handle->event remains valid throughout the outer
  perf_aux_output_end() call.

Changes in V3:
- Added a dedicated Physical contiguity requirement section and a full
  per-condition htm_dump_sample_data() return values and event->count
  table in the commit body, covering all five exit paths (success,
  -ENOSPC, H_NOT_AVAILABLE, H_LONG_BUSY_*/hard error, stop-failed
  before dump). V2 had a brief paragraph.
- htm_dump_sample_data() return type changed from int to ssize_t; ret
  locals in htm_dump_sample_data() and htm_event_read() likewise changed
  to ssize_t. Prevents truncation of the upper 32 bits of chunk_size on
  64-bit PowerPC.
- Success path now returns (ssize_t)(chunk_size / 128) , the number
  128-byte HTM trace records - rather than raw chunk_size bytes.
  htm_event_read() uses the value directly (local64_set(&event->count,
  ret)) without any further division, keeping it free of format
  knowledge. The same contract is extended to the memory-config path
  in patch 4 (to_copy / 32).
- Removed the unused trace_records field from struct htm_pmu_buf and
  its initialisation and increment sites. V2 carried the field as
  dead code.
- Added event->count does not represent an instruction or cycle count
  sentence to both the commit body and the in-code comment
  in htm_event_read().

Changes in V2:
- Opted into PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE to
  request physically contiguous allocations, which H_HTM_OP_DUMP_DATA
  requires.  V1 had no contiguity requirement and could silently
  corrupt memory if the allocator returned a fragmented page array.
- Added a page-by-page physical-continuity scan in htm_event_read()
  before every H_HTM_OP_DUMP_DATA call.  The scan verifies that
  virt_to_phys(page[n]) + PAGE_SIZE == virt_to_phys(page[n+1]) and
  stops at the first gap, bounding the dump to a verified safe window.
- htm_dump_sample_data() now returns a record count (already divided
  by the per-format record size) rather than raw bytes, so
  htm_event_read() uses the value directly without format knowledge.
  AUX trace path returns chunk_size / 128; the memory config path
  added in patch 4 will return to_copy / 32.  Three-way semantics:
  ret > 0 -> count = ret; ret == -ENOSPC -> count = 1; otherwise
  count = 0.  The V1 arch_record__collect_final_data callback loop
  is replaced by this mechanism.
- Removed the unused trace_records field from htm_pmu_buf; htm_dump_
  sample_data() now returns chunk_size on success so htm_event_read()
  can derive the record count directly.
- Introduced distinct htm_pmu_buf and htm_pmu_ctx structures; V1 used a
  single struct htm_pmu_buf for both purposes.

 arch/powerpc/perf/htm-perf.c | 290 ++++++++++++++++++++++++++++++++++-
 1 file changed, 289 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
index 0d1960e299e6..656f9b5aa38d 100644
--- a/arch/powerpc/perf/htm-perf.c
+++ b/arch/powerpc/perf/htm-perf.c
@@ -95,6 +95,22 @@ static inline void parse_htm_config(u64 config, struct htm_config *cfg)
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
@@ -296,6 +312,29 @@ static void htm_event_start(struct perf_event *event, int flags)
 	if (ret > 0) {
 		target->tracing_active = HTM_TRACING_ACTIVE;
 		event->hw.state &= ~PERF_HES_STOPPED;
+
+		/*
+		 * On a genuine start (not a context-switch RELOAD), re-arm the AUX
+		 * buffer so that a subsequent htm_dump_sample_data() call can write
+		 * data.  collect_htm_trace is cleared on any hard hcall error; without
+		 * this reset, restarting the event via ioctl(ENABLE) after such an
+		 * error would permanently drop all future trace data.
+		 *
+		 * Open a brief AUX transaction to obtain the buffer pointer, reset
+		 * collect_htm_trace and head, then close with size=0 (no data
+		 * committed).
+		 */
+		if (!(flags & PERF_EF_RELOAD)) {
+			struct htm_pmu_ctx *htm_ctx = this_cpu_ptr(&htm_pmu_ctx);
+			struct htm_pmu_buf *aux_buf;
+
+			aux_buf = perf_aux_output_begin(&htm_ctx->handle, event);
+			if (aux_buf) {
+				aux_buf->collect_htm_trace = 1;
+				aux_buf->head = 0;
+				perf_aux_output_end(&htm_ctx->handle, 0);
+			}
+		}
 	}
 }
 
@@ -465,8 +504,254 @@ static void htm_event_del(struct perf_event *event, int flags)
 	/* pmu_private freed by event->destroy = reset_htm_active */
 }
 
+static ssize_t htm_dump_sample_data(struct perf_event *event)
+{
+	struct htm_pmu_ctx *htm_ctx = this_cpu_ptr(&htm_pmu_ctx);
+	struct htm_target_id *target = event->pmu_private;
+	struct htm_pmu_buf *aux_buf;
+	struct htm_config cfg = target->cfg;
+	u64 chunk_size, dump_offset, page_index, page_offset;
+	u64 max_contiguous_bytes, expected_phys, scan_index, actual_phys;
+	u64 hypervisor_target_phys;
+	void *target_page_virt;
+	ssize_t ret = 0;
+	int retries = 0;
+	long rc;
+
+	/* Start AUX transaction session framework */
+	aux_buf = perf_aux_output_begin(&htm_ctx->handle, event);
+	if (!aux_buf)
+		return 0;
+
+	if (!aux_buf->collect_htm_trace) {
+		/*
+		 * collect_htm_trace is cleared on hcall error and reset to 1
+		 * in htm_event_start() when tracing restarts.  If it is still
+		 * 0 here the event was disabled due to a prior hard error;
+		 * end the AUX transaction and return 0 so the drain loop stops.
+		 */
+		perf_aux_output_end(&htm_ctx->handle, 0);
+		return 0;
+	}
+
+	if (target->tracing_active == HTM_TRACING_ACTIVE) {
+		htm_event_stop(event, 0);
+		if (target->tracing_active == HTM_TRACING_ACTIVE) {
+			/*
+			 * H_HTM_OP_STOP failed.
+			 * Cannot dump data while the trace is still running.
+			 * Return -EIO to signal a non-retriable hardware failure;
+			 * htm_event_read() will set event->count=0 and the drain
+			 * loop will stop cleanly.
+			 */
+			perf_aux_output_end(&htm_ctx->handle, 0);
+			return -EIO;
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
+		/*
+		 * No space in the AUX ring buffer right now.  Leave
+		 * collect_htm_trace set. Return -ENOSPC so htm_event_read()
+		 * keeps event->count non-zero, signalling to the caller that
+		 * collection is still ongoing and another pmu->read pass
+		 * should be attempted once the consumer has drained the buffer.
+		 */
+		perf_aux_output_end(&htm_ctx->handle, 0);
+		return -ENOSPC;
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
+		perf_aux_output_end(&htm_ctx->handle, chunk_size);
+		/*
+		 * Return the number of 128-byte HTM trace records written.
+		 * Dividing here keeps htm_event_read() free of format
+		 * knowledge: it can simply use the returned count directly,
+		 * regardless of which data path (AUX trace or memory config)
+		 * produced it.
+		 */
+		return (ssize_t)(chunk_size / 128);
+	}
+
+	/*
+	 * Hcall failed.  All non-success paths end collection for this
+	 * buffer session.
+	 */
+	aux_buf->collect_htm_trace = 0;
+	perf_aux_output_end(&htm_ctx->handle, 0);
+	return ret;
+}
+
 static void htm_event_read(struct perf_event *event)
 {
+	ssize_t ret;
+
+	ret = htm_dump_sample_data(event);
+	/*
+	 * htm_dump_sample_data() returns the record count directly
+	 * (already divided by the per-format record size):
+	 *   AUX trace path:   chunk_size / 128  (128-byte HTM records)
+	 *   Memory cfg path:  to_copy    /  32  (32-byte entries)
+	 *
+	 * ret > 0:        record count written; use directly as event->count.
+	 * ret == -ENOSPC: AUX buffer full, hypervisor stream intact;
+	 *                 count = 1 so the drain loop keeps retrying
+	 *                 once the consumer has drained the buffer.
+	 * ret <= 0:       EOF, stop failed, or hard error; count = 0
+	 *                 so the drain loop stops cleanly.
+	 *
+	 * event->count does not represent an instruction or cycle count;
+	 * actual trace records are decoded in userspace by the perf tool.
+	 */
+	if (ret > 0)
+		local64_set(&event->count, ret);
+	else if (ret == -ENOSPC)
+		local64_set(&event->count, 1);
+	else
+		local64_set(&event->count, 0);
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
+	/*
+	 * Snapshot (overwrite) mode is not supported.  In overwrite mode
+	 * perf_aux_output_begin() leaves handle->size = 0, which would
+	 * cause htm_dump_sample_data() to return ENOSPC on every call,
+	 * setting event->count = 1 and creating an infinite drain loop
+	 * in userspace.  Reject it here so perf_event_open() returns
+	 * EINVAL to the caller.
+	 */
+	if (snapshot)
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
@@ -479,7 +764,10 @@ static struct pmu htm_pmu = {
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



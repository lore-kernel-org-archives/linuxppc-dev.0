Return-Path: <linuxppc-dev+bounces-25591-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BD4C5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:38:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGmwM20rbz3cBH;
	Sat, 08 Aug 2026 00:38:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786113491;
	cv=none; b=H/Zk5Efvk+At2/aJMqK81bXDX3KFQiqiCLqAKSBD1qLb9RcePp8iINdpYy2u5C8tozYuFmjyLqMwmHaRgkneaDcQUCF4TOjb3PbbiHeF84ZSuc3VVFiOqx5DXgMcsj2JcoXMkdCFxWBKeOFdFYGibajhY4ANK+UgzZ9KtoBucExbc9iHuSUL8pHYjo71TImofDVhPIxonMPSx36KTi5Uo7nbfKxmtoLM+SvfqNMoRyIcBttmaHKiYfhIABUn+elMoWgZ3XllwNjmSRYJu8AP8HxJtJOnD/y+2mLXF3NlCjqidQ7ptgLw9S/ql5HE2foTVZpdEsl9zka69wpMSsjaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786113491; c=relaxed/relaxed;
	bh=nDDeh0hHZjXj/hs2E3ix0OSBGuhYHWTkqQDKLJKGRWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCH2B8auFkpdxtiSe9d9uxBgUaDMhfFm3/O7RXApC5aUcy9x5icIKNKxbUa8PH7W63wAu8jRcIgqMDp/ez3zpXLHbSNTHn7teLLFNw4XIJ3P1X54JKO/qCfQENHKOXlNIzTpFifK4qsI2RvngnJslLqY3wnuoSXD28bcFpnnpnp10ymlOyZ640CkyrgufueNWghhU78lmJ9XWk4SSURxnpkybtTr7I+e6vFyes7FbASiIsGo6YIqmIiri2/KjJM+i6+ik/+d3NGyXkWHzbwKalOnnQKpzAnELWev8ErluXU/5Gx7jWyI/snTrpqEWxwJLHUs2vtyfvZ5wIeCGEIn+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QODLMkKc; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QODLMkKc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGmwK6Ll4z3c7j
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 00:38:09 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Clr0f3829444;
	Fri, 7 Aug 2026 14:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nDDeh0
	hHZjXj/hs2E3ix0OSBGuhYHWTkqQDKLJKGRWY=; b=QODLMkKccXY6ysefUsMOoz
	2frBlJDo9VZpATIKB0RPDJ+v/K8Yi+Z+zpP7Es/OWG3I0Vc/aO0mSH3/oUS3hKkJ
	Fy4ZiWq6NX5RKOcT6YIPDyEvrI38NKSFRwyl29z/hfcKvAjO+cjlJJjYrbbQpOiQ
	bsXmFvlPCqyKJnKa6BwvfQAd1fOJmnJOLZ0QojMHduSbpdG+NH0N2BbY8F+MBa8e
	WwiwC4a8R0CUIys8fOROOaHW7UGU8LWkqWmiulYWPvsNPnhsITUOvWN6myGfrHDe
	etjpTHhncHkv/qvV6d8wMj9/ixOiIVo3gBYUNLUH8aWdPqkFf7JsDWBQr3U7Oh6w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01mbb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:38:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EQGLC003629;
	Fri, 7 Aug 2026 14:38:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r05wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:38:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Ec1Cf32309652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:38:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 142BF20043;
	Fri,  7 Aug 2026 14:38:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C637D20040;
	Fri,  7 Aug 2026 14:37:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:37:58 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V5 3/6] powerpc/perf: Add AUX buffer management to capture HTM trace data
Date: Fri,  7 Aug 2026 20:07:31 +0530
Message-Id: <20260807143734.1224-4-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260807143734.1224-1-atrajeev@linux.ibm.com>
References: <20260807143734.1224-1-atrajeev@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kezPW9WowqHuCbTxW6xFvpn7ngpN6HgU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX8UBYwIrjb/09
 9XXH8YEpL6fDS37kZ+rcLMdPF4A59eUPX4MYJO8UQGYvm5OvWgOIMghH1ekiWcnBw7cr+86ZWyn
 DNsxoYFs+alqO9TF03S+uXt4burys4g=
X-Proofpoint-ORIG-GUID: kezPW9WowqHuCbTxW6xFvpn7ngpN6HgU
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a75edcf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=6to4BSeoCK3BXBEt1KUA:9 a=juAip3XSfSdIvQ4z:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfXxVjBfl22ss2B
 ffCKbK/B9t7XEUgnq4+XroGNMFHSVHNCjaGtnB9spSM33nrw1PnxKFd273Tr8PWp/gDFK1R8d+l
 g5QN4dqSPyN07CPVR6ome+OsM719TbrHRt4pyXDS9i7BIjan+Ai6HlZJtZB5GRgxyI1CkrskoCR
 Kb/tol02Z1pz2+a0hZ+h6nOulzcZAtzukjnEGqhGl1o6k5/Q+I7kbA6cf8cdHy2z2PEsGv1CCeg
 rHK632fsYxioqI+epzWVjDJ90RjxtvLz+ylQcuAXjGaVciLH0ieJ+dlxI8T6Q+rkv/1YANrI0Rp
 t+JVeXxeNbDqIu8+lNn+M01iWLoDQtEDQ0hh6GPqHG4SKLd60OSn9kqCITysQF9zCmOT/5smQxj
 Yt3JekYw006wGwr/KyocsaBdu5zjLBSwzvYNF7g3bE4YoVOR77ZScHdHE+qFYH4shEms45JgCX0
 O9EQa6c3G59RfLBlpEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070112

Implement support for auxiliary (AUX) ring buffers in the HTM PMU driver.
This enables high-volume trace data to be streamed directly into a perf
AUX buffer for deferred post-processing by the perf tool.

Introduce the PMU data structures htm_pmu_buf and htm_pmu_ctx, and
implement the core lifecycle hooks:

  htm_setup_aux():  Allocates per-CPU context and records the AUX buffer
                    base, head, and size for the active trace window.
  htm_free_aux():   Releases the PMU-private tracking allocations.

perf_output_handle objects are declared on the stack in every function
that calls perf_aux_output_begin() (aux_buf_reset_for_start() and
htm_dump_sample_data()).  A per-CPU handle embedded in a static variable
would be shared between an outer AUX transaction and a nested call from
NMI context on the same CPU: perf_aux_output_begin()'s error path writes
handle->event = NULL on the handle it receives; if both the outer and
nested caller share the same object, this clears the outer transaction's
event pointer and causes perf_aux_output_end() to return early without
decrementing rb->aux_nest, permanently stalling the ring buffer.  Using
stack-local handles eliminates the aliasing entirely.

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

One-shot dump model:

   HTM hardware fills a fixed physical memory buffer (configured by
   H_HTM_OP_CONFIGURE) while tracing is active.  When pmu->read is
   first called, htm_dump_sample_data() issues H_HTM_OP_STOP to freeze
   that buffer, then copies its contents into the perf AUX ring buffer
   one chunk at a time across successive pmu->read calls (each call
   advances aux_buf->head by chunk_size and returns; the perf drain loop
   calls pmu->read again until event->count reaches zero).

   The hardware is NOT restarted between pmu->read calls, and is NOT
   restarted after the dump finishes.  This is intentional:

     - H_HTM_OP_DUMP_DATA reads the same frozen hardware buffer on every
       call, addressed by the advancing aux_buf->head offset.  Restarting
       the hardware mid-drain would cause it to overwrite the buffer
       content that has not been transferred yet, corrupting all
       subsequent chunks.

     - The intended usage is a bounded recording session (e.g.
       perf record -C 8 -m,512 -e htm/.../ sleep 1): hardware traces for
       the duration of the sleep, then the perf tool drains the full
       buffer in one pass at event close.  A new perf record invocation
       opens a fresh event, which issues H_HTM_OP_START again.

   If H_HTM_OP_STOP fails on the first pmu->read call, the dump is
   aborted and event->count is set to 0.  The hardware buffer is still
   running; it will be stopped by H_HTM_OP_DECONFIGURE in htm_event_del()
   when the event is closed, preventing a resource leak.

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

Hardware buffer boundary check:

   H_HTM_OP_STATUS returns the currently allocated HTM buffer size for
   the target.  The status output buffer header byte 0x01 holds
   CurrentNestHtmBufferSizeInPowerOf2 (HTM_NEST) or
   CurrentCoreHtmBufferSizeInPowerOf2 (HTM_CORE); both types use the
   same offset and length (offset 0x01, 1 byte).  The actual buffer
   size is 1 << byte[0x01].

   htm_event_add() issues H_HTM_OP_STATUS after a successful
   H_HTM_OP_CONFIGURE, allocating a 32-byte scratch buffer (enough for
   the header), reads byte 0x01, computes hw_buf_size = 1ULL << val,
   stores it in target->hw_buf_size, then frees the scratch buffer.
   If the hcall fails, hw_buf_size remains 0.

   In htm_dump_sample_data(), after the contiguous-window clamp and
   before the H_HTM_OP_DUMP_DATA call, hw_buf_size is used as a hard
   ceiling: if aux_buf->head has reached hw_buf_size the hardware buffer
   is fully consumed — collect_htm_trace is cleared and the dump returns
   0 immediately without issuing any further hcalls.  chunk_size is also
   clamped to hw_buf_size - aux_buf->head so the final chunk never
   overshoots the hardware boundary.  When hw_buf_size == 0 (status
   hcall failed) the check is skipped and the existing contiguous-window
   clamp and hcall EOF signal remain in effect.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V5:
- Use stack-local struct perf_output_handle in aux_buf_reset_for_start()
  and htm_dump_sample_data() instead of a per-CPU embedded handle.  A
  shared per-CPU handle is corrupted when perf_aux_output_begin()'s error
  path writes handle->event = NULL on a nested (NMI) call to the same
  object, clearing the outer transaction's event pointer and permanently
  stalling rb->aux_nest.  Stack-local handles eliminate the aliasing.
  As a consequence, struct htm_pmu_ctx (which contained only the handle)
  and its DEFINE_PER_CPU are removed; they are no longer needed.
- Add u64 hw_buf_size to struct htm_target_id.  Populated in
  htm_event_init() by a GFP_KERNEL H_HTM_OP_STATUS hcall using a
  PAGE_SIZE-aligned buffer (the hypervisor requires page alignment):
  status_buf[0x01] gives the current buffer size as a power-of-two
  exponent, so hw_buf_size = 1ULL << status_buf[0x01].  The hcall is
  issued in htm_event_init() (process context, GFP_KERNEL) rather than
  htm_event_add() (atomic, GFP_ATOMIC) to avoid unreliable PAGE_SIZE
  allocations in atomic context; H_HTM_OP_STATUS is independent of
  CONFIGURE and returns valid data before any session is opened.
  htm_dump_sample_data() uses hw_buf_size to clamp chunk_size and to
  detect end-of-data (aux_buf->head >= hw_buf_size) without a failed
  hcall.  On boundary hit, pivot to htm_collect_memory_config() via
  goto out rather than returning 0, so the memory-config drain is not
  skipped.
- Add in_nmi() guard at the top of htm_event_read().  The function
  issues hypervisor calls and mutates target->tracing_active and
  aux_buf->head, none of which are NMI-safe.  Returning early from NMI
  context preserves the existing event->count so the drain loop retries
  on the next scheduled pmu->read() call.

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

 arch/powerpc/perf/htm-perf.c | 371 ++++++++++++++++++++++++++++++++++-
 1 file changed, 370 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
index c1ce12605014..f72ee661c084 100644
--- a/arch/powerpc/perf/htm-perf.c
+++ b/arch/powerpc/perf/htm-perf.c
@@ -88,6 +88,7 @@ struct htm_target_id {
 	int tracing_active;		/* HTM_TRACING_ACTIVE / HTM_TRACING_INACTIVE */
 	int configured;			/* 1 after H_HTM_OP_CONFIGURE succeeds; 0 otherwise */
 	struct list_head list;
+	u64 hw_buf_size;	/* hardware buffer size from H_HTM_OP_STATUS (1<<byte[0x01]), 0 if unknown */
 };
 
 /* Helper to parse the 28-bit event config into distinct fields */
@@ -99,6 +100,38 @@ static inline void parse_htm_config(u64 config, struct htm_config *cfg)
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
+/*
+ * Reset AUX buffer state at the start of a new trace session.
+ * collect_htm_trace is cleared on any hard hcall error; without
+ * this reset, restarting the event via ioctl(ENABLE) after such an
+ * error would permanently drop all future trace data.
+ *
+ * Uses a stack-local handle to avoid aliasing with an in-progress
+ * AUX transaction on the same CPU (e.g. from NMI context).
+ */
+static void aux_buf_reset_for_start(struct perf_event *event)
+{
+	struct perf_output_handle handle;
+	struct htm_pmu_buf *aux_buf;
+
+	aux_buf = perf_aux_output_begin(&handle, event);
+	if (aux_buf) {
+		aux_buf->collect_htm_trace = 1;
+		aux_buf->head = 0;
+		perf_aux_output_end(&handle, 0);
+	}
+}
+
 /*
  * Check the return code for H_HTM hcall.
  * Return 1 if either H_PARTIAL or H_SUCCESS is returned.
@@ -191,6 +224,10 @@ static int htm_event_init(struct perf_event *event)
 	u64 config = event->attr.config;
 	struct htm_config cfg;
 	struct htm_target_id *target, *tmp;
+	u8 *status_buf;
+	long src;
+	ssize_t sret;
+	int sretries = 0;
 
 	if (event->attr.inherit)
 		return -EOPNOTSUPP;
@@ -277,6 +314,32 @@ static int htm_event_init(struct perf_event *event)
 	list_add_tail(&target->list, &htm_active_targets_list);
 	mutex_unlock(&htm_targets_lock);
 
+	/*
+	 * Query the hardware-allocated HTM buffer size via H_HTM_OP_STATUS.
+	 * The status output buffer header byte 0x01 holds
+	 * CurrentNestHtmBufferSizeInPowerOf2 (for HTM_NEST) or
+	 * CurrentCoreHtmBufferSizeInPowerOf2 (for HTM_CORE); both types
+	 * use the same offset (0x01) and length (1 byte).
+	 * hw_buf_size is used in htm_dump_sample_data() to bound dump
+	 * offsets, preventing H_HTM_OP_DUMP_DATA calls past the end of the
+	 * hardware buffer.  On failure hw_buf_size stays 0 and the boundary
+	 * check is skipped gracefully — the contiguous-window clamp still
+	 * applies.
+	 */
+	status_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (status_buf) {
+		do {
+			src = htm_hcall_wrapper(htmflags, cfg.nodeindex,
+					cfg.nodalchipindex, cfg.coreindexonchip,
+					cfg.htmtype, H_HTM_OP_STATUS,
+					virt_to_phys(status_buf), PAGE_SIZE, 0);
+			sret = htm_return_check(src);
+		} while (sret == -EBUSY && ++sretries < MAX_RETRIES);
+		if (sret > 0)
+			target->hw_buf_size = 1ULL << status_buf[0x01];
+		kfree(status_buf);
+	}
+
 	event->pmu_private = target;
 	event->destroy = reset_htm_active;
 	return 0;
@@ -318,6 +381,9 @@ static void htm_event_start(struct perf_event *event, int flags)
 	if (ret > 0) {
 		target->tracing_active = HTM_TRACING_ACTIVE;
 		event->hw.state &= ~PERF_HES_STOPPED;
+
+		if (!(flags & PERF_EF_RELOAD))
+			aux_buf_reset_for_start(event);
 	}
 }
 
@@ -510,8 +576,308 @@ static void htm_event_del(struct perf_event *event, int flags)
 	/* pmu_private freed by event->destroy = reset_htm_active */
 }
 
+static ssize_t htm_dump_sample_data(struct perf_event *event)
+{
+	struct perf_output_handle handle;
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
+	/* Start AUX transaction; use a stack-local handle to prevent
+	 * NMI reentrancy from corrupting an outer transaction's handle.
+	 */
+	aux_buf = perf_aux_output_begin(&handle, event);
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
+		perf_aux_output_end(&handle, 0);
+		return 0;
+	}
+
+	if (target->tracing_active == HTM_TRACING_ACTIVE) {
+		/*
+		 * First pmu->read call of the drain sequence: stop the hardware
+		 * to freeze the HTM buffer before reading it.  This is a
+		 * one-shot dump — the buffer is static for the entire drain;
+		 * the hardware is not restarted between chunks or after the
+		 * dump completes.  Restarting mid-drain would overwrite buffer
+		 * content that has not yet been transferred to the AUX ring.
+		 * A new perf record session issues H_HTM_OP_START afresh.
+		 */
+		htm_event_stop(event, 0);
+		if (target->tracing_active == HTM_TRACING_ACTIVE) {
+			/*
+			 * H_HTM_OP_STOP failed — cannot dump a live buffer.
+			 * Abort the dump; event->count = 0 stops the drain loop.
+			 * The hardware is still running; htm_event_del() will
+			 * call H_HTM_OP_DECONFIGURE which implicitly stops it,
+			 * preventing a resource leak.
+			 */
+			perf_aux_output_end(&handle, 0);
+			return -EIO;
+		}
+	}
+
+	/* Derive the exact target destination point directly out of active ring pointers */
+	dump_offset = handle.head & (aux_buf->size - 1);
+	page_index = dump_offset >> PAGE_SHIFT;
+	page_offset = dump_offset & (PAGE_SIZE - 1);
+
+	/*
+	 * Assess constraints regarding space remaining across the mapping
+	 * context boundary.
+	 * handle.size is always page-aligned: perf_aux_output_begin() computes
+	 * it as the distance from the write pointer to the wakeup boundary,
+	 * rounded to PAGE_SIZE.  Masking with PAGE_MASK is therefore a no-op
+	 * but is kept to make the page-granularity contract explicit.
+	 */
+	chunk_size = handle.size;
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
+	/*
+	 * Bound the dump to the hardware-allocated buffer size reported by
+	 * H_HTM_OP_STATUS (stored in target->hw_buf_size at configure time).
+	 * aux_buf->head is the byte offset of the next chunk to dump; once
+	 * it reaches hw_buf_size the hardware buffer is exhausted and no
+	 * further H_HTM_OP_DUMP_DATA calls should be issued.
+	 * hw_buf_size == 0 means the status hcall failed at configure time;
+	 * skip the check and let the hcall itself signal end-of-data.
+	 */
+	if (target->hw_buf_size) {
+		if (aux_buf->head >= target->hw_buf_size) {
+			aux_buf->collect_htm_trace = 0;
+			perf_aux_output_end(&handle, 0);
+			return 0;
+		}
+		if (chunk_size > target->hw_buf_size - aux_buf->head)
+			chunk_size = target->hw_buf_size - aux_buf->head;
+	}
+
+	if (!chunk_size) {
+		/*
+		 * No space in the AUX ring buffer right now.  Leave
+		 * collect_htm_trace set. Return -ENOSPC so htm_event_read()
+		 * keeps event->count non-zero, signalling to the caller that
+		 * collection is still ongoing and another pmu->read pass
+		 * should be attempted once the consumer has drained the buffer.
+		 */
+		perf_aux_output_end(&handle, 0);
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
+		perf_aux_output_end(&handle, chunk_size);
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
+	perf_aux_output_end(&handle, 0);
+	return ret;
+}
+
 static void htm_event_read(struct perf_event *event)
 {
+	ssize_t ret;
+
+	/*
+	 * Refuse to run from NMI context.  htm_dump_sample_data() issues
+	 * hypervisor calls, mutates target->tracing_active, and writes
+	 * aux_buf->head — none of which are NMI-safe.
+	 *
+	 * perf_event_read_local() (used by BPF helpers such as
+	 * bpf_perf_event_read_value()) does not check PERF_PMU_CAP_NO_NMI,
+	 * so an explicit in_nmi() guard here is required.
+	 *
+	 * Returning without touching event->count preserves whatever value
+	 * was set by the previous pmu->read() call.  If the drain is still
+	 * in progress, event->count remains non-zero and the drain loop
+	 * keeps retrying.  The next scheduled pmu->read() — which will not
+	 * be in NMI context — will proceed normally and complete the dump.
+	 * This mirrors the stack-local handle fix: both let the NMI path
+	 * return without mutating any shared state.
+	 */
+	if (in_nmi())
+		return;
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
@@ -524,7 +890,10 @@ static struct pmu htm_pmu = {
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
2.53.0



Return-Path: <linuxppc-dev+bounces-25592-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BD2C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:38:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGmwQ0SMRz3cG0;
	Sat, 08 Aug 2026 00:38:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786113493;
	cv=none; b=F0uVCkel0fJwiz7rDqmLTGkN42vPrzelKs75BNIKtXZjIhP5wojzaIm1MAOxyB0xb9cFHYXVbXgR4wXdEziSq07sGXsBEezA0lRTSPXCpda/0vVKTt1oHi8eGrdRGu0EoHu7lraoDBeNSti0ekNUEe/yGu2OuDdtxthFFF4VPZE2kdyaMAQgUV8M8cMDIP+RtyYc6Bks8r5+ZnVcHV9Vv8p3ruYO+WUEsMiqc/qPetO1XVlyGnEKw3/Q5m9dtYwx90zpkfSebBjNxQ2qZA9bbnbG8ejyHOetfwCoHAqAdPSxmkDZwduyaP/9+QGpe6RhrdwQy677i9JZBMlxmX6tVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786113493; c=relaxed/relaxed;
	bh=iOzd7t5sCHJIs3v3TH9+/fynvZ2SFXKxTOxtEKVc6TI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrhMdTGHOJ4GlME8mNTZFE9GN0JDLEN/JWAtf41PRQl58R76y9r4mFLVdThQ9q1XjRENmcu8XNiPKpf4CCiQyWsLiPWhzgd8JF6zKoIAf1dWgR/CZJzmW3PamsFmofgDTMSbzCtwGNVonuGHaoSMN+zBnnYdWFZDazmT3SVJVIrli0U++Qvl4+lbipFhi06GXbT1yy6PlIoyzQS9Z0cZ6MG8AJmO8UHWER93D86RVQUqgrzHqKy14hG1WFNSpfpUV01/xOwgzPxCqzaAfltIyReNtq4G3HUFeNsGK/j7ROnvXFDhLRmISf3M5wuErOugiI9+zODyIqHkkMdMzOgR6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=psYo4mM/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=psYo4mM/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGmwN4cnPz3c7j
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 00:38:12 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Cm5Ad1413172;
	Fri, 7 Aug 2026 14:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iOzd7t
	5sCHJIs3v3TH9+/fynvZ2SFXKxTOxtEKVc6TI=; b=psYo4mM/I+8MrtlvkynKGD
	cLkB6wnJcbUCtUVzLnhqNVQTxz9waEcmZU47+YsdWv0zo7TqAjHl4fDLEd2+9nGQ
	K5MWrOA1kVTXbW0aoNB7Jje6q8sDb4ccWtZlqpwVAcLUYuXpUhCo9K9p9Zqe2KYw
	DgR9o1FTi+XKa2Ikl+lJsnqPiVi82CucFTnNGZhb1wXyNDr+8E8PHcUsPTafLYk7
	6eLfwuWHpjiBsi8Wsl3nQ7pJJuamxJWb091LJXHsJ8zXwPymqALKOjB+emYDb7Dd
	n2zBdFzVA2GMj+RAp+ze9JKnDDdylg54Ua226rKwSKVn3JFRjAsCniAb5MovaE0g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02c7kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:38:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EQImg026111;
	Fri, 7 Aug 2026 14:38:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhqynt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:38:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Ec3669961742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:38:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFEDD20043;
	Fri,  7 Aug 2026 14:38:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 743C120040;
	Fri,  7 Aug 2026 14:38:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:38:01 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V5 4/6] powerpc/perf: Capture the HTM memory configuration as part of perf data
Date: Fri,  7 Aug 2026 20:07:32 +0530
Message-Id: <20260807143734.1224-5-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75edd1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ib3TvkL6aPAUh8kSF4kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX188QCABLwVJl
 61ipv3Oxt6KGdEmn1ldnASpEdQUyMDQpZXxzmk5GpgfrKweAjHaW+DLT4MkqOOXW/ObHzP5zlq0
 ZwPZaQUeIW2o0w/oZr0/ml2mpHFdrS8V8BwAlpBrD7aKlgt3d7PlosRfObPbcZPScSUZ3EtN+sc
 xCDX33UwYPaNgcotDK06rxrW0v/JFofsvOD/cgCyhcuy+pIlqhIlU58qZ6N7HR6kwUXtm3Ncuw6
 slm3OGaQcvH/QbrxJDnwaLPqVSCKS6ZRgTP/R5pW19+AGJTqjpwimPKeVwxhimo9S0AFGIJCDbl
 +FY6stDTm3l45C/Ls2iyPAZv8mv3cc3tLCh6sBF8omQ7MCk2ooF2gCJA3MwveetrJCHYBcMCUKP
 wR2ifKW/j8MIVKaYvH5nPHoDTu2dy19qFM7gSpTBpDRw9Fl42eQZm/g3LB2o8otHMQzFrnbyiOj
 +P5x2Y215V9AxNEYLUw==
X-Proofpoint-ORIG-GUID: v18Mn_lnSsxlxvVO0CZw3VjjAWstFeXq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX9ohGHQQvRysV
 IeIinyW/EnXJLS69eCq40ibce6PHQ08dpB9ElhDyoNVmIyF8DVRazRmWSoOHAV2EO0PBEbSsscL
 ta4z1dvMPn5OTQUMuBuUbONx9HXaH04=
X-Proofpoint-GUID: v18Mn_lnSsxlxvVO0CZw3VjjAWstFeXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070112

The H_HTM hypervisor call can also return the system memory
configuration, which describes the physical to logical real address
mapping for logical partitions.

After dumping HTM trace data into the AUX buffer, capture the
corresponding HTM system memory configuration records and emit them as
raw perf sample data for userspace parsing.

Add AUX-private tracking for a hypervisor memory-configuration dump
buffer and iterator state.  Once AUX trace dumping completes,
htm_event_read() calls htm_collect_memory_config() which issues one
H_HTM_OP_DUMP_SYSMEM_CONF hcall and emits the result as a single
PERF_SAMPLE_RAW record, then returns immediately.  The perf drain loop
calls htm_event_read() repeatedly until event->count reaches zero,
giving userspace a chance to drain the ring buffer between every record.
This mirrors the AUX trace path design and avoids the ring-buffer-overflow
problem that a while(true) loop would create.

Trace payload continues to be written to the AUX buffer, while memory
configuration records are emitted as raw perf samples. This keeps the
AUX stream focused on trace data and allows the configuration records to
be decoded separately in userspace.

The hypervisor fills as many 32-byte entries as fit within the buffer
size passed to H_HTM_OP_DUMP_SYSMEM_CONF — it does not cap at a fixed
entry count.  Observed maximum fill is 64480 bytes (2015 entries at
32 bytes each plus a 32-byte header).  HTM_MEM_BUF_SIZE is therefore
defined as the allocation size (65440 bytes) and HTM_MEM_MAX_ENTRIES is
derived from it ((HTM_MEM_BUF_SIZE - 32) / 32 = 2043), not the other
way around.  This ensures the hcall is always told the true buffer size
and the WARN_ON_ONCE(to_copy > HTM_MEM_BUF_SIZE) guard is a genuine
impossibility check rather than a post-overflow assertion.

HTM_MEM_BUF_SIZE = 65440 is the largest multiple of 32 that satisfies
both constraints: it exceeds the observed 64480-byte maximum fill by 960
bytes of headroom, and the resulting perf record (65440 + 92 bytes of
fixed overhead = 65532) stays below 65535, the __u16 limit of
perf_event_header.size.  The 92-byte overhead is: 8 (perf_event_header)
+ 64 (header_size worst case: 8 u64 sample fields) + 16 (id_header_size
worst case) + 4 (PERF_SAMPLE_RAW u32 size prefix).

perf_fetch_caller_regs() is used to initialise the pt_regs argument
passed to perf_event_overflow().  An uninitialised stack frame would
leak kernel stack bytes to userspace if the event is opened with
PERF_SAMPLE_REGS_INTR.  This follows the pattern used by tracepoints
and BPF perf-event helpers for synthetic sample emission.

When perf_event_overflow() throttles the event (returns non-zero),
overflow_handler has already run unconditionally (writing the sample to
the ring buffer) before the non-zero return.  mem_start is therefore
advanced so the same block is not emitted again, and -ENOSPC is returned
so event->count is set to 1 and the drain loop keeps retrying to emit
the next block once the event is unthrottled.

Keep HTM tracing state in event->pmu_private via htm_target_id. AUX
private state is used only for dump progress and staging buffers.

Concurrency and locking:

   target->tracing_active and target->configured:

     Every read and write of these fields occurs in pmu->add(),
     pmu->del(), pmu->start(), pmu->stop(), and pmu->read().  All of
     these callbacks are invoked by the perf core under ctx->lock with
     IRQs disabled (event_sched_in/out, __perf_event_read).  IRQs
     disabled means regular interrupts cannot preempt these paths.  NMI
     can still fire — but see below.

   aux_buf->head and aux_buf->collect_htm_trace:

     These fields are only written from htm_dump_sample_data() (called
     from pmu->read()), which is also under ctx->lock with IRQs disabled.
     Additionally, perf_aux_output_begin() increments rb->aux_nest on
     entry and perf_aux_output_end() decrements it on exit.  If an NMI
     fires while an AUX transaction is open (aux_nest > 0), any nested
     perf_aux_output_begin() call hits the WARN_ON_ONCE(nest) guard and
     returns NULL immediately — the NMI path exits without touching
     aux_buf->head or any other shared state.

   BPF NMI path (perf_event_read_local):

     The only kernel path that calls pmu->read() without holding
     ctx->lock is perf_event_read_local(), used by BPF helpers such as
     bpf_perf_event_read_value().  perf_event_read_local() does not
     check PERF_PMU_CAP_NO_NMI, so it can invoke pmu->read() from NMI
     context.

     htm_event_read() guards against this with an explicit in_nmi()
     check at entry: if called from NMI, it returns immediately without
     touching event->count, target->tracing_active, aux_buf->head, or
     issuing any hcall.  event->count retains its previous value, so
     if the drain is in progress the drain loop remains alive and the
     next scheduled pmu->read() (not in NMI context) completes the dump.

     Additionally, htm_event_init() (patch 2) prevents a second
     perf_event_open() for the same target (returns -EBUSY), so a BPF
     session and a perf session cannot hold the same target concurrently.
     The in_nmi() guard is defence-in-depth against any future path
     that bypasses this reservation.

   No additional locking is required beyond ctx->lock (for target
   fields) and rb->aux_nest (for AUX buffer fields).

Ring buffer full and silent drop of memory configuration records:

   htm_collect_memory_config() uses perf_event_overflow() to emit records
   to the main ring buffer.  perf_event_overflow() returns non-zero only
   when the event is throttled; it returns 0 both when the sample is
   written successfully and when perf_output_begin() fails because the
   ring buffer is full (in the latter case the sample is silently dropped
   inside perf_output_sample()).  In both 0-return cases aux_buf->mem_start
   is advanced.  This is the same behaviour as tracepoints and BPF perf
   event helpers: when the ring buffer is full, records are dropped and the
   iterator advances.  The alternative — stalling the iterator on drop —
   would loop forever whenever the ring buffer stayed full, blocking the
   drain loop.  Dropped records are visible to userspace through the
   PERF_RECORD_LOST counter in the ring buffer header.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V5:
- htm_collect_memory_config(): zero struct pt_regs regs with memset()
  before calling perf_fetch_caller_regs().  perf_fetch_caller_regs()
  only initialises nip, msr, and gpr[1]; the remaining fields are left
  as uninitialised stack bytes.  Defensive zeroing prevents potential
  kernel stack leakage and matches the pattern in trace_event_perf.c
  and bpf_trace.c.
- htm_dump_sample_data(): handle perf_aux_output_begin() returning NULL
  while memory-configuration collection is still in progress.  When the
  AUX ring buffer is full, perf_aux_output_begin() returns NULL and the
  function previously returned 0, signalling EOF to htm_event_read() and
  permanently abandoning the mem-config drain.  The fix retrieves
  aux_buf via perf_get_aux() and, if collect_htm_trace is already clear
  but collect_htm_mem is still set, calls htm_collect_memory_config()
  directly, keeping the drain alive independently of AUX ring pressure.

Changes in V4:
- htm_collect_memory_config(): restructured from a while(true) loop to a
  single-hcall-per-call design, mirroring the AUX trace path.  The old
  loop had no way to break out when the ring buffer filled mid-loop:
  perf_event_overflow() returns 0 for both "written" and "ring buffer
  full / dropped", so iteration would continue, dropping every subsequent
  record with no chance for userspace to drain the buffer.  With one hcall
  per call, the drain loop (arch_perf_record__need_read) calls
  htm_event_read() → htm_collect_memory_config() once per pass, userspace
  drains the ring buffer between passes, and ring buffer pressure is
  handled naturally.
- htm_collect_memory_config(): on non-zero return from perf_event_overflow()
  (event throttled), advance mem_start before returning -ENOSPC.
  overflow_handler runs unconditionally inside __perf_event_overflow()
  before the non-zero return, so the sample WAS written to the ring buffer.
  The old code did not advance mem_start on throttle, causing the same
  block to be emitted again on the next call — a duplicate sample bug.
- htm_setup_aux() / htm_free_aux(): removed emit_buf.  emit_buf was a
  second HTM_MEM_BUF_SIZE allocation used to keep raw.frag.data stable
  across loop iterations (htm_mem_buf was overwritten by the next hcall).
  With no loop, htm_mem_buf is not reused within a single call, so it
  is stable throughout perf_event_overflow() and no memcpy or second
  buffer is needed.
- htm_setup_aux(): changed kmalloc_node to kzalloc_node for htm_mem_buf.
  The buffer is passed to the hypervisor and subsequently read by the perf
  core; kzalloc_node ensures uninitialized heap bytes are never exposed if
  the hypervisor leaves reserved fields or padding untouched.
- HTM_MEM_BUF_SIZE / PERF_SAMPLE_REGS_INTR: no change needed here.
  PERF_SAMPLE_REGS_INTR is now rejected in htm_event_init() (patch 1),
  so the 92-byte fixed overhead used in the HTM_MEM_BUF_SIZE calculation
  is accurate for all sample types this driver accepts.
- struct pt_regs initialisation: no change needed.  perf_fetch_caller_regs()
  was already added in V3 (see "Changes in V3" below).  The reviewer was
  looking at V2 code.

Changes in V3:
- Fixed HTM_MEM_BUF_SIZE defined as (32 + 2013 * 32 = 64448 bytes) while
  the hypervisor actually fills up to 64480 bytes (2015 entries) when
  given a sufficiently large buffer — overflowing the allocation by 32
  bytes.  The hypervisor fills as many entries as fit within the given
  buffer size; it does not cap at a fixed entry count.  Fixed by
  redefining HTM_MEM_BUF_SIZE as 65440U (the largest multiple of 32
  fitting in perf_event_header.size __u16 with 92 bytes of worst-case
  header overhead: 65440 + 92 = 65532 < 65535) and deriving
  HTM_MEM_MAX_ENTRIES from it ((HTM_MEM_BUF_SIZE - 32) / 32 = 2043).
  The buffer now covers the observed maximum with 960 bytes headroom,
  and the WARN_ON_ONCE guard is a genuine impossibility check.
- Fixed htm_mem_buf allocated as PAGE_SIZE (4096 bytes on 4K-page
  configs) while the hypervisor was told the buffer length is
  HTM_MEM_BUF_SIZE.  Changed to kmalloc_node with HTM_MEM_BUF_SIZE.
- Fixed uninitialized struct pt_regs regs passed to perf_event_overflow().
  If the event is opened with PERF_SAMPLE_REGS_INTR the perf core reads
  these bytes into the ring buffer, leaking kernel stack memory to
  userspace.  Added perf_fetch_caller_regs(&regs) after the declaration
  block, following the pattern in kernel/trace/trace_event_perf.c and
  kernel/trace/bpf_trace.c.
- Clarified the perf_event_overflow() throttle path: added a comment
  distinguishing the throttle path (collect_htm_mem left set, -ENOSPC
  returned) from the error/EOF paths that clear collect_htm_mem.

Changes in V2:
- Memory configuration records are now emitted as PERF_SAMPLE_RAW
  samples directly by htm_event_read() after the AUX trace dump
  completes, using H_HTM_OP_DUMP_SYSMEM_CONF.  V1 embedded the
  configuration data inside the AUX buffer itself and used two
  PERF_SAMPLE_RAW boundary markers (start/end) to delimit it.
- The two-marker boundary scheme is removed.  There is no longer any
  interleaving of memory configuration data inside the AUX stream;
  the AUX buffer carries only bus-trace data.
- Separate AUX-private fields for a hypervisor dump buffer and iterator
  state are introduced to manage the SYSMEM_CONF drain.
- Tracing state remains in event->pmu_private (htm_target_id); AUX
  private state is used only for dump progress and staging buffers,
  consistent with the restructuring in patches 1 and 3.

 arch/powerpc/perf/htm-perf.c | 210 ++++++++++++++++++++++++++++++++++-
 1 file changed, 206 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
index f72ee661c084..ec1ce1457764 100644
--- a/arch/powerpc/perf/htm-perf.c
+++ b/arch/powerpc/perf/htm-perf.c
@@ -108,6 +108,9 @@ struct htm_pmu_buf {
 	u64	head;
 	u64     size;
 	int     collect_htm_trace;
+	void    *htm_mem_buf;	/* Staging area for H_HTM_OP_DUMP_SYSMEM_CONF hcall */
+	u64     mem_start;	/* Hypervisor iterator position for DUMP_SYSMEM_CONF */
+	int     collect_htm_mem;	/* State flag tracking whether memory logging is ongoing */
 };
 
 /*
@@ -203,6 +206,168 @@ static ssize_t htm_return_check(int rc)
 #define HTM_TRACING_ACTIVE	1
 #define HTM_TRACING_INACTIVE	0
 
+/*
+ * HTM_MEM_BUF_SIZE is the allocation size for the hcall staging buffer.
+ * The hypervisor fills as many 32-byte entries as fit within the buffer
+ * size passed to H_HTM_OP_DUMP_SYSMEM_CONF — it does not cap at a fixed
+ * entry count.
+ *
+ * HTM_MEM_BUF_SIZE is chosen to satisfy two constraints:
+ *
+ *   1. The full perf record (perf_event_header + fixed sample fields +
+ *      PERF_SAMPLE_RAW u32 size prefix + to_copy) must fit in
+ *      perf_event_header.size which is __u16 (max 65535):
+ *        overhead = 8 (perf_event_header)
+ *                 + 64 (header_size, worst case: 8 u64 sample fields)
+ *                 + 16 (id_header_size, worst case)
+ *                 +  4 (PERF_SAMPLE_RAW u32 size prefix)
+ *                 = 92 bytes
+ *        to_copy <= 65535 - 92 = 65443
+ *        round down to multiple of 32: 65440
+ *
+ *   2. HTM_MEM_BUF_SIZE must be a multiple of 32 so a whole number of
+ *      32-byte entries fill it exactly.
+ *
+ * 65440 = 32 + 2043 * 32 is the largest multiple of 32 satisfying all
+ * constraints:
+ *   - total record: 65440 + 92 = 65532 < 65535 (3-byte u16 margin)
+ *
+ * HTM_MEM_MAX_ENTRIES is derived from HTM_MEM_BUF_SIZE — not the other
+ * way around — so the hcall is always given the true buffer size and
+ * the WARN_ON_ONCE(to_copy > HTM_MEM_BUF_SIZE) guard is a genuine
+ * impossibility check rather than a post-overflow assertion.
+ */
+#define HTM_MEM_BUF_SIZE	65440U
+#define HTM_MEM_MAX_ENTRIES	((HTM_MEM_BUF_SIZE - 32) / 32)	/* 2043 */
+
+/*
+ * htm_collect_memory_config - issue one H_HTM_OP_DUMP_SYSMEM_CONF hcall
+ * and emit the result as a single PERF_SAMPLE_RAW record.
+ *
+ * Mirrors the AUX trace path: one hcall per call, return immediately.
+ * htm_dump_sample_data() calls this once per htm_event_read() invocation;
+ * the perf drain loop calls htm_event_read() repeatedly until
+ * event->count reaches zero, giving userspace a chance to drain the ring
+ * buffer between every record.  This avoids the ring-buffer-overflow
+ * problem that a while(true) loop would create: if the ring buffer fills
+ * mid-loop there is no way to break out and let userspace drain it.
+ *
+ * Returns the number of 32-byte memory configuration entries emitted
+ * (to_copy / 32) on success, -ENOSPC if throttled (sample was written,
+ * event temporarily paused — advance mem_start, retry next block next
+ * call), 0 if the stream ended normally, or a negative error code on
+ * hard failure.  The caller uses the return value directly as
+ * event->count, consistent with the AUX trace path returning count..
+ */
+static ssize_t htm_collect_memory_config(struct perf_event *event,
+					 struct htm_pmu_buf *aux_buf)
+{
+	struct perf_sample_data data;
+	struct perf_raw_record raw;
+	struct pt_regs regs;
+	u8 *htm_mem_buf = aux_buf->htm_mem_buf;
+	__be64 *num_entries;
+	u64 next_start;
+	u64 to_copy;
+	long rc;
+	ssize_t ret;
+	int retries = 0;
+
+	/*
+	 * Zero the full pt_regs before fetching the caller context.
+	 * perf_fetch_caller_regs() on PowerPC only initialises nip, msr,
+	 * gpr[1], and result; all other fields (link, ctr, xer, remaining
+	 * GPRs) would otherwise contain uninitialized stack bytes.  If the
+	 * event is opened with PERF_SAMPLE_CALLCHAIN, perf_callchain_kernel()
+	 * reads regs->link and writes it to the ring buffer, leaking kernel
+	 * stack memory to userspace.  PERF_SAMPLE_CALLCHAIN is rejected in
+	 * htm_event_init(), but zeroing here is the safe defensive practice
+	 * used by tracepoints and BPF perf-event helpers.
+	 */
+	memset(&regs, 0, sizeof(regs));
+	perf_fetch_caller_regs(&regs);
+
+	/* Issue one hcall with the current iterator position */
+	do {
+		rc = htm_hcall_wrapper(htmflags, 0, 0, 0,
+				       0, H_HTM_OP_DUMP_SYSMEM_CONF,
+				       virt_to_phys(aux_buf->htm_mem_buf),
+				       HTM_MEM_BUF_SIZE, aux_buf->mem_start);
+		ret = htm_return_check(rc);
+	} while (ret == -EBUSY && ++retries < MAX_RETRIES);
+
+	/*
+	 * ret == 0 (H_NOT_AVAILABLE): normal end of stream.
+	 * ret < 0 (error): hard failure.
+	 * Both cases: clear collect_htm_mem so the next htm_event_read()
+	 * call does not re-enter, and return so event->count is set to 0.
+	 */
+	if (ret <= 0) {
+		aux_buf->collect_htm_mem = 0;
+		return ret;
+	}
+
+	/*
+	 * Read next iterator value and payload size from the hcall response.
+	 * next_start == 0 means this is the last batch.
+	 */
+	next_start = be64_to_cpu(*((__be64 *)(htm_mem_buf + 0x8)));
+	num_entries = (__be64 *)(htm_mem_buf + 0x10);
+	to_copy = 32 + (be64_to_cpu(*num_entries) * 32);
+
+	if (WARN_ON_ONCE(to_copy > HTM_MEM_BUF_SIZE)) {
+		aux_buf->collect_htm_mem = 0;
+		return -EIO;
+	}
+
+	/*
+	 * htm_mem_buf is stable for the duration of this single call —
+	 * no loop reuse, so raw.frag.data remains valid throughout
+	 * perf_event_overflow().  No memcpy to a separate emit_buf needed.
+	 */
+	perf_sample_data_init(&data, 0, event->hw.last_period);
+	memset(&raw, 0, sizeof(raw));
+	raw.frag.data = htm_mem_buf;
+	raw.frag.size = to_copy;
+	perf_sample_save_raw_data(&data, event, &raw);
+
+	if (perf_event_overflow(event, &data, &regs)) {
+		/*
+		 * Event throttled: overflow_handler ran unconditionally before
+		 * returning, so the sample WAS written to the ring buffer.
+		 * Advance mem_start so the same block is not emitted again.
+		 * Return -ENOSPC so htm_event_read() sets event->count=1,
+		 * keeping the drain loop alive to emit the next block once
+		 * the event is unthrottled.
+		 */
+		aux_buf->mem_start = next_start;
+		if (!next_start)
+			aux_buf->collect_htm_mem = 0;
+		return -ENOSPC;
+	}
+
+	/*
+	 * perf_event_overflow() returns 0 for both "sample written" and
+	 * "ring buffer full, sample dropped" (perf_output_begin() failure
+	 * inside perf_output_sample() is silent).  Advance the iterator in
+	 * both cases.  This matches tracepoint / BPF perf-event helper
+	 * behaviour: when the ring buffer is full, records are dropped and
+	 * the stream continues.  Stalling the iterator on drop would loop
+	 * forever if the ring stayed full.  Dropped records are counted in
+	 * the PERF_RECORD_LOST entry in the ring buffer header.
+	 */
+	aux_buf->mem_start = next_start;
+	if (!next_start)
+		aux_buf->collect_htm_mem = 0;
+
+	/*
+	 * Return the number of 32-byte entries emitted.  Dividing here keeps
+	 * htm_event_read() free of format knowledge, consistent with the AUX
+	 * trace path returning chunk_size / 128.
+	 */
+	return (ssize_t)(to_copy / 32);
+}
+
 static void reset_htm_active(struct perf_event *event)
 {
 	struct htm_target_id *target = event->pmu_private;
@@ -594,10 +759,25 @@ static ssize_t htm_dump_sample_data(struct perf_event *event)
 	 * NMI reentrancy from corrupting an outer transaction's handle.
 	 */
 	aux_buf = perf_aux_output_begin(&handle, event);
-	if (!aux_buf)
+	if (!aux_buf) {
+		/*
+		 * AUX ring buffer is full: perf_aux_output_begin() returned NULL.
+		 * If the AUX trace dump is already complete but memory
+		 * configuration collection is still in progress, we must not
+		 * return 0 here — that would signal EOF to htm_event_read() and
+		 * permanently abandon the mem config drain.  Memory config
+		 * records go to the main ring buffer via perf_event_overflow(),
+		 * which is entirely independent of the AUX ring.  Retrieve the
+		 * aux_buf from the ring's aux_private and call directly.
+		 */
+		struct htm_pmu_buf *fb = perf_get_aux(&handle);
+
+		if (fb && !fb->collect_htm_trace && fb->collect_htm_mem)
+			return htm_collect_memory_config(event, fb);
 		return 0;
+	}
 
-	if (!aux_buf->collect_htm_trace) {
+	if (!aux_buf->collect_htm_trace && !aux_buf->collect_htm_mem) {
 		/*
 		 * collect_htm_trace is cleared on hcall error and reset to 1
 		 * in htm_event_start() when tracing restarts.  If it is still
@@ -632,6 +812,11 @@ static ssize_t htm_dump_sample_data(struct perf_event *event)
 		}
 	}
 
+	if (!aux_buf->collect_htm_trace) {
+		ret = htm_collect_memory_config(event, aux_buf);
+		goto out;
+	}
+
 	/* Derive the exact target destination point directly out of active ring pointers */
 	dump_offset = handle.head & (aux_buf->size - 1);
 	page_index = dump_offset >> PAGE_SHIFT;
@@ -701,8 +886,8 @@ static ssize_t htm_dump_sample_data(struct perf_event *event)
 	if (target->hw_buf_size) {
 		if (aux_buf->head >= target->hw_buf_size) {
 			aux_buf->collect_htm_trace = 0;
-			perf_aux_output_end(&handle, 0);
-			return 0;
+			ret = htm_collect_memory_config(event, aux_buf);
+			goto out;
 		}
 		if (chunk_size > target->hw_buf_size - aux_buf->head)
 			chunk_size = target->hw_buf_size - aux_buf->head;
@@ -757,6 +942,8 @@ static ssize_t htm_dump_sample_data(struct perf_event *event)
 	 * buffer session.
 	 */
 	aux_buf->collect_htm_trace = 0;
+	ret = htm_collect_memory_config(event, aux_buf);
+out:
 	perf_aux_output_end(&handle, 0);
 	return ret;
 }
@@ -862,7 +1049,21 @@ static void *htm_setup_aux(struct perf_event *event, void **pages,
 		return NULL;
 	}
 
+	/*
+	 * htm_mem_buf is the staging area passed directly to the
+	 * H_HTM_OP_DUMP_SYSMEM_CONF hcall.  The hypervisor is told the
+	 * buffer length is HTM_MEM_BUF_SIZE; allocate exactly
+	 * that amount.  See the HTM_MEM_BUF_SIZE comment for the derivation.
+	 */
+	buf->htm_mem_buf = kzalloc_node(HTM_MEM_BUF_SIZE, GFP_KERNEL, cpu_to_node(cpu));
+	if (!buf->htm_mem_buf) {
+		kfree(buf);
+		return NULL;
+	}
+
 	buf->collect_htm_trace = 1;
+	buf->collect_htm_mem = 1;
+	buf->mem_start = 0;
 	buf->head = 0;
 	return buf;
 }
@@ -877,6 +1078,7 @@ static void htm_free_aux(void *aux)
 	if (!buf)
 		return;
 
+	kfree(buf->htm_mem_buf);
 	kfree(buf);
 }
 
-- 
2.53.0



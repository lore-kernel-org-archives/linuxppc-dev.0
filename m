Return-Path: <linuxppc-dev+bounces-24819-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E9BC531C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 07:28:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6c0w59phz2ygK;
	Sat, 25 Jul 2026 17:28:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784964528;
	cv=none; b=NsnvCnLIalkRHiHK4ach9nm32y80qTKvT1udyuafe73g1DlJBLWJqUvWSep1nfgUhBOU1g973tWXVaRtOHyLVzKaWOxyg+UBWVbn8FD2tmk4jf8P6KIumKWv9JzSyUrQhF1XQvEpRDaq2jOrpunL03K25VBteuiUiuK6Wl7d87WWVlqF5s11+Qmvo+5Lsj05xlHzOxdkukp+ohxcRSPld6JVJ5aPpnc6J2lt281d+NjzvAhT+k3fl0F8OJs7BvTnBEVQyT4kZzMVnx4nUKcwEV7LDhp1VirJ5swB8v8sUbmYQL+j88lHxbpYJYzXyGv+nJ3ZopkHCk2aOJI4CSSL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784964528; c=relaxed/relaxed;
	bh=ikUuMoQ5Gdg8fwi6HvCV8ewDzztlwCUWMae+wSCrXWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQ9x7+vWvZiwuHa9R/52vhcLa3DilyJyhZL0LQjnNkhaGPVRomVC0mI0ypwXvwsEGrwcQUQgfNPKUjnDzkH/PJUGNmKO3dqSQKav+Defp4sqHnGoBPWZMBEd9dERCw9UMa5a4o0mqUHM2RqGXQedtY4hOFT7B63XIWER8+r0IXWbBwy3dYwup8Gi1wQ1G45aZphaSmbkdfyU3jqDFmMtOz7bCVS9lomJfUbv+Nha8GlCaDP8GvHRePphBScZt1bGEAMYI+ldIJGVbSra2aSr1sgGy9CQIV+k3JRCd0JjFD1H8f9aMkfuznFnElVl6FQ17oKtaCG0RUy2pUup/T60hQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qLmj4AAX; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qLmj4AAX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6c0v20q1z2ygG
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 17:28:46 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P5Cm242080372;
	Sat, 25 Jul 2026 07:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ikUuMo
	Q5Gdg8fwi6HvCV8ewDzztlwCUWMae+wSCrXWk=; b=qLmj4AAXI5J5gdcCIRLZbT
	hQEhsvUn12uUfvXcpzxXJxgRg4xfsQlhgnF/K785gKerOUpgOm+ViHyaMN2jSasM
	3Hw2fZrSzdcapQYESuoe6CWV3dGBl4XL105d6rOg4bALZUG6/Kkr4snZKXf/831D
	rC6ca2IATjMk2KCWsdk6i+Qtl/pInie7AoDLi9sxGrbdF/yWfF7DbqIVRPVXugvI
	XkLf2BQ4SFvvmFYlRAtpzBuuF57T/2e3DFoZXhmMb4iWU0Jj7nXQl8gLpUaNArGe
	+hcOfAiD4SonoXxB4AOZLPW6dXmsnWrSAwmOeTY53uDlArrEZxfzLBGlfO6ShZlg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmmtq0kr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:28:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P7QQg1015833;
	Sat, 25 Jul 2026 07:28:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn1u0jts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:28:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P7SbpO39321980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 07:28:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 416212011B;
	Sat, 25 Jul 2026 07:00:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B157620113;
	Sat, 25 Jul 2026 07:00:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.222.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 07:00:05 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V3 4/6] powerpc/perf: Capture the HTM memory configuration as part of perf data
Date: Sat, 25 Jul 2026 12:29:40 +0530
Message-Id: <20260725065942.78839-5-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260725065942.78839-1-atrajeev@linux.ibm.com>
References: <20260725065942.78839-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=JcWMa0KV c=1 sm=1 tr=0 ts=6a6465ac cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=58y-Zh21SeqGuYnbM7gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA2NiBTYWx0ZWRfX33gBTMCcjXFc
 zu3es8Ec5nIymob6Tokbt0ldVrywGqvB0K9ew9oxhuDI+6Rrja9NthUe/4rPht5pXyBWT+Vk0h7
 Xs6FrSE9LOWB0xYeGzXvfaxZU7Geectgbo64VupQnrn3GGiAsT9bscc1+X18Wy9xkquN+JH0Nw5
 tvELRMeq7hK8YavFWm2FgDTls6gkJxDrRRS8jbHiGku55S9VbsQKs92RJppF389qfWdvIfzZgxC
 JGlzphjH1iUXbXfqBjDfrEQ1SGwH8OTw2eL+8MPbQ5FIWxBOrtGMGuLd7aqJxJU4rK5mF0awYIU
 v4E5QCVrcCdVthN4Ir07w0L1eCm5ra2w69l7bw9Vj4xQVvJsYXz3ECCKNSeWCjYjkuP38x1Gr3F
 swvhut7Bri3I23AWUrxnuPhq2a2ZSYAgzhhLIZK0FB87c4zzPLgDETsh/4aUeOn7Tuyr3n3j0lm
 8UbnfYi/rzuoXCwQJSA==
X-Proofpoint-GUID: VPQdaGonm6N-7ogSHr8eFljbxIeyy6xC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA2NiBTYWx0ZWRfX4BKNYxFbj6jx
 zipXN4nzvybAon/X1VXeSXaRpr8wZApYU8WzB044oP7sGUyVTrnNxwE/L2huabRRVHdANX3O2Vo
 6yxdOAZbEpxYt+sUbxak6OptkmsvuLY=
X-Proofpoint-ORIG-GUID: VPQdaGonm6N-7ogSHr8eFljbxIeyy6xC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607250066

The H_HTM hypervisor call can also return the system memory
configuration, which describes the physical to logical real address
mapping for logical partitions.

After dumping HTM trace data into the AUX buffer, capture the
corresponding HTM system memory configuration records and emit them as
raw perf sample data for userspace parsing.

Add AUX-private tracking for a hypervisor memory-configuration dump
buffer, a stable emit buffer, and iterator state. Once AUX trace dumping
completes, htm_event_read() switches to H_HTM_OP_DUMP_SYSMEM_CONF and
iterates over the returned records until the configuration stream is
exhausted.

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

When perf_event_overflow() throttles the event (returns non-zero), the
iterator mem_start is not advanced.  The same memory configuration block
will be retried on the next htm_event_read() call once the event is
unthrottled.  collect_htm_mem is left set so the retry path is entered;
ENOSPC is returned so event->count is set to 1 and the drain loop
keeps retrying until the ring buffer consumer catches up.

Keep HTM tracing state in event->pmu_private via htm_target_id. AUX
private state is used only for dump progress and staging buffers.

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
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
- Clarified the perf_event_overflow() throttle path: when the event is
  throttled, mem_start is intentionally not advanced (the same block will
  be retried on the next drain pass once unthrottled).  Added a comment
  making this explicit and distinguishing it from the error/EOF paths
  that clear collect_htm_mem.

Changes in V2:
- Memory configuration records are now emitted as PERF_SAMPLE_RAW
  samples directly by htm_event_read() after the AUX trace dump
  completes, using H_HTM_OP_DUMP_SYSMEM_CONF.  V1 embedded the
  configuration data inside the AUX buffer itself and used two
  PERF_SAMPLE_RAW boundary markers (start/end) to delimit it.
- The two-marker boundary scheme is removed.  There is no longer any
  interleaving of memory configuration data inside the AUX stream;
  the AUX buffer carries only bus-trace data.
- Separate AUX-private fields for a hypervisor dump buffer, a stable
  emit buffer, and iterator state are introduced to manage the
  multi-call SYSMEM_CONF dump loop.
- Tracing state remains in event->pmu_private (htm_target_id); AUX
  private state is used only for dump progress and staging buffers,
  consistent with the restructuring in patches 1 and 3.

 arch/powerpc/perf/htm-perf.c | 205 ++++++++++++++++++++++++++++++++++-
 1 file changed, 204 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
index f880a5fc8833..af9a8412ff20 100644
--- a/arch/powerpc/perf/htm-perf.c
+++ b/arch/powerpc/perf/htm-perf.c
@@ -103,6 +103,10 @@ struct htm_pmu_buf {
 	u64	head;
 	u64     size;
 	int     collect_htm_trace;
+	void    *htm_mem_buf;	/* Staging bounce area allocated node-locally */
+	void	*emit_buf;	/* Stable buffer for perf raw sample emission */
+	u64     mem_start;	/* Hypervisor offset state iterator tracker */
+	int     collect_htm_mem;	/* State flag tracking whether memory logging is ongoing */
 };
 
 struct htm_pmu_ctx {
@@ -173,6 +177,174 @@ static ssize_t htm_return_check(int rc)
 #define HTM_TRACING_ACTIVE	1
 #define HTM_TRACING_INACTIVE	0
 
+/*
+ * HTM_MEM_BUF_SIZE is the allocation size for the hcall staging buffer.
+ * The hypervisor fills as many 32-byte entries as fit within the buffer
+ * size passed to H_HTM_OP_DUMP_SYSMEM_CONF — it does not cap at a fixed
+ * entry count.  Observed maximum fill is 64480 bytes (2015 entries).
+ *
+ * HTM_MEM_BUF_SIZE is chosen to satisfy two hard constraints:
+ *
+ *   1. Must cover the observed maximum fill:
+ *        HTM_MEM_BUF_SIZE >= 64480  (2015 * 32 + 32-byte header)
+ *
+ *   2. The full perf record (perf_event_header + fixed sample fields +
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
+ *   3. HTM_MEM_BUF_SIZE must be a multiple of 32 so a whole number of
+ *      32-byte entries fill it exactly.
+ *
+ * 65440 = 32 + 2043 * 32 is the largest multiple of 32 satisfying all
+ * three constraints:
+ *   - covers 64480 with 960 bytes headroom
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
+ * htm_collect_memory_config - drain H_HTM_OP_DUMP_SYSMEM_CONF into the
+ * perf ring buffer as PERF_SAMPLE_RAW records.
+ *
+ * Returns the number of 32-byte memory configuration entries emitted
+ * (to_copy / 32) on success, 0 if the event was throttled or the stream
+ * ended normally, or a negative error code on hard failure.  The caller
+ * (htm_dump_sample_data) uses the return value directly as event->count,
+ * consistent with the AUX trace path returning chunk_size / 128.
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
+	void *emit_buf = aux_buf->emit_buf;
+	long rc;
+	ssize_t ret = 0;
+	int retries;
+
+	/*
+	 * Initialise regs to the current caller context.  perf_event_overflow()
+	 * may sample register state into the ring buffer if the event was
+	 * opened with PERF_SAMPLE_REGS_INTR; an uninitialised stack frame
+	 * would leak kernel stack bytes to userspace.  Use
+	 * perf_fetch_caller_regs() to capture a safe, deterministic snapshot
+	 * of the current CPU state — the same pattern used by tracepoints and
+	 * BPF perf-event helpers for synthetic sample emission.
+	 */
+	perf_fetch_caller_regs(&regs);
+
+	/*
+	 * htm_mem_buf is the hcall memory buffer target reused each iteration.
+	 * emit_buf is a preallocated stable buffer used for perf raw
+	 * sample emission, so raw.frag.data remains valid during
+	 * perf_event_overflow().
+	 * Size: 32-byte header + HTM_MEM_MAX_ENTRIES * 32-byte entries.
+	 */
+	while (true) {
+		retries = 0;
+		do {
+			rc = htm_hcall_wrapper(htmflags, 0, 0, 0,
+					       0, H_HTM_OP_DUMP_SYSMEM_CONF,
+					       virt_to_phys(aux_buf->htm_mem_buf),
+					       HTM_MEM_BUF_SIZE, aux_buf->mem_start);
+			ret = htm_return_check(rc);
+		} while (ret == -EBUSY && ++retries < MAX_RETRIES);
+
+		/*
+		 * ret == 0 (H_NOT_AVAILABLE): normal end of stream — clear
+		 *   collect_htm_mem so the next read does not re-enter.
+		 * ret < 0 (error): hard failure — clear collect_htm_mem and
+		 *   stop.
+		 * Both cases are treated as "no more data for this session".
+		 */
+		if (ret <= 0) {
+			aux_buf->collect_htm_mem = 0;
+			break;
+		}
+
+		/*
+		 * Read next iterator value from the hcall response BEFORE
+		 * emitting — but only commit it to mem_start after a
+		 * successful write of raw data.
+		 */
+		next_start = be64_to_cpu(*((__be64 *)(htm_mem_buf + 0x8)));
+
+		/*
+		 * The hcall was given HTM_MEM_BUF_SIZE bytes of buffer space,
+		 * so num_entries is already bounded to HTM_MEM_MAX_ENTRIES.
+		 * The response is a complete hcall data:
+		 *   [32-byte header][num_entries * 32-byte entries]
+		 * Userspace can validate and parse it directly.
+		 */
+		num_entries = (__be64 *)(htm_mem_buf + 0x10);
+		to_copy = 32 + (be64_to_cpu(*num_entries) * 32);
+		if (WARN_ON_ONCE(to_copy > HTM_MEM_BUF_SIZE)) {
+			ret = -EIO;
+			aux_buf->collect_htm_mem = 0;
+			break;
+		}
+
+		memcpy(emit_buf, aux_buf->htm_mem_buf, to_copy);
+
+		perf_sample_data_init(&data, 0, event->hw.last_period);
+		memset(&raw, 0, sizeof(raw));
+		raw.frag.data = emit_buf;
+		raw.frag.size = to_copy;
+		perf_sample_save_raw_data(&data, event, &raw);
+
+		if (perf_event_overflow(event, &data, &regs)) {
+			/*
+			 * Event throttled: the record was not written to the
+			 * ring buffer.  Do NOT advance mem_start — the same
+			 * block will be retried on the next htm_event_read()
+			 * call once the event is unthrottled.  Leave
+			 * collect_htm_mem set so the retry path is entered.
+			 * Return -ENOSPC so htm_event_read() sets event->count=1,
+			 * keeping the drain loop alive until the ring buffer
+			 * consumer catches up.
+			 */
+			ret = -ENOSPC;
+			break;
+		}
+
+		/* Record written successfully: advance the iterator */
+		aux_buf->mem_start = next_start;
+
+		/*
+		 * Return the number of 32-byte memory configuration entries
+		 * in this batch (to_copy / 32).  Dividing here keeps
+		 * htm_event_read() free of format knowledge, consistent with
+		 * the AUX trace path returning chunk_size / 128.
+		 */
+		ret = (ssize_t)(to_copy / 32);
+
+		if (!next_start) {
+			aux_buf->collect_htm_mem = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static void reset_htm_active(struct perf_event *event)
 {
 	struct htm_target_id *target = event->pmu_private;
@@ -450,7 +622,7 @@ static ssize_t htm_dump_sample_data(struct perf_event *event)
 	if (!aux_buf)
 		return 0;
 
-	if (!aux_buf->collect_htm_trace) {
+	if (!aux_buf->collect_htm_trace && !aux_buf->collect_htm_mem) {
 		perf_aux_output_end(&htm_ctx->handle, 0);
 		return 0;
 	}
@@ -470,6 +642,11 @@ static ssize_t htm_dump_sample_data(struct perf_event *event)
 		}
 	}
 
+	if (!aux_buf->collect_htm_trace) {
+		ret = htm_collect_memory_config(event, aux_buf);
+		goto out;
+	}
+
 	/* Derive the exact target destination point directly out of active ring pointers */
 	dump_offset = htm_ctx->handle.head & (aux_buf->size - 1);
 	page_index = dump_offset >> PAGE_SHIFT;
@@ -572,6 +749,8 @@ static ssize_t htm_dump_sample_data(struct perf_event *event)
 	 * buffer session.
 	 */
 	aux_buf->collect_htm_trace = 0;
+	ret = htm_collect_memory_config(event, aux_buf);
+out:
 	perf_aux_output_end(&htm_ctx->handle, 0);
 	return ret;
 }
@@ -646,7 +825,29 @@ static void *htm_setup_aux(struct perf_event *event, void **pages,
 		return NULL;
 	}
 
+	/*
+	 * htm_mem_buf is the staging area passed directly to the
+	 * H_HTM_OP_DUMP_SYSMEM_CONF hcall.  The hypervisor is told the
+	 * buffer length is HTM_MEM_BUF_SIZE (65440 bytes); allocate exactly
+	 * that amount.  See the HTM_MEM_BUF_SIZE comment for the derivation.
+	 */
+	buf->htm_mem_buf = kmalloc_node(HTM_MEM_BUF_SIZE, GFP_KERNEL, cpu_to_node(cpu));
+	if (!buf->htm_mem_buf) {
+		kfree(buf);
+		return NULL;
+	}
+
+	buf->emit_buf = kmalloc_node(HTM_MEM_BUF_SIZE, GFP_KERNEL,
+			cpu_to_node(cpu));
+	if (!buf->emit_buf) {
+		kfree(buf->htm_mem_buf);
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
@@ -661,6 +862,8 @@ static void htm_free_aux(void *aux)
 	if (!buf)
 		return;
 
+	kfree(buf->emit_buf);
+	kfree(buf->htm_mem_buf);
 	kfree(buf);
 }
 
-- 
2.43.0



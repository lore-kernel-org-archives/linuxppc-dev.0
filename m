Return-Path: <linuxppc-dev+bounces-25002-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F049C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 12:38:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9BhJ2Zk6z2yrW;
	Wed, 29 Jul 2026 22:38:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785328704;
	cv=none; b=jIyBRsxKN8fLD6mTA2jUpuTQbeutT/9FGFBkeUmTITLNWAcQp0nl4GNlOiZOBp/LXItfx0fGIOCiTrUPNaBG2SeEvEocOtdDvAZPb6c808Or2wkB6pQ+lS3ebPBNmtxNiOs92pHwTjBjcJ5U19YyUfGnASZe1hR22+f955AoC+CVuw9CSBpmcnU7UHdFStgt97qVWu+ap9g5nwBcpE5ldwDTyTjrapQiC2cMtPhwILMkj6+Ov17n852VvPLfy96H4+eEZo5vvYykCZwPMrNaxAtQAkKRMZsuuGmUKc28Uc5Eb4p8/jsCVXFvG9Bkp07BIZOijY/xPGmrpLTx5pjoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785328704; c=relaxed/relaxed;
	bh=mvwNJkLOxcU8stzdw0I7HGUJ2J2k2en1jaE/dD1yXdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oscUdQpqga1jHMQL/7GNSgs5DvuK0jN1RTHllOREd7XhA3AimtgBXVEvpD1SI7iQ0mKu3mBvp+18H9gsuY8j8m8b9VlJ7eYPMTQHRJxmi7pDxPtSvJ2srXdMHh+y5JIcUuZpjIj3ZdDbJL9xBPe033ihw2MRJ8xY8yUFxpOFH4qXSXEa2WwW+QqTILe65WCT99ufq9czrwmA6hqVQPnigUsNKI4jLG9Lgo/vA3bmNcUNy0byNXykP3KW+4dn7LqTWaA+cKuopc+nR2qM0BrCaG0cqesADBzHpAhSVqPLCrWjvwEdfQqxQu1Rx5Fn/XIe1m1sDiXoZHIF8Gq7yqzjvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nE/Tf0tD; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nE/Tf0tD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9BhH280Gz2yn2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 22:38:22 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBIBGI2165612;
	Wed, 29 Jul 2026 12:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mvwNJk
	LOxcU8stzdw0I7HGUJ2J2k2en1jaE/dD1yXdU=; b=nE/Tf0tDf7AHYdoA9eyUQW
	ET5/hgY9yzqgiQPoHT/LkRRkU7D/DHcBcsadFuCN0OU7+0DQRZtYcZZsRexFTVvE
	yjFDVic7plACReoWcnaJpkCf75mlaPhpFZEzWge0xTLhg+Mbvpaws8xLedzF7dVY
	qFtIifxKt5ma2xU1SezTJmNlUdtZKKHZgxRA7AgvqCMBlMQec9HEW1BAYJ8Zwkub
	hcpPnJV3yHqR5nao2JjyreTnxIwBpau2q5gTHjXzjlPOQJWDB2glEgbbqGmHkBwV
	/IQs4DZt5yWl71iOJktTFfPv9it/Aa4wKsyBdsHlKq7CI/QZmPPEBHeqWvmD1ZmQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycjk1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:38:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCQHWJ015732;
	Wed, 29 Jul 2026 12:38:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqev4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:38:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCcEf425559502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:38:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CF8220040;
	Wed, 29 Jul 2026 12:38:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CA8A20043;
	Wed, 29 Jul 2026 12:38:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 12:38:11 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V4 4/6] powerpc/perf: Capture the HTM memory configuration as part of perf data
Date: Wed, 29 Jul 2026 18:07:50 +0530
Message-Id: <20260729123752.63010-5-atrajeev@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Sffc2o4-XzQ7X35GVl2rH0i54JVB2HJk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX/Imce1OeAlOO
 CwTH2XpXnqGYVDAhTsPMoZ0CWEXlBBKrVHWtx8uU/f3E7ZqlGTiOwC6yEs69x8XGQgHjyHedm5D
 BA/CLRaQ1Zn4Idd98xS7p4nwPQtGk1hFrbbGSreXONzS1RQBTIUul2VEUadLnQQJPpheHmXoW8O
 onC4lAb+x6C/h9+kmvy2cHgFDbnUTGR5LXo3+FEQRj5oPPXWA/Y8SjvazdbBwBcQoNQg+qrITYI
 S4LO9RNyBSjQpfZS5qpyvtV8IxaKOQ02B4G7u9of75qZVVcF2T11MfCJmSxqlAabRdftQxrF1WY
 h8uJ+61TZOb8NZ1pN1+Gcy1fTEWANB5cg8vBnWx3kE99H7c6WT3e88KmhH/CPFvYQKpt0I5DfEt
 Hbb2606X9TNnjQP8R1NRumENfkJ64JFkmYGgdInjCBYA9cGuSneBpwXE92Xb4nSiKqA54kMgxpA
 PYniBLCR+Z+ZkAL4g9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX9bIsCSjRmmOU
 T5pMiuJiy8m3MyMoLxrYw1uqMB1H7LksbqtK/GEkj2e/or0s5LcOPLkvqq/bhmnoo4PVpCSChlc
 cX045JN76tQzNMiO6dWJsSJ1zFD/V4U=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a69f43c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=8Q_xNA3RzAoMIHAl5xEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Sffc2o4-XzQ7X35GVl2rH0i54JVB2HJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

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

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
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

 arch/powerpc/perf/htm-perf.c | 175 ++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
index 656f9b5aa38d..81e65b13d34d 100644
--- a/arch/powerpc/perf/htm-perf.c
+++ b/arch/powerpc/perf/htm-perf.c
@@ -103,6 +103,9 @@ struct htm_pmu_buf {
 	u64	head;
 	u64     size;
 	int     collect_htm_trace;
+	void    *htm_mem_buf;	/* Staging area for H_HTM_OP_DUMP_SYSMEM_CONF hcall */
+	u64     mem_start;	/* Hypervisor iterator position for DUMP_SYSMEM_CONF */
+	int     collect_htm_mem;	/* State flag tracking whether memory logging is ongoing */
 };
 
 struct htm_pmu_ctx {
@@ -182,6 +185,154 @@ static ssize_t htm_return_check(int rc)
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
+	 * Initialise regs to the current caller context.  perf_event_overflow()
+	 * may sample register state into the ring buffer. Use
+	 * perf_fetch_caller_regs() to capture a safe, deterministic snapshot
+	 * of the current CPU state — the same pattern used by tracepoints and
+	 * BPF perf-event helpers for synthetic sample emission.
+	 */
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
+	/* Record emitted successfully: advance the iterator */
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
@@ -523,7 +674,7 @@ static ssize_t htm_dump_sample_data(struct perf_event *event)
 	if (!aux_buf)
 		return 0;
 
-	if (!aux_buf->collect_htm_trace) {
+	if (!aux_buf->collect_htm_trace && !aux_buf->collect_htm_mem) {
 		/*
 		 * collect_htm_trace is cleared on hcall error and reset to 1
 		 * in htm_event_start() when tracing restarts.  If it is still
@@ -549,6 +700,11 @@ static ssize_t htm_dump_sample_data(struct perf_event *event)
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
@@ -651,6 +807,8 @@ static ssize_t htm_dump_sample_data(struct perf_event *event)
 	 * buffer session.
 	 */
 	aux_buf->collect_htm_trace = 0;
+	ret = htm_collect_memory_config(event, aux_buf);
+out:
 	perf_aux_output_end(&htm_ctx->handle, 0);
 	return ret;
 }
@@ -736,7 +894,21 @@ static void *htm_setup_aux(struct perf_event *event, void **pages,
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
@@ -751,6 +923,7 @@ static void htm_free_aux(void *aux)
 	if (!buf)
 		return;
 
+	kfree(buf->htm_mem_buf);
 	kfree(buf);
 }
 
-- 
2.43.0



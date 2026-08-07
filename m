Return-Path: <linuxppc-dev+bounces-25589-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A0BC2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:38:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGmwH5W3pz3c7n;
	Sat, 08 Aug 2026 00:38:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786113487;
	cv=none; b=aQmZggIwihOyoJTGWps9IDBEk6HhuBjIraNyplckUv9LHkV56gI/H85QD/6ty+9szU5P642oblMci0tOG3xagJqa0K+9wq+QS7cTFJqwM3/NhSdxrh4/v9f1ItQ4jgt5AD/NKnixspz27gE1c5ro0dlxT5r6UInldcKNqzapHWLKZE1mOMAC91qI8o7Xd0ADtDUqudM52JQHXBsYXqSBXlePF72YP55/A43GSiL/vGpPVFSR2CUtJ3mqJLfBUInn/AudGSnGX7Zv+il891ekQBsp9EKqKHzqHD0Sdu24OSH31ncm/6nMLVw1ogmCtUqNlZXAwDuvHXqaJMQfdFJUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786113487; c=relaxed/relaxed;
	bh=tMXygelTc7B6WTgDKtAKqXMiK18VIy6YCdPDm1TWJ+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lTPrKElyV2z0TKet0vl/ZkWeDYEWS2icdp1gVJr0i+PuX8R0nSfiQa0X0XBkjnjfsTCNkZHhZldl+g/tvbMugfGz4SKY4KaimY9z8VR99q5Y9t/Gy3ABCZNNGBACHu08dGneppGW70llG6PxZO1zvg950JpEBBN9BGWb3W0VoxSuxXanWWoaXI/Llfgpw3NHbYsZZBkvqyuQm6ODkW5Wt7AO0jU4JtPEE6S7edCODb9T+PNMofLtTn+4jjaBoFjfUkQ4zsjX0gBWNmDIW61VbHOoJpaxFebpeN+GhZUrKrUwziz3+YcgK1GM7fWkoe/B6U1Ay+bjidFOhyA9Gz7Ryw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p8XvGafi; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=p8XvGafi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGmwF6R2nz3c4D
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 00:38:05 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677CmDaN1421031;
	Fri, 7 Aug 2026 14:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tMXyge
	lTc7B6WTgDKtAKqXMiK18VIy6YCdPDm1TWJ+8=; b=p8XvGafidv+XAjV4lVhXdz
	VpGp7ST/zJDTg512Kd0ZM8Qm3anyPEejh68BQjYo7J+6qXKUkShLUtjbzDgYPf1P
	nuXGYGBbdLfizB5Y+p8TB5LevBHvdz/BRtnNDXZe8+7ReXsWioEBj2TngQfUst6Z
	rVQU3cboVm5Ayjq01SJQZiyHQQk7xnsj1zDoFfhCQP5hFnteUFtoPNYTBo4a0SnO
	7vaFFvMm3BEci7CBOg7XrdZFUy/tYuBd6UdrraUXvhQPpIXzxxhSrhnwIntG6crb
	Jrc4W1zqIX8U0yKV1qHNTlRv477WZ9DNoOwJtQgSCgl96dytw8wmMeoUikhKp8gw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02474p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:38:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EQLjI017267;
	Fri, 7 Aug 2026 14:38:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwg5eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:38:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677EbtQi42861034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:37:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9E1F20043;
	Fri,  7 Aug 2026 14:37:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E55920040;
	Fri,  7 Aug 2026 14:37:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:37:53 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V5 1/6] powerpc/perf: Add HTM PMU driver to expose Hardware Trace Macro data
Date: Fri,  7 Aug 2026 20:07:29 +0530
Message-Id: <20260807143734.1224-2-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 7PZT2l1W3GWzA1PGcgJh8unqVaMmp75b
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a75edca cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=QQqG_2NUGTNwCOjroMAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7PZT2l1W3GWzA1PGcgJh8unqVaMmp75b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX0/6x39eJcEto
 LrPO7ipwfitTm2Bx1s375oNfWHO7AQ7BUEeOiwinbH+gspGnNWg7ixVHoMdet+1L50dnWtPzYnl
 WeHOw4WLzwn/yA7oSGDP8/Zx/wsMs6td6SgyPfqJj4t0Hcue3t3NqVyDkZhW1E3lik70L9+PMDQ
 e6e7JTckzdu8kD0tI/XJf0o8Mw9M2NIBFv0N9rD7lNwqXZDdKoyjiO/yfkbUTkNVTCgxcQ6lxnr
 ZHWEtAbXHubFtWqRavsMp3/9cIl4nUTrtSrTG1Mbio4fS2Kn+4JBV0BP857kjguGtkbVX39C6dH
 21zFYH1iFa+4wL+X6Dgr10kKnNGeXvFNta1RL6aK5K0jHEgeaNB5kt6pqQq5/7lGPkst7uhig0f
 OTzbYyO6b9L9pNvC2WxFrOg3eco5Y+Qpbcyj+V3EoPnJyHue0PR2Kb31I8eVdT/p79EAXTIwpLe
 O4MiZqHXA0M2JNqF+cg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX2ZS/camwn0G/
 007csy2Ju8SvcCcHpBi3bvZiMRrr0ddJXlBp4B/cMN7VbW5VddkSA8kaEsRKfcP0sC3LYAVUqXF
 bAH+211RniuUUW/fJPeC82KjxUReDLw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070112

The H_HTM hypervisor call (hcall) provides an interface to the Hardware
Trace Macro (HTM) function on POWER systems.  HTM captures hardware-level
trace data for a specific node/chip/core target within a logical partition.

Add a new "htm" Performance Monitoring Unit (PMU) that exposes HTM control
via the standard perf interface.  The event configuration is a 28-bit value
packed into the perf config field:

  bits  0-3:  htm_type         (HTM_CORE=2, HTM_NEST=1, HTM_LLAT=3)
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
the source of information, with event->hw.state kept in sync as a hint
for the perf core.  This avoids conflicts with infrastructure writes to
event->hw.state.

H_BUSY, H_LONG_BUSY_* and other errors handling:

  All PMU callbacks (add, del, start, stop) are invoked in an atomic
  context with interrupts disabled and hardware context locks held;
  sleeping is not possible anywhere in the driver.

  H_BUSY (transient): retried in a spin loop up to MAX_RETRIES times.

  H_LONG_BUSY_* (hypervisor requests a long delay before retry) and
  other errors: not retried.  The correct response differs by callsite:

  - pmu->add (H_HTM_OP_CONFIGURE): on any non-success result from the
    configure hcall, calls perf_event_disable_inatomic() and returns 0.
    event_sched_in() in the perf core converts any non-zero pmu->add()
    return to -EAGAIN and leaves the event as PERF_EVENT_STATE_INACTIVE,
    which the mux would retry on every tick.  Returning 0 and calling
    perf_event_disable_inatomic() instead schedules a task-work callback
    that sets PERF_EVENT_STATE_OFF — permanently disabled, never
    rescheduled by the mux.

  - pmu->stop (H_HTM_OP_STOP): exits immediately on any failure,
    leaving tracing_active as HTM_TRACING_ACTIVE.  The perf core always
    calls pmu->del() after pmu->stop(), so htm_event_del() is the
    guaranteed retry point for the stop hcall.

  - pmu->del (H_HTM_OP_STOP retry and H_HTM_OP_DECONFIGURE): retries
    the stop hcall first.  H_HTM_OP_DECONFIGURE requires the trace to be
    stopped first; if the stop retry fails, the deconfigure will
    fail too.  Both failures are surfaced via pr_err with target
    identifiers (node/chip/core/type).
    A workqueue-based deferred cleanup was considered but rejected as
    over-engineering for a firmware-maintenance-only edge case that is
    consistent with how all other in-tree POWER hcall-backed PMU drivers

Note: this patch does not prevent two concurrent perf_event_open() calls
for the same HTM hardware target (node/chip/core) from being opened
simultaneously on different CPUs.  PERF_PMU_CAP_EXCLUSIVE only enforces
exclusivity within the same per-CPU context and does not cover this case.
A global reserved-targets list to reject duplicate reservations is added
in the next patch.

After this patch the PMU is visible under sysfs:

 # ls /sys/bus/event_source/devices/ |grep htm
 htm

 # ls /sys/bus/event_source/devices/htm/
 events  format  perf_event_mux_interval_ms  power  subsystem  type  uevent

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changes in V5:
- Add HTM_LLAT (htm_type=3) as a third supported HTM type alongside
  HTM_NEST and HTM_CORE.  Add EVENT(HTM_LLAT, 0x3) and
  GENERIC_EVENT_ATTR/PTR entries, and extend the htm_type switch in
  htm_event_init() with case HTM_LLAT.
- htm_target_id: add int configured field to track whether
  H_HTM_OP_CONFIGURE succeeded for this event.  Set to 1 in
  htm_event_add() after a successful CONFIGURE, cleared to 0 if the
  subsequent H_HTM_OP_START fails.  htm_event_del() guards its
  H_HTM_OP_DECONFIGURE call with if (!target->configured) return; to
  prevent issuing DECONFIGURE when CONFIGURE was never completed or was
  already undone, which would destroy a concurrent trace session on the
  same target.
- htm_event_init(): extend the sample_type rejection to cover
  PERF_SAMPLE_CALLCHAIN, PERF_SAMPLE_STACK_USER, PERF_SAMPLE_REGS_USER,
  and PERF_SAMPLE_AUX in addition to the existing PERF_SAMPLE_REGS_INTR
  check.  All of these either add variable-length data to the ring buffer
  record (overflowing the fixed HTM_MEM_BUF_SIZE budget), require kernel
  stack walking that is unsafe from the HTM read path, or conflict with
  AUX buffer ownership.  A single combined check replaces the two
  separate guards.

Changes in V4:
- htm_event_add(): replace -ENODEV / -EIO returns on configure or start
  failure with perf_event_disable_inatomic(event) + return 0.
  event_sched_in() in the perf core overrides any non-zero pmu->add()
  return to -EAGAIN and sets PERF_EVENT_STATE_INACTIVE, which the mux
  retries on every tick; this would flood the hypervisor with
  H_HTM_OP_CONFIGURE hcalls when it has requested a long backoff.
  perf_event_disable_inatomic() schedules a task-work callback that sets
  PERF_EVENT_STATE_OFF, permanently excluding the event from the mux.
- PERF_EF_RELOAD comment in htm_event_start(): expanded to explain that
  HTM does not use frequency mode, so there is no period or counter to
  unthrottle, and that the guard is belt-and-suspenders because
  .task_ctx_nr = perf_invalid_context prevents pmu->start() from being
  called on context-switch-in entirely.
- PERF_EF_UPDATE comment in htm_event_stop(): expanded to explain that
  HTM has no counter to snapshot on context-switch-out (data flows into
  the AUX buffer via pmu->read), and that the guard is belt-and-suspenders
  for the same reason as above.
- Added explanation above HTM_TRACING_ACTIVE that pmu->add/del are never
  called on context switch: .task_ctx_nr = perf_invalid_context forces
  CPU-wide-only placement; perf_event_context_sched_out/in() only walks
  task->perf_event_ctxp which is NULL for tasks with no task-context
  events, so the switch path returns immediately without touching HTM.
- Fixed typos: "erros" -> "errors" (commit body and two in-code comments).
- htm_event_init(): reject attr.freq with -EINVAL.  HTM is a
  hardware-scope bus tracer with no counter or sample period.  Frequency
  mode makes the core call pmu->stop/start every tick to adjust the
  sample period — meaningless for HTM — and would corrupt event->count
  semantics (the driver uses it as a record count; the freq machinery
  would interpret it as a sample-rate measurement).  perf record already
  forces attr.freq=0 in htm_recording_options(), but rejecting it in the
  kernel closes the gap for any direct perf_event_open() caller.
- htm_event_init(): reject PERF_SAMPLE_REGS_INTR with -EOPNOTSUPP.
  The HTM_MEM_BUF_SIZE record size calculation (patch 4) assumes a fixed
  92-byte overhead; PERF_SAMPLE_REGS_INTR adds sizeof(struct pt_regs)
  (~296 bytes on PowerPC) to each sample, overflowing the __u16
  perf_event_header.size limit and corrupting the ring buffer.

Changes in V3:
- Expanded the H_BUSY, H_LONG_BUSY_* and other errors handling section to
  give per-callsite rationale for each hcall (configure, stop, del).
  V2 described the retry policy but not why each site responds differently.
- Added explicit note that this patch does not yet prevent duplicate concurrent
  perf_event_open() calls for the same HTM target; that is handled in patch 2.
  V2 omitted this cross-reference.
- Diffstat grows from 379 to 422 lines added (the extra lines come from the
  expanded commit message body; no functional change to the driver code
  itself).

Changes in V2:
- Moved the HTM PMU driver from arch/powerpc/htm/ to arch/powerpc/perf/
  and renamed the source file from htm.c to htm-perf.c to follow the
  naming convention of other PMU drivers in that directory.
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
 arch/powerpc/perf/htm-perf.c | 517 +++++++++++++++++++++++++++++++++++
 2 files changed, 518 insertions(+), 1 deletion(-)
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
index 000000000000..cbe4f62813ee
--- /dev/null
+++ b/arch/powerpc/perf/htm-perf.c
@@ -0,0 +1,517 @@
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
+EVENT(HTM_NEST,		0x1);
+EVENT(HTM_CORE,         0x2);
+EVENT(HTM_LLAT,		0x3);
+
+GENERIC_EVENT_ATTR(htm_nest, HTM_NEST);
+GENERIC_EVENT_ATTR(htm_core, HTM_CORE);
+GENERIC_EVENT_ATTR(htm_llat, HTM_LLAT);
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
+	GENERIC_EVENT_PTR(HTM_LLAT),
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
+	int configured;			/* 1 after H_HTM_OP_CONFIGURE succeeds; 0 otherwise */
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
+		 * Hypervisor requests a long delay before retry.  All PMU
+		 * callbacks (add, del, start, stop) are invoked in an atomic
+		 * context with interrupts disabled and hardware context locks
+		 * held. sleeping is not possible anywhere in the driver.
+		 * Return -EAGAIN so every caller can distinguish this from
+		 * transient H_BUSY and treat it as a hard failure without
+		 * spinning or sleeping. See the per-callsite comments for how
+		 * each caller handles it.
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
+ *
+ * Note: pmu->add() and pmu->del() are NOT called on every context switch
+ * for HTM events.  .task_ctx_nr = perf_invalid_context means HTM events
+ * can only be opened CPU-wide (perf_event_open() returns -EINVAL for any
+ * task-specific open).  CPU-wide events live in cpuctx->ctx, not in
+ * task->perf_event_ctxp.  perf_event_context_sched_out/in() only walks
+ * task->perf_event_ctxp and returns immediately when it is NULL, so
+ * pmu->add/del are never triggered by a context switch.  The
+ * PERF_EF_RELOAD / PERF_EF_UPDATE guards below checks this.
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
+	/*
+	 * Reject sample types whose payload size cannot be statically bounded
+	 * or whose maximum size would overflow the 16-bit
+	 * perf_event_header.size limit when combined with HTM_MEM_BUF_SIZE:
+	 *
+	 * PERF_SAMPLE_CALLCHAIN  — (1 + nr) * 8 bytes; nr is runtime-defined,
+	 *                          default up to 127, configurable to 1024+.
+	 * PERF_SAMPLE_STACK_USER — up to ~65443 bytes depending on header size.
+	 * PERF_SAMPLE_REGS_USER  — depends on sample_regs_user bitmask at open
+	 *                          time; up to 44 regs × 8 = 360 bytes.
+	 * PERF_SAMPLE_REGS_INTR  — same as REGS_USER.
+	 * PERF_SAMPLE_AUX        — in-sample AUX snapshot; size is runtime.
+	 *
+	 * All remaining sample types (IP, TID, TIME, ADDR, PERIOD, CPU, etc.)
+	 * contribute exactly one u64 each.  Their worst-case combined overhead
+	 * is accounted for in HTM_MEM_BUF_SIZE (patch 4): the buffer is sized
+	 * so that HTM_MEM_BUF_SIZE + max fixed overhead <= 65535.
+	 */
+	if (event->attr.sample_type & (PERF_SAMPLE_CALLCHAIN  |
+				       PERF_SAMPLE_STACK_USER  |
+				       PERF_SAMPLE_REGS_USER   |
+				       PERF_SAMPLE_REGS_INTR   |
+				       PERF_SAMPLE_AUX))
+		return -EOPNOTSUPP;
+
+	/*
+	 * HTM is a continuous bus tracer with no counter or sample period.
+	 * Frequency mode makes the core call pmu->stop/start every tick to
+	 * adjust the sample period — meaningless for HTM — and would corrupt
+	 * event->count semantics (the driver uses it as a record count).
+	 * perf record already forces attr.freq=0 in htm_recording_options(),
+	 * but reject it here to close the gap for direct perf_event_open() callers.
+	 */
+	if (event->attr.freq)
+		return -EINVAL;
+
+	parse_htm_config(config, &cfg);
+	switch (cfg.htmtype) {
+	case HTM_CORE:
+	case HTM_NEST:
+	case HTM_LLAT:
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
+	 * Ignore context-switch re-enables (PERF_EF_RELOAD).  HTM is a
+	 * not a frequency-mode counter PMU. PERF_EF_RELOAD is used by
+	 * the core to restart a counter after unthrottling a frequency-based
+	 * event; HTM has no period or frequency knob and nothing to unthrottle.
+	 * In practice this path is never reached because
+	 * .task_ctx_nr = perf_invalid_context prevents task-context placement,
+	 * so pmu->start() is never called on context-switch-in.
+	 * The guard is kept as check.
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
+	 * Ignore context-switch-out stops (PERF_EF_UPDATE).
+	 * HTM is a continuous bus tracer; stopping the hardware on
+	 * every context switch would break continuous tracing, which is the
+	 * entire purpose of this PMU.  PERF_EF_UPDATE is used by the core to
+	 * snapshot a counter value on context-switch-out; HTM has no counter
+	 * to read (data flows into the AUX buffer via pmu->read).  In
+	 * practice this path is never reached because .task_ctx_nr =
+	 * perf_invalid_context prevents task-context placement, so
+	 * pmu->stop() is never called on context-switch-out.  The guard is
+	 * kept as check.
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
+	/*
+	 * pmu->add() is invoked in an atomic context with interrupts disabled
+	 * and hardware context locks held; sleeping is impossible.  Only retry
+	 * on transient H_BUSY.  On H_LONG_BUSY_* (-EAGAIN) or any other error,
+	 * the loop exits and we call perf_event_disable_inatomic() + return 0.
+	 * Returning any non-zero value from pmu->add() would cause
+	 * event_sched_in() to convert it to -EAGAIN and leave the event as
+	 * PERF_EVENT_STATE_INACTIVE, which the mux retries on every tick,
+	 * flooding the hypervisor with H_HTM_OP_CONFIGURE hcalls exactly when
+	 * it has requested a long backoff delay.  perf_event_disable_inatomic()
+	 * schedules a task-work callback that sets PERF_EVENT_STATE_OFF,
+	 * permanently excluding the event from the mux.
+	 */
+	do {
+		rc = htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
+				       cfg.coreindexonchip, cfg.htmtype,
+				       H_HTM_OP_CONFIGURE, param1, param2, 0);
+		ret = htm_return_check(rc);
+	} while (ret == -EBUSY && ++retries < MAX_RETRIES);
+
+	if (ret <= 0) {
+		perf_event_disable_inatomic(event);
+		return 0;
+	}
+
+	/*
+	 * htm_event_init() allocated event->pmu_private (struct htm_target_id)
+	 * and set event->destroy = reset_htm_active to free it on teardown.
+	 * Initialise the tracing state and hw.state before calling start.
+	 * Mark configured so htm_event_del() knows a matching DECONFIGURE is
+	 * required.  This flag is the only gate; htm_event_del() must not
+	 * call H_HTM_OP_DECONFIGURE unless this driver issued the paired
+	 * H_HTM_OP_CONFIGURE — doing so would silently destroy a concurrent
+	 * trace session that owns the same hardware target.
+	 */
+	target->configured = 1;
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
+			/*
+			 * Start failed.  Attempt to deconfigure to avoid leaving
+			 * the hypervisor resource permanently reserved.
+			 * pmu->add() is atomic; only H_BUSY is retried.  If
+			 * H_LONG_BUSY_* or another error is returned here, the
+			 * resource cannot be reclaimed in this context; log the
+			 * failure so it is visible in the kernel log.
+			 * Call perf_event_disable_inatomic() so the event is
+			 * permanently disabled (PERF_EVENT_STATE_OFF) rather
+			 * than left inactive and retried by the mux.
+			 */
+			retries = 0;
+			do {
+				rc = htm_hcall_wrapper(htmflags, cfg.nodeindex,
+						       cfg.nodalchipindex, cfg.coreindexonchip,
+						       cfg.htmtype, H_HTM_OP_DECONFIGURE, 0, 0, 0);
+				ret = htm_return_check(rc);
+			} while (ret == -EBUSY && ++retries < MAX_RETRIES);
+			if (ret <= 0) {
+				pr_err("DECONFIGURE failed in htm event add (ret=%d) node:%u chip:%u core:%u type:%u;\n",
+						ret, cfg.nodeindex, cfg.nodalchipindex, cfg.coreindexonchip, cfg.htmtype);
+			}
+			/*
+			 * We already issued DECONFIGURE above; clear configured so
+			 * htm_event_del() does not issue a second one.
+			 */
+			target->configured = 0;
+			perf_event_disable_inatomic(event);
+			return 0;
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
+	/*
+	 * pmu->del() is called by the perf core after pmu->stop(), whether
+	 * triggered by ioctl(PERF_EVENT_IOC_DISABLE) or event destruction.
+	 * pmu->del() is invoked in an atomic context with IRQs disabled,
+	 * sleeping is impossible.
+	 *
+	 * If a prior htm_event_stop() call returned with tracing_active still
+	 * set to HTM_TRACING_ACTIVE (because H_LONG_BUSY_* caused an immediate
+	 * exit), calling htm_event_stop() again here with flags=0 retries the
+	 * H_HTM_OP_STOP hcall.  This del path is the guaranteed retry point:
+	 * the perf core will always reach del after stop, so the trace is not
+	 * permanently left running in the hypervisor.  Only H_BUSY is retried
+	 * here; H_LONG_BUSY_* or any errors on stop is treated as a best-effort,
+	 * ie the deconfigure that follows will still be attempted and error logged.
+	 */
+	htm_event_stop(event, 0);
+
+	/*
+	 * Only issue H_HTM_OP_DECONFIGURE if this driver successfully issued
+	 * the paired H_HTM_OP_CONFIGURE.  If htm_event_add() failed before or
+	 * during CONFIGURE (configured == 0), there is nothing to tear down.
+	 * Issuing DECONFIGURE without a prior CONFIGURE would silently destroy
+	 * a concurrent trace session that owns the same hardware target and
+	 * produce spurious pr_err() noise for an expected H_STATE / H_NOT_AVAILABLE
+	 * response.
+	 */
+	if (!target->configured)
+		return;
+
+	/*
+	 * Deconfigure the hardware resource.  Only H_BUSY is retried.
+	 * If H_LONG_BUSY_* or any other error is returned, the resource
+	 * cannot be reclaimed in this atomic context; log the failure so it
+	 * is visible in the kernel log.
+	 */
+	do {
+		rc = htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
+				       cfg.coreindexonchip, cfg.htmtype,
+				       H_HTM_OP_DECONFIGURE, 0, 0, 0);
+		ret = htm_return_check(rc);
+	} while (ret == -EBUSY && ++retries < MAX_RETRIES);
+	if (ret <= 0) {
+		pr_err("DECONFIGURE failed in htm event del (ret=%d) node:%u chip:%u core:%u type:%u;\n",
+				ret, cfg.nodeindex, cfg.nodalchipindex, cfg.coreindexonchip, cfg.htmtype);
+	}
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
2.53.0



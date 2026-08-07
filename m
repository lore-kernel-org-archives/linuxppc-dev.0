Return-Path: <linuxppc-dev+bounces-25588-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76634C2A09B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:38:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGmwD5NVgz3c4l;
	Sat, 08 Aug 2026 00:38:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786113484;
	cv=none; b=N9//2hYbdFuQ2vi981YzcLyRiNEe1Sgqax9J92/olXsrpUQ2qyd6cr1IELGTSalpvuiKHY7hz92W3D2S3TsFVTt2uxapZnCB0aUV1Vi3Xipk1qGn+sNIgNixR8rGgUrZGnqoncoxnJ7FWW4+r0m8JTjyz8tE5IAh3caMLv8JFmoEEf/U1zzEtuj0RmAzKRTaXW4Jf3swSjtwUWW0R4p5Qa2fmoy04nFMOpCpiGmVlAz+BNNnZUdx/iWa8EsBSpl3fMTwt1jrkxKpMj0RcgZyugyYtq/IsjstYhVjS3MXeL0BHoHoNjVwU+v9vid4gxYQJBhvZSi2OXGA4ykbH78oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786113484; c=relaxed/relaxed;
	bh=wJ/W/Fi1b/6h4ADYkcco/0/E7e58RC8K+goVg5EQT5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TUz7n966l0qtIWtwNmfkwUmyp0JgnXqRwgYdNBiR5vA1bshJR9jLLX+M2rI7EncMohb5VxumAYMvRJd+kSuTm1gQDc3BurSfiRXPl47mCWNJ5qbHZQ81U3mPuYNiIVKJ9K48MBHNXIV3TmCV+hBP9ieKTJ46xfRTV0H0mAjlyJeOHFo4kXLNKVdA22O12W8p6lxNNlZ5TZoam9wZbyy/qTPFKBfqziwRUHzlq+AEbTpOgquuPzExKJZTPATXzQpffsUxs4vs6Z6sKo+JF/ThkWkqyk5mCx3Ph36trFqSUIkqepdsZquZS2Y8gmwltgSis5OiKV6/E1VP1OgPUXqsvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mTi6sujP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mTi6sujP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGmwB2Y7mz3c4D
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 00:38:01 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677ClbQM1485050;
	Fri, 7 Aug 2026 14:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=wJ/W/Fi1b/6h4ADYkcco/0/E7e58
	RC8K+goVg5EQT5s=; b=mTi6sujPRoyMbfEfQByezRB0K8AI5pVGSjAryh/D8ZXl
	WG8iUeUEjgV85R9Ma+VuoOqvG0tXXod2TpH/kDH2bRWRVOTO+/ruP6yVkLhDcLOz
	qDFhUwjt0a3XJlD5DIgIPlPoJ5WbF0fUnOXh27B4Sga2nxZXdTan2G7XwuSZBzA9
	Twl9aLp77gDxEBFNyojGa2v/bph57pFNbIN7R0YKcYxQCN4rmCjtY27qt38CzxWs
	N6XDo4+60ZTYbAz1s4A8JrqeWjVwAJ/1n80j1ldTRt82Kv4UEqNrw8hOpOsfko+S
	1WNZ/RpIWZfVSFi7FEO1XGR1QjRqZZ75yKnoGb+4uw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy044bp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:37:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677EQKnQ003677;
	Fri, 7 Aug 2026 14:37:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4r05w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 14:37:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Ebrkr47841670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 14:37:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CF1820043;
	Fri,  7 Aug 2026 14:37:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5C7A20040;
	Fri,  7 Aug 2026 14:37:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 14:37:50 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V5 0/6] powerpc/perf: Add HTM PMU driver and perf AUX support
Date: Fri,  7 Aug 2026 20:07:28 +0530
Message-Id: <20260807143734.1224-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX4MJ32JQrns8/
 BmsHUsgh7WA85IG05FXXsuXje5QZejuS+dlIAWpIb3f0YToLE4rxKlJDGh3EF79WRtlNlLivUU6
 VInL3LsL0Ufe9UiuzaNY6pbUcBTEAnSSZ0/DJXSeJr5vpaCugA3vX2BYbOPSMmDPAJ6XEvI83+X
 /D1MVtkSwlw6mZrVVUt+KUaNjAlF+bdPhEdBXDu5CvE0sSi5QOrZnzt3QmGYnaMBXdh+/pmYY9y
 UJ4QU1g2zTJM9zXLIP710B5SmlgQiSSWB+H/TA0yCpMShI2qixGOICmQmXN7+UAiyQ4Yzjb/3Ov
 74vu2vHTgA22bZI5yc0LzVfukKkrN3x1TV/Gq97tJenbxXmZQNR6n8I674zPbSJO1k1F/5zAfc0
 yMKZ0L3GIanGIUEd8CuD27Qp1uAxEwjkbis7rJgyJzpsEAP+BKQjl1oZpqcEf6Pu1TuRAULM/0/
 8XHd+82Z5Ml9XPfCLIQ==
X-Proofpoint-ORIG-GUID: 3-i9myEIUdNLOkixxB8aUptZBeSJh4TZ
X-Proofpoint-GUID: 3-i9myEIUdNLOkixxB8aUptZBeSJh4TZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDExMiBTYWx0ZWRfX6HELR9eLDLGu
 wbDm9yOR88A8xs0Sc79PQxoORbBqK0Nv2O5tryfsJkQ8oBPVHIqWjsz5a/6U64/lqUivGYWDfQI
 KwQq0DtXm/hSMNAJjMALzcuS8kb7fck=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75edc7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=zQHK5bSOx5GkbYARfgoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070112

Overview:
The Hardware Trace Macro (HTM) on POWER systems provides hardware-level
bus-trace data for a specific node/chip/core target within a logical
partition.  It is accessed via the H_HTM hypervisor call and traces
continuously at node, chip, or core scope independent of task scheduling.

This series adds a new "htm" PMU driver under arch/powerpc/perf/ that
exposes HTM trace collection via the standard perf interface using the
perf AUX buffer infrastructure, together with ABI and RST documentation.

Patch overview:
Patch 1 introduces the core HTM PMU driver (htm-perf.c).  The event
configuration encodes the trace target as a 28-bit value in
perf_event_attr.config:

  bits  0-3:  htm_type         (HTM_CORE=2, HTM_NEST=1, HTM_LLAT=3)
  bits  4-11: nodeindex
  bits 12-19: nodalchipindex
  bits 20-27: coreindexonchip

The PMU lifecycle maps to H_HTM_OP_CONFIGURE/DECONFIGURE at add/del time
and H_HTM_OP_START/STOP at start/stop time.  Context-switch callbacks
(PERF_EF_RELOAD / PERF_EF_UPDATE) are intentionally ignored because HTM
traces the hardware scope, not individual tasks.  Tracing state is kept
in event->pmu_private (HTM_TRACING_ACTIVE / HTM_TRACING_INACTIVE) as the
authoritative source, with event->hw.state kept in sync as a hint for the
perf core.

Patch 2 adds duplicate-reservation protection.  When 'perf record -a' is
used, perf opens system-wide events on all CPUs in parallel.  Without
driver-side tracking, concurrent opens for the same HTM target (node,
chip, core, type) can race and issue duplicate H_HTM_OP_CONFIGURE flows.
A global reserved-targets list is added; htm_event_init() rejects any
open that matches an already-reserved tuple, while different targets can
still be opened simultaneously on different CPUs.

Patch 3 adds AUX ring-buffer support so that high-volume trace data can
be streamed into a perf AUX buffer.  The driver opts into
PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE to request
physically contiguous allocations, which H_HTM_OP_DUMP_DATA requires.
A page-by-page physical-continuity scan is performed before each dump to
detect and bound any fragmentation gaps, preventing silent memory
corruption.  event->count is set to the number of 128-byte HTM trace
records written on a successful dump, 1 when the AUX buffer is
temporarily full but the hypervisor stream is intact, and 0 when the
stream is exhausted or a hard error occurs; the perf tool uses this as
a drain signal to decide whether another read pass is needed before
closing the event.

Patch 4 adds system memory configuration capture.  After writing trace
data to the AUX buffer, htm_event_read() calls H_HTM_OP_DUMP_SYSMEM_CONF
and emits the returned physical-to-logical address mapping records as
PERF_SAMPLE_RAW data.  Keeping trace data in the AUX stream and memory
configuration in raw samples allows each to be decoded independently in
userspace.

Patch 5 adds ABI documentation for the sysfs entries under
/sys/bus/event_source/devices/htm/, covering the format attribute
(config bit layout) and the events attribute group.

Patch 6 extends Documentation/arch/powerpc/htm.rst with a new section
on the perf interface: event syntax, required options, the two output
files (htm.bin.nX.pX.cX.tX and translation.nX.pX.cX.tX), and how to pass
them to htmdecode for trace decoding.

Usage example:
Collect HTM trace data from two simultaneous chip targets:

  # perf record -m,256                                          \
      -e htm/nodalchipindex=2,nodeindex=0,htm_type=1,cpu=8/    \
      -e htm/nodalchipindex=1,nodeindex=0,htm_type=1,cpu=9/    \
      -a -- sleep 10

  # perf report

Output files written by perf report:

  htm.bin.n0.p2.c0.t1       raw HTM bus-trace, chip 2
  htm.bin.n0.p1.c0.t1       raw HTM bus-trace, chip 1
  translation.n0.p2.c0.t1   memory config records, chip 2
  translation.n0.p1.c0.t1   memory config records, chip 1

The htm.bin.* files can then be decoded with htmdecoder to produce
trace output.

Testing:
Tested on POWER11 with two simultaneous HTM targets.  Both htm.bin.*
and translation.* files are produced correctly.

  # perf record -C 9 -m,256 \
      -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ -a sleep 3
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 256.277 MB perf.data ]


  # perf record -m,512 \
  -e htm/htm_type=3,nodalchipindex=1,nodeindex=0,coreindexonchip=6,cpu=8/ \
  -e htm/htm_nest,nodalchipindex=1,nodeindex=0,cpu=16/ -a sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 514.095 MB perf.data ]

Athira Rajeev (6):
  powerpc/perf: Add HTM PMU driver to expose Hardware Trace Macro data
  powerpc/perf: Reject duplicate HTM target reservations
  powerpc/perf: Add AUX buffer management to capture HTM trace data
  powerpc/perf: Capture the HTM memory configuration as part of perf
    data
  docs: ABI: sysfs-bus-event_source-devices-htm: Document sysfs event
    format entries for htm pmu
  powerpc/perf/htm: Add documentation for Hardware Trace Macro PMU

 .../sysfs-bus-event_source-devices-htm        |   36 +
 Documentation/arch/powerpc/htm.rst            |  158 ++-
 arch/powerpc/perf/Makefile                    |    2 +-
 arch/powerpc/perf/htm-perf.c                  | 1122 +++++++++++++++++
 4 files changed, 1314 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
 create mode 100644 arch/powerpc/perf/htm-perf.c

-- 
2.53.0



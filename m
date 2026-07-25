Return-Path: <linuxppc-dev+bounces-24820-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639A5C531C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 07:28:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6c0z1NxDz2ygG;
	Sat, 25 Jul 2026 17:28:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784964531;
	cv=none; b=nqMWaNbSbAxw6Lv/cxtOY65o0EXOhqNPzKY3+gEgfTL3Y0vzQO2OKh533NMTVPMKxmNdyokA9iCEViScU3TmplwCbipQUOSZKQe4TgJt2wAdBzwmYLUaj2i5CTvfztRULHupj9w0ZCuUFWE6HAeoWsYBC/IVpJCNcXOm+jnCMf4SmXiuZTBGatey/16O/w/176QfdmMiknGS1pW/3QUwEgJaUXvfzsNYO+0COUY8+OkNg+1xgiCy6jrSGQ75fIY2K6mXFOFOBXscCrdLDuaui4wcZUrW8DrdUyBGgUFkA2UggVVFnS8AzxcQN0D//hltYPwu++q5x9z2TbUPF8pd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784964531; c=relaxed/relaxed;
	bh=MEZ6TFTX5X33kUGMSTH0hjC2sWyiz9SsjtTTG5OOTZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OSF0J5rUAF++UhxO3Wfhc0ck/P2hvdxP0aq4Zu4D36BZ9GPZa1/e60U5s5/4zj7LKwL3s1ss3n7SQYXg0uY2BSRZuI21Q2P6+QPSsq0VFgwwWK/nVZTpE4Mq2W91A7a5BPjt/YX2b/ALw9aVlZU7jBzIf4Ydd4wFCZ0QSARCDqug4MBmx6A1U9XyRwAHQsysuWgRlMJA4TqDh2KBdboMnz2hwQm3tpKTQKpVFribVklss2/P6QG59f0EnTA8MG+XxPwGKIGrqhUjGG+479HIwmBTv8ImXmHqjoNV1hzlu3jptG6CxUg8LwmyLddXZD5NmlpOvjHrt98A6HTN7r+kBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D4+bdefG; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D4+bdefG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6c0t6NK1z2yYY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 17:28:46 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P5CDsm3980575;
	Sat, 25 Jul 2026 07:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MEZ6TFTX5X33kUGMSTH0hjC2sWyiz9SsjtTTG5OOT
	Zk=; b=D4+bdefGADtIEh2+BBGJ+dDbUs4nmZPXut2SU9EqlgV+N8g7LX1RG/aoO
	9odtroh4Vc/eiQmLiKmO9i0vaVDk8bwxT0POU7KiFThpcjqZ/vAb8nCtRKpgjaQ3
	oUaHFIDyzugGtFGpa5Ru2ciOBKhpF+g6v2oR4qYfEmeGyQWRVz0Kj8FAwE7oD+D8
	Hv7chHjkK/g1QO3WKTLLhYS+V0OsAZsRgEXyoDK6Orgosb4X4tuvCZ5i/yiI/Npw
	N6ZTRUQkhRmngscWCQtO0IrPiO1ncpWP3zt0yeEn0y5R3vkWuSXpFWCIfHcK3Qsy
	4OQXRcFkXZ94xfxULUBX1zsBIRg9g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmmst0kek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:28:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P7QFe5011365;
	Sat, 25 Jul 2026 07:28:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn330jee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:28:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P7SbGW48366012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 07:28:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9659420095;
	Sat, 25 Jul 2026 06:59:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ED7B2009B;
	Sat, 25 Jul 2026 06:59:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.222.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 06:59:55 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V3 0/6] powerpc/perf: Add HTM PMU driver and perf AUX support
Date: Sat, 25 Jul 2026 12:29:36 +0530
Message-Id: <20260725065942.78839-1-atrajeev@linux.ibm.com>
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=COgamxrD c=1 sm=1 tr=0 ts=6a6465ab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=zQHK5bSOx5GkbYARfgoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA2NiBTYWx0ZWRfX28/Vx655UFoC
 LOnMs9HozJr2qLgWdCHtlUmtnzzBBzHaKnqnz6cCVxvjrvFN3adwkt9uLGlmK+qsDD+5jgUvCUE
 qOHKLdTHlu5EVHb3tGS+V5pz2ok9MGo=
X-Proofpoint-ORIG-GUID: VKDusf4RcKY5A3hs486gIPDa13YGXxBl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA2NiBTYWx0ZWRfX1uYUvWWU5aLz
 u0wR3DWeaUpSVTIl01BxLoQVaThiHkEKrnZUzIxSaAFgO6+61PCooQp1yVGwp4W9A3sFHlGkJZE
 RlA8hhUKe41xKOMgbc0rbnpXn5NpI8wW8puQ66eohkDDDI5/HEcrSCOPhNPHboFTPBAhBI7KaX8
 nSHwBHmk8drX+ZVmu8yY1ZS5dqwHDp8NlyI7Dkm/0dIKGDv6i3BL7pFtVxuRSbPOxz2+UX/a3Ij
 qiRi/xsJkTGPKn+GEI3giznWzXA3eUm9e/4YZvCY3GF5xY600khzU5sHqqX/M8q3b+0+hharWsW
 W+oNtp0mA4ql4rqUmHKVIPWb8PpenJTozLgu1Gpy7VtuIIidVb81k4Kj/007YEupa7x5BHR1wy7
 4fCo9ZasoZPpWq8rYdcSN1m/EUaItxHAkIp6XDiszTfSNJ9WsZBuz2I1r9g17Xw2mWvmHsR5dhC
 5zfxM3O7H+XUxq1uqDg==
X-Proofpoint-GUID: VKDusf4RcKY5A3hs486gIPDa13YGXxBl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250066

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

  bits  0-3:  htm_type         (HTM_CORE=2, HTM_NEST=1)
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
files (htm.bin.nX.pX.cX and translation.nX.pX.cX), and how to pass
them to htmdecode for trace decoding.

Usage example:
Collect HTM trace data from two simultaneous chip targets:

  # perf record -m,256                                          \
      -e htm/nodalchipindex=2,nodeindex=0,htm_type=1,cpu=8/    \
      -e htm/nodalchipindex=1,nodeindex=0,htm_type=1,cpu=9/    \
      -a -- sleep 10

  # perf report

Output files written by perf report:

  htm.bin.n0.p2.c0       raw HTM bus-trace, chip 2
  htm.bin.n0.p1.c0       raw HTM bus-trace, chip 1
  translation.n0.p2.c0   memory config records, chip 2
  translation.n0.p1.c0   memory config records, chip 1

The htm.bin.* files can then be decoded with htmdecoder to produce
trace output.

Testing:
Tested on POWER10 with two simultaneous HTM targets.  Both htm.bin.*
and translation.* files are produced correctly.

  # perf record -C 9 -m,256 \
      -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ sleep 3
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 256.277 MB perf.data ]

Athira Rajeev (6):
  powerpc/perf: Add HTM PMU driver to expose Hardware Trace Macro data
  powerpc/perf: Reject duplicate HTM target reservations
  powerpc/perf: Add AUX buffer management to capture HTM trace data
  powerpc/perf: Capture the HTM memory configuration as part of perf
    data
  docs: ABI: sysfs-bus-event_source-devices-htm: Document sysfs event
    format entries for htm pmu
  powerpc/perf/htm: Add documentation for Hardware Trace Macro PMU

 .../sysfs-bus-event_source-devices-htm        |  34 +
 Documentation/arch/powerpc/htm.rst            | 158 ++-
 arch/powerpc/perf/Makefile                    |   2 +-
 arch/powerpc/perf/htm-perf.c                  | 907 ++++++++++++++++++
 4 files changed, 1097 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
 create mode 100644 arch/powerpc/perf/htm-perf.c

-- 
2.43.0



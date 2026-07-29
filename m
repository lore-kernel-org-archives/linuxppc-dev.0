Return-Path: <linuxppc-dev+bounces-24998-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5071C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 12:38:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9Bh74Wmkz2yDr;
	Wed, 29 Jul 2026 22:38:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785328695;
	cv=none; b=nuURLFaUoAAjAqjSu31li4VF6w0RznxbdRCcVIwFqPXVou8lCu1386hwUBP3Q1dOzCZR6k66CJfJCZ20T/jBmEzJw5Irt9J8SRFP6B8b8Senh6VLYJDq2Hj/US/BDYIcJeREROiAHIqjEhfVCp+KcETHOKO6MwbAbZ3uTseZGiLyfme3fnY17L2spY9yHvcMgAux1zyPSsKj5IJZtEjqpSiCVhoD9N4xYGGWbDt0WHd7keWgCbwx44fbffnA8wFk9JX4yXRGkzSb7xkRkrrkF4VT4DR9lGQZIFTX/lnAEkCsBE0Gn4/dKB/WTEgvRD0bX9vRBdBqmhSQ/myzsMOEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785328695; c=relaxed/relaxed;
	bh=C8XpmTNtyOnVshdL8wT+JgkWoGyWdDMu7s0faSV7tco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YBz4NqE66oLeJcI4XICq5/G0bXPLTSb0NKsCwQew6WYHtxbmAftpz2vOZkw1wBpkUZRPgi6auEH9CktvE3usOdxzRUw6EzPCJmzPRiHHnpZoMg54Gy3NNrOTONPx5J7ZVmUKuUoucHTAjsstaU4qDIewz/axZfSsfQfQfIwdz7dVNSxUNgpYLrhtuKKKcx3HoTTFq1/W1zyjxFaMzdcgQdTeMPoVinRxj3I7N2i5q9+vcTM+LyZ+G9o59J/hfXdL2suOGGdQnpsRE+3s+ZQbCsfghwxRy3PLBw6+JM6mOA2oTU5vRGm/XBaVc+Gu3MUFeVV3epLA85pdVN2HW4IbsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=InGnhc61; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=InGnhc61;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9Bh45gypz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 22:38:12 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHjAc4063626;
	Wed, 29 Jul 2026 12:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=C8XpmTNtyOnVshdL8wT+JgkWoGyW
	dDMu7s0faSV7tco=; b=InGnhc61TBU1UWra0Iq06xqQTkI2LxI+bkq3Bz3+kvWz
	jVTIeJ5ff5hJSGIGSwDiLIG68XW/Atkpz9Z9gLqjoOV4+ck99wPx3d9T+XKRYCsR
	qSRdQ/N48a2OQIUI5sVk5lLPiEKCeJ4F4pMWjHFwxJtDvMlOo6X+V/Q8I8OUwUL1
	t76yi+VP3LkI/yW+LmsY6ty8oKpR67OJ6UumVeoGEbTbvxMLythHomyoMDgR5a9C
	0S55+A/mB1TiFrnJauXNXywJMVEvkHBgN+TM/kSR3lhiiN7caX7Ap53zRU640SUL
	10DazVwQoVrA0yWFbwSxbqvdT2Cc/OT2u8gMpM3LKQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xtntj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:38:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCQHvZ031848;
	Wed, 29 Jul 2026 12:38:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk6pvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:38:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCc3VK27853094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:38:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED4DD20040;
	Wed, 29 Jul 2026 12:38:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB13920043;
	Wed, 29 Jul 2026 12:37:59 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 12:37:59 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V4 0/6] powerpc/perf: Add HTM PMU driver and perf AUX support
Date: Wed, 29 Jul 2026 18:07:46 +0530
Message-Id: <20260729123752.63010-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-GUID: 9klTidsbiwjcHKMgMVGV-jCIHblLKQmn
X-Proofpoint-ORIG-GUID: 9klTidsbiwjcHKMgMVGV-jCIHblLKQmn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX5Dv3xK+hpe7I
 PFjZer6bHwOlRe+BTXbvMLSl5w5G4y6kMH093qJq4LB8XjY/Ew5UYNTEWDfTVh3gF8Dhzc7Ezev
 /C9UillNQq5HGwprovTk4GUYVN+unmQ=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a69f432 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=zQHK5bSOx5GkbYARfgoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX8jeR1l5bF4Ht
 Uro+R/LbJSslLYcd31BLNslVYwsVOty5VPjbrVgZMVwirhFgWeBC40VTYPrwFGCJzoSSSTRUMVY
 Y5ol3zAsDervEl/JQn+r76rnDKKOq5R7V89FVF4fzurtkxG2r981VRlLu62THNY9MXRsl1nefyK
 2JE7F5hhgpYM6KoD9ZYf3kpY0Vs2ggnZJ0JylnhOw0FIpQC1shiRB1ope+xP2OXNPNZcRDfSmHm
 69LBBIfEBmORbYzTUS10vs4Evo4pG8nXmsEAs58IHFvQw/bjl9j3pLsDWFu6gimnBgTs5fyg10e
 bJApjpgOG0Vmed4VdzV037bUdtNGEiijvNls5MCInMVTKNHXSCOE4I92Fqg4qW1r53aXXV88mFm
 H5O6FcNFPVklwB9HIXewsNirk2LQ38XcQSWvgizq0QDU8fk2xqA+Kuk0YcxzHWerHxu5lImFNnJ
 mrHrHyR+gYNUrBU3f8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

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
 arch/powerpc/perf/htm-perf.c                  | 968 ++++++++++++++++++
 4 files changed, 1158 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
 create mode 100644 arch/powerpc/perf/htm-perf.c

-- 
2.43.0



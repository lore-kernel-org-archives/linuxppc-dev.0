Return-Path: <linuxppc-dev+bounces-24471-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4BCC44527
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 10:45:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3cc465Vvz2ySN;
	Mon, 20 Jul 2026 20:45:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784544324;
	cv=none; b=UUV3IjRmEgv6JSC4p7+HT4WD3xHdc/2lnrJHPxsv0QY5iF9SrIGCYMvh18fsHRHiqpp00JbWxfsPCflf4DfXmsFJIvWEa3nwg9hcIsZ2FSwTt6pFc980P2hnx+rpqF8qFGqJHQ5lxC60YkbaCAOxW1Mq1QgHxzekAT2P/kbHLaKuwV27rvdvN4lr691pD3mVYMkiOSEdf+vP0IGbr7l6GI/6Btedq4lwR7QgC7fEI4ep+D9sCzct+B+p1a1EY1qL2verFrXy+Ggin6xEgy+UnOgtPe/A8JtvANoH1JgA5U6guaLSWqNTCTyl7j4jjiKdHCGTrpu8YYRYlAw7/HlogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784544324; c=relaxed/relaxed;
	bh=Bh4Kd5Ffp0bqWK1ZYzCv1ryaS6Fo509xDQCP+xF22/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aF7tvmb8A9A37AIJya/hf9jimpl1K4ZcUqJ7l0+phq2X7Y3dkXtLem5ktcMS2tx+4ml49pZN0/PleyBOCBTUGVpPeAun+qhXEzgNwHvor1thWvko6MrRPsMa+17iSYncGUQxm0klvDJ71sV/iUr9Iy3l9mnM2DuOOO2/Nvo+4fyV5Y8pHkoNQZntFm9331ePg8JotFqk0hWD9u25LZ8uNNCNLTP3EDpS/2VXhNkwKTgdtYRUr8qy4nXXlINS2hLCNtrkC5E/k3DqIZtIRDB3d2IccVxheSqUXvEgtkfb3FsSeztcsmnBBmNOsWn2BpuUoyNIla8+vxbONym59kdLrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CsG/2ZYG; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CsG/2ZYG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3cc036TCz2xm3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 20:45:19 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KACBsb1826407;
	Mon, 20 Jul 2026 10:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Bh4Kd5Ffp0bqWK1ZYzCv1ryaS6Fo509xDQCP+xF22
	/o=; b=CsG/2ZYGX4oPHDs6Gl8oYYCdzuy/TGErhEjRd3xFK/PS7AczTGUwpYK9U
	Anr438CCEYjDz0TAdKTts5muoPDxZWetLOnBr92S2sezEFFrpm5eFcKX07FZmsDw
	lunx9tOWbYHT2YJK6GTHZtyZQKmqvMKUYWE4QxsSjGlmNAqG0U1XaLEQiegZXSvL
	tS8ilz9PToxlasuxZNEHCar3+3EATtRHj8TU1A1t6KqPZDeVmnWfvtSDkRNLxqax
	/38gmQAfTed3ZMjxabqVDkP4Fd/Ws2YXbLIc8CDCr7b3t69NvYUBP2G5ArrneKLL
	nGeomY8HvmDSU2dvZbaR1H1YNPVBA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77jxs9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAYk3n027039;
	Mon, 20 Jul 2026 10:45:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagw5f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 10:45:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KAjAAh49873158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 10:45:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A5342004D;
	Mon, 20 Jul 2026 10:45:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB85F2004B;
	Mon, 20 Jul 2026 10:45:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 10:45:07 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-perf-users@vger.kernel.org, atrajeev@linux.ibm.com,
        hbathini@linux.vnet.ibm.com, tejas05@linux.ibm.com,
        venkat88@linux.ibm.com, tshah@linux.ibm.com, usha.r2@ibm.com
Subject: [PATCH V2 0/6] powerpc/perf: Add HTM PMU driver and perf AUX support
Date: Mon, 20 Jul 2026 16:14:41 +0530
Message-Id: <20260720104447.11843-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5dfc3c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=zQHK5bSOx5GkbYARfgoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfX/p1kbeLQUbqj
 pDPK32G6yfAqRHJtbLwy+1YgagTxwjKU9Cbj8gtzs3I8e44axND2BDFHZzlNoWEO+3EtyEQR50U
 se4/Sfsbgc35EYraN8SfpmM5RVTH25uPZxkbr8hxcJV2rn77VBVGUR198TuOeWmqRVlHI2jwYO4
 NfdPrvJJlu8AzwC/t7Jjk7ZmBTuO8VR5rkZKv/6NXZ7c2mFDeosMqWjmCv6MQeac4QqzZ1kRhri
 gWf0mPUdYkGwVmsJSyWoks6yOXoSg63ATyLLIRki6FiOOm05fLO7W7jDb9KRCj+pypeaOcfUL+v
 NbLv7wCeoy66XS8pYQrS7uEukZevk8+kORXAAz7gihbQqE7FPRxbpcautKxGXQJFFM3jn/3/eBt
 y9Q8HW4aXO/IXwowRcvLQK2PBwGPKWPSiQkbZ+0rt5/S6qedtKTzymeX6n3JbPjXQta1+0mCNrk
 lJWLGPgPZz68RW0b5Og==
X-Proofpoint-ORIG-GUID: DfSyl-YqzXmvZ8r08FWGFUM295rR_9zi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfXy0Zcc5y8386v
 EypPLrto6O4VHuHMX4nxl2omS3Pd5u35dGU2U9ukEmARkt3odVmtr2delcZQpwKacJWcowjhseJ
 U7dnkrHpzbFY2c13GVrhTOij73qn0ho=
X-Proofpoint-GUID: DfSyl-YqzXmvZ8r08FWGFUM295rR_9zi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200119

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
corruption.  event->count is set to 1 when data is present and 0 when
the stream is exhausted; the perf tool uses this as a drain signal to
decide whether another read pass is needed before closing the event.

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

 .../sysfs-bus-event_source-devices-htm        |  21 +
 Documentation/arch/powerpc/htm.rst            | 137 +++-
 arch/powerpc/perf/Makefile                    |   2 +-
 arch/powerpc/perf/htm-perf.c                  | 749 ++++++++++++++++++
 4 files changed, 905 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-htm
 create mode 100644 arch/powerpc/perf/htm-perf.c

-- 
2.43.0



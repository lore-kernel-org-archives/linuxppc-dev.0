Return-Path: <linuxppc-dev+bounces-24811-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD22C531C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2026 07:08:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6bY95Ggqz2yYY;
	Sat, 25 Jul 2026 17:08:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784963293;
	cv=none; b=eRGLuMeCF1DCS7bkCHHrSezIP4Vh9+OfoDuSN2YMzULHGEvR0aKwkDvrmopnoyOzqVopXIQHHtvf7xLF/bHLDT3pDGUWr/9nJH7umWwxXQQLlY2qIBLee3C/fXdciHrPfF9iDDU7gactHEadK2BQP/oIWiZ+c5aLfk3MATjbHW1llsJMEkcGsyJFBaxlS2j4/6Hk3vnOpPpSLMDskoycK2sY7+lk6I9lYkKLPrB23qD5ilrHkESiHq5PuyqrjcobiF4WaJfmH3EME0JTPwDjGd6Nq/X5eMcTg2TKXsZfawI5rIBXvMIpyz9l3Xyo9V7AdQplD3irzVIpEpZFwp5xCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784963293; c=relaxed/relaxed;
	bh=06iF2XW7NM7IOGFvRLvPzULXDKEXorZtKiQy3/FxJtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bz3EnuxqgGiBe6M0/M8TxXps3hutBVf9VrjeticLbJWjSaoByS5Ow9ZCdb3ui2JW+6n/pYutryvATz5EbutgNcc1jcoQ+Vcsrfp/BbLxn+UpoetZ5OLBuZ+m0dRDdTcvKwrdpc0oNOjjI8mGLH1jbmVHaH9s9FHT+yyCK3YiFXZv01IsiJi/DANCZKAaQkYEFxVOBHi1OGl8BEUOIFbS0aF6cGesjY9Uj7pfyVOWWjqX3EWu8YRNvGnshpV6I8XOvJMZz8m1yTqsjJmjLALss1GxHX7ZIoWbHgnKDahZrmnqGeviJLDeQKkxd9XFCulr8e6bflW1nvgNVvvQgWXXGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HTu7D0cf; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HTu7D0cf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6bY83h28z2ySJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 17:08:12 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66P5DPIA3852303;
	Sat, 25 Jul 2026 07:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=06iF2XW7NM7IOGFvRLvPzULXDKEXorZtKiQy3/FxJ
	tU=; b=HTu7D0cf/mO4TRz8Zz/J0+ja4t8O0LDT/z5dv6tLUnPz2WpfAYaxTjHK8
	Z46dEtYX7OB+V5IK5MX5PFt88bGrJpPzHViArIAjaLPR30lAFXPBuTdieqiu/Kfs
	giJYAT2Jh7Ak80PKelybR5ULrWAI4FNQI9qyfr6XKCUOv5U+fgW+RZ9aoUU0Qn3n
	RKR/fk9PrFCIdiFTOeww66FUdKMqc+LHSCTW7tQ4V7ld+mvTaKfA8slzPAA3nwUP
	rkfyXgK9dyBvX9pwyiI2Du+b8pWKl1WGSsEvOEtDvUNRudVD5S/hSNGi9L18gEYz
	otsntDsVF8gKTmMP5X2qvXf/9JReA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmkje8qpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:08:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66P6uNdF018205;
	Sat, 25 Jul 2026 07:08:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fmn12ghgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 07:08:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66P780vl52953380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 07:08:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7152420168;
	Sat, 25 Jul 2026 07:08:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B9C520169;
	Sat, 25 Jul 2026 07:07:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.222.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 07:07:56 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V3 0/6] tools/perf: Add powerpc HTM auxtrace support
Date: Sat, 25 Jul 2026 12:37:41 +0530
Message-Id: <20260725070747.81435-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=YvY/gYYX c=1 sm=1 tr=0 ts=6a6460d5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Lql3lfElDkBJbt6mtbwA:9
X-Proofpoint-GUID: ao8pUc_nXAWz6nk0jdeT2vr27DUaW33c
X-Proofpoint-ORIG-GUID: zlJmbyQUIhYpDW7txe3Am4oP0bO_QAMw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDA2MSBTYWx0ZWRfX+2Gzv/vmvWiV
 Z26ecFjqy5iqVC3Dn6tGI1Mo7Xck1XW197OwHY9f4UClUp5AC9s6OrsZLSWJyGk2DhMvWspsWdv
 8qj9kS4imQ9oSjOTFYJZr0YFfc33FI2n2AXBXgOU9dO+9kRVVZAOFT84Td6Nt+fgOaxZlX6lVLn
 L93IQ2dcUiHidZFdskret9M0B0sTk6+8e0jTotM/xTqkVt1DqfDMVMpbObcx0YUf8hEdvsN8wWU
 Mp2ZUWRe38Xx+fx6ya/M+WOAdB4GkSXTIkytZe3IBisWgfkTTjcA164Tcchl/zcGncGSN/DasBz
 hFluiHvKOnIGu3HCy/LAtipEPlFSfouR4EsTO2n4t47scWFoJ5gLRuACK0jlIWWrETMcdMYUiWj
 XBEs4R6qBnrvy2ox7q1pFUmrzOpPyZoCHzT8mIrvCx1cFfV2AcArrmWGrdWbf/PRwX1cJ6fSxwK
 2qyPOF66kf+Q+wPHd4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDA2MSBTYWx0ZWRfX97Eu043KJcGU
 3nnoiPmgfsFgJGY45wzAyMzty65SqDQ8Fy09jKFpDKP5mzTxukjT03QOvC6FG7MlTf5tPRbjCrm
 Ev+C7MU5VmE6QnNsqsX4STqiUXIJVzQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250061

Overview:
This series adds perf tool support for capturing and processing Hardware
Trace Macro (HTM) trace data on POWER systems.  HTM exposes raw bus-trace
data via the H_HTM hypervisor call.  The kernel-side HTM PMU driver
(submitted separately) streams this data into perf AUX buffers and emits
memory configuration as PERF_SAMPLE_RAW records.

This series wires up the record and report sides in the perf tool so that
'perf record' collects HTM data and 'perf report' writes the trace and
memory configuration to files ready for post-processing with htmdecode.

Patch overview:
Patch 1 refactors the existing powerpc auxtrace dispatch.  All VPA-DTL
recording logic is moved from arch/powerpc/util/auxtrace.c into its own
file, arch/powerpc/util/vpa-dtl.c, leaving auxtrace_record__init() as a
thin per-PMU dispatcher.  This is a prerequisite for adding the HTM
recording path cleanly.

Patch 2 adds the HTM recording path (arch/powerpc/util/htm.c and
util/powerpc-htm.h).  htm_recording_init() sets up the auxtrace_record
callbacks.  htm_info_fill() stores the PMU type and a (cpu, attr.config)
pair for each htm evsel into the PERF_RECORD_AUXTRACE_INFO priv[] area.
The decode side reads these back to map each AUX buffer to its
(node, chip, core) target using event->auxtrace.cpu.  PERF_SAMPLE_RAW is
also enabled here so that memory configuration records are captured
alongside the AUX stream.

Patch 3 adds a generic weak arch_perf_record__need_read() hook in
builtin-record.c.  When the hook returns non-zero, perf record performs
an extra mmap-read pass before disabling events.  The drain loop runs
until the hook returns 0 or no forward progress is made, then the events
are disabled and closed normally.

Patch 4 implements arch_perf_record__need_read() for powerpc.  It reads
event->count for all open htm evsels via perf_evsel__read() and
accumulates the values.  The kernel driver sets this count to the number
of 128-byte HTM trace records written on a successful dump, 1 when the
AUX buffer is temporarily full but the hypervisor stream is intact, and
0 once the stream is exhausted or a hard error occurs.  A non-zero total
causes the recording loop to perform another read pass.

Patch 5 adds PERF_AUXTRACE_POWERPC_HTM to the auxtrace_type enum and
wires the dispatch in perf_event__process_auxtrace_info().  It also
amends htm_info_fill() to set auxtrace_info->type now that the constant
is available.

Patch 6 adds the full HTM decode path in util/powerpc-htm.c.
powerpc_htm_process_auxtrace_info() reads the (cpu, config) pairs from
priv[] and builds a cpu_configs[] lookup table.  As each
PERF_RECORD_AUXTRACE event arrives, process_auxtrace_event() maps it to
the correct target and writes the data to htm.bin.nX.pX.cX immediately.
PERF_RECORD_SAMPLE RAW records are written to translation.nX.pX.cX by
process_event().  Per-run first-write tracking (htm_target_seen) ensures
O_TRUNC on the first write and O_APPEND on subsequent writes.

Patches not included in V2:
Three patches present in V1 are intentionally dropped from this series
and will be submitted as a follow-on once the core infrastructure gets
integrated:

  - htmdecode integration: V1 patch 6 invoked the external htmdecode
    tool via fork/exec after writing htm.bin.* to decode the raw
    bus-trace data in-process.  This is deferred because the interface
    between perf and an external decode tool needs more discussion.

  - Physical-to-logical address mapping: V1 patch 7 read the current
    partition ID from /proc/powerpc/lparcfg, parsed the translation.*
    memory map entries, and mapped physical addresses in the decoded
    trace to logical addresses within the LPAR.

  - Synthetic sample generation: V1 patches 8 and 9 created a
    PERF_TYPE_SYNTH event named "htm", injected synthetic perf samples
    with the translated logical addresses as sample IP, and wrote a
    separate .out.l file with logical addresses alongside the decoded
    trace.  The appropriate abstraction for synthetic HTM samples in the
    perf tool requires further discussion.

Usage example:
Collect HTM trace data from a single chip target:

  # perf record -C 9 -m,256 \
      -e htm/nodalchipindex=2,nodeindex=0,htm_type=1/ sleep 3
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 256.277 MB perf.data ]

  # perf report

Output files written by perf report:

  htm.bin.n0.p2.c0       raw HTM bus-trace data
  translation.n0.p2.c0   memory configuration records

Multiple targets can be collected simultaneously:

  # perf record -m,256 \
      -e htm/nodalchipindex=2,nodeindex=0,htm_type=1,cpu=8/ \
      -e htm/nodalchipindex=1,nodeindex=0,htm_type=1,cpu=9/ \
      -a sleep 10

Testing:
Tested on POWER10.  Both htm.bin.* and translation.* files are produced
correctly for single and dual target collection.

Note: Link to kernel patches:
https://lore.kernel.org/linuxppc-dev/20260725065942.78839-2-atrajeev@linux.ibm.com/T/#t

Athira Rajeev (6):
  tools/perf: Move powerpc VPA-DTL auxtrace init into a separate file
  tools/perf: Add AUXTRACE recording support for powerpc HTM
  tools/perf: Add arch hook to drain remaining data before event close
  tools/perf: Add powerpc callback support for
    arch_perf_record__need_read
  tools/perf: Add powerpc HTM auxtrace event processing support
  tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE
    records

 tools/perf/arch/powerpc/util/Build      |   2 +
 tools/perf/arch/powerpc/util/auxtrace.c |  93 +----
 tools/perf/arch/powerpc/util/evsel.c    |  55 +++
 tools/perf/arch/powerpc/util/htm.c      | 170 +++++++++
 tools/perf/arch/powerpc/util/vpa-dtl.c  |  96 ++++++
 tools/perf/builtin-record.c             |  68 ++++
 tools/perf/util/Build                   |   1 +
 tools/perf/util/auxtrace.c              |   4 +
 tools/perf/util/auxtrace.h              |   1 +
 tools/perf/util/powerpc-htm.c           | 441 ++++++++++++++++++++++++
 tools/perf/util/powerpc-htm.h           |  43 +++
 tools/perf/util/powerpc-vpadtl.h        |   1 +
 tools/perf/util/record.h                |   3 +
 13 files changed, 902 insertions(+), 76 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/htm.c
 create mode 100644 tools/perf/arch/powerpc/util/vpa-dtl.c
 create mode 100644 tools/perf/util/powerpc-htm.c
 create mode 100644 tools/perf/util/powerpc-htm.h

-- 
2.43.0



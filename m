Return-Path: <linuxppc-dev+bounces-25006-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44476C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 12:44:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9Bq36zBrz2ygW;
	Wed, 29 Jul 2026 22:44:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785329055;
	cv=none; b=RyOjyFqz9L2AmCWdFAFN1dLAs2q4eLPPP74xNxHlAFDDAqsPU6zR8N2b8cGXFH66Cp9G+ARaPBTVGhOJ1rwS9L6BFuvENnN3NDDlxLRYVG3n5YocHPHmtNIHYKXJRGe6GqXc4GbmCIgfzDtlExx47Nv7w2bHx27rQSoUSN8Wy5TyD1hcVPmprtmPDdHcyNoTqXk6ocvXCyeMuEiZ0YoNgY09bHCwQ6v5qTPKSBXJZVC57/NRwAGCvvf8CTL8V34vUvao8yraxJaY1f2IuyOr+QHfkQSsh4sqEuiSQkHpP5DyypgPCXembOkbO9hrzHAD0oUYBVYEvW/BuSgzS587SA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785329055; c=relaxed/relaxed;
	bh=fbma4ZbOOkHDIcKJVfgSOSzbPRHhl5pdJLufN+Mt4Ac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jFmRaIRPJfPwDnEifNvwmv4kwh2Aj0TLPtVoQk95GQe2CW5ebC+xDhd6m+xfz00WlCoeqoFzeQ5fPXz+8T0fEK9+/2L/BCU3+D67KbdPXByS1FnRrKyR397UI4HKueN669Azpp+wYUhrOJFnwH/AsLDRn0PeIcGrWfzIoVlpYCqG0oFOA5RTkF9kIBwbSo8/xSh+QfUqhgD8qoiEB5Fmx7dHc0W+e2e3oCfqPPCmkBwNdhekLz8kpYCgO0BFMqrnIsGHrMKvN6NENjZ1bBsVrBxAASFHtXCXitkmoWmS3wwb9LsU9Xu0kevxMyIDW5ql/5UG+2vL4gI+2+chdzVKCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EXGrozop; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EXGrozop;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9Bq30L0Wz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 22:44:14 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TBHdAR2163972;
	Wed, 29 Jul 2026 12:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fbma4ZbOOkHDIcKJVfgSOSzbPRHhl5pdJLufN+Mt4
	Ac=; b=EXGrozop4bm5wavbBsQ6DctYdrl6W8kN//7sVXHrxEFV9DXSDYBWj3LeP
	ULq0DB+i5tC4umq79yYNuO7lxsnbdIy0PHy3REFH/hfQgux5Ruer2jU04p0OE60z
	BZPyHsHm18323TQwuv9PMbpFVCOFSmM7kj6M4AjEZsFMztf4y67JObeqR4nMuHy/
	0UogKY4MKMxlZcVwUb8Qh9L9WSUN9cs6DJY+Bnt6DTHviyqe5cGtZGD7lgenWqw5
	HCfyqtrDayQ8HuTSfUNaBHHkIzdr6DCD47RR5boxKrl166hd05IVimRDp3Prtdpj
	wu6j8xoKXisl6BbcU1pBgP6STLX0A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycjm9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:44:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TCfFD7029917;
	Wed, 29 Jul 2026 12:44:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y6e76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 12:44:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TCi5tE28312044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 12:44:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 735F420040;
	Wed, 29 Jul 2026 12:44:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BFB820043;
	Wed, 29 Jul 2026 12:44:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.136])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 12:44:01 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V4 0/6] tools/perf: Add powerpc HTM auxtrace support
Date: Wed, 29 Jul 2026 18:13:54 +0530
Message-Id: <20260729124400.65009-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: gjpu4VuNDMMFoCJlb-xD_aAuJd466ILn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX6hD9XmPe3T5r
 4ICg/RHq0cq4U8J/+8TFchaRE/TuSpRbPf5DzAIUonCjVBvIra5HlOQXQhXBEvQq+LUwNUjJgC6
 Oy6EUqGonQG/Bni3g2VHmBcvKjp96KZgPjrOC/s+v+G/b3EI2fWURjq4zRgFUkQ0pPKGMjMzO6t
 ODDlJK94iJy7v9hJQrHaJvibcjhL5ucsMUNYfYSAXv+3WDswOdzU5YV6COYID4w+RRAXB7KydIh
 PqReQjM3Or7bmAeX/V65nybzn3PMQRkkzt0Bh4pctgou2AFfzpd0z05kGe2qLEOXmEMlf2X+v06
 GjXlROYuKMS94Ypzo3UxWlJqnPa2APDDcly83U3oORhS/j3aeahlCZzmnkWO1kgs/qArlPaU6W0
 1FPUkoHOkutKBVuLhzh2IsKB6CYB2iaC03FUZ+bI2izEY+UgJshYDbt72S3JTyd8cwiYOj1WXtS
 TeGBheV12OeyW/rBp1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX+vTCRHCYpOWa
 hwEhtkhpWA9sDwkwN9p/yj0JIad6tuMQ93rkzUmdVA2ebkQ7k3SYm9iMphoQGIJ7hDCHhPstgok
 oJeVlxZlmYyOiWnJ1xtfuKEJTnLvRzw=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a69f59a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Lql3lfElDkBJbt6mtbwA:9
X-Proofpoint-GUID: _CNZh1BRC7Tpyc9Y5bBn9X8HBiw-aJTA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

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
https://lore.kernel.org/linuxppc-dev/20260729123752.63010-1-atrajeev@linux.ibm.com/T/#t

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
 tools/perf/arch/powerpc/util/auxtrace.c |  97 ++----
 tools/perf/arch/powerpc/util/evsel.c    |  55 +++
 tools/perf/arch/powerpc/util/htm.c      | 171 +++++++++
 tools/perf/arch/powerpc/util/vpa-dtl.c  |  96 +++++
 tools/perf/builtin-record.c             |  77 ++++
 tools/perf/util/Build                   |   1 +
 tools/perf/util/auxtrace.c              |   4 +
 tools/perf/util/auxtrace.h              |   1 +
 tools/perf/util/powerpc-htm.c           | 446 ++++++++++++++++++++++++
 tools/perf/util/powerpc-htm.h           |  43 +++
 tools/perf/util/powerpc-vpadtl.h        |   1 +
 tools/perf/util/record.h                |   3 +
 13 files changed, 925 insertions(+), 72 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/htm.c
 create mode 100644 tools/perf/arch/powerpc/util/vpa-dtl.c
 create mode 100644 tools/perf/util/powerpc-htm.c
 create mode 100644 tools/perf/util/powerpc-htm.h

-- 
2.43.0



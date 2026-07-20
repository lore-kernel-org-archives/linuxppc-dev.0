Return-Path: <linuxppc-dev+bounces-24479-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10515C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 11:04:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3d1s5QSKz303B;
	Mon, 20 Jul 2026 21:04:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784545457;
	cv=none; b=NDanscOXbHc0eaJloBxDJ68DOYbyIqKnPp4hoKc2gZCImpTKbL8huHGJI0QCboRPitRfy9QAwHo6W+ukFeYxTYteoUgzng6gcWDS0J3NLdbbFA5+2PqOkFzfZxl3ED7cegDQDY067tZJn37GxNMICHkfwhZOhd6B/tlTX8yug0p1FnzqEXuIT2YQV73VYFDQxyhAWGA7HqfjJtzlpIGN8EgXPkTnU1r0SpIdsc7XVl9EUDOQQieRqnjJyqqxLlyfhVzlz3o0z5jtLgoRIgXXmJ10qe3iOvhkf2/i23wu97WmRZ8kPKI/dxW1nFlRlh5ka7GnwgfC0TwpMtb3uFsOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784545457; c=relaxed/relaxed;
	bh=DlGX67Kh1j9/71U/OVOcdyBnPuJRuYUIJbq1UIoyffE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jgEmaC8SDSJIuR5mEv9ApbvOtd3tWtf5Qzb72UF9kQdkHT1qR5SWAiegHK3XLEgNfCJzCc67nirgu1KOwvO7ZKIqcuWjsrNiH29/vN7gu8uxEqq7yUKnET0jiPywMaPOdzXlsoFrzZDw6WZT9rLqny5HKpPqsum57YLXf6RTaIh2OztiZcWZPW2IdbGGB1KDpfh/jmrsyO+xlCgAPRiymQi2ZprZ7BaEhavzPYCjqhwuczrjBUtKRm2Ey2g2Uhlp8HzVWXVSk5zrzyWEvfFARb+YtfazGHboda1z3FU28Fta/wrqxbj/hg2n2YNjw+TTrtdFlq12+ud0mz+uTP6q2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SB5lSv68; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SB5lSv68;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3d1n3yYZz2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 21:04:12 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KACBtf1826407;
	Mon, 20 Jul 2026 11:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DlGX67Kh1j9/71U/OVOcdyBnPuJRuYUIJbq1UIoyf
	fE=; b=SB5lSv68negbOxuK2yL0XGjZUWGdGRA1MbY0eLLlh7NUK+O3IEfSUhRiY
	slu4vaclJblnmCGujSdCwKT1IViVn/evQvYb+X0qfeAvsejY8UtLKUqKuGlIqSnJ
	oBNJc97yr92Ow2ky7uIjV15modFDKDv0NtqQKgkrauX67uuCMd/nh/etBdQlkWpo
	3nZ7sOsBurGeFiIXJBDjjgBm+AmgppKevIVWEyL3t31jCrl0oAsMlTiy+H5o6m/5
	BOtIqgOC1e/YwcJCsecFQrAlgggwVhsg948HvAc6gf6BKTo5XuqWUJCc/8g+TT+Q
	o1P5NHhEr/CzLNuE//XOTHKq6EHnQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77jxub1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KAndEg028090;
	Mon, 20 Jul 2026 11:04:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g52yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 11:04:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KB40IS50659626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 11:04:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B409820043;
	Mon, 20 Jul 2026 11:04:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 690702004B;
	Mon, 20 Jul 2026 11:03:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.16.54])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 11:03:57 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com,
        usha.r2@ibm.com
Subject: [PATCH V2 0/6] tools/perf: Add powerpc HTM auxtrace support
Date: Mon, 20 Jul 2026 16:22:12 +0530
Message-Id: <20260720105218.14277-1-atrajeev@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5e00a5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=RE6roZah17OqO2nNXcEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfXzHRzjUTPXD0M
 xCi9EeXxw7GtXZw37B5T02b5e1OQahsOnzmtnXizwf0kcTZ2Y5X6LSuNuP5jzx1wAurnFizyhH5
 e7EFXyriA5BnjJikI1lMDIF/gwbFKBEZl1to5MTlSwvxOKrwRaLNDfwtaiEA/sw3uue8ovAy0Pc
 wJKMMoHaTh89w9lLVACr8K9Cw0qmQkmN3UEW5spI9gCV+U6xGQVBqWh7OraolL8Cx1JhznUNU3s
 hWO9MZNG/y3ObfRoci7d6PzJLSvaOxPgZ6lBYu+TXf0EsWgrxvMU33kQztRThZpIrKaiDVeTBdn
 LsmT9x5+4jyRAX/VT0HORlaK+mfQyQ/4jH0WeJuQLtvl9TniLgpvKhxoxlaZcu8bObyGWC2SM1W
 FijjZKccEdTmougpaYFkyJPBcE9n7RQ9HZYbm92F00QJ912D1GXIfh7uYYdJ5C/N0i/bF80+vNE
 SnXa7UNuwESIwQaSRbA==
X-Proofpoint-ORIG-GUID: sfy3SHClcfUcXO05WPEjZHYV-6OiRirw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDExOSBTYWx0ZWRfXwmv+DE0kuqgu
 ny4Ins55SlLY19FBcHp1sNgygCgkj1B/Va2OEKB0f0C4IikHxeVgcAH1/VPCkYac/UY7ox4Vs0b
 RYqtKulUJY5baGEdqOiGNzPIIxrhPik=
X-Proofpoint-GUID: _CpkRGZkExqeMNw-hy4wV8FAE7sQZnmk
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
This series adds perf tool support for capturing and processing Hardware
Trace Macro (HTM) trace data on POWER systems.  HTM exposes raw bus-trace
data via the H_HTM hypervisor call.  The kernel-side HTM PMU driver
(submitted separately) streams this data into perf AUX buffers and emits
memory configuration as PERF_SAMPLE_RAW records.

This series wires up the record and report sides in the perf tool so that
'perf record' collects HTM data and 'perf report' writes the trace and
memory configuration to files ready for post-processing with htmdecoder.

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
accumulates the values.  The kernel driver sets this count to 1 while
data is staged in its internal buffers and to 0 once the stream is
exhausted.  A non-zero total causes the recording loop to perform another
read pass.

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
    partition ID and parsed the translation.*

  - Synthetic sample generation: V1 patches 8 and 9 created a
    PERF_TYPE_SYNTH event named "htm", injected synthetic perf samples

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
https://lore.kernel.org/linuxppc-dev/20260720104447.11843-1-atrajeev@linux.ibm.com/T/#t

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
 tools/perf/arch/powerpc/util/auxtrace.c |  93 +-----
 tools/perf/arch/powerpc/util/evsel.c    |  69 ++++
 tools/perf/arch/powerpc/util/htm.c      | 169 ++++++++++
 tools/perf/arch/powerpc/util/vpa-dtl.c  |  95 ++++++
 tools/perf/builtin-record.c             |  45 +++
 tools/perf/util/Build                   |   1 +
 tools/perf/util/auxtrace.c              |   4 +
 tools/perf/util/auxtrace.h              |   1 +
 tools/perf/util/powerpc-htm.c           | 415 ++++++++++++++++++++++++
 tools/perf/util/powerpc-htm.h           |  43 +++
 tools/perf/util/powerpc-vpadtl.h        |   1 +
 tools/perf/util/record.h                |   3 +
 13 files changed, 865 insertions(+), 76 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/htm.c
 create mode 100644 tools/perf/arch/powerpc/util/vpa-dtl.c
 create mode 100644 tools/perf/util/powerpc-htm.c
 create mode 100644 tools/perf/util/powerpc-htm.h

-- 
2.43.0



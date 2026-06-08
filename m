Return-Path: <linuxppc-dev+bounces-22191-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E29CD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 13:00:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYsbh5ZL1z2ytV;
	Mon, 08 Jun 2026 23:00:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780923648;
	cv=none; b=Ld9rV2F4MnwF+cmKk8EfiU7PCVMvCHe9deHdcOKYPKgi7tJabCnNivzM4kXaMCNx3/FZtELUlSBLkFfECz8Nn9T6W9N9JHnoz31eNKAQnR82GqrGPDKOzdM6RBAekFJu+wNDvX5hlsX1UBEmRq/yGd31i656Hm+3x4CX07cDzmFtCOVZdpZmPu6yxsUOgOadiS4vYzialkPFfqsL9Q7+saUHVWQrEtacVAvaocdqRfLLm7LOPI8LGi9kQwP9+Wgv6o/H5ggESbAWRRh+3kWi67A3p4ZBMQ41e6/ReYMXIQ6Oic5+hK4WiLZyGR32ylZAvPW7NUBvOFBkJsDnGQ2Qjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780923648; c=relaxed/relaxed;
	bh=QyPsNonAALRjhEBZiBDa/4GSiJ+bpAAy2gRhnusk4fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzEoD7V+htdzmDPlxy79tm6CEkzsX0AAuWrU3nN8MuUbjHBL45O9rGCozFf+WkaNsRFKrLeyYUunk4EkQri880mZpYIwN6QW7dhA8XBv3Awssc0nDj+20FD/lSE/v7LFteiiD2oXSYfUpEeWOqVFo0PLa5jh+gsTy5/Y12jEhkkaWM9r+4gI6MJuBZf5ix6wNY5pTAyZDwxG1M4F3cl1COx2/Fgwr9NNVBF+4OJusHXiec2k8UqMDj7dlGfkFzLvYFQmFOeug1hGyXDioa8lYXfUgZ/4jVLxZi+e8R/JCCqvo5bONF7qWkdEBoxC0NoY6mDH+DQPHHt/FJHI6spI/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KivI6YnQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KivI6YnQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYsbg3Mzcz2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 23:00:47 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6588xMlD3159944;
	Mon, 8 Jun 2026 13:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QyPsNonAALRjhEBZiBDa/4GSiJ+bpAAy2gRhnusk4
	fg=; b=KivI6YnQCtmeh0ItQXk8UqGenkTQQex8/+wXzsccUHpAIiOF/mkgloCFY
	i9yVl9+Eusv9bN91xz2RPFC/GpGaiZNwyeOce0b1SZerF/TYobCpDVKOHMtvgUEV
	pBMo+vwSXxCL2fe9+dRHTAVtCxYgrfhaz8vfon/wlhyPtbNcSLjltZHLSLU8Kdbm
	AGyzVKxjLkXj40j8+ikhz+Lx/y6dqvg7b768ab/5uGFX1kCYO458O6vBNeRA7awj
	JYxakf+3IDZtDqqXnDrK49s/BPfVEBKbEeZn1HLhTgpFhj3X33UixPQ+QxSSQ8Hk
	STwMjFIhEb9g5VysaKraDuUI7eFtw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ydybpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 13:00:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658CnkHc004231;
	Mon, 8 Jun 2026 13:00:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8vwfjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 13:00:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658D0aPl51380584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 13:00:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6177D20040;
	Mon,  8 Jun 2026 13:00:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 047332004D;
	Mon,  8 Jun 2026 13:00:31 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.124.212.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 13:00:30 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH 0/4] perf: Add perf.data tracepoint events to trace.dat conversion
Date: Mon,  8 Jun 2026 18:29:48 +0530
Message-ID: <20260608125951.90425-2-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExOSBTYWx0ZWRfX9laoSyMNRZmt
 aJhx+D8WFESH2ix86SlnM8E9t10lrafIko2aaIj7W0Y93Jo9I5cprxAI78c983mg71UVTa0L9Ow
 m4N6s1fejiP26QJD0iRxcAuEkCMF5xDH/4IvtNO+YTan2I67sD+8kgLJeVJ0ZVIaP+WF9Bo9aaZ
 gO8xwClXiS8vEWj8NW0n6+Ezuwcdhbp3saUi41QLWNSMA069n0hZ3Nxc1rpESfGdjmcqCYqklMC
 RkDPoFM6D+U1d3tv34d6PQuZm5LrikOGqWZ85qdeC1SZHOKdrlLBKhRppYJ+2uDGIF6VWxJ0BhY
 ipW5KYghU0I+qZOlZGI5/QonZkNnzTJnqJ3XtW5dchMm4rRrBnAr0I1Wn+Acf5eaxERzzK3nMgU
 iHIlqohcCjYGBOUcOlR22BX7U8tc+eM5S96nZoS6N+7HVTqOXs0YmaH0PM5EisyKEmtBujaErgk
 TErjMNsfbVz7aMg7l8g==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a26bcf9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=uhnewQdbmIg8kqqWvIkA:9
X-Proofpoint-GUID: XUOk1uY2T6LncLMlavxA1WpnM3500Bcf
X-Proofpoint-ORIG-GUID: pqzb-BaCsNOXoh0PX-niHQuUjs__VoeQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080119

This RFC patch series introduces support for converting perf.data files
containing tracepoint events into trace.dat format, enabling seamless
visualization and analysis using KerneShark.

======================
Background and Motivation
======================

Currently, perf and trace-cmd operate as separate tracing ecosystems with
incompatible data formats. Users who collect tracepoint data with
'perf record' cannot easily visualize it in KernelShark's graphical
timeline view or leverage trace-cmd's analysis capabilities.

This creates workflow friction when users need to:

- Visualize perf tracepoint data in KernelShark's interactive graphical
  timeline
- Share trace data between perf and trace-cmd workflows and toolchains
- Perform architecture-independent conversion and analysis of traces

This conversion bridge eliminates these barriers by enabling seamless
data exchange between perf and trace-cmd ecosystems, allowing users to
choose the best tool for each analysis phase.

======================
Implementation Overview
======================

The series implements the trace.dat file format specification (version 7)
within perf's data conversion framework.

**Patch 1/4: Core trace.dat Export Infrastructure**
Introduces util/trace-dat.c and util/trace-dat.h implementing:
- Per-CPU raw event buffer management (init, collect, free)
- Ftrace ring buffer page construction
- trace.dat section writers (strings, options, flyrecord sections)

**Patch 2/4: Metadata Integration**
Extends util/trace-event-read.c to write trace.dat metadata during
perf.data
parsing:
- Initial format header (magic, version, endian, page size, compression)
- Section 16: HEADER INFO (header_page + header_event)
- Section 17: FTRACE EVENT FORMATS
- Section 18: EVENT FORMATS (per system/event format files)
- Section 19: KALLSYMS
- Section 21: CMDLINES
- Section 15: STRINGS (written last after all sections)

**Patch 3/4: Conversion Backend**
Implements util/data-convert-trace.c with trace_convert__perf2dat()
function:
- Processes PERF_TYPE_TRACEPOINT samples via process_sample_event()
- Collects raw event data per-CPU using trace_dat__collect_cpu_event()
- Writes OPTIONS sections (CPUCOUNT, TRACECLOCK, metadata offsets)
- Writes FLYRECORD section with per-CPU ring buffer pages

**Patch 4/4: User Interface**
Extends tools/perf/builtin-data.c with --to-trace-dat option:
- Adds command-line option for trace.dat output
- Mutually exclusive with --to-ctf and --to-json
- Calls trace_convert__perf2dat() to perform conversion

======================
Current Implementation Details
======================

**trace.dat Format Version:**
The implementation currently targets trace.dat format version 7, which
is the stable version supported by current trace-cmd releases (v3.x).
This version is hardcoded to ensure compatibility with existing
trace-cmd and KernelShark installations. Future enhancements could add
version negotiation or support for newer format versions as they become
standardized.

**Compression Strategy:**
Compression is explicitly disabled (set to NONE) in the generated
trace.dat files.
This design choice:
- Simplifies the initial implementation and testing
- Ensures maximum compatibility across trace-cmd versions
- Avoids external compression library dependencies

Future work could add support for various compression algorithms (zlib,
zstd, lz4) with runtime selection via command-line options, significantly
reducing file sizes for large traces.

======================
Usage Example
======================

```bash
*Record tracepoint events with perf*
perf record -e sched:sched_switch -e sched:sched_wakeup -a sleep 10

*Convert to trace.dat format*
perf data convert --to-trace-dat=output.dat

*Verify trace.dat structure*
trace-cmd dump --summary output.dat

*Analyze with trace-cmd*
trace-cmd report output.dat

*Visualize in KernelShark*
kernelshark output.dat
```

**Conversion Output:**
```
[ perf data convert: Converted 'perf.data' into trace.dat format
'output.dat' ]
[ perf data convert: Converted 2684 events ]
```
**trace-cmd dump --summary Output:**
```
 Tracing meta data in file output.dat:
	[Initial format]
		7	[Version]
		0	[Little endian]
		8	[Bytes in a long]
		65536	[Page size, bytes]
		none	[Compression algorithm]
			[Compression version]
	[buffer "", "local" clock, 65536 page size, 16 cpus, 1048576 bytes
    flyrecord data]
	[10 options]
	[Saved command lines, 0 bytes]
	[Kallsyms, 0 bytes]
	[Ftrace format, 0 events]
	[Header page, 206 bytes]
	[Header event, 205 bytes]
	[Events format, 1 systems]
	[9 sections]
```
======================
Testing and Verification
======================

The series has been extensively tested with:
- Various tracepoint events (sched, irq, syscalls, block I/O)
- Mixed recordings containing both tracepoint and non-tracepoint events
  only tracepoints converted)
- Verification with trace-cmd report and KernelShark visualization
- Memory leak testing with Valgrind (0 bytes leaked)
- Cross-architecture testing (x86_64, ppc64le)

All generated trace.dat files successfully open in:
- trace-cmd report (v3.1+)
- KernelShark (v2.0+)

======================
Next Steps
======================

We would highly appreciate reviews, comments, and feedback on:
- The overall architectural approach and integration points
- Compatibility considerations with trace-cmd ecosystem
- Performance characteristics for large-scale traces
- Additional use cases or workflow scenarios
- Future enhancement priorities

Tanushree Shah (4):
  perf/trace-dat: Add trace.dat export infrastructure
  perf/trace-event: Write trace.dat metadata sections during parsing
  perf data-convert: Add perf.data to trace.dat conversion backend
  perf data: Add --to-trace-dat option for converting perf.data
    tracepoint events into trace.dat format

 tools/perf/builtin-data.c            |  38 +-
 tools/perf/util/Build                |   2 +
 tools/perf/util/data-convert-trace.c | 152 ++++++
 tools/perf/util/data-convert.h       |   4 +
 tools/perf/util/trace-dat.c          | 705 +++++++++++++++++++++++++++
 tools/perf/util/trace-dat.h          |  79 +++
 tools/perf/util/trace-event-read.c   | 259 +++++++++-
 7 files changed, 1230 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/util/data-convert-trace.c
 create mode 100644 tools/perf/util/trace-dat.c
 create mode 100644 tools/perf/util/trace-dat.h

-- 
2.53.0



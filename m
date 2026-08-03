Return-Path: <linuxppc-dev+bounces-25271-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB422C5518F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 15:00:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDKbq5Bzsz30F0;
	Tue, 04 Aug 2026 01:00:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785769223;
	cv=none; b=Sc1szYZdejwsimSbuF6elsaUavGXxlkQVuH0OXogG6N6bRP/tGc06c+HAceO1m6fVyX5kDvlLi2qfdgYSf8eRnj37VBRSVZzIupTE+ObPHOTq/kS4qnKJdsW2bGR4PYDM3hJO4fWf6ytKjwCADkweIKy52bVa3e9xfsohvoQSdIhKxVX4rPZ3Mz+4afuvNm9MABMmuzs4TlUO/NFybqq7ETJcqUg5SfBHslAu7D03Bq/VryPLzMnbGGX1EtIzo85nu+Ph5GfaRl8U3nmC/uQvVT8aR6HsB7TiPfeomIrTdqI+gXkkJ2KRZ8zrNp0m6RYRXit6S/uJhzEnrK5069Tuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785769223; c=relaxed/relaxed;
	bh=9W7N87FmPmzkltIiR6l7nZvlzP7PQDiGAGZQThsJWBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sc8mYHkF2ia/aWMNguqqCpLkSwjJVvwjItpWrQa5hPPPE/zDSXgW4xAHb9AeYM+2vRq5RTDHdUMKal5BV3FSSxzEscu6wjJt3+AOs27VHVSpVEI0hW+LwwO1aBbia+cDEKXJifKyfzy66cS0fOENs56AAqf3rRR7Dapqs/TIwTr09GkOw4Hgbuz5iWRVvZGzmM+anG+ligTO8g2wOxwmQu1MHjIfbd4zOyL9f97v81lZecRbAwNCnPyq05/woVGIkSlG7fh8pFUITfbR+p8j9koawupmiG5HLx/P4mNXtSSF/2aq+hPF7A0Hm3CbvKq8ZdvcvP6W8rF3FQU/+4OZwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DmlpUD57; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DmlpUD57;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDKbn3rVhz30DY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 01:00:20 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHdNZ2282639;
	Mon, 3 Aug 2026 15:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9W7N87FmPmzkltIiR6l7nZvlzP7PQDiGAGZQThsJW
	Bg=; b=DmlpUD57+i8imtWsiSyOwXPfqmFjwp6PpnrGFsBILu4qcXc31699/cM4V
	o8EA7oQNP2c3RErylNnJPAwD2lIkxqR48n3GZocadsVM6+A1COeSuKMOFlvB99ac
	jEEBb5KNkyv0ZYXVIbxDtT0AvIiH1ehULVVBMMYTxUM0roM4gomHyAG3mmYbN8CP
	B3l1aJW5FiwanIepcNKWXtUuuZ6mrpdz59NvkoWVYhg97LYpYsdKtFZ2kNyvUJh2
	YxN8qK11q0hwuRzi/53E7VN0wGwLfLrgXHPFsQMdG7F9Jpm9BTQ6EZJaL1HeB/dM
	NPvjUKAXdKzDTd0brByiIp3P7RkKg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4sdnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:00:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673EuNqu017524;
	Mon, 3 Aug 2026 15:00:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtydn0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 15:00:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673F08kk34013558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 15:00:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C051D2004D;
	Mon,  3 Aug 2026 15:00:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8899620040;
	Mon,  3 Aug 2026 15:00:03 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.ibm.com.com (unknown [9.39.27.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 15:00:03 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH v3 0/5] Add perf.data tracepoint events to trace.dat conversion
Date: Mon,  3 Aug 2026 20:29:50 +0530
Message-ID: <20260803145958.299956-1-tshah@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX+2K8+ZrRqPLx
 hEmh3ub29djxb4gXMMUa2sfx+gBW/No9Rczk4JfJkXbWyLsL+gqVb2J2fKpi1ME0dyDyQUyUg/K
 HSpS8pIZEvNK0t0ta1rrfKXoE5sJmP0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzMyBTYWx0ZWRfX9QFkKUikKQwe
 ri3f2XIvYaK6D6nvXFAGVeGXmRKUK12rlTCeVLaJ1pO3prBz8yqLXIZAxApseWgU7iXxkfIohb3
 77Dcskt0gHv59rtXA7xP30jNQP4H7DQdGDZgnuPIwb3Ey7iqjcJA3S7gMlTMF1gkUTbisEAa57y
 35E8kUoimghGZbfnl8oZYyU9BU83PK3hDm9g1rmroRSaso+JNKKs+lHnFQgBr2Hjmdf9IeMLIoo
 rhfF2XnUYR7cqDPFtu55CjljwFk5mO4aO240LRmfUXDLU7uCN26itN6pe2Q/tHIllb/yOU2QO8x
 0T35muncFZBNzeCVYc8fKlPpby6Q0fTmtmjL+KniiMRuL8rJqh7fHZsPm5AB3DXq2w7BV0GEopk
 xfBs0d22VrF3ugFmyk3RTyKvb81hvNsvNDRlHdMQKdmfXbIqc0Vl4MDN0WM0wGGWt/ZCsdT1hDO
 Eu+mAu4qHeJNDfMg4kw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a70acfd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Tp0rbDIa7SUVJQcLoPQA:9
X-Proofpoint-ORIG-GUID: xQX944SMnTJuqRddCGXO7I3l7sy8O1-Y
X-Proofpoint-GUID: xTsA37WOR1FDaFc80SZLesl5UnGR1QRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030133

This RFC patch series introduces support for converting perf.data files
containing tracepoint events into trace.dat format, enabling seamless
visualization and analysis using KernelShark.

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

**Patch 1/5: Core trace.dat Export Infrastructure**
Introduces util/trace-dat.c and util/trace-dat.h implementing:
- Per-CPU raw event buffer management (init, collect, free)
- Ftrace ring buffer page construction
- trace.dat section writers (strings, options, flyrecord sections)

**Patch 2/5: Metadata Integration**
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

**Patch 3/5: Conversion Backend**
Implements util/data-convert-trace.c with trace_convert__perf2dat()
function:
- Processes PERF_TYPE_TRACEPOINT samples via process_sample_event()
- Collects raw event data per-CPU using trace_dat__collect_cpu_event()
- Writes OPTIONS sections (CPUCOUNT, TRACECLOCK, metadata offsets)
- Writes FLYRECORD section with per-CPU ring buffer pages

**Patch 4/5: User Interface**
Extends tools/perf/builtin-data.c with --to-trace-dat option:
- Adds command-line option for trace.dat output
- Mutually exclusive with --to-ctf and --to-json
- Calls trace_convert__perf2dat() to perform conversion

**Patch 5/5: Shell Test**
Adds a shell test (tools/perf/tests/shell/) covering normal tracepoint
recordings, pipe mode and mixed tracepoint/non-tracepoint recording
conversions and --force flag behaviour.

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
- Memory leak testing with Valgrind (0 bytes leaked).
- Cross-architecture testing: v1 tested x86_64 and ppc64le. v2 adds
  s390 (big-endian) perf.data converted on both ppc64le
  (little-endian) and x86_64 (little-endian) hosts, in addition to
  same-arch x86_64 (LE->LE) and ppc64le (BE->BE) conversion.
- Pipe mode support has been tested end-to-end. (in v2)

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

---
Changes in v3

- Rebase on latest perf-tools-next and resolve merge conflicts.
- Drop evsel parameter from process_sample_event() following upstream
  commit "perf tool: Remove evsel from tool APIs that pass the sample".

Changes in v2

Addressing the Sashiko AI review findings on v1:
 
Cross-arch correctness:
  - Introduce to_file_u16/u32/u64 helpers (wrapping tep_read_number())
    to write all multi-byte fields in the recorded machine's byte order;
    apply throughout metadata sections and flyrecord page/record headers
    (ts, commit, TIME_EXTEND, large-event data_len).
  - Fix flyrecord record header bit layout for big-endian files.
    The record header word bit layout differs by file endianness,
    matching kbuffer-parse.c type_len4host()/ts4host():
      LE: type_len in bits [4:0],   time_delta in bits [31:5]
      BE: type_len in bits [31:27], time_delta in bits [26:0]
 
Pipe mode:
  - Add process_attr(), process_feature(), and process_tracing_data()
    callbacks required for pipe mode operation.
  - Defer CPU buffer initialisation until the first tracepoint sample,
    after process_feature()/process_tracing_data() have populated the
    session header. This ensures the recorded machine's CPU count is
    used rather than the host's - critical for cross-platform analysis.
 
Format compliance:
  - Implement TIME_EXTEND records for timestamp deltas >27 bits to
    prevent silent truncation and maintain chronological ordering.
  - Fix large event encoding (>=29 words): use type_len=0 with a
    separate 32-bit length word, avoiding collision with reserved types
    (PADDING=29, TIME_EXTEND=30, TIME_STAMP=31).
  - Add bounds check rejecting records larger than a page payload before
    batching, preventing heap overflow in trace_dat__write_page().
  - Fix flyrecord section_size to exclude the 16-byte section header,
    matching trace.dat specification and trace-cmd behaviour.
 
CLI behavior:
  - Fix --force flag: open with O_CREAT|O_EXCL when force is not set,
    failing with -EEXIST instead of silently overwriting existing files.
 
Memory safety:
  - Fix realloc overwrite of cpu_events->events and page_records on
    failure: use temporary pointers, only commit on success.
  - Fix use-after-free/double-free in sequential page_records realloc
    failure: replace with malloc+memcpy+free pattern.
  - Fix section_size computed from before section header position.
  - Add NULL checks for get_tracing_file(), calloc() padding, and
    trace_dat_options_offset assignment on write failure.
  - Use goto out_free on record allocation failure to avoid leaking
    accumulated page_records entries.
  - Replace direct read() with do_read() in read_proc_kallsyms() to
    handle short reads correctly.
  - On fwrite failure, set trace_dat_write_failed and continue parsing
    so that perf.data processing completes normally.
 
Testing (new in v2):
  - Add shell test covering conversion, trace-cmd dump validation,
    sched_switch event verification, and --force flag behaviour.
 
Documentation (new in v2):
  - Add documentation for 'perf data convert --to-trace-dat', covering
    usage and supported options.

v1: https://lore.kernel.org/linux-perf-users/20260608125951.90425-2-tshah@linux.ibm.com/

Tanushree Shah (5):
  perf/trace-dat: Add trace.dat export infrastructure
  perf/trace-event: Write trace.dat metadata sections during parsing
  perf data-convert: Add perf.data to trace.dat conversion backend
  perf data: Add --to-trace-dat option for converting perf.data
    tracepoint events into trace.dat format
  perf test: Add test validating trace.dat generated by 'perf data
    convert --to-trace-dat'

 tools/perf/Documentation/perf-data.txt        |   7 +
 tools/perf/builtin-data.c                     |  43 +
 ...rf_data_converter_tracepoints_trace_dat.sh | 169 ++++
 tools/perf/util/Build                         |   2 +
 tools/perf/util/data-convert-trace.c          | 241 +++++
 tools/perf/util/data-convert.h                |   4 +
 tools/perf/util/trace-dat.c                   | 876 ++++++++++++++++++
 tools/perf/util/trace-dat.h                   | 113 +++
 tools/perf/util/trace-event-read.c            | 307 +++++-
 9 files changed, 1755 insertions(+), 7 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace_dat.sh
 create mode 100644 tools/perf/util/data-convert-trace.c
 create mode 100644 tools/perf/util/trace-dat.c
 create mode 100644 tools/perf/util/trace-dat.h

-- 
2.47.1



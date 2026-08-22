Return-Path: <linuxppc-dev+bounces-26044-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD7DC5DF8C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Aug 2026 06:27:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRnKh74bPz2xWt;
	Sat, 22 Aug 2026 16:27:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787380072;
	cv=none; b=f5dX1SPL9S9edWRZ7Wn5XwePGiuzp0XVtizJvDqjuehXPvaJ4I+Wt/Gzj0lEPIkeGdTiwvS7qj79vR6V5yoF8JKargFenJEJ/ySpURC4bl4MROSQpeENx45HELZpyd/jVWFThQ0nDjPhaOkmWb7M5hGsWu0wAFgbTNT062sMj+3JU7ZoSd2xekCQY3qhNWJCuQpyX/B/HTUcI0vMV82KyHkL/wxG+wovjyQc4wm4vJb5+33yXPhJPqOdgqgfG6N7MUZJJq5Fz4VZi1EJglnurCjTCwe69T08PfU4Ii7eiwSZI18Rqh8VTFy5+TlAgNdt8rGZx4D0WN4uOHsjycYKlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787380072; c=relaxed/relaxed;
	bh=B3MKNm83H2DhV+gF+4WVi6k2/VCYpoy4f7I95MiLM9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MyDqc36j3lVYRhEKKUEcRxRMe9DnQ+v26+UADTVee4NzrsLmbH9Byuzme/YaAg3WGbdUXkCxkAkgqO94k3/LUjRbw+1GyCTHvD3oDf++E+raVhQJlnf82DkCNrwSILjYJT0AaL5egsNqTqfJuj59e6MTVYKFj1yxyX3kfooTCFkChRu6s4Bt/Yc1ailUYIZSPZNTz0xoyXuFV/nyk6p7OBGqhIkCaehhv3SeNj1weFfDkdWVf/ZhtH7BaJQwvVIL7EMm82zP9efmQMojZIowh/9C/Q2x9Hct1WtL7IxcGzetrw54zzds8YOxn76v5KSKQg9fRBaCmTQ5Z7kpkdDOng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PXspEQyS; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PXspEQyS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRnKf71Tyz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Aug 2026 16:27:50 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67M51bE23671663;
	Sat, 22 Aug 2026 06:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=B3MKNm83H2DhV+gF+4WVi6k2/VCYpoy4f7I95MiLM
	9U=; b=PXspEQyStz80U90iNlkdxfZrSYfirAGZFCGzsdc5WGjwYrhXNPRrELjoP
	eMvmWGG8FxeL2UKvFolSS8J7D9xMkEtzjVxXR1TBUUzyyrnpCGk3dKZtoaabji3R
	nZOZ3Zqk6d+99KGGbs6tLtthGQqrYcBTmSEJ3kLzNhzaVDm1XPm1x0a+fPdmPVvV
	UBlQFqs5erUL5iY5SUpnp3mj4dZETvqYzkMIhb+fSz5gY3wJeAS4QF+ir70EtPYk
	PCZYGXNZ6kSpGTZinJ1HX8aNAcaBjIR/zXH5J63Q356pa0VMDi+NJV4Zr9+CtF7k
	YgO/RVbWOd0gOZGY3NMPVIfhJ3lHQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g48h7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Aug 2026 06:27:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67M6QKDe003529;
	Sat, 22 Aug 2026 06:27:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twrpp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Aug 2026 06:27:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67M6RaTJ45613388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Aug 2026 06:27:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53F4A20043;
	Sat, 22 Aug 2026 06:27:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 548E620040;
	Sat, 22 Aug 2026 06:27:32 +0000 (GMT)
Received: from li-4c4c4544-0047-4210-804e-b5c04f423534.bbrouter (unknown [9.124.214.68])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Aug 2026 06:27:32 +0000 (GMT)
From: Tanushree Shah <tshah@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org,
        Tanushree Shah <tshah@linux.ibm.com>
Subject: [RFC PATCH v4 0/5] Add perf.data tracepoint events to trace.dat conversion
Date: Sat, 22 Aug 2026 11:57:19 +0530
Message-ID: <20260822062729.882005-1-tshah@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GEFfilBB9TQ35VUXlee2fq3KslGas0PR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA0NiBTYWx0ZWRfX618RB9XbhA72
 ZlRYJTLn03LCvS/D9KPLzgamy1if3S471ga8N8iWbFWsqvtF/A5GgD59J2iFFK62ZWKhTpZ1Lzm
 3XYqOI+m8MzA15e1P/2CTbJ82pQnxwQ=
X-Proofpoint-GUID: f3Brlx8SM4Fz1rGcwu7XZD5E4UZJJegi
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a89415e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9ibJ0VodueySRw4JxTQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA0NiBTYWx0ZWRfXxYy5B+vW2dnP
 i0Upa/+aMJfvilpywmMTiTouzAd5qvcsT+hPgqcb+XEDOXpoY9TPybswgkatLFNLc4mbSPCIoaX
 vn3blat791+BoWOI2xdeZM+r9tVVSou0lW780GsGqvVgFWRCiB9qBvM+vmCxaKCBKqHCeDemomu
 CRtnbw2xNpJlCrV9KXGKqKG7cVNnbZ1q2fsGG4Wvfn/zcs7+bKNv7qNOnBTZgAR4rpcsWDTLy5x
 zhyNf2dxorbyXyNq3fPDahpHQJMMXHCT3SkfedHLKy0WLJhnH8VgFQftg8AMSGliQRg69LMaHZz
 XwJhoupY2+QOnH1kSUxHYZMNvKGlc/SB08cEQMGIkvTB/mRX/bSLSvS9epG9E3lJEiyRTaXuMEC
 lYMsqQWZ7I01chd6nSSKkB00KB8BIPKM9PfbkXAIqMeYry32uC8tbTQfVBarQbZZRbVyxwJgj8j
 5hydDKvaCGlcEZV0UmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608220046

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
  (only tracepoints converted)
- Verification with trace-cmd report and KernelShark visualization
- Memory leak testing with Valgrind (0 bytes leaked)
- Cross-architecture testing: v1 tested x86_64 and ppc64le. v2 adds
  s390 (big-endian) perf.data converted on both ppc64le
  (little-endian) and x86_64 (little-endian) hosts, in addition to
  same-arch x86_64 (LE->LE) and ppc64le (BE->BE) conversion.
- Pipe mode support has been tested end-to-end. (in v2)
- Time filtering: verified --time option correctly limits converted
  events to the requested range, consistent with --to-json behaviour.
  (in v4)

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
Changes in v4

Addressing Sashiko AI review findings on v3:

Timestamp correctness (trace-dat.c):
  - Fix TIME_EXTEND delta_upper shift: >> 5 (TRACE_DAT_RECORD_TIME_SHIFT)
    should be >> 27, causing wildly inflated timestamps in trace-cmd.
  - Advance base_ts after every event so time_delta is relative to the
    preceding record, not a stale page base.
  - Introduce page_base_ts updated only at page boundaries, keeping the
    page header timestamp correct independently of per-event base_ts.

Memory safety (trace-dat.c):
  - Fix leak on TIME_EXTEND calloc() failure: use goto out_free instead
    of return -ENOMEM so page_records/page_rec_sizes are freed.

I/O correctness (trace-event-read.c):
  - Check fseek() return values when patching the event formats section
    size; set trace_dat_write_failed on any failure to prevent silent
    corruption of subsequent writes.

Resource management (data-convert-trace.c):
  - Fix orphaned 0-byte output file when fdopen() fails in !opts->force
    path: use goto out_close so unlink() is called on error.
  - Honor --time filtering using perf_time__parse_for_ranges() and
    perf_time__ranges_skip_sample(), consistent with JSON/CTF converters.
  - Add explicit <stdio.h> include for fdopen()/fopen()/fclose().

Header (trace-dat.h):
  - Add explicit <stdint.h> for uint16_t/uint32_t/uint64_t on musl libc.

Shell test (patch 5):
  - Replace 'cycles' with 'cpu-clock -a' for portability on s390, KVM
    guests and unprivileged containers without hardware PMU support.
  - Add -a to all perf record/sleep invocations per Ian's suggestion.
  - Fix EXIT trap to pass through exit code 2 (skip) unchanged.
  - Move second mktemp after trap registration to avoid temp file leak.
  - Drop rm -f "$result" before converter in test_trace_converter_command;
    --force handles overwriting and deleting first opens a symlink race.
  - Move rm -f "$result" to before perf record in pipe and mixed-events
    tests to prevent stale output being validated on early return.

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
 ...rf_data_converter_tracepoints_trace_dat.sh | 173 ++++
 tools/perf/util/Build                         |   2 +
 tools/perf/util/data-convert-trace.c          | 264 ++++++
 tools/perf/util/data-convert.h                |   4 +
 tools/perf/util/trace-dat.c                   | 883 ++++++++++++++++++
 tools/perf/util/trace-dat.h                   | 114 +++
 tools/perf/util/trace-event-read.c            | 307 +++++-
 9 files changed, 1790 insertions(+), 7 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace_dat.sh
 create mode 100644 tools/perf/util/data-convert-trace.c
 create mode 100644 tools/perf/util/trace-dat.c
 create mode 100644 tools/perf/util/trace-dat.h

-- 
2.47.1



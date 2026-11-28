Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3472606A31F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LDtMS6yF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc3wx5ZSQz2xjP;
	Sat, 28 Nov 2026 19:53:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795856033;
	cv=none; b=mhUqNHxz8ZyKF4ng6nezd+SQGxEkBb37ZyJ9DnxZptNbCJSSHqE5GVq9QPXw6ZnuD9NT5cQYuCMMM5Wi2IOUf7x9gXnnnRHmpk8nTTkoEu/Qq3aygzQRnZgCPJH8ENHBF5zUGI31Uyhrr1z+PAJCzBFt2dR72qpAShNTKM6GZTJI5lALNc1v6pGhcq3IxIJ7kv1fYd0dQ/KeqU82CGufLWfEUGMX1i7H8IJTLfNUfkEUrtRJdhl8Kx2biLi3YxB3CXY20eNZg8ZGzYxmA9YYTWxGgLxfvw8hrMTjyTYwvSDFiMyHX9XswHo4pblxz5OxBnUnr+SMl5o5XR1KXDrNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795856033; c=relaxed/relaxed;
	bh=0cGxzr1KGg9ThNBoisPllYArLCPmgAD/0+Oy3J8b/sY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=HEUX9Eiw/wGjqQ0I7FACy5IH/PHTqB0YR3pbRLW/VFFaZwwwxLDKhO1XCP9p5Xaoxwk2LWUGX1IYeNotvraPv1Jze5qd8zu1oaA/V9J8UXMSP45a9kBMNnblDuu6ux/SfPr7GAPLwOIMzSOn5Qi25kd/iozogFpABk3uhN9AOJ4vAVG1YllNXOkWxnQy8kzFabILI/TEszx/KV23HQks0FENOGcjmUQGSYxGO9dir2+uKr0Ibw0O4oBuXrUkU4MswLgy9W3rW3PX7meOflVcpulNsIXg2jXPfHMyGXUPFMBwpc+wZHWCmKQBF02FOEtnRlwo1TN4FmMKLcV+moGglw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LDtMS6yF; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LDtMS6yF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tejas05@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc3ww0zkJz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 19:53:51 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AS4YbB7725544;
	Sat, 28 Nov 2026 08:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0cGxzr1KGg9ThNBoisPllYArLCPmgA
	D/0+Oy3J8b/sY=; b=LDtMS6yFKcOUreigDpZt9Sc9nqOxovw0kXGRMaEzQwsPyk
	JknvBgqjQqW8GMuL+mUIlXqB9aKzhavF77o9dU5nfe18Cao6TlrlyhBfsOkfFYNk
	Cw1dStYsC+/Fpqs/8YQ6qYS5K9OIwqDVa+4rL0s+E0xar6UKTfGD5BoMGU89c2X+
	L8yn3emf1M33/slcRr10Ylw2XLumdZFSmTwYsaIpVMgSlyZxAJ5lw3sXyTnch14A
	NFpFjqeaC8/VpYpD31WQvQZxlRoZliUH1BGEG+5lcNUXj/DOvEbLpRVHs6sxpIpI
	WTWNojOoQqLewR2+mCDRwxyixmYGRUag1Emz7OAQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j7mck117b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 08:53:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AS4JGgD4160970;
	Sat, 28 Nov 2026 08:53:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxxby19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Nov 2026 08:53:41 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AS8rcXg52429058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Nov 2026 08:53:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F26558056;
	Sat, 28 Nov 2026 08:53:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9975158052;
	Sat, 28 Nov 2026 08:53:31 +0000 (GMT)
Received: from [9.124.208.201] (unknown [9.124.208.201])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 28 Nov 2026 08:53:31 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------gDzFElFoWMN0SCQexvJvMAl7"
Message-ID: <bb2d77d7-fb98-451c-b3fd-5a4d9b865282@linux.ibm.com>
Date: Sat, 28 Nov 2026 14:23:29 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 0/5] Add perf.data tracepoint events to trace.dat
 conversion
To: Tanushree Shah <tshah@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, vmolnaro@redhat.com, mpetlan@redhat.com,
        tmricht@linux.ibm.com, maddy@linux.ibm.com, irogers@google.com,
        namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org
References: <20260822062729.882005-1-tshah@linux.ibm.com>
Content-Language: en-US
From: Tejas <tejas05@linux.ibm.com>
In-Reply-To: <20260822062729.882005-1-tshah@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI4MDAzNCBTYWx0ZWRfX0NAjMpjkrQBz
 zZ+6oUAtI6SefTdhxKjKKCtd9/zfngNMaV5mq/2OSgGhF6h/jDhf9Vx4JKiCqmNzVPmaWArYQmo
 nsQpWG0Jis5PXcKWPHXj5Pd6OikzGD4=
X-Authority-Analysis: v=2.4 cv=MtfHeGae c=1 sm=1 tr=0 ts=6b0a9696 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rPcVIzdCP0rLiskAh84A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=SI2jfP4bZpg5dYLdXWoA:9 a=wAeynHeHK_UmNeLU:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI4MDAzNCBTYWx0ZWRfX4sFeQnKtMxaG
 6YvZQZb95fV/aQL4yrDgvRN7SV1c6iBqt2Tcx8/Q+JArUztpEDsJ0tOn0kbdq1p+VYLvEi+DkK9
 RpbxTFLeXJAjEQukBzt1suoxxqALGFfctv6Hp12EInQDiaTc1NIUzaIGbM1UVCY5Pfj2n/itGN+
 NboDtRNZbclwfLtzEw/cJElPmr90CpgAFSQ62Zl9Vd1oPakocSmpgqQjnsDlH56q1geYNezgCZ+
 +VXN7KEux+4fzK4c6qWDLoV1iYxnVs8Fs6cFa7kXmh/SF+q43TptKxk+S9GPXzQCDzNRCe6wXXd
 MvEzv2lkt8+4aJvWwSsi8FtDhk4lKug+zcGEr03Y1zNe7fQwxq11sFnQZPAWfQJglo/ZYt8vAt5
 wsk4ImgVBwZ1BUT7bgJCYGWpMioI+JlE9V4DLiDpoir/TcRdiGThGOERrooxvXba4YxcwcNzhHz
 dz26Co9lIx97dQVz4Wg==
X-Proofpoint-GUID: I5RdVao8de_bgw_mJOdHpW6uH82ukfNV
X-Proofpoint-ORIG-GUID: olHKFc1ROqaos6YEfsqnOHVpDwroKGeS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-28_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611280034
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------gDzFElFoWMN0SCQexvJvMAl7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/26 11:57 am, Tanushree Shah wrote:

> This RFC patch series introduces support for converting perf.data files
> containing tracepoint events into trace.dat format, enabling seamless
> visualization and analysis using KernelShark.
>
> ======================
> Background and Motivation
> ======================
>
> Currently, perf and trace-cmd operate as separate tracing ecosystems with
> incompatible data formats. Users who collect tracepoint data with
> 'perf record' cannot easily visualize it in KernelShark's graphical
> timeline view or leverage trace-cmd's analysis capabilities.
>
> This creates workflow friction when users need to:
>
> - Visualize perf tracepoint data in KernelShark's interactive graphical
>    timeline
> - Share trace data between perf and trace-cmd workflows and toolchains
> - Perform architecture-independent conversion and analysis of traces
>
> This conversion bridge eliminates these barriers by enabling seamless
> data exchange between perf and trace-cmd ecosystems, allowing users to
> choose the best tool for each analysis phase.
>
> ======================
> Implementation Overview
> ======================
>
> The series implements the trace.dat file format specification (version 7)
> within perf's data conversion framework.
>
> **Patch 1/5: Core trace.dat Export Infrastructure**
> Introduces util/trace-dat.c and util/trace-dat.h implementing:
> - Per-CPU raw event buffer management (init, collect, free)
> - Ftrace ring buffer page construction
> - trace.dat section writers (strings, options, flyrecord sections)
>
> **Patch 2/5: Metadata Integration**
> Extends util/trace-event-read.c to write trace.dat metadata during
> perf.data
> parsing:
> - Initial format header (magic, version, endian, page size, compression)
> - Section 16: HEADER INFO (header_page + header_event)
> - Section 17: FTRACE EVENT FORMATS
> - Section 18: EVENT FORMATS (per system/event format files)
> - Section 19: KALLSYMS
> - Section 21: CMDLINES
> - Section 15: STRINGS (written last after all sections)
>
> **Patch 3/5: Conversion Backend**
> Implements util/data-convert-trace.c with trace_convert__perf2dat()
> function:
> - Processes PERF_TYPE_TRACEPOINT samples via process_sample_event()
> - Collects raw event data per-CPU using trace_dat__collect_cpu_event()
> - Writes OPTIONS sections (CPUCOUNT, TRACECLOCK, metadata offsets)
> - Writes FLYRECORD section with per-CPU ring buffer pages
>
> **Patch 4/5: User Interface**
> Extends tools/perf/builtin-data.c with --to-trace-dat option:
> - Adds command-line option for trace.dat output
> - Mutually exclusive with --to-ctf and --to-json
> - Calls trace_convert__perf2dat() to perform conversion
>
> **Patch 5/5: Shell Test**
> Adds a shell test (tools/perf/tests/shell/) covering normal tracepoint
> recordings, pipe mode and mixed tracepoint/non-tracepoint recording
> conversions and --force flag behaviour.
>
> ======================
> Current Implementation Details
> ======================
>
> **trace.dat Format Version:**
> The implementation currently targets trace.dat format version 7, which
> is the stable version supported by current trace-cmd releases (v3.x).
> This version is hardcoded to ensure compatibility with existing
> trace-cmd and KernelShark installations. Future enhancements could add
> version negotiation or support for newer format versions as they become
> standardized.
>
> **Compression Strategy:**
> Compression is explicitly disabled (set to NONE) in the generated
> trace.dat files.
> This design choice:
> - Simplifies the initial implementation and testing
> - Ensures maximum compatibility across trace-cmd versions
> - Avoids external compression library dependencies
>
> Future work could add support for various compression algorithms (zlib,
> zstd, lz4) with runtime selection via command-line options, significantly
> reducing file sizes for large traces.
>
> ======================
> Usage Example
> ======================
>
> ```bash
> *Record tracepoint events with perf*
> perf record -e sched:sched_switch -e sched:sched_wakeup -a sleep 10
>
> *Convert to trace.dat format*
> perf data convert --to-trace-dat=output.dat
>
> *Verify trace.dat structure*
> trace-cmd dump --summary output.dat
>
> *Analyze with trace-cmd*
> trace-cmd report output.dat
>
> *Visualize in KernelShark*
> kernelshark output.dat
> ```
>
> **Conversion Output:**
> ```
> [ perf data convert: Converted 'perf.data' into trace.dat format
> 'output.dat' ]
> [ perf data convert: Converted 2684 events ]
> ```
> **trace-cmd dump --summary Output:**
> ```
>   Tracing meta data in file output.dat:
> 	[Initial format]
> 		7	[Version]
> 		0	[Little endian]
> 		8	[Bytes in a long]
> 		65536	[Page size, bytes]
> 		none	[Compression algorithm]
> 			[Compression version]
> 	[buffer "", "local" clock, 65536 page size, 16 cpus, 1048576 bytes
>      flyrecord data]
> 	[10 options]
> 	[Saved command lines, 0 bytes]
> 	[Kallsyms, 0 bytes]
> 	[Ftrace format, 0 events]
> 	[Header page, 206 bytes]
> 	[Header event, 205 bytes]
> 	[Events format, 1 systems]
> 	[9 sections]
> ```	
> ======================
> Testing and Verification
> ======================
>
> The series has been extensively tested with:
> - Various tracepoint events (sched, irq, syscalls, block I/O)
> - Mixed recordings containing both tracepoint and non-tracepoint events
>    (only tracepoints converted)
> - Verification with trace-cmd report and KernelShark visualization
> - Memory leak testing with Valgrind (0 bytes leaked)
> - Cross-architecture testing: v1 tested x86_64 and ppc64le. v2 adds
>    s390 (big-endian) perf.data converted on both ppc64le
>    (little-endian) and x86_64 (little-endian) hosts, in addition to
>    same-arch x86_64 (LE->LE) and ppc64le (BE->BE) conversion.
> - Pipe mode support has been tested end-to-end. (in v2)
> - Time filtering: verified --time option correctly limits converted
>    events to the requested range, consistent with --to-json behaviour.
>    (in v4)
>
> All generated trace.dat files successfully open in:
> - trace-cmd report (v3.1+)
> - KernelShark (v2.0+)
>
>
> ======================
> Next Steps
> ======================
>
> We would highly appreciate reviews, comments, and feedback on:
> - The overall architectural approach and integration points
> - Compatibility considerations with trace-cmd ecosystem
> - Performance characteristics for large-scale traces
> - Additional use cases or workflow scenarios
> - Future enhancement priorities
>
> ---
> Changes in v4
>
> Addressing Sashiko AI review findings on v3:
>
> Timestamp correctness (trace-dat.c):
>    - Fix TIME_EXTEND delta_upper shift: >> 5 (TRACE_DAT_RECORD_TIME_SHIFT)
>      should be >> 27, causing wildly inflated timestamps in trace-cmd.
>    - Advance base_ts after every event so time_delta is relative to the
>      preceding record, not a stale page base.
>    - Introduce page_base_ts updated only at page boundaries, keeping the
>      page header timestamp correct independently of per-event base_ts.
>
> Memory safety (trace-dat.c):
>    - Fix leak on TIME_EXTEND calloc() failure: use goto out_free instead
>      of return -ENOMEM so page_records/page_rec_sizes are freed.
>
> I/O correctness (trace-event-read.c):
>    - Check fseek() return values when patching the event formats section
>      size; set trace_dat_write_failed on any failure to prevent silent
>      corruption of subsequent writes.
>
> Resource management (data-convert-trace.c):
>    - Fix orphaned 0-byte output file when fdopen() fails in !opts->force
>      path: use goto out_close so unlink() is called on error.
>    - Honor --time filtering using perf_time__parse_for_ranges() and
>      perf_time__ranges_skip_sample(), consistent with JSON/CTF converters.
>    - Add explicit <stdio.h> include for fdopen()/fopen()/fclose().
>
> Header (trace-dat.h):
>    - Add explicit <stdint.h> for uint16_t/uint32_t/uint64_t on musl libc.
>
> Shell test (patch 5):
>    - Replace 'cycles' with 'cpu-clock -a' for portability on s390, KVM
>      guests and unprivileged containers without hardware PMU support.
>    - Add -a to all perf record/sleep invocations per Ian's suggestion.
>    - Fix EXIT trap to pass through exit code 2 (skip) unchanged.
>    - Move second mktemp after trap registration to avoid temp file leak.
>    - Drop rm -f "$result" before converter in test_trace_converter_command;
>      --force handles overwriting and deleting first opens a symlink race.
>    - Move rm -f "$result" to before perf record in pipe and mixed-events
>      tests to prevent stale output being validated on early return.
>
> Changes in v3
>
> - Rebase on latest perf-tools-next and resolve merge conflicts.
> - Drop evsel parameter from process_sample_event() following upstream
>    commit "perf tool: Remove evsel from tool APIs that pass the sample".
>
> Changes in v2
>
> Addressing the Sashiko AI review findings on v1:
>   
> Cross-arch correctness:
>    - Introduce to_file_u16/u32/u64 helpers (wrapping tep_read_number())
>      to write all multi-byte fields in the recorded machine's byte order;
>      apply throughout metadata sections and flyrecord page/record headers
>      (ts, commit, TIME_EXTEND, large-event data_len).
>    - Fix flyrecord record header bit layout for big-endian files.
>      The record header word bit layout differs by file endianness,
>      matching kbuffer-parse.c type_len4host()/ts4host():
>        LE: type_len in bits [4:0],   time_delta in bits [31:5]
>        BE: type_len in bits [31:27], time_delta in bits [26:0]
>   
> Pipe mode:
>    - Add process_attr(), process_feature(), and process_tracing_data()
>      callbacks required for pipe mode operation.
>    - Defer CPU buffer initialisation until the first tracepoint sample,
>      after process_feature()/process_tracing_data() have populated the
>      session header. This ensures the recorded machine's CPU count is
>      used rather than the host's - critical for cross-platform analysis.
>   
> Format compliance:
>    - Implement TIME_EXTEND records for timestamp deltas >27 bits to
>      prevent silent truncation and maintain chronological ordering.
>    - Fix large event encoding (>=29 words): use type_len=0 with a
>      separate 32-bit length word, avoiding collision with reserved types
>      (PADDING=29, TIME_EXTEND=30, TIME_STAMP=31).
>    - Add bounds check rejecting records larger than a page payload before
>      batching, preventing heap overflow in trace_dat__write_page().
>    - Fix flyrecord section_size to exclude the 16-byte section header,
>      matching trace.dat specification and trace-cmd behaviour.
>   
> CLI behavior:
>    - Fix --force flag: open with O_CREAT|O_EXCL when force is not set,
>      failing with -EEXIST instead of silently overwriting existing files.
>   
> Memory safety:
>    - Fix realloc overwrite of cpu_events->events and page_records on
>      failure: use temporary pointers, only commit on success.
>    - Fix use-after-free/double-free in sequential page_records realloc
>      failure: replace with malloc+memcpy+free pattern.
>    - Fix section_size computed from before section header position.
>    - Add NULL checks for get_tracing_file(), calloc() padding, and
>      trace_dat_options_offset assignment on write failure.
>    - Use goto out_free on record allocation failure to avoid leaking
>      accumulated page_records entries.
>    - Replace direct read() with do_read() in read_proc_kallsyms() to
>      handle short reads correctly.
>    - On fwrite failure, set trace_dat_write_failed and continue parsing
>      so that perf.data processing completes normally.
>   
> Testing (new in v2):
>    - Add shell test covering conversion, trace-cmd dump validation,
>      sched_switch event verification, and --force flag behaviour.
>   
> Documentation (new in v2):
>    - Add documentation for 'perf data convert --to-trace-dat', covering
>      usage and supported options.
>
> v1:https://lore.kernel.org/linux-perf-users/20260608125951.90425-2-tshah@linux.ibm.com/
>
> Tanushree Shah (5):
>    perf/trace-dat: Add trace.dat export infrastructure
>    perf/trace-event: Write trace.dat metadata sections during parsing
>    perf data-convert: Add perf.data to trace.dat conversion backend
>    perf data: Add --to-trace-dat option for converting perf.data
>      tracepoint events into trace.dat format
>    perf test: Add test validating trace.dat generated by 'perf data
>      convert --to-trace-dat'
>
>   tools/perf/Documentation/perf-data.txt        |   7 +
>   tools/perf/builtin-data.c                     |  43 +
>   ...rf_data_converter_tracepoints_trace_dat.sh | 173 ++++
>   tools/perf/util/Build                         |   2 +
>   tools/perf/util/data-convert-trace.c          | 264 ++++++
>   tools/perf/util/data-convert.h                |   4 +
>   tools/perf/util/trace-dat.c                   | 883 ++++++++++++++++++
>   tools/perf/util/trace-dat.h                   | 114 +++
>   tools/perf/util/trace-event-read.c            | 307 +++++-
>   9 files changed, 1790 insertions(+), 7 deletions(-)
>   create mode 100755 tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace_dat.sh
>   create mode 100644 tools/perf/util/data-convert-trace.c
>   create mode 100644 tools/perf/util/trace-dat.c
>   create mode 100644 tools/perf/util/trace-dat.h

Hi Tanushree,

I tested this series on a ppc64le LPAR.
Setup:
   - 16 CPUs, 64K page size
   - Base: torvalds/linux master at 9437ee8b6cf6.
   - perf built with libtraceevent, trace-cmd 3.3.1
Applying the series:
   Patches 1 and 2 applied cleanly. Patch 3 failed on a context mismatch
   in tools/perf/util/Build, because the lines after data-convert-json.o
   have moved on master. I added the one line by hand:
     perf-util-$(CONFIG_LIBTRACEEVENT) += data-convert-trace.o
   Patches 4 and 5 then applied cleanly. The series is probably based on
   perf-tools-next, so this may only be a base difference.
Results:
   - perf test -v trace-dat ("perf data convert --to-trace-dat" command
     test) passes.
   - perf record -e sched:sched_switch -a -- sleep 3 gave 496 events.
     The converted file is read by trace-cmd report with no warnings.
     Event count, per-CPU timestamps and sched_switch payload text match
     perf script, and trace-cmd dump shows 16 CPUs and a 64K page size.
   - A larger run with sched:sched_switch, sched_wakeup and
     sched_process_exit under perf bench sched messaging produced 171873
     events (23 MB). All 171873 events converted. The flyrecord section
     is about 11.9 MB (about 180 pages over 16 CPUs), so the multi-page
     path was exercised. Event count, payload text, CPU numbers and
     timestamps match perf script, and timestamps never go backwards on
     any CPU.
Observations:
   - trace-cmd prints timestamps rounded to the nearest microsecond,
     while the default perf script output truncates. The two differ by
     1 us on about half the events. The converted timestamps match
     perf script --ns after rounding to the nearest microsecond, so I
     don't think this is an issue with the conversion.
   - The saved cmdlines, kallsyms and ftrace format sections in the
     output are empty. The task name of the first event can show as
     "<...>" in trace-cmd report. Is this expected for this version of
     the series?
I have not tested HTM, CPU hotplug or SMT-off recordings, or error
paths such as a full disk. I will follow up if I run those.

Tested-by: Tejas Manhas<tejas05@linux.ibm.com>

Thanks,
Tejas Manhas

--------------gDzFElFoWMN0SCQexvJvMAl7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>
</pre>
    <pre class="moz-cite-prefix">On 22/08/26 11:57 am, Tanushree Shah wrote:
</pre>
    <blockquote type="cite"
      cite="mid:20260822062729.882005-1-tshah@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">This RFC patch series introduces support for converting perf.data files
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
  same-arch x86_64 (LE-&gt;LE) and ppc64le (BE-&gt;BE) conversion.
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
  - Fix TIME_EXTEND delta_upper shift: &gt;&gt; 5 (TRACE_DAT_RECORD_TIME_SHIFT)
    should be &gt;&gt; 27, causing wildly inflated timestamps in trace-cmd.
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
  - Fix orphaned 0-byte output file when fdopen() fails in !opts-&gt;force
    path: use goto out_close so unlink() is called on error.
  - Honor --time filtering using perf_time__parse_for_ranges() and
    perf_time__ranges_skip_sample(), consistent with JSON/CTF converters.
  - Add explicit &lt;stdio.h&gt; include for fdopen()/fopen()/fclose().

Header (trace-dat.h):
  - Add explicit &lt;stdint.h&gt; for uint16_t/uint32_t/uint64_t on musl libc.

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
  - Implement TIME_EXTEND records for timestamp deltas &gt;27 bits to
    prevent silent truncation and maintain chronological ordering.
  - Fix large event encoding (&gt;=29 words): use type_len=0 with a
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
  - Fix realloc overwrite of cpu_events-&gt;events and page_records on
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

v1: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/linux-perf-users/20260608125951.90425-2-tshah@linux.ibm.com/">https://lore.kernel.org/linux-perf-users/20260608125951.90425-2-tshah@linux.ibm.com/</a>

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
 create mode 100644 tools/perf/util/trace-dat.h</pre>
    </blockquote>
    <pre>Hi Tanushree,

I tested this series on a ppc64le LPAR.
Setup:
  - 16 CPUs, 64K page size
  - Base: torvalds/linux master at 9437ee8b6cf6. 
  - perf built with libtraceevent, trace-cmd 3.3.1
Applying the series:
  Patches 1 and 2 applied cleanly. Patch 3 failed on a context mismatch
  in tools/perf/util/Build, because the lines after data-convert-json.o
  have moved on master. I added the one line by hand:
    perf-util-$(CONFIG_LIBTRACEEVENT) += data-convert-trace.o
  Patches 4 and 5 then applied cleanly. The series is probably based on
  perf-tools-next, so this may only be a base difference.
Results:
  - perf test -v trace-dat ("perf data convert --to-trace-dat" command
    test) passes.
  - perf record -e sched:sched_switch -a -- sleep 3 gave 496 events.
    The converted file is read by trace-cmd report with no warnings.
    Event count, per-CPU timestamps and sched_switch payload text match
    perf script, and trace-cmd dump shows 16 CPUs and a 64K page size.
  - A larger run with sched:sched_switch, sched_wakeup and
    sched_process_exit under perf bench sched messaging produced 171873
    events (23 MB). All 171873 events converted. The flyrecord section
    is about 11.9 MB (about 180 pages over 16 CPUs), so the multi-page
    path was exercised. Event count, payload text, CPU numbers and
    timestamps match perf script, and timestamps never go backwards on
    any CPU.
Observations:
  - trace-cmd prints timestamps rounded to the nearest microsecond,
    while the default perf script output truncates. The two differ by
    1 us on about half the events. The converted timestamps match
    perf script --ns after rounding to the nearest microsecond, so I
    don't think this is an issue with the conversion.
  - The saved cmdlines, kallsyms and ftrace format sections in the
    output are empty. The task name of the first event can show as
    "&lt;...&gt;" in trace-cmd report. Is this expected for this version of
    the series?
I have not tested HTM, CPU hotplug or SMT-off recordings, or error
paths such as a full disk. I will follow up if I run those.

Tested-by: Tejas Manhas <a class="moz-txt-link-rfc2396E" href="mailto:tejas05@linux.ibm.com">&lt;tejas05@linux.ibm.com&gt;</a>

Thanks,
Tejas Manhas</pre>
  </body>
</html>

--------------gDzFElFoWMN0SCQexvJvMAl7--



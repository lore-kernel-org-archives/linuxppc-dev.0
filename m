Return-Path: <linuxppc-dev+bounces-25411-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F305EC55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 06:15:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFKsp3kGJz2yLY;
	Wed, 05 Aug 2026 16:15:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785910558;
	cv=none; b=Bye+9DjfKDtInFf3BmdlqytE5ddWrgieLy+0j7/J56p1IUbiMj6DgFjFhWocOI59VAb+/N3gIluuthfDrH0H9I54+mf0syqL7uBstzTumoFtx9lSBXc1YNcwC5uAWm4vWFCcMwwlpzP6g6471PjqLw62aGuFNrotXd1wtOvK6b5/v7uyxGxarMTL1XpF3jiLE23pi+SU/ezzyBW+QlmPgtGThG/PzFD+lN2XyOx1J5UnRZyR0Io0tqWu9BJamWPfZqbdDlEgkZTNXJVICl/g+L0FS5mY1G0grJCzRt+SJ3PO/nPNMo/s7Emnp2MfOAJVyvNP9jJdiSpwcSILQXJrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785910558; c=relaxed/relaxed;
	bh=zBo9vMC+MU3SHhcOblWP9SwuXb/sr9tr9VH3Sma4zl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NirP05CYn5xaklh1ryuqLeT+2YqQfTGm91qFgewLGDijr+CWAmD2suqliHdeR6DYlIbJA1l8KzfjDAzD+uTjv8gPOb8EhO1vmJv5f+GQ4IqHdJ+UCpPm7puRX+VBxn8kv0L92GdX/T4itMf59zh5ViEKW2lp7uCfihs1Zj0JYypWWhODC72PN5xKPstOOGx140BjFK9rdjsS1pHkjoDpEvYxpTfwXzS0eDu2ElQKX5LtcpHFgdTbemSx6dIl9fB2LIB3Ev2JNXu5gn04k3mtquZDGCH0U32jqY0aLwP0kJIWQmxKMlVqX+/fFS9WVjFTJ/u80McIr1KshjjTdvWnIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JrLPKmFJ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JrLPKmFJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFKsn0vf2z2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 16:15:56 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755n0bJ2911541;
	Wed, 5 Aug 2026 06:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zBo9vM
	C+MU3SHhcOblWP9SwuXb/sr9tr9VH3Sma4zl4=; b=JrLPKmFJmy3bpC47Ru978R
	r9Xr+WpSXlZV87Uep4STUaKVJ/e3yg/MPAU4O4Ns1pcQBcMYOk5IVamcC+Gd4nOD
	fLwtIotM7Wr+D7NvW2yPv8cSDfovGpHj6nkpVwTCbMq1S3FQhruq+ubC0uAcVJKB
	6EgRwV23DV1kjE9yx+Clzqwwld2gbYnjZGt8L0Y2RnV0cFAOUht40yQy8635c/BM
	DowGsj9duBaMnkWIqfHzm9WDwO80ZSUFvmQ6M2ibh+J/vrvVsIiHDb5FjChHxU58
	wPiph+N0a9IlXFyFkkbx2VOQed/LNANWPQNjKW6xW7NN+k6M2Fepq1yXWI3xtpbQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g97x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:15:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6756BNLd002401;
	Wed, 5 Aug 2026 06:15:48 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhd7cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:15:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6756FjRQ20513308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 06:15:45 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C10258043;
	Wed,  5 Aug 2026 06:15:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AEE958059;
	Wed,  5 Aug 2026 06:15:38 +0000 (GMT)
Received: from [9.39.28.2] (unknown [9.39.28.2])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 06:15:38 +0000 (GMT)
Message-ID: <28c7f42a-30ee-4bb0-a0f3-cc808d36ed1f@linux.ibm.com>
Date: Wed, 5 Aug 2026 11:45:36 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] Add perf.data tracepoint events to trace.dat
 conversion
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, rostedt@goodmis.org
References: <20260802180801.65183-1-tshah@linux.ibm.com>
 <CAP-5=fXGaMPzt8BUZKQB4QeuxrfiERAF8Kdut+uBPnXWvL82-g@mail.gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <CAP-5=fXGaMPzt8BUZKQB4QeuxrfiERAF8Kdut+uBPnXWvL82-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA0MiBTYWx0ZWRfX1e1CG++6PQpY
 PQTsQnvk0D3uK+3gjBYk16VmpPwikkRm3WCA5HZHFhvE31GULjEQ7VGVBDktTVaWOhtZIUVJ5NF
 TNdfNoML1WT4UVveElaPp5qND77STUeskVaK3swODhM70wWy42hKbzIGte2CED9vbQ9cgx78/Cb
 p6az84hz0hinGiDz69ew/oZWZI7BuCDqzgtMe0hQXI21zOlCRTpFrp5UATHfP/3eoQNCBqEcmj7
 d2YF+moWNhavJL7k3MJAAs07pOfTLOaB7kdN62UB5vy4fQjF2SwVxqhoLE8EYxUNmXBb+c8ZoW+
 XAJ4vUSk10OV9sjAZPf16+7CEBTvMBXjOYBgH1LSwqIkY9fkV4y2HYVD3qs5TCafTsBZ37lubo5
 Dz776vyx3ollhL7v2Yz1jD2dZMKMyqoNs5SRiE0MKo00ePi5ZoelaVDRqzhHxRt0pa2BjUkAXsa
 QLNEACEmXx8WaJRvLFQ==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a72d515 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=c92rfblmAAAA:8 a=pkcWlOGinYVj8a_QqHoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 1KRtReQ1WxJkXDKexlvcT_W0y5dSalw8
X-Proofpoint-ORIG-GUID: FRmeSwpJBU3oiMbXuoe0q6KfYiXbcw1h
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA0MiBTYWx0ZWRfX+rZc/7XfUjGU
 cfqfcUk/eUxyFtHdAMvx4L8cdXs+I0YwfsujvfhzzlfoYejwJXQ+bKzNCDp3+nN/LQTP9zRXerh
 EdLfT0DipOOyd6ZIBrRI3nzXbfMtcTE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050042

Hello Ian, Thank you very much for the feedback.

yes, v2 needed a rebase. I had already sent V3 patches on Monday.
Below is the link:
https://lore.kernel.org/all/20260803145958.299956-1-tshah@linux.ibm.com/.

Thanks.
Tanushree Shah


On 05/08/26 07:37, Ian Rogers wrote:
> On Sun, Aug 2, 2026 at 11:08 AM Tanushree Shah <tshah@linux.ibm.com> wrote:
>>
>> This RFC patch series introduces support for converting perf.data files
>> containing tracepoint events into trace.dat format, enabling seamless
>> visualization and analysis using KernelShark.
>>
>> ======================
>> Background and Motivation
>> ======================
>>
>> Currently, perf and trace-cmd operate as separate tracing ecosystems with
>> incompatible data formats. Users who collect tracepoint data with
>> 'perf record' cannot easily visualize it in KernelShark's graphical
>> timeline view or leverage trace-cmd's analysis capabilities.
>>
>> This creates workflow friction when users need to:
>>
>> - Visualize perf tracepoint data in KernelShark's interactive graphical
>>    timeline
>> - Share trace data between perf and trace-cmd workflows and toolchains
>> - Perform architecture-independent conversion and analysis of traces
>>
>> This conversion bridge eliminates these barriers by enabling seamless
>> data exchange between perf and trace-cmd ecosystems, allowing users to
>> choose the best tool for each analysis phase.
>>
>> ======================
>> Implementation Overview
>> ======================
>>
>> The series implements the trace.dat file format specification (version 7)
>> within perf's data conversion framework.
>>
>> **Patch 1/5: Core trace.dat Export Infrastructure**
>> Introduces util/trace-dat.c and util/trace-dat.h implementing:
>> - Per-CPU raw event buffer management (init, collect, free)
>> - Ftrace ring buffer page construction
>> - trace.dat section writers (strings, options, flyrecord sections)
>>
>> **Patch 2/5: Metadata Integration**
>> Extends util/trace-event-read.c to write trace.dat metadata during
>> perf.data
>> parsing:
>> - Initial format header (magic, version, endian, page size, compression)
>> - Section 16: HEADER INFO (header_page + header_event)
>> - Section 17: FTRACE EVENT FORMATS
>> - Section 18: EVENT FORMATS (per system/event format files)
>> - Section 19: KALLSYMS
>> - Section 21: CMDLINES
>> - Section 15: STRINGS (written last after all sections)
>>
>> **Patch 3/5: Conversion Backend**
>> Implements util/data-convert-trace.c with trace_convert__perf2dat()
>> function:
>> - Processes PERF_TYPE_TRACEPOINT samples via process_sample_event()
>> - Collects raw event data per-CPU using trace_dat__collect_cpu_event()
>> - Writes OPTIONS sections (CPUCOUNT, TRACECLOCK, metadata offsets)
>> - Writes FLYRECORD section with per-CPU ring buffer pages
>>
>> **Patch 4/5: User Interface**
>> Extends tools/perf/builtin-data.c with --to-trace-dat option:
>> - Adds command-line option for trace.dat output
>> - Mutually exclusive with --to-ctf and --to-json
>> - Calls trace_convert__perf2dat() to perform conversion
>>
>> **Patch 5/5: Shell Test**
>> Adds a shell test (tools/perf/tests/shell/) covering normal tracepoint
>> recordings, pipe mode and mixed tracepoint/non-tracepoint recording
>> conversions and --force flag behaviour.
>>
>> ======================
>> Current Implementation Details
>> ======================
>>
>> **trace.dat Format Version:**
>> The implementation currently targets trace.dat format version 7, which
>> is the stable version supported by current trace-cmd releases (v3.x).
>> This version is hardcoded to ensure compatibility with existing
>> trace-cmd and KernelShark installations. Future enhancements could add
>> version negotiation or support for newer format versions as they become
>> standardized.
>>
>> **Compression Strategy:**
>> Compression is explicitly disabled (set to NONE) in the generated
>> trace.dat files.
>> This design choice:
>> - Simplifies the initial implementation and testing
>> - Ensures maximum compatibility across trace-cmd versions
>> - Avoids external compression library dependencies
>>
>> Future work could add support for various compression algorithms (zlib,
>> zstd, lz4) with runtime selection via command-line options, significantly
>> reducing file sizes for large traces.
>>
>> ======================
>> Usage Example
>> ======================
>>
>> ```bash
>> *Record tracepoint events with perf*
>> perf record -e sched:sched_switch -e sched:sched_wakeup -a sleep 10
>>
>> *Convert to trace.dat format*
>> perf data convert --to-trace-dat=output.dat
>>
>> *Verify trace.dat structure*
>> trace-cmd dump --summary output.dat
>>
>> *Analyze with trace-cmd*
>> trace-cmd report output.dat
>>
>> *Visualize in KernelShark*
>> kernelshark output.dat
>> ```
>>
>> **Conversion Output:**
>> ```
>> [ perf data convert: Converted 'perf.data' into trace.dat format
>> 'output.dat' ]
>> [ perf data convert: Converted 2684 events ]
>> ```
>> **trace-cmd dump --summary Output:**
>> ```
>>   Tracing meta data in file output.dat:
>>          [Initial format]
>>                  7       [Version]
>>                  0       [Little endian]
>>                  8       [Bytes in a long]
>>                  65536   [Page size, bytes]
>>                  none    [Compression algorithm]
>>                          [Compression version]
>>          [buffer "", "local" clock, 65536 page size, 16 cpus, 1048576 bytes
>>      flyrecord data]
>>          [10 options]
>>          [Saved command lines, 0 bytes]
>>          [Kallsyms, 0 bytes]
>>          [Ftrace format, 0 events]
>>          [Header page, 206 bytes]
>>          [Header event, 205 bytes]
>>          [Events format, 1 systems]
>>          [9 sections]
>> ```
>> ======================
>> Testing and Verification
>> ======================
>>
>> The series has been extensively tested with:
>> - Various tracepoint events (sched, irq, syscalls, block I/O)
>> - Mixed recordings containing both tracepoint and non-tracepoint events
>>    only tracepoints converted)
>> - Verification with trace-cmd report and KernelShark visualization
>> - Memory leak testing with Valgrind (0 bytes leaked).
>> - Cross-architecture testing: v1 tested x86_64 and ppc64le. v2 adds
>>    s390 (big-endian) perf.data converted on both ppc64le
>>    (little-endian) and x86_64 (little-endian) hosts, in addition to
>>    same-arch x86_64 (LE->LE) and ppc64le (BE->BE) conversion.
>> - Pipe mode support has been tested end-to-end. (in v2)
>>
>> All generated trace.dat files successfully open in:
>> - trace-cmd report (v3.1+)
>> - KernelShark (v2.0+)
>>
>>
>> ======================
>> Next Steps
>> ======================
>>
>> We would highly appreciate reviews, comments, and feedback on:
>> - The overall architectural approach and integration points
>> - Compatibility considerations with trace-cmd ecosystem
>> - Performance characteristics for large-scale traces
>> - Additional use cases or workflow scenarios
>> - Future enhancement priorities
>>
>> ---
>> Changes in v2
>>
>> Addressing the Sashiko AI review findings on v1:
>>
>> Cross-arch correctness:
>>    - Introduce to_file_u16/u32/u64 helpers (wrapping tep_read_number())
>>      to write all multi-byte fields in the recorded machine's byte order;
>>      apply throughout metadata sections and flyrecord page/record headers
>>      (ts, commit, TIME_EXTEND, large-event data_len).
>>    - Fix flyrecord record header bit layout for big-endian files.
>>      The record header word bit layout differs by file endianness,
>>      matching kbuffer-parse.c type_len4host()/ts4host():
>>        LE: type_len in bits [4:0],   time_delta in bits [31:5]
>>        BE: type_len in bits [31:27], time_delta in bits [26:0]
>>
>> Pipe mode:
>>    - Add process_attr(), process_feature(), and process_tracing_data()
>>      callbacks required for pipe mode operation.
>>    - Defer CPU buffer initialisation until the first tracepoint sample,
>>      after process_feature()/process_tracing_data() have populated the
>>      session header. This ensures the recorded machine's CPU count is
>>      used rather than the host's - critical for cross-platform analysis.
>>
>> Format compliance:
>>    - Implement TIME_EXTEND records for timestamp deltas >27 bits to
>>      prevent silent truncation and maintain chronological ordering.
>>    - Fix large event encoding (>=29 words): use type_len=0 with a
>>      separate 32-bit length word, avoiding collision with reserved types
>>      (PADDING=29, TIME_EXTEND=30, TIME_STAMP=31).
>>    - Add bounds check rejecting records larger than a page payload before
>>      batching, preventing heap overflow in trace_dat__write_page().
>>    - Fix flyrecord section_size to exclude the 16-byte section header,
>>      matching trace.dat specification and trace-cmd behaviour.
>>
>> CLI behavior:
>>    - Fix --force flag: open with O_CREAT|O_EXCL when force is not set,
>>      failing with -EEXIST instead of silently overwriting existing files.
>>
>> Memory safety:
>>    - Fix realloc overwrite of cpu_events->events and page_records on
>>      failure: use temporary pointers, only commit on success.
>>    - Fix use-after-free/double-free in sequential page_records realloc
>>      failure: replace with malloc+memcpy+free pattern.
>>    - Fix section_size computed from before section header position.
>>    - Add NULL checks for get_tracing_file(), calloc() padding, and
>>      trace_dat_options_offset assignment on write failure.
>>    - Use goto out_free on record allocation failure to avoid leaking
>>      accumulated page_records entries.
>>    - Replace direct read() with do_read() in read_proc_kallsyms() to
>>      handle short reads correctly.
>>    - On fwrite failure, set trace_dat_write_failed and continue parsing
>>      so that perf.data processing completes normally.
>>
>> Testing (new in v2):
>>    - Add shell test covering conversion, trace-cmd dump validation,
>>      sched_switch event verification, and --force flag behaviour.
>>
>> Documentation (new in v2):
>>    - Add documentation for 'perf data convert --to-trace-dat', covering
>>      usage and supported options.
>>
>> v1: https://lore.kernel.org/linux-perf-users/20260608125951.90425-2-tshah@linux.ibm.com/
> 
> Thanks again Tanushree for pursuing this. I see on sashiko.dev that
> sashiko couldn't review the v2 patches because they failed to apply:
> https://sashiko.dev/#/log/baseline/53604/2
> The SHA of perf-tools-next that sashiko.dev was trying was
> d04ef71492fad7230d474efe33d05f4c0563d409, which corresponds to "perf
> machine: Check snprintf truncation for guest kallsyms path," added 4
> days ago:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=perf-tools-next&id=d04ef71492fad7230d474efe33d05f4c0563d409
> Could you rebase the patches so that we can benefit from the Sashiko review?
> 
> Thanks,
> Ian
> 
>> Tanushree Shah (5):
>>    perf/trace-dat: Add trace.dat export infrastructure
>>    perf/trace-event: Write trace.dat metadata sections during parsing
>>    perf data-convert: Add perf.data to trace.dat conversion backend
>>    perf data: Add --to-trace-dat option for converting perf.data
>>      tracepoint events into trace.dat format
>>    perf test: Add test validating trace.dat generated by 'perf data
>>      convert --to-trace-dat'
>>
>>
>>   tools/perf/Documentation/perf-data.txt        |   7 +
>>   tools/perf/builtin-data.c                     |  40 +-
>>   ...rf_data_converter_tracepoints_trace_dat.sh | 169 ++++
>>   tools/perf/util/Build                         |   2 +
>>   tools/perf/util/data-convert-trace.c          | 240 +++++
>>   tools/perf/util/data-convert.h                |   4 +
>>   tools/perf/util/trace-dat.c                   | 876 ++++++++++++++++++
>>   tools/perf/util/trace-dat.h                   | 113 +++
>>   tools/perf/util/trace-event-read.c            | 307 +++++-
>>   9 files changed, 1749 insertions(+), 9 deletions(-)
>>   create mode 100755 tools/perf/tests/shell/test_perf_data_converter_tracepoints_trace_dat.sh
>>   create mode 100644 tools/perf/util/data-convert-trace.c
>>   create mode 100644 tools/perf/util/trace-dat.c
>>   create mode 100644 tools/perf/util/trace-dat.h
>>
>> --
>> 2.47.3
>>



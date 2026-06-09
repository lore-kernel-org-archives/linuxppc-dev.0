Return-Path: <linuxppc-dev+bounces-22330-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3A1CD8CA4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 13:09:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZTlB56yxz2ySf;
	Tue, 09 Jun 2026 23:09:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781010566;
	cv=none; b=G8UEK7WSx7c+Y54GIRgty3K/lKFUy4/jliyU49O60sn1GHF+EygUoEAw5veG6yt43tBXs3cd1AABQmB61mN2kvpTsDmKK0xCVCJR5OYxqNXHzIXdrlQOiQ167kkj7x8SruDxiFAbG3REAe6NnPX6eTCKdf6slvsun7v+GDSceHPH9p1fBDl6mX6hQrSWBk5gVwJwodmFBjpK7QGJW2qIwzMplavTY+HgN7x5g50eESEEOZ4i4OThzBEp4VyFPrKLzoVLJdmcvv5CqoBQM0uk/wlAN4inr/yglP3Og70Dy/xT5hEOZf0nRW11aeWKMHlX5rgZ9Vtk+nYPdLA+ysVb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781010566; c=relaxed/relaxed;
	bh=p6YrsNlH0WUoHuA2M8P+ezk6RWuyUcgH3Uxv5EAFeJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mW3ujwF2eenTC+pgm0rjNltHXQysPrzr1URqItOS41JulwrHepODMejXQtX2SlFEQ7YExigcNpw4Qgr7xRg1JTUyBkR5he49DF5al1AQhe0N5cG51XxHX0ll/ugZtvPyRjLT/4BhmL9nE49+lLnDKECoi3ooLOL0MsIQIyyflFmrIsekjlFE4xk9scmgQ0OJdZ4aAwz6OBHWNCiHI8fU6SsCWPqDMLg51mNX6cNtIT3MOEZhP4YOs2Jmcb24s5DDwhqsh/Zkb8pFZQQwL7elUGGiiC4fySM8MccDc1SLLKyqGhoGKDk9bpIoGpU93CCRX33DqQbBx7P/lzjD9dWYoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kcRkg1Og; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kcRkg1Og;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZTl93PVvz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 23:09:25 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658ME5Uv3475344;
	Tue, 9 Jun 2026 13:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p6YrsN
	lH0WUoHuA2M8P+ezk6RWuyUcgH3Uxv5EAFeJs=; b=kcRkg1Ogu8Hpy/Z30RCMeH
	11NJ3Tu4jnKL7z3+78+lQnd8zk0/R2j7sWtpS/Fd79upzKJpFkDk2t/RrHsvdszV
	tsI1rSMz7pXXT9SSvlKiFQ0r6iFl2ZnfdVaa/SdTeoNNHvRm43oWz+Me6aLHsdB0
	8GsdlhNGwNdNsnatuUec2FdP+nJ7ZyVskdn2V4Ghz0bsafZGJJYkzTstfX3H405s
	XRWB1NHL/l/rtLcz8Jn97eXeEAUsM3feOQzw0R4E4KH4KO71Bu5pdrfbzZVPcoKz
	KV5QI95rlHOda4wQqCvDRN1QB79ogQuQs7tCIaPwfrcJYc1XTdUDmuakBc17Yjxg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhv86p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:09:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659D4bxk014215;
	Tue, 9 Jun 2026 13:09:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g1vks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:09:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659D9FLw21692986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 13:09:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 589665805A;
	Tue,  9 Jun 2026 13:09:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C256258054;
	Tue,  9 Jun 2026 13:09:08 +0000 (GMT)
Received: from [9.124.209.4] (unknown [9.124.209.4])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 13:09:08 +0000 (GMT)
Message-ID: <08e20eaa-d16a-45a0-8b8f-653782b6481c@linux.ibm.com>
Date: Tue, 9 Jun 2026 18:39:07 +0530
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
Subject: Re: [RFC PATCH 0/4] perf: Add perf.data tracepoint events to
 trace.dat conversion
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com,
        maddy@linux.ibm.com, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com,
        Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
References: <20260608125951.90425-2-tshah@linux.ibm.com>
 <CAP-5=fWbaEB=8niBhrUz6TLB2dgWv=kjrH8-Hn_PAmpUwqQThg@mail.gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <CAP-5=fWbaEB=8niBhrUz6TLB2dgWv=kjrH8-Hn_PAmpUwqQThg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNCBTYWx0ZWRfX2OtKS8xD3diW
 TVNvPuCjPoQUGMSTlzaHRTmied4idCw9mSnsEQ8IHVNX5e7RwRfnb/lZcgdTQVIHZZT5TUxz9z5
 MjAjlrAsEty1klxXHfII+qG06VkrwGIiHuAfDKxe8ep3W/JUZsyZkKH28th6nKugh5/G40uTxFD
 8sNRhQ3eTI4/Zu3EH8Pcq9bJimd0lITwn14VdcGlTtt9706S7TLuNdIQ3PceDRua9MsRYKpzn0P
 DszYRNKMl1zksKJLjXWqxuwWlVfeSIYgMptQy0/Hz4+c73uxDyymsM59GUiDcOCeJVB4ckKksrD
 GbPkFEVJ924V/mf1MwC0iH+JqEP3Iuw2MQxZNWKOH74JqDPey7e0+mH25gQ/fOO7qUT86k/5ypq
 E2N+nr3dsne2p2C715P0y/x0K/gffufRdJIF0D3zVWTowtfyyikV10plR/hlXWl98FxB65DSLxf
 DUJAgCNWNoRE1guHjAA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a281080 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rA2XquP34O2BbOxzJ20A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XmHAFh-fjo9LoJXnKCJHn6PQE_7MY9p4
X-Proofpoint-GUID: EdwiTZTARwwlzOna22WlpypeezTdL7qG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090124

Hello Ian,

Thanks for the review. I will fix the typo in the next version.

I agree that shell test coverage similar to the existing converter tests 
would be useful, and I plan to include that in the next revision.

I will also go through the review comments from Sashiko, validate them, 
and address the necessary fixes in the next version.

Thanks,
Tanushree Shah

On 08/06/26 20:48, Ian Rogers wrote:
> On Mon, Jun 8, 2026 at 6:00 AM Tanushree Shah <tshah@linux.ibm.com> wrote:
>>
>> This RFC patch series introduces support for converting perf.data files
>> containing tracepoint events into trace.dat format, enabling seamless
>> visualization and analysis using KerneShark.
> 
> Thanks for doing this, this is a useful feature!
> 
> nit: typo KernelShark
> 
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
>> **Patch 1/4: Core trace.dat Export Infrastructure**
>> Introduces util/trace-dat.c and util/trace-dat.h implementing:
>> - Per-CPU raw event buffer management (init, collect, free)
>> - Ftrace ring buffer page construction
>> - trace.dat section writers (strings, options, flyrecord sections)
>>
>> **Patch 2/4: Metadata Integration**
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
>> **Patch 3/4: Conversion Backend**
>> Implements util/data-convert-trace.c with trace_convert__perf2dat()
>> function:
>> - Processes PERF_TYPE_TRACEPOINT samples via process_sample_event()
>> - Collects raw event data per-CPU using trace_dat__collect_cpu_event()
>> - Writes OPTIONS sections (CPUCOUNT, TRACECLOCK, metadata offsets)
>> - Writes FLYRECORD section with per-CPU ring buffer pages
>>
>> **Patch 4/4: User Interface**
>> Extends tools/perf/builtin-data.c with --to-trace-dat option:
>> - Adds command-line option for trace.dat output
>> - Mutually exclusive with --to-ctf and --to-json
>> - Calls trace_convert__perf2dat() to perform conversion
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
>> - Memory leak testing with Valgrind (0 bytes leaked)
>> - Cross-architecture testing (x86_64, ppc64le)
> 
> It seems that some of this could be a test to give coverage of the
> feature. We have similar tests for other convertors:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/test_perf_data_converter_ctf.sh?h=perf-tools-next
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/shell/test_perf_data_converter_json.sh?h=perf-tools-next
> 
> I think Sashiko has caught some coding issues, so I'll hold off on a
> full review until the churn from Sashiko subsides.
> 
> Thanks!
> Ian
> 
>> All generated trace.dat files successfully open in:
>> - trace-cmd report (v3.1+)
>> - KernelShark (v2.0+)
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
>> Tanushree Shah (4):
>>    perf/trace-dat: Add trace.dat export infrastructure
>>    perf/trace-event: Write trace.dat metadata sections during parsing
>>    perf data-convert: Add perf.data to trace.dat conversion backend
>>    perf data: Add --to-trace-dat option for converting perf.data
>>      tracepoint events into trace.dat format
>>
>>   tools/perf/builtin-data.c            |  38 +-
>>   tools/perf/util/Build                |   2 +
>>   tools/perf/util/data-convert-trace.c | 152 ++++++
>>   tools/perf/util/data-convert.h       |   4 +
>>   tools/perf/util/trace-dat.c          | 705 +++++++++++++++++++++++++++
>>   tools/perf/util/trace-dat.h          |  79 +++
>>   tools/perf/util/trace-event-read.c   | 259 +++++++++-
>>   7 files changed, 1230 insertions(+), 9 deletions(-)
>>   create mode 100644 tools/perf/util/data-convert-trace.c
>>   create mode 100644 tools/perf/util/trace-dat.c
>>   create mode 100644 tools/perf/util/trace-dat.h
>>
>> --
>> 2.53.0
>>
> 



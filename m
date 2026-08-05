Return-Path: <linuxppc-dev+bounces-25398-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8A4C55184
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 02:07:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFDM54QByz2xnp;
	Wed, 05 Aug 2026 12:07:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::82c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785895649;
	cv=pass; b=T7v0K5Cu+cMhFWTZDzHh8Pu/KrhLHuIrbdQESrWpt/f9nJ7GdWwU6YcYkVotl0/b2+r6+A0nsmnqmu071iaPF+S4hd4VjwSVbiZ9mnmBtsLI5297tk3XWAoLl6ahNJhfzMQ6ndtymfEYKY0C3dih5Jfm1wcksTtPRoSLo4C5Nl/mQmdrejFDHPDn1aCQk0ZGJcOBkdv3DiUre2g156vJrPUaOYrNgNlqn0qbFSr4dzyxWmcmXllA+yfjLfABtltjGJLhMUgiaTN4L6LgvMBcL4+nRH5jp535kw/awRHHbhIRM+0L4uf1btYAexfSnaor48unm7TdFO1pcoG6LMxHGQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785895649; c=relaxed/relaxed;
	bh=t9PYmyQbnxhX6P6w3VmvET5K3sj0GsRwOG5w5bheb/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2VOlc1vWBsMg/pFX3R5JE1hCePuEfdMcl1XslmzzpGpu1Zpi/9q/14S6+jpo/lFvIOZj+vNeq+RAcqFAUMUEEqBtiGvnDw5Cn5WZmqM0P4BU2N9nl4yxtZZlO0nTIMsS5c/j98zEiWF1wX8+IHKMMLJk8W3wMz35jbUgOgZsZR3HCllFIB9OdFsuyaSbM4iVOlCR0TWhZRpiEThtn9Je3hM0AVQttM6GRhxKdV49p4VwVyLhJs9fy7lNVo37LXIRk+/Oduww3Hop5rrXikD/G0brWchbsQ78omb2kf0L5KpTN8F8FoUrzboUMWHz1m3fsSsvIqwXau+tu8zu1TwVQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DGw1TK8p; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DGw1TK8p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFDM20nqNz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 12:07:25 +1000 (AEST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-51c10e86e52so87421cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 19:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785895643; cv=none;
        d=google.com; s=arc-20260327;
        b=RGDWkz3gNi7TwDCd9KTC6lekXaTj1WtRaWBKXovgqUV/8RGpVwjhG5Yc4CpPq8Bcs0
         e6kxSvkCKk3O27bIBj04w6vpcTuvR7jzkJDjKk+z2jE4930T3GDZLNshN64+12iOhX/G
         3H3kLAMW0C4wTXQ+R+8k6gIzoB/2sGn5+JrUof4pRglo730n7XzSJQwA6teT+wGBVWWd
         cVI17L3SRkhcwIndcjribUSduY8zG+8LDxqT5bl5HhkAiUXJuLfsVC+lxI+oZ6rGYdxc
         CAL3HwWt7Yci49z1803Fp9dKdVSe8tOF3sabItfixWyziisjiZ9gpw09CaSRLFdp8wet
         8dKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t9PYmyQbnxhX6P6w3VmvET5K3sj0GsRwOG5w5bheb/8=;
        fh=PUCaNjnWgEJThRZDsWr0d7vOYNn2QZAj3NnBSHHAMU4=;
        b=lWxsDWbMNm8KR4XENZdo8zl2L2PbYFvZ1AQ3T1ZLMoj0ZGBl40ZBPloAuU9k94EhvQ
         1hGNa9OAEX/wkeGTnwExWBNhD5awDUYvWt7nOpfMFqAIcsEvQm0jZuIkPyDOFJ13vlzs
         6b09mhbhwh5UklLq6ZQjq09YOB9ZbqtYXYxHU9aS2dILvE2JTtaYerPOzXjAN4aq0H7n
         47/urT9RAKzzQZncvuHhEdkOh4QRoBDLZK6EXUoUS9ayHXh5LfMpst16AufVNHXhE3mF
         IFHNNw88g8W/gSDM+q/KYpGq1jYMIhtm1DdxVs5CJ0P2s4CDEiBJ2qvVBdj2CFQSK9VE
         68ZQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785895643; x=1786500443; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t9PYmyQbnxhX6P6w3VmvET5K3sj0GsRwOG5w5bheb/8=;
        b=DGw1TK8p1zKqm0iRhCmECnlXQTeI1vXmlZWOx4LlI1aSz6/3BPQ7Eh4F/0vDmisPFT
         0ayC4rqItQjBIHvgko68aA1J/IAwnNbfqUCnmkj1LwdUXK7lAKE8jkTXfg4Dmmgww4Kb
         lKJq2hZ61sRs4dWM5n/so63oYQPWs+bqvy3Zy2c2ybLxSRgCUoX0B5mDvsBpBMPz2eSj
         RoKzEDZMQb2xNeibPbaQNOGHOSFHARXG67GuZpRzywOv1Myojcl3xvOXTr4aM+7Regd2
         35sL3TUK5LbASj7VBhTJxJj0a0dNEqWUf8IFWgEmH+KXkhNAvigLu0ftYVimtJmThFDz
         LFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785895643; x=1786500443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t9PYmyQbnxhX6P6w3VmvET5K3sj0GsRwOG5w5bheb/8=;
        b=A8CYyRVWBdANK4M2O2b4CRA+dl3/W+G9j5sj4o4hBMNqb+U6aknf58iCsiVG+eiz0U
         dIfnsl1CDcgSmfoyUN6djb5KNgqiyXgTmzLV++mHM7LZ56gRRSxhMq2/g8Yvyj7ZqedM
         t6UXoli4dqFW3baZ5BUohSWFplJ4pSjg4gqLfvo8tOL5mymQhYp9BjcDGY/Ux8kIXbad
         QHwR2TIUB+ZMqDNNUkQbV719xKLF0gpG5R2vVoHnMYvLfSG0ONq9kclQoSUopd0aKh9O
         4H5sTB+brgPGxvBIKFak1gN56LNQGavYIV0sbMsi8CgZSBRQJYPMkYcDfioJZjTGUXaB
         gEXQ==
X-Forwarded-Encrypted: i=1; AHgh+RoOhIboS8/A3apYFQeQascAi9F+aFBJcrgb65V6tOkCPWbwJw8vudoR4L/kIwLm9kmI206Lu4CsXgZmUAQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymzGFMThK5sjmxVKdJGjLLuNMF1uJO5h2Rnx3JsaxzMxIAM3AT
	cZWXtMJwUHBiQBeOYrKkv469oyxLrLSNS/3Q4LGzO43/5lWNM8fKK9hzR5sLZipAgvxXOh3I+3S
	E2+O/vUDa31l6CriIg8fO9Owf17ZS2uRyNp9EfDKx
X-Gm-Gg: AR+sD101H8AJ9mCbYDzVLSk3Px+GT5yjJJbu78mJnb1I3HJHI7Uoq/rJzM/J7HcXIEw
	jyaIRFBHFEbltxhQIB3dJdF3YCgAgRlODtrZkrsFcuGu/3ynNwYatMiq3wGo4J80qAHGglKzgho
	PaQgpUZYK5udUeD02VVLFhyqCkPbOlFfuvTsC3aMsOiK9ZTAi59POk5txQ+0FUr5f1JhvYaWyUc
	5WFvIbJ6aZvc2v4P2ncO7Tp9vMOJhlJJtfb1qDmkpHOWHCXjsxFwFptHAJU4d7Z6DeQ1mGaa4pa
	NVlyC8+blU5KeekSqE75JONekpJo0LKWtAjtB0j3NHkHOY6wQoFunyXR
X-Received: by 2002:ac8:7c51:0:b0:517:6010:7c71 with SMTP id
 d75a77b69052e-52ce693a5b0mr10312871cf.4.1785895641906; Tue, 04 Aug 2026
 19:07:21 -0700 (PDT)
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
References: <20260802180801.65183-1-tshah@linux.ibm.com>
In-Reply-To: <20260802180801.65183-1-tshah@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Aug 2026 19:07:10 -0700
X-Gm-Features: AUfX_mwYjaXJrOhwgGizy9vBeAtHaoOt-f0P8k6jgU6FXsqa3x8xZnCk6rmAGVY
Message-ID: <CAP-5=fXGaMPzt8BUZKQB4QeuxrfiERAF8Kdut+uBPnXWvL82-g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] Add perf.data tracepoint events to trace.dat conversion
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, atrajeev@linux.ibm.com, hbathini@linux.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 11:08=E2=80=AFAM Tanushree Shah <tshah@linux.ibm.com=
> wrote:
>
> This RFC patch series introduces support for converting perf.data files
> containing tracepoint events into trace.dat format, enabling seamless
> visualization and analysis using KernelShark.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Background and Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Currently, perf and trace-cmd operate as separate tracing ecosystems with
> incompatible data formats. Users who collect tracepoint data with
> 'perf record' cannot easily visualize it in KernelShark's graphical
> timeline view or leverage trace-cmd's analysis capabilities.
>
> This creates workflow friction when users need to:
>
> - Visualize perf tracepoint data in KernelShark's interactive graphical
>   timeline
> - Share trace data between perf and trace-cmd workflows and toolchains
> - Perform architecture-independent conversion and analysis of traces
>
> This conversion bridge eliminates these barriers by enabling seamless
> data exchange between perf and trace-cmd ecosystems, allowing users to
> choose the best tool for each analysis phase.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Implementation Overview
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Current Implementation Details
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Usage Example
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ```bash
> *Record tracepoint events with perf*
> perf record -e sched:sched_switch -e sched:sched_wakeup -a sleep 10
>
> *Convert to trace.dat format*
> perf data convert --to-trace-dat=3Doutput.dat
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
>  Tracing meta data in file output.dat:
>         [Initial format]
>                 7       [Version]
>                 0       [Little endian]
>                 8       [Bytes in a long]
>                 65536   [Page size, bytes]
>                 none    [Compression algorithm]
>                         [Compression version]
>         [buffer "", "local" clock, 65536 page size, 16 cpus, 1048576 byte=
s
>     flyrecord data]
>         [10 options]
>         [Saved command lines, 0 bytes]
>         [Kallsyms, 0 bytes]
>         [Ftrace format, 0 events]
>         [Header page, 206 bytes]
>         [Header event, 205 bytes]
>         [Events format, 1 systems]
>         [9 sections]
> ```
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Testing and Verification
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The series has been extensively tested with:
> - Various tracepoint events (sched, irq, syscalls, block I/O)
> - Mixed recordings containing both tracepoint and non-tracepoint events
>   only tracepoints converted)
> - Verification with trace-cmd report and KernelShark visualization
> - Memory leak testing with Valgrind (0 bytes leaked).
> - Cross-architecture testing: v1 tested x86_64 and ppc64le. v2 adds
>   s390 (big-endian) perf.data converted on both ppc64le
>   (little-endian) and x86_64 (little-endian) hosts, in addition to
>   same-arch x86_64 (LE->LE) and ppc64le (BE->BE) conversion.
> - Pipe mode support has been tested end-to-end. (in v2)
>
> All generated trace.dat files successfully open in:
> - trace-cmd report (v3.1+)
> - KernelShark (v2.0+)
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Next Steps
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> We would highly appreciate reviews, comments, and feedback on:
> - The overall architectural approach and integration points
> - Compatibility considerations with trace-cmd ecosystem
> - Performance characteristics for large-scale traces
> - Additional use cases or workflow scenarios
> - Future enhancement priorities
>
> ---
> Changes in v2
>
> Addressing the Sashiko AI review findings on v1:
>
> Cross-arch correctness:
>   - Introduce to_file_u16/u32/u64 helpers (wrapping tep_read_number())
>     to write all multi-byte fields in the recorded machine's byte order;
>     apply throughout metadata sections and flyrecord page/record headers
>     (ts, commit, TIME_EXTEND, large-event data_len).
>   - Fix flyrecord record header bit layout for big-endian files.
>     The record header word bit layout differs by file endianness,
>     matching kbuffer-parse.c type_len4host()/ts4host():
>       LE: type_len in bits [4:0],   time_delta in bits [31:5]
>       BE: type_len in bits [31:27], time_delta in bits [26:0]
>
> Pipe mode:
>   - Add process_attr(), process_feature(), and process_tracing_data()
>     callbacks required for pipe mode operation.
>   - Defer CPU buffer initialisation until the first tracepoint sample,
>     after process_feature()/process_tracing_data() have populated the
>     session header. This ensures the recorded machine's CPU count is
>     used rather than the host's - critical for cross-platform analysis.
>
> Format compliance:
>   - Implement TIME_EXTEND records for timestamp deltas >27 bits to
>     prevent silent truncation and maintain chronological ordering.
>   - Fix large event encoding (>=3D29 words): use type_len=3D0 with a
>     separate 32-bit length word, avoiding collision with reserved types
>     (PADDING=3D29, TIME_EXTEND=3D30, TIME_STAMP=3D31).
>   - Add bounds check rejecting records larger than a page payload before
>     batching, preventing heap overflow in trace_dat__write_page().
>   - Fix flyrecord section_size to exclude the 16-byte section header,
>     matching trace.dat specification and trace-cmd behaviour.
>
> CLI behavior:
>   - Fix --force flag: open with O_CREAT|O_EXCL when force is not set,
>     failing with -EEXIST instead of silently overwriting existing files.
>
> Memory safety:
>   - Fix realloc overwrite of cpu_events->events and page_records on
>     failure: use temporary pointers, only commit on success.
>   - Fix use-after-free/double-free in sequential page_records realloc
>     failure: replace with malloc+memcpy+free pattern.
>   - Fix section_size computed from before section header position.
>   - Add NULL checks for get_tracing_file(), calloc() padding, and
>     trace_dat_options_offset assignment on write failure.
>   - Use goto out_free on record allocation failure to avoid leaking
>     accumulated page_records entries.
>   - Replace direct read() with do_read() in read_proc_kallsyms() to
>     handle short reads correctly.
>   - On fwrite failure, set trace_dat_write_failed and continue parsing
>     so that perf.data processing completes normally.
>
> Testing (new in v2):
>   - Add shell test covering conversion, trace-cmd dump validation,
>     sched_switch event verification, and --force flag behaviour.
>
> Documentation (new in v2):
>   - Add documentation for 'perf data convert --to-trace-dat', covering
>     usage and supported options.
>
> v1: https://lore.kernel.org/linux-perf-users/20260608125951.90425-2-tshah=
@linux.ibm.com/

Thanks again Tanushree for pursuing this. I see on sashiko.dev that
sashiko couldn't review the v2 patches because they failed to apply:
https://sashiko.dev/#/log/baseline/53604/2
The SHA of perf-tools-next that sashiko.dev was trying was
d04ef71492fad7230d474efe33d05f4c0563d409, which corresponds to "perf
machine: Check snprintf truncation for guest kallsyms path," added 4
days ago:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/?h=3Dperf-tools-next&id=3Dd04ef71492fad7230d474efe33d05f4c0563d409
Could you rebase the patches so that we can benefit from the Sashiko review=
?

Thanks,
Ian

> Tanushree Shah (5):
>   perf/trace-dat: Add trace.dat export infrastructure
>   perf/trace-event: Write trace.dat metadata sections during parsing
>   perf data-convert: Add perf.data to trace.dat conversion backend
>   perf data: Add --to-trace-dat option for converting perf.data
>     tracepoint events into trace.dat format
>   perf test: Add test validating trace.dat generated by 'perf data
>     convert --to-trace-dat'
>
>
>  tools/perf/Documentation/perf-data.txt        |   7 +
>  tools/perf/builtin-data.c                     |  40 +-
>  ...rf_data_converter_tracepoints_trace_dat.sh | 169 ++++
>  tools/perf/util/Build                         |   2 +
>  tools/perf/util/data-convert-trace.c          | 240 +++++
>  tools/perf/util/data-convert.h                |   4 +
>  tools/perf/util/trace-dat.c                   | 876 ++++++++++++++++++
>  tools/perf/util/trace-dat.h                   | 113 +++
>  tools/perf/util/trace-event-read.c            | 307 +++++-
>  9 files changed, 1749 insertions(+), 9 deletions(-)
>  create mode 100755 tools/perf/tests/shell/test_perf_data_converter_trace=
points_trace_dat.sh
>  create mode 100644 tools/perf/util/data-convert-trace.c
>  create mode 100644 tools/perf/util/trace-dat.c
>  create mode 100644 tools/perf/util/trace-dat.h
>
> --
> 2.47.3
>


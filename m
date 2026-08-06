Return-Path: <linuxppc-dev+bounces-25458-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42510C55ABF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 00:18:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFntm511Pz2yh4;
	Thu, 06 Aug 2026 10:18:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::829" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785975504;
	cv=pass; b=lcYOXGCadPXbdHjHot9UPJnIBGXpnmurCXtYGgiyziJ6EtzMeJQ3+XtKG4mRQgGli7Dz18aImef3q+zPvcYTzDKuZFwtd6rZrKM9XeCt6cKyjZzJ7r95KJkJsVIBi4ETnyXFvy+Zl9WuezNbfd00Z/dyXo9XHrR/2pgvInk3jKHhLz5vs2xIwcBYfGjPZZ5rJ23HmGiXUQg84bLsi1dv+wjsptIP0QJKeP3WwrQOiFVUwteRbw6SLaN/UTTeDT04Wpf4Yg4BN33Yqx8cI1h0x+uzwbNUC9h7ZCIPFDg+OY7G/eFnzl578mJZRtmGyqI7SPMQEYAbA4GR2w8Dbk3TAw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785975504; c=relaxed/relaxed;
	bh=axTHnxyWcvJ5jT/xJHKSS3NucnkSVrenGHjva7q9+Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuMT8TKedx9RMtkQo9DmES7v5hiPp2BeHrB02CTKjnPs5xOsiuPk1QBhIQCfIySdptsk3+g6XT8zQB3YTJ39cEOYKE0iFreEy7Y7n+Q7IVLVBKpwnEXvCBrnzfd9AX5EHcwfVkZ5jA2pAsfGFxm8qLpgEs4ErfQlljsnttKqwRy+bRTgapKx8iGnffK+6dl9UNQIkqj9jbKC0xlSnPNp1M9eH4rs3t4otFQksr2W3zWrMIJEG+W3WYw36fq8V29aZ7xGnvty25YYJk5MRFVJpjJWAsudUEUMCuEDTypfVEjit7C2LdGZtEItB1L7HuB+IYXSVe9n+6GoUtqKcVNLaQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WwYoayho; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=WwYoayho;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::829; helo=mail-qt1-x829.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFntl0rgTz2ygL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 10:18:22 +1000 (AEST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-51c01c79467so121621cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 17:18:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785975499; cv=none;
        d=google.com; s=arc-20260327;
        b=f7q2oA02Lc2ToZCAuWSOsoGK19a+L8Hvso6iXIZl809Ixl7Xq7PsotDWHpUbbVz45l
         0RjT+sqNqS9k31nVwfTp+q3r8gPnUPtb05xcZNryDyo4STbS45UD73ai6Xgf8sQROhJT
         dfkmn4ZubXTMGdn/jMvYnTCulshhYYAd0TMXmafaSF15ArKDgEnpUHxFLFTDKPJkniVZ
         wfRFxzMc1ifxRscmcqtfvHHZQ1ianaKDCucfRr9jfRQd4O6rbEhXGkrlibJ25gXAts/d
         Un4+hsLCyf2ABwEodvxl4x1Krn+dftDLvWNo2+d4mSuUeSJyr89i9cCZgz7LPb9kJ81W
         T3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=axTHnxyWcvJ5jT/xJHKSS3NucnkSVrenGHjva7q9+Ss=;
        fh=2i8U/CgLLC6bTFdWkibfmxxUeATIJ38+M1IDhSX2uaM=;
        b=Cnq/va+60Ur7tawEI5RCdKj/R1u6FmcGU1UT3zGp8EdrM8O4xIydKSJjmC+KPLqbQZ
         U8dNXsCr94V1/T5eQYxBvyEOojEkw/Sunx9DH7qgCnlftCHo7xt+yQ+dzqqIpxaPhMP5
         QwOkaoAEoPAkAg0NpSZ8g/SkyhfXofxYfD78JJZ3ISgz7HTTiBrVACYEkUkffP2E1WDa
         XHfVIfBOwypof5iFD/OJvjT1rqb/VgbSyDgmeVnUDYji4Q6aL0b7ha343xrC3yB0run7
         DtXRjjq+Y1aYkvJVpflNsVoeg8Eq0ktMS2lFpRWnC110CWVgip772Y893TN6WNGqPvEj
         Gibw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785975499; x=1786580299; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=axTHnxyWcvJ5jT/xJHKSS3NucnkSVrenGHjva7q9+Ss=;
        b=WwYoayho09pTvvoKwMXil4yqry3SMtgQ2hJ9SnNiwrH0t0Jmn7FA8PSDXi6uNN0X9M
         fKF4IS6xn3Za/kbZVKW4eksc1tb8N+QnRk8pR9etSCmdRAbJqc38lpNtyfoXu2CfmPmc
         1R81m001EYhlVsdjtAJqnHl7sWgbNb10+NDjcv9qlOkSYbcXI53Bb7C68emPv84HCNmA
         O+9+A9lXIwpj0XGLXvIRA/BTv8wntdAW3O2HP7pMjc7oSPVd9fD9DlSpvlL1xHLtTk66
         Arp30y5W2cixfafTqn36PxjB+dlNOVJznkvD/kirFr0VVjZftirEkat93pxLtZC1WNib
         nEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785975499; x=1786580299;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=axTHnxyWcvJ5jT/xJHKSS3NucnkSVrenGHjva7q9+Ss=;
        b=W2/o9vUV0PXZg+0HFEhGP6K3lzyDnfEBOI3KDztgmQfiVf7j/3N9BLFor0bdoMj5iS
         LM4jiLQyX38QG0oUW78InrB2UfGLwn1CD8mFaD7igXElq8kcbtedjMEmL0wo8XAn79b6
         1eJLjGgw//f0p4ihcxarw2pAYGCj9VQ6kO8rK8tlsoQZUeh0D2neXD0SjrxXMD3JI/9m
         UbwgEkGQ29YoyYHwwa5NaUpREWJTmGtlprl1kdt6KxJnMby7MxKVQ5u72DTaCImXsRzb
         I5QPMohLNY/VWQOl0mY88c9gYMB3czTqJntolv0Fanag7VS2IXszvMF7VDLPAUGJs/Pb
         9yyg==
X-Forwarded-Encrypted: i=1; AHgh+RpOm76JtzcXdgftZO8Msah1sZZz54sH7nJCsD3ls2WwE8kg5MqhJviPNUYpMVWNiRV1rkV0Pw5MsotJ36s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwMTaWNuBauwX64EUGQ3C3n7k/rKZPKKgzfgNQWgXtwsMAnfJWz
	MWNR4DDMG5UOYUkARMV+tAznk0F+JrlyzORzdb+zL9nFCuMNcxvfNhvdhGUCoEGSNjsNh8Fo7a4
	4nSZxCRJEYYfkxTG+hin9V+mTs9KWiVxt1eBzlbap
X-Gm-Gg: AR+sD13LYK/IKy8Cu6stXKMnszed+/Ir4EH66SWSFx2k+Mfc0JRoXaIPLGxKXmzsngF
	DFHLzhAfxrvHF9skGf5dSGkLFms67nvuOyvoWM43yFnPDkdNA1x2R9gXq8DVtGzJNDLO9wbNgEe
	IqcPbERAkkDbko93aICWbsIQaX3k/B2OcmWOmJi4Yalsp6jlC1RufyA+O6hrZO0HMKQyQOeQBPp
	HZmDWAJPN3co0Wown8ZeemywmpLxBo3s9mpS+iRIlExQwCHr8MAl7h+oqRFjKXM9StR9spF/JFO
	zUWQqii5Wld+qGV0J9BBV7gm2EyAVwCREtLTdrrudtErMw==
X-Received: by 2002:a05:622a:8e0a:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-52cfea481f8mr3636741cf.13.1785975498641; Wed, 05 Aug 2026
 17:18:18 -0700 (PDT)
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
References: <20260803145958.299956-1-tshah@linux.ibm.com>
In-Reply-To: <20260803145958.299956-1-tshah@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 17:18:07 -0700
X-Gm-Features: AUfX_mzHfg8OKrzcsskwyhFyBYUk1q6_wR-eNVoFaNypmKRKxw2qqIz2Omn6K9U
Message-ID: <CAP-5=fUN86_sd6_etczdWvjF4hZDOfUo-G30eoPRHKDOAD8tkQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] Add perf.data tracepoint events to trace.dat conversion
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, atrajeev@linux.ibm.com, hbathini@linux.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 8:00=E2=80=AFAM Tanushree Shah <tshah@linux.ibm.com>=
 wrote:
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
> Changes in v3
>
> - Rebase on latest perf-tools-next and resolve merge conflicts.
> - Drop evsel parameter from process_sample_event() following upstream
>   commit "perf tool: Remove evsel from tool APIs that pass the sample".
>
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

Still looks great, and it's getting better as you address the nits
Sashiko is raising. I look forward to testing.

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
>  tools/perf/Documentation/perf-data.txt        |   7 +
>  tools/perf/builtin-data.c                     |  43 +
>  ...rf_data_converter_tracepoints_trace_dat.sh | 169 ++++
>  tools/perf/util/Build                         |   2 +
>  tools/perf/util/data-convert-trace.c          | 241 +++++
>  tools/perf/util/data-convert.h                |   4 +
>  tools/perf/util/trace-dat.c                   | 876 ++++++++++++++++++
>  tools/perf/util/trace-dat.h                   | 113 +++
>  tools/perf/util/trace-event-read.c            | 307 +++++-
>  9 files changed, 1755 insertions(+), 7 deletions(-)
>  create mode 100755 tools/perf/tests/shell/test_perf_data_converter_trace=
points_trace_dat.sh
>  create mode 100644 tools/perf/util/data-convert-trace.c
>  create mode 100644 tools/perf/util/trace-dat.c
>  create mode 100644 tools/perf/util/trace-dat.h
>
> --
> 2.47.1
>


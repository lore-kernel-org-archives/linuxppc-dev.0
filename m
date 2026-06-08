Return-Path: <linuxppc-dev+bounces-22271-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A923CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:18:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYwfq4ygLz3bpP;
	Tue, 09 Jun 2026 01:18:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780931923;
	cv=pass; b=TI/QHW/4bLKaf8dOQWE15Lve9MUR3Wp+IMq6NDTPskONBM56JcHwkRyhIVK2OEKmQRkJWu5n8CuB08znhMgR1lHeVB7/2/sqimqR+OoVilTHYDHjmdyCNryd6boGGN+bE4myv9HAXCXxlpyXyX/YZUtNBPsZhKkvMWCKN5pBWH+xmOx/+CU8biTorJGXcnAfgT3HCGeISonAdodXxnMGvmgEQnf5Al/KDTdy8Oer8Fawm7QsLo7hAqIdQteIs0x2x3URL92yByuFkJowyMM4PKlg5kh9p6yOFopCy96vKw17ycEW+y4Jpj35j626LZgODrRXXyvQCocHOrDcG3K4dQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780931923; c=relaxed/relaxed;
	bh=TrIxg69gImaQo8ODOgcEAFRUbnotycj+tq5RTmAqHIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVXEnaJ4qY4c0jOvNQIjo3LdN+fyd/E2DtJuMcQ2RV6W/ere2VvQIeWEghYA15ftCE3+4mKCQu/+i0pP8NQGd+5EoJ7CyRohwSfhmNb+NWjUqVOc5/uCZnhzG0s58sWopLdKYk6gBcF2AsgY+kaPl29sc37bHhR8uwbqAEc2D8KswmW43cKMzThdQSVTmgk85vJ/S1wkTfEYGjKBrjqBZ+WCc0G7xysj1ApBe7fYTYkv2LEogUbjqnRWJMTFV5Q2tWxkFFbL2eociJynHXziz8Vox8c5c0Owi1M82Jn1yKfQZ2nfbhyZniPoKMzo8BNJwtWfRe1s/8E4MfjYHzHnUg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JW2eJJ9b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JW2eJJ9b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYwfn6mZjz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 01:18:41 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2c0b1a48855so392475ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 08:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780931919; cv=none;
        d=google.com; s=arc-20240605;
        b=OezptlKF6RK4ohJ6IsZIa1qcYs+8E7/uduyixXMlzLDqQQo40AkLoYdAZJR+JfSmnf
         mGTT7MMzWoSsTrpZMNtMznVHixbQrV25/7DTq4Uzbw+bimImpgydTlukSq/Hj3DT70Ha
         55537Gi6RiIJGUQmckz4MYvrQI7WNBG5Gd0zgvSvVbIaiHE7WElNUE4ogYP2r9QduaTl
         11SqqLSCGKqAhH5fqlchk86VV+eSDO3DSJZvOFlgNfmCp0jnrbt2sODs/J3nJ53wlsQW
         ZNadLQKg1lrI98XUKZ7n1LEu65HGWdXRswjyQYAd/yUptvUVlvTuJD+FTXu70VoO17HC
         a6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TrIxg69gImaQo8ODOgcEAFRUbnotycj+tq5RTmAqHIs=;
        fh=mKpLFDGGVsuQzXOTfWOc8aYCjvtg0PIUeDHUO0sUoYQ=;
        b=LY2asbtikdrjTL5VG7ezdlg/ZhHhZvyjnIISqRFtAlASDqEt2oLsM5VePohDcknbmO
         ApmLYRyC7WGASqQcUO6WU86pFYC41jrCZsGqPV6JEQGPdRb700vT3mFEwXrVmt0wNaci
         O5rQq7UZhmb+mME2uwcC/4JUHXvV7SraZi/HLtXCvF7T5J8KjE9cnoghTr0g7JelQ1Eq
         y2ypqFBFJVxkKzOLA7TYocE4fcDC4qS62rW/pVOvjHVk/xbSPUPfuwTLUaAjBobjjhSN
         Bj9B/YsGskYEA6G6BR1nGAuXmMV6QyWfrZVrxWstXzbbeVXN8nbTv9vUtSFAJOr3D8ka
         pWdw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780931919; x=1781536719; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrIxg69gImaQo8ODOgcEAFRUbnotycj+tq5RTmAqHIs=;
        b=JW2eJJ9bWRbAQZWM0mazB4oZCLsLubITP41wnGqpVcCG334fPi6mL0fLXTxmXko4Gr
         9kMQLQK+6MDOIucUy6tEG2sapdNXR5AKyXNak3hTE9IzkyXcl0/Il3/4a/jnBOaUk7ua
         1OwNSemtQ209RNxQFCTiVgOOau76JftNGgDZkaaU6ax5rxAbfhZluEoE7kQc0JFkIgGC
         NudWjjDXj3Jjr9J1tr9lfe2o5S/As18VLxD9GKm5WZV13Xx3y4gku6sWqMEpmMLZEw7Z
         +0d2dD3b2oeLsiq7u61/X33WLnU4wfWAdMk5wuZ1W+ODGLUf7ANcJrTKyRaGE1nIIyFo
         Zj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931919; x=1781536719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TrIxg69gImaQo8ODOgcEAFRUbnotycj+tq5RTmAqHIs=;
        b=MinYglwBcsiW5hBqj+iWYfA3XsSXJWdeELDK4N0bGB/su6S9sGp9svQPhSV/uos/uM
         I1mwHVl7Hql/QVoVZ+djTBvd30jrM87GLAJH1wFO/U7PQL5nPKBZaOIevNH05zj9uIPg
         agwLHloFX4p+UkIGPuK5C2i8JWVkb84uuBQ2xUvKqAq0sWChi57Y1wU1rGVxystxwBNU
         zQwkivEIBPy/1JSw8AvfVL9U5uvKTKme4YIVP3dnz3sibT+hJFu05Utyq8JJZ09Sazbn
         YbAJjx9pxrAfjcxG9q0x5K7qdR3Y16sQAJJIHYBKXPYK9UcLJjqhYMVOhg863bUPVKqD
         IuAg==
X-Forwarded-Encrypted: i=1; AFNElJ9fYODKw54tWUNj2w3r+WyKB0DhAPpVWG07RV1LpvfftsAFS6W5FMLOvqXEaVOOKSyjCWS3Af06MmlcLZs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YytW3RXY+S5tnx6VcWavtKJEtqAa30WfgJ1VIj/EgRF3qiTXNac
	VOwdzDRLCgYype7Diu8cJ9Ebf2x/ZwFffNLYiJ/wyIIE3hBJr3bv5xpR5zYmYfFVD/m4vcJuWlB
	zMGHEnXmRaOZWuXu1bEVEeP3aSG9u2U9cVdQfh6QR
X-Gm-Gg: Acq92OFxUnWetGjCH3i/wPHjNDZzlJAbgPxboD3w6yY+KeFzfZPP6JKdOspTEVB+SYS
	0Ms+gXNziSCzyEd5XUWmg9E81KczG8UMRk7bXJe/GMQ1q1QISyTMilrvtVUzPdzyGfNpzGjUKsj
	jC58vFLzTfoF/MkrXJXI9neOZdl1DIeywHuZt2ZsFVNjS8H03xLHe28zligw45i5QijI0tOobe6
	T0Y1twB9R8RCc39OBE58JKjZT0Jc5uxFeOoqdtZBEsRt5X4AmrVtDqLwHpPzCl+7tczzg1rED1K
	4hOuVehNckfoKzEqnzYVoVk1dxMeYF2Ub0Xh0V2KdJIjoNI=
X-Received: by 2002:a17:902:cf0b:b0:2c1:68ba:aa7b with SMTP id
 d9443c01a7336-2c1ebfd6b21mr4979645ad.20.1780931918327; Mon, 08 Jun 2026
 08:18:38 -0700 (PDT)
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
References: <20260608125951.90425-2-tshah@linux.ibm.com>
In-Reply-To: <20260608125951.90425-2-tshah@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 08:18:26 -0700
X-Gm-Features: AVVi8Ccbl3xR6n4R1G4IBDcL4ljsGEMowhTpXPvSlvHHfbFgDr6fr_hFW1gbXG4
Message-ID: <CAP-5=fWbaEB=8niBhrUz6TLB2dgWv=kjrH8-Hn_PAmpUwqQThg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] perf: Add perf.data tracepoint events to
 trace.dat conversion
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com, 
	Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 6:00=E2=80=AFAM Tanushree Shah <tshah@linux.ibm.com>=
 wrote:
>
> This RFC patch series introduces support for converting perf.data files
> containing tracepoint events into trace.dat format, enabling seamless
> visualization and analysis using KerneShark.

Thanks for doing this, this is a useful feature!

nit: typo KernelShark

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
> **Patch 1/4: Core trace.dat Export Infrastructure**
> Introduces util/trace-dat.c and util/trace-dat.h implementing:
> - Per-CPU raw event buffer management (init, collect, free)
> - Ftrace ring buffer page construction
> - trace.dat section writers (strings, options, flyrecord sections)
>
> **Patch 2/4: Metadata Integration**
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
> **Patch 3/4: Conversion Backend**
> Implements util/data-convert-trace.c with trace_convert__perf2dat()
> function:
> - Processes PERF_TYPE_TRACEPOINT samples via process_sample_event()
> - Collects raw event data per-CPU using trace_dat__collect_cpu_event()
> - Writes OPTIONS sections (CPUCOUNT, TRACECLOCK, metadata offsets)
> - Writes FLYRECORD section with per-CPU ring buffer pages
>
> **Patch 4/4: User Interface**
> Extends tools/perf/builtin-data.c with --to-trace-dat option:
> - Adds command-line option for trace.dat output
> - Mutually exclusive with --to-ctf and --to-json
> - Calls trace_convert__perf2dat() to perform conversion
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
> - Memory leak testing with Valgrind (0 bytes leaked)
> - Cross-architecture testing (x86_64, ppc64le)

It seems that some of this could be a test to give coverage of the
feature. We have similar tests for other convertors:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/test_perf_data_converter_ctf.sh?h=3Dperf-tool=
s-next
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/test_perf_data_converter_json.sh?h=3Dperf-too=
ls-next

I think Sashiko has caught some coding issues, so I'll hold off on a
full review until the churn from Sashiko subsides.

Thanks!
Ian

> All generated trace.dat files successfully open in:
> - trace-cmd report (v3.1+)
> - KernelShark (v2.0+)
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
> Tanushree Shah (4):
>   perf/trace-dat: Add trace.dat export infrastructure
>   perf/trace-event: Write trace.dat metadata sections during parsing
>   perf data-convert: Add perf.data to trace.dat conversion backend
>   perf data: Add --to-trace-dat option for converting perf.data
>     tracepoint events into trace.dat format
>
>  tools/perf/builtin-data.c            |  38 +-
>  tools/perf/util/Build                |   2 +
>  tools/perf/util/data-convert-trace.c | 152 ++++++
>  tools/perf/util/data-convert.h       |   4 +
>  tools/perf/util/trace-dat.c          | 705 +++++++++++++++++++++++++++
>  tools/perf/util/trace-dat.h          |  79 +++
>  tools/perf/util/trace-event-read.c   | 259 +++++++++-
>  7 files changed, 1230 insertions(+), 9 deletions(-)
>  create mode 100644 tools/perf/util/data-convert-trace.c
>  create mode 100644 tools/perf/util/trace-dat.c
>  create mode 100644 tools/perf/util/trace-dat.h
>
> --
> 2.53.0
>


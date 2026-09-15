Return-Path: <linuxppc-dev+bounces-27446-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702C1C88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 22:41:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkxpS2bCQz2xfT;
	Wed, 16 Sep 2026 08:41:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:34::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789512112;
	cv=pass; b=nCn8Nziw9orC86NYSChG1Q3HjNHbAGr/820eFTU3KGFDZ24jeQOjVV03zkoxzLHa0LtoNOmPrJCxL4zddh0z6cSlvd8CYp5MENrGfst2iDdeW3+tAjy9NkWzG2I30pekVfMrt78OB2EoQn9Iuu738/FHajXqc3SzHEuSlTXhCuKR+9HHHVleVoQu02aB8b9Yd5eqeKiK9yXkJgKw764qKB0hVctFmtxWiyBYX/aBmByy+x/QkxXj99kc3k92V8iWqt8rlJZzbqUYg1YQ0Th2z/n5epqkUu+cy5J+Mui1Cc9gOG7iZupyQTd7MBydtRmnX1FXWp5DHpNZE1cDyp/Htg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789512112; c=relaxed/relaxed;
	bh=VQ1mEqm3bUbUEwwFFwsjHm7EwizoCsIVSDgF3ajrEas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfxBgpK8jDsLwVrQV94iqzrbE6vXmd9pnhRFs9QmGNojYoaCaoxwyyfWKOFlo0LRAwbewsEpxFwDl+IiDErotu9I7P1uXP3q8MFMyJAFedgdCqwvSg90ITq8u9YzEGCnSE7Ixzld6dAOHgZ+i3xCYeOCeDabnVv+yOyAuZ+m786NTQ5CmO1I93olNcgkTCCRDC0nDFL7svWBo/tLe0+btPIUc59vXoNZ1fr11LjlOveNbcuqdnQ5SiYJ2k/rL4FqmN02o3nAdBd69b4Xw0Z1vFNEKyFDhnCTuCqvW8QzDSxrz/E0A48XMJYK3wMh2JG+0sn5VJJcBqMiPOXDWhIoLw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=B8oT6XQl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=B8oT6XQl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:34::10; helo=mail-qk2-x10.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x10.google.com (mail-qk2-x10.google.com [IPv6:2607:f8b0:4864:34::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkxpQ40Qjz2xbQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 08:41:49 +1000 (AEST)
Received: by mail-qk2-x10.google.com with SMTP id d75a77b69052e-53012819c04so48671cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 15:41:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789512107; cv=none;
        d=google.com; s=arc-20260327;
        b=n7TTru8XdcaOaaHJmPAJ5NMUHTBbBE3+n5E/iIEgrf9rsELVb4aLuzdTJBw4B86eTk
         Nv/nw+XqXhIKKAuOuaWFiM1a1hQSyJE0t6hHbxTNoTcu+FEu1/qmMazuRJcO68h7Kbau
         mZtbI2nQS4y+13sTLqWva/L1gHD4tvZV4AmIesImZnXXFhx47ZCA1vCBvBnRqUoe9lYs
         oHHiUdMHjVhvEu7zl6WhvFnWlp85ephpvWoIPkny2vlSsYgaAVJ9FnGnVcc4H2vUP2xZ
         kUHJpQIlROmyIcODELvklOcZpe1pgdrtZ9TNMUDS+4w2Qiol/izoe9elTYZllS569KHP
         XEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQ1mEqm3bUbUEwwFFwsjHm7EwizoCsIVSDgF3ajrEas=;
        fh=375IzL5tyOkmUHGriSVRZGh9qJD1Za53gfc23si7m7M=;
        b=Q+DnDhKcv5dBKBmIWM6GpQkKvzOejFyY24ukOdYDMSbyIfFpSdZIQHYu01Mw2AC4Da
         yCGIBRez2UFzpnU3YphCg2E0NZP65hawEekL4xcuYXXpB+JMDa0XzdLb5abmcBffoVPh
         leyCngP+yqdYw3c3V+OM4tTphQt3YgF7koQ3P5bipwSdSYSCDKccg3l4MV7p5dSZliHX
         W4eZNqazX3NCGq3gtNg99pa19ycw6uFTJAVu8kBOh6iPaSkYoDj0dYFrG3tGlAF59ezG
         x4fakag1AkKFRoOQ6QknUa5EtXuT9FUKtmbNfy3xd2/Llk9oah9YX4IBtGTGDL40OrUd
         AwTA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789512107; x=1790116907; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQ1mEqm3bUbUEwwFFwsjHm7EwizoCsIVSDgF3ajrEas=;
        b=B8oT6XQl0Vn7WW/Z+RfYzcw05RBEZ59ixr0DlTAmHO1Ovy4XB8fRDSs2gh07Jsg1+6
         fB57GOR0/sF9sAiy4T8de+fzKcF2GbsJdKHLShkOaKNGyafB9j6/JJwH0L9e0YUntotp
         R1cumAXNTxsdZeTj014aFez9SwCExyTsvaUJ+npzVEBXtl1PzbQieigQK8Cb5JaNtBBs
         5WL77Yw62zNmsO5/QqSX9/DqD369jWWw8Vuk4fO1qB7C31gqO584tEW3di1cctZl+oYN
         k7gq3SwBOp6GVB1wdFmAY4RNuK+aFF/NzXD5KLxU8+Eu2FFMBl5UynjTSZayh2+jdztk
         nTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512107; x=1790116907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQ1mEqm3bUbUEwwFFwsjHm7EwizoCsIVSDgF3ajrEas=;
        b=nqayygC4An62aGwV2AYNGfgpQdyCdCIiFjN3V9Z+6puQNzJknZp4eE3vPsikRiTTx1
         MHhOVQgtZHq2Udu7bDdveN2viOVg6WvCZNIuQ0wfvCF79/NapPibwHwW48Qnko9IGNMM
         3QXyOJaQ9bOJT66AaZ7cTvWfWJafrJGzKTWe4JKUtv3rI7lxEQ/IeoTSxEtk9v7zrBrY
         ubO6hYgoCex8Eyl6w1sxezOjjwiQa75mzVNofc94zHIWm1o/EW7aI+rpCZ4FBzrrw4X5
         Wr0B/zgGOHUqOe8jSDmFJRakDF0mo17NhE4AtcjdYhEJoCXEAuIHlwOkjAEHgVkNKylo
         vOUw==
X-Forwarded-Encrypted: i=1; AKwUvBxS4MgsUApCAwkl6wvfEWeHv/80EBQ0CGi5g7IxDmNBE8F2nFN5lcpIblvqWk25dXw/bFGQMiJMQK8EbwQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n/VdJd+2C99K2U5gA5Z5CwSRND/z+WO5KqMjGbTuerPYjxanrc
	qStm085mSclnvuzavmLqVG+HOg/3IqkmxU1dFtQUarNUvDHbWVKx4Lbsl1iWNZncwG6IX40OhZn
	kT0uqNXnpxCl1ZQHeJZ/2UIevEWVKcryujDA9QI5B
X-Gm-Gg: AYBFou2E2FrnZZgXYi1nSbwlZI8Y7DleBYaYJ1TWzkKXtFxisFx8Qlv5ZEDatxGk1JX
	XfiOenqfp1guZJIwLu6yHmchMvTWeEjwPgrvggMTP2SociPRS7vAJk2EDbh5vm0YFhV0o+nFCvh
	uC/t+usaZD/dfcOIGPskjpSoHrc6IKmNdHZqOJHLz7dtdsVCidkVlblRLmYc6jhHqPKLoHfawWy
	mlMASy9SxKVnWzGQDt/Eb5004g67TmtiUYetzZQC6Fq9e02B+2wPwkdjUP2tA4jN59N5jNAlFYA
	22fYZlNCRmsXOrm+bRZ6q0sMlV54YDT+DQrE2Nx6WQjHLHnSnRm20Mqj8dhHou0a4eK6iwzHjmT
	GJFvTTivo1Q==
X-Received: by 2002:a05:622a:580e:b0:52f:4a75:f840 with SMTP id
 d75a77b69052e-5327f5e8dedmr1378711cf.9.1789512106116; Tue, 15 Sep 2026
 15:41:46 -0700 (PDT)
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
References: <20260807144135.2607-1-atrajeev@linux.ibm.com> <083A4990-6158-4C25-B29C-78A8AF9ADCF3@linux.ibm.com>
In-Reply-To: <083A4990-6158-4C25-B29C-78A8AF9ADCF3@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 15:41:34 -0700
X-Gm-Features: AcwNN1UEG7pVwjSnb00JbKXR74IHKWDgQf1sITA6eKr5Av6Gb5msdaS6bHv88Y4
Message-ID: <CAP-5=fX-sUhf06gSoib1S5y-fFTg=dNmXkNXJ-LEtgj3fO4KbQ@mail.gmail.com>
Subject: Re: [PATCH V5 0/6] tools/perf: Add powerpc HTM auxtrace support
To: Athira Rajeev <atrajeev@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	tejas05@linux.ibm.com, tshah@linux.ibm.com, venkat88@linux.ibm.com, 
	usha.r2@ibm.com, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 10:11=E2=80=AFPM Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
>
>
>
> > On 7 Aug 2026, at 8:11=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ibm.co=
m> wrote:
> >
> > Overview:
> > This series adds perf tool support for capturing and processing Hardwar=
e
> > Trace Macro (HTM) trace data on POWER systems.  HTM exposes raw bus-tra=
ce
> > data via the H_HTM hypervisor call.  The kernel-side HTM PMU driver
> > (submitted separately) streams this data into perf AUX buffers and emit=
s
> > memory configuration as PERF_SAMPLE_RAW records.
> >
> > This series wires up the record and report sides in the perf tool so th=
at
> > 'perf record' collects HTM data and 'perf report' writes the trace and
> > memory configuration to files ready for post-processing with htmdecode.
> >
>
> Hi All,
>
> I am currently working on addressing Sashiko's review comments for V5 of =
the patch series.
> Before I proceed with posting V6, requesting for any feedback or suggesti=
ons that I should incorporate in V6, apart from Sashiko's comments.

Hi Athira,

Did you get what you needed for V6? I see Adrian's reviews.

Thanks,
Ian

> Thanks
> Athira
>
> > Patch overview:
> > Patch 1 refactors the existing powerpc auxtrace dispatch.  All VPA-DTL
> > recording logic is moved from arch/powerpc/util/auxtrace.c into its own
> > file, arch/powerpc/util/vpa-dtl.c, leaving auxtrace_record__init() as a
> > thin per-PMU dispatcher.  This is a prerequisite for adding the HTM
> > recording path cleanly.
> >
> > Patch 2 adds the HTM recording path (arch/powerpc/util/htm.c and
> > util/powerpc-htm.h).  htm_recording_init() sets up the auxtrace_record
> > callbacks.  htm_info_fill() stores the PMU type and a (cpu, attr.config=
)
> > pair for each htm evsel into the PERF_RECORD_AUXTRACE_INFO priv[] area.
> > The decode side reads these back to map each AUX buffer to its
> > (node, chip, core) target using event->auxtrace.cpu.  PERF_SAMPLE_RAW i=
s
> > also enabled here so that memory configuration records are captured
> > alongside the AUX stream.
> >
> > Patch 3 adds a generic weak arch_perf_record__need_read() hook in
> > builtin-record.c.  When the hook returns non-zero, perf record performs
> > an extra mmap-read pass before disabling events.  The drain loop runs
> > until the hook returns 0 or no forward progress is made, then the event=
s
> > are disabled and closed normally.
> >
> > Patch 4 implements arch_perf_record__need_read() for powerpc.  It reads
> > event->count for all open htm evsels via perf_evsel__read() and
> > accumulates the values.  The kernel driver sets this count to the numbe=
r
> > of 128-byte HTM trace records written on a successful dump, 1 when the
> > AUX buffer is temporarily full but the hypervisor stream is intact, and
> > 0 once the stream is exhausted or a hard error occurs.  A non-zero tota=
l
> > causes the recording loop to perform another read pass.
> >
> > Patch 5 adds PERF_AUXTRACE_POWERPC_HTM to the auxtrace_type enum and
> > wires the dispatch in perf_event__process_auxtrace_info().  It also
> > amends htm_info_fill() to set auxtrace_info->type now that the constant
> > is available.
> >
> > Patch 6 adds the full HTM decode path in util/powerpc-htm.c.
> > powerpc_htm_process_auxtrace_info() reads the (cpu, config) pairs from
> > priv[] and builds a cpu_configs[] lookup table.  As each
> > PERF_RECORD_AUXTRACE event arrives, process_auxtrace_event() maps it to
> > the correct target and writes the data to htm.bin.nX.pX.cX.tX immediate=
ly.
> > PERF_RECORD_SAMPLE RAW records are written to translation.nX.pX.cX.tX b=
y
> > process_event().  Per-run first-write tracking (htm_target_seen) ensure=
s
> > O_TRUNC on the first write and O_APPEND on subsequent writes.
> >
> > Patches not included in V2:
> > Three patches present in V1 are intentionally dropped from this series
> > and will be submitted as a follow-on once the core infrastructure gets
> > integrated:
> >
> >  - htmdecode integration: V1 patch 6 invoked the external htmdecode
> >    tool via fork/exec after writing htm.bin.* to decode the raw
> >    bus-trace data in-process.  This is deferred because the interface
> >    between perf and an external decode tool needs more discussion.
> >
> >  - Physical-to-logical address mapping: V1 patch 7 read the current
> >    partition ID from /proc/powerpc/lparcfg, parsed the translation.*
> >    memory map entries, and mapped physical addresses in the decoded
> >    trace to logical addresses within the LPAR.
> >
> >  - Synthetic sample generation: V1 patches 8 and 9 created a
> >    PERF_TYPE_SYNTH event named "htm", injected synthetic perf samples
> >    with the translated logical addresses as sample IP, and wrote a
> >    separate .out.l file with logical addresses alongside the decoded
> >    trace.  The appropriate abstraction for synthetic HTM samples in the
> >    perf tool requires further discussion.
> >
> > Usage example:
> > Collect HTM trace data from a single chip target:
> >
> >  # perf record -C 9 -m,256 \
> >      -e htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=3D1/ sleep 3
> >  [ perf record: Woken up 1 times to write data ]
> >  [ perf record: Captured and wrote 256.277 MB perf.data ]
> >
> >  # perf report
> >
> > Output files written by perf report:
> >
> >  htm.bin.n0.p2.c0.t1       raw HTM bus-trace data
> >  translation.n0.p2.c0.t1   memory configuration records
> >
> > Multiple targets can be collected simultaneously:
> >
> >  # perf record -m,256 \
> >      -e htm/nodalchipindex=3D2,nodeindex=3D0,htm_type=3D1,cpu=3D8/ \
> >      -e htm/nodalchipindex=3D1,nodeindex=3D0,htm_type=3D1,cpu=3D9/ \
> >      -a sleep 10
> >
> > Testing:
> > Tested on POWER11.  Both htm.bin.* and translation.* files are produced
> > correctly for single and dual target collection.
> >
> > Note: Link to kernel patches:
> > https://lore.kernel.org/linuxppc-dev/20260807143734.1224-1-atrajeev@lin=
ux.ibm.com/T/#t
> >
> > Athira Rajeev (6):
> >  tools/perf: Move powerpc VPA-DTL auxtrace init into a separate file
> >  tools/perf: Add AUXTRACE recording support for powerpc HTM
> >  tools/perf: Add arch hook to drain remaining data before event close
> >  tools/perf: Add powerpc callback support for
> >    arch_perf_record__need_read
> >  tools/perf: Add powerpc HTM auxtrace event processing support
> >  tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE
> >    records
> >
> > tools/perf/arch/powerpc/util/Build      |   2 +
> > tools/perf/arch/powerpc/util/auxtrace.c |  98 ++----
> > tools/perf/arch/powerpc/util/evsel.c    |  77 ++++
> > tools/perf/arch/powerpc/util/htm.c      | 185 ++++++++++
> > tools/perf/arch/powerpc/util/vpa-dtl.c  |  96 +++++
> > tools/perf/builtin-record.c             |  65 ++++
> > tools/perf/util/Build                   |   1 +
> > tools/perf/util/auxtrace.c              |   4 +
> > tools/perf/util/auxtrace.h              |   1 +
> > tools/perf/util/powerpc-htm.c           | 447 ++++++++++++++++++++++++
> > tools/perf/util/powerpc-htm.h           |  43 +++
> > tools/perf/util/powerpc-vpadtl.h        |   3 +
> > tools/perf/util/record.h                |   4 +
> > 13 files changed, 954 insertions(+), 72 deletions(-)
> > create mode 100644 tools/perf/arch/powerpc/util/htm.c
> > create mode 100644 tools/perf/arch/powerpc/util/vpa-dtl.c
> > create mode 100644 tools/perf/util/powerpc-htm.c
> > create mode 100644 tools/perf/util/powerpc-htm.h
> >
> > --
> > 2.53.0
> >
>


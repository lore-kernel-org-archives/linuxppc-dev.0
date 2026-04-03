Return-Path: <linuxppc-dev+bounces-19280-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F96BE85379
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 15:39:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnNFF5Vq1z2yjV;
	Sat, 04 Apr 2026 02:39:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775230769;
	cv=pass; b=RQ8+OYF7s8EdgaRs7z5qB6yuOU9hP2qjbtn0JX4WIMfsbGUNsZ2WEEYUwDbVkrgO3NTsTU7a2x7dLw9CExui+Oo/DGwkJSmqwCbtIpGR38okW7HBZIpvbzwQXWDsdZ/6zpxtGpjowKhS5iqoutX2hF5tTGAoar1ROBOYFSxdgLcPPYmrOZYIMx42n2CfYjyUUDBxO3R8mfiehuZ2XJKZzX37eD+dV7IW02G+AaqM0m/UcTGSVZpTAzwcyLmQhEQuThYcd1+9+AjdLNbvSE8DcBXmHLPDcvC4QoRbsYOawNxnQdMixpa3M3EeFh6mrfXw8kVYXJgo1mVzK9lBa16Cig==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775230769; c=relaxed/relaxed;
	bh=FhI+efbDFLiEonazJjgaQH+AZ3snthfw8f9lU+HywFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoHauLW4VLmpAI79oH1OshADjJtSpa3rMxtS3b5PifEBc61PucWr5yHeQnnFhFmqb6Hhb2+awB+iMUDGPJ3q0Cclt52FBhCZJ6ITINwid9uYD/R6y0JkQP5UbhhnOBefaYdqWk4ziBua5FOddF8pK8Vrpn6m+6RVj0/fs8fw/6viJOsdU8zmsy5MNXri2AtWwcsno3J2d05UJjevSdAj4PK4Rn7yM6JQ3kyieTuDjUMZ361abYvW76Gq25W2srLj/zDkrRspHeq1mTtNxTzRYHbr1cy04hCMQZkJfSNFe4Ol2vTk4QQFgaPBv++mck4Y+IoOvrdYtwXA+isoSjZ2Pw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XSsFnRa4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XSsFnRa4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnNFC5ms4z2yhX
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 02:39:27 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2b2591757fbso96275ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 08:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775230765; cv=none;
        d=google.com; s=arc-20240605;
        b=B4k8V9+2FyISKXFYKq9iFgbkAuzHOyxaRzPYxcGPNqxLlkxwuik7NQ4uxnptT7pmPt
         2ZOJloM3/5aomG+ZKjYeGVW2XppmbGJ7C12eA9K7yaUMPpFbAE3QXL1tjb14KvL2JHDE
         aNGbhXHV1+b0Snvf3ue1uR0Bb8vU2Nhl9v8kwoK7iBnQALyvfr2M7vNjWoS4oQVrsWBN
         1VBMc/3IlwpHFkZM7dp0ee+9m5SctzTJlLrbYcS0s0XjZbiteOZH+m9FAY8+kehNY9pK
         P46XOsla2+OYzDsDLET5FbODRhP1HxU5XwEwBmrx6il3vJHZ+GA/OOmEwZ9vP2C9gxJm
         YctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FhI+efbDFLiEonazJjgaQH+AZ3snthfw8f9lU+HywFw=;
        fh=fJW+gxXLkxHiAKRCQV+FD9qyAkWrEfzP/99zbf3/eyQ=;
        b=V09jiQdfTng7yXtf1SjQKVBUfoIech97aY7nYM3KYvGj+9/SO44w5FQ3mXXlN73vwO
         dlSRmgLwGnAWXgKrHykkYE46tz9qw670CV6AH50LFcaWtYHokbBmmR9kHq8olslxMCH3
         PqKZMIyIMiP0p8aOSPo5r+rc+9skDI09g5CC7DCf7mrxyijvxp+oJebqyJSbYBwAg7yW
         q3yIQsK28VQbNoKevcrsJcqzkIbjCH5GkVDsjjaSEaCaRl4CGfDdAfNuHtQPceSO0Dtx
         wgANOFKkWiYoHEvoIBVPfACdw1bIeTZ5nRuTPf1boN/cUYQobY+iwFXOdbKrxGMiIZio
         Gn0Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775230765; x=1775835565; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhI+efbDFLiEonazJjgaQH+AZ3snthfw8f9lU+HywFw=;
        b=XSsFnRa46CYAEJRaSAOTOkIZug2mDE3a3OvnfA4XABh5f9Tf47p5dew40PBnkaY4eP
         TP9DYWwuQdVHZC3guI7YgUqjmdjOFO4pyP/QxpnLMvCOgZOffW7wm9V81C4PW6ixVqCB
         sGzcdr5gTkyGSNqjPEeASA4pEFPXxXBV9bPJYdF1RUFmAXtrJkggQwnUwUGE7/13W5Y3
         KPMVtrTrd69jL+rdciNj1C4jvIbU1SAAh3ejm1bJAkexA1Kmtf6QSgWBK6kioTCCabZ4
         eVmiIge/1sWhM0ah/JFPcjEs67PCgu7hfnqA1aGYrSuHlOKYOPaZWLuWDQHK8ZcX5g5G
         owOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230765; x=1775835565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FhI+efbDFLiEonazJjgaQH+AZ3snthfw8f9lU+HywFw=;
        b=Qls7yPwevdKt62BnCcwTwe3j3PVevymHgh5OSd+iV8fnW5NkVg3l//SflkWTQyXFDc
         SDy4XrOkMgiIbAhva7dutgM6gK42JB9D2pGlgnH2SNTLVNrZcKeKkIe9+IHH7NAg9OIk
         GVXQxxyF4dJhgtSqvg6W6p9oritZDM1Flezu5P8GMJq2tVRBux5ns0TMX1Fp1SWdZnMB
         6m1BZVgq9qTdclHeANzLurF5/T3Pm6BQjc6mKJmEG5OepdBS8jMJvmTAnyMx5RQIRRzM
         MMY0Pl/Hf4bg7gj2wOxxqGQrQ4P+flDpfMabnYPhSejJzF22bTrCMfuK5zHZ6TeW2j8u
         GzCw==
X-Forwarded-Encrypted: i=1; AJvYcCUxh293SazhMyI/VWXOBQMbC4NHtgsfxkaOS/oX895RySxN82DTFr+TJGo8lG9Bjvdku480oc90yZ1acU0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQh8cBZmFgyT4JxeAAJKermzGbB/BkjdtjW8VFJd6q5gzs2mwy
	0fh/VA+Xj7OTtICt5wY0uAofh4xRTRsa+2c6988wEAqmDfcSDYxIj1tUIyG85x7SMyqtoW0x1lD
	hKzBYZZRz3bpmZWd56WU85IQowpFgS2uhPSzU7OUi
X-Gm-Gg: AeBDiesCrWIkxTzz5VqBT2cBoLqQF1iN3dx6SJC1cerrrJOtV+jh/J4YyUL0w0yl27E
	gCJnQUuQEh4IZM09UeYqkRAY+2j080IpUAfNx2eSYeCDNFzYtw59i4RYCbtDzyO7eL/zMSs8w4+
	1gddXkKvilZWirQrBmvI9bPjvL28XtFHy48IyQZQm+Ddt9NHFW4U77VypQEflA6OXcDG/esqwBM
	td3jy64RYsjzsuhXD4teDoEYIjMnzNsOpw+Veu+RRXQrKWV0RvEAIFYdYtmpFGlNGkLrcpopbCp
	FoC9VWeA
X-Received: by 2002:a17:903:22d1:b0:2ae:7fa2:6bda with SMTP id
 d9443c01a7336-2b283f049edmr1927905ad.1.1775230764064; Fri, 03 Apr 2026
 08:39:24 -0700 (PDT)
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
References: <20260315105751.86835-1-atrajeev@linux.ibm.com>
 <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com> <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
 <ec33d914a3eb3f8cc1a0ad16bf877ff7284072c9.camel@intel.com> <cf702c86-7dea-44af-8dd2-0c27e19da1b5@linux.intel.com>
In-Reply-To: <cf702c86-7dea-44af-8dd2-0c27e19da1b5@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Apr 2026 08:39:10 -0700
X-Gm-Features: AQROBzA-FV3lZ8eXXN_-IIy5A-zCuhgDBacFdsKJ5rl_ORv9FOTKguhRMX3ukUY
Message-ID: <CAP-5=fWR6v7kKSMVD+ANwMTmOdc4zKLEVY+9tNR5n+kq0F=Mkg@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, "Falcon, Thomas" <thomas.falcon@intel.com>, 
	"Kleen, Andi" <andi.kleen@intel.com>
Cc: "atrajeev@linux.ibm.com" <atrajeev@linux.ibm.com>, 
	"venkat88@linux.ibm.com" <venkat88@linux.ibm.com>, "Shivani.Nittor@ibm.com" <Shivani.Nittor@ibm.com>, 
	"tmricht@linux.ibm.com" <tmricht@linux.ibm.com>, 
	"hbathini@linux.vnet.ibm.com" <hbathini@linux.vnet.ibm.com>, "mpetlan@redhat.com" <mpetlan@redhat.com>, 
	"Tanushree.Shah@ibm.com" <Tanushree.Shah@ibm.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"maddy@linux.ibm.com" <maddy@linux.ibm.com>, "Chen, Zide" <zide.chen@intel.com>, 
	"vmolnaro@redhat.com" <vmolnaro@redhat.com>, "Tejas.Manhas1@ibm.com" <Tejas.Manhas1@ibm.com>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "acme@kernel.org" <acme@kernel.org>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "Mi, Dapeng1" <dapeng1.mi@intel.com>, 
	"namhyung@kernel.org" <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 12:36=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 4/3/2026 1:32 AM, Falcon, Thomas wrote:
> > On Wed, 2026-04-01 at 13:40 -0700, Ian Rogers wrote:
> >> On Mon, Mar 23, 2026 at 3:40=E2=80=AFAM Venkat <venkat88@linux.ibm.com=
>
> >> wrote:
> >>>
> >>>
> >>>> On 15 Mar 2026, at 4:27=E2=80=AFPM, Athira Rajeev
> >>>> <atrajeev@linux.ibm.com> wrote:
> >>>>
> >>>> Currently in "perf all PMU test", for "perf stat -e <event>
> >>>> true",
> >>>> below checks are done:
> >>>> - if return code is zero, look for "not supported" to decide pass
> >>>>  scenario
> >>>> - check for "not supported" to ignore the event
> >>>> - looks for "No permission to enable" to skip the event.
> >>>> - If output has "Bad event name", fail the test.
> >>>> - Use "Access to performance monitoring and observability
> >>>> operations is
> >>>>  limited." to ignore fail due to access limitations
> >>>>
> >>>> If we failed to see event and it is supported, retries with
> >>>> longer
> >>>> workload "perf bench internals synthesize".
> >>>> - Here if output has <event>, the test is a pass.
> >>>>
> >>>> Snippet of code check:
> >>>>  ```
> >>>>  output=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> >>>>  if echo "$output" | grep -q "$p"
> >>>>  ```
> >>>> - if output doesn't have event printed in logs, considers it
> >>>> fail.
> >>>>
> >>>> But this results in false pass for events in some cases.
> >>>> Example, if perf stat fails as below:
> >>>>
> >>>> # ./perf stat -e pmu/event/  true
> >>>> event syntax error: 'pmu/event/'
> >>>>                     \___ Bad event or PMU
> >>>>
> >>>> Unable to find PMU or event on a PMU of 'pmu'
> >>>> Run 'perf list' for a list of valid events
> >>>>
> >>>>  Usage: perf stat [<options>] [<command>]
> >>>>
> >>>>    -e, --event <event>   event selector. use 'perf list' to list
> >>>> available events
> >>>> # echo $?
> >>>> 129
> >>>>
> >>>> Since this has non-zero return code and doesn't have the
> >>>> fail strings being checked in the test, it will enter check using
> >>>> longer workload. and since the output fail log has event, it
> >>>> declares test as "supported".
> >>>>
> >>>> Since all the fail strings can't be added in the check, update
> >>>> the testcase to check return code before proceeding to longer
> >>>> workload run.
> >>>>
> >>>> Another missing scenario is when system wide monitoring is
> >>>> supported
> >>>> example:
> >>>> # ./perf stat -e pmu/event/ true
> >>>> Error:
> >>>> No supported events found.
> >>>>  Unsupported event (pmu/event/H) in per-thread mode, enable
> >>>> system wide with '-a'.
> >>>>
> >>>> Update testcase to check with "perf stat -a -e $p" as well
> >>>>
> >>>> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> >>>> ---
> >>> Tested this patch.
> >>>
> >>>
> >>> With this patch:
> >>>
> >>> Testing hv_24x7/CPM_ADJUNCT_INST/ -- perf stat failed with non-zero
> >>> return code
> >>> Testing hv_24x7/CPM_ADJUNCT_PCYC/ -- perf stat failed with non-zero
> >>> return code
> >>>
> >>>
> >>>
> >>> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >> Testing on an Intel Alderlake the test is now failing:
> >> ```
> >> ...
> >> Testing offcore_requests_outstanding.l3_miss_demand_data_rd --
> >> supported
> >> Testing ocr.full_streaming_wr.any_response -- perf stat failed with
> >> non-zero return code
> >> Testing ocr.partial_streaming_wr.any_response -- perf stat failed
> >> with
> >> non-zero return code
> >> Testing ocr.streaming_wr.any_response -- supported
> >> ...
> >> ```
> >>
> >> Running `perf stat` manually reveals an issue with the event:
> >> ```
> >> $ sudo perf stat -vv -e ocr.full_streaming_wr.any_response -a sleep
> >> 1
> >> Using CPUID GenuineIntel-6-B7-1
> >> Attempt to add: cpu_atom/ocr.full_streaming_wr.any_response/
> >> ..after resolving event:
> >> cpu_atom/event=3D0xb7,period=3D0x186a3,umask=3D0x1,offcore_rsp=3D0x800=
0000100
> >> 00/
> >> ocr.full_streaming_wr.any_response ->
> >> cpu_atom/ocr.full_streaming_wr.any_response/
> >> Control descriptor is not initialized
> >> ------------------------------------------------------------
> >> perf_event_attr:
> >>  type                             10 (cpu_atom)
> >>  size                             144
> >> ------------------------------------------------------------
> >> perf_event_attr:
> >>  type                             0 (PERF_TYPE_HARDWARE)
> >>  config                           0xa00000000
> >> (cpu_atom/PERF_COUNT_HW_CPU_CYCLES/)
> >>  disabled                         1
> >> ------------------------------------------------------------
> >> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 3
> >> ------------------------------------------------------------
> >> perf_event_attr:
> >>  type                             0 (PERF_TYPE_HARDWARE)
> >>  config                           0x400000000
> >> (cpu_core/PERF_COUNT_HW_CPU_CYCLES/)
> >>  disabled                         1
> >> ------------------------------------------------------------
> >> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 3
> >>  config                           0x1b7
> >> (ocr.demand_data_rd.l3_hit.snoop_hit_no_fwd)
> >>  sample_type                      IDENTIFIER
> >>  read_format
> >> TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
> >>  disabled                         1
> >>  inherit                          1
> >>  { bp_addr, config1 }             0x800000010000
> >> ------------------------------------------------------------
> >> sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8
> >> sys_perf_event_open failed, error -22
> >> switching off deferred callchain support
> >> Warning:
> >> ocr.full_streaming_wr.any_response event is not supported by the
> >> kernel.
> >> The sys_perf_event_open() syscall failed for event
> >> (ocr.full_streaming_wr.any_response): Invalid argument
> >> "dmesg | grep -i perf" may provide additional information.
> >>
> >> Error:
> >> No supported events found.
> >> The sys_perf_event_open() syscall failed for event
> >> (ocr.full_streaming_wr.any_response): Invalid argument
> >> "dmesg | grep -i perf" may provide additional information.
> >> ```
> >>
> >> This looks like a latent Intel cpu_atom PMU bug. Thomas, wdyt?
>
> Hmm, it looks the error is caused by the invalid bitmask of OFFCORE_RSP_x
> MSRs. Currently the valid bitmask of OFFCORE_RSP_x MSR is set to
> 0x3fffffffff in intel_grt_extra_regs[], while the msr value is set
> 0x800000010000 for the ocr.full_streaming_wr.any_response event. The bit =
47
> is recognized an invalid bit and then abort the event creation.
>
> Base on the description "Table 21-56. MSR_OFFCORE_RSPx Request Type
> Definition" in SDM, bit 47 should be a valid bit now. Suppose bit 47 shou=
ld
> not be a valid bit when adding the ADL PMU support, but it's updated and
> becomes valid later.
>
> Along with the constant updates of perf event lists
> (https://github.com/intel/perfmon), we have noticed there are mismatches
> more or less between the driver hardcoded events and perfmon event list.
> Currently we are summarizing the mismatches. Once these mismatches are
> finalized. we would submit a patchset to fix these mismatches.

That's great, if it takes too long perhaps we could just remove the
events for now.

Thanks,
Ian

> Thanks.
>
> > +Dapeng, Zide, Andi
> >
> > Thanks,
> > Tom
> >
> >> Thanks,
> >> Ian
> >>
> >>> Regards,
> >>> Venkat.
> >>>
> >>>
> >>>
> >>>> tools/perf/tests/shell/stat_all_pmu.sh | 20 ++++++++++++++++++++
> >>>> 1 file changed, 20 insertions(+)
> >>>>
> >>>> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh
> >>>> b/tools/perf/tests/shell/stat_all_pmu.sh
> >>>> index 9c466c0efa85..6c4d59cbfa5f 100755
> >>>> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> >>>> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> >>>> @@ -53,6 +53,26 @@ do
> >>>>     continue
> >>>>   fi
> >>>>
> >>>> +  # check with system wide if it is supported.
> >>>> +  output=3D$(perf stat -a -e "$p" true 2>&1)
> >>>> +  stat_result=3D$?
> >>>> +  if echo "$output" | grep -q "not supported"
> >>>> +  then
> >>>> +    # Event not supported, so ignore.
> >>>> +    echo "not supported"
> >>>> +    continue
> >>>> +  fi
> >>>> +
> >>>> +  # checked through possible access limitations and permissions.
> >>>> +  # At this step, non-zero return code from "perf stat" needs to
> >>>> +  # reported as fail for the user to investigate
> >>>> +  if [ $stat_result -ne 0 ]
> >>>> +  then
> >>>> +    echo "perf stat failed with non-zero return code"
> >>>> +    err=3D1
> >>>> +    continue
> >>>> +  fi
> >>>> +
> >>>>   # We failed to see the event and it is supported. Possibly the
> >>>> workload was
> >>>>   # too small so retry with something longer.
> >>>>   output=3D$(perf stat -e "$p" perf bench internals synthesize
> >>>> 2>&1)
> >>>> --
> >>>> 2.47.3
> >>>>


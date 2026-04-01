Return-Path: <linuxppc-dev+bounces-19176-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D605C10FCADE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 20:41:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmH2851Vkz2yjV;
	Thu, 02 Apr 2026 07:41:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::635" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775076064;
	cv=pass; b=D94axAg0A+7NamP4h6pMhBUddIFDx+Als/KTwVkefjQHsqArYGnw6ofwezLYeaPBvqINct/J7bOuiMrIlb9tZeg0lgvdtatyThYLCYcS1981vyDoQnciuvJbhf3TY00ZivifTWwucENlRXkVM4ZLY+JUAuhMG/Wbbwng9QnQElhmIzaLT/01UMwNavxm50KB9s2nNjH36qfxL8YhiSxgWP2ykaP0IJFM/Kqqxu7JFKZIwFELo2z14/luQc8poy+jlKk6OR/yg4SQ7uDQzj/OMXgMcQa/71o9eD618C6GUKZHk4P+ClptiYjTFeuhuC10DsCiACJ7F6miabf8o6GJ7w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775076064; c=relaxed/relaxed;
	bh=951WrjawRqq3nzkew3xFf8UWz29OPoL5LGFETUE8lmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhi3IGG4kWC9x5Euf5m/k4wDp7MkTklfIDq/hGJ3AEgqyxl7v6sBXOPEMSpFRmqvVHNfhEvLbKSJRaLMejJaitFpl4lZqe1G9RrCqizWduz7PCHiIWp6nagAPBnBe8WBtwqcSSRkG2JpiswstvvNX4Ej+6ZTh7V52j6YSNGJXkLNPlevCmR2mJMKMA/L4Z/ztzXZlyMb4sq1xSGxT416JBh3IoDOfBUI4JihbSWVMZH6Z94YcrbPy+8cyfQ3MzHrdXGaV3ycvkuTIw7WS9Cmx2LOIYW7af4uulWUHOBhcxSNYMx8QI9w2QaNIEt07MspVfxllhUwgbiag9jV7JS2Gw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rkL3auaQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=rkL3auaQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=irogers@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmH2717wjz2yhZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 07:41:02 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2b0b260d309so6745ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 13:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775076060; cv=none;
        d=google.com; s=arc-20240605;
        b=KOGSZA0AxC4UigHGXTbq+ts+ZE1q3rYsvRE/k8faX1/YLPpm9/6m+lc0zWzapbWkLf
         A6l5/ZrBT1HHonzUXa1+dZu9uhAgUKT5rF5mL1STgsNxmKN/kC3rnnw4gd6gPX3CRZxZ
         VaCyxATbyi2VIDPeviKCHgWoiUJ3jKHefXQqtESfmvDX3bN2t/mGibDrFpkkItYXlsnH
         f8BHY+yB3ya1vG35jqQ94Y6T0Ul9UnkjnhhEnjSfrn6pUywNjvY0egFBGYYIp0vS3I8R
         QS+GDrBgUqGl78K3SvfALgckHB7tWBALQ7wOiqJ06gc57yC/c86RxCMsuwh7lVbKWg2W
         xWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=951WrjawRqq3nzkew3xFf8UWz29OPoL5LGFETUE8lmQ=;
        fh=h8xvtouuz4UwdazK3lkeb/VGCe3stwNPwNIfEUgKcPM=;
        b=LwMw20AwdPNoETVVF3o9iA+uwZPHupogc9K93EGM9ov3Hfx0XfbKDickMM3b42vPxH
         PSS5SSjm4t8I1oz9Zubqclmc2W2iUHfrh16LYtalXW39nt+RxTPS70N0bqIPBNsz6vw3
         rlL50o01CZNKyG0KmGF7d4Obj9qwNREzNpQgFYvL0z8eg7WbsBVUqp07ZfTz34i2u3Ay
         pQMTQSCipd92cecyaUZKfgiEXeURZWbCUG6WNcMBKxU/bHv0kXJwBk64pdMoCX3vcimN
         Kar8m0t7c7w1VILNytySvCO/wGjw90UsndR+qhdb+MY+JdduigIA1pAtU1+4UDDUhMZC
         qDrg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775076060; x=1775680860; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=951WrjawRqq3nzkew3xFf8UWz29OPoL5LGFETUE8lmQ=;
        b=rkL3auaQhrsGt5XgRnujGDK7M+mmejehixgJ3PCtPIujouBITdK0rT97UA+PMX5+8C
         1Fzwg/01KJhJKRr9cNU1PRuXUTp7jGt2V6JWkdVOwhiatapc7hY/C9W86KFcxMi2S3Xd
         mXFNL5JKSGj2K6Rqo+Ho1eY4zeHuKwet3xGeN8ijcuu43HzvIDQHi8xwCGF6SN/KHGvu
         dQNBo7DO420SuoG/bkARCR3961WkgbaS/JAttcp9gE2wb7kldtmkCi3zuKBmCO1SKsid
         zMgWJG4lAwQ1wOhi2FEpu+4KOh5N1oBghWp+vpF1Pd8cWzDoVmMLwFDQFTVmQH8D4mbs
         Pl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775076060; x=1775680860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=951WrjawRqq3nzkew3xFf8UWz29OPoL5LGFETUE8lmQ=;
        b=jr+gE2MmQVGpIuSJXH2X2moJ/GkWpC2+PrIrO2CfnNmDs61pqO9EMn8uKiyp7nP2nA
         80xWFrYSaPzto9ljjKllsVGCTWnHlkLbYixO9Yn0J0bvaZsk+/vVmCERMpqPy1pJLXzF
         Fcqn8/Sx4EpfeHDmZ3CY7FxmKaUL+2NHYEgiFEwzhZBFInwU6VWvITDCya/FJoXKR9nN
         xPGgoPgehu/UR0InHc6ztJq6nWDCQB6LtUeJCmWkSwRfJE9PAO8K+Y+FmGRrCbBWr8Lg
         i7VMoScUZ/nsXC4GbPzTA3xdIYoWhEFBzLVTXGvBpAHMZN2x6epY2aQJBnYfitvdihSA
         cQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNKzE4HKdSDxQqRMNcDSoj+vcGvMKuHpEFHyrrQ9YGJsbUFNblavU+640YorGiUIBZTn87SHu5ZnCB3wQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxTQzkwNed6R2ecR/inU3uC7kwb1a4bXEL+9vAg1QD5YIs2mYGl
	iTmx8LONm0vnnEeOv7FqF0bOv5Cte3Lb1qfvOQT3qXsG+wMEQdW0x0d76L6G6GVf+oOGWLBKpss
	hBRZjwU9KGD9zvf1JtwIp9rrT8crFPHeJUyMNDEzD
X-Gm-Gg: ATEYQzw4xAvOmEG7XU5hGGpAaI7HEzv0DI27S61LoH64GWh2ZrwnM33fXxqazbGCNmz
	R0BthPUcZvA/nQuPEUQ420x9FuuuE/TwR6V9dUJerqWrhJYDUa9+OUd/uyo5sgXJiVVqSa3Rtyw
	8gj79gsDFPUbtkIZ4qiAyacUEK5yfMekJkyJNDZJd55B8udC+ecHioLLG+mjCTTRPHnuiR+do8t
	blTzscTQupNTkVsUVh2uN5+wC9K4jPOxV23adr6owmkyEmxvXY54QxRCqSqORE3zxAfELCNY/Pi
	P72yi2IJDDhwemsHZSQ44coShVWumqXeYDzBdXtJgV971Jg=
X-Received: by 2002:a17:903:1a2d:b0:2ae:7fa2:6bda with SMTP id
 d9443c01a7336-2b2769b0742mr500905ad.1.1775076059588; Wed, 01 Apr 2026
 13:40:59 -0700 (PDT)
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
References: <20260315105751.86835-1-atrajeev@linux.ibm.com> <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
In-Reply-To: <7B7E5C6C-D15A-4B79-925B-B5F3EDD84774@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 13:40:47 -0700
X-Gm-Features: AQROBzCsIQ5u20S1ffg6GKC2eZ2mM6neoKCEoseeulqZUJEM_EM8Ddw4PtA3mMI
Message-ID: <CAP-5=fWxDouXfCV3Xzk5JdouidUOaNqHBfZaf_c9JoEA8Ft-7g@mail.gmail.com>
Subject: Re: [PATCH] tools/perf/test: Check for perf stat return code in perf
 all PMU test
To: Venkat <venkat88@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 3:40=E2=80=AFAM Venkat <venkat88@linux.ibm.com> wro=
te:
>
>
>
> > On 15 Mar 2026, at 4:27=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ibm.c=
om> wrote:
> >
> > Currently in "perf all PMU test", for "perf stat -e <event> true",
> > below checks are done:
> > - if return code is zero, look for "not supported" to decide pass
> >  scenario
> > - check for "not supported" to ignore the event
> > - looks for "No permission to enable" to skip the event.
> > - If output has "Bad event name", fail the test.
> > - Use "Access to performance monitoring and observability operations is
> >  limited." to ignore fail due to access limitations
> >
> > If we failed to see event and it is supported, retries with longer
> > workload "perf bench internals synthesize".
> > - Here if output has <event>, the test is a pass.
> >
> > Snippet of code check:
> >  ```
> >  output=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> >  if echo "$output" | grep -q "$p"
> >  ```
> > - if output doesn't have event printed in logs, considers it fail.
> >
> > But this results in false pass for events in some cases.
> > Example, if perf stat fails as below:
> >
> > # ./perf stat -e pmu/event/  true
> > event syntax error: 'pmu/event/'
> >                     \___ Bad event or PMU
> >
> > Unable to find PMU or event on a PMU of 'pmu'
> > Run 'perf list' for a list of valid events
> >
> >  Usage: perf stat [<options>] [<command>]
> >
> >    -e, --event <event>   event selector. use 'perf list' to list availa=
ble events
> > # echo $?
> > 129
> >
> > Since this has non-zero return code and doesn't have the
> > fail strings being checked in the test, it will enter check using
> > longer workload. and since the output fail log has event, it
> > declares test as "supported".
> >
> > Since all the fail strings can't be added in the check, update
> > the testcase to check return code before proceeding to longer
> > workload run.
> >
> > Another missing scenario is when system wide monitoring is supported
> > example:
> > # ./perf stat -e pmu/event/ true
> > Error:
> > No supported events found.
> >  Unsupported event (pmu/event/H) in per-thread mode, enable system wide=
 with '-a'.
> >
> > Update testcase to check with "perf stat -a -e $p" as well
> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> > ---
>
> Tested this patch.
>
>
> With this patch:
>
> Testing hv_24x7/CPM_ADJUNCT_INST/ -- perf stat failed with non-zero retur=
n code
> Testing hv_24x7/CPM_ADJUNCT_PCYC/ -- perf stat failed with non-zero retur=
n code
>
>
>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Testing on an Intel Alderlake the test is now failing:
```
...
Testing offcore_requests_outstanding.l3_miss_demand_data_rd -- supported
Testing ocr.full_streaming_wr.any_response -- perf stat failed with
non-zero return code
Testing ocr.partial_streaming_wr.any_response -- perf stat failed with
non-zero return code
Testing ocr.streaming_wr.any_response -- supported
...
```

Running `perf stat` manually reveals an issue with the event:
```
$ sudo perf stat -vv -e ocr.full_streaming_wr.any_response -a sleep
1
Using CPUID GenuineIntel-6-B7-1
Attempt to add: cpu_atom/ocr.full_streaming_wr.any_response/
..after resolving event:
cpu_atom/event=3D0xb7,period=3D0x186a3,umask=3D0x1,offcore_rsp=3D0x80000001=
0000/
ocr.full_streaming_wr.any_response ->
cpu_atom/ocr.full_streaming_wr.any_response/
Control descriptor is not initialized
------------------------------------------------------------
perf_event_attr:
 type                             10 (cpu_atom)
 size                             144
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 config                           0xa00000000
(cpu_atom/PERF_COUNT_HW_CPU_CYCLES/)
 disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 3
------------------------------------------------------------
perf_event_attr:
 type                             0 (PERF_TYPE_HARDWARE)
 config                           0x400000000
(cpu_core/PERF_COUNT_HW_CPU_CYCLES/)
 disabled                         1
------------------------------------------------------------
sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 =3D 3
 config                           0x1b7
(ocr.demand_data_rd.l3_hit.snoop_hit_no_fwd)
 sample_type                      IDENTIFIER
 read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
 disabled                         1
 inherit                          1
 { bp_addr, config1 }             0x800000010000
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 16  group_fd -1  flags 0x8
sys_perf_event_open failed, error -22
switching off deferred callchain support
Warning:
ocr.full_streaming_wr.any_response event is not supported by the kernel.
The sys_perf_event_open() syscall failed for event
(ocr.full_streaming_wr.any_response): Invalid argument
"dmesg | grep -i perf" may provide additional information.

Error:
No supported events found.
The sys_perf_event_open() syscall failed for event
(ocr.full_streaming_wr.any_response): Invalid argument
"dmesg | grep -i perf" may provide additional information.
```

This looks like a latent Intel cpu_atom PMU bug. Thomas, wdyt?

Thanks,
Ian

> Regards,
> Venkat.
>
>
>
> > tools/perf/tests/shell/stat_all_pmu.sh | 20 ++++++++++++++++++++
> > 1 file changed, 20 insertions(+)
> >
> > diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/=
shell/stat_all_pmu.sh
> > index 9c466c0efa85..6c4d59cbfa5f 100755
> > --- a/tools/perf/tests/shell/stat_all_pmu.sh
> > +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> > @@ -53,6 +53,26 @@ do
> >     continue
> >   fi
> >
> > +  # check with system wide if it is supported.
> > +  output=3D$(perf stat -a -e "$p" true 2>&1)
> > +  stat_result=3D$?
> > +  if echo "$output" | grep -q "not supported"
> > +  then
> > +    # Event not supported, so ignore.
> > +    echo "not supported"
> > +    continue
> > +  fi
> > +
> > +  # checked through possible access limitations and permissions.
> > +  # At this step, non-zero return code from "perf stat" needs to
> > +  # reported as fail for the user to investigate
> > +  if [ $stat_result -ne 0 ]
> > +  then
> > +    echo "perf stat failed with non-zero return code"
> > +    err=3D1
> > +    continue
> > +  fi
> > +
> >   # We failed to see the event and it is supported. Possibly the worklo=
ad was
> >   # too small so retry with something longer.
> >   output=3D$(perf stat -e "$p" perf bench internals synthesize 2>&1)
> > --
> > 2.47.3
> >
>


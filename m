Return-Path: <SRS0=BFlh=LR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66CDC4743C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 17:27:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D76760FEA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 17:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D76760FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G99Fh5CYGz3btw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 03:27:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cPVdN6PD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::236;
 helo=mail-lj1-x236.google.com; envelope-from=vincent.guittot@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cPVdN6PD; dkim-atps=neutral
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G99FB2qHNz303y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jun 2021 03:27:23 +1000 (AEST)
Received: by mail-lj1-x236.google.com with SMTP id a21so3991365ljj.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2021 10:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q2d2sQHy0KntFj7PyfcvDTPhCqiaY/wl1GYeGVevyXY=;
 b=cPVdN6PDfWFEKRnik7cWwwE2fuQoRkEUgYdGwM27Vslnjn6NScjASeLKUvFlLUy1fa
 YXUAtS1SSrQbJJQlZ2efFgnnrPWZiW04wQ7FvzRE38YrO12OoZGIOklD5hkfp6MB68OA
 SfQUOdH7RhRTnUfD/jg5jAIXBApRwAtdcgh895kz/BsXk26Ga/0j5nPYOctu/Pw5UgmT
 1JMpZBvjggPUqdlW5aZtJUx5D0OCzO0zs8ct+cEbq/aIBxEevuysksboegpZhScn9etZ
 e7FZI6h13VkR/pzJv64UlKW7uEqGqSAcjFBGzC2s/TeO0Sza0buUk/FtfmJo2PWSVNKE
 hW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q2d2sQHy0KntFj7PyfcvDTPhCqiaY/wl1GYeGVevyXY=;
 b=em9yEyYeBLJQaK61HY7dE+L5tUX2F5HzzMgGNq+B5llNTcalQwadp12cwzxmJGedKi
 TdDzSRFYj+2PaAMSje1zJgFfyhbWT5VNRPJLD5B2ljrrq7ODhHmVeLlngZ9iqO0kormI
 1Z7zzKGoHZ2K5oZxtgn1xN0dIn+5TLdjBqBuFy0xz6TESjgJjTuek8I8f0RSUW1T6g7P
 5g0G8JQfYmBFUp6gI+ociqPoo8u1coH8Dh5PwBRAOvqJIPoc/En1kqLtNxRaBPQe/gDo
 zk8L6MrFvO2acpg9FpJ+NEMhaTvON+tIo59Bp4siJWn7lCQHHpL1qjgUu034P41YtPc4
 e+ww==
X-Gm-Message-State: AOAM531a4rvwBSQbaJZ/+B/hEgz7Jm6PsDapKBFxEIPUqPRwn9URHrPO
 0hapkaQSzIBwZUkAiovVIGw/7OASMvDCeIyNfbGgjw==
X-Google-Smtp-Source: ABdhPJyc3ed/8kGPnbAGbdKUWTuzqOmrBvOtjBG7eXcy78/JpI6wipxa14CPu+ThHwFHhGlwP4yOZgSH2Lml/drFtZg=
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr585757lji.209.1624469238388;
 Wed, 23 Jun 2021 10:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <2ED1BDF5-BC0C-47CD-8F33-9A46C738F8CF@linux.vnet.ibm.com>
 <CAKfTPtDrHv4OOfPvwOE2DMNoucXQJ=yvvEpTVKrXghSdKEnZcA@mail.gmail.com>
 <20210622143154.GA804@vingu-book>
 <53968DDE-9E93-4CB4-B5E4-526230B6E154@linux.vnet.ibm.com>
 <20210623071935.GA29143@vingu-book>
 <CCB4222F-000A-44E8-8D61-F69893704688@linux.vnet.ibm.com>
 <6C676AB3-5D06-471A-8715-60AABEBBE392@linux.vnet.ibm.com>
 <20210623120835.GB29143@vingu-book>
 <5D874F72-B575-4830-91C3-8814A2B371CD@linux.vnet.ibm.com>
 <CAKfTPtBKn27=jryS_sxsVb+0yHDze_PMcLuyFtDkDo0H9Nzqww@mail.gmail.com>
In-Reply-To: <CAKfTPtBKn27=jryS_sxsVb+0yHDze_PMcLuyFtDkDo0H9Nzqww@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 23 Jun 2021 19:27:07 +0200
Message-ID: <CAKfTPtDFUBe+qD9z0YYb7yyup_mhdNNX+zopFwcnyh+G41viAw@mail.gmail.com>
Subject: Re: [powerpc][next-20210621] WARNING at kernel/sched/fair.c:3277
 during boot
To: Sachin Sant <sachinp@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Odin Ugedal <odin@uged.al>, open list <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 23 Jun 2021 at 18:55, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 23 Jun 2021 at 18:46, Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:
> >
> >
> > > Ok. This becomes even more weird. Could you share your config file and more details about
> > > you setup ?
> > >
> > > Have you applied the patch below ?
> > > https://lore.kernel.org/lkml/20210621174330.11258-1-vincent.guittot@linaro.org/
> > >
> > > Regarding the load_avg warning, I can see possible problem during attach. Could you add
> > > the patch below. The load_avg warning seems to happen during boot and sched_entity
> > > creation.
> > >
> >
> > Here is a summary of my testing.
> >
> > I have a POWER box with PowerVM hypervisor. On this box I have a logical partition(LPAR) or guest
> > (allocated with 32 cpus 90G memory) running linux-next.
> >
> > I started with a clean slate.
> > Moved to linux-next 5.13.0-rc7-next-20210622 as base code.
> > Applied patch #1 from Vincent which contains changes to dequeue_load_avg()
> > Applied patch #2 from Vincent which contains changes to enqueue_load_avg()
> > Applied patch #3 from Vincent which contains changes to attach_entity_load_avg()
> > Applied patch #4 from https://lore.kernel.org/lkml/20210621174330.11258-1-vincent.guittot@linaro.org/
> >
> > With these changes applied I was still able to recreate the issue. I could see kernel warning
> > during boot.
> >
> > I then applied patch #5 from Odin which contains changes to update_cfs_rq_load_avg()
> >
> > With all the 5 patches applied I was able to boot the kernel without any warning messages.
> > I also ran scheduler related tests from ltp (./runltp -f sched) . All tests including cfs_bandwidth01
> > ran successfully. No kernel warnings were observed.
>
> ok so Odin's patch fixes the problem which highlights that we
> overestimate _sum or don't sync _avg and _sum correctly
>
> I'm going to look at this further

The problem is  "_avg * divider" makes the assumption that all pending
contrib are not null contributions whereas they can be null.

Odin patch is the right way to fix this. Other patches should not be
useful for your problem

>
> >
> > Have also attached .config in case it is useful. config has CONFIG_HZ_100=y
>
> Thanks, i will have a look
>
> >
> > Thanks
> > -Sachin
> >

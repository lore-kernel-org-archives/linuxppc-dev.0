Return-Path: <SRS0=BFlh=LR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AE1C4743C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 15:14:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A6860240
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jun 2021 15:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A6860240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uged.al
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G96Hf6HGDz3bx9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jun 2021 01:14:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=uged.al header.i=@uged.al header.a=rsa-sha256 header.s=google header.b=YV66voH0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ugedal.com (client-ip=2607:f8b0:4864:20::730;
 helo=mail-qk1-x730.google.com; envelope-from=odin@ugedal.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=uged.al header.i=@uged.al header.a=rsa-sha256
 header.s=google header.b=YV66voH0; dkim-atps=neutral
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G96H53QBfz2yYG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jun 2021 01:13:51 +1000 (AEST)
Received: by mail-qk1-x730.google.com with SMTP id o6so6069668qkh.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jun 2021 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uged.al; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gZeBBRZLdgs5z5YIW+IZOvyuL2HOJs5r51r/cXKgVrI=;
 b=YV66voH0V9MqAVOn7Keklep6VQK/r+/AlEwBzhLa/aXtZfO4MDlFTg7hphubEqbp+8
 JfW9fD173C1e0822uNyOw1UIMnx1MB0RmeKn2NSvxU9twMPAp4X1Q4koYTLOx9AMekjN
 9wMjYZELcmwL/iWnzTtlDWVmglTbUPx1lQRTQA9wypew7Hpwl/sqX3SKk4uu11CACnIs
 VschCj2ZyRo4Jp+C5NE1wI39wDPRGGVvLw03CjaVtUwNFV/U2lu9jtO0p5we6nrktiwi
 +ftiIXe1QeuQervG+nYNXMXwxPhe+RO2owMaStVg7GHfM2Yfdk9MApHpvV+XtxXcA8xC
 5bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gZeBBRZLdgs5z5YIW+IZOvyuL2HOJs5r51r/cXKgVrI=;
 b=iFesVrRf+QSmmlt//iiNL0LwsJ3aK6kYci+6v4Bi03apKED+hj64LT3zRZNJDvgl30
 OFbRC2Y1P0kj0Jyh+Qk+w4VqqBSR6xUrHftYamo0WrwZTAHOpJe4k82EZPzBEUleGti3
 n22HwmuPE5BsmlEJadLOrhRIpOyaDYYXmWI3zHGUN0AMS5dqeBKlGOHPEInzjMh/Mlvv
 VsavEVWZB/xM5ROU4K0ziA/KNLPPmlztY1oe4egQmPlP3Qzr3W0zTHlYpcg/yZ5qQTTD
 s4bnfAQPPkLbAbrE4yC7bNeWwCb3kcadrVqMpcAUxjCqS0SG7efQLYqpzHzqc1oCAPJ3
 T8jw==
X-Gm-Message-State: AOAM530Qx/rF6cYUS78iuEZwJD0cUI82DFRhZlG2CKoZYDTZauzAvelo
 iShelYVcOBfcomXZ/u2Dog79UHLLW3wK0iOMr1eRRA==
X-Google-Smtp-Source: ABdhPJztGSPN1d/xRjk75/D+Fbiy6eSyD4Wtzm1wmWhJRjLyNZn3h+80Ztx7AH5f+x/Gj5yzIqqHgPAuhe1OmhCcg64=
X-Received: by 2002:a05:620a:16c2:: with SMTP id
 a2mr528118qkn.148.1624461227131; 
 Wed, 23 Jun 2021 08:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <2ED1BDF5-BC0C-47CD-8F33-9A46C738F8CF@linux.vnet.ibm.com>
 <CAKfTPtDrHv4OOfPvwOE2DMNoucXQJ=yvvEpTVKrXghSdKEnZcA@mail.gmail.com>
 <20210622143154.GA804@vingu-book>
 <53968DDE-9E93-4CB4-B5E4-526230B6E154@linux.vnet.ibm.com>
 <20210623071935.GA29143@vingu-book>
 <CCB4222F-000A-44E8-8D61-F69893704688@linux.vnet.ibm.com>
 <6C676AB3-5D06-471A-8715-60AABEBBE392@linux.vnet.ibm.com>
 <20210623120835.GB29143@vingu-book>
 <CAFpoUr01xb9ZJF9mb2nmZDpUHXFH3VSbY3AU8-1owV-_7wVTPg@mail.gmail.com>
 <CAKfTPtB++3y4VnbKE_n=bgsqCfqXuF0KUsdB_cFhi9xAnMRubw@mail.gmail.com>
 <CAFpoUr3bHzrwvumw6R=2JVbKa_wmtT9cMf-mdDHxY0Png-N9Jw@mail.gmail.com>
 <CAKfTPtAev0VgCmK3AUyTCoVA38YmskpB98q0kTrbEPK6e=1dTA@mail.gmail.com>
In-Reply-To: <CAKfTPtAev0VgCmK3AUyTCoVA38YmskpB98q0kTrbEPK6e=1dTA@mail.gmail.com>
From: Odin Ugedal <odin@uged.al>
Date: Wed, 23 Jun 2021 17:13:11 +0200
Message-ID: <CAFpoUr3Q+7Tr3y59H-BiFU7BO=dquhQpJ8M9JtmV0_3ySfp-+Q@mail.gmail.com>
Subject: Re: [powerpc][next-20210621] WARNING at kernel/sched/fair.c:3277
 during boot
To: Vincent Guittot <vincent.guittot@linaro.org>
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Odin Ugedal <odin@uged.al>, open list <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

ons. 23. jun. 2021 kl. 15:56 skrev Vincent Guittot <vincent.guittot@linaro.org>:
>
>
> The pelt value of sched_entity is synced with  cfs and its contrib
> before being removed.


Hmm. Not sure what you mean by sched_entity here, since this is only
taking the "removed" load_avg
and removing it from cfs_rq, together with (removed.load_avg *
divider) from load_sum. (Although. ".removed" comes from
a sched entity)

> Then, we start to remove this load in update_cfs_rq_load_avg() before
> calling __update_load_avg_cfs_rq so contrib should not have change and
> we should be safe

For what it is worth, I am now able to reproduce it (maybe
CONFIG_HZ=300/250 is the thing) as reported by Sachin,
and my patch makes it disappear. Without my patch I see situations
where _sum is zero while _avg is eg. 1 or 2 or 14 (in that range).
This happens for both load, runnable and util.

Lets see what Sachin reports back.

Thanks
Odin

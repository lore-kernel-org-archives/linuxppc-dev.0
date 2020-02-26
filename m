Return-Path: <SRS0=VSEi=4O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667D6C4BA24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 23:54:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECE2206BF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Feb 2020 23:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOBc69kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECE2206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48SXj04CdDzDqpM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Feb 2020 10:54:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::341;
 helo=mail-ot1-x341.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=GOBc69kz; dkim-atps=neutral
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48SXg83KHhzDqbh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2020 10:53:05 +1100 (AEDT)
Received: by mail-ot1-x341.google.com with SMTP id r16so1244474otd.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2020 15:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/reQHu4oXoI3nFgr5YiBaaoUtCPf0kmkkCGZobp7ogQ=;
 b=GOBc69kzvKAYIDgSiDtmfD2LeZKT41+DREuPP3AdsynOYTdkObHIwdm9ocA987vcAr
 41s0+ndDfLOV6PobIdF5y5VejtLO82MfJWsiWNzJBWW7fI5yChTwO6BrKqPq+0mzlbDW
 vpGzRvBIv40SsN2WUDZT0zigTQcpGgt6ryPnvMKN0/Vw9NVx8xYPXA2rF/FKj7E11xj1
 EppoWMjMJOm3ZXShMkyAyCxcewo+kPSHHwD4KYectnpSuZjibvujMh3LpcWSPTBEszZM
 95tKODZZQ2UXo3ihuKpeeKCcR1uZB4irGdI9m4Gtrbz8UoHYHJxGKcWxAhBpMr+PzLEk
 gL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/reQHu4oXoI3nFgr5YiBaaoUtCPf0kmkkCGZobp7ogQ=;
 b=e1ZaThUTC/8EP5q2KV1qqMqI/gfCpexO6A2L9Fc0OjsUWZ0NdRlorKhRj1C2hsjAFh
 p5pkV+CBpyvVShrbWeAPLRK17r5TP560Y+tnoYymx/A7CW/Yyo6ioyWO6pCqWCWD+IGB
 0HkP3NClZGViiNW3aO6bH6gpn4eZIGZ/ans0HpaNhcnHzaKtz4F8szOAezfOM2enpB8t
 +As7CY+Ls+4IAjTyZ8bckzIbewC997fjwrgn14lStBEDJnu82NDqDmAcBbR6xk4vBVyJ
 FSMxPrC6zivTYOFzo6CvXyWf5o/q24mHEPw14EkKldv8/zxcp7mZOFaucjruAv+xRx9Y
 6PYA==
X-Gm-Message-State: APjAAAX2k22qm1muZaqCPHBG6cC+SFP53272Lql7pJy14QTQumMgX+R3
 nfa9/ebI3XcNrmCSDa7tA5Oc3AFYR8b80qFWl1c=
X-Google-Smtp-Source: APXvYqyFKXO7LN+6pKs8whW9i1Cnc3fvNSxx5S3BZ3HBQhLXGjzFi8oUmjzqEAjvsel4j0Yqsf8CKC6VzWQB3N/0ZPo=
X-Received: by 2002:a9d:aea:: with SMTP id 97mr1095792otq.51.1582761182552;
 Wed, 26 Feb 2020 15:53:02 -0800 (PST)
MIME-Version: 1.0
References: <20200226040716.32395-1-jniethe5@gmail.com>
 <20200226040716.32395-8-jniethe5@gmail.com>
 <1582699744.9jdw100hst.astroid@bobo.none>
In-Reply-To: <1582699744.9jdw100hst.astroid@bobo.none>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Thu, 27 Feb 2020 10:52:51 +1100
Message-ID: <CACzsE9qmF+mpPQzL7HN5jOdjCtTJbqWvQQfnOxXkpJMs-fQxRg@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] powerpc/traps: Check for prefixed instructions
 in facility_unavailable_exception()
To: Nicholas Piggin <npiggin@gmail.com>
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
Cc: Alistair Popple <alistair@popple.id.au>, Daniel Axtens <dja@axtens.net>,
 linuxppc-dev@lists.ozlabs.org, Balamuruhan S <bala24@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 26, 2020 at 5:53 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Jordan Niethe's on February 26, 2020 2:07 pm:
> > If prefixed instructions are made unavailable by the [H]FSCR, attempting
> > to use them will cause a facility unavailable exception. Add "PREFIX" to
> > the facility_strings[].
> >
> > Currently there are no prefixed instructions that are actually emulated
> > by emulate_instruction() within facility_unavailable_exception().
> > However, when caused by a prefixed instructions the SRR1 PREFIXED bit is
> > set. Prepare for dealing with emulated prefixed instructions by checking
> > for this bit.
> >
> > Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
>
> Oh you've got it here, I would just squash this together with the first
> patch.
Sure, I'll put them together. When you mentioned a couple more things
to do in traps.c, was it just this? Or is there still more to be done
adding an FSCR?
>
> Thanks,
> Nick

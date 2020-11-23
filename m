Return-Path: <SRS0=H+zi=E5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D26C2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2020 20:04:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435EA2071E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2020 20:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="sW9rb6Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435EA2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cfylh6PzVzDqQV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 07:04:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::643;
 helo=mail-ej1-x643.google.com; envelope-from=morbo@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=sW9rb6Gl; dkim-atps=neutral
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cfyhb0DMCzDqRS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2020 07:01:18 +1100 (AEDT)
Received: by mail-ej1-x643.google.com with SMTP id k27so25042540ejs.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2020 12:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q1EarbbRbCkwbzS/kZDraReJYpODX6N6wu4Osu4AXvc=;
 b=sW9rb6GlQAn1WkFfOJxqpW6PmjeK6+5PZHVd6hQcrTZSehPaJ3Yq2PobKgQTf+iOew
 diJPyGVNYjX2aaBxBkcMdzLmDJzDv49jjX6Jf77yTKDsHN5a/vA0oGO1aheP0/Dll6bK
 qDYeuCFYdJqq/CC3BWe25/MRrjfGfoIec9XpK1ZGZRzS+8XNCd2ixNOvUbMp/Yb1coH4
 5lIrRiDYjbQ0RxDMZa40NvDJ42JKxYDB3oeZPpmBn4mEJbu8Fmgmc+ppAGLC1m3uGhiE
 vpw7oAETBHN/VzqG+nPHv7AGXLNzu42UPb5xRnH0RLgcuaRxNq3ER2CSKP6b8O9d2+vQ
 Cehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q1EarbbRbCkwbzS/kZDraReJYpODX6N6wu4Osu4AXvc=;
 b=Petk/FinKE8mhCEYtKf6vaqey2LcRVkYoD8R49j1yukUkESUdlSvydopgs4LU+R34H
 Nqb6NQkPZeCJ4+EeYxJJkv332ctWRbna4omiJFIMpNz2/zLhKcUyLOlGXlQN39vVdSVK
 4WMq6iww2U1MRevQ5SKqS3jfcMaLq9kEugzxnZ7YdP7XxZNf5weYLeGU1f4Rf7Nl6WMQ
 HCf3xJJ4vV0l77tE68mxiuVe1b5NYxojM1LG5/ymp2KWhDbZlY8SIfoMHbg7mQMLRF8S
 wet2h4eIzVA+tqGi2QXAHuH5p5i2+PD9NjX1DUHesHTzZP0iok3Uj4minuLLBRU2jrB0
 MS5Q==
X-Gm-Message-State: AOAM532YIw3WKW1nPNvqfQgKlJexXsoyfAZ5VGKB5n7D0eLV66lG2PQo
 1JRoS6nOux4xpaFraAXfgdjG5i5kkSY6SrnK6BEB
X-Google-Smtp-Source: ABdhPJwe6O7lroFS0ZNwQ6Dgot22OgB7m50lPxE6l1ImQ2GVfXJZ4kf3JVAjA8ZUMn7Q7hsXB7jWd3swOqYu9v3he0c=
X-Received: by 2002:a17:906:1b04:: with SMTP id
 o4mr1048327ejg.531.1606161673027; 
 Mon, 23 Nov 2020 12:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20201118223513.2704722-1-morbo@google.com>
 <20201120224034.191382-1-morbo@google.com>
 <20201120224034.191382-4-morbo@google.com> <87d0041vaf.fsf@mpe.ellerman.id.au>
 <20201123063432.GG2672@gate.crashing.org>
 <CAGG=3QVjSAwU+ebvH=Lk5YVMxW7=ThvkJXGPw+95nYxxuurMig@mail.gmail.com>
 <20201123195622.GI2672@gate.crashing.org>
In-Reply-To: <20201123195622.GI2672@gate.crashing.org>
From: Bill Wendling <morbo@google.com>
Date: Mon, 23 Nov 2020 12:01:01 -0800
Message-ID: <CAGG=3QXR=Yfh8PNa4m-kQLTBP4YKD8OGm_6fSUgeasQ1ar9b2g@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] powerpc/64s: feature: Work around inline asm issues
To: Segher Boessenkool <segher@kernel.crashing.org>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 23, 2020 at 11:58 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> > On Sun, Nov 22, 2020 at 10:36 PM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > > "true" (as a result of a comparison) in as is -1, not 1.
>
> On Mon, Nov 23, 2020 at 11:43:11AM -0800, Bill Wendling wrote:
> > What Segher said. :-) Also, if you reverse the comparison, you'll get
> > a build error.
>
> But that means your patch is the wrong way around?
>
> -       .ifgt (label##4b- label##3b)-(label##2b- label##1b);    \
> -       .error "Feature section else case larger than body";    \
> -       .endif;                                                 \
> +       .org . - ((label##4b-label##3b) > (label##2b-label##1b)); \
>
> It should be a + in that last line, not a -.

I said so in a follow up email.

> Was this tested?
>
Please don't be insulting. Anyone can make an error.

-bw

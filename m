Return-Path: <SRS0=3GPV=CK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCF8C433E6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 10:07:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD273206A5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 10:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVTmSw6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD273206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BgjRF6Ds1zDqY5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2020 20:07:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::244;
 helo=mail-oi1-x244.google.com; envelope-from=allen.lkml@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=cVTmSw6X; dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BgjP05p6PzDqRn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2020 20:05:08 +1000 (AEST)
Received: by mail-oi1-x244.google.com with SMTP id z195so647863oia.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2020 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=12zlZh/I8vKcpFmFAYP7329YZeBRoOUT8YXeGfQKuJs=;
 b=cVTmSw6XX+UT6JUTH4rdPSJ9FNDlYkQZYUfvTr2XorsOE1gcdNjHOzTRgqjMvpA4Xy
 TsmOhTC0Xb1IGa6M2dfbBdowKCpxJ866AVZrI14hUdZEmiCll6cl3emPVLdxv6nSMdq2
 kqV0dP0hQxBQOU9KFPrbouWkY2RRe0sNwVjlm+Fi0S7vhwBaebaEb7gXqLl+HGDhJaOv
 Z893PplsVmLuxu4Qg5AghWQuMPM3Yki2X6UZhkcCMiAWTzre3QwjLxDhUhIXwTDMYo57
 TjPtLbMB6+ljoKyyBzxOv7VO7jk6WxlGmym/CuGp432h8bnzpkLQOQNCWDR8/zgVa858
 cQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=12zlZh/I8vKcpFmFAYP7329YZeBRoOUT8YXeGfQKuJs=;
 b=uC/JZR8q7kmms6IRvO/sjih16ZgLXUs2aLnORX0Y6PS0H0pwbE039Pm0mOgDajSaI3
 E4YXvN30lS+WFMCDlwwJar9/2zSq90c7JlTvoF7vut6Ur7862VocWZAyDUe9u/VxAPKk
 +XP3ONEgVzyR0ZtCduEhhb/dqpwmzWJzCBtP0/+ApnaCb9t6V+j8O8QcGj21Q60SSaTT
 tk0OtM1b7s8UcLgTnm6+qFdzCcTu3evhRKDfz5qE8NEx0HxIxGt7iFDirUlatqbeEfss
 7eCsofR+uZXmeP6HRpDgVQY+gjg7v2FpO+22GbRiNY/NlkhoFzEPQoLJitw2elufkhzX
 x15g==
X-Gm-Message-State: AOAM533VlxnEjL07gIaccdFVXzD+i0EzUJ5RmR7RbqTzf+FYy0j8Wy7n
 rHREi9mOlc3qZWiy71LZnZ0zAvD97VggFsPxE8c=
X-Google-Smtp-Source: ABdhPJye06bcGhAWcYxufpzsaAsoo5AYygMhxy14Mms95Z97Cmb8t1iCi6Fk2wDJAHKUVMTHJ8UVPQHQTR7OYPMT4tY=
X-Received: by 2002:aca:4c09:: with SMTP id z9mr72588oia.175.1598954704359;
 Tue, 01 Sep 2020 03:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
 <s5hsgckl084.wl-tiwai@suse.de> <20200818104432.GB5337@sirena.org.uk>
 <CAOMdWSK79WWsmsxJH9zUMZMfkBNRWXbmEHg-haxNZopHjC1cGw@mail.gmail.com>
 <20200819111605.GC5441@sirena.org.uk> <s5h4koyj2no.wl-tiwai@suse.de>
In-Reply-To: <s5h4koyj2no.wl-tiwai@suse.de>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 1 Sep 2020 15:34:53 +0530
Message-ID: <CAOMdWSJ2VKhbnRDTNVuTKSL12k0qhryO7yznstAk8k_nBGp2=Q@mail.gmail.com>
Subject: Re: [PATCH 00/10] sound: convert tasklets to use new tasklet_setup()
To: Takashi Iwai <tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Kees Cook <keescook@chromium.org>,
 timur@kernel.org, Xiubo.Lee@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, clemens@ladisch.de,
 tiwai@suse.com, o-takashi@sakamocchi.jp, nicoleotsuka@gmail.com,
 Allen Pais <allen.cryptic@gmail.com>, Mark Brown <broonie@kernel.org>,
 perex@perex.cz, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Takashi,
> > > > These patches which I wasn't CCed on and which need their subject lines
> > > > fixing :( .  With the subject lines fixed I guess so so
> >
> > > Extremely sorry. I thought I had it covered. How would you like it
> > > worded?
> >
> > ASoC:
>
> To be more exact, "ASoC:" prefix is for sound/soc/*, and for the rest
> sound/*, use "ALSA:" prefix please.

I could not get the generic API accepted upstream. We would stick to
from_tasklet()
or container_of(). Could I go ahead and send out V2 using
from_tasklet() with subject line fixed?

Thanks,
-- 
       - Allen

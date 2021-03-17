Return-Path: <SRS0=EYxI=IP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C53C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 02:16:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543F764F91
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 02:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543F764F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F0YgG1Vcvz3brZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 13:16:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=egDWDko3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b2b;
 helo=mail-yb1-xb2b.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=egDWDko3; dkim-atps=neutral
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0Yfp0ddYz2yhJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Mar 2021 13:16:00 +1100 (AEDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 133so38958885ybd.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 19:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Yo3EEN+b2FOoX7TZIRo+Dl0cQP0jobVVqSzxMXsb9PQ=;
 b=egDWDko3ZGYqB6YT/FM5c3SxaDgsuZCCTksK3VIgAFtZuFS3TrGtNXECTjuCMJUAkv
 xRQu6PBsuQ861fjs1e2ii0Ul6hvYqbZXdvRMNGsEtPQms+/pFSMZvNHe9Mm2wguG8Fpv
 qfr5BqfGHkXn1Y5NveigZF8su/fsoxilTiwLupwwTDvhFDnfUqemAmmmo5eSiPTFXaWb
 p2BfvQe8GhdvOTjX6zJ81p7zNcU7Iysx8Gm9jJGRtcFzXVTxfJsOldb2REWrCh0yv/y0
 nbRPlBWo2nDnVO7R5zoZSi2IKnSJhFyiw37I8pwU1u87BlqxhmZ414fNkM5b4+xQifa7
 1+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Yo3EEN+b2FOoX7TZIRo+Dl0cQP0jobVVqSzxMXsb9PQ=;
 b=XdAYLpJgobAvp4KaiLNH/ojpSDK+spD9j0NXVkPfI8Cw3GuO1QqlGDkLRs9sbUy3P9
 oJsMedhKWKZjHTR20jr7jydISwS1MMEZBPjIlLFxuMzBhelKIaUnAKSP0mXoWXSbQ9pD
 aRkI6m/puh0mIphuuTxmivZJc0Y81dkfUDf/z9M1uVzbxMaw0MW89LjuRyT+XUbaFqpk
 eprV4a1XrIFXhLh9kZHjZxTiwW0dZbof92dPvVszH8/1hBqiEq/g+GyGE/yE86cQbGYF
 d4j6cIkezBf/TCGkrUMxUTRwzYQru6apaTS+WRrCL0G57Q7acA4eQimwwCrQMrWjmMjR
 WFbA==
X-Gm-Message-State: AOAM5303482G6TCkm66JTNSpase5C9Yq//4hfeV4JHPZxpaSxgIsgMdg
 7Jisd00vBOmNbkwF9/QSYYxZ8Hkgi1HFfhM0t6o=
X-Google-Smtp-Source: ABdhPJwMGJnVC6vi2Rzotps2ar4d/syqK2Vy/Ar5EHe5ldV6gCjWczrMcXNNtMoaXkDff3CoUU0KdEtiDmNTgXpgEQU=
X-Received: by 2002:a25:ca88:: with SMTP id a130mr2150975ybg.414.1615947358500; 
 Tue, 16 Mar 2021 19:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210316031741.1004850-1-jniethe5@gmail.com>
 <20210316031741.1004850-5-jniethe5@gmail.com>
 <1b4d4df4-4553-0f33-631f-5a2e5ae97547@csgroup.eu>
In-Reply-To: <1b4d4df4-4553-0f33-631f-5a2e5ae97547@csgroup.eu>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Wed, 17 Mar 2021 13:15:47 +1100
Message-ID: <CACzsE9r4H7yyRfZ3_jcTsjUSwfbPiRyLn6AjU6r2hPWL=OV8pw@mail.gmail.com>
Subject: Re: [PATCH v9 5/8] powerpc: Set ARCH_HAS_STRICT_MODULE_RWX
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, ajd@linux.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, naveen.n.rao@linux.ibm.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 16, 2021 at 5:51 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 16/03/2021 =C3=A0 04:17, Jordan Niethe a =C3=A9crit :
> > From: Russell Currey <ruscur@russell.cc>
> >
> > To enable strict module RWX on powerpc, set:
> >
> >      CONFIG_STRICT_MODULE_RWX=3Dy
> >
> > You should also have CONFIG_STRICT_KERNEL_RWX=3Dy set to have any real
> > security benefit.
> >
> > ARCH_HAS_STRICT_MODULE_RWX is set to require ARCH_HAS_STRICT_KERNEL_RWX=
.
> > This is due to a quirk in arch/Kconfig and arch/powerpc/Kconfig that
> > makes STRICT_MODULE_RWX *on by default* in configurations where
> > STRICT_KERNEL_RWX is *unavailable*.
>
> Not that easy on book3s/32. On it, you can't protect memory against execu=
tion on a page basis, you
> can only do it on a segment basis. So in order to do that, when would nee=
d to allocate to areas of
> memory: one in module space for text and one in vmalloc space for data.
>
> See https://github.com/linuxppc/linux/commit/6ca05532 and
> https://github.com/linuxppc/linux/commit/7fbc22ce
Would it be ok to just make ARCH_HAS_STRICT_MODULE_RWX conditional on 64s?
>
>
> >
> > Since this doesn't make much sense, and module RWX without kernel RWX
> > doesn't make much sense, having the same dependencies as kernel RWX
> > works around this problem.
> >
> > Signed-off-by: Russell Currey <ruscur@russell.cc>
> > Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> > ---
> >   arch/powerpc/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 4498a27ac9db..d9cadc4212d0 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -137,6 +137,7 @@ config PPC
> >       select ARCH_HAS_SCALED_CPUTIME          if VIRT_CPU_ACCOUNTING_NA=
TIVE && PPC_BOOK3S_64
> >       select ARCH_HAS_SET_MEMORY
> >       select ARCH_HAS_STRICT_KERNEL_RWX       if ((PPC_BOOK3S_64 || PPC=
32) && !HIBERNATION)
> > +     select ARCH_HAS_STRICT_MODULE_RWX       if ARCH_HAS_STRICT_KERNEL=
_RWX
> >       select ARCH_HAS_TICK_BROADCAST          if GENERIC_CLOCKEVENTS_BR=
OADCAST
> >       select ARCH_HAS_UACCESS_FLUSHCACHE
> >       select ARCH_HAS_COPY_MC                 if PPC64
> >

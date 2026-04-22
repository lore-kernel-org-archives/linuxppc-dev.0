Return-Path: <linuxppc-dev+bounces-19928-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF489F94CD1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 07:00:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0qqm6VGRz2yZN;
	Wed, 22 Apr 2026 17:00:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776841236;
	cv=none; b=VntJDJ8j7SUx/iMSfjZn2Pyg5bP8ubl4Fl/HYfAU61E16LC2m6/0g59EZYXA+F1EYNIswGk29jZYY9xWw5XoSaGXO+QvKBmgqwvgQIPgiLV34ikZQCfC2Zc5Fms6I533Jw4ScojM2rlwmnsPJpJU99faewsONiYlSl6hwCbyruHhN1xo1H0CdsV2Q+6d7f/5Lai9l+spIxmX7Ypknk/+IM8m6r1uW4YjvuBCjYxuzMmeqopsreFbgUxWs28HECH++/f3rUk5x9aqHok91U35yEs8LdcDTcVRsBKqzj7YaaaLtU875+MtZrDa24MjbazRnexiH3ttfdzMgQy56bSryA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776841236; c=relaxed/relaxed;
	bh=y7FPVHJoaG3puv6XWup3ZPoz+GkNPFrTTayyBuc9srY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njrA9CWuKl7OONpFv8wUvjbdVY51lv5U+KBgu6PqYoNUqQknUIGCN3HWQzlYpnn1PWICgcoithGvNXUTBQxqLuzN3NVj60Wjln5H0j2LdMRrBaxyziSMuMcmsbH1iNrLGxlriKXS99NRvwRpON1kbakFnw/CcYkOdPajVnekuSL86lUwfPuOoBsNXSYfAag4e0ww+mCYGU5F2CVVbhTSzDydAshsuwWgCep+svt2KEvXuiq9rYZ5kUNzzn+rzctAh38+oGb6Z1chiIsBoovpDWh/N5r0FRLT1kbL0uGefEey7F4SFn/I2LcdxO+1mbOW0DbvrOor53op/eddTSsFHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IFNgRYjw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=ribalda@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IFNgRYjw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=ribalda@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0qqk19b8z2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 17:00:32 +1000 (AEST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-674a44b84fcso5954679a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776841228; x=1777446028; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7FPVHJoaG3puv6XWup3ZPoz+GkNPFrTTayyBuc9srY=;
        b=IFNgRYjw9cPIvxwtNzf9bqScR4TUW41lNd2Q25xKQ1tD9mVUHYkyvgkGcpoOmMP/J+
         a9lXC1MvVix79qWv1C1REW4Hlk6Mox7W2kpkyIcbPnyiZadQz1kAhPxaS5hI/iHEw+ID
         ptddPY+okWM3lvCI45O/fMeG9yObMYghORmlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776841228; x=1777446028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7FPVHJoaG3puv6XWup3ZPoz+GkNPFrTTayyBuc9srY=;
        b=rukR3MKWdEDB8SEnMBmRSnXOh4oBDBTzyM27P/tb8HLKZb0wFfC4bD1D8ZSXFL54Ng
         Uv2kdR3QFVDV3hGC5Aeu2j7HO7bOB9Rf0f9JliXwZ/RFZ7U2CBs7yreG7oRk7jrXZ9DY
         2Bv3VMz/H62fm81NRSmDpa4FGqpvIliGNb8c2gXaQLSBCj6hUheCJ9EX+yzQ7l9idpa1
         l+1IihKLXqMo45IHJ5yZvqG0u+aQXObHA49oKIh0wSq0cmCamAdRpsW3r1NRYvIGoJ5d
         u79vXY+9hFue2Uu+R490e4QA0xqB41sSrMJXA6in97OQVa7lmQYIjltzIgM7CeOR48Nj
         jAqA==
X-Forwarded-Encrypted: i=1; AFNElJ9zOXBkkkEquneK5tyGha1xds0AaYgxBlKNFOob9Eo2BVSzTx7G9/JWbTG+opFKkfkWQegavVI7K0UqsbU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxHktYDI5xvBiu4PK42jOaUGSofi2CRYXVxBXaM3+A9bW7o2cZf
	ikvhw0XN3DaYY4sZ85emHZqwBO8az0ahvuvZNu0exCJ7qA4LKbGuQHReGZ4JoaPplzwqSBv7px8
	BBntjsw==
X-Gm-Gg: AeBDievzy1Go5hTkB14O4aBsdzyElLn61VruDyLkTAtdrQduGQDfkwGr1Wq5WjXpYyE
	IJVDZG0w5yjPikPx4Cz/52jgtmIhtwENNQ/QwSMM/xcan3444epGLBeX6xGySvHk07lUZ4/bDwZ
	oVwRTLc6t9Cy/gml2ALfVtTTqIEPyw59y91S7UkYVUwdUxm7g4tF1NIPHsYW9uhYBG2rAazWDap
	+N3C7YXDVaMTt/vgzfijSVrUTaeAhMwM6pNo3P8e8A0uXwtTZtNKPrZzKCYSeV8NspuodaUnf5a
	aKqz5pc+t/+S8znOJAclW4m4Np3Q7NPRRl7hrLyMikKBspGvCzkVz/UUZVmj0nudLwZxxRZhB03
	dwd5OJjJOE/apgLLMB4OmtCdsGJ+/wQN0IkkrWDn5xy4qzDVl2YP6ABDVjO+SSQT5dB+2pYuTjf
	0c//VrEPLdFNzUzPnbJ6QXZLwkOL9xSSmoQIEz3kyLsOAnOonGLA0WFGiC
X-Received: by 2002:a05:6402:35d5:b0:676:99a2:296d with SMTP id 4fb4d7f45d1cf-67699a229e2mr3403513a12.6.1776841227673;
        Wed, 22 Apr 2026 00:00:27 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67316a69a46sm3049931a12.1.2026.04.22.00.00.25
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 00:00:26 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-baa8c78ac7fso139713366b.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 00:00:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8zmGp7NnRjo1bNJ98Z23vH7Olq1Fh4FkCkUi8x/NCGDD9fZrZpPno+lHfLRStNFGFxm460t6KkAm1MFc4=@lists.ozlabs.org
X-Received: by 2002:a17:907:72c6:b0:ba6:1412:9339 with SMTP id
 a640c23a62f3a-ba6141295bfmr736745866b.20.1776841224135; Wed, 22 Apr 2026
 00:00:24 -0700 (PDT)
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
References: <CANiDSCsOy0P1if-gJZqOM5pTJ0RDcwVfru1B7KFbTOEMqjPKJw@mail.gmail.com>
 <20260422071541-9a295128-d913-418f-a21c-1386fca30290@linutronix.de>
In-Reply-To: <20260422071541-9a295128-d913-418f-a21c-1386fca30290@linutronix.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Apr 2026 15:00:11 +0800
X-Gmail-Original-Message-ID: <CANiDSCviww1L1p2+MvF59Biqb6hc7WdL1J37kBjFd1NXz-Yt8A@mail.gmail.com>
X-Gm-Features: AQROBzBGVi8LEvYMOBvlvkNfmwMd-5JBUrvgcCu22OEXpA-bBMJrHFL2pdRz-k8
Message-ID: <CANiDSCviww1L1p2+MvF59Biqb6hc7WdL1J37kBjFd1NXz-Yt8A@mail.gmail.com>
Subject: Re: New warning in linus/master
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas

Thanks for the prompt reply

On Wed, 22 Apr 2026 at 13:57, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Hi Ricardo,
>
> On Wed, Apr 22, 2026 at 11:51:45AM +0800, Ricardo Ribalda wrote:
> > Media-CI has found a couple of new warnings in the latest kernel
> > version for aarch64 and powerpc. They get fixed with this patch and
> > before moving I wanted to know if this was under your radar.
>
> Thanks for the report. I was not aware of these so far.
>
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/M=
akefile
> > index 7dec05dd33b7..65914842fae0 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -50,7 +50,7 @@ CFLAGS_vgettimeofday.o =3D $(CC_FLAGS_ADD_VDSO)
> >  CFLAGS_vgetrandom.o =3D $(CC_FLAGS_ADD_VDSO)
> >
> >  ifneq ($(c-gettimeofday-y),)
> > -  CFLAGS_vgettimeofday.o +=3D -include $(c-gettimeofday-y)
> > +  CFLAGS_vgettimeofday.o +=3D -include $(c-gettimeofday-y)
> > -Wno-maybe-uninitialized
> >  endif
>
> (...)
>
> I'd like to know exactly what is going on before suppressing the warning.
> It is a non-standard warning, only enabled by *some* of the vDSO builds
> for some reason.
>
> > https://gitlab.freedesktop.org/linux-media/users/ribalda/-/pipelines/16=
49144/test_report?job_name=3Dcross-gcc
>
> While I was able to download a configuration from this job and also use t=
he
> same container image, I can not reproduce the issue. Is the configuration=
 the
> full one or only the template?
>
> Could you provide full reproduction steps?

You can try repro with:

work/linux $ podman run -v .:/workdir/ --rm -it
registry.freedesktop.org/linux-media/media-ci/build:latest
$ cd /workdir
$ CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make allyesconfig
$ CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make
arch/arm64/kernel/vdso/vgettimeofday.o

The gcc version discrepancy is because I the error was due to old gcc
version and I was playing around with that... but it fails in both
gcc14 and gcc15

You can try with debian testing with
work/linux$ podman run -v .:/workdir/ --rm -it debian:testing
$ apt-get update
$ apt-get install gcc-aarch64-linux-gnu build-essential flex bison libssl-d=
ev bc
$ cd /workdir
$ CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make allyesconfig
$ CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make
arch/arm64/kernel/vdso/vgettimeofday.o

Regards!

>
> > CONFIG_CC_VERSION_TEXT=3D"aarch64-linux-gnu-gcc (Debian 15.2.0-16) 15.2=
.0"
>
> The linked test log shows GCC 14.2, not 15.2.
> Not that I could reproduce it with either one...
>
> >   SYNC    include/config/auto.conf
> >   CC      arch/arm64/kernel/vdso/vgettimeofday.o
> > In file included from <command-line>:
> > In function =E2=80=98vdso_set_timespec=E2=80=99,
> >     inlined from =E2=80=98do_aux=E2=80=99 at /workdir/lib/vdso/gettimeo=
fday.c:266:2,
> >     inlined from =E2=80=98__cvdso_clock_gettime_common=E2=80=99 at
> > /workdir/lib/vdso/gettimeofday.c:293:10,
> >     inlined from =E2=80=98__cvdso_clock_gettime_data.constprop=E2=80=99=
 at
> > /workdir/lib/vdso/gettimeofday.c:306:7:
> > /workdir/lib/vdso/gettimeofday.c:104:26: warning: =E2=80=98sec=E2=80=99=
 may be used
> > uninitialized [-Wmaybe-uninitialized]
> >   104 |         ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SE=
C, &ns);
> >       |                      ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
> > /workdir/lib/vdso/gettimeofday.c: In function
> > =E2=80=98__cvdso_clock_gettime_data.constprop=E2=80=99:
> > /workdir/lib/vdso/gettimeofday.c:242:13: note: =E2=80=98sec=E2=80=99 wa=
s declared here
> >   242 |         u64 sec, ns;
> >       |             ^~~
>
> The same pattern is used in some other do_ handlers, which do not generat=
e this
> warning. I also can't immediately see what is wrong.
>
> (...)
>
>
> Thomas



--=20
Ricardo Ribalda


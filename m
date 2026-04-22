Return-Path: <linuxppc-dev+bounces-19935-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E5DF94CDF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 08:07:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0sJX6dQ7z2yqs;
	Wed, 22 Apr 2026 18:07:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776845228;
	cv=none; b=UkNSvwRntuz/WeI7moqMpn3tY/jPsZw5FE/MTAp3Ck90JUjpiwAmIGn4N0leJATU3QoHYJSsksmsfzbMSzONMfE3kn/q2Dw4Yb59LTVyURBI7TDq1+gk1IxsOZuIzEYrIkkD7421zfV8U1PQMK1mSlGXvM5XUHT+8HuCTzCiUWGHoRZPUi0iLXjZhDv+cddsQjmLPBDqnY6b2KuTewKHv/U2z875yJltAlKZGXs3yPwyHn3EXBGOb7kbsbSo3pWCmCy52R8R9ozEoTr76p3Qs6zP96767Ua59KsZQT13uX3grCbXo448oAHHzwWK4no71id1qfaR50yCWM5ExafXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776845228; c=relaxed/relaxed;
	bh=+xnVaF+973Zb7xN4UvEz+8ZuM5TVrO0nSR9bASc5gWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIG6f3sZIO4lNhgu7z+7PM5gwoWOikH4SoFtdyGJbsU50pF+eRguIk2vpLqoYSt11msTCSPqRyjPXPP9qPQ2eqo4hJtNe11wegX0M2XhAZNOzrEVr2a8A3F27DG7SvtV1N88DiwWRe+a7VvEyBRbc9Ti4SIBxmjAjxG4t373orjMrXIAKH9HS77WbxxZ6BImZBnWNmG92XUsCiULqwOWowkmYPKt51e230ovBXRCYTgAJd/94NHyt3Q94A00DWuyqOaJ4ZvupvI4KYYXKEEvNv055dAdx02ZMsEJ3MqtwU/H1j0Js61kOUoCGspVhInWHnRvQqFKXYeSaSFQYvlCeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org; dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ICgTSCxi; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=ribalda@chromium.org; receiver=lists.ozlabs.org) smtp.mailfrom=chromium.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ICgTSCxi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=chromium.org (client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com; envelope-from=ribalda@chromium.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0sJW0NK3z2yql
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 18:07:06 +1000 (AEST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-ba36357195bso604812766b.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776845221; x=1777450021; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xnVaF+973Zb7xN4UvEz+8ZuM5TVrO0nSR9bASc5gWw=;
        b=ICgTSCxicEZKAgx/8OL/2KPC/yck9LOZVNQQqL5LgsECCYm2vmq1cH+UWND4Y3yNng
         6SSABnDb3ItL4omMgTaF35fKvS2J5x4Gtncgp63Zx4LMUB+a34Rd5/wfcnk1XNhsKrSq
         NSJtWFf9LIJd939sFbSnoOFbvJGE7qhFwH0Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776845221; x=1777450021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+xnVaF+973Zb7xN4UvEz+8ZuM5TVrO0nSR9bASc5gWw=;
        b=VY6fBZl3GaaDguae47w7v04iEreYmwmWocXf9S0hYMCBV+znJg1LwN+mIgAP5tYfBp
         OX5Cv1iaeDSrBxy/qfjBbcJiAIiwWnppw7prUIoa/jsJTpRMECZGDXLWac0fdyiUZCG5
         5jdEu5/CosST9hsd3JnNxAZMxI8a8Pu1qFQarXLG8huqrgi/Pkm7W01GW530XG07uhbE
         l++NrNgDeEFGlHMvCWrIh+f/J5L+OfnteAiSk1RsIZYOwf5XgXUn/5YOI1kC/essAL+R
         eKyTo9wWAMexwPUi0vFxul6ESyIDcHP9GFGZ1yxNk9lemyS1hmxlJIUq2fdFE3Lq87l+
         nQ5g==
X-Forwarded-Encrypted: i=1; AFNElJ/Bi+OzTiGE7vB/6t2O8XaJiw4wyp7AmrxnFD1iTi4hPFiwJabTQuCjlpp0Ejlt8g2WXHskhG3SnCxMZDI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyX8o4kqjgXpfegF69xhLg34we09gxs4anfvjmQ1P42dWpgcM5k
	pQ7guZ9Ww0jlen74+11i5JTnPRII6FQhDf7Ot8wePr97jXMb+zfMOnzC6jI9LXpUfEYGCfpRcz3
	25l8EJA==
X-Gm-Gg: AeBDies3XUiYj7uyEHAiyI+XFqcxgYbMomCNSNFa1DG8XCNrsZ3RD0xLxVhb5M1SIst
	UNO+PV/wg6JWHDIM0SEbXso87bktYy3qNtebPONAmwDRv8Rph++mZ6gjf1lZTPtbGyEQrSDasRT
	ZjzHJVFEIO0+77zxS+k3LTlVDJBGphthovEVCrG/tCpaX++uGVTVpgYKfqC4aXM3fqj3fXzSdIF
	7kB1PmU+wAjR8YtP1CymQLjaL9TYY0CFjwpGpQ1kN0yESpn1K8DgOLMY89tPH5CW1tvsUiLczEq
	zXVBsgLtK8Izb10BBTfOP3+qlyjZcvYCyN5nFN9IOj7f7ojrhVRiaZWIJ4S7axyzvMx7AYPfg8t
	XbInktaI+CJdjZM6rCHvBD7agDzy/CYSmyqYgDDa6iotT5+3DA02cgV1BU6YI/+V0k0Thk2witV
	wLL9tRgDirepgn004gk2u/7nU/5mwR4TKcQaZR3VEPT4992U6tJAgzDbAm+DElHuktVyp+KCc=
X-Received: by 2002:a17:907:806:b0:b9b:4519:7914 with SMTP id a640c23a62f3a-ba41a82618emr1078507066b.33.1776845221125;
        Wed, 22 Apr 2026 01:07:01 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba6366452c6sm379524666b.11.2026.04.22.01.07.00
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 01:07:00 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9d9971d059so758799866b.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 01:07:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9/8km1g50M1DGmnV4ipmUjODuWiFL96C/DIytsTZMza1gO8+gkMcad8T+gy7qbpUByt0Xy6CjgHZjNcJc=@lists.ozlabs.org
X-Received: by 2002:a17:906:4fc5:b0:b9b:ddb2:b1c1 with SMTP id
 a640c23a62f3a-ba418f7f625mr936456766b.21.1776845219289; Wed, 22 Apr 2026
 01:06:59 -0700 (PDT)
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
 <CANiDSCviww1L1p2+MvF59Biqb6hc7WdL1J37kBjFd1NXz-Yt8A@mail.gmail.com> <20260422092713-4021a1a5-3a54-4260-878a-aec1bef3f8c7@linutronix.de>
In-Reply-To: <20260422092713-4021a1a5-3a54-4260-878a-aec1bef3f8c7@linutronix.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 Apr 2026 16:06:45 +0800
X-Gmail-Original-Message-ID: <CANiDSCtfiPDiqzhjZGoCJbLC0fRoH1HLKrvYUt7jLDYEBQHqgg@mail.gmail.com>
X-Gm-Features: AQROBzA7vfrwO2plpLpwVGaJQHR2MKiQUcm7cyVmWYAcKsQQIyoUjhDJYfCBMLg
Message-ID: <CANiDSCtfiPDiqzhjZGoCJbLC0fRoH1HLKrvYUt7jLDYEBQHqgg@mail.gmail.com>
Subject: Re: New warning in linus/master
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas

On Wed, 22 Apr 2026 at 15:32, Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Wed, Apr 22, 2026 at 03:00:11PM +0800, Ricardo Ribalda wrote:
> > On Wed, 22 Apr 2026 at 13:57, Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > > On Wed, Apr 22, 2026 at 11:51:45AM +0800, Ricardo Ribalda wrote:
> > > > Media-CI has found a couple of new warnings in the latest kernel
> > > > version for aarch64 and powerpc. They get fixed with this patch and
> > > > before moving I wanted to know if this was under your radar.
> > >
> > > Thanks for the report. I was not aware of these so far.
> > >
> > > > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vd=
so/Makefile
> > > > index 7dec05dd33b7..65914842fae0 100644
> > > > --- a/arch/arm64/kernel/vdso/Makefile
> > > > +++ b/arch/arm64/kernel/vdso/Makefile
> > > > @@ -50,7 +50,7 @@ CFLAGS_vgettimeofday.o =3D $(CC_FLAGS_ADD_VDSO)
> > > >  CFLAGS_vgetrandom.o =3D $(CC_FLAGS_ADD_VDSO)
> > > >
> > > >  ifneq ($(c-gettimeofday-y),)
> > > > -  CFLAGS_vgettimeofday.o +=3D -include $(c-gettimeofday-y)
> > > > +  CFLAGS_vgettimeofday.o +=3D -include $(c-gettimeofday-y)
> > > > -Wno-maybe-uninitialized
> > > >  endif
> > >
> > > (...)
> > >
> > > I'd like to know exactly what is going on before suppressing the warn=
ing.
> > > It is a non-standard warning, only enabled by *some* of the vDSO buil=
ds
> > > for some reason.
> > >
> > > > https://gitlab.freedesktop.org/linux-media/users/ribalda/-/pipeline=
s/1649144/test_report?job_name=3Dcross-gcc
> > >
> > > While I was able to download a configuration from this job and also u=
se the
> > > same container image, I can not reproduce the issue. Is the configura=
tion the
> > > full one or only the template?
> > >
> > > Could you provide full reproduction steps?
> >
> > You can try repro with:
> >
> > work/linux $ podman run -v .:/workdir/ --rm -it
> > registry.freedesktop.org/linux-media/media-ci/build:latest
> > $ cd /workdir
> > $ CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make allyesconfig
> > $ CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make
> > arch/arm64/kernel/vdso/vgettimeofday.o
> >
> > The gcc version discrepancy is because I the error was due to old gcc
> > version and I was playing around with that... but it fails in both
> > gcc14 and gcc15
>
> Ack.
>
> > You can try with debian testing with
> > work/linux$ podman run -v .:/workdir/ --rm -it debian:testing
> > $ apt-get update
> > $ apt-get install gcc-aarch64-linux-gnu build-essential flex bison libs=
sl-dev bc
> > $ cd /workdir
> > $ CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make allyesconfig
> > $ CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make
> > arch/arm64/kernel/vdso/vgettimeofday.o
>
> Both reproducers do *not* reproduce the issue for me.
> (It is more or less exactly what I tried before)


Ok, I think I found what is going on. media-ci was forcing
KCFLAGS=3D-Wmaybe-uninitialized

https://gitlab.freedesktop.org/linux-media/media-ci/-/blob/main/test-build.=
sh?ref_type=3Dheads#L29

And something has changed in the kernel in the last version that
triggers a (hopefully) false positive.

can you try with:

CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make
KCFLAGS=3D-Wmaybe-uninitialized  allyesconfig
CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make
KCFLAGS=3D-Wmaybe-uninitialized  prepare

?


>
> Please note that this line does not work in general:
> $ CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm64 make arch/arm64/kernel/=
vdso/vgettimeofday.o
>
> The vDSO object files can not be built in this way like regular kernel ob=
ject
> files and will produce a compiler error, but not the one under discussion=
.
> Instead the vDSO on arm64 is built during the 'make prepare' phase.
> (Other architectures work differently, of course...)
>
> (...)
>
>
> Thomas



--=20
Ricardo Ribalda


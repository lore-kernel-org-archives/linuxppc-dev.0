Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4940C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 20:06:52 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC20A20661
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 20:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lNOw7caF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC20A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ZgBd6NSkzDqgH
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 07:06:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::a44; helo=mail-vk1-xa44.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="lNOw7caF";
 dkim-atps=neutral
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com
 [IPv6:2607:f8b0:4864:20::a44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Zg8w4WmFzDqSM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 07:05:20 +1100 (AEDT)
Received: by mail-vk1-xa44.google.com with SMTP id w72so1956369vkd.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2019 12:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ir2gy1vI+QuEjLbaEs5X765OOqWePEa4uQXeCPwMJG4=;
 b=lNOw7caFXMuA6Gl7KQBr0CksbMGZLvtGfgLF74Td414lwed/G2VRgCI09yjhM454Dd
 hbPRb4NaqSNz4MMly3zdrmWJ5kHlN/oOEsKkzSRMkgNVgFoGYOEiFi2pka9FFNu+pvUq
 ZELyesivcCvJ7LJhPXU2JLBlBDhztkvan2Zjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ir2gy1vI+QuEjLbaEs5X765OOqWePEa4uQXeCPwMJG4=;
 b=edlIwewW7gf/6Evh0Z1iv38OmmaPvgqbmnGyoud71dtYSEaVIFyZZxiLa4u848nwQn
 om1GimuOorIOvOw1lGXXPEpXWVO07W4C0fz+plX1tJ54yyfzBTdL1Pr8rzo3udsziuh0
 uct40MldyYigg7fKRsZDrJd+JOnaHnxHsmFiHQD5n/A+WaVqMdKLU33c1vy/iqpYHPZS
 c/Gd9gjqeOlFPrKCdrmtTD6nntnJrGpPVwIrvDP1S1c5EyDEmdF0SHFKwhfVlv9m63lq
 JQLgNjgN3npaMxSg7hzHqa7uF/dLf2g1lAPT47AZ6sZSBU8OulfNiPhSDyMUzNLw8Ia3
 Sunw==
X-Gm-Message-State: AJcUukeBO7YeYDj4BeWBbAubuD5v6CfoCcLfzzwzT6J2PIBhT0aPG4p7
 O4logEcQokUMUV5iAlb3dKTnz4Y1Lqk=
X-Google-Smtp-Source: ALg8bN5ysFYx6/jbHcOcEDk3aymnGEVZ/jeae2AHYYcqCmwOSUZkqTd7/sPvRwwc1aD3DPpOQwbNFw==
X-Received: by 2002:a1f:6bc8:: with SMTP id k69mr863947vki.84.1547064316661;
 Wed, 09 Jan 2019 12:05:16 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com.
 [209.85.217.47])
 by smtp.gmail.com with ESMTPSA id e67sm35447477vsd.32.2019.01.09.12.05.15
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jan 2019 12:05:15 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id n10so5524667vso.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Jan 2019 12:05:15 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr3106997vsl.188.1547064314501; 
 Wed, 09 Jan 2019 12:05:14 -0800 (PST)
MIME-Version: 1.0
References: <8593f7faf89812a9987d44d9ae615d64dca4d77f.1544800744.git.christophe.leroy@c-s.fr>
 <CAGXu5jKeGp_z_69SybtkSaE381Ui7aXCxp9yBxv=TS0=hSsm-A@mail.gmail.com>
 <2d2e8cef-dd12-75e8-4779-fe4437e2169c@c-s.fr>
 <CAGXu5jKUArQAkirjTTrPM-xayT1aYEGzmyveDZwrLuqmvRqD+A@mail.gmail.com>
In-Reply-To: <CAGXu5jKUArQAkirjTTrPM-xayT1aYEGzmyveDZwrLuqmvRqD+A@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 9 Jan 2019 12:05:02 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK1En85PMUgHbzHoO2U84FiNoJLPF0rUXeyPaoY6GXEEA@mail.gmail.com>
Message-ID: <CAGXu5jK1En85PMUgHbzHoO2U84FiNoJLPF0rUXeyPaoY6GXEEA@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: Add a tests for NULL pointer dereference
To: Christophe Leroy <christophe.leroy@c-s.fr>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 9, 2019 at 7:16 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jan 8, 2019 at 10:31 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
> >
> >
> >
> > Le 09/01/2019 =C3=A0 02:14, Kees Cook a =C3=A9crit :
> > > On Fri, Dec 14, 2018 at 7:26 AM Christophe Leroy
> > > <christophe.leroy@c-s.fr> wrote:
> > >>
> > >> Introduce lkdtm tests for NULL pointer dereference: check
> > >> access or exec at NULL address.
> > >
> > > Why is this not already covered by the existing tests? (Is there
> > > something special about NULL that is being missed?) I'd expect SMAP
> > > and SMEP to cover NULL as well.
> >
> > Most arches print a different message whether the faulty address is
> > above or under PAGE_SIZE. Below is exemple from x86:
> >
> >         pr_alert("BUG: unable to handle kernel %s at %px\n",
> >                  address < PAGE_SIZE ? "NULL pointer dereference" : "pa=
ging request",
> >                  (void *)address);
> >
> >
> > Until recently, the powerpc arch didn't do it. When I implemented it
> > (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D49a502ea23bf9dec47f8f3c3960909ff409cd1bb),
> > I needed a way to test it and couldn't find an existing one, hence this
> > new LKDTM test.
> >
> > But maybe I missed something ?
>
> Okay, gotcha. You're getting more complete reporting coverage. Sounds
> good to me. Thanks!
>
> Acked-by: Kees Cook <keescook@chromium.org>

Applied to my lkdtm -next tree.

--=20
Kees Cook

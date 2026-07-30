Return-Path: <linuxppc-dev+bounces-25137-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C23BC5516D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 20:44:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB1QZ0bVCz2yMn;
	Fri, 31 Jul 2026 06:44:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::536" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785444262;
	cv=pass; b=Gx8BYQNOpDvZQJVhCGSmWgjNDqucRVu18INqqYHcOZPLCaGnm/XyLdZuLHlPuWQihGuSJtbUFCkdKMGzmH7BRSXQf8Ac98fl0LgZrP1ZF60/h9ngRWwEArWT4M5XH5/wPTysiFYy3w+l6HxPH4ZLcMuy8+m8CA2XuPTCLHMhjvyy3UuehyLnVCr5ZEDARiV/tUdTT8E4LN9u8NPR9Jbx03e07mITK4rwKlcxRizLvcwyrufkplCeb/mS3vYBSkK8s0+3QlPKKX5ziTS6SiOINT4Tv3FLdB5cCYJmfwOkkuUwjwI6udVDdrG3tqgWypkLqGYDMhhJ7oe4vuEJXajwTA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785444262; c=relaxed/relaxed;
	bh=7krrGD9WM3wP2p7EjFIybZWxvqaAPH6bQoTBvIKjdQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3SLwH9xcu6JLADaLEef+Zvc2FMAyEl8s6n+hRW/2INVIjZl/uuzZjvwGR1LD+SrpK7WDKcZu+Ag2gDtPi5HGBWFUg2pXB47O5dlmXp/mj7gGdKCVcs+pQQFxJ1Lk0hDColTZWqQY3crRiKTAFqegrij/8byzgyMXsBTb3Yf/IPYZAl04E2rLrFVRjFQNIch51qd7ObRQjz7hHG9iTes1PHRhHumPogY8GZ0gu0lDmu6Gt+QTEKsDCW76CQqbyCiYJYA4zokeM2Icy8ldcY5WJselI/9U7NJAl9ENL8tvZ2MqLBWaCE63KVyqLhDgJfcXs49e9xj09Nonm9GwGcDYg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mYWth8PW; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mYWth8PW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB1QX388xz2yH4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 06:44:19 +1000 (AEST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-69fc6a09b5aso441258a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 13:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785444256; cv=none;
        d=google.com; s=arc-20260327;
        b=QeIcVi631MYUCh03Y5xDQ5eGoQm+R5R7lMDIyhe4ZkYMTa6lGeCIXq0MnW+tbX0nT0
         2Wvh35YXfGfAfd96wKMr8tL2lJT32z7Reezr8u1Snak4bnmp9psdIU3UgSRGhpzAFKaM
         t8j6iYPmEgtbdr6MgWf2IXWVbu3mpHgeHaG7C8/F4705X/hrI6omRScZfm1KgC4UFjI8
         yaMh/Iby/iO4o5yCG+mJWxpNl1hfLH1t91Z87mxcNwajmO8DyDqt9zCMktTmk26MyAmE
         SmxukiJnU9Qx7+ba0/MURUN6ir/NXns9Z7L2J8pJZQPG0gwRTyBM5fEmm3MUjkYvh1Dd
         pi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7krrGD9WM3wP2p7EjFIybZWxvqaAPH6bQoTBvIKjdQk=;
        fh=Z+xfdWOEIrtd4C5dNzzX3bhDufjWoxkuCT2oGKMp1Ec=;
        b=eHuVwyryXlCkH6E4qQFjK2iQOPyuYRXkIq8lhP0Yw7Wa6e/CIbTxwHeIe1OVyfPZHI
         Ukgx2h5q6L4UcpoBvlnQ1dv6y2/fvUtw35XCRELuDWRrN58grn+FA3SqrOAjLBeKxUab
         i0mbm5U0ufwDpNM1imtDr5vKgmTGUs778M7yPkSj0dyKCTp6VjuVE+ElKh7CC0z9CGH7
         bom0HhiBnCzSLln/RNQDgmVmSWzYdkvGtbb4qGhPLrWjXkJhlqJffoo2ToTtP/zUoabB
         d2zftA9fsdkZ8DEfFR0B7SPEHL45kMCyuaOTOw8cz5ZricB2vdqiqEAvi0pOxsaHojSO
         4hKA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785444256; x=1786049056; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7krrGD9WM3wP2p7EjFIybZWxvqaAPH6bQoTBvIKjdQk=;
        b=mYWth8PWWb/vi305PYqoTWcxcMiMjH5tZVpUH0dH1mqHCnbwwz/vrefX4qgxaVl3IM
         xst5mX0KChf21Bm2FWVaL/yjVH04uBB/FQ6qNykoOwc3JQiNBqFtpvKJgo9biJS6uBp6
         D0uqaZHC1FOrLozUMRnn60wvG9krA5KZgXXCM16s+P5/pAVolwem5vGUfhBP8kojId60
         Q3I8TsQWq+Jpafigrlp6JD3mBDnVKtH7vOiHE5hxQuEzi8IDO2F5Nl+IRZsbI3/V3VJQ
         MqfMjqVH4Wv867btBMoIJzjPoycx4fnsg9LD3/F9ruiVEmQgDRPeZlbMyeXrhwqfk0k3
         6d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785444256; x=1786049056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7krrGD9WM3wP2p7EjFIybZWxvqaAPH6bQoTBvIKjdQk=;
        b=E50nU9yLg6+gWpVHUwfSkXQE1ecVDykV51TZRLg6DJDRveXTAADBUvnj/Pk17cKq04
         QjHjKXphk4Qnr5u0Mk7udGCSZkCpwHcD4GsTi5T8LihXR91HwZtzUrstsToYeh3mx0Xn
         OHCz8Ac4KUObUsnsoaEL3IcqPJS2uNy0jM/zHO9e0aCBslVhIEozj1LBPnAM4e//hj5J
         F5KSSYeSWtncs0izsGQBk63OWIWILG+uf/Mo7IZOAeAGLMrXA8EZ/ecHL4B7fDNliEw1
         Qi2pDP8FBklWRBdVExHH5fn6/+1jdRRPSwHcgJw/jeYfKyVuSWG8FELPexylKX1TuoJx
         H7SA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3BV5iShXw4oYV3gGj9K1D9h/Mc4UydyS/J7PeTEq3LJW1afAOK7yMHXvzqZXkglNNqe6F/cv8NdRTc3I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YweG4xGL8LSSZ8Xz9tZ6Yjndy5OclrQ0O6HLQ0fNdx0q8OO9iJn
	C4gEFPFnPB1Sfi0YQRfvDX8zUEfthej3ChySebGPLHUjhQPwhHzw8Gya2tMTM/vdJUdGLIpqw8p
	9Dm72VEKSOWy63tfiFA655VpASPSthEs=
X-Gm-Gg: AR+sD11Csnq77e0jgSmGe923Lj8NuTBG6GW7UdvFa7Vq/83uKQVjjSxWvB9MUI+3cd4
	HugMsQTL2DA02PQ5s9JMPnH/tgYuvjbnYcUnwEcJ8KCvjmEW5me1WhBDEvTg5VlwiZy4ZjDpLn+
	EIfTbTg39plfMosmESy6OC0lWrQxW0ojvSoeNMOuXOSRS3tm8/NDj6PRjRrB3PbHUR8VbhLUm6P
	3TIYeCDLCSjMJChxwP9o1J4R50Z8L3gwR7wck426QdZUD/UHPFkf0q8uh3oEzQH672bxQXdAMiq
	U/95SMQ+7b8VyBMqDiXbRnfAs+4tR4rYIgreC4GyCO8BPfYhzcnyTcUJPM6ZUmG9Ui7AVc78OSF
	ZzGJy6SwkzsQE2mRQKYYW0DzYKU9/UOXkJvFR1UA4EEktQXwyFQlF3BoGSuLM2nvAI/CJRy7E3v
	dWZ02WuP1iS3kzYIbBwboDJNaV/nAii0dD2UwGo314djbw9uqeGC++8Ii+
X-Received: by 2002:a05:6402:5288:b0:69f:e196:1213 with SMTP id
 4fb4d7f45d1cf-6a090da1ef8mr1003480a12.28.1785444255884; Thu, 30 Jul 2026
 13:44:15 -0700 (PDT)
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
References: <20260602050131.856789-1-rosenp@gmail.com> <20260602050131.856789-6-rosenp@gmail.com>
 <CAMRc=Me0rqs8nxrp95X-2Bjw059ahRxwKrg-NtmEt025w2m9bw@mail.gmail.com>
 <DIYGFNLIFBW7.21W9J6SUGYF72@gmail.com> <7ee42722-f7f9-40cc-a576-5f85e3955537@linux.ibm.com>
 <CAKxU2N8n4iHrr-+NxL6D9WZ4EgH_XVJ7yfPa4P6ZyFNJTir60w@mail.gmail.com> <880aae3c-a552-4d3f-8ed1-e3dc3911ee1a@kernel.org>
In-Reply-To: <880aae3c-a552-4d3f-8ed1-e3dc3911ee1a@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 30 Jul 2026 13:44:04 -0700
X-Gm-Features: AUfX_my7A6QKyTc9STOnZDQVN1ZhP0FUsC3gLrEqPLkUxNe872gyKrAyfUMD0RU
Message-ID: <CAKxU2N-h2amT8KMZ-Vm+jvVekbP+w-n3=tenkEOtmuQNaBWQcw@mail.gmail.com>
Subject: Re: [PATCH 5/7] gpio: ppc44x: Convert GPIO to generic MMIO
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 10:49=E2=80=AFPM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 29/07/2026 =C3=A0 20:32, Rosen Penev a =C3=A9crit :
> > On Wed, Jul 29, 2026 at 3:55=E2=80=AFAM Madhavan Srinivasan <maddy@linu=
x.ibm.com> wrote:
> >>
> >>
> >> On 6/2/26 2:56 PM, Rosen Penev wrote:
> >>> On Tue Jun 2, 2026 at 12:51 AM PDT, Bartosz Golaszewski wrote:
> >>>> On Tue, 2 Jun 2026 07:01:29 +0200, Rosen Penev <rosenp@gmail.com> sa=
id:
> >>>>> Use gpio_generic_chip_init() to set up the PPC44x GPIO chip
> >>>>> instead of open-coding the basic get, set, locking and state handli=
ng.
> >>>>>
> >>>>> Keep the PPC44x-specific direction callbacks because they still nee=
d to
> >>>>> program ODR and the OSR/TSR registers around the generic data and
> >>>>> direction registers.
> >>>>>
> >>>>> Assisted-by: Codex:GPT-5.5
> >>>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>>>> ---
> >>>> ...
> >>>>
> >>>>> @@ -124,10 +102,11 @@ static int
> >>>>>    ppc4xx_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int=
 val)
> >>>>>    {
> >>>>>      struct ppc4xx_gpio_chip *chip =3D gpiochip_get_data(gc);
> >>>>> +   struct gpio_generic_chip *gen_gc =3D &chip->chip;
> >>>>>      struct ppc4xx_gpio __iomem *regs =3D chip->regs;
> >>>>>      unsigned long flags;
> >>>>>
> >>>>> -   spin_lock_irqsave(&chip->lock, flags);
> >>>>> +   gpio_generic_chip_lock_irqsave(gen_gc, flags);
> >>>> If you're already doing it, can you use lock guards too?
> >>> Sure. btw, I avoided placing
> >>
> >> Do you have plan to address this comment in v2
> > Yeah I have it fixed locally.
>
> You should probably put patch
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260517063754.21=
819-1-rosenp@gmail.com/
> as first patch in this series in order to enable applying the fix to
> 6.18 without applying the entire series and to avoid any future conflict.
Not sure what you mean by this.

I assume the simplest way to proceed is to wait for that patch to be
merged first and then proceed with this patch series.
>
> Christophe
>
>
> >
> > I'm not sure if this has to do through the PPC or GPIO tree.
> >>
> >> Maddy
> >>>
> >>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ore.kernel.org%2Fall%2F20260517063754.21819-1-rosenp%40gmail.com%2F&data=3D=
05%7C02%7Cchristophe.leroy%40csgroup.eu%7C2ac0ec525c7045cd969508deed9fc7e0%=
7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639209467691381845%7CUnknown%7=
CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIk=
FOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DiqGebSy%2BbKMBFZz%2FZwZ=
9N2Jf8v63FkGPNhrdUf864fE%3D&reserved=3D0
> >>>
> >>> in the beginning of the series. My thinking is that's for older kerne=
ls.
> >>> I believe either the generic API or devm_gpiochip_add_data fixes this=
.
> >>>> Bart
> >>>
>


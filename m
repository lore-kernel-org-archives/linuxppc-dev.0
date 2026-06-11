Return-Path: <linuxppc-dev+bounces-22510-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFCDCD98CE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 16:08:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbndL5jtNz2xfB;
	Fri, 12 Jun 2026 02:08:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781194134;
	cv=pass; b=JJPgIdm7wIIR9+pqgQR+cmJWf2ndp6Lhr52znF5W6wh1NFy3VgPc0xf7zp6SFpAiKiO+x0r+TfONow6eXrpEc7PZk3h2n7LXp9h5h+r2/oOxRWgPLZV4e9PQSma9YfnO2FxcGR5XgIWZXX4qb9wInJy7utIjfFFKSITX7Re7gsEgcoETXptUuN2XBnpUOryqV5b/YswpbyYqmJW6CaYwroj0U3UynRiAK+sI822qoBcxk2mbGDrQpa4dxd3GjxCpBcyqNrf2liNRlGfbQ0S++vtrly/anjzAqHm5I72gSeahHvpnVxDJWH7081B7IjNjqND3TO3vnMLgC5VUd5+Yxg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781194134; c=relaxed/relaxed;
	bh=0BPhvT50VQuK2+y7zbXq9J0IJLvfRaU5Y2kOZciKetk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp70eaFwp9dyJ8nHZ1A/ID1Ek4avu+BZF8y+BJ32airYfHgZifEMb45eTn5Rlmq+9JBlA9NmvHAsnrJpnCHvnOdt4/4SRXBWAVJM9k2qFB+J0PBggozMoYgcGhlb2618liTAFWWZSRUJMtLVDYGVZs2OFHisdByq/ezcjYVQmDWGzsmmJe8JL6anO/5bcfuxdOaiaQWuJAmIQe7F92r6Ak/2Z2gAPj9gbGRD9WHEozWwtCVLDIXEMmwh55k45GKi7HKmfFHfkt4iD1HrOeAB9CWiOeas+iEPaN31xXYCW9C/ATowoO9/xYexAE9uFiz+sixZyqWHOetr05ubY9pwDw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pxM+hCZG; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pxM+hCZG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbndK1nLWz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 02:08:52 +1000 (AEST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so861166b.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 09:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781194125; cv=none;
        d=google.com; s=arc-20240605;
        b=RhdQpyrwkP9WoodULGZstU5d1RLjYhiQr09RyMwOk/wvENocLIDuIrd2nF4MkweJdl
         ctPwvh5yKqTlDz7NaD9ILRs2p02t5iS78I6k65FVGBiOvWys+jo7MvyE6hPIdm7it3Zj
         3Dx7CgKb2nbN73jybB8Hpwks++XcLGiKqRP36NfJ2no0mzqM6a6vGaFKUy6qhtN8rlNb
         nZnoZOGAbpNQvGsdrRjLKA+KNT446MQvE63UPU7BngpyZy/b/Y0mQgdwyVCPqupssWqX
         rDVR3lKfAZUoJnijpR3e/f2/QnWFQnSGAbXWNasSVKbcewqgpZ0sxFVTQBv3K+P4hKCi
         Lgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0BPhvT50VQuK2+y7zbXq9J0IJLvfRaU5Y2kOZciKetk=;
        fh=t20Iac9UkHx2QXbvof4BY1HebMbjKOt5g4aHtio7VAw=;
        b=T2js24nLxrKlB4kCnAV6yZES63CJbdt9UtfCbiPEubF8y8eCdBU3oGFmWorOjL7vsh
         qzUs2gl+xhr6mKR9GKqlTZVi4rc2W/pgBBLdwgjiDd5xxb+QscxpcbNtXKBSnHLa+Ket
         W5XO7G1rkBWqlZbd1A+qPUYzvXF2bYmDBlPMYpCHK2XskTmsVesN/eejRheUGIF1hCPg
         AGZo2uKdExqRfoL23DvOmdcqbA3khYz/5zI09W2X7y5rXygYzuXHJEMAO2CGStN++lzx
         VunBf07gu0NAO1f9MlKxPyyl0Ewhm+CK+yi879yTA8mIDzE8K3re3kCxOASWLors5QwV
         YR5g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194125; x=1781798925; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BPhvT50VQuK2+y7zbXq9J0IJLvfRaU5Y2kOZciKetk=;
        b=pxM+hCZGgnzi3TgJgpUqWVTVnPyQlB9uHEj2C+HB+DRaY9l/KK2Hpxd0jbEhuBtVCB
         v8a9Yxl2MKgA+DTAljJTZ6ySrheBkEne4RvaFW7BCgSu1EyDsc9lDfnwm05OYn9UQ0mL
         LEzi+YRDcznFPg2q0yDqyC8OvIN+HxMcOArpVSvh9vZNSbmws+LEJXrYoCoFECeHQ/rr
         LcLWfQ1o8LN2GGkX41rR0W6BL71NQai6tnawIEpnXMw0jRSSt9XIi6Ci2byWUYq6ZvbW
         0u/u4H3nz/Lm6sJKHAjlYadzymZh4pE1UJmsiA2hAeAMoaB9QjdwTRg0D/tS3/1iFZwO
         QVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194125; x=1781798925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0BPhvT50VQuK2+y7zbXq9J0IJLvfRaU5Y2kOZciKetk=;
        b=qQrv3p9EBP13be+sqF3YjimDkO9u+MhhYQ8PcXGSgAeanXQZIGyzMMmGM0ivAbLGed
         4bpHVkvfY7JEvoOJBI0A6LC8bPeFiGEmHLgoo2mnXCp+AP0TtwqDC8bxhJ/OFdM3y54O
         rc+NrgGG5OWp9Z2WXingIVextXOeoQgmDc6ihlalu7DyFsos49gSs5ZbnTVEtueNo02K
         59qYfjbXpxWWVYaqaxN3UKUlKoY1dCe35r9x1I71MpzBcW5aSyvOf4dotM0hi9boZE/Y
         uYhTG3Dhytds5DiZst2gSsb8fWeEmHbAqW9fPDvRu7nTr7i8V766nz+VkD2uRir0+pLD
         Wpzw==
X-Forwarded-Encrypted: i=1; AFNElJ8QOtLDH3DuJU2z1QAMVAlFpWsk1Kzz4kZ2T149wprK0xDd8zeNsOfN6D62zrLiDDU4aicX8N42fVebCGE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx+Hpv2iedcjZqmGEYgHUpV9n/FiTKBjJTkXU6xR9QUeP0UgvHc
	DSakVsbC0eOH3ZAMuLXUrik2bCWuThUVL2GjqYhbGIK9VnppQCgqeaSEVDhASQEqEcEbDZw1Pf2
	AbJd1culapIGtoeI46VuP+Pf2lA6/Isk=
X-Gm-Gg: Acq92OEp1I/2bxbJYzvCbtKXAQERBmttzJKBUjhZqpgOvY3wpSQf05kxFAjK4GmnNBo
	Hv3sAGMHYY3SkCa5QymOvu4mS3NtW2llzWtAT0GPmlXgQsxSuIzEN1/3bT5DWyYwdijKcL1i+bb
	MLFToMsG0qYon8TY2DWd317fwjCT3lP1TXucgCJ07DZ2A2kj3dOEbuE2aRxSgNuj9Z4Ob7UezyQ
	fjvzf0/iTNumUFBm/8REbUn1EWXAzt+dyv8a5rec4pVsDHK5jmMbWgaPWIXihvnwnDnT0+1vp/t
	V6oFNcyOf5OCC3ndu9pZ3BbMBQnh0s2YPtpUAvtyKLYsOuBluji7rDG6/2hCgIAFtaVNvIggp1C
	CNfBNcc2nTrsDb/dxaGcSG+/emN8K5qTtnYXJKMYrb3pRvjAXHJDbwvSc
X-Received: by 2002:a17:907:1dd8:b0:bec:f0bb:66f5 with SMTP id
 a640c23a62f3a-bfc87c0cb2bmr131123066b.30.1781194124409; Thu, 11 Jun 2026
 09:08:44 -0700 (PDT)
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
References: <20260611035245.13439-1-rosenp@gmail.com> <20260611035245.13439-12-rosenp@gmail.com>
 <airV8Wm3yyY4hTQP@lizhi-Precision-Tower-5810>
In-Reply-To: <airV8Wm3yyY4hTQP@lizhi-Precision-Tower-5810>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 11 Jun 2026 09:08:32 -0700
X-Gm-Features: AVVi8Cd07wPKVB64G5JpfGCeLGfe3Dlz_RdVLBiqMrIH7Js6qZaJUTS5GxMh3qw
Message-ID: <CAKxU2N9QNMo9u0s_MfYG8qfiWsHqwuB9ax_qbf6gbxA0syOiaw@mail.gmail.com>
Subject: Re: [PATCHv4 11/15] dmaengine: fsldma: convert channel allocation to devm_kzalloc()
To: Frank Li <Frank.li@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Zhang Wei <zw@zh-kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 8:36=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wro=
te:
>
> On Wed, Jun 10, 2026 at 08:52:41PM -0700, Rosen Penev wrote:
> > Convert fsl_dma_chan_probe from kzalloc_obj() to devm_kzalloc(), tying
> > the channel lifetime to the parent DMA device. Remove kfree(chan) in bo=
th
> > the probe error path and the remove function.
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
>
> If use flexible array, needn't allocate channel
Not sure what you mean. A regular array avoids that as well.
>
> Frank
>
> >  drivers/dma/fsldma.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> > index e4a3315a7d9d..0df09789187d 100644
> > --- a/drivers/dma/fsldma.c
> > +++ b/drivers/dma/fsldma.c
> > @@ -1114,11 +1114,9 @@ static int fsl_dma_chan_probe(struct fsldma_devi=
ce *fdev,
> >       int err;
> >
> >       /* alloc channel */
> > -     chan =3D kzalloc_obj(*chan);
> > -     if (!chan) {
> > -             err =3D -ENOMEM;
> > -             goto out_return;
> > -     }
> > +     chan =3D devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
> > +     if (!chan)
> > +             return -ENOMEM;
> >
> >       /* ioremap registers for use */
> >       chan->regs =3D of_iomap(node, 0);
> > @@ -1200,9 +1198,6 @@ static int fsl_dma_chan_probe(struct fsldma_devic=
e *fdev,
> >
> >  out_iounmap_regs:
> >       iounmap(chan->regs);
> > -out_free_chan:
> > -     kfree(chan);
> > -out_return:
> >       return err;
> >  }
> >
> > @@ -1215,7 +1210,6 @@ static void fsl_dma_chan_remove(struct fsldma_cha=
n *chan)
> >       tasklet_kill(&chan->tasklet);
> >       list_del(&chan->common.device_node);
> >       iounmap(chan->regs);
> > -     kfree(chan);
> >  }
> >
> >  static void fsldma_device_release(struct dma_device *dma_dev);
> > --
> > 2.54.0
> >


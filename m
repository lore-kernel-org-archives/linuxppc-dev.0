Return-Path: <linuxppc-dev+bounces-21963-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE31CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 09:39:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVjMK5XYvz2ybQ;
	Wed, 03 Jun 2026 19:39:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::530" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780479549;
	cv=pass; b=K8KMObbDJ0mR9jdNylBqlgEFd/tV2nHSAyQ3Boc+HMDYny/TTDi2Sape1Cq1OZM5VNbJNHQYnpT546hH+QEHMCLLFNPuZUXm1kcMhrP1J+aMK5mgidcZpMfD7svd9eAJh5LdUYS37cXEgBkwwnqx0gGgvIltDS7h+XqNUvC2vVOJBAP7VP+CDpf2G/1QjX1Fpb+4OwmAnm3ZO3KZae3rqfiJcMKSkh29ojEmHuTh+AOYjXPj4dwXljQtPuqLKh+MtaFo6r/XWP7b+DP2fj4/piPiF9m8MtY0wvdklkNKcIii+/IjhgULl2j2m2A3cFu0wQEXow62CMpfNqup5modew==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780479549; c=relaxed/relaxed;
	bh=SwXKhIJjZGWqX6uBB2vnznJQiVYEOuhYWUEkVzvu58Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SugNPJQbiapS0ui4CdSJEBW7lLhpAcsdAWtySEDdY2POJBa6VfFmmBlMa/+BXdejhudR+KI3Z3uGB8xdh/lMVWjlHrB/alg23p9d67Ukkki9pKDZZv75iTnNDqj3ZFCRxMJR8uRFAWJg1QSRYJtMGdesJOHA4cFCcMxpViHevXlak+87KpIXc+4Dq+K1/7n7B+2qx6/wfYlcTEp8ypkl2wfY/kiHd6pXtBIOGdbSC8gUO+ecVA/CdPBdcx8n27OCTtYdVLeyi3onjmCP/BapS20m0j3+jX+XoDisfSmvFgVoHUkwM8Hyk+22SzISIuduA+BahHHAvrU3iOKgtQSDVA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F0Fsg1e9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F0Fsg1e9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVjMH4s2Gz2yH5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 19:39:06 +1000 (AEST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-68d234218bcso83053a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 02:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780479542; cv=none;
        d=google.com; s=arc-20240605;
        b=Xt+sXADFLelMPB/vKw7VEhaIITpM1CvQrnAbyBQRcF3pdzq9RfPjchh46AomyHWTaS
         v5f2RyWGTRNDQdO1pTY5glJKi0cHsHlWOpUBCwTfzRcZiLVAzYJgAHZWAXlgMbYd9mwr
         /s3FWgUPFTzNXpHhSjDqq9yhZ7TjIMSlyPkoOoSEj9c2dPkjpcEXYaYYzCGB6Y4htLBJ
         Du1oxjpb97XrDBZut9fZlevbeynaN8/7EY6wwHWn2VjV7h7iX8orlYsPia40Ph9EnVH1
         iLxD8Lr4KSEDoSh1zpdPPeJ7hRQW7ZePBh6oO1HzSSZFa+esAm/BYtUcAOzSHDUxrZmV
         C75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SwXKhIJjZGWqX6uBB2vnznJQiVYEOuhYWUEkVzvu58Y=;
        fh=bkj6a8IB4luldzIviUmhWb6PSfuwcvxY/UwHXPTfYMk=;
        b=HIYrgLYpRzjXckaEcaMCHXenbsUxgQpfqaeExOuMp/6r4NswBqbqg/2HkaHYnDssPA
         kL2rBL6467Or7mUFZd7DUe2mWO8xumr1at7bEeFrL8bUSKRBfzkQbGMplp7hEszTRmJQ
         uYKfZe4jAufJ5UJsWZ9/FqvvQM6tOizvT5dPH9oduYbq0NkljHjqFOABNuYDfVWGcBpv
         1Lc91vLwf1qi1wsGVdBtNAK/fYhm/rH/97/rgC4Je/oEjMLLrGNysX+rKDve3DfO41iY
         vsf20Xdgb2E37cJ0JRqsPOCD/A9/1+hMJiw13J/AGqQIgf4RnjIET7xViWXnVIRgMh3M
         FbQA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780479542; x=1781084342; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwXKhIJjZGWqX6uBB2vnznJQiVYEOuhYWUEkVzvu58Y=;
        b=F0Fsg1e9/9rG/RyU7d2CaRt6Rhm1PnKFQ1ksAFqPkmSCp7/FD8xNuYarzrC9M/apP9
         iyVqKCeNHwMSfZIobnXNRvig4BJmXVYROE82Qp/Bj1hX8mHM81WaXcoVJY7vw4DickVL
         /3PFs4/SPMVLNUrNdNKOisYHRzVSKre1VKqf+ilfFh7gxtvAohxxSxUrVItFUJKbwxXx
         N2geed5oLQBmszk+HmvC2GuA+PNthsnx/CHbgGyYN64cw7x2WvvDkLvIyjJKy37TB0OR
         NcC08/Hr9AE0eszZHu8rbBcdTRk30CCIB7j+hKv9UmooPLdvEsBFDrRzEaKyLnWg0mje
         BUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780479542; x=1781084342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SwXKhIJjZGWqX6uBB2vnznJQiVYEOuhYWUEkVzvu58Y=;
        b=DLaEUAHBgoy0Hl+ruls0z5BE9XXnz2pgivzk3Up/mzldVOaXLiAlczlhrRhK/6uNfO
         HuUd1Ah0df58BWbcfPZkL4bnCukoDpUu7uifFGcxgwiqrd9g27mRzeYolP6ZUzkrGp0B
         GJpReGc8FtvodPJfWl6bT5x331XUArmzYSDYDu8ZSwDXSt+2rmQplv6br6TpqTDhhNdO
         HVZCZlh3mpUEitucQQuNMJJXI8CToEV8jW3u7JVV0nyHZ6IdfaRdkvxpG5jMJszYeNAa
         qTXXF7PIGQ06nzmoQWZY/Qo/e9h6QvNVBZkMhCm1MM+1x0PZbux9rnumWg42kTkyHlw1
         Wa5Q==
X-Forwarded-Encrypted: i=1; AFNElJ9rMno7cPMvUNMjcV7PtDIaYHLIwTWbustZ6T2EraFrrzXm3Ivn4mtAiSKQWhO3W1V78ZZjIgBZSZRfcFE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz0+iARLPyQz9g16l4D7pfPyQyDUDi/dVZC52cvV0gycDGmdKqX
	XZb1YwJMVNP/2wD14bIZ9jsOBGkLf/yyoun2e6L77HUVdon9Ghbcf8VunZ8UlSx6kvPKAIJUs8+
	24TIf/LmFY6hfee/je2tL+k+t+NaEFHM=
X-Gm-Gg: Acq92OESd8OItTGjIayh6Fv9Jhhx4aBP4k2tHd2bTnJAszzbY/puk6dYsX86/IhgK9j
	gFCJ6XR1Spdnq0x0BGzRx2m0jRAUBhduMcojOHkbET9uS6RNScF6UqQcYOpWEZMsa9Lk1F7X9yG
	9HUaA4N9GuRvPkCd7CJnjAzG0jslW1UdNpJC5taUTFslLHCjyQDwhL0dYkGLEIM28BfLmqlOfRC
	2dtfm3k7W7taiGFcpPHbh/GZbiTD69Q/xkwWIp5MK3T/rttBvBMzZELQ5HrwoqougzwSf78pP9G
	bCDFlroz6Okw65naRqujvIaIEo/WgB0bzf6K/3XwODzVg6TyeGcLyGnosYPVakPGJwL/jax/EDc
	LlOAH92/EoCP9RIjpTDuARircS1zL99j45nNwK55XztpF+UkyAHASJzDNnyMeWBxNr7af
X-Received: by 2002:a05:6402:1589:b0:68c:3424:af6c with SMTP id
 4fb4d7f45d1cf-68e710f7416mr1164077a12.20.1780479542040; Wed, 03 Jun 2026
 02:39:02 -0700 (PDT)
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
References: <20260603005455.226882-1-rosenp@gmail.com> <63476872-b3be-4564-a748-74757130c50a@kernel.org>
In-Reply-To: <63476872-b3be-4564-a748-74757130c50a@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 3 Jun 2026 02:38:50 -0700
X-Gm-Features: AVHnY4JOPde6EcbhbVP7kQ6u8j7UMFPXiaRnZA5NqzesPep85f7PtCeO2ye9Qog
Message-ID: <CAKxU2N8UBXMqeOoKOTy20ZL4sK8JNQfuamWP-_nMyxS3EH5oSg@mail.gmail.com>
Subject: Re: [PATCH] i2c: cpm: Use platform_get_irq() to retrieve interrupt
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-i2c@vger.kernel.org, Jochen Friedrich <jochen@scram.de>, 
	Andi Shyti <andi.shyti@kernel.org>, 
	"open list:FREESCALE I2C CPM DRIVER" <linuxppc-dev@lists.ozlabs.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:15=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
>
>
> Le 03/06/2026 =C3=A0 02:54, Rosen Penev a =C3=A9crit :
> > Replace irq_of_parse_and_map() with platform_get_irq() as recommended
> > for device-managed IRQ lookup. Properly propagate any errors returned
> > from platform_get_irq(). irq_of_parse_and_map() requires
> > ire_dispose_mapping(), which is missing.
>
> irq_of_parse_and_map() and platform_get_irq() look pretty different, can
> you give more details on how one can replace the other ? (I don't mean
> this is wrong, just I don't have enough details).
My understanding is the latter is higher level and doesn't require
mapping. Just a request from the platform_device machinery for an irq
that it already mapped.

It also supports -EPROBE_DEFER. Probably not relevant here but could
be some day.
>
> >
> > Assisted-by: opencode:big-pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   drivers/i2c/busses/i2c-cpm.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.=
c
> > index 2cb6a233d313..23679c192edc 100644
> > --- a/drivers/i2c/busses/i2c-cpm.c
> > +++ b/drivers/i2c/busses/i2c-cpm.c
> > @@ -434,9 +434,9 @@ static int cpm_i2c_setup(struct cpm_i2c *cpm)
> >
> >       init_waitqueue_head(&cpm->i2c_wait);
> >
> > -     cpm->irq =3D irq_of_parse_and_map(ofdev->dev.of_node, 0);
> > -     if (!cpm->irq)
> > -             return -EINVAL;
> > +     cpm->irq =3D platform_get_irq(ofdev, 0);
> > +     if (cpm->irq < 0)
> > +             return cpm->irq;
> >
> >       /* Install interrupt handler. */
> >       ret =3D request_irq(cpm->irq, cpm_i2c_interrupt, 0, "cpm_i2c",
>


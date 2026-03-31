Return-Path: <linuxppc-dev+bounces-19038-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3552F1061B2B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 01:58:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flB9V4pRZz2ybQ;
	Tue, 31 Mar 2026 12:58:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::634" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774922318;
	cv=pass; b=KOyyquSJGai/iZ5x82WHM/eNxI6vv8K5sGpgD4tEmJJdh4PDCd1k2/FZ0cnyiWOLAzoIMT3c9SeQpJcnq6Yfb48gK5uoSQgG5rGusdu1dX06Gs8tBhPFpgvOJA2D9t/TLzcYotzmniSWxEEJAdeV1iFe4L+Aj2Z6tOlQY+mZlyjMfKBCshFtntT9QOdYVF1HPq2C4O585yRjct9BcDaysC/89XqKMsIeQzLGC5kmBxvjBmakbjSogMZEdIKbFz72+GnkRI9hH07OlM9qaLevaJq2WuxsR1rPXvseWaCx6rqHx6RjaS2mdctQYkUC0aIgEFeGJmYcvXV8GijsOdv8lw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774922318; c=relaxed/relaxed;
	bh=lh6+5wmxx4h3Bwis2Kw/KW78+qVVfu3FcQxTwX+HNrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3Z13xC7/aRK4o9Xt/881vLB2X6zdVlZ9og6HCbaCaL589cfkJHV9U097KozlqyjBLkD3XUhH7mUL8+gBnAA34Zf8+grZZBXlS94zTXg73Be0jsDU8Hmw71HV4HrRaGkN3dMBaEjsyDHA/1VounE9/lUdOZPnmQc2UtqVutiitefysjvYbC0DyJZtaRiaeNJ79V1ZODqPY60LRLTA5MIiov3Hu56KhkqGWT/yaLKLrTKa5dOqB3TQ9BZZW+/tG+tLXG5hdhooJYOPjP6VS3GDyvoAzn/PoagjPJk7JiAH1XFFGmdfM09BWJ24W8U5wC4T2nAIlW2L/+lvqvDYjFcNQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FtJ66vVC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FtJ66vVC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flB9T2gDCz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 12:58:37 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2a9296b3926so33469945ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 18:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774922315; cv=none;
        d=google.com; s=arc-20240605;
        b=HMDMSQ4iAibC2L8MRfvzxFQ4DwSv5ylPpsqzzBqs8Ohy1DJ8QkWyXLhfyvjBiDbYiT
         xz2ZGZoJeHwADRDTOS0r7hDjGtnPD1W5YqntTQFHiDJbjurONW0a7JPtdZhiCeIyYAkL
         xk0xrPY5R0YKATSy8Xp+KEK5NjKauJlrL3UliHT0vSWIhP4UOzbxc0/S5OJDQSd4v8KX
         Zxa3a3YTrPoWqnvYhqMjh4zQGZIsyog8h47JfMZtmofvhMfaeIhF42V5oMJyS9+dRqoZ
         qaE7LwCQ+jl+PGTRW0d0f/vVd8SDb+76OCDovmJVybB7KUbqWdGY4qGV9MI9Zh18Z8h6
         RuyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lh6+5wmxx4h3Bwis2Kw/KW78+qVVfu3FcQxTwX+HNrY=;
        fh=EZyhp4EgX4UOC+ZbqqBF/Z6/XXYfI5x5tDyZXQX0/hM=;
        b=bAz5Wv0JpNb6yyKGZBQpQSHw3HqlZfLcqKL1lqYazdO5m8AQOGFm5JDI88pYoucUA1
         l+VkFdhjSw0611uMtnOFRwhjHnhdqBtSyhA8OJ/3S3QIQBvCzJmZeZ9U6mZjRLqZf0Ql
         J4EjDUeqIQIg/0n6DwToPFexlIHDwFfkYQtj76VobknVC98K080Ov3de8YvDAg2cnfCM
         x9eC8bFXqMsaayabrs0bAWF53Ei+G4K9FIOb4SGLFUcFt7Gw72hnlUEnK2SzBlXDVQLp
         5u/+0huGJ9nNyKjL8zyDtcIHYIagWmT1qcFuHgz/HKAStjwpwa7ENwPKQx3r/NO5lZOf
         STNw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774922315; x=1775527115; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lh6+5wmxx4h3Bwis2Kw/KW78+qVVfu3FcQxTwX+HNrY=;
        b=FtJ66vVCTmWFkJYq2MHiJ/uoVcBsM1gcgcKh5EuZa0VoQMvOTLxHJk4Q3t2KWy/sdJ
         GvE7p31zLA03oPpuB3b9DuaU08gn0o8qxxAGBUnv3pwX7kwURj520DX4vdZEwaSPCzM6
         J3hOo109/4DfbvI5JaAdz8JzzusCTt0v7nFr5Mbi8/qyUvQ3jq+Tz2Y7mbfgj1/0q6Q1
         QiR3zV8WN9b4zUB+tyl1DMWMQCKazdDpOJS6lz/9sn2pG3Npe1E3NSUxzRwdfuaFdV2M
         wzEgY7erPNbaO+cI5Oy6UDwuHr+lvIvcOFGeRD/Czo7ahnvqSbonrl3KunPXypT34Pmw
         PsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774922315; x=1775527115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lh6+5wmxx4h3Bwis2Kw/KW78+qVVfu3FcQxTwX+HNrY=;
        b=Pp7BYpgUsJkvVyoN70R2qjZzuNY0xTSHK2+pP4jBeAk1rGpYNEYDnXsdi/EKIYV7sK
         LrbJUq/95qieRF2sLMTD/DvqfGKhIUYw1Fawy1w0AOZKlt7xFlRLSBpRVdjjAEMlLIHV
         vh+v42Y33AM3ndFYUrWVIzdi4cLr5UQml35MYh0r0TXk6zDIfibxxetWaTzS/BuhfO8U
         CLQgQ4QqD9M9v2hABMFWEhdp2AbeRzqKqSI+UKcTk/IroyN9j3xnAf0gnWrtq/fl8NBF
         eiJM0XysMrEXAUdMNaphbNVCXxZvJvrvGEoWA2PtuGRR1QRKUeiOukEjI5k/jfSghOWd
         eDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgOPltzX7vXg/mhSagGRCojJj1HIr8VuPmpmO3nL9cw+Wzyh0b9sa8sISYUY5yWkm1GmWNx+Oxx9lAAn4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxvFVuGKC8Kah+QGJNu04eRSXwx/h0ZiKrOdj22GMesKqseCxqN
	B7Pox+onOJ9DRtyPjnF6tFmV8kecHrWKjbyGH4nanTdSETEUcsAaILVDwJQIE9ukqhgkEFk0Cul
	OZxwMzdrqTwyW7lqd3nlCUeITr6z/WK4=
X-Gm-Gg: ATEYQzxKB+arLGshRNgsKJJabss7eoL51Kns1t3gchTMvTHEraEasE2Mwc7SSaZLzOn
	tKwJrlL/oNERWVGEkpR8tZSmEky4Rplf/+JMWinnkuPquwOhyFIvcEzsJBk+PfJhfYXl4gqf58d
	kvRKePLLZp4+XqSY13RYCNY//9zzDUAkERiD+bh4QspSnPgHR2p3QXWZOL+ean3N4fmhH9YW5NU
	PNc6Gn+2CkvtkkHpW3iPyB+fFBytjSpyFbw9HnfGW7rEFQtIi3YZhK6oBrrhOjuNT7ZWgmfEC9X
	ysTPX0E=
X-Received: by 2002:a17:902:e802:b0:2b0:67cc:adc3 with SMTP id
 d9443c01a7336-2b0cdc9c219mr159701135ad.14.1774922315057; Mon, 30 Mar 2026
 18:58:35 -0700 (PDT)
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
References: <20260330112555.3637002-1-shengjiu.wang@nxp.com>
 <20260330112555.3637002-12-shengjiu.wang@nxp.com> <be591d2b-9429-43de-8d5b-357a503607d0@sirena.org.uk>
In-Reply-To: <be591d2b-9429-43de-8d5b-357a503607d0@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 31 Mar 2026 09:58:22 +0800
X-Gm-Features: AQROBzCFKjUeuTt4x-RIANuzLxPEbAMPhRw1tgOwlXSxX4RREqzkMd0fDbLrAY4
Message-ID: <CAA+D8AOsCg9ZO0f974Ds3Vev8uSVj52mano=vG+Rvrw7dJ8faQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] ASoC: fsl_easrc: Change the type for iec958 channel
 status controls
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 9:23=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Mar 30, 2026 at 07:25:55PM +0800, Shengjiu Wang wrote:
> > Use the type SNDRV_CTL_ELEM_TYPE_IEC958 for iec958 channel status
> > controls, the original type will cause mixer-test to iterate all 32bit
> > values, which costs a lot of time. And using IEC958 type can reduce the
> > control numbers.
>
> > Also enable pm runtime before updating registers to make the regmap cac=
he
> > data align with the value in hardware.
>
> > @@ -100,22 +130,52 @@ static int fsl_easrc_set_reg(struct snd_kcontrol =
*kcontrol,
>
> > -     ret =3D regmap_update_bits_check(easrc->regmap, mc->regbase,
> > -                                    GENMASK(31, 0), regval, &changed);
> > -     if (ret !=3D 0)
> > +     ret =3D pm_runtime_resume_and_get(component->dev);
> > +     if (ret)
> >               return ret;
> >
> > -     return changed;
> > +     ret =3D regmap_update_bits(easrc->regmap, REG_EASRC_CS0(mc->regba=
se),
> > +                              GENMASK(31, 0), regval[0]);
> > +     if (ret !=3D 0)
> > +             goto err;
>
> This drops all the checking for changed values that we used to do so we
> won't generate notifications to userspace.

Yes,  as the type is changed to IEC958, the notification is not
acquired by the mixer-test.

Do we still need to add the notification?

best regards
Shengjiu Wang


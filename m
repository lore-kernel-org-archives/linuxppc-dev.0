Return-Path: <linuxppc-dev+bounces-20156-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B238AFF8861
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 10:48:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g40ds2D89z2y7r;
	Mon, 27 Apr 2026 20:48:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::630" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777286881;
	cv=pass; b=Z8QL1jehYMZRtTSKjnpZg+bxTMshP1dIPn4cxAbtBO0WumxqOkKdPNm3WBtX6ALmSzRfkaI7/cE1BN+2FCCsEtYk/xsh56bb0O9fnnxIzPFp9+TmnrzpmH04qGpHOBlZSHWpe/ccJpPdHsk9FeYTW4piAJHVLKYlEdoiXuGJtp1LjGZRkFOxu92i2vkr2hy8HpGB0kpf6ePqxkNfzrS3gfGZeH8udidGEJ1mORyfWsTrfdeWnqptIzaTYNnYJiG1JGJx94c6g6UokDT/ztO98Ebr907rhvou7qePjU7o4rbxpLIiHp2CRBVTby7WCiJ4OySaCm0LGocyuN16KIVI+A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777286881; c=relaxed/relaxed;
	bh=O7WIXV3vy7glDtk0NEp5Cspv2KG7UzeIls2bJ47h0Z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPJktss9/fZzqKO4Xj/Pki6KP0+MS6uaVAU02Ww/4GVhyAklvp20858vm+Ynm2ZUDu08DZKgIGQNGdYTU3M57Gzd6l0Peuz3+f6jDaZEOsifo5F+WBeXX7kFAW9VxUi3X64tZD9P2MSMN/cbrMB7JGf9OCt7GI8twbtXCm2siUJHR3jOjPyo24TuaSod7Lf0+WRAtRu+gJz27CTBBJAds1wskVgBqtcdlnS/PB0uieC8p2uYgTX8Rt3BB5AmWuECNcDoJcS2AOJS+530CP60mPTlegtGix6ZjWKvFYgOm+styxDgLBlC/1oqsc4FIAQgNAvJ9MqJfidQF+DBC7qAEA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=avfzTSzE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=avfzTSzE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g40dq6PYdz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 20:47:58 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2b2429f98d0so58268785ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 03:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777286877; cv=none;
        d=google.com; s=arc-20240605;
        b=E+81cgpuB0AbL3i6MWlcKImxRT4WlK3+EIb/PnC4LWG5mxjG4O2kTbMCILK+AiJmMr
         /x+gmKeRw6wCdJsbvM3bjKTCz/46W87i8mDDwlO4ncVxHd5e7PYhxXHgWjgUYujgqVCj
         1nR0CLaijMHx4NwvQOVUrYLvY5Dx5oO3MbYgl5RNtXXm5DWgwD+e/h5/b53PKgCnFlx1
         8ZZkiBqTsPvwF/cFcF1CN6vxaCvTy1/xTkRkqiw7qIRCK67Zn7VNbJbKR2aKyL0+040J
         jTIDzpFn3fJuaP8nimYocqmAhEFwyIgQK6miSXAgOxN7nYB60BB7fASWjk7sCtO+Kfai
         2ExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O7WIXV3vy7glDtk0NEp5Cspv2KG7UzeIls2bJ47h0Z0=;
        fh=cFphU1tddMwpQFmop1aNU+o/nv3xOht8+ljxylfcOrI=;
        b=dZB69wv+qK+BjfND1Bl7xJ31iLpQ/1+PNisywJcPo1/NynGyQFUAHqoT2ofQ2BB9lF
         h4TawibHREnO4hBQ962SxNamqOTUYYRb6+EKDy1Wwt6V+oEcx+c/sbycS+uL8ia5jaG9
         Q/U3QIdUdrx3SHGDTLolmikhBEgUTo2ytUp356mZrIXjkU0kLkcmGNQSzGxEhxNkHj25
         6DoXbOuzRg2NP0X+A2Pktfk4FzcenfS99X6WcUoAwcXsJQclTbJSvCIpJXiwxglfq5/b
         Knklhvx4Q9eoca3X4zhGjeqFaZCNTvy/OeuwFBh3z1OJB6izu+cLj3QiHHmkjvJf5SR/
         4F7Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286877; x=1777891677; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7WIXV3vy7glDtk0NEp5Cspv2KG7UzeIls2bJ47h0Z0=;
        b=avfzTSzElEeZ2cI1RgdFxyOq0/i7OwVNh932UUFZkQD0XqULonXsqrvYAhIFkyVaDg
         Rip5VzuItEHYyX8inLJw8gZIqJV1LqSoyzMPoJOd4mJgmA2DfkPFS5vVxlMyLCRUroeG
         uC8d2vfv2go71CRT8GjNTk8S5WD1Vn9YQsHtXC8t2qWZ0xEG72zWNzwTe3s3HPR92fey
         PAbUvN6Wgj9F3oOGK4jOsnloftWuvObqCWd+P95tqpIEdaq0O/ZctK5O73hW+RF+zRae
         K88/8ON5HuSg8HXu0X1O6o4opCXol7hGyqe+hcMk/6olISkQz6hnB1xrrtVD1C2PXHuG
         4BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286877; x=1777891677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7WIXV3vy7glDtk0NEp5Cspv2KG7UzeIls2bJ47h0Z0=;
        b=ClGxrKoBSAJwEne2d7W9R0t320oJQ7zeiKtjeW/uQ6ckauMkZgoa2FqQxhJTsS29NH
         7LwZXhAB15u+khPE7Z/Mi6/7oz7BdLll5F4XnCowSH5co+OJAARO4j5Yt6Lx9GDqr3Rw
         6LYHISxiVBRRV+Yo0WH6bqdPhkjaXNQfdpPRukK/bS5NS1MsfCKNveJutPxsAhq1icCD
         apxHL2dVhEXsRHkFSY+pO2d1Fn8u4+qcH44vB5qL1eMOz33S0/yVOQ3JxQbtnyvPJv3U
         U0Tjjp+EMMm7GSTledgFaFrTon4aelcO2QFdLeD8onlOe9h3JuRJnXxed7PWFa8oJ6Gf
         bLHg==
X-Forwarded-Encrypted: i=1; AFNElJ9weuynEnREu2lK4DbnGtz7aPTEywOQ9Pdq/SOaBkpgJ+ar6IMCr3KqLRcTK5z6GUuPtrPvf4EwLQyFA/U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFBS3iGtkWK9EvKz3zCw4sCalW0O/V3zkwOHbjdrTXXwncrTU6
	CuVrkq7A0b1B7e2dGiWieuA8/3iPu/BycVR3H+hrjgFAI8PW4e5n/E/Zbpg/dmFyq1RtX4cJ1y8
	93baWXW8/7S95kbLQh8u5ppnp/i/DTH4=
X-Gm-Gg: AeBDieu5Tl7NTI1NAS65SkmAA/xY7gv7jVK1rERQL5whlhAlwKZ0231ptvm9+COKM7r
	kxhdfexRrQBWbDqu4zcJs7xOw2PAVPdZab7rr9dJww04zwwQmcNQx/EG2B7cDTMEA+jaZ7VN8GK
	Sis1+fhhrYQRl3XR6Dt4MBwqS4GVS45E6v9wvCAXx7b415eOdZU78eFiSCBzGbt7tpTKN7OXUrV
	dLK4reiZ2B/rE5MipQSqhkVIoPK2KGVdWTsw0ULpH4iJrJ6y2gauwGtPLJmm7C/R8qVvaaSSDDi
	fPR8xwUuq5KpSG8cUQ==
X-Received: by 2002:a17:903:48f:b0:2b5:ffc2:b8d with SMTP id
 d9443c01a7336-2b5ffc20c6cmr288496845ad.40.1777286876631; Mon, 27 Apr 2026
 03:47:56 -0700 (PDT)
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
References: <20260424103806.2276780-1-shengjiu.wang@nxp.com>
 <20260424103806.2276780-4-shengjiu.wang@nxp.com> <c925e9e6-934d-4b07-aaef-a7f737c687a2@sirena.org.uk>
In-Reply-To: <c925e9e6-934d-4b07-aaef-a7f737c687a2@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 27 Apr 2026 18:47:44 +0800
X-Gm-Features: AVHnY4IckQd0kNOio5AaSh11MDWGsTPIgl8JS33ob56G8t0YqSY5T0f6WsqJIBs
Message-ID: <CAA+D8AOUVbSmWpr4+KhHC+9zmvj2M-BE_bpYEOUByGUv-wdHMA@mail.gmail.com>
Subject: Re: [PATCH 3/5] ASoC: fsl-asoc-card: add channel and rate constraints
 for CS42888
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 12:09=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Fri, Apr 24, 2026 at 06:38:04PM +0800, Shengjiu Wang wrote:
>
> > The CS42888 codec has 4 I2S lanes with 2 channels per lane. Using odd
> > channel counts (3, 5, 7) causes data misalignment in the I2S frame,
> > resulting in incorrect channel mapping. Only mono and even channel
> > counts (1, 2, 4, 6, 8) work correctly.
>
> > +static int fsl_asoc_card_startup(struct snd_pcm_substream *substream)
> > +{
> > +     struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> > +     struct fsl_asoc_card_priv *priv =3D snd_soc_card_get_drvdata(rtd-=
>card);
> > +     struct snd_pcm_runtime *runtime =3D substream->runtime;
> > +     static struct snd_pcm_hw_constraint_list constraint_rates;
> > +     static struct snd_pcm_hw_constraint_list constraint_channels;
>
> This makes the constraints global for all substreams, given that the
> Freescale SoCs tend to have multiple DAIs and have things like direct
> PDM inputs I'd expect it'd be relatively common to have disjoint
> constraints.

Thanks for the comments.  I will refine it.

Best regards
Shengjiu Wang


Return-Path: <linuxppc-dev+bounces-16718-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E45EF06ED
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Feb 2026 03:16:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8VGr4GWzz2yFm;
	Mon, 09 Feb 2026 14:16:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770607012;
	cv=pass; b=hErtr+HxJ4L3Wq50KmlDxmiORJROy1nYwtD86DvszO91+An6mjjjDnfyIVJ0HKbWjDw5LI673P+TRkPlIk3L47C5T9Ra308MGYfntytEqAGE2R9z46+s0lKPPXX9bOz3j8eE1Lvo+FYKIbnrajY20mdMeRMxjqeeSgS6cdUbe8IHvajhx0WfMwS/a8v3845+yrR8TK/HuK1JkAbqMSCBwToki1BHurYewOlV24hw0639lLi66+x4ZNFkRq0vhQpLHajZL3mnxZAH9OR1RrOrikc1zXfALDtFge/kkXyIcpmaIWOQaGCCTPwVDvzVO7GAaYHhk906ABmDSIcllbBwZA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770607012; c=relaxed/relaxed;
	bh=gHTyT6nEnXSnplwUfxDYJkQonZefuQNxcoEB9kIEWPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBvvicVg8JDNvS1zbyhg7o0wvnd/DFHOUGhbw57BkIi3C92ot9fnOxzQhhZxUhmVnETQpKXrSRslsNJZW6g4k31mXUn67uRDrBFEABx5S4IUlS+xcUMyOFVtKhiqE8RerBeR7lB2w1li61LnuqFuuhg7DDBv23GUDorjfeEFWPcUwIi8K15NmrxT7uZdCOYGpNfyb/CacCHAw9bGmmnafrMlo5NhD1EczS+T1hpayXHDZgNfiPcJw+um6LuppK9YlBB1xZd1Idc0zqSKj4kQsO6s7JxvPifVS5qDj/l0twObhHdpASLzEGdaJQfuWX/V9QZoZ9Zz3a1HFm8MUQQjWQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=P/46V50g; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=P/46V50g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8VGp73Y4z2xLv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 14:16:49 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-35480b0827bso2369397a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Feb 2026 19:16:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770607007; cv=none;
        d=google.com; s=arc-20240605;
        b=R/jY7/hHj2+SnDOJA6Eu7sU/TObU6ulXMB2TVhzgjYkF3nDubPlxdeA2gq3aszuk0p
         hW7lfblUYb3hYBd1pkFRlBgdewBmxQA93Zr7Y/oEG+EIhG/Jiz7iZQ0NPRR42VDl+SFk
         OXpiKi2dnvJzwnFJBzVqwpIBmTfPslrZl3BMt0pqXiwEF/Hz1OE+9TTdUBoLUoDhYFQU
         Oz3BHFaqpTLG7EdPWMo19/g/nbOthefcC4DpS44UJbYLlcO7A2Hh6szWw+tE6byaq274
         Kc9atFUEDXyvyO5szmdRZJ6dukUTPL2moo+Y9gj5OdqMu+Wku8vUFPRbRHYX4cCz4J+s
         M35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gHTyT6nEnXSnplwUfxDYJkQonZefuQNxcoEB9kIEWPk=;
        fh=awxoU0XClWRfSZj0aDPyvZwrfkZ7DUOcmiL00kr5M6E=;
        b=KGWmfH5p2XI2eXZzDRJSmhQ9OeuSz9J/wVioxgZ7rEqzjPAd6vmSj3FbwoegTT3aDB
         0H5QBFivP9hc2CBYLdsR4dqgj8D7oOZzGxxiKTHZiJYaWL/BvEI5DaG62gkyERWMvKB2
         KEgjBVrorypqeb67u+DTz+aj74jYhyAKFbnA9SBcgOHXr7goXf0+07kCunYJGyKnHmnX
         q4P/Chc/UiOR34Qew9BU7KrmzATmoJb3f92/xl5d5nJEJ5rnxljWI1ZwiTGTJ3qXyCg3
         XQkWDf74nGNAFA6ely0fPJxnzIxweciY/hJ7X6zB/fn59h9kPHvMiasEwSWNE51kiX6B
         dyZA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770607007; x=1771211807; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHTyT6nEnXSnplwUfxDYJkQonZefuQNxcoEB9kIEWPk=;
        b=P/46V50gignNhu4fZ5RvVu1k+rCsuV53zrqWcvqZisZVas+hS1QBpPKalLbbSwx3zQ
         Rud+p8pBKIVg49ar7awO3zmqkono+WPsIsyaS4xgSN5XadTq+SEouzfYA3FfzEk4OurA
         6m0gDsC/DQ014how47f9Hd0LmDOGSTfgq7cyCPgMMvyd4mBIW0zwSfwaEQzIa92p6UCB
         SShGj7H6/mQY6Bx25uncwzB5ZNOJ2z8fIfHGqSRaA/pjmYDBjYNmDB04Qv9lOSRtkTw2
         6Bt67ZfZYGwWL8Cwz5JcHMrX3bBF2opY8KTP1o0KM7LU8b+pCuOZSTbkv7TR5s6fwtY0
         H5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770607007; x=1771211807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gHTyT6nEnXSnplwUfxDYJkQonZefuQNxcoEB9kIEWPk=;
        b=aShOGO+oZcPvfkdSGldq9VgufDZZ6FJh1YcK4quQkwi5igaYNWqwTSTTWrQBAekyCO
         iT5A3SBFOJAl4I1ruRWk3TzI0EXnFYDhRQDc6NvjbqpC1tqZG5nOciaWevHUOnmmDic2
         fOk6v3ksndYcOPMQBWY4vOjxQed/bXc7tmAmOlmUSIwBM276sZvxN1Qif1mKfua4K472
         8F30wFnAqfvtdUmztXKyQQir2BY/wTblmq4gRAIAxMx5eK8MsXg2/orfjZNGHCbiZ3Of
         zG5578LlfrPP0yvctLFN4G/1BYi/qFFHYk5XQyM3Opy0SUQ6KOSQgzCoKseQfL8UldWu
         KmMg==
X-Forwarded-Encrypted: i=1; AJvYcCXE3DF43hAfvm69K5DXgT5wGpwBdT6omaR7N2/cQFC4TqiXaHmOpTX/c9ebyyoocgVBM8xpfc8E7lDhnFs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw5PvSe5X6lvXVSbFNzmU0WCa9q5uS/gpYXlNYlgFj/03nmiX0F
	JOxLRMGv5VEiKIxnntKGDvDnv1kl0FKRcQFOLneg/qSutFy0fU8iUGjw9BQuWj3FlX0FGDV7dwO
	3REBfJCzxLaZrp/f1o1EaMITcsMTfS6g=
X-Gm-Gg: AZuq6aIa7655ug0jTaSphybon4uEWZ1IPBOlpIGSUU+drIeSR15Jr/gge2N5pYG1UJ/
	YYA5Bdg8ZPOFqIxBr86JjgJltu01gkOGGks5pwHSxtLue/ZXbXvKwU92WmglEXBJv9d8X+M4T1v
	+WLyDPUCxI+cYshhY3ZIP2TrqiD9hicNAKOse1RVjsfiA5jtCrbrjwrSZTzfKTmf1W9NShPr5Cz
	CCad2ljoSOGqvCznvRBQKRrCZTxPp3hZGD7Cr8PWMLgtCP3Vw1m2x1Iwy/jAQsynHVQ3y8=
X-Received: by 2002:a17:90b:1e47:b0:353:2972:74a4 with SMTP id
 98e67ed59e1d1-3549bbf563cmr11484025a91.13.1770607007093; Sun, 08 Feb 2026
 19:16:47 -0800 (PST)
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
References: <20260206084334.483404-1-shengjiu.wang@nxp.com>
 <20260206084334.483404-2-shengjiu.wang@nxp.com> <aYX8qnKiPxHej-Xo@sirena.co.uk>
In-Reply-To: <aYX8qnKiPxHej-Xo@sirena.co.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 9 Feb 2026 11:16:34 +0800
X-Gm-Features: AZwV_Qi1D-HuZj6R86-IG9_oK8GOda7quzttYuSgvVtuYCMC-SLchN_iGAdvXmY
Message-ID: <CAA+D8ANHrwN_vL_JmC8ZUQ_FPUcOqvBof=Wrzkmpbexi5iFMQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_sai: add bitcount and timestamp controls
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 10:37=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Feb 06, 2026 at 04:43:33PM +0800, Shengjiu Wang wrote:
>
> > +     SOC_ENUM("Transmit Timestamp Increment", tstmp_enum[0]),
>
> Don't have arrays of enums with magic indexes into them - this is just
> error prone and hard to follow.  The normal thing is to declare a
> separtae variable for each enum, or if you *must* use an array use
> named constants at both ends to index into it (but that's not
> meaningfully different to just having multiple variables...).

Thanks for the comments.  I will update it.

>
> > +     SOC_SINGLE("Transmit Timestamp Reset", FSL_SAI_TTCTL, __bf_shf(FS=
L_SAI_xTCTL_RTSC), 1, 0),
> > +     SOC_SINGLE("Transmit Bit Counter Reset", FSL_SAI_TTCTL, __bf_shf(=
FSL_SAI_xTCTL_RBC), 1, 0),
>
> __bf_shf()?

Can we use the __bf_shf() to get the shift of the mask?

best regards
Shengjiu Wang


Return-Path: <linuxppc-dev+bounces-26517-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16F5C624D6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 03:11:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbhMZ1L6sz2xlJ;
	Fri, 04 Sep 2026 13:11:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::629" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788491514;
	cv=pass; b=E+Pv38/FDp9cU4+uG7IIHZN2EqxP1HymqQjzscqR1UZQXkCRSwMaPrDzYaqyJvOKXkrMUpVcpWsCph3Wq8j15GaA/wLMRUdQ3QSbN4jpRBtOqZ9O0Z1PPVGJ5n9gcegZNwD+lk0W+WgKY2KEieh9JSdcXFxnIbsAeenp6zGBxJZ8fOBeEQxVbx86YJfMuK3d5GeDeVov5TFJjzd6Gjk3fdKQAeYlZ/dCD1NKeHOg3eSEOm8MoRRNLF6HXaT7HaRREGDBqNiakKJrwzKcPOCDUBSOKMCdAuLD/TFM3are3fe3LQ4TVWAWjIEp2ihD+kTk8unCntWQz/KMFbWMERh1Lg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788491514; c=relaxed/relaxed;
	bh=vfRlFYrZG7tQcJDkEgmaPaaxAK6OS6eQsP+WeAvUDW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TABcHO6FRuMJuPwUkOdAEpSmsvm9jAem9QKv/bMOzD9NRZu4xDtUaDvJkCzMhEIl6qxDIHGRUvbcgBEWP7PUZAx+NRmwlZ94CbMid1RYmIwIVuKBA7ZVbHUns29J2gUAUEWJEtT9ne411arQSAne6VdXJPrV5fh6Y9U5PtdRPzbKKc1pGN+B/e+Rr2aMQdHKwEIRYc6En3k5R/Z+nWUU3NLkWzERO37/vu0ZeyJOWQWbNn5iFBo6Kyw1gpuWd6Q+Xh9Fark6DDNCGrLyXS6RlD9yqy8d82+Fi10Z4CPwJGaJmLNi8nq7OMN7kuqO/lg4I/uM5HV+ve5oDm7/vePORg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bqyEf1wP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bqyEf1wP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbhMX2xHHz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 13:11:51 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2d01663d816so4041975ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 20:11:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788491510; cv=none;
        d=google.com; s=arc-20260327;
        b=UDVE/Xo88RpcWHtbuOG7AyZZ1oIBlySGLsjyai92XX91DD+WEioI/8fEuN0cSYmllc
         7jQ2pd9RLRW8DGgJJAFpGcFhdX70SACCVy9IPGH61TcBbvL8uu3MCKR6dbr1yMlrWv5G
         1Xjq/giycyBqLDO2VLQ2pked56QCVfCnOKlOwDajfJTzS08F+nQJ6J+PfeRJLsfrNDSk
         f8Is0n/Zy/7JuK4QyWUrByy68ec+nQTsG45L6Ure6X/eOCiDZBkJT9etAiSD8ehdPuwr
         eqndd3EG0BZd+psRqdSn0uyiZhIdboss9pMSE7sTYFMhCHzjwqwp4NlJpG+kE6dIJ6jo
         j53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vfRlFYrZG7tQcJDkEgmaPaaxAK6OS6eQsP+WeAvUDW0=;
        fh=wCfatnq4vx/71JkezTcr0KOiTA0YZAeVoexo/oGbe60=;
        b=UCfUm+UFnu+PCTJTEfKNHRsNDQVygy76CKh4iWC0nRnG3Eln5YJfD7nOStqOUrk79Q
         zTIJpcTbCJv5drC8GzjIH7bbMb9QLkeuTcNjtUxqGPCuSntqRNDoW57XyqaGR4417H08
         RVK6RAxIblBmClJzxyx9GpkxaNyvbzMbmALNDZ2700CIrKWmpcimcyJjIbyZuoFTnx1I
         OWF0m0shrZ4Dr252z0gmVsx+6MJdpEVl+bpWXYc+8DtAigfvMxdcijRiQSlAHaeqP829
         ud+iO7O7UiHDii9gfy+27kg4XcykzA29KAWi2gwk7PBQfc0ZAPuG9BjfDMC1ofOAf3Ac
         XToQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788491510; x=1789096310; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vfRlFYrZG7tQcJDkEgmaPaaxAK6OS6eQsP+WeAvUDW0=;
        b=bqyEf1wPBJLpecWc86t0TljTOKeDGXqOKvBqC6wywi9tlbmsAIh/hKsvTxHBjnrvQU
         7i+WAkjFfmsrzQt/4g/jp0UAcxHT3qOO4spnv6lTDv+u0Oy3u++hktSjYFpG8hRtPJph
         LY/cSIHJKpnchHaWt6uIdvPpuqxMkXpaYMf4aLkJznC6JbSGc65JkdgBZt7HtOPM+ZDU
         l0GNIs1cbvBfxcN+q6KngKKSOjFeEy/y6Xei0K0to1hKTSzSu8lfImOblnP+zbgjws9C
         QyePqR+Kf04XmaJjcEKtEPdnBA/wlQkuQSAFhKuBAXO9QlhRPUEpDB+YHShj2llERow+
         0mHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788491510; x=1789096310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vfRlFYrZG7tQcJDkEgmaPaaxAK6OS6eQsP+WeAvUDW0=;
        b=Y9wvmnEQPrfs248XpqoJNBxXIDVeNvF0EdlmaLqUDTnljr3mmMPXLQNiYs1xaxwRYj
         asx9kPqQuCAmTMcWtVDjv5b7HwX0mklTczWYI8PUnFMNaWe6wTSi5P2281Dfpg1IX/0J
         vZKE/Q2wpDyT/NQw74zig8R8j1LyMmxsggVGHfPN950yWlUcqIjmErk3sJIj2UkCgJ1+
         5wQoWc3G4+7aNDHMTyXXbTntOAi7byyWo0IXV6khDsnaVJtKORibqOFyKooMoEYdr0T6
         5Vl2ANZ3Q5+3XUrfTxSS/x41fPF+00/MFQfuG4xFqwfF8jLrC06u4nLuPfw6VHN3v6qy
         SJ+g==
X-Forwarded-Encrypted: i=1; AKwUvByinSnwuxINDWU05YS1Tb3Zf5/RC44J/g5ey6VxwArlJu79Uy32Ue0pK0SJ9v+mde70rk/rrLCemQxQdCA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++keBQSikwHo6FYIAbK6yEMl6WaR095HrwQ/KBD69eyQZ7Hfk2Ox
	iRZ1+AGnJSJXwo176djZfh/GCWPm38Lu7uRSdFeIGAkH7wzreDGRZWmNbgAY6B09Skqk0tphdo2
	JSns0ZGwFyCEFOmJ6qBKc3RsWAigzBIM=
X-Gm-Gg: AYBFou2DE3TkyAKFPvppIAG6K0hxfRJ6IwnrjBC8SGWJay0FKw14Ala5gJQnQru+P9f
	EWn23Zs2y7vngzo7gNHylNbKEsLXW229D5jIM4Y/jC7heIMeLIwdTpK3oy3zTsNhxmg6pFrDLjx
	D/eKh2sCBje3g2aVXDZ84Ka/9+phCQyejW9khqTESSGCKJyZN7L6jAR27VL2njziaAjR6zWHm8k
	TCxqiGlERJsbavyXWZBxXPdQKFHx+7+ir9Z5gM0ziJugjyRfof8CASkd7RH1JGTj11bITuU899d
	fQUBEEnPq9n82H2Y80AsWFd592ZVsaJZBUtDS5jMMyxL
X-Received: by 2002:a17:903:1acf:b0:2d8:da29:da41 with SMTP id
 d9443c01a7336-2db127509bemr55944165ad.15.1788491509602; Thu, 03 Sep 2026
 20:11:49 -0700 (PDT)
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
References: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
 <20260813070020.719810-2-shengjiu.wang@oss.nxp.com> <20260814-lean-classy-hyrax-60aab2@quoll>
 <CAA+D8AOdF08PyOqQX6HTz-bWZmyB0bmKoW2DxYtnGS3g72aWrA@mail.gmail.com>
In-Reply-To: <CAA+D8AOdF08PyOqQX6HTz-bWZmyB0bmKoW2DxYtnGS3g72aWrA@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 4 Sep 2026 11:11:35 +0800
X-Gm-Features: AcwNN1VSQJhguJNnq06i_90XVuMC-oTCxeandMzLTYM0L_HXyiYFRb-mCLJw1rE
Message-ID: <CAA+D8AN=ZSPDK0HahaD_Ki9=RSfofpTbphFz_eestpZvmFpYfA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	shawnguo@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, 
	perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, 
	Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 3:41=E2=80=AFPM Shengjiu Wang <shengjiu.wang@gmail.=
com> wrote:
>
> On Fri, Aug 14, 2026 at 3:21=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On Thu, Aug 13, 2026 at 03:00:16PM +0800, shengjiu.wang@oss.nxp.com wro=
te:
> > > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> > >
> > > The i.MX ASRC hardware supports up to three conversion pairs (A, B, C=
).
> >
> > Each one or only the newest? You will be getting the same questions.
>
> Each one.
>
Should I refine the commit message with a new version?

Best regards
Shengjiu Wang


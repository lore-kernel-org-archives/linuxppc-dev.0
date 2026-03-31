Return-Path: <linuxppc-dev+bounces-19096-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51246109B46F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:50:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flTyh6cXgz2ybR;
	Wed, 01 Apr 2026 00:50:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::52f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774965020;
	cv=pass; b=XUJuBCanUsbdPmHVr6jY2eIJ/G5I4q0QEi2NdNb0XFa/+b0ikYSfphAJoi41GdAUNydWiKk2WqFqFSCCsHxLFQzZuSfb1hzSMf1K9RYbg9uH1gSO5KNAbv6s8Rgd9cxTY6RUr4Wk7Y1j8xsyU8lNqVUbtrC3mMXXRBb8ljv4CUEUYD7l2u8riYBTMpquqxDAnu6FXWf2QO8UxXAVmezgrmEJtcwViD+kGgNUmoBkmFMI22rRJ7a1UbcJMTEBJf8ha95N1QNqVQIeb+dgy7Bg/WO7yeIKE5oE5hGqCJUcL4oZvl0eJSoefR+h2oUvgae+n3GE5xuFwSxUIoYONtvP6g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774965020; c=relaxed/relaxed;
	bh=y1qBqYHapfEK0lfRyQ72RjBAD9wjLPlTowcxM0WvHL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ght06vyB9tvNtWWJipHerxFgrxor73DK+4jsOcKp/DG68hwObJOK8jv7UCYmvkZtGVySrO6j5DDnRX6UAeCH8rZjynmyKrXEfa2q/Yrjj6S8lnwuEZrIRECqxOHwZx6xspE0VO3a1dcrqFc9TCRQbzYHD2RI0M12xRqJZN2zZQaxH5eXoo6fiuzkELpKgWhpWbFZryyRf1oLxMOn5kJTpTWgTsO//GrkTImIifBGgtOfa5pmIv0t/a0KDPff8DiCz72Y+1UZzQhguageijHJhVO1i7+Fk+MlQdz3lCwWUI+oP32siU6KiV2pqX0ogbnxcdtr4Jh9m+kEpF8d+4yPgw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eiFxPVKf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eiFxPVKf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flTyg5CK0z2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 00:50:18 +1100 (AEDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso2401361a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 06:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774965016; cv=none;
        d=google.com; s=arc-20240605;
        b=dQRMoO8zW46MgXG8CPmalTsHsk5qLLdD8opulaZsycyPcv6t7dnr8ob5PVaf37x56v
         TBkXiqXsDJz7ZAY4Hto+Cps84vVr71lB88tbKZaYCJAgQxZkr4NPRDkTubwwp9oaBn3h
         ZTN1CDubz9YSRcjJru6he/tpTbLdRYSbi5gpdXm4k0md7YtjWHjX1C04QFGbMnYDXbMZ
         98fMAX7Yi3Fa/37d7/TFQdnSGcrMVJ4ClpvzOGBWlnPms1OarlAVY4h9cMX89bM8vQKT
         eD8kVRx0F+TgBoUADYHMxYajW53RpyTcMXRZDLhTFQolGX3qEpW41bAWM+5IYBlcxlLh
         IF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y1qBqYHapfEK0lfRyQ72RjBAD9wjLPlTowcxM0WvHL8=;
        fh=4W2xmpKulK/wltDi2eIhsnPAsezC5ElOd5cELYpeoLY=;
        b=M2CP0WWV4KEEMFdgETb6LHmAYdVW91Tn1Gomr68DcTFQZYqfUru3zolVUc/GDY88nb
         2ed9MOTr/aW1e3TUJTqDRZmlXBv2E5cjHLYtlGjr+sBxEilskxB4TJrXgNYQIg3qJ9Y8
         IFJjEvUwjF1ppo/+tSjNuNR5UY86k7iJiBjOn8LasWbK+gSe1YZfjNYZIa+aeTDW+tvd
         e1tphblfkdGEk/572c8FgsfeaIIpcBs8ls0NlCKBhraD+mAO8LZGvmm1BfM8CZJV7kfW
         RGPL1oNeKt40rHiYjdw4yZCTzicGreePS+DXjtZ1k9pWEiq4P121V5V+j+iXfMGWc4pE
         pgvw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774965016; x=1775569816; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1qBqYHapfEK0lfRyQ72RjBAD9wjLPlTowcxM0WvHL8=;
        b=eiFxPVKfAI9uBvbhcfGdaVr7Hj1hRp7hat850nI/xsVzhkikgXA2PVbZGPTYbMqGEq
         Z14xVgsKVc959DsVlpWP+BMusXe/Cd01joJCV2ElF3pk0iFPYaBdymoQhWRvFdQBhx/P
         slb44RM4PYd3wvRqXP9bbHQZU8akpNuz0c5nyG1T0qFzLIhrtZMEoCtBxqpVfd+1xq5o
         l7BmLEKFxn4MiSk97VFb6Byw7NljeC1ihD/ufBtUIFjbGdyLnDZNso+FrLvCXMbhStaN
         UMivJ0iFkolR9wgO8ACP9ZN53ksof69Uene3dP8Zb28sh6FB53b3F3y8fqws8vB02e/N
         eQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965016; x=1775569816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y1qBqYHapfEK0lfRyQ72RjBAD9wjLPlTowcxM0WvHL8=;
        b=mz4hTXuY2qPo8b4DPqlluWLwKnKcsfcps0n490V/BZ6k3vRdEgrCGbBt2Thdilw+CU
         M7NozKwk/7LvtJpODny3XAECzOAHoZs4PivpX8T0dMvzu/n238ZgjJ5XkH22luWKdxSz
         Xx6gPIR6I+SUwYjE4yfQZpapAeseef9h40CKWCdoDJiIsXXjS6dlNppv35aLWwpGcCLn
         MyHeuBt0onJmyNgrIfFTao3KGF1qwYH2usYR3NVqvyV+HoOqgJC+zb5FN21ldS3H2qJ1
         Fd80WlbtdjGAlZrSsl2XdvUfUUKKIN9zlrFTGbhhdrObb0HWknkKEOKP6HFfa7cAoPjf
         ILEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbTEZX5d8SYBIaVLMhy6GTsxGkqIGSXCDHdrUwx6QdPjulGqYA3oV2oFmMWGLGxJDh7Gv7qHVHywg2uHs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YygRdRipysIRuQF8/HIo+tsSOhMaqdAvu0U1faNxz6hnvLxx88k
	R6mcmDp72lNV3Uqj/psoO2A0dXP20seGPKuWyrc1QD06HgjJZeqbS7Rv3iv7bhkb1qcTtgLVMky
	q4N89tLGXnyZ4UFUf4vRrNl5DQ7iTQ1g=
X-Gm-Gg: ATEYQzxU4KzKRZmikn6EKXgmT1XpqUYYhIM2jilYHNhlk11LHKPL0U5M1cpDxIQHc3e
	qGWUmGUkDf/8B4pdGgs/H8rQ5iREwRPnPTZ5tFb4vo3EHXkIQ88a9a8Xr+R4EL/usHzkMuywRVR
	RCmzDEOAExdDcz0v1t+02/MdG4c+N9t6JL04qSTOn06eR+CDmaLsmH8EEB1/vn7P1UqBSrpSIK4
	yPi+pJoxzoT8Bi4TQHaHkEIx6fA/GgMC0J+5/08ggiDgt6DUStBs77OpJGAknN3sAkpyh/Bc9Ff
	SvSnHTcn
X-Received: by 2002:a17:902:e78e:b0:2b0:61f8:9f01 with SMTP id
 d9443c01a7336-2b0cdd21fd8mr185405015ad.44.1774965016332; Tue, 31 Mar 2026
 06:50:16 -0700 (PDT)
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
 <CAA+D8AOsCg9ZO0f974Ds3Vev8uSVj52mano=vG+Rvrw7dJ8faQ@mail.gmail.com> <317fc80e-ec80-477d-80f6-53c395de4b4a@sirena.org.uk>
In-Reply-To: <317fc80e-ec80-477d-80f6-53c395de4b4a@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 31 Mar 2026 21:50:03 +0800
X-Gm-Features: AQROBzC6RhnjxCnVfj7ajFlij0eI6AQdxlZTct8_WFqmkpRLOUfhHdGV-721L0w
Message-ID: <CAA+D8AMaOEpuwuBjO1jYuDQuLSXsC3e6CAS1Rrz5G6Z6hFXtmg@mail.gmail.com>
Subject: Re: [PATCH 11/11] ASoC: fsl_easrc: Change the type for iec958 channel
 status controls
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 9:19=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Mar 31, 2026 at 09:58:22AM +0800, Shengjiu Wang wrote:
> > On Mon, Mar 30, 2026 at 9:23=E2=80=AFPM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > This drops all the checking for changed values that we used to do so =
we
> > > won't generate notifications to userspace.
>
> > Yes,  as the type is changed to IEC958, the notification is not
> > acquired by the mixer-test.
>
> > Do we still need to add the notification?
>
> Yes, it should be there for all controls - it's just that mixer-test
> doesn't have support for the IEC958 controls wired up so it's mostly
> skipping them.  Someone should add that!  :P

Thanks.  I will add the notification back in the next version.

Best regards
Shengjiu Wang


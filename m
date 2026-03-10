Return-Path: <linuxppc-dev+bounces-17949-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CF1EA8550
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 09:29:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVT9R0lbfz3cB5;
	Tue, 10 Mar 2026 20:29:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1033" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773134971;
	cv=pass; b=SfOCiZ6Z/d/o2Fi4UTF/qd9OUdc6SgQhQcwWumPzChplHKfTY3P7EL5yOLIDRAU6m1BqE+xAYSZvwSJYymJzm5fmYExNustQFc4CEvvM4R2Fwu8VwipCu4O65jyyk11UKZjSNO/+jVrMZh9uwq1Vojn5XBO7zeirIFBKnK1WOMJous4VT18Nmcaw2uAFaJS1FPt/+ThzLp9E5F8wZ/3ZFCi/CAmwR7NZIU9d7Je/2T3CsDM4xgK+IMguDnFeMrSpXIJYmBedfmaSQscHkDbjPX0v8YgaHIOIR74Q5uulUTBRlL9H0jsXFvX31IYTtLxtFftcAfVQ7oWMpsV+VCAr2A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773134971; c=relaxed/relaxed;
	bh=Up7jH3yF00x8N37NnPn5JsG2anC4ZO7gjpanlMVKPOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGBdObyhis305PO6k4if2zRgMydb2mH2btrbnlu3sH3XOMvH0L8ZJLTX9Yg7VYrB1adiyeKpI86gmSQ37vnwRs/M86UJGtXkcFgimmApHktwytB5HnwUSpAga7cIV3Wv0jQ7c4UQeo9LfdqMDUN7hmUoXFg2IxDU/X8Un2jxXrTdvIpeVfJHOLglHOJMkHIi5+0lSCSOJHxa8RaL2SKMMN2ghrEq7OOBjHGuUbKKUFOJTlo5ZMpHJ9KOJGzqEnjhjHt68wsazHQ03WElX0O1nLZrKvkOjdY8gJ3SL5ABQfXNKOEhOl42Rv4T2Gd6dNjnZtx/a9KOwFvDT8PhzxvRtQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HT/+UXGl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HT/+UXGl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVT9Q01lcz3bjb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 20:29:29 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3598b95ad7dso6985046a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 02:29:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773134968; cv=none;
        d=google.com; s=arc-20240605;
        b=aBjKhEXKDYXnDYyB0cle8zgCRUH+36iK4We31YaxVCcuZbirljimm0gORUq1AUSJ+N
         KvCxuCf+AeA8rDyj+XQWjH9b6N6196R/xC3h8fVlrkYcw0D/kK/jwLMJq8JGZeRXdy87
         2txYD9a3p5qJS6Vo7dihGkyUz8wtVd0yD16bUY4xFECW85aIwjUU/daNvY/rp+H0MTn/
         2d0Fdu1cloPtJeGbOw+qdxKhd4FIrj0EI3A57et8F/YaTtaGhqDpp1ziF4w5m2M6iVVI
         vHDesoSobf0hTXSfQ6UP/Iw+oqHiRDVhwC7waecDLjdfNjfmpLMF8swt1VehGodaHtVp
         Z9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Up7jH3yF00x8N37NnPn5JsG2anC4ZO7gjpanlMVKPOU=;
        fh=DH2T5IjFmSj/wVKIUjxs/XSumtoZXzixl6GB2L0Sn70=;
        b=PBIfLhedVeq8bCbFo61fZcL5fxV2U5rdLVmvlIKvohYm9CfZB5AKh1I/JmcaHpxKDh
         ThHDH0ZPGS3jjmiY1q7e8ez6QGwnV+dvgxyOf3T4uMf+zHpi3qTOK0Hhpur/0T4A1CcT
         0WiVI1wuM0Ai2eJqBS7QraecObF/+jzylPxiJ7MnUvyfXm7K8m7IJmfvrfHZuBZ4r95q
         WoD0YoVol3ctbIxHjj/atxb7AkGl0QjlHeu3utzOgJ1I4S2VVit00d13rVhDZy9Mydy2
         tfNXR0lgh1XXLwncNZpW1FVaLnwp+4Kra5MJ5SJOqgRS1jRMw2vn3Tsmr0IwpcADoWA6
         6nrw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773134968; x=1773739768; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up7jH3yF00x8N37NnPn5JsG2anC4ZO7gjpanlMVKPOU=;
        b=HT/+UXGly503nLvWRy5m9joSrlDZeW1fY/u9y7sc6Z0hVzM/w3jVHpKhcNq8khdioL
         4aMgZIv8CS/MOE08kev2jIOWeVMpG7zrew5IDWnAlgHtOZP65LjZUrDXRQ3eFRl9FuoE
         m9IJ6P3b/u7bq4/owKkr2IVLwASY0Ibl41YXq6rOxpHT+Tu1b/TfBFMWd6ibgtTcMf0Q
         plWO5GQ/U7cMg6CJ7nwDWWQ4FQ+NYRY8ShwcCz+nMP5+ifwmN6Yf5PShOzfu57Lu9NfJ
         +RhupzN9T6nBzeFYz29y4Qq8Acrj7RJPHcYb8r/JVa7KTZO66Bv+hu6WiNkDHw0Ta/QV
         lQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134968; x=1773739768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Up7jH3yF00x8N37NnPn5JsG2anC4ZO7gjpanlMVKPOU=;
        b=u5bh9IW0pTYH0kony8WX5G9BneUfIeC1oxNkdo5CwveXBwD0UWmb1OEJjFUi3L1FX8
         KtpX74BzJazdSCMedol2fBTPkZ0LMxx5eYwlaGoYC5iwDPP/d2wQMwKR5IotiZoDkBfr
         RzcxkKWxeogFecNL5TjpR5hASzWnc2rY1kby7Y6aFxH7xXTZP6mr63qnmi9wCSqbAmI2
         xHae+8gm43BRIKYmA1+Qu2Iu9X1u3ArFb3lYgOXMCIJizTaz8OzlmqSE5EgN7CW4R8Fu
         X7/rWs+HfMysKJSg2D638CQZKvN/33Xe9kUZiAx9QaakjnnFxmdw6Nw6SpF6noZ/tLRl
         a1EA==
X-Forwarded-Encrypted: i=1; AJvYcCXj249i0qtPhlXOabnGDk/jvQZQHhJWeofx6rcJCabILaKhSyheeSbNVmE50KkVWjQfBOgIlh8iYINW3BA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKrCQmh0Zq3jk9xYOAtpg4pOE6/AxVrndGBmOopszfIBh5kito
	Qt0jaVDPgjR5XnoirMRDD3hJI3Nz2JK/PzZ0dNaD6og4R7KiSVG5bX3xi0yec78xMGEl51HTTO+
	noutTooOlbkH+Oo34DBh962BnASmbde0=
X-Gm-Gg: ATEYQzyTQabRX0tzP1mO6X5RNCk+vZKYKwVGRLaQy6OQFjfH3rz6VpR+8je489Depxc
	aN/8wMFUxWe15Bt7RIOMl45TOCNTFV3Kst/cd6Xt+Z8BeQrcUG4PEFjeSUkQHbdd/w9Nl0Fxz10
	2nYSSr6MNWxMfc15lXKoU4T3MjPqWtbMxSNcZHTqHL/LPIWzzBmYvmipMBjBpnn+RCTMHHnZLUt
	7gSXTMmnR0XsuoACrWdzeZfI0NU9emRmZPBRLhNA1sX26Vbkj0Vog/iV6jhCk7fL2M8Z9iI7E1s
	9NmXaPKwf35ZCKFPhA==
X-Received: by 2002:a17:90b:240e:b0:359:f69a:f7b7 with SMTP id
 98e67ed59e1d1-359f69b119emr762790a91.10.1773134968062; Tue, 10 Mar 2026
 02:29:28 -0700 (PDT)
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
References: <20260309083530.2977163-1-shengjiu.wang@nxp.com>
 <20260309083530.2977163-3-shengjiu.wang@nxp.com> <9c7c407e-ced4-455a-a8a8-54b42f706130@sirena.org.uk>
In-Reply-To: <9c7c407e-ced4-455a-a8a8-54b42f706130@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 10 Mar 2026 17:29:13 +0800
X-Gm-Features: AaiRm51kpGDxVUwp306p9yXRCDiX0441GzksaY-s4uyolXBTtPbdws2JZvFrKBs
Message-ID: <CAA+D8AMOqTEPico+FYSd2Dqpux5GnhkMWc3dnJNXAsfGwV6VAw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] ASoC: fsl_sai: add bitcount and timestamp controls
To: Mark Brown <broonie@kernel.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 6:42=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Mar 09, 2026 at 04:35:29PM +0800, Shengjiu Wang wrote:
>
> > +     SOC_SINGLE_EXT("Transmit Timestamp Reset", FSL_SAI_TTCTL, FSL_SAI=
_xTCTL_RTSC_SHIFT, 1, 0,
> > +                    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
> > +     SOC_SINGLE_EXT("Transmit Bit Counter Reset", FSL_SAI_TTCTL, FSL_S=
AI_xTCTL_RBC_SHIFT, 1, 0,
> > +                    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
>
> Sorry, I should've spotted this on earlier review (though surely you
> will have seen this on running mixer-test?) but these fail:
>
> # # verdinwm8904.2 Transmit Timestamp Reset
> # # 0.2 Transmit Timestamp Reset is a writeable boolean but not a Switch
> # not ok 366 name.verdinwm8904.2
> # ok 367 write_default.verdinwm8904.2
> # # Spurious event generated for Transmit Timestamp Reset
>
> The reset controls should be volatile, always read zero and not generate
> events as a result.  The name needs fixing as well.

Thanks for your time.  Sorry I didn't know there is a mixer-test in
the kernel tool
folder, I misunderstood mixer-test was a tool designed by Toradex. I
found the tool
now.

I am running the test, and trying to fix the issue caused by this
patch set.  but I also
find some issues for other devices in fsl, which I will fix later.

Thank you again for this useful tool.

Best regards
Shengjiu Wang


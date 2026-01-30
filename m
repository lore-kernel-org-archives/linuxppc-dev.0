Return-Path: <linuxppc-dev+bounces-16427-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B9CD49C71
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Jan 2026 08:25:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f2TZz0W4Kz2xpg;
	Fri, 30 Jan 2026 19:24:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1036" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769761499;
	cv=pass; b=oYrRggEdY6MRZn7dE7AKiCLJEljZ0j4T5pV/uWdHIFuCDAfyqt5IR3qYVv987MmOuCjclx7V6O/q3bjK3Oa4oZT7+b46PkGOHgSgymEaGLKFv0UYia6bAscBQSnHaGiUoNqdEB9mSIEaq9e9Yjp21BmcQXra+8XguGtkh4id7PPn6O1NgQUdvgLt/5BnEQFt2hOjiwrdGFWS7Xc1f06WH+J/7qNDzBaZIlH/0TnzO6qBGt7Odqiuj+le0JQroFBt9eQts9wURQ+Z8xT4BVrI0/hdDg3QZDo06bPkl6sW2MhclvpT/Tl0yaHSgrBbDJdJRx/Yi/ckHSFc05e06T4rLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769761499; c=relaxed/relaxed;
	bh=qIF2oyc7jSMJyV9MJXutUw0TkKSVy7Ny/HYiVWp/mcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gG1P1iMXCLf4Kb+gVeysBWryn70TnIIo0ywsJ3GawnsAtJ0B6UuduAbl8JEDTF5C8z2t2H5aB1ZJ9aBs0f9oMBzaEjnTTj4mS86bsUrg9kJZU2E1dcGdKu4iF/7rW4E9yhALjzGZ8Cm3vSVfBbjC2y84NXOWv8eC7xNal+dD0pM8/OqWOepiU/90oAtsmKE6q/o4m2/q0zqgnDVGzuanmr16YCNcJKAEKLtwMGxhrg3BocLmY8ZDVAnFeRfdcyskQLEqXoi1LUcm347nFjU6kO6zhshb45PpfcynKOR+s6q3QOs9KCqWJZgHYuaLjz/MrKDjSjUPxAc1/pXao36fQw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FJ1hJ7se; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FJ1hJ7se;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2TZy2c7vz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2026 19:24:58 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so1547034a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2026 00:24:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769761496; cv=none;
        d=google.com; s=arc-20240605;
        b=AWPZQWme5YMH4j0r9QVLcbjyALTmidskixQf/mmDroACFXpK/JIFqA7b3pwXYvrzWd
         ary3AocYH/1sNCay0axLMO0FB+JNKGkdzHKD3SdBJvd9pbH9BgnaCvATVu6arSzcWD8j
         sRgtNDJHPiNH8IbHCv1QcOQR1f+8IoWSD2ppASy7lLF1sZ/Wza15jvnk0GJVTM3RHPcM
         wV+VKylyKprXNdpkre3ilHrBXWRUht+OVVpty56vsY72TLEtHP+X/sI5uM0xHjK1fwHb
         he54Ht2canWG8VqaCkvJMiC6+NLy0x8N51ul8dWLZVKcAV20elbxkqlBBaJEUGnmLO/z
         V5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qIF2oyc7jSMJyV9MJXutUw0TkKSVy7Ny/HYiVWp/mcQ=;
        fh=3qG1i59VktPhOcwrTjetewHb1gAwtXlN/zuKzuEUtgU=;
        b=ddM1wlUYAjYQtDk7Hk4wjUL7u18CY5+x5RNSGdMgRb1XXX/DcZ6+OxaYMJt6inB+eb
         zrR2x4BGtdMAeIbRXjvUVxaws//MhVU+Va5l9XVsvFiX5goBMT7RqBQDr9X/vhUhcf+Y
         kaMeZHLdNgL5wHokNTfTq2IyAKDjJ7dH5JW49BBq/sL9eCU3ODRx1hZZmor8WKu0K7je
         WuOg9smCFnLEwx2zvfltSc8K9bNUSH2qkhsTBdwTfknN0S8gPv93QVtfw5aux31UtPL2
         glMN0qZ1O/u7CleEJ10yDpYHvNNczLD1LPEL5SRpwMkfcPB/IAKMABtxDnMwkkMBqoqh
         e+jg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769761496; x=1770366296; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIF2oyc7jSMJyV9MJXutUw0TkKSVy7Ny/HYiVWp/mcQ=;
        b=FJ1hJ7seDIuqw9aOH9QlqOR+uSBxQejjZ1iBs0s5qns8V5Nip9tHkr22BQLl5eGR7l
         iaz3OM3EEp30GAVDoJYAuug9uA3fhNlnPRPjlDSefsX5GdiZQeJX2dOJFNMPB3p8xE35
         YpKRFbOl32tkNUQeHSTgiwR7IpbuiswH/8k0f46u4nkRqWofb/3cWBQN2HrCFMAAzwI4
         oQhbcvR2LLs5B746yzHj4VynSQcg3PTUWw6uEKegx3hLTpc9KBVNYhmiS04CiNuUtwxb
         CrCnKrnPaN12R3Bs8++B6Nbat0/9Wwre8WZQleKp+psWvdKho0opXbkIBp5P91ppSx12
         P/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769761496; x=1770366296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qIF2oyc7jSMJyV9MJXutUw0TkKSVy7Ny/HYiVWp/mcQ=;
        b=fsR8otjHMXEZHURHCwrmsRUec8gNB7tGr91ruujaLgSMyYylN18g1GjYfjf1363MBL
         NY2WGutKka7v+3JyHQZR+827R7MIvpj468xJPSl/Mo4MlP+YgXJih8ANcBR3CbCR4dqe
         yK0iTYkqclc9qtXorjjhkroit0I2eX25RcL+7Xs3AGJ0Z+d+NhRSLXOQISZioqzUxyvH
         z+q6NiPxpD1OVodOqH5uGBK+71V3Gbiklp8wiPDeA6ypu9bbnftJ4BJmOuH20xpenWmH
         OqQ83yt3qCS3KNAxZ/HiJ/HSqjZF1KtzWyI9SBMxoqPH7xnesNV52wX010SurobnuyRZ
         56Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVRQyOkwEvlYpKC7c6woTP/crBHAh9B8tNHqw/h9avaPfyOEnmB/Ji59vDTiydeuxOCufPEa/nCQpZo06E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzIhFsyVhbEyD29eBiaZA2tKlXFzAl+dMTuFvmnsA7Ri2EGAdtR
	pOX47blsHKOZop0/uYN3pZnCCRHr0n10tzXd2mwDph6P6iLzKLyNqK4Xij09MFTRf17EOYiM4IY
	KAOtXytTEvj4KWLMv+W0SuO7JwYUg5iw=
X-Gm-Gg: AZuq6aKJnzu5Si+uKMosYk2DC+AYPYTdCj90dZoN5Aictv+iqcw4qMSB0dAE2TROYZ4
	n17DML1/tlOW20mR/x3EuhpDwGJ5zlIb9njsL9DEYffmVerME2zMcgGchwPZCDu9+PhUjCm9B+J
	S2Hwdtt7br+MI11tBHItqKjkLEDcW86M1wTmHYtvAmwSlJlS7iVA2P8qpArsxum/pR2Kd+t94yE
	BN5Sm2Bf5muE8sJ1kPN2GeM6oH3cT725qT3k9o8HU9x1w5R/FTaKg1hz4j+A5Khw6Ob93I=
X-Received: by 2002:a17:90b:35cf:b0:353:e91:9b2f with SMTP id
 98e67ed59e1d1-3543b3c648emr2292966a91.37.1769761496076; Fri, 30 Jan 2026
 00:24:56 -0800 (PST)
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
References: <20260130054330.3462544-1-shengjiu.wang@nxp.com>
 <20260130054330.3462544-3-shengjiu.wang@nxp.com> <CAEnQRZC_6xRRi6y2t0MGe8udTPYWg9XEBFrxhFCbKYBCCD=OeA@mail.gmail.com>
In-Reply-To: <CAEnQRZC_6xRRi6y2t0MGe8udTPYWg9XEBFrxhFCbKYBCCD=OeA@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 30 Jan 2026 16:24:42 +0800
X-Gm-Features: AZwV_Qh3nyHcIbEYDDCvGcF70iBOk8SCVrc7tCSz-T6YiK9YuuynA5ywxyM9ma4
Message-ID: <CAA+D8AMkaTkHL03fi8THxK-a8xBR1Cu4BcNC5XfeZvzvwJ=rTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ASoC: fsl_asrc: Add support for i.MX952 platform
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 3:27=E2=80=AFPM Daniel Baluta <daniel.baluta@gmail.=
com> wrote:
>
> On Fri, Jan 30, 2026 at 7:44=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.=
com> wrote:
> >
> > Add a compatible string and clock mapping table to support ASRC on the
> > i.MX952 platform.
> >
> > The clock mapping table is to map the clock sources on i.MX952 to the
> > clock ids in the driver, the clock ids are for all the clock sources on
> > all supported platforms.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> At this point imx952 has the issue with dma request not cleared you fix
> in patch 3/4.
>
> So in order to avoid this you need to swap patches 2 and 3.  And in the
> newly patch 3 you will fill fsl_asrc_imx952_data with correct value
> for start_before_dma.
>
> Thus we also keep everything working for bisection.

Good catch. I will swap them.

best regards
Shengjiu Wang


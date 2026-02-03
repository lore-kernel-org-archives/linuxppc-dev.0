Return-Path: <linuxppc-dev+bounces-16543-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4086AE83060
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Feb 2026 08:33:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4xb54vjHz30Lv;
	Tue, 03 Feb 2026 19:33:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1236" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770107617;
	cv=pass; b=TLmyKAgtoR40xPYulCw3EBIkhDJIwfDyJiIg0lMOsTj8AtNGaAMo6QL93E/EhmiNOpAJGo5ZfjlppPnWC1lIl0Z4byZK6eE55AYyf+A9GzQupp25hcsQBxO5Aa730TIpYh37YDSHOIpR2vwuDVLFvaZxkKsGo9Xbs4mXM+a3zWSvHRgENf2zYhkBBTPvJWmTrzaThDyJ9r4Y+tUSewivGIddAY6z8gM4UqQ6VsjW2FaKMPiI75yOgE8YGTAz+VZcz8+r1bbFeiUsRfCCTYb6EiXXEl+T5v46TemTjAr0dyUx+RngBsMo9MJMnTSSOYRM4RNDDjULApwaK7HF57YWUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770107617; c=relaxed/relaxed;
	bh=emyZuy7uXV7Ze/RJbFb/MJbjgAkf0STJ6afujsD5fLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GobZL+zEZeEngE8PPdss8BlnxHh8tzRP7Yrv6IO/X+uEwvXZGVwpDwdElLtbPhSH8uQ5S5ixw14jBDAj1UgcnyWfJF7U+zsYYqF6w8cQ47y8kFtzEOZ6Mh0KhcX/iBIvHEz0lmjlzm0dDz9KPIHKK0M3EOQFK1Jke5KRsW40fdiIZkXjKcjisQnDNZ+iwpdyEn5iW33Bxfa8kpmRDiDJrAVgL4DKwKmNOu9BUhX/0NUZoeQ2Pe+DTuPbzQgpFKC1PzSn6FGKjLXP0MZmDqOJBqN3b1C4a3YEekrm+OWzU6cJIaKZiGkF9yZHvLsJhecz8rFSJxub65hvjTLdE3ZqAA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OdnBnL4e; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=daniel.baluta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OdnBnL4e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=daniel.baluta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com [IPv6:2607:f8b0:4864:20::1236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4xb46j38z309S
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 19:33:36 +1100 (AEDT)
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-12460a7caa2so8128279c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2026 00:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770107615; cv=none;
        d=google.com; s=arc-20240605;
        b=V07E+FmIX5oBIUzn2YOjFSNbeJ//uPXN/hmzKHuFHzJZmxdrXNMEC2t7oONqnuzFvj
         Wp78uoX3QXs9pg5sSNm2M522Ev556u+EBUGNqiCS1+dYsjdfDCAScraXZIiAtqfVWlCA
         yOUMMJWpOiRjMnaXonTZCZDNj2a8GESzPhHFFvHl8vETEqlCCaRgUewbipw3uFD1kADV
         symV2TLFvriahF/vGeeA69OsG5FT14R2jc2318vjhPsRfavMH+vPnt0oXxzOy5/8tnSS
         quoEUOp/p5jo6GO8hVz8M1zR4ww/RYYsj2FtoRmxBMiRfoMuwEx0e4gyZcZFh7rh11Hz
         ZzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=emyZuy7uXV7Ze/RJbFb/MJbjgAkf0STJ6afujsD5fLM=;
        fh=hgx2WXfTfly+ypbhdmApBIUYMVjnQWZt3+Kh2mOfFLY=;
        b=Du1kolPtjODmD7dvxz1C5gKYuJaTh1CSmVnQK3Zo9iADDnLrnph6FS695qzwWVyZIH
         PLYKBKWC5+jsU+I7/MsYrNGio6+dYbDdFFU0F41Bk1s4zl71D79d8Z7zjBwClg06b439
         xg7yMl5it3H2AYbLxQOTiegaJEF+Xt8QEbVrLyWjQI35ZMWFETmlfkwH04M56ZlBciUj
         /kOhVThmUqt/Rs9PvUQSlzIwuJSG0wgYBT49ZYSsvhszsQcJ4QGLXMwKYfnRBrdbWkIt
         rj0uUHDM9/QHgu6j6m5kmtm9aiBghfquAfAD8UYnPsYOu9mmlgGkpsIcsqnM9L0O+lYi
         Rdhw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770107615; x=1770712415; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emyZuy7uXV7Ze/RJbFb/MJbjgAkf0STJ6afujsD5fLM=;
        b=OdnBnL4eE3HGYp+jQcMpUkcikk4+6xxkAjYW/G0Dyvn8PL9xW0Rpk0l90ExDMhtou4
         2cwMJJw3Biym88DSJ8jl5v9R7AZp5Ty7+HxcdCVwMixbqq5BJY087dFE5F5eoqPT4O/f
         XUHalC6H9E24dPvQkrMaQCqZGlbzLP8JDKeTPKdqECuJzE3r1D7muEJJbo3LKIf4nXdh
         6AfHSQ1XXYRFnV6/fMd36dkg+cluDPytrYgP2FoECS2/ybioDGkamVxx9WQjF7TwlWOp
         F20xh3mx7nyqP6mmQKQn1C7ko0FcwMcXlLS9K9py4O4JqYH7ppjmi4Tj6+nElSjLz7i2
         6x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770107615; x=1770712415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=emyZuy7uXV7Ze/RJbFb/MJbjgAkf0STJ6afujsD5fLM=;
        b=bYnWAEfMpHakbacXvJLjZF8gXUlEdxR5bG8Ay347i48SVCeFId2i0WMCEYBzkDkGcp
         YSEkemXUR/viwkmJsMO+MPbR4OsvwyVDNp2zhXtdHOwP5h6P5MFXVpId3pF3OtNxFJhH
         wEdQ8KHVqyipDTafBuJkQxeaf3Oo6wwy8e5KO1rFMzEZdh4oT2/el45nDLMp/kKbnWyj
         /4ZFFJp3rHKWbIZp8XPSN87c5b5XunDOJBZ+ZpTb30iwNjMYafL5xo5US6DrrC/iiQDF
         MPP1DHEBJ6ilBrmnKH1ma/ubEDcI5+ewNaCX6QpyP1IWrch2Brn192N4T2UR8hOQrICv
         tkCA==
X-Forwarded-Encrypted: i=1; AJvYcCUqrZTNd1p0zo6lQXQtxRpkU0BxYyn+QIdgMCP7gJt7nkmSIqnf4A2UKtoxSbjM+jLkBkxYMtKh6iPMZD0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwdkGUUbC2EAcxenk5sQBKqC7h5ymvot/47Xr1mrqdmWKZ1wDSm
	s5SIs0ci+2yAgb2HpBI5FHS1UZ8Ltgi38UQ+hMuOeaCMeDnaZQYmgJwVW4B/5obvMDLSmynzf36
	Z5TWuLzd0VsaRokRqTrHDbQb67Nse23E=
X-Gm-Gg: AZuq6aJH/WTCXjDF8r/iyDi0fMBymciO6+yF1TdzZcFTh0YdT7SbgwOoZKwSXj6AuNU
	nGf9+dmzipkxRDWWECMUvL/Yljx5wYCoeVH6URoUw5sFLIthzfYrfmYFG52PIX4xnLloncPCOeK
	imVDFdQz4WQ3OhjygLHYso52lezNObwpNh+hU+AK8A7m7pfwyYcFztxLh1qkKLL3OxPffU0SHSM
	bzxN8Bg6z/MhtAx0N6fcZe3EB50hDFAg/cdQ4AJ/RKWk2IsQaaoV96hNEmWPkC1YPA+//Hi0nWy
	IBt3HRtIg1s7bzzzNCP+c3h8ZZgHig+kUFSCWIX96gt2dThvouV9eBZlAkiRDhg9u33uMIFvCcS
	270Cbbsp6aw==
X-Received: by 2002:a05:7022:403:b0:119:fac9:ce12 with SMTP id
 a92af1059eb24-125c0f9d262mr7374498c88.13.1770107614645; Tue, 03 Feb 2026
 00:33:34 -0800 (PST)
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
References: <20260203031345.3850533-1-shengjiu.wang@nxp.com> <20260203031345.3850533-4-shengjiu.wang@nxp.com>
In-Reply-To: <20260203031345.3850533-4-shengjiu.wang@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 3 Feb 2026 10:36:16 +0200
X-Gm-Features: AZwV_QiN7aElCqGBVfp3lxdbVrrkTZK84USf8JhpYodb0geCaRz0C4JnQWtK0dQ
Message-ID: <CAEnQRZBkKG61b8ytdGKsRqRsfHZ33Q3y+fK0Pkx1hUnw8bWkUQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ASoC: fsl_asrc: Add support for i.MX952 platform
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, 
	perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 5:13=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.com=
> wrote:
>
> Add a compatible string, clock mapping table and enable the option
> 'start_before_dma' to support ASRC on the i.MX952 platform.
>
> The clock mapping table is to map the clock sources on i.MX952 to the
> clock ids in the driver, the clock ids are for all the clock sources on
> all supported platforms.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


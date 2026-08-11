Return-Path: <linuxppc-dev+bounces-25734-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAA8C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 08:17:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK4HD0NjDz2yvG;
	Tue, 11 Aug 2026 18:17:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::62d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786436247;
	cv=pass; b=W317SAI2frOdjEmlRCbyNRcatThMn2oh79+LP1vfobx165G1K2Ais9jdlOlElhvW04vGG2TSe/ZYFcOWPL+8NrEt6r0NiOdrt2EsaBtwPpQPOnwc77bFn2Tt0iQI8LR2Dsqvn95oklL+ZJpAdB82PsITcE+QkVGxRwx/ouIAfFSmnvu2BBG7JHHwWmksZ1PvdekmcVOWNeRmyLhR3gJmnx85ngaX7QsxND4osH/Zz8lFjzmJN2wqfqOdCYWHPl4x7tawHsXxORJl4V9der+QphsihoWR1mYJPDIBKMKR7cMEgJpYLg5aEnkGoSEPqPMJP+M1wtHJj26Xy6glr7U/Ug==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786436247; c=relaxed/relaxed;
	bh=/N6NxxZa1/RwsdJJL1XOaQxBTanGcXh5CEXk/SH/G4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBrhcF4SsE5raKUjy/x1v0i+K3xNh5MdztT2BuSgrljs5llWltjqtz4qr+pjiQaS1s4jhwtvT/K+lhHFXamJ0HOYdnGuOGskqGuqPm4ikYcXOZ1LhURq/D8FsaRyNXolyafLXu5kraXN24IvzVFdFxY3lJ6vLnd+/NlBL4EJrF9Qp45g8FPwGd4ERBet8gBMNhwIUtOqO/I2Ap/8QIvpVLl301B+YATSGwwt+BZaGXOHtj9mvwB4zduqmkVCcxbg5FXu6hH2Upx9I6pX027XT5OiP+f4qXq3Uilc72QoHKv15c+8Hm4Jeu20EEJkpe5mQINGe+Lx0wn4EGmCCYAH3g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P/epZspb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P/epZspb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=shengjiu.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hK4HC15XDz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 18:17:26 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2cf452def93so6214155ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 01:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786436244; cv=none;
        d=google.com; s=arc-20260327;
        b=pFo3tF3qsIY/djz4lWItgRh3xYaX5gf67+shFNFsCap/mtdSDh29VFIAL2xTSN2wPS
         bFzG81T0s/qx+5BULym5ZXAXF+OMkBbKR9/mpTJp8SSxKaiO+8voO8vpxH81U1B+tqe+
         Crw2aR7MA1uDx3M/wFbNQ91vpENw5gaPNxrAxG/Pz8k93O2CwVWWpaGMDbNNDEayemGg
         sjSrYn/+BCJEmdD2cMTgR2E/UqxivAyBTnTscOojXmxqJTxFBBZKjw2vkqkIWYoI+Y/E
         PH1v010tQSWIHFkPZS2qwWchuhu/7HjJab2g+kCvk5/RyfPUeGEduuVKH0FSJpkU3AMv
         vN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/N6NxxZa1/RwsdJJL1XOaQxBTanGcXh5CEXk/SH/G4M=;
        fh=LjoPnClf8IV6C9Wu2FSVv22hHYi1Db100xxxl6HrSzI=;
        b=n/P5r+Eq7f5FHX7XXhKH12sGLn8Yjop3L+r27uqIWp8cP3++C/KtokvsoyK1IznaUI
         X6mk54rwdRJFNauyGPkd7ixsb9c7sv9HB43kJOYGHq4See9owMzO0jv5Jza2SfzVUgbr
         uEt5yaefCTzr93Ef3S6sQN7V9VoE9dY3o1/SES88oxzL8Ux0JHsQKf8yPHts6EXEXFoM
         2iFJrxR51hJd6Xdgl5WSPqQtlsZnGiMhMeBZO1W/mCjaO1DiTOYazWI7DThdrd9k7ID2
         uzdzEabw/9hcnOTP5armccjdnQMfOPdskMgJcTFgY0lvFOWha6g/Mv7lviGZ3twfyFHZ
         LQaQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786436244; x=1787041044; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/N6NxxZa1/RwsdJJL1XOaQxBTanGcXh5CEXk/SH/G4M=;
        b=P/epZspb0BfH410Dgc23SgLPgI/QnZQUC72yrX50CKs4gT3xqim7EZ+n4GuCdd5Svl
         tQjbq/WeWx9fCzU6RATkhZo/AS1nOA/Qi6mgTSOU7ZRWEcluo/0oAsivYSAYyrZxbqQ1
         2Wk3IE0Xat82EfHlpIKwozogJk2GXYIERGlBQ/eCwvfWpcF531XGBedOvDTRh1C81Uk2
         XAzYIZG/7vrtcH7RhyB/irimV67P411ZVsbTad1IuyJWueHSMgi4CuZQh8H3Bk9CTwrO
         Rp0TtNzNr1Rc+sFUrn7Gi6x1OJlu5qV1i8DNmEgxycpmyZZxTbij4fPh43CCm4klC8sP
         DX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786436244; x=1787041044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/N6NxxZa1/RwsdJJL1XOaQxBTanGcXh5CEXk/SH/G4M=;
        b=XV2mLCTY4FMvMKo742Xt1ZoRuHV37jmZDk09UsHrkQBIAtmJx/eBXZJruiTgzO5Tbv
         wM9JivoBl9Eow5dICiWCir9c8VCTkl9PBbMllTO1Q5yQga8qRh47Z97Ckf0Ah5UDmPYD
         7cuwAZu+cfyLHtcpYSlTjsiN24ZKHXTcfJb/naJYk42LSO7dcatCkn9Jy/Rs20mOccwb
         zXwIOoXGtMkBbtE+EEwkOp0jhL0wVmx0QOPNRVp48Z8bi4cSlnDoCfY5OCJhXCxkMekW
         +uu/UM5xU6XBXEMfOY/gosoC591xld4qCwAoS5iAPegxCJfsh3HwuCvIBk57MVwDNPRk
         rTHg==
X-Forwarded-Encrypted: i=1; AHgh+Rqef4gC4u0O5u5984GOgasGzI4TJaJHGRMpTVg8or1eatZRUtIUq4eumZOVoeHJQilR0FiqCwSWyf3JfE0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzurPZiJSLd3MOlp24W9pSxhATOmcLCzLE0dMi31Dv5z99wdATR
	tWbyiy8ygAxGs/7RcyQbcYqlOa7eGkReIzfJYsERimawUo4PB0usqfv5Qw53N7CGIs0wdRaGGVn
	K+GSGki+z35/GDzndL6qTsK/QRbtlSXM=
X-Gm-Gg: AR+sD12H6J0k+EfDU8bJujjT0MhBPGriEoHb0R3dB9l2ewwTD+K29xnTNd+gzoRfv5S
	GqpO3o7nEmi5ycLhur+flMg7qxG9X9aBSADn0VLoH3xPefD1+z6bei1GYKQBOgozPDcWV1RRxiE
	bJVjpjWDqbWFJXDepb0+dHSDSMKrwIXgXbWfjZdeyzr9EzfGYK/ySQPoUKgSqGax5Idqk+VG5ND
	N6cCqc3gGHmRUD7pYpFu57jYYvAziCasGWBl0OYAUK2WZkYzfQktwW2RXUYmmmvLPv1f5R1aXh2
	MeRxFD6T4X+Xj5NNioJGCKiZfUKLrUsRSq+eZnBO3cDvqM5PQFfnmPI=
X-Received: by 2002:a17:902:ffcf:b0:2cf:7ea3:7cf1 with SMTP id
 d9443c01a7336-2d31877be01mr17789185ad.5.1786436244086; Tue, 11 Aug 2026
 01:17:24 -0700 (PDT)
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
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com> <20260810-normal-cuscus-of-argument-4b230b@quoll>
 <CAA+D8AM9s7EX-G246Hf2=DOx5q2qXWg_MjUCaoJ8RggOjp+5cQ@mail.gmail.com>
 <dc40dcae-3017-4e61-8c6d-7e6127e4ee77@kernel.org> <CAA+D8AOQ_y7BdR4h+X6qxFygPU6h1iFV0cYXHN4KB370yM2Bkw@mail.gmail.com>
 <3219a2e7-d11b-478e-ad2e-5f1ec2bbdf27@kernel.org>
In-Reply-To: <3219a2e7-d11b-478e-ad2e-5f1ec2bbdf27@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 11 Aug 2026 16:17:02 +0800
X-Gm-Features: AUfX_mx1LX0wZY0j5iDajd7W5oe3f6Rmcs5OiNPXvXt3EbMHLfrVtGbE60ayIAU
Message-ID: <CAA+D8AO1q-n2S3X2d1ZZ_yXxNrHPjCPvrJrPZmTMOYZM9uEGeQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
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

On Tue, Aug 11, 2026 at 3:36=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 11/08/2026 09:33, Shengjiu Wang wrote:
> >>>>
> >>>> Why mentioning upstream in the first place? Either this change break=
s
> >>>> ABI or not, explain that.
> >>>
> >>> The deprecated 'port' property is retained, so this change is fully b=
ackwards
> >>> compatible and does not break ABI.
> >>
> >> So why? Drop redundant parts.
> >
> > Ok, I will remove the sentence below in the commit message.
> >
> >     No existing upstream DTS file for fsl,imx-asrc uses the previously
> >     documented single 'port' node, so this change does not break any
> >     in-tree device tree.
> >
>
> Honestly, it's redundant, because you are not dropping it. So even if
> DTS was using the port, what would change?
>

Understood. Even if a DTS was using 'port', nothing would change since
'port' is retained.  I will drop the sentence in v4.

Thanks.

Best regards
Shengjiu Wang


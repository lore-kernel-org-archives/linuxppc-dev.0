Return-Path: <linuxppc-dev+bounces-27894-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEFBC982F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 07:33:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpsJt57C7z2yfy;
	Tue, 22 Sep 2026 17:33:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790056919;
	cv=none; b=mp7K2a+UupeUtiWKC75YpLKHx8Cud8axGyqzg9mlj1RI7ILOkV3ljksSaciStEE7jnMpJAB415pocJscy3sZsqOvvPS8aIzk96W0bF7mM9C06xFl5dSDJjAw+eBLcD5ppeA/cKiRhZy4+2Q77xWt7C81VnPjumRXj0suSVDmZCn0q1MsusEEo6THY314Xs947dyeGvruaKclvrmCorPqdqZpY/pRfbdLfIkqvw7U8CFfDfZdVMTTox3QtTzRLjKr2T2XNkYdkcQ4GmL6U+CcrKnNxRz8CB9M87F+eHRtl6wdMolRPti4pN+o0jj+aWTH4uOn0bC5aK/bmde8cgFvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790056919; c=relaxed/relaxed;
	bh=37Eexq0zFYxGYgBaFUWATikMtDj/TkGR7YrZ6T7c8q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKRpozf0LjUa2ivgfGxbzwVgY/DA6pCqwWN4ilmjWkMlGoVICd1j2VS379+jcmoFwoI0dfXK188iQzue7qxYW5+78yDsl8TUFH29Wx+7tFEnVEeiJu/D+6P/uXDKkdc6HgQ6YDPnoEZKCXbo7wMkYtAATD5QTKqwL++WdZup3pz81G7nCCM7j7RZWRQCNbw2MZBIJajqqj5PwU33F6HEeVERPBTOMt6Z8f7lglNdSR9cz/UJtUj/Sz6MbItIK9m7zu9QklOqRr8BfEUjI1MLCmBnjRvlyiB+kkoSmut4XoE98yLHuY67KPOUHa48HoZPGV+6pC3/e7m6npZP77bIYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UCEg2OL0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=chancel.liu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UCEg2OL0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com; envelope-from=chancel.liu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com [IPv6:2607:f8b0:4864:39::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpqHV23DRz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 16:01:57 +1000 (AEST)
Received: by mail-pj2-x11.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so2771848a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 23:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790056915; x=1790661715; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37Eexq0zFYxGYgBaFUWATikMtDj/TkGR7YrZ6T7c8q8=;
        b=UCEg2OL0GTSuMcPAurAWckkJBcEQYec7B2Nr3uja3NmVwu40B+uXlmKkFwpC1wvKyC
         AS/Hs5GiTrBu0DW4L9bZwlaESZTYBhX9Rj3tx0XTbFpDpY+lkn2e+j/f4T3vZ+7Y1lw1
         cBAEges7o0ynCInJSMsSNXYjnEOOfOf0+agwghZmeEF+BwnOjpWFArJQRwoGt7lL4UZ4
         xD/YicaA8hHYGTy1mzZ8O/j4Rq6NZZRbhZIQSAp0+59RRsE3BqtogsMX+6PlzZwgw5qZ
         RIptX9GhJKZ/Xlne9XqJeeQjUTqowcfkGqHmI8mJb/IfHNaHKEE47eHfkIGipZ3jOeDs
         14aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790056915; x=1790661715;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=37Eexq0zFYxGYgBaFUWATikMtDj/TkGR7YrZ6T7c8q8=;
        b=hwuaemfoUhGO7aHdukLuK59XW4vC+oYr4kqeuWdVH6ckoiD2C/LJG2k+xKshV6PJSA
         o0wJKKB/1dVR8kr39yVivB2AkHlFLqaL3NgTL7ySkhY1TF9PADm6cJmLfuKr+kle8avw
         kUsymwdcB2aYKhdmii9fPn1huysr2lRBBkKKg5oM6JOJ+n2HzL/O1AoCk360XzoWy0tq
         g6XtYxJGrZPdyOhHe67oWp7AU99sAGXAg4KjQXaVDdzxjqhyy4vmId2Q627uDo0S0QDV
         Q++YHXAYTkkdIBg3nznKGeXfWVv35tS4vNLn9EgqOTvj48TIuRaklCctBSxPP+D3KLZl
         eE1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxg0F1+opWQ56boEKq8SVyKDGlYAEF+xJC4ouz77tWMhMS95EqXQPDsri9VQavCWRRrIkmH5tDv8+Vvu+Q=@lists.ozlabs.org
X-Gm-Message-State: AFuF++l1GLXLm88ukRzoaLNYMfgAH4OTKpWga3u6H8Lbf2IJJIfUVxDb
	65/2zY5QI2hsJkU9WsrTLJ1PsHT72wIQXfeY6XmDi+rKSAu9c12e/kYW
X-Gm-Gg: AYBFou3A/W4C9phWD75jmDd4QKs7XfzAHZ/lktJN/i1aiAH2r/nuxr1UB9+4j0yH5HD
	qPnZGpJqCc2TAiFDGu+5S0H3em9wlar0xf7lTMFemhoaHK+a4w2dUhoosut/kEsBLWR5hG+jnrD
	AC7LdYJGFwfceUoKhO22+8hQGgZmYT4DdpAXd1g/gZ9Nnh2ZqU5mH3XdBQOFEm+y+Reb/7gcowa
	uPCpG7v/H0xuOjwirQegoo+/TYlrbaW2xCnIiGiE5n4yuB35nOg4Zh9HmwOVVz5HkBLaxYGXYkw
	qGz+kZ0E0N1gP30bdCeGXqrRyFvaJGP037OSTR+QOUyXAMVsx8v/yq64giOHEFNgZ3IfMgkG5w4
	15TSNY+I7ZuhDZ7Kh6gYeYJliFfs+KUeBkyT/NxUbPXgDHjUvkcKHBSYhb4rJL1sKQ/v+G62KdG
	byIzd/9yZAJQTDoCnn5JBMvOMmjmM/NiqXb5RH5GDoX6KBaLUVgbGrytA55hvWRMawHAjlBfuYA
	6JESwiM0d5/9Gbf5lA=
X-Received: by 2002:a17:90b:558d:b0:39e:1ec8:ee7b with SMTP id 98e67ed59e1d1-3a07309f897mr123698a91.7.1790056915456;
        Mon, 21 Sep 2026 23:01:55 -0700 (PDT)
Received: from [10.25.133.25] ([165.85.205.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e610e8439sm2788903eec.3.2026.09.21.23.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 23:01:54 -0700 (PDT)
Message-ID: <878dc90c-3a4c-45fb-bfbb-2ba802bfc14c@gmail.com>
Date: Tue, 22 Sep 2026 14:01:46 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5 4/5] ASoC: fsl_asrc: expose individual DAIs per
 conversion path
To: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 shawnguo@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
 perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
References: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
 <20260922033428.1690822-5-shengjiu.wang@oss.nxp.com>
Content-Language: en-US
From: Chancel Liu <chancel.liu@gmail.com>
In-Reply-To: <20260922033428.1690822-5-shengjiu.wang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2026 11:34 AM, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> The i.MX ASRC hardware supports three independent conversion pairs
> (A, B, C). The driver previously registered a single DAI with generic
> stream names "ASRC-Playback" and "ASRC-Capture", which prevents
> multiple independent conversion paths from being used simultaneously.
> 
> Replace the single fsl_asrc_dai instance with an array of three DAI
> drivers to allow up to three independent conversion paths to be active
> at the same time:
> 
>   asrc-0 -- ASRC-Playback / ASRC-Capture (backward compatible)
>   asrc-1 -- ASRC1-Playback / ASRC1-Capture
>   asrc-2 -- ASRC2-Playback / ASRC2-Capture
> 
> asrc-0 retains the original generic stream names to preserve backward
> compatibility with existing machine drivers and board configurations.
> Each DAI retains the same channel, rate and format capabilities as the
> original. Update the devm_snd_soc_register_component() call to register
> all three DAIs.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Chancel Liu <chancel.liu@gmail.com>

Regards,
Chancel Liu



Return-Path: <linuxppc-dev+bounces-26011-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A991C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 02:23:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQS0d5KFNz2yhY;
	Thu, 20 Aug 2026 12:23:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787192609;
	cv=none; b=aVg0VyHD0buKWo+XcDCT9bN6Q9cNLmkaW6U8V/aVKaxPWL3+TLlPiqh5hPVSMAkw9O1xVKk/8jLLncszuf9K5f8lOp28zj5SNOa0erHGgtLPew8evPyQabvvrxqpmKoClL4DuuLMbSPCcOc/hZkqkZl1Wmb5xgaX5fnD3/Yt4GIN//ulj9nbXfuEp86QTMjFzu3JHm3hOcuT55FYIaYRIiXWYD00FRJJkK3o0GO079GnwZLkVMjNruz1498bT3Occ5+sC8IYZceJuG5z8kslWOULw3PevoTZjvIYEghu6URfi90oJTh+yid4nbJJnYiKFDdboPqvnFxNEL2i7nc1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787192609; c=relaxed/relaxed;
	bh=+930oIjhckqaaw7wGivirjSGVULUtrGnctjoCVRfDag=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CCE0WneI9lqXaIrjFsBFTGwwgDZ8LaTIgjsfo8cdsQaNiFmJcJaC6MRJRVgRudSxj+n+kS88HBdEgTJ+e1ez1vpqv97X5qHbUBftAcOVMk2MxlwksRcDPGK/la5sTYy6mjZfe9Ou0P6ZRTDhDFNwWY5x8UWT76fJ7uerU6a5JPjykzCw1AkrU/YlqSsXNLJlsd0Be4qGfvUhy54nDu9eTZ5X25uBynRecA3c3FNcdV2aIk5BTbSCQM4i8ecILRar/1eziigHiyZpNFv2KdcQnkAfiWxn2HLmKI9Swc3QYlLXr8Y+ahagSnPUcPOLMC/5KAfR1SkNkGhlRUkkHMYNrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SfXS3pS6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SfXS3pS6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQS0c5XWFz2yRP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 12:23:28 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso517763a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 19:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787192605; x=1787797405; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+930oIjhckqaaw7wGivirjSGVULUtrGnctjoCVRfDag=;
        b=SfXS3pS6BknTELwGuL72uT7PN9d8QF1Q5mIWP8uZhMNqcW8vkLASmnRB7udJ9bCwaE
         SURtnaHFJ66e6p8hRfow3rFfaI9yViFma6mron4OUoAn1xtrTEnsVv3wsiZi8mWLfJX1
         aDNkRSBmZZeFvGqc+vRAhYp5m6+5lbXFdUyEF9XNwNUI+JAevgikPP/EwD2AgQ8fX50C
         Qu48tHZVwqIwc7s7k/xA5sweNteAhKAh2h3Rrvpzg1R8MqAn20bXqG1JHQNtCJ1yJeC5
         BbSaYA3+XMBvZqq42jiS8sQ9QSekbIDUCykz24CGmJcn8ScZQdIERDRE7tjRIc3O6l4T
         qp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787192605; x=1787797405;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+930oIjhckqaaw7wGivirjSGVULUtrGnctjoCVRfDag=;
        b=l4Rj1aDkFyasO42ZSsaDY9Z4iY3u50E//QL/GiTzhCxgmZ23EsrRGGteKR4yzNBjqc
         OG5Ah8f//5yHZesjgAdaPxTNv8Wh1d3tVC1nWx26fzy0f9meWQ0XQPn9vRuI9RloC+5M
         dkTxZMrnW/ixruztFAtgJItJ9DpLvsN8Ijv6M8MIbD2qMXGJnov4nDxV2MFO2zh0bmEM
         XBbTvOqvHMNkMdOSa03vOAaskoUFTj6m6sWtMUHtxxImpH2pHnIcr6taJVMZcRVkkdv+
         RG0ygqn7rK6ejpmtUksTC6P898Pr82xy6z4riXDe+mU9k/kKu3WKhNNzmpO1+rV04VpY
         3ViQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp38t3CulZNaHoVQf40YpwlWlIOQkV1eGZxjuqdDtwgVlzKdRgymfbqYuDeAN/eASFffnafYtkEKnZyPt8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mOfDreGg320b8NFcqj5vpvjT3CBWe3t931XQjHqfjEe+f4+gEr
	5Q9cnMhNFNMg7s3xRX6AU9faEP/8xQSzY8L9rPOZLmxzNyEp/wXEHk3Y
X-Gm-Gg: AR+sD11ocajgL9Xj9CdEHHWoVNuMowiMeHiGfv5FTToAMaiyK4Q8WbenWiJXETJgf3S
	6/wMLXx6iXCXgpspMu5eSCTwaRp4IjlQ7jTqKwwVtFBSI4Bb2UswQqXutqMXDzKHIdGwUo25lWA
	w7GvMi9DCXCA+1AbUTQZSaxQ2yhBc46VARa7vH6OHZ38l0qRSK2FzhKqMvs6sd4XWm6yTqvv9Ao
	jQesSQyWNG9lHtxFlCeZ49+gTfGcCKAtlxVQQMvgks8IF5xpJ/RLkGKrBxparPlVc4TZd/xbFj8
	LLvxlcvZr2wgpJnSsFm3H/ekbBXrmrR2mEQzclZ6iMSq4hd1f4kX20DJKNSDGRFgdeGYrnWuSfA
	Epx3UBU4wlppf/K+xdBcCCA8A54jtxAnSxkqhTMbZNCf1OXpnIPkbot5cbY+azFHN05AisH5ZOi
	zPP4jjL7WrEPqI2Z238jsFYP1HqHuWfeksLodIklHF3WTFw80QR9Me1y0uF2xWrvPhnhKZOsWFN
	5qWLcfMDA/yYOCqXVq4zxbxl5Sz+ZOfImP/Sg+LDAZl
X-Received: by 2002:a17:90b:524a:b0:380:86d8:8162 with SMTP id 98e67ed59e1d1-395a07022b9mr4178473a91.18.1787192605458;
        Wed, 19 Aug 2026 19:23:25 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d6168e5bsm326457eec.1.2026.08.19.19.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:23:24 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: powerpc: Add Ritesh and Shrikanth
In-Reply-To: <20260818035037.613186-1-maddy@linux.ibm.com>
Date: Thu, 20 Aug 2026 07:50:46 +0530
Message-ID: <mruhjzwh.ritesh.list@gmail.com>
References: <20260818035037.613186-1-maddy@linux.ibm.com>
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

Madhavan Srinivasan <maddy@linux.ibm.com> writes:

> Ritesh and Shrikanth has been helping in the powerpc mailing list
> patch reviews, adding them as reviewers.
>

Sure. Thanks! Maddy & Christophe,

Would like to continue doing that.

Acked-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b7094a616afd..e1c5e6ed5ed0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14876,6 +14876,8 @@ M:	Madhavan Srinivasan <maddy@linux.ibm.com>
>  R:	Michael Ellerman <mpe@ellerman.id.au>
>  R:	Nicholas Piggin <npiggin@gmail.com>
>  R:	Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> +R:	Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> +R:	Shrikanth Hegde <sshegde@linux.ibm.com>
>  L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
>  W:	https://github.com/linuxppc/wiki/wiki
> -- 
> 2.55.0


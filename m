Return-Path: <linuxppc-dev+bounces-26987-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6150DC79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 16:54:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg6Mx4r06z2ywv;
	Thu, 10 Sep 2026 02:54:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788972845;
	cv=none; b=ORKgbdWmdgXOTLovv+G2vyLnDx+b3Lh2/u6CxrvDIevEd5mlNRpdPSxRmQGa72Ig5QJ2LDTRtDyApeasFBD/TNWR0S4bh0QNFtFPAwRmZmJxXMgMNcW3Z0jDwn5+ZoiauZxVwD5jM2JGOI+gzYmPRatEWcq91aVgEir0dKbQop0iZuQ0IhTG+7FqrXevO27MV/hZ8iDXNPDt7mxFoMtkTw4pzaA21HfuHlvErrzGp9ArZjpQcU0PdFzdWJChtctv+0W0cXCmWtcLn/8kn8as2102xthbsdAx94HW3M+pm3ZXJea3QqH/WFh5/HMbcgkStrYkOEqH2erj+qGNZvjXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788972845; c=relaxed/relaxed;
	bh=ciwSeHWBadqQx6YZVRZm2djgvhH+b+XMn6UtqaKUvdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5M47BphHuh14QqdR/5ZPVcgjP0WEB5aJ36VCQQG6uIgMnPFwAxdwvL7jndJT/df1Rgdh1rzG5dM6pVPKYR6O/OMYRuXU/0jjJsytQskKjl3a02XOYBUYzYSAbPvRGfEow41zDmLRNbJD1jc/I9j60XNJyhFecEF767hl10fWdJ5egRjWBSmrgN3GdcgZRFSavtob3C2fk686fmajTwTqH/JmB6Eopo80BMqEtHsEahI323msLO8fxxDkWy8G7PZzsVZioEt37GixKs9HwU8C0Lg+67i8aDQ7BfzL2odhgjAdbzY7GHkrF8egU0xPhw5HWEvwCaF81EkxyP5JAF/Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y+2LIRwK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y+2LIRwK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=dmitry.torokhov@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg6Mw3MHyz2yvK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 02:54:04 +1000 (AEST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-8558c0b26a8so4391129b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 09:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788972841; x=1789577641; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ciwSeHWBadqQx6YZVRZm2djgvhH+b+XMn6UtqaKUvdE=;
        b=Y+2LIRwKn/7PqiSxO2J9b7aLjushfMd8dwSKVBqKM+rxAiHbsfooUJGnJvV55yqJ2n
         YVzEWmE0jo1sw8x+BEuV39rHzBu8JiQuL2YnXzDNoyiAPNtYKqsZdLKvxW6BR+IegZWr
         W4AtfRt3EZKHfUvSH93tskRaGNhui/uIqLbyPi6vHtC98RjbaHr/ngKOZ+NelK0VHDRz
         zPlwUJuGhZI4roFKeC6nLwTTPoFRjY0rvL67H6Z+xzGIO9KWbGIIskOSywu+t2NQVr5H
         iGTMepA9HdyYwpSvXONfMxi6STGjzsMvhRDh/NvrrZdFhCnHX2o5SQXDlkht4Fday1Fy
         pcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788972841; x=1789577641;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ciwSeHWBadqQx6YZVRZm2djgvhH+b+XMn6UtqaKUvdE=;
        b=Kc12mWF23x5ZWkLWVn3tIDaqR6np+J+tveznrwNu7+FOLLLEt3oLklKtpjcapHr6TV
         Jk5qY2vYjJ79+r6RREHShlkEgP+DS/ferQuRV2S+jiBsRKJRB+1YseItSebT58dynIXH
         QMzz2IOHPv6sNeuRCbl6idtTmCPvH47t+Kh9J9LGJvpzEelyVJkm/ngKzDw5nP21JHpA
         H7vRxGLLdSL+G3c9ForXG4Ri05x5mK/EQ4Dhc8ecbdZ83V8p8PqQHVfmEZk5zwQbsY7K
         lXMiYlTiu61QkHl4jN0kVOwyv83NK8XY8+U5WkEQk9pTEH1YDZe0lyouWXAmTdjyNvQa
         kQCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxED6qJbEDUwCR5rtLdk2cFBt9nk87R3V7uuz+5yJLOZgfIQhgR54HfS7/OPziqK3tfq+i7F0zBWuBcu7s=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lPEor9mQ1ZyUlNlVoPRifD4ox2e53SST6syUr1Y1s/LaC4OZw9
	xRHVACYNukGFGz/x1DZWqdYksZFGGZKPuVtHz3hFpZGDM22/W1ZfzpLR
X-Gm-Gg: AYBFou2enKAtkgVtXwuOwXg/DdGI3Z/Xop5tcMZwyphLEYBzOoO5oyPZiCfhgFK3w6w
	HOrTj7BOKzbBhpeYkt7iPhL2MuEJaGPiYBf12jNZECEcMb658/vwHUSdtD2Hf5c/LcP4bowsDJ4
	5/X6Uy3RmWdy3k+suJP2mp4xXBNaOyLbBM8rZNUyEEUOhs4zGYXIdZW6nYOkVAzUQX2cLOLoj6X
	g598FKGAglQ9Zs9q2EFuNKJhz/toBlPy0KG4vkEhE2iXirXwf7VDvJ7hpK2l5dLRsanUs9naq+s
	Tti4fm3poxzSnzjYK+nfG3HSXB3VVv2L9kvordrzILbxJjtSIuEwLujN8HPtzGUK947Gu/GIs1X
	YNQMGuV3cjjsB9DNwbrnwx1DnBz/DXk5+KLbAwzW6l0PgJM0PqAXFul32K0ohzmmCEqMTSEkLwR
	JNRlJ1kggi6i+rYrnupWK32P5xP1EJ0BngrByBAQq4lz8oS3sRPXHLz/SIOp5D+BM027MmfIt0G
	izdXM/nfxPOjH1gqNcVZQRA5iv2ULg88pK6P+7SR8E1t3K5pcs=
X-Received: by 2002:a05:6a20:4311:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3da39d147ebmr54252434637.9.1788972841349;
        Wed, 09 Sep 2026 09:54:01 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2d43:5153:5c50:643e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3342af0bc08sm45655113eec.17.2026.09.09.09.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 09:54:00 -0700 (PDT)
Date: Wed, 9 Sep 2026 09:53:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH v2 0/3] powerpc: 512x: Convert ADS7845 touchscreen on
 PDM360NG to device tree
Message-ID: <aqGJQwB81hODuSIc@google.com>
References: <20260719-ads7846-pdm360ng-v2-0-1198bd108502@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719-ads7846-pdm360ng-v2-0-1198bd108502@gmail.com>

On Sun, Jul 19, 2026 at 10:37:15PM -0700, Dmitry Torokhov wrote:
> The reason for this series is to remove support for platform data in the
> ads7846 touchscreen driver, as pdm360ng is the last user of legacy
> platform data in the kernel for this driver.
> 
> This series converts the ADS7845 touchscreen on the PDM360NG board to use
> Device Tree bindings instead of legacy platform data callbacks:
> 
> - Move GPIO controller capabilities into mpc5121.dtsi so all MPC5121
>   boards inherit proper controller definitions, and remove redundant
>   local declarations from ac14xx.dts
> 
> - Update pdm360ng.dts to use "ti,ads7845" with pendown-gpio and
>   interrupt-parent referencing gpio_pic
> 
> - Add "ifm,pdm360ng" to mpc512x_generic.c and delete obsolete
>   pdm360ng.c.
> 
> This change has been discussed in '24 but I just got around to
> implementing this:
> 
> https://lore.kernel.org/r/ZoNHLjmSvCN12vU5@google.com/
> 
> Note that this should compile but I have not tried this on real
> hardware.

Michael, Madhavan,

Can this be merged or maybe you want me to make some changes? I'd like
to finish cleaning up ads7846...

Thanks.

-- 
Dmitry


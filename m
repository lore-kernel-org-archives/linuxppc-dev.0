Return-Path: <linuxppc-dev+bounces-27116-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3932C88E45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 07:25:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hh5fW15DTz2ygK;
	Fri, 11 Sep 2026 17:25:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789111507;
	cv=none; b=n/TGuTUtCgqIcrjpAjbA/PpyFlisMeCLjQUHlirXV+tDuWDbXxe4nyVX9z1Mg7Ar+lRw73+0eXfLvTmTFuXY/jhOz42eriL6B8VgSYncNibrh2IZXb0YqycWX4lk4TnSXALMNnydB1pdvFbYHbmax88bw4aCBNvPjiWJkUqfDCJDKHLkRx66I66Q+Hk5ndigmjA0MrIlFiY3LcAsB1ukuh2s454zMGldF/afrGvkl9gTuFJcgcwJBvo3Dpr/CYXYJquVTyg+ItjWfypJrBktqiZ3L1OmH/Nz0oziCCzZdq0WeL3GOLl2kcNuZQc37/wHA4YjH66JLbraj0CPtRNrRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789111507; c=relaxed/relaxed;
	bh=BH+kR55l7q2T4yQ9SIaFXw37h9ozVxD3HhYmGKf8G4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n13m3blhTYCTpFHeHc/F8bSiWx0t8WtrMsxn9yg7AJ7V5btUgMLvAdjRrO8zaSdgoRucmMoZBP/vxODet2KWjOOkUoEZy9qUEE6/Mz/bX0j2iNkm5RDg1IRuwX6Ox8+tQQMr0Z3efPtoJS24pWWWy50tGQ82cKm0V6OZMvxXx+lZZLdlE6EJY0143sTIIrzxRtW+aEW0w1FCLyVLVp/AfKHPXzQNcASUWa+OVkKS8XPZdQBlUyhKx/hs2IoYaU31wed006cetGoOFlnD0W+fq/z9mjOKA0wCh2ZBs3d6/wKNPai9PEo9A5lSoJ9POj77uGir8cnNFPTEhO43SiYFKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANl9844t; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ANl9844t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh5fV19vzz2yd7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 17:25:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DAF0542A07;
	Fri, 11 Sep 2026 07:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D7E1F000FF;
	Fri, 11 Sep 2026 07:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789111501;
	bh=BH+kR55l7q2T4yQ9SIaFXw37h9ozVxD3HhYmGKf8G4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ANl9844tOuE5AoQGY+DjaIFqCkPogFuzPNdfQWqulQ1ewcXnDBgt4NdOoaAxooGZH
	 otw3WqXN/dfJ1pNs0X0yevkODFTPh3pxA9BwxVVkBA1iktQgUJQewif5xVbMODOWQG
	 p/mWIch3ra5WH3jLHFaw3cWT0YrPLRjUedj8sYvbwLEFVFwspXynmHIaliKaD8MzHM
	 Xaf5Qs18Xas8eGIznU7yaUWvc+9ptKBerpjAHFGKEw0DHIqd0hSZcM1yyqzMhkH095
	 IUQbqVg1ph51dt/CUhqYAMrmXLp66EUw6RS72Jj/2UD9lzJLKJvRcTkZjvnML1Ja+L
	 dkfqQ0ihw0QKA==
Date: Fri, 11 Sep 2026 09:24:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, Support Opensource <support.opensource@diasemi.com>, 
	Sebastian Reichel <sre@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
Subject: Re: [PATCH 01/14] mfd: remove unused 88pm80x driver
Message-ID: <20260911-righteous-arboreal-angelfish-3bcbdf@quoll>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-2-arnd@kernel.org>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909132153.1596191-2-arnd@kernel.org>

On Wed, Sep 09, 2026 at 03:21:38PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This pair of drivers was originally added as companion chips for pxa/mmp
> SoCs, but the corresponding platform code was never merged, so it has
> been unused the entire time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../devicetree/bindings/regulator/88pm800.txt |  38 --

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof



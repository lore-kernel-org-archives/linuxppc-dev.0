Return-Path: <linuxppc-dev+bounces-17757-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D43EFCE47
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 21:58:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR64b2zt5z2xlv;
	Thu, 05 Mar 2026 08:58:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772661519;
	cv=none; b=YUQVw35mQW92O8V2N+XAtXyv1pd0xg3G9zF0OWqxa2WsNSWi0Znj7mJhJveC6NeLF/iGKvIOb/tVVACi6tpSa6ttCAkpUqaYdT/3uc5Pt8z1Y/RWnwXowIjQe4kEH85/TSwkSe/NwOp2DEA3syHbqC6RoJuOMwmHzL39r6KSaJuN6vwruPfXsVOPGT6RWcHpmngX3Fe0X00Wqcl39GSiOgeBkZF2L0xfal9+UU1SeX16makAG5mOZxl3f6hY1VdCdPMDWZG3RfBVO+lKOZAYrTwmhqeulBcBwNNPw1RyllBFoUCoYWnsQq4umHZ4p58wRc17WoBkq7XPhCGuqCs2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772661519; c=relaxed/relaxed;
	bh=SDR4PsYkFmZIckUOryLH4IjXcqpjDOwt0KGqniQjbHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXpmsSmJYPQp77RYh+2DRyoe/HxMRfWGZ0nSyvi+O2Jw+iDhOc/z6DXb6LbPWfbhcf9LIVSwlS+YtrQ2b3bOnE1Xgvz+lLlAyhnBCm5s0MyANM8hKyUrHxUHOEd1sPb1kTKPK3JJrpenWmQ/x/DSM8v/k/uobST0DNIxrqs2PW98zWe9dSAjUlUKKn7iOUPWYc6/lu8ew60dn4qV5ZKKxkIMF7KI4BzpsXxIFbDt2CaIzpfDDKpPDeE/WBiyLzMHGHjgm9v63ZybZbfCAACb6lVodlzXNBsyuoqen7bIwMevhYnueqdd0wVrP84O51xCYJ7zoXuM2eqOyaO1AhjIwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WPJJpvRG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WPJJpvRG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fR64Y26Ptz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 08:58:36 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-829781b2b01so594236b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 13:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772661513; x=1773266313; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDR4PsYkFmZIckUOryLH4IjXcqpjDOwt0KGqniQjbHs=;
        b=WPJJpvRGbBJjgCbh3vaDTyqwWA01Aq0sZxfv/0p7MUV6Y6k0Mxd/no6kPhWUzxw84O
         KlxN/rLWJiPVVRcDcik4PlYjaL6zI1sIp8myABmsI2iVj6ZwH7cPNZzxGUWfv5tmas3a
         ly4bu8blJrLAvpguSaOXOpow6G+niiQijlfSbss0Zl9+kEUuTKUeqnFOY89xytS0yzQ+
         4WXirNREQi9LiB5fNvTpRU79yNB/blYlWGW4MP+IwOxhXix8HWH+cMreGj6iZC3fW7yx
         S8qKdvp/lpY+aGCSHEafHhft5Yth+Xxz/fCUVkrg7SaZKr7hn8seO/x7+oQ7OR2aIvYP
         iyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772661513; x=1773266313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SDR4PsYkFmZIckUOryLH4IjXcqpjDOwt0KGqniQjbHs=;
        b=n4MQRXzfQOqxbTjgDWNkAV+6+z4SI7MqyOZ5o453xT8AaaTz2xRUj95ABH9tUB+CEN
         6cRdXuxtvbJi7mC/epM1j7rBHaZNo2mNiBNFPQdJN/rHFisexttfSp1yIKh/UhF02cXk
         RRaQfTcJoPYhwCsoZH+2rvJvX7O3KJ0a5RO1M9vR8mf0c1U9/MXMZ/QDM1SW6bYyYpV0
         BuFCle8gJkJQsI5Ako36edjSj2rPLxwqZXyKlfM66MdfRem9wleEh/t+05vQEqg8ejC2
         03ZQS/1DbcRyHCDfiFeLk4qS8IcDGiWXvHRnGijGEJrc5qwGbNTq93ftMzXmoOmMGKXS
         HZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCVoMVc8GARpRfQs3mIVAeuDPOhUylfjLH59iHYEYZXRImMLolqpzhGR2Aa4+3dRe2rAoz1iRKgDb9iw5KU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzFVumNUu1bG9GsvWzEbPj3caVrfssDPY2y9ij0X3ylBdX7ntVE
	ajMtamjPQ0wiSLw3C0M+j0XY7uvooNtfsLWJfffaKt0SbcxyvdVgZSFB
X-Gm-Gg: ATEYQzxOt8qS8vswPkC8+7i5eoMJjbqI5U7LsLequg8tcRAw2ywt3zp0XLwUlFP4FRB
	VvbtI0g1HjX18d+TNkRjPt3te5ByyqXtOxUy8O/ckJJEMOPCNfisVgWnxwz6X8pqVwg2dBYID0d
	awFzEt53yUKDvEiG9HoMn2XhzXVVgolzlf62Nzn2Vk81vQyHelpwiBPUjSIuJByuqHhWVjZG246
	XRdBoXm8/MwchgIwWCwwOVUMheTqwU+YzrPSEClF50Njuz59KF17by0KxDAcCosJCdedUagpild
	viOgV0dev8mckZiUN5TMi6k045odRvN0oUfsnX5NBx/8xMIcejyq5jWz7l+xmZN9L3jS5SOUhwx
	Lfrg9RX6JNfUGEye+4upWpZAOHfpCguQrvVbW2RMuWmO/WfLubfDB5uDcftR5PYX0d4TEjxw+/7
	u0cuZyf3fZ2xUtImE6Ikx2rrEt5fpaLi8E4eIA
X-Received: by 2002:a05:6a00:4288:b0:827:3321:7a23 with SMTP id d2e1a72fcca58-82972b63764mr2746760b3a.24.1772661513098;
        Wed, 04 Mar 2026 13:58:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82984a01827sm110603b3a.43.2026.03.04.13.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:58:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 4 Mar 2026 13:58:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 09/14] hwmon: drop unneeded dependency on OF_GPIO
Message-ID: <a1ce9ab4-49cc-46f7-8524-1cbc0e6333fa@roeck-us.net>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
 <20260304-gpio-of-kconfig-v1-9-d597916e79e7@oss.qualcomm.com>
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
In-Reply-To: <20260304-gpio-of-kconfig-v1-9-d597916e79e7@oss.qualcomm.com>

On Wed, Mar 04, 2026 at 10:02:30AM +0100, Bartosz Golaszewski wrote:
> OF_GPIO is selected automatically on all OF systems. Any symbols it
> controls also provide stubs so there's really no reason to select it
> explicitly.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Applied.

Thanks,
Guenter


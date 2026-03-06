Return-Path: <linuxppc-dev+bounces-17859-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D27FC9EC0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 23:33:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSN5K1fPBz3cB3;
	Sat, 07 Mar 2026 10:33:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772840021;
	cv=none; b=EtMUE0ZI5fWhW0YlVp9KxB3v8dNnCbAua/QYteQj0RfokZQLX+/QljElCH8SrbItGEOENzBW2VAWH7NBf9TFeds2icDqIrfvNeAgQopw2L8d56tR6nmznwx4w5wk3S7JQqE5xaLRGFV8J2MOMQDJbFpObAi/04++pf7yERQ3x/sYJwPBrokuRYcbDbUBQYxqd4hOtZCHIc88q6NxqiDRYEqQMriWkRFfxq0EGl94M2tcYTDPdVanF4peNL3APE3JSXM5jZQ2WQjD6RuO22GFhS95SsezsV4oD6nvvawZjkJASfc09dG23lkYb08SrtdyBZu8qYoWnwgwap2nSgYySw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772840021; c=relaxed/relaxed;
	bh=A3n1MjNRco+xhIuiD22YqqFeZmP/U2HpmvCL9DYQOmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IanchQ2nN38qSnJ4ZkNJi49BmrEKxppgm6CHyelaPAZQ6/QOE4PeUx2AtKw7zKuk9VnyLsf0kPjIS37/1qsbQNJAcZzahLWQOiyerfSFG8P494wT2J1aCsMdvoAB/oLbZ1eXxmOeZHpBFjIWsml1YNfq5K98F1AKo3NhWBFwp7qyzAsfb6pnUmXfjXU3EPO4go+QLgcbOPpmjwVEin6UDw3A48uapZdiSp7M+dkHfwB1SWOmojVSBimhgt1q7Jik2fZLtMVbIRXsUQXP2E3zr9wRoGeyz6AS6YstwcPg/xHQ4NnLHG0iq3hQA46H8tkyDiK2DDdRMr9Q1W69nycEjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=R3RMzDQR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=R3RMzDQR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fSN5J2LVJz3c9y
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2026 10:33:40 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-3597df496f6so3989438a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2026 15:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772840018; x=1773444818; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3n1MjNRco+xhIuiD22YqqFeZmP/U2HpmvCL9DYQOmg=;
        b=R3RMzDQR5rnCyr9QWZbQMlKCvz/68ZWdtQJhwFL43OiPX6eDNYBoLCmuhfgir7e4kj
         ZsEf4KTX7PdZEdbVEiSyGM4Bd/4WMfkXkT1spFuVcOwWzVPs2t7Meu5gNTUcpcNeeR//
         LAB/r9fU2EejHXNQ79jucCDXxvZnqkajju4IRVh+TdWZ1rSaKEBID4HZkGp+rj3JFzJC
         AEMiCZHwKxy01l6gnv5xaZnYf7EZd/QI7omA7G6lh4HaPy9q3iZeAMa2PGc68Ow9gT4G
         2wytwdJfoHaHhcHN/pnitP528w4qL+Gt4uEs0sIf8pu3T1EKPVGX0cBMx3sf9F7pUSWC
         LGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772840018; x=1773444818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A3n1MjNRco+xhIuiD22YqqFeZmP/U2HpmvCL9DYQOmg=;
        b=KytOXyJe6hSGxAmaSF0FVIXMtlNqE1p5SPz4ZpROHY2lSfIbS0EU+ADMYuVVHx/RrQ
         yMqlxciKjzIg3PGz1WmDKq6N0Bhv5HvJwesrlEGm0nDVvpFUWO602EMdwfec9Sl0+rGG
         IcIdEzDqgbVJ5haPQ5xy6zTXuKIKAtN4GvWoZ7T0xln++HFQFXpXsp5lfsK/s9dvCW5M
         rHDKo31pS6msavLURI3INFVlLlM5VK91JQpEEZAQEDv3NqSWXQ40usiNHD8x9D+sFLE9
         rQndNZwGDDwQKEUdKb0VtLjlThjXYTOkG/DQB+4g5VNZBRO9hpLFCcPQ2SrqOsa5I/GR
         FBAw==
X-Forwarded-Encrypted: i=1; AJvYcCUtiKatBCTNiyWvAApHuqtz9pzgARAbdcvjcqk2PMXxybyuEizE3hxbvonH1QbzCsFYZFfFCEnEMTRxDyE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwT/dgrzbDHG0GeFTIwQK+XxjuHov7lc9nULbhOPUEDjz7YPC/6
	JTw98xyscHMAXKZkib5QFrkc+LjTySpHzxnFSXQ4f0FRE51nvX1jy8kz
X-Gm-Gg: ATEYQzzdNM2ToZYL2PJRw7+kizrDZLpo0NMSwvYVM4FUGN8TRdDuU1Sp3rlODA8aRIs
	n7TBiHXt62dh4iBLzMVTP5qhgBGDpMJGWuGvXJvst/BE7hKLjAlEgMsTbtoit3G9IKdTO9+pBxH
	2mN0hpBjsVilLUfBkHOJ0sVltLBhIAxa0cfUffzsyOodQQ42sa7K9rEUJLGYDsqBmP+fB7p4YWU
	4s5dEtpOSWPjo5l1Y2O0RmI3AQ09e3VJhj9raGhhqF3Qb1hIv8Pb7iPapOBxzxJ1skT9zekBTJc
	KOocP92wlPN+UdggBUFjELvbi1evXYGIGWBzG4iX9FNCzXuAk8iPaJTI9AFF5SDFi8jmEYNB7ZU
	W1eT3lC29vo9r5q4xXbWIn9D/jAikr+WX3Vv4UzoKi/YaDJwWLly341qM89aQUG+J/UZpyLktzd
	mkKFe260OF3F3NyirMntvvo3wzlf+KgmSQYQ9b
X-Received: by 2002:a17:90b:38c4:b0:32e:528c:60ee with SMTP id 98e67ed59e1d1-359be31746amr3476775a91.24.1772840017833;
        Fri, 06 Mar 2026 15:33:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2de79f6sm6579296a91.9.2026.03.06.15.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:33:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 6 Mar 2026 15:33:36 -0800
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
Subject: Re: [PATCH 10/14] watchdog: convert the Kconfig dependency on
 OF_GPIO to OF
Message-ID: <07aa5d40-96b6-41a1-b8ce-22f2c2c94aed@roeck-us.net>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
 <20260304-gpio-of-kconfig-v1-10-d597916e79e7@oss.qualcomm.com>
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
In-Reply-To: <20260304-gpio-of-kconfig-v1-10-d597916e79e7@oss.qualcomm.com>

On Wed, Mar 04, 2026 at 10:02:31AM +0100, Bartosz Golaszewski wrote:
> OF_GPIO is selected automatically on all OF systems. Any symbols it

Actually, that isn't really true.

if GPIOLIB
...
config OF_GPIO
        def_bool y
        depends on OF
        depends on HAS_IOMEM

OF_GPIO also depends on GPIOLIB and HAS_IOMEM. I don't know why it needs
to depend on HAS_IOMEM, but the GPIOLIB dependency is real.

Guenter

> controls also provide stubs so there's really no reason to select it
> explicitly. We could simply remove the dependency but in order to avoid
> a new symbol popping up for everyone in make config - just convert it to
> requiring CONFIG_OF.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5d6e035ed3cbe5c2b631d11b76b20..ef200339a22a6f9c51a46c9c0b8466add74313e2 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -250,7 +250,7 @@ config DA9062_WATCHDOG
>  
>  config GPIO_WATCHDOG
>  	tristate "Watchdog device controlled through GPIO-line"
> -	depends on OF_GPIO
> +	depends on OF
>  	select WATCHDOG_CORE
>  	help
>  	  If you say yes here you get support for watchdog device


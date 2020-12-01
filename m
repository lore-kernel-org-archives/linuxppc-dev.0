Return-Path: <SRS0=H/Sv=FF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D25C64E7B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Dec 2020 10:10:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DCD6206F9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Dec 2020 10:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FjLGvvbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCD6206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CldC13gD0zDqbx
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Dec 2020 21:10:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::344;
 helo=mail-wm1-x344.google.com; envelope-from=daniel.thompson@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=FjLGvvbX; dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cld5H6pwjzDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2020 21:05:17 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id k10so1922769wmi.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Dec 2020 02:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=14bf6bn+oj8PMyR0sJXDa7vt6hfR/TzFTELJbHUC7s0=;
 b=FjLGvvbX1fS+Lzs7Jouwk4Xu5zby+fhb4SU9TD2AE3FCHm8BPNZ/4cQd8SjrL4teyO
 pIrlUihpdldsh6VzuqjFbQapRtHM/oN3isKB/EtTzfLNwGUKynKjH85fbuEntqzz9l/M
 zF/SRCOBE4zD/aC/w5Xthj9RhPGPgnmrL1Rz6FLJ5TDvxvdmNo6KDHxdQhrfzeBvtEDD
 7j2t4XSgW0acxS83X/ur3/Z7Yiq1aV+ISZfBRWfznhvkhv84rEvGPp6dBSgEpeJDwi6p
 32U1wPJILW50xkF1pYoC8QGnRQPruXD1wlIYhAik+Nvz7XfPhgPfeX4tn2phCkRisXbC
 h/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=14bf6bn+oj8PMyR0sJXDa7vt6hfR/TzFTELJbHUC7s0=;
 b=UL6mGEYpP+sGjObaNKSvzxekedCD8G/JJCsj5gy4BSKwE+4znqbeGHRr+McqS9CIw2
 c73KTbdXdgTqU8+8DC7kCKm+UMVg790H/ZhPeXGIvU/EI+1TD1fnipNimoM3HLSe/jfZ
 3UpVNDP7GefLbbT7SoG71MrEhwOMmbz3tMjP26BKZY1b6AL7FHm3Mi27gFUlXH1yWcgX
 Yy7aWfTW/k+omzaSxSnO3LQSqT02+zUI2PeMKtOs2jeYjGFcO1V/3nHmbm53h1bDqPzW
 FOkZbmNKJgy6CEKc9Dg40wSR4X79o4OKvQfX6BIqzQD1/nkNHVLJ6l9GvretzYFJTS86
 cnAA==
X-Gm-Message-State: AOAM530lcpijm9Btz5s5f6ZeBviBCM+ID36qPKg8nufa/znPByB/IIuF
 jEReJEqx9alTby2R+xUEioX6ug==
X-Google-Smtp-Source: ABdhPJxZXrE0bS930s4kHxmTujcKxrLUp8mkRl/hRPu1hEArkUtvSLrw9l0edI4pIsEcorzqGoW98g==
X-Received: by 2002:a05:600c:255:: with SMTP id
 21mr1914111wmj.69.1606817109823; 
 Tue, 01 Dec 2020 02:05:09 -0800 (PST)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net.
 [80.7.220.175])
 by smtp.gmail.com with ESMTPSA id p11sm2348078wrj.14.2020.12.01.02.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 02:05:07 -0800 (PST)
Date: Tue, 1 Dec 2020 10:05:05 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: Re: [PATCH 0/5] drop unused BACKLIGHT_GENERIC option
Message-ID: <20201201100505.xsocmjf6tmxu4uon@holly.lan>
References: <20201130152137.24909-1-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130152137.24909-1-andrey.zhizhikin@leica-geosystems.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alexandre.belloni@bootlin.com, tony@atomide.com,
 linux-kernel@vger.kernel.org, James.Bottomley@hansenpartnership.com,
 thierry.reding@gmail.com, paulus@samba.org, sam@ravnborg.org,
 linux-omap@vger.kernel.org, deller@gmx.de, linux@armlinux.org.uk,
 krzk@kernel.org, jonathanh@nvidia.com, ludovic.desroches@microchip.com,
 catalin.marinas@arm.com, linux-mips@vger.kernel.org, will@kernel.org,
 mripard@kernel.org, linux-tegra@vger.kernel.org, lee.jones@linaro.org,
 wens@csie.org, linux-arm-kernel@lists.infradead.org, jernej.skrabec@siol.net,
 tsbogend@alpha.franken.de, linux-parisc@vger.kernel.org,
 emil.l.velikov@gmail.com, nicolas.ferre@microchip.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 30, 2020 at 03:21:32PM +0000, Andrey Zhizhikin wrote:
> Since the removal of generic_bl driver from the source tree in commit
> 7ecdea4a0226 ("backlight: generic_bl: Remove this driver as it is
> unused") BACKLIGHT_GENERIC config option became obsolete as well and
> therefore subject to clean-up from all configuration files.
> 
> This series introduces patches to address this removal, separated by
> architectures in the kernel tree.
> 
> Andrey Zhizhikin (5):
>   ARM: configs: drop unused BACKLIGHT_GENERIC option
>   arm64: defconfig: drop unused BACKLIGHT_GENERIC option
>   MIPS: configs: drop unused BACKLIGHT_GENERIC option
>   parisc: configs: drop unused BACKLIGHT_GENERIC option
>   powerpc/configs: drop unused BACKLIGHT_GENERIC option

Whole series:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

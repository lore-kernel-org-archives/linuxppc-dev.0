Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C012C4360F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5685F20851
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXmgAKPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5685F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4435j72kH3zDqJh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 01:24:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::344; helo=mail-wm1-x344.google.com;
 envelope-from=daniel.lezcano@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="kXmgAKPS"; 
 dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4435cJ68SXzDqDC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 01:20:12 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id v26so17290887wmh.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 06:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ClZXXrP3BYB32DX7heYICw4CsezNlo5nX4c0OSIYVrs=;
 b=kXmgAKPSzKBlErTbTVMwRbNVX5C/bVcgD4Ddc/3EUJDlxf70Bljrs/ZTu/t49hqqje
 hyU5qP81E5t9C9u+juruGkNJI7IV6MVL5GigmXKuwqgC3qZfXjRqElUZ5yF4WlCYBjhT
 JaBcDpFthRsAKQVdU9jxYKesXz93pUFjJraXpFxnOizq3ettppOWVf0gXs0uCQkUJ5TM
 vBCrG6XNkXO08k47y67EXgSUG40Ph75TeVxq4eD06H4frl76UtHBb9tj2ytiGkvE4YQc
 ruMCtxcwjWVuPSH9mj1IY951KdG9XyTbtnHWk/LQZ6JJ2YO2zHYZcMvHZwVk3HaX/sOI
 o82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ClZXXrP3BYB32DX7heYICw4CsezNlo5nX4c0OSIYVrs=;
 b=nPqopAcJMQNHPh2YzMYXnvMCjNbfrAFcTt9Zf1j9xNtK6k9MW+dHH2eAif2z7OmIwj
 eERBdnXw9JnZ7QWD0FIfnRTY/T7EJpo8TRkGT6QyErRJq1mHJ9SJSW2RAdH7DyYMJVH0
 9caG1rOceyO2KxDjq2mSxsIeTEEGevGKqemR1vm+fxpcNEK7oKwFpRfiQaZ1hDjDa7jT
 DyPnv5L9UWso/AlCFQuguPdpsbvjMuXgSdvo+G6NhIvdVF6LFTD+QFj/AlP8zqGfw2zo
 xbPrxdB27H+j6lK5WtUj40gvtlI5bBANNuy83HaIyZzqAMdwJ4N2lw3rDJC+NZlhqvBm
 Uybw==
X-Gm-Message-State: AHQUAuYHR1ee/RqqR9HmSBq7F19lRWRav9ZZ4ly6O5X2FnD69vjJggct
 86TlPYWQFdb/NIhcn42KJ4t+ZhRbOyQ=
X-Google-Smtp-Source: AHgI3Ib455TygYVlPC1SJ0oM7R+duaUfW4js4OfK+qogmUfNV65oGh4+/Typu4wLNSWvEwxM/qa/Kg==
X-Received: by 2002:a1c:41c5:: with SMTP id
 o188mr16028078wma.147.1550499609210; 
 Mon, 18 Feb 2019 06:20:09 -0800 (PST)
Received: from [192.168.0.41] (148.125.92.92.rev.sfr.net. [92.92.125.148])
 by smtp.googlemail.com with ESMTPSA id e6sm15839091wrt.14.2019.02.18.06.20.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:20:08 -0800 (PST)
Subject: Re: [PATCH 3/8] drivers/clocksource: timer-fsl-ftm: use common header
 for FlexTimer #defines
To: Patrick Havelange <patrick.havelange@essensium.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-3-patrick.havelange@essensium.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5ed4658a-7ef6-91c7-7afa-2f73f038ff95@linaro.org>
Date: Mon, 18 Feb 2019 15:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218140321.19166-3-patrick.havelange@essensium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 18/02/2019 15:03, Patrick Havelange wrote:

Changelog please

> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> ---
>  drivers/clocksource/timer-fsl-ftm.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
> index 846d18daf893..e1c34b2f53a5 100644
> --- a/drivers/clocksource/timer-fsl-ftm.c
> +++ b/drivers/clocksource/timer-fsl-ftm.c
> @@ -19,20 +19,9 @@
>  #include <linux/of_irq.h>
>  #include <linux/sched_clock.h>
>  #include <linux/slab.h>
> +#include <linux/fsl/ftm.h>
>  
> -#define FTM_SC		0x00
> -#define FTM_SC_CLK_SHIFT	3
> -#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
> -#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
> -#define FTM_SC_PS_MASK	0x7
> -#define FTM_SC_TOIE	BIT(6)
> -#define FTM_SC_TOF	BIT(7)
> -
> -#define FTM_CNT		0x04
> -#define FTM_MOD		0x08
> -#define FTM_CNTIN	0x4C
> -
> -#define FTM_PS_MAX	7
> +#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_MASK_SHIFT)
>  
>  struct ftm_clock_device {
>  	void __iomem *clksrc_base;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


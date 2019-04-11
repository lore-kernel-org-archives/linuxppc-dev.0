Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E59AC10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 16:42:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2F22083E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 16:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcvXOgMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2F22083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g6J51TskzDqSH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 02:42:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=daniel.lezcano@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="xcvXOgMW"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44g6GQ2rdqzDqJh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 02:40:43 +1000 (AEST)
Received: by mail-wr1-x441.google.com with SMTP id k17so3562072wrx.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=OEsAGu5FY2oqAqolGl6W2+S5SjflU5nYh0bRo2ivrKo=;
 b=xcvXOgMWMmGIZQyJfVYL9B4/04simq4Tb1B0B4HZf/38fKoJwnbfwJEUDd+5aqyZGF
 vn91/46j//qhcGZ2IKGkqLz0HfA8pxCQXL7EFeTVIia9ftVGSNhbUnGW/lvhuPi/mKhH
 s8NyT0er5Qqc0uv6lSfavsHwZTrAO452YO+S9a2d4sWitqWXqKtxbnkALPyX3vERuf33
 tAV6l7reP6hpnXydad3erl4EA5r8ioRKdZvqrdHW/Hceyica7+Nccpr5Bg8MSOSlKR/u
 YT/8IyV/Rk5roYSQsuTxN6SxNsflUD+L3eSClvbVnONHI1s8LpmeDRTA904mFlb/YxNr
 +e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OEsAGu5FY2oqAqolGl6W2+S5SjflU5nYh0bRo2ivrKo=;
 b=l5/zCDzLvtQUTTUHQ8FB1RRF1/53sNF5TaE8+Z68/JM50C9owvNK+Wg9x1AFJanNwn
 iFoSHWP2RS3U76v8vAbuHaAkOHF0QnXzc/QZ9p3u9uejsGUuJI6eqBWiVMbD4oKK0v6P
 3cOtmW0NgRqqnqxLWJ5PCZRGjPlyei5YcXt7wqLt1IXY9SRKhqClSg+pO9x4TosMtyLw
 Dx/0J83/Kkq20Mz31KNsBLApu2L/v/dUKjnCgnwOGDP6NbdTM8mpwE8pV+SBMw4UOXFD
 WEwxAnlaiIKCOLS6qyOu7SQCrG4D5RYOyLqx/TarLmQNlovfquUdXY7kLa5TW8WJ+v+O
 P5IA==
X-Gm-Message-State: APjAAAWz0C3nGA7641c/mQhCoJN8LJ3F5lk8fsS5FLa3JMf4Xr8ybDAZ
 3gK23clzlj7SRi91FnxCIC6uZw==
X-Google-Smtp-Source: APXvYqy8kvXe8sp3uA6Vjd553WaEmvQqpcGB+IAUBjUEJ9mcsPgTvGgr+zWr257iifWdaeU9GNuWCQ==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr7867744wro.20.1555000839751; 
 Thu, 11 Apr 2019 09:40:39 -0700 (PDT)
Received: from [192.168.8.100] (195.118.130.77.rev.sfr.net. [77.130.118.195])
 by smtp.googlemail.com with ESMTPSA id
 g84sm9684634wmf.25.2019.04.11.09.40.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Apr 2019 09:40:38 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] drivers/clocksource: timer-fsl-ftm: use common
 header for FlexTimer #defines
To: Patrick Havelange <patrick.havelange@essensium.com>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Jonathan Cameron <jic23@kernel.org>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
 <20190306111208.7454-4-patrick.havelange@essensium.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ba80affb-0d9d-8248-f995-788105394bb3@linaro.org>
Date: Thu, 11 Apr 2019 18:40:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190306111208.7454-4-patrick.havelange@essensium.com>
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

On 06/03/2019 12:12, Patrick Havelange wrote:
> Common #defines have been moved to "linux/fsl/ftm.h". Thus making use of
> this file.
> Also FTM_SC_CLK_SHIFT has been renamed to FTM_SC_CLK_MASK_SHIFT.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> Changes v2
>      - None
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


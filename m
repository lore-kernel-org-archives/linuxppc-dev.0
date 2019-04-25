Return-Path: <SRS0=v/d1=S3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4802DC43219
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 21:43:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056C6206C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 21:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PteYC7nI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056C6206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qrK60wVWzDqbC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 07:43:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=daniel.lezcano@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="PteYC7nI"; 
 dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qrH8698bzDqdw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 07:41:40 +1000 (AEST)
Received: by mail-wr1-x444.google.com with SMTP id b1so1438187wru.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2BbnDHSdmo9EsPssh4+cDnse2PF+EKLkrPxXRQPRv3U=;
 b=PteYC7nIBAGD7LJdOjlhH4ErRzLpUucdh0PzJOri70keJcE7oe0VK7tGnyw1aiQsk4
 0/feRsGlYVbxk7CwpvZE3ekPa8qnds9kBeQUapImzenbNioGaURUe5lF8ejlirbODlsy
 lMLFZjIx8DtmPEtiQ7BA6Iy+PHNd7TetVLFcWvXsnfNdW0+6BEsCZ+juYgEhEbXByH3/
 7hY0BoYvYXbboHWFluYE583WL8Tgzr5F4CRo4dYbYOr+w5RZ3Jqsm7UX9JTCP87U56+d
 mwV7dHGb0eeGUQ11DYvQLw39RWRXQ7beN0IbZtSRTPIwmr/Oy39EH53q8liJOWada7sE
 S7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2BbnDHSdmo9EsPssh4+cDnse2PF+EKLkrPxXRQPRv3U=;
 b=Y/e8qvtMr00G9dS2d44/bpoCA9aDFl0zKjzE0ISP3+9yXwelyVup+x5rdodYpzOHuK
 /4CqtVteSFvYbZ3T/twwzujvodYVo+apDIqOxmENns7a533tKv0hZ6YLzgPVdqbWdl0t
 OSW1Naa5yQculnasdYhvKAFIVovofKZihidyD4Xph9qx4vyAB62TV6mjtHpnsIyv/w2Y
 hcEUKtQ1nHYxNIQxL1ToUXikjBoxEGCtOBxiYP0jzjK0S89QqGWkv5Ul2KQGEtwfb6SB
 5AhOpBWJIea/1DCqoOoqaZbMxJylmTinPE8cM1hrcA+hgZNJ/3FLA/Y41vQmTm0wN3ji
 DnFw==
X-Gm-Message-State: APjAAAXx3FwUt8ME7wqYda2172F0rxC7IXnoWjv+X0m4XUnABICN13t+
 AM2Ch/9CT7TJQEEUkI08aiKVOg==
X-Google-Smtp-Source: APXvYqz/NnZShgYYb2LoFn+nXFrxK9q4LhZMsDhREk9lrIWFfGYHfWkP8HiIoZIZPHJ9BIYQL7qRyg==
X-Received: by 2002:adf:eb4c:: with SMTP id u12mr22325094wrn.235.1556228496305; 
 Thu, 25 Apr 2019 14:41:36 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net.
 [78.210.255.2])
 by smtp.googlemail.com with ESMTPSA id d11sm10703499wrc.32.2019.04.25.14.41.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Apr 2019 14:41:35 -0700 (PDT)
Subject: Re: [PATCH v10 14/18] drivers/clocksource: timer-fsl-ftm: use common
 header for FlexTimer #defines
To: William Breathitt Gray <vilhelm.gray@gmail.com>, gregkh@linuxfoundation.org
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <c82ce954006d9a228c7a6ebb0eabade48bd2c149.1554184734.git.vilhelm.gray@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <95ce444a-2f10-ec89-cb13-578349511f6b@linaro.org>
Date: Thu, 25 Apr 2019 23:41:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c82ce954006d9a228c7a6ebb0eabade48bd2c149.1554184734.git.vilhelm.gray@gmail.com>
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
Cc: mark.rutland@arm.com, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
 thierry.reding@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 david@lechnology.com, robh+dt@kernel.org, tglx@linutronix.de,
 fabrice.gasnier@st.com, esben@haabendal.dk, shawnguo@kernel.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, knaack.h@gmx.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 02/04/2019 08:30, William Breathitt Gray wrote:
> From: Patrick Havelange <patrick.havelange@essensium.com>
> 
> Common #defines have been moved to "linux/fsl/ftm.h". Thus making use of
> this file.
> Also FTM_SC_CLK_SHIFT has been renamed to FTM_SC_CLK_MASK_SHIFT.
> 
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Please, do pick my Acked-by from V2.

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


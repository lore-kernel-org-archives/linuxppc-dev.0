Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ED0C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 20:53:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEA120671
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 20:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggnoXW65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEA120671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430ZXb3RyGzF3cr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 07:53:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ggnoXW65";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com;
 envelope-from=jacek.anaszewski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ggnoXW65"; 
 dkim-atps=neutral
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430ZMS3WmvzF3V7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 07:45:04 +1100 (AEDT)
Received: by mail-lf1-x144.google.com with SMTP id a16so4987279lfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 12:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XoLzKOMYMpvhfX9iLjV1f8bylSNS2Gb+5zk9Yy13474=;
 b=ggnoXW65X2rPBJWLPbsDWh1UvQy4k1PO3FNRaMQTXsX9CrZ0jfDa5kpLxsFMFxwNiy
 hT4T4kNbYRQgrKtKtdmme+FNoCiKDE5nhxFhczlQhsN+kBIYcm+isjB9X12GR2Z+vGzm
 X37498OgtRrrr4zlj9FH4XoZAkZuAvxCEGQ5rCZH0b6ffxVbB9ZxYsygkFDX7kzXmlxe
 F4VEuPjpGMJFHhmxyTRe2eoOiLWUJTjKt5rQfgm0numBA5IRhpvLqUBiVgdxU79LdKCa
 gUyiaG9WA6Halwzb+ShDYz7lxQg+s6ObUMfiDHsX6cxA6lIgjQAZ8U4xCojV5mGsROp0
 gK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XoLzKOMYMpvhfX9iLjV1f8bylSNS2Gb+5zk9Yy13474=;
 b=C3VHmP9BDwcKh+OXmZiMsdT16QFDcnwvkPnv0ySJI5KygGv9fZhfvG0zjzowJ0kJGE
 xFiY3Tkq371GQgddrKW1Fc5v9wdmX/VerXVgHp8jYKb4+HMqts0Pp2EUDLnz9k/LxVNm
 VTJWRLzOgNGKjcxvZH2+nN+SqG4s+lgq6f0v32BLX9XUD+gildIIR5YI1pu3a6bGjQ9a
 8YrJ/BlPMZJxdWD/8tN9BIJdh8RsktVaEPV1STeyGe0X9zCV9RayQcCEKQ0jAw4raYi/
 +sRZY4uR8yL7cCK3h+CXsrQN4Hok7HNpf8M8IHgJFQSTiJQ0FkC/S5Tt2xU5Bt5SZ8p4
 CeTA==
X-Gm-Message-State: AGRZ1gKN/liBBbwGJPPQ+UXNSn+BlhMLpcAvbLyqgvOWCrDzWXV2qNjB
 mdaRlTmNNUxtj/U6yU/Kpnk=
X-Google-Smtp-Source: AJdET5cJBViKFFPRiWKS1sW6vsDOVIRh5QKqYDtUNuaLoQUS/kFqqE1EkUT7RnThBfvTiXBk/uohaA==
X-Received: by 2002:a19:d78c:: with SMTP id q12mr4602050lfi.27.1542833101582; 
 Wed, 21 Nov 2018 12:45:01 -0800 (PST)
Received: from [192.168.1.18] (dma88.neoplus.adsl.tpnet.pl. [83.24.56.88])
 by smtp.gmail.com with ESMTPSA id r29-v6sm6303381ljd.44.2018.11.21.12.44.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Nov 2018 12:45:00 -0800 (PST)
Subject: Re: [PATCH] leds: powernv: add of_node_put()
To: Yangtao Li <tiny.windzz@gmail.com>, pavel@ucw.cz,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20181121123138.21870-1-tiny.windzz@gmail.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <82ef58c4-1d18-9dd6-71ec-42f799370f33@gmail.com>
Date: Wed, 21 Nov 2018 21:44:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181121123138.21870-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Yangtao,

Thank you for the patch.

On 11/21/2018 01:31 PM, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node returned by
> it and that reference needs to be dropped by its caller.bl_idle_init()
> doesn't do that, so fix it.

s/bl_idle_init/powernv_led_probe/

I suppose that you adopted the commit message from a fix
for drivers/cpuidle/cpuidle-big_little.c.

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/leds/leds-powernv.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/leds/leds-powernv.c b/drivers/leds/leds-powernv.c
> index b1adbd70ce2e..0b1540029034 100644
> --- a/drivers/leds/leds-powernv.c
> +++ b/drivers/leds/leds-powernv.c
> @@ -285,6 +285,7 @@ static int powernv_led_probe(struct platform_device *pdev)
>  	struct device_node *led_node;
>  	struct powernv_led_common *powernv_led_common;
>  	struct device *dev = &pdev->dev;
> +	int rc;
>  
>  	led_node = of_find_node_by_path("/ibm,opal/leds");
>  	if (!led_node) {
> @@ -295,15 +296,20 @@ static int powernv_led_probe(struct platform_device *pdev)
>  
>  	powernv_led_common = devm_kzalloc(dev, sizeof(*powernv_led_common),
>  					  GFP_KERNEL);
> -	if (!powernv_led_common)
> -		return -ENOMEM;
> +	if (!powernv_led_common){

missing space:

s/){/) {/

> +		rc = -ENOMEM;
> +		goto out;
> +	}
>  
>  	mutex_init(&powernv_led_common->lock);
>  	powernv_led_common->max_led_type = cpu_to_be64(OPAL_SLOT_LED_TYPE_MAX);
>  
>  	platform_set_drvdata(pdev, powernv_led_common);
>  
> -	return powernv_led_classdev(pdev, led_node, powernv_led_common);
> +	rc = powernv_led_classdev(pdev, led_node, powernv_led_common);
> +out:
> +	of_node_put(led_node);
> +	return rc;
>  }
>  
>  /* Platform driver remove */
> 

I've fixed those trivial problems and applied the patch
to the for-next branch of linux-leds.git.

-- 
Best regards,
Jacek Anaszewski

Return-Path: <SRS0=rG8u=ES=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E295DC2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 10:34:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21C622203
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 10:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pb8VQuJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21C622203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CWyf34Q4yzDqKv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2020 21:34:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::344;
 helo=mail-wm1-x344.google.com; envelope-from=lee.jones@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Pb8VQuJI; dkim-atps=neutral
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CWycB4XJVzDqsZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2020 21:33:09 +1100 (AEDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so5002058wmh.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2020 02:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=UPml7Ag+cyD5ZpOUsCEhsFzeed/Gt64P4gFrMh0ZZKY=;
 b=Pb8VQuJIwCFqzeQjIGAHYXTufJDGSFTfprHfLDPNEjyM5STzLg/vQp5fI6xymu/6Qd
 CD1scPRwOyQTWw7OLIqv4RK7UT/B0h61kLvuBgSkGZLvovycoVbf6zrWr9GIjM4daD3c
 5beykU4oWsv8wEbZKwJkXLAtQCi9WF8MsgsyZdj3JAXi4+qFH6R8Jjxvoh7ym0wlgCCq
 cm9+SkfSRx9LNFYdrrQbCq2GMUZSjBbBk4Xo8KMmh4wrW04RYYzUgC81efqemBQ4yEW4
 tNseL4k1arQCKFoKhYWc6QkEvoUne+CsrHVoYZbYjyz0qpS3YE8ZJlHqXyw2c8Wl5wwy
 ck7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=UPml7Ag+cyD5ZpOUsCEhsFzeed/Gt64P4gFrMh0ZZKY=;
 b=p+zE0ncSNQ2YTgvJMELcOahWF1iTT18eaxlX4KIYusMMr5XHmDeTz37hrWFOUmDjy6
 2Jrj28Vey7F/GSP0jf6cQW30/3FkXyPnIHeohcmxVnk4EkxnAsT48cdCAZZLdy/XOuib
 FbDg1oI1la2Sr67TPHrX/ZNnyUuLjT+k04NVUxvULbZYpWPTObkvgDrem9xnMDt6XHEN
 mOP+zxlw7oaH1Cux6oSut3WImLMrYgyqrvnajqUyXHbs9wJWJpaE9sWFvwV6RYlSm/xz
 XW/RdZkzoqWAfsD4h4U300X6NxrDfdmw79OLaGj6HRkbzlWxfJqGuqTV37DXtb8sMDCl
 6KoQ==
X-Gm-Message-State: AOAM532FmRPtGoIpa0Cc92xxyy13MhYISv0YJ4W29Jwszb37ibyTjw9l
 G21rnYum2yO09x4QhjGkmwIotAc/BPZ9p/LK
X-Google-Smtp-Source: ABdhPJybfLNMok1CvTRVf4Y6Qu7ivi2P2KG2tDvWy1ClR91LsorSSABSS7zH0zcIgTKID0RKbgc/AA==
X-Received: by 2002:a1c:2583:: with SMTP id l125mr8851372wml.50.1605177183172; 
 Thu, 12 Nov 2020 02:33:03 -0800 (PST)
Received: from dell ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id i5sm6545274wrw.45.2020.11.12.02.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 02:33:02 -0800 (PST)
Date: Thu, 12 Nov 2020 10:33:00 +0000
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Scott Wood <scottwood@freescale.com>, act <dmalek@jlc.net>,
 Dan Malek <dan@embeddedalley.com>, "Software, Inc" <source@mvista.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/25] soc: fsl: qe: qe_common: Fix misnamed function
 attribute 'addr'
Message-ID: <20201112103300.GE1997862@dell>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-12-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103152838.1290217-12-lee.jones@linaro.org>
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

On Tue, 03 Nov 2020, Lee Jones wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/soc/fsl/qe/qe_common.c:237: warning: Function parameter or member 'addr' not described in 'cpm_muram_dma'
>  drivers/soc/fsl/qe/qe_common.c:237: warning: Excess function parameter 'offset' description in 'cpm_muram_dma'
> 
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: act <dmalek@jlc.net>
> Cc: Dan Malek <dan@embeddedalley.com>
> Cc: "Software, Inc" <source@mvista.com>
> Cc: Vitaly Bordug <vbordug@ru.mvista.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/soc/fsl/qe/qe_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
> index 75075591f6308..497a7e0fd0272 100644
> --- a/drivers/soc/fsl/qe/qe_common.c
> +++ b/drivers/soc/fsl/qe/qe_common.c
> @@ -231,7 +231,7 @@ EXPORT_SYMBOL(cpm_muram_offset);
>  
>  /**
>   * cpm_muram_dma - turn a muram virtual address into a DMA address
> - * @offset: virtual address from cpm_muram_addr() to convert
> + * @addr: virtual address from cpm_muram_addr() to convert
>   */
>  dma_addr_t cpm_muram_dma(void __iomem *addr)
>  {

Any idea who will pick this up?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

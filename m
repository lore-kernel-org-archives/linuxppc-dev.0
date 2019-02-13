Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992E1C282CA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 08:06:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184EE222C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 08:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hKu2VKHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184EE222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zsYd1QmNzDqTM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 19:06:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=lee.jones@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="hKu2VKHT"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zrkm6w7GzDqS0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:29:36 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id q1so1256099wrp.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 23:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=p1ubNWXGHPnF8cNyX5xYmowXhYPVRyQWPlZNKdwfTas=;
 b=hKu2VKHT8ANYSMZfbVUfV7u6JKn6aZ8519m5/Q+ilXS/t8uBxsgQi92Uvx0cchs0k6
 0GS0R8muSud7PJBYF6mhzHEBfe9kHAnBnFfxPan9BeHGfzI//T9ez9hqA3oo816RRmZW
 wpYHbtKPgeW+Ifb3dvO/LCCJgnFyIF4Rj5sXrvmMVbgCDp3Cd5JuqWaO5h2+dhhJag22
 rf+lcITHUlTRnVPG0zKzo+0KtAz8LJKbeIrmRs8fVe5sfktMNzOu0VCf0FAn+CSFdDBx
 KCnYic2FHcgfPwIGxWieKHFvujUmy2bI44eRBnrSvNtkc+swOHwWm7gkl9cWoGDlDU6G
 LxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=p1ubNWXGHPnF8cNyX5xYmowXhYPVRyQWPlZNKdwfTas=;
 b=Ex1z2BZIU9qa9mFM+yk98414qTblCkye+87nxx0f4tt6bGmhfmgPudjn60+gzAfjlL
 WAqaQOUvn21WCbtthkXwfw3FqX9kYRcUXdFvuBJpQpn+gg6OLSI3gpi9+XLJvRbQjkXT
 t0cdlgz+Rc7N3dWTYQ2MtHHQVUDMgzfCO/Hf8L/YwnlRbjB6vcyLBPNxn1dVjhtlgLMX
 O+lRVszqAqfcNhkfhmYeU+Tk0M8qKHKUPqssgbirHTdOFT4A6L4e/Dd0NbpSIjf2gQr1
 +b+zBlkwEaIuD55FgLem+GELbt0X5dHQBkfQlR8bVbmS37OvjtnnMS8LwZsDLio97E1U
 2iXA==
X-Gm-Message-State: AHQUAuZqfSkRzgQK8mxp0RlXAUgRsU7VT6OFCyfgiDm+TtbJTT/dbyvy
 pf8+A4hNbsu4dFA7ujHKI5Nwjw==
X-Google-Smtp-Source: AHgI3IZcd4zu/3yvHzkl49HGJ4yreQu5p0YiXKGToLp9LNR1JCXvFQTZLzDX27/8lOJeVrKoRHhVcQ==
X-Received: by 2002:a05:6000:6:: with SMTP id h6mr5767032wrx.68.1550042973913; 
 Tue, 12 Feb 2019 23:29:33 -0800 (PST)
Received: from dell ([2.27.35.171])
 by smtp.gmail.com with ESMTPSA id q24sm4487482wmq.16.2019.02.12.23.29.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Feb 2019 23:29:33 -0800 (PST)
Date: Wed, 13 Feb 2019 07:29:31 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/12] mfd/sm501: depend on HAS_DMA
Message-ID: <20190213072931.GD1863@dell>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211133554.30055-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org,
 devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 11 Feb 2019, Christoph Hellwig wrote:

> Currently the sm501 mfd driver can be compiled without any dependencies,
> but through the use of dma_declare_coherent it really depends on
> having DMA and iomem support.  Normally we don't explicitly require DMA
> support as we have stubs for it if on UML, but in this case the driver
> selects support for dma_declare_coherent and thus also requires
> memmap support.  Guard this by an explicit dependency.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/mfd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f461460a2aeb..f15f6489803d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1066,6 +1066,7 @@ config MFD_SI476X_CORE
>  
>  config MFD_SM501
>  	tristate "Silicon Motion SM501"
> +	depends on HAS_DMA
>  	 ---help---
>  	  This is the core driver for the Silicon Motion SM501 multimedia
>  	  companion chip. This device is a multifunction device which may

I would normally have taken this, but I fear it will conflict with
[PATCH 06/12].  For that reason, just take my:

  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

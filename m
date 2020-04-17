Return-Path: <SRS0=SBso=6B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1891AC2D0EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 17:41:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE5D22209
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 17:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WZaabqWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE5D22209
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 493k150nBZzDrnR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Apr 2020 03:41:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 493jyv5wyYzDrTn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2020 03:39:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=LBjygYyC944CKlPD3XS2R4n/n0JfZwjSTHNfNJ0y7Zg=; b=WZaabqWmMoH65WOVHe9ERur26P
 R1zgqFtkWETNmQ3aNjbpQfcQ/JGtumJqJklq+OZU5vJzEP5wQQNy97YnDh1BrIbJDxDhQyrVfrvYA
 M43cVmGeTPWLLQ/ltsKs5UCTyoFBCLAizrOtvkyue1SS/J8tUxWZjFOuuuZe7aG3bufdDhSIkZOko
 CUdTgm1zBbjMp8h5mhSmXHGmqBQ9KJwtE8xmHNfwSdUdA6l4vo1LdOTt7ucqRtrTmDj7YpsyTGLG2
 uYhQLJtIZ+/nNevMMgYHdsr+j4FUD9CeFABIAwOdPN2f8SdoATvwE9vReArCgU2HttHEvDMju2zYx
 FaOs5k0g==;
Received: from [2601:1c0:6280:3f0::19c2]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jPUxl-0002jG-Sf; Fri, 17 Apr 2020 17:39:37 +0000
Subject: Re: [PATCH] drivers: uio: new driver uio_fsl_85xx_cache_sram
To: Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20200417172130.14287-1-wenhu.wang@vivo.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9263f8fb-74e0-4c74-6c72-bdf0dfafbf1b@infradead.org>
Date: Fri, 17 Apr 2020 10:39:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200417172130.14287-1-wenhu.wang@vivo.com>
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
Cc: oss@buserror.net, robh@kernel.org, kernel@vivo.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/17/20 10:21 AM, Wang Wenhu wrote:
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 202ee81cfc2b..f6e6ec0089c0 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -105,6 +105,14 @@ config UIO_NETX
>  	  To compile this driver as a module, choose M here; the module
>  	  will be called uio_netx.
>  
> +config UIO_FSL_85XX_CACHE_SRAM
> +	tristate "Freescale MPC85xx Cache-Sram driver"
> +	depends on FSL_SOC_BOOKE && PPC32 && !FSL_85XX_CACHE_SRAM
> +	help
> +	  Generic driver for accessing the Cache-Sram form user level. This

	                                              from

and SRAM would be better than Sram IMO. (2 places)

> +	  is extremely helpful for some user-space applications that require
> +	  high performance memory accesses.
> +
>  config UIO_FSL_ELBC_GPCM
>  	tristate "eLBC/GPCM driver"
>  	depends on FSL_LBC

thanks.
-- 
~Randy


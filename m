Return-Path: <SRS0=fJFq=CH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB32C433E6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2020 15:07:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7FF207DA
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2020 15:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGG5ffRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7FF207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bf0Fj2G4NzDqmb
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2020 01:07:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::242;
 helo=mail-oi1-x242.google.com; envelope-from=groeck7@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=AGG5ffRz; dkim-atps=neutral
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bf0CX0vlLzDqjJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2020 01:05:58 +1000 (AEST)
Received: by mail-oi1-x242.google.com with SMTP id z195so3311256oia.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2020 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=GESIzfSQF/IiQj5pKJ59W/BWN56R6UAMnjLXD2xuVB4=;
 b=AGG5ffRzCA2kYkm1R9vg42GzRIb9HYRNvR2yghbUZztNX2faULR35xzkF0/Q8+11Nf
 uemArEKDOPA2/yw88M64xCY9uW7v53zNpohwjyYDDGp9H9AwENe+Ef+kcQtXJFJdkgKU
 0dIl+0kWssKjSXwaerpAJw2DXWp2mN1bQ7TRyZ+5SDCB6akg9L+2xVfRbLm1jCiyO31C
 Sbr67qr5uixtYdr73qAGku2p3YElxuXfB06JCf34RQ2tHVYO77yuJnuwbD4+eAQRENjQ
 pz3hrl1eBpGewmwu6Qn65SSFHZZmTVTFhYMWt2+QhhssCG+NqzldjhNGoR+UBJkYDOZa
 r0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mime-version:content-disposition:user-agent;
 bh=GESIzfSQF/IiQj5pKJ59W/BWN56R6UAMnjLXD2xuVB4=;
 b=ptfuOTARfoTSu9ThbB+qB1GAjhjU+yW2bS3me5nuHpPkc9cSN+G4hI0XZsglw5rf/S
 /sghvJSSygrPGXC1u1SQofwhrMENSdHGfNwi4F+P0/wosmSaULwbMwOsjpC4aZ9nIlyS
 /qY7VEjNHb3U45kNlIc37iQdz0wdaTcUROrEKHmWD4Y5zCAwmkLtHuiMW00GRiW0F/p+
 9lZnOFUTfa7pDAbU4Q0y/2FoI+/PXWu7uMF4+kOijjR6H7XwuOpehOuVzTbQIQTOTZcn
 FvxKsoySzIZoSPi+Lr24IX5gAQOW39fW/md1vmK+gsqOw9i8IFx1Rose1o6+O8MKeDnq
 RKhg==
X-Gm-Message-State: AOAM532p1ieUmEVsdMa1A025sZpT+jEL0G8K16rq0X28aedJXC/LhjFf
 qM5so3DNNd87DJ+vVZl8sTs=
X-Google-Smtp-Source: ABdhPJxb0/cqPfgx+AtFIEYXoQn7rFw9hVwhWLa/xdUqzVCRQ4RpoCuGNKpUO9nZ933mnzHCpgHPMA==
X-Received: by 2002:aca:4306:: with SMTP id q6mr2168933oia.128.1598713553709; 
 Sat, 29 Aug 2020 08:05:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id o11sm536368oia.6.2020.08.29.08.05.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 29 Aug 2020 08:05:53 -0700 (PDT)
Date: Sat, 29 Aug 2020 08:05:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] fsldma: fsl_ioread64*() do not need lower_32_bits()
Message-ID: <20200829150551.GA27225@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Joerg Roedel <joerg.roedel@amd.com>, linuxppc-dev@lists.ozlabs.org,
 Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
 Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Aug 29, 2020 at 02:45:38PM +0200, Luc Van Oostenryck wrote:
> For ppc32, the functions fsl_ioread64() & fsl_ioread64be()
> use lower_32_bits() as a fancy way to cast the pointer to u32
> in order to do non-atomic 64-bit IO.
> 
> But the pointer is already 32-bit, so simply cast the pointer to u32.
> 
> This fixes a compile error introduced by
>    ef91bb196b0d ("kernel.h: Silence sparse warning in lower_32_bits")
> 
> Fixes: ef91bb196b0db1013ef8705367bc2d7944ef696b

checkpatch complains about this and prefers 

Fixes: ef91bb196b0d ("kernel.h: Silence sparse warning in lower_32_bits")

Otherwise

Tested-by: Guenter Roeck <linux@roeck-us.net>

> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Zhang Wei <zw@zh-kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/dma/fsldma.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
> index 56f18ae99233..6f6fa7641fa2 100644
> --- a/drivers/dma/fsldma.h
> +++ b/drivers/dma/fsldma.h
> @@ -205,7 +205,7 @@ struct fsldma_chan {
>  #else
>  static u64 fsl_ioread64(const u64 __iomem *addr)
>  {
> -	u32 fsl_addr = lower_32_bits(addr);
> +	u32 fsl_addr = (u32) addr;
>  	u64 fsl_addr_hi = (u64)in_le32((u32 *)(fsl_addr + 1)) << 32;
>  
>  	return fsl_addr_hi | in_le32((u32 *)fsl_addr);
> @@ -219,7 +219,7 @@ static void fsl_iowrite64(u64 val, u64 __iomem *addr)
>  
>  static u64 fsl_ioread64be(const u64 __iomem *addr)
>  {
> -	u32 fsl_addr = lower_32_bits(addr);
> +	u32 fsl_addr = (u32) addr;
>  	u64 fsl_addr_hi = (u64)in_be32((u32 *)fsl_addr) << 32;
>  
>  	return fsl_addr_hi | in_be32((u32 *)(fsl_addr + 1));
> -- 
> 2.28.0
> 

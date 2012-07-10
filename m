Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C99B32C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 07:26:01 +1000 (EST)
Message-ID: <4FFC9DE1.5060502@freescale.com>
Date: Tue, 10 Jul 2012 16:25:53 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Qiang Liu <qiang.liu@freescale.com>
Subject: Re: [linuxppc-release] [PATCH 4/4] Talitos: fix the issue of dma
 memory leak
References: <1341900014-20915-1-git-send-email-qiang.liu@freescale.com>
In-Reply-To: <1341900014-20915-1-git-send-email-qiang.liu@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Herbert Xu <herbert@gondor.hengli.com.au>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Qiang Liu wrote:
> An error will be happened when test with mass data:

Please don't use the phrase "fix the issue" in patch summaries.  It's
redundant.

This patch should be titled,

"drivers/crypto: fix memory leak in Talitos driver"

> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
> index 81f8497..a7da48c 100644
> --- a/drivers/crypto/talitos.c
> +++ b/drivers/crypto/talitos.c
> @@ -264,7 +264,7 @@ static void flush_channel(struct device *dev, int ch, int error, int reset_ch)
>  			else
>  				status = error;
> 
> -		dma_unmap_single(dev, request->dma_desc,
> +		 dma_unmap_single(priv->dev, request->dma_desc,

You have an indentation problem here.

-- 
Timur Tabi
Linux kernel developer at Freescale

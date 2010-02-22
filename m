Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 10E4DB7CB6
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 07:26:22 +1100 (EST)
Date: Mon, 22 Feb 2010 21:26:13 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: "Steven J. Magnani" <steve@digidescorp.com>
Subject: Re: [async_tx-next PATCH 2/2] fsldma: Fix cookie issues
In-Reply-To: <1266860439-17352-1-git-send-email-steve@digidescorp.com>
Message-ID: <Pine.LNX.4.64.1002222123350.4120@axis700.grange>
References: <1266860439-17352-1-git-send-email-steve@digidescorp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Zhang Wei <zw@zh-kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 22 Feb 2010, Steven J. Magnani wrote:

> diff -uprN a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> --- a/include/linux/dmaengine.h	2010-02-22 11:18:11.000000000 -0600
> +++ b/include/linux/dmaengine.h	2010-02-22 11:18:30.000000000 -0600
> @@ -31,6 +31,8 @@
>   * if dma_cookie_t is >0 it's a DMA request cookie, <0 it's an error code
>   */
>  typedef s32 dma_cookie_t;
> +#define DMA_MIN_COOKIE	1
> +#define DMA_MAX_COOKIE	2147483647

Taking into account, that dma_cookie_t is 32 bits:

+#define DMA_MAX_COOKIE		((1 << 31) - 1)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

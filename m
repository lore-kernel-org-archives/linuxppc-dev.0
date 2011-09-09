Return-Path: <cbouatmailru@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 48C27B70BB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 10 Sep 2011 00:07:10 +1000 (EST)
Received: by wyh21 with SMTP id 21so1554123wyh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 09 Sep 2011 07:07:05 -0700 (PDT)
Date: Fri, 9 Sep 2011 18:07:01 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
Message-ID: <20110909140701.GA9258@oksana.dev.rtsoft.ru>
References: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
	linux-mmc@vger.kernel.org, Xu lei <B33228@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 09, 2011 at 08:05:46PM +0800, Roy Zang wrote:
> From: Xu lei <B33228@freescale.com>
> 
> Freescale eSDHC registers only support 32-bit accesses,
> this patch ensures that all Freescale eSDHC register accesses
> are 32-bit.
> 
> Signed-off-by: Xu lei <B33228@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---

The patch looks OK.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

[...]
> +static u8 esdhc_readb(struct sdhci_host *host, int reg)
> +{
> +	int base = reg & ~0x3;
> +	int shift = (reg & 0x3) * 8;
> +	u8 ret = (in_be32(host->ioaddr + base) >> shift) & 0xff;
>  	return ret;
>  }

Though, I wonder if we could change sdhci_be32bs_read{b,w}, instead
of making this local to eSDHC.

The thing is: sdhci_be32bs_writeb() is using clrsetbits_be32,
so the write variant already uses 32-bit accessors, so nothing should
break if we switch sdhci_be32bs_readb() to in_be32().

But maybe it's safer if we do this in a separate patch, so that it
could be easily reverted without impacting eSDHC if something actually
breaks.

You decide. :-)

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com

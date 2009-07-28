Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 48567B7B5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jul 2009 02:11:19 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id CEFFBDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2009 02:11:18 +1000 (EST)
Date: Tue, 28 Jul 2009 20:11:15 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 8/9] drivers/mmc: correct error-handling code
Message-ID: <20090728161115.GA8091@oksana.dev.rtsoft.ru>
References: <Pine.LNX.4.64.0907281755340.28189@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.64.0907281755340.28189@ask.diku.dk>
Cc: linuxppc-dev@ozlabs.org, kernel-janitors@vger.kernel.org,
	sdhci-devel@lists.ossman.eu, linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 28, 2009 at 05:56:00PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> sdhci_alloc_host returns an ERR_PTR value in an error case instead of NULL.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @match exists@
> expression x, E;
> statement S1, S2;
> @@
> 
> x = sdhci_alloc_host(...)
> ... when != x = E
> (
> *  if (x == NULL || ...) S1 else S2
> |
> *  if (x == NULL && ...) S1 else S2
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Thanks,

> ---
>  drivers/mmc/host/sdhci-of.c         |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of.c b/drivers/mmc/host/sdhci-of.c
> index d79fa55..fb00bc5 100644
> --- a/drivers/mmc/host/sdhci-of.c
> +++ b/drivers/mmc/host/sdhci-of.c
> @@ -226,7 +226,7 @@ static int __devinit sdhci_of_probe(struct of_device *ofdev,
>  		return -ENODEV;
>  
>  	host = sdhci_alloc_host(&ofdev->dev, sizeof(*of_host));
> -	if (!host)
> +	if (IS_ERR(host))
>  		return -ENOMEM;
>  
>  	of_host = sdhci_priv(host);

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

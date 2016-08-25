Return-Path: <clabbe.montjoie@gmail.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKjnP3xXNzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 22:15:52 +1000 (AEST)
Received: by mail-wm0-x243.google.com with SMTP id i138so7141220wmf.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 05:15:52 -0700 (PDT)
Date: Thu, 25 Aug 2016 14:15:46 +0200
From: LABBE Corentin <clabbe.montjoie@gmail.com>
To: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc: olof@lixom.net, mpm@selenic.com, herbert@gondor.apana.org.au,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: pasemi_rng.c: Migrate to managed API
Message-ID: <20160825121546.GA25650@Red>
References: <1472124856-12767-1-git-send-email-prasannatsmkumar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472124856-12767-1-git-send-email-prasannatsmkumar@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 25, 2016 at 05:04:16PM +0530, PrasannaKumar Muralidharan wrote:
> Use devm_ioremap and devm_hwrng_register instead of ioremap and
> hwrng_register. This removes unregistering and error handling code.
> 
> This patch is not tested with hardware as I don't have access to it.
> 
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> ---
>  drivers/char/hw_random/pasemi-rng.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/hw_random/pasemi-rng.c b/drivers/char/hw_random/pasemi-rng.c
> index 699b725..0f03397 100644
> --- a/drivers/char/hw_random/pasemi-rng.c
> +++ b/drivers/char/hw_random/pasemi-rng.c
> @@ -100,37 +100,18 @@ static int rng_probe(struct platform_device *ofdev)
>  	void __iomem *rng_regs;
>  	struct device_node *rng_np = ofdev->dev.of_node;
>  	struct resource res;
> -	int err = 0;
>  
> -	err = of_address_to_resource(rng_np, 0, &res);
> -	if (err)
> +	if (of_address_to_resource(rng_np, 0, &res))
>  		return -ENODEV;
>  
> -	rng_regs = ioremap(res.start, 0x100);
> -
> +	rng_regs = devm_ioremap(&ofdev->dev, res.start, 0x100);
>  	if (!rng_regs)
>  		return -ENOMEM;
>  

I will propose to use devm_ioremap_resource() instead for removing this hardcoded 0x100, but i cannot find any user of this driver in any dts. (And so cannot check that this 0x100 is given in any DT resource node)

Is this normal ?

Regard

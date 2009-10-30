Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57397B7BB2
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 08:54:36 +1100 (EST)
Subject: Re: mpc512x/clock: fix clk_get logic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <w.sang@pengutronix.de>
In-Reply-To: <1256894234-11264-1-git-send-email-w.sang@pengutronix.de>
References: <1256894234-11264-1-git-send-email-w.sang@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 31 Oct 2009 08:54:17 +1100
Message-ID: <1256939657.6372.81.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-10-30 at 10:17 +0100, Wolfram Sang wrote:
> The matching logic returns a clock even if only the dev-part matches. This is
> wrong as devices may utilize more than one clock, so the wrong clock may be
> returned due to dev being not unique (noticed while working on the CAN driver).
> The proposed new method will:
> 
> - require the id field (as _this_ is the unique identifier)
> - dev need not be given; if NULL, it will match any device.
>   if given, it has to match the dev of the clock
> - using the above rules, both fields need to match in order to claim the clock

Have you considered switching to my proposed device-tree based clock
reprentation ?

Cheers,
Ben.

> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
>  arch/powerpc/platforms/512x/clock.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> Index: .kernel/arch/powerpc/platforms/512x/clock.c
> ===================================================================
> --- .kernel.orig/arch/powerpc/platforms/512x/clock.c
> +++ .kernel/arch/powerpc/platforms/512x/clock.c
> @@ -53,19 +53,21 @@ static DEFINE_MUTEX(clocks_mutex);
>  static struct clk *mpc5121_clk_get(struct device *dev, const char *id)
>  {
>  	struct clk *p, *clk = ERR_PTR(-ENOENT);
> -	int dev_match = 0;
> -	int id_match = 0;
> +	bool id_match = false;
> +	/* Match any device if no dev given */
> +	bool dev_match = !dev;
>  
> -	if (dev == NULL || id == NULL)
> +	/* We need the unique identifier */
> +	if (id == NULL)
>  		return NULL;
>  
>  	mutex_lock(&clocks_mutex);
>  	list_for_each_entry(p, &clocks, node) {
>  		if (dev == p->dev)
> -			dev_match++;
> +			dev_match = true;
>  		if (strcmp(id, p->name) == 0)
> -			id_match++;
> -		if ((dev_match || id_match) && try_module_get(p->owner)) {
> +			id_match = true;
> +		if (dev_match && id_match && try_module_get(p->owner)) {
>  			clk = p;
>  			break;
>  		}
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

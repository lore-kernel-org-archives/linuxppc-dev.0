Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 267C31007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 12:45:57 +1000 (EST)
Subject: Re: [PATCH] fix of_flat_dt_is_compatible to match the full
	compatible string
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stuart Yoder <stuart.yoder@freescale.com>
In-Reply-To: <1279841330-28695-1-git-send-email-stuart.yoder@freescale.com>
References: <1279841330-28695-1-git-send-email-stuart.yoder@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jul 2010 12:45:50 +1000
Message-ID: <1279853150.1970.58.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-22 at 18:28 -0500, Stuart Yoder wrote:
> From: Stuart Yoder <stuart.yoder@freescale.com>
> 
> With the previous string comparison, a device tree
> compatible of "foo-bar" would match as compatible
> with a driver looking for "foo".
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>

Beware you are doing two changes in one here and only documenting one...

You also removed the case insenstivity.

Now, those things are supposed to be case sensitive afaik, but we have
enough legacy HW with more/less crap DTs and I'd be careful with
changing that without a good reason (ie, it breaks not to do it ?).

No objection with fixing the partial match tho.

Cheers,
Ben.

> ---
>  drivers/of/fdt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index dee4fb5..f5239c0 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -169,7 +169,7 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
>  	if (cp == NULL)
>  		return 0;
>  	while (cplen > 0) {
> -		if (strncasecmp(cp, compat, strlen(compat)) == 0)
> +		if (!strcmp(cp, compat))
>  			return 1;
>  		l = strlen(cp) + 1;
>  		cp += l;

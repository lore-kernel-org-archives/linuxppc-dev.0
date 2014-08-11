Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE81E1A07BF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 12:56:59 +1000 (EST)
Message-ID: <1407725796.4508.54.camel@pasglop>
Subject: Re: [PATCH 7/14] cpu: delete unneeded test before of_node_put
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon, 11 Aug 2014 12:56:36 +1000
In-Reply-To: <1407492475-26283-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1407492475-26283-3-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-08-08 at 12:07 +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Simplify the error path to avoid calling of_node_put when it is not needed.
> 
> The semantic patch that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)

Change the subject to powerpc/4xx/cpm or something like that,
appart from that:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> 
> // <smpl>
> @@
> expression e;
> @@
> 
> -if (e)
>    of_node_put(e);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  arch/powerpc/sysdev/ppc4xx_cpm.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/ppc4xx_cpm.c b/arch/powerpc/sysdev/ppc4xx_cpm.c
> index 82e2cfe..ba95adf 100644
> --- a/arch/powerpc/sysdev/ppc4xx_cpm.c
> +++ b/arch/powerpc/sysdev/ppc4xx_cpm.c
> @@ -281,7 +281,7 @@ static int __init cpm_init(void)
>  		printk(KERN_ERR "cpm: could not parse dcr property for %s\n",
>  		       np->full_name);
>  		ret = -EINVAL;
> -		goto out;
> +		goto node_put;
>  	}
>  
>  	cpm.dcr_host = dcr_map(np, dcr_base, dcr_len);
> @@ -290,7 +290,7 @@ static int __init cpm_init(void)
>  		printk(KERN_ERR "cpm: failed to map dcr property for %s\n",
>  		       np->full_name);
>  		ret = -EINVAL;
> -		goto out;
> +		goto node_put;
>  	}
>  
>  	/* All 4xx SoCs with a CPM controller have one of two
> @@ -330,9 +330,9 @@ static int __init cpm_init(void)
>  
>  	if (cpm.standby || cpm.suspend)
>  		suspend_set_ops(&cpm_suspend_ops);
> +node_put:
> +	of_node_put(np);
>  out:
> -	if (np)
> -		of_node_put(np);
>  	return ret;
>  }
>  

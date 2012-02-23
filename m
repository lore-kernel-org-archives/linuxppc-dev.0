Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C5D1B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 12:41:57 +1100 (EST)
Received: by pbbrp2 with SMTP id rp2so889431pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2012 17:41:55 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 22 Feb 2012 18:41:53 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] ppc-6xx: fix build failure in flipper-pic.c and hlwd-pic.c
Message-ID: <20120223014153.GD3212@ponder.secretlab.ca>
References: <1329953703-25806-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329953703-25806-1-git-send-email-paul.gortmaker@windriver.com>
Cc: olof@lixom.net, linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 22, 2012 at 06:35:03PM -0500, Paul Gortmaker wrote:
> The commit bae1d8f19983fbfa25559aa3cb6a81a84aa82a18 (linux-next)
> 
>   "irq_domain/powerpc: Use common irq_domain structure instead of irq_host"
> 
> made this change:
> 
>    -static struct irq_host *flipper_irq_host;
>    +static struct irq_domain *flipper_irq_host;
> 
> and this change:
> 
>    -static struct irq_host *hlwd_irq_host;
>    +static struct irq_domain *hlwd_irq_host;
> 
> The intent was to change the type, and not the name, but then in a
> couple of instances, it looks like the sed to change the irq_domain_ops
> name inadvertently also changed the irq_host name where it was not
> supposed to, causing build failures.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Merged, thanks.

g.

> 
> ---
> 
> [seen in build tests on the linux-next tree from yesterday.]
> 
> diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
> index 675335a..53d6eee 100644
> --- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
> +++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
> @@ -172,7 +172,7 @@ out:
>  
>  unsigned int flipper_pic_get_irq(void)
>  {
> -	void __iomem *io_base = flipper_irq_domain->host_data;
> +	void __iomem *io_base = flipper_irq_host->host_data;
>  	int irq;
>  	u32 irq_status;
>  
> @@ -182,7 +182,7 @@ unsigned int flipper_pic_get_irq(void)
>  		return NO_IRQ;	/* no more IRQs pending */
>  
>  	irq = __ffs(irq_status);
> -	return irq_linear_revmap(flipper_irq_domain, irq);
> +	return irq_linear_revmap(flipper_irq_host, irq);
>  }
>  
>  /*
> @@ -197,7 +197,7 @@ void __init flipper_pic_probe(void)
>  	np = of_find_compatible_node(NULL, NULL, "nintendo,flipper-pic");
>  	BUG_ON(!np);
>  
> -	flipper_irq_domain = flipper_pic_init(np);
> +	flipper_irq_host = flipper_pic_init(np);
>  	BUG_ON(!flipper_irq_host);
>  
>  	irq_set_default_host(flipper_irq_host);
> diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> index da6ca02..3006b51 100644
> --- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> +++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
> @@ -189,7 +189,7 @@ struct irq_domain *hlwd_pic_init(struct device_node *np)
>  
>  unsigned int hlwd_pic_get_irq(void)
>  {
> -	return __hlwd_pic_get_irq(hlwd_irq_domain);
> +	return __hlwd_pic_get_irq(hlwd_irq_host);
>  }
>  
>  /*
> @@ -213,7 +213,7 @@ void hlwd_pic_probe(void)
>  			irq_set_handler_data(cascade_virq, host);
>  			irq_set_chained_handler(cascade_virq,
>  						hlwd_pic_irq_cascade);
> -			hlwd_irq_domain = host;
> +			hlwd_irq_host = host;
>  			break;
>  		}
>  	}
> @@ -227,7 +227,7 @@ void hlwd_pic_probe(void)
>   */
>  void hlwd_quiesce(void)
>  {
> -	void __iomem *io_base = hlwd_irq_domain->host_data;
> +	void __iomem *io_base = hlwd_irq_host->host_data;
>  
>  	__hlwd_quiesce(io_base);
>  }
> -- 
> 1.7.9.1
> 

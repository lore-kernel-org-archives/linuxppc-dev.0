Return-Path: <>
Received: from asclepius.site5.com (asclepius.site5.com [70.47.36.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C257ADDDDB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jul 2007 13:25:12 +1000 (EST)
Date: Wed, 4 Jul 2007 22:35:43 -0400
From: Sonny Rao <sonny@burdell.org>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH] pseries: don't die if unknown/missing interrupt
	controller property
Message-ID: <20070705023543.GA21522@kevlar.boston.burdell.org>
References: <20070702004937.GA15712@kevlar.boston.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070702004937.GA15712@kevlar.boston.burdell.org>
Cc: miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jul 01, 2007 at 08:49:37PM -0400, Sonny Rao wrote:
> The pseries platform does not have a default function for init_IRQ and
> does not install one if it doesn't find or doesn't recognize an
> interrupt controller in the device tree.  Currently, the kernel dies
> when it tries to call the NULL init_IRQ() function.  Clean that up.
> 
> Signed-off-by: Sonny Rao <sonny@burdell.org>
> 
> --- kernel/arch/powerpc/platforms/pseries/setup.c~orig	2007-06-26 16:23:38.000000000 -0500
> +++ kernel/arch/powerpc/platforms/pseries/setup.c	2007-06-26 19:09:53.000000000 -0500
> @@ -274,6 +274,12 @@ static void pseries_lpar_enable_pmcs(voi
>  		get_lppaca()->pmcregs_in_use = 1;
>  }
>  
> +static void no_irq_init(void)
> +{
> +	printk(KERN_ERR "no_irq_init: failed to recognize"
> +	       " interrupt-controller\n");
> +}
> +
>  static void __init pseries_discover_pic(void)
>  {
>  	struct device_node *np;
> @@ -296,8 +302,6 @@ static void __init pseries_discover_pic(
>  			return;
>  		}
>  	}
> -	printk(KERN_ERR "pSeries_discover_pic: failed to recognize"
> -	       " interrupt-controller\n");
>  }
>  
>  static void __init pSeries_setup_arch(void)
> @@ -594,4 +598,5 @@ define_machine(pseries) {
>  	.check_legacy_ioport	= pSeries_check_legacy_ioport,
>  	.system_reset_exception = pSeries_system_reset_exception,
>  	.machine_check_exception = pSeries_machine_check_exception,
> +	.init_IRQ		= no_irq_init,  
>  };


Hi Paul, if there's no objection I'd like this to go into 2.6.23 thanks.

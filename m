Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C60E4B7CC1
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2010 13:53:10 +1100 (EST)
Subject: Re: [PATCH 1/2] Add static fields to ibm,client-architecture call
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joel Schopp <jschopp@austin.ibm.com>
In-Reply-To: <1263510116.7445.5.camel@jschopp-laptop>
References: <1263501508.4869.133.camel@jschopp-laptop>
	<1263501613.4869.139.camel@jschopp-laptop>
	<1263510116.7445.5.camel@jschopp-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jan 2010 13:51:03 +1100
Message-ID: <1263523863.724.380.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-01-14 at 17:01 -0600, Joel Schopp wrote:
> This patch adds 2 fields to the ibm_architecture_vec array.  
> 
> The first of these fields indicates the number of cores which Linux can
> boot.  It does not account for SMT, so it may result in cpus assigned to
> Linux which cannot be booted.  A second patch follows that dynamically
> updates this for SMT.
> 
> The second field just indicates that our OS is Linux, and not another
> OS.  The system may or may not use this hint to performance tune
> settings for Linux.

Patch submission 101...

> Sorry if the last version sent out got whitespace munged.  Hopefully
> evolution works on this one.

The above should be past the signature marker (--) so it doesn't end up
in the changeset comments

> Signed-off-by:Joel Schopp<jschopp@austin.ibm.com>

The marker should be here or the line below:

> Index: linux-2.6.git/arch/powerpc/kernel/prom_init.c
> ===================================================================

Would also end up in the comments.

The rest looks fine.

Cheers,
Ben.

> --- linux-2.6.git.orig/arch/powerpc/kernel/prom_init.c
> +++ linux-2.6.git/arch/powerpc/kernel/prom_init.c
> @@ -654,6 +656,9 @@ static void __init early_cmdline_parse(v
>  #define OV5_CMO			0x00
>  #endif
>  
> +/* Option Vector 6: IBM PAPR hints */
> +#define OV6_LINUX		0x02	/* Linux is our OS */
> +
>  /*
>   * The architecture vector has an array of PVR mask/value pairs,
>   * followed by # option vectors - 1, followed by the option vectors.
> @@ -665,7 +670,7 @@ static unsigned char ibm_architecture_ve
>  	W(0xffffffff), W(0x0f000003),	/* all 2.06-compliant */
>  	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
>  	W(0xfffffffe), W(0x0f000001),	/* all 2.04-compliant and earlier */
> -	5 - 1,				/* 5 option vectors */
> +	6 - 1,				/* 6 option vectors */
>  
>  	/* option vector 1: processor architectures supported */
>  	3 - 2,				/* length */
> @@ -697,12 +702,24 @@ static unsigned char ibm_architecture_ve
>  	0,				/* don't halt */
>  
>  	/* option vector 5: PAPR/OF options */
> -	5 - 2,				/* length */
> +	13 - 2,				/* length */
>  	0,				/* don't ignore, don't halt */
>  	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES | OV5_DRCONF_MEMORY |
>  	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
>  	0,
>  	OV5_CMO,
> +	0,
> +	0,
> +	0,
> +	0,
> +	W(NR_CPUS),			/* number of cores supported*/
> +
> +	/* option vector 6: IBM PAPR hints */
> +	4 - 2,				/* length */
> +	0,
> +	0,
> +	OV6_LINUX,
> +
>  };
>  
>  /* Old method - ELF header with PT_NOTE sections */
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

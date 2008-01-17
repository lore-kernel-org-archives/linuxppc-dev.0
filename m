Return-Path: <dgibson@ozlabs.org>
Date: Thu, 17 Jan 2008 11:16:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [Add mpc5121 support PATCH v2 2/8] Add mpc512x ipic support
Message-ID: <20080117001615.GA9989@localhost.localdomain>
References: <1200519447-25555-1-git-send-email-jrigby@freescale.com>
	<1200519447-25555-2-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1200519447-25555-2-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 16, 2008 at 02:37:21PM -0700, John Rigby wrote:
> Added ipic_info entries for vectors used by 512x that
> were previously unused by 83xx.

I've always wondered what these great big tables in the ipic driver
were for.  Are they anything that could be better repsresented in the
device tree?

> diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
> index 7274750..4c016da 100644
> --- a/arch/powerpc/sysdev/ipic.c
> +++ b/arch/powerpc/sysdev/ipic.c
> @@ -48,6 +48,13 @@ static struct ipic_info ipic_info[] = {
>  		.bit	= 17,
>  		.prio_mask = 1,
>  	},
> +	[3] = {
> +		.mask	= IPIC_SIMSR_H,
> +		.prio	= IPIC_SIPRR_C,
> +		.force	= IPIC_SIFCR_H,
> +		.bit	= 18,
> +		.prio_mask = 2,
> +	},
>  	[4] = {
>  		.mask	= IPIC_SIMSR_H,
>  		.prio	= IPIC_SIPRR_C,
> @@ -55,6 +62,34 @@ static struct ipic_info ipic_info[] = {
>  		.bit	= 19,
>  		.prio_mask = 3,
>  	},
> +	[5] = {
> +		.mask	= IPIC_SIMSR_H,
> +		.prio	= IPIC_SIPRR_C,
> +		.force	= IPIC_SIFCR_H,
> +		.bit	= 20,
> +		.prio_mask = 4,
> +	},
[...]

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

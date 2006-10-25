Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17727.56923.634981.723647@cargo.ozlabs.ibm.com>
Date: Thu, 26 Oct 2006 07:59:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
In-Reply-To: <453FB582.20802@bplan-gmbh.de>
References: <453FB582.20802@bplan-gmbh.de>
Cc: akpm@osdl.org, Sylvain Munaut <tnt@246tNt.com>, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nicolas DET writes:

>  	if (machine && strncmp(machine, "Pegasos", 7) == 0) {
>  		_chrp_type = _CHRP_Pegasos;
> +	} else if (machine && strncmp(machine, "EFIKA5K2", 8) == 0) {
> +		_chrp_type =_CHRP_E5K2;

This whole _chrp_type thing, and having to do different things based
on the root-node model property, is really only a workaround for
older machines with inadequate device trees.  Decisions about things
like which interrupt controller driver(s) to instantiate should be
taken based on properties in the appropriate device-tree nodes, for
instance the model and compatible properties in the node(s) for the
interrupt controller(s).  In fact I'd like to get rid of _chrp_type
completely.

> diff -uprN a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
> --- a/include/asm-ppc/mpc52xx.h	2006-10-25 19:07:48.000000000 +0200
> +++ b/include/asm-ppc/mpc52xx.h	2006-10-25 19:11:55.000000000 +0200
> @@ -119,7 +119,7 @@ enum ppc_sys_devices {
>  #define MPC52xx_SDMA_IRQ_NUM	17
>  #define MPC52xx_PERP_IRQ_NUM	23
>  
> -#define MPC52xx_CRIT_IRQ_BASE	1
> +#define MPC52xx_CRIT_IRQ_BASE	0

What is this going to do to other 52xx users?

Paul.

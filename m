Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0249CDDF1E
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 08:51:47 +1000 (EST)
Message-Id: <64B092F9-7790-4655-AA12-B9010D87D0A4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Philippe De Muyter <phdm@macqel.be>
In-Reply-To: <20080409221256.GA927@frolo.macqel>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] mpc8540 : Fix restart
Date: Wed, 9 Apr 2008 17:51:40 -0500
References: <20080409221256.GA927@frolo.macqel>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 9, 2008, at 5:12 PM, Philippe De Muyter wrote:
> Hi everybody,
>
> 	Previously, with the arch/ppc tree, mpc8540 boards could reboot.
> 	Now with the arch/powerpc tree, they can not anymore.
> 	Fix that.
>
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>
>
> --- a/arch/powerpc/sysdev/fsl_soc.c	2008-03-21 14:53:41.000000000  
> +0000
> +++ b/arch/powerpc/sysdev/fsl_soc.c	2008-03-26 12:08:25.000000000  
> +0000
> @@ -1428,13 +1433,17 @@
>
> arch_initcall(setup_rstcr);
>
> +extern void abort(void);
> +
> void fsl_rstcr_restart(char *cmd)
> {
> 	local_irq_disable();
> 	if (rstcr)
> 		/* set reset control register */
> 		out_be32(rstcr, 0x2);	/* HRESET_REQ */
> -
> +	else
> +		abort();
> 	while (1) ;
> +
> }

This was on purpose.  abort() doesn't really do a restart and thus I  
didn't want it to be used that way.

- k

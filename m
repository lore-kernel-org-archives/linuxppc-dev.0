Return-Path: <tnt@246tNt.com>
Message-ID: <4540F659.9070409@246tNt.com>
Date: Thu, 26 Oct 2006 19:54:33 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
References: <453FB582.20802@bplan-gmbh.de>	
	<1161816783.22582.132.camel@localhost.localdomain>	
	<45409760.7030902@bplan-gmbh.de>	
	<1161866964.27827.2.camel@localhost.localdomain>	
	<4540B0A9.6070404@bplan-gmbh.de>	
	<528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>
	<528646bc0610260909x10c3b242i64387f576e625048@mail.gmail.com>
	<4540EB0E.2090000@bplan-gmbh.de>
In-Reply-To: <4540EB0E.2090000@bplan-gmbh.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Nicolas,


I don't have much to add to what's already been posted, so here's a
couple of details,
mainly compatibility concerns with the legacy arch/ppc tree.

>  
> diff -uprN a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
> --- a/include/asm-ppc/mpc52xx.h	2006-10-25 19:07:48.000000000 +0200
> +++ b/include/asm-ppc/mpc52xx.h	2006-10-25 19:11:55.000000000 +0200
> @@ -119,7 +119,7 @@ enum ppc_sys_devices {
>  #define MPC52xx_SDMA_IRQ_NUM	17
>  #define MPC52xx_PERP_IRQ_NUM	23
>  
> -#define MPC52xx_CRIT_IRQ_BASE	1
> +#define MPC52xx_CRIT_IRQ_BASE	0
As explained in IRC, I'm not sure about this.
I was previously talked into applying this to avoid using interrupt
number 0. In the LITE5200 IRQ0 is used for PCI. It's interrupt number
is equal to MPC52xx_CRIT_IRQ_BASE and if it's 0 some drivers just don't
work.
That's when using the arch/ppc code. Apparently this is no longer an
issue in arch/powerpc (someone to confirm and explain me why ? I would guess
the irq_linear_revmap thingie ), but can a "standard" lite5200 be booted
in a arch/powerpc kernel ?

So if no critical, I would postpone that change until it's confirmed
a lite5200 can boot ...


> -extern int mpc52xx_get_irq(void);
> +extern unsigned int mpc52xx_get_irq(void);
Mmmh, the one in arch/ppc is not unsigned but I guess the warning is fine.


Finally, some triviality : The patch adds some space on empty lines. Also,
the indentation is sometimes done with space and sometimes with space ...




    Sylvain

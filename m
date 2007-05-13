Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 5B8A8DDEBE
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 10:24:51 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/9] powerpc: BestComm core support for Freescale MPC5200
Date: Sun, 13 May 2007 02:24:45 +0200
References: <11790019171838-git-send-email-tnt@246tNt.com>
	<200705130127.08761.arnd@arndb.de> <46465295.90309@246tNt.com>
In-Reply-To: <46465295.90309@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705130224.46114.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 13 May 2007, Sylvain Munaut wrote:

> BestComm has some pretty specific needs and I think trying to
> somehow extends a generic interface to fit those needs would just
> pollute it.

ok.

> However, you could totally implement a "DMA devices" that would just
> use a simple "copy from there to there" task using this BestComm driver.
> So other part of the kernel (like network) could use that interface to
> use the dma engine ...

Can it also do the advanced operations like XOR on DMA that the
Intel ioat has? That would be even more interesting, I guess.

> >> +static int __init
> >> +mpc52xx_bcom_init(void)
> >> +{
> >> +	struct device_node *ofn_bcom, *ofn_sram;
> >> +	struct resource res_bcom;
> >> +
> >> +	int rv;
> >> +
> >> +	/* Find the bestcomm node. If none, fails 'silently' since
> >> +	 * we may just be on another platform */
> >> +	ofn_bcom = of_find_compatible_node(
> >> +			NULL, "dma-controller", "mpc5200-bestcomm");
> >> +	if (!ofn_bcom)
> >> +		return -ENODEV;
> >
> > I know, my usual rant is getting old, but why is this one not an
> > of_platform_driver? It's not shared with arch/ppc or with arch/mips,
> > and it's not needed before module_init() time.
> It needs to be initialized before _any_ other driver that uses bestcomm.
> When compiled as module that could be an of_platform_driver but when
> built-in there is apparently no way to ensure it's going to be probed
> first. (At least no clean way ... )

Initialization order is always a little tricky, but if you use a 
subsys_initcall, it should at least come before any regular driver
like network or disk, and arch/ drivers come before any code in drivers/,
so I don't see much of a problem here.

> >> +
> >> +#ifdef MODULE
> >> +module_init(mpc52xx_bcom_init);
> >> +module_exit(mpc52xx_bcom_exit);
> >> +#endif
> >> +
> >> +/* If we're not a module, we must make sure everything is setup before anyone */
> >> +/* tries to use us ... */
> >> +#ifndef MODULE
> >> +subsys_initcall(mpc52xx_bcom_init);
> >> +#endif
> >
> > You can make it subsys_initcall() unconditionally. If the driver gets built
> > as a module, it will turn into module_init() by itself.
> Oh, great, I didn't know that. I guess the module_exit still has to be
> conditionnal.

No, it's designed so that you don't need any #ifdef. The module_exit
function can simply be left out entirely when doing a builtin driver.

> > Why don't you use EXPORT_SYMBOL_GPL?
> Why would I ? Is it mandatory now ?
> I don't really have an objection to non-gpl modules to use the exported
> functions ...

It's your choice, but there is a strong recommendation to use _GPL for
all new interfaces nowadays. If you don't, people might suspect that
you have a hidden agenda and actually plan to do non-gpl modules
yourself.

However, this is a legal minefield and I'm not trying to force you
to change it, it is always the decision of the copyright holder.

	Arnd <><

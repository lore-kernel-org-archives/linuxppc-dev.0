Return-Path: <sr@denx.de>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by ozlabs.org (Postfix) with ESMTP id 2067F6830C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 21:02:26 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 19 Sep 2005 13:02:14 +0200
References: <ea43f4f9050825183121655ba2@mail.gmail.com>
	<200509161306.17103.sr@denx.de>
	<20050916162733.GA8019@gate.ebshome.net>
In-Reply-To: <20050916162733.GA8019@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509191302.15462.sr@denx.de>
Subject: Re: [PATCH] ppc32: cleanup AMCC PPC4xx eval boards to better
	support U-Boot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Eugene,

On Friday 16 September 2005 18:27, Eugene Surovegin wrote:
> On Fri, Sep 16, 2005 at 01:06:16PM +0200, Stefan Roese wrote:
> > Add U-Boot support to AMCC PPC405 eval boards (bubinga, sycamore and
> > walnut) and cleanup PPC440 eval boards (bamboo, ebony, luan and ocotea)
> > to better support U-Boot as bootloader.
>
> In general, 44x pieces look OK, but 40x aren't. Notice, that we don't
> have any #ifdef CONFIG_UBOOT in 44x sources. Let's not add them for
> 40x, try to replicate the same boot-wrapper approach as Matt used for
> 44x.

OK. I'll split the patch in two (44x and 40x stuff) so we can get the 44x 
pieces on the way.

Just to be sure: The 44x boot-wrapper approach you mention is 
"boot/simple/pibs.c"?

<snip>

> [snip]
>
> > --- a/arch/ppc/platforms/4xx/bubinga.c
> > +++ b/arch/ppc/platforms/4xx/bubinga.c
> > @@ -89,7 +89,11 @@ bubinga_early_serial_map(void)
> >            * by 16.
> >            */
> >  	uart_div = (mfdcr(DCRN_CPC0_UCR_BASE) & DCRN_CPC0_UCR_U0DIV);
> > +#ifdef CONFIG_UBOOT
> > +	uart_clock = __res.bi_procfreq / uart_div;
> > +#else
> >  	uart_clock = __res.bi_pllouta_freq / uart_div;
> > +#endif
>
> Why not just rename this field and skip this ugly ifdefing?

That's better. Will be updated in next try.

Best regards,
Stefan

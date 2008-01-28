Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [67.192.77.34])
	by ozlabs.org (Postfix) with ESMTP id 84191DDE9A
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 10:55:36 +1100 (EST)
Subject: Re: PATCH[1/1] 8xx: Add clock-frequency to .dts brg entries
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080128155012.GA27054@ld0162-tx32.am.freescale.net>
References: <1201485191.5537.55.camel@neuromancer.mindspace>
	<20080128155012.GA27054@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Mon, 28 Jan 2008 23:55:20 +0000
Message-Id: <1201564520.3912.29.camel@neuromancer.mindspace>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-01-28 at 09:50 -0600, Scott Wood wrote:
> On Mon, Jan 28, 2008 at 01:53:11AM +0000, Bryan O'Donoghue wrote:
> > cpm_uart_core has a dependency on fsl,cpm-brg/clock-frequency, this
> > means that a .dts that uses the cpm uart driver needs to supply a
> > clock-frequency entry for get_brgfreq to return a meaningful number.
> > 
> > Included is a patchset which adds the correct brgclk to the adder port -
> > @ 50Mhz and also adds an entry for mpc885ads - which I've noticed is
> > missing a clock-frequency entry.
> 
> It's not missing -- it's added by the bootwrapper.
> 
> -Scott

Hmm..

You mean that arch/powerpc/boot/mpc8xx.c mpc8xx_set_clocks is supposed
to be adding this field ? 

I see arch/powerpc/boot/wrapper.a has a reference to the function but -
and this time I've checked all documentation - there's no mention of how
to use this library at all... it _looks_ to me like this isn't being
linked in any way.

It for sure is nowhere in the uImage - and I've taken the preferred
route of making a uImage with .dtb - genreated from adder875-uboot.dts

dtc -O -o adder875-uboot.dtb arch/powerpc/boot/dts/adder875-uboot.dtb


cpm_uart depends on "fsl,cpm-brg" and a field called "clock-frequency"

as I understand it that's

fsl,cpm-brg
	|_clock-frequency

whereas mpc8xx_set_clocks seems to add

/soc/cpm/brg
	|_clock-frequency

So unless I'm not understanding the structure of the tree - possible - I
don't see how /soc/cpm/brg => clock-frequency could /possibly/ satisfy
get_brgfreq in fsl_soc.c

If there's something other then making a uImage and dtb and booting
these from u-boot that I'm supposed to be doing here ... it'd help if
you could say..

Otherwise in order to get the UART working using a uImage + dbt I've
found it necessary to add this field to the .dts....

mpc866ads.dts - also has a "fsl,cpm-brg" => clock-frequency entry in 

linux/arch/powerpc/boot/dts/mpc866ads.dts - and to me this looks like
the correct approach for get_brgfreq to function properly...

What do you think ?

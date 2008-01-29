Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 85136DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 04:04:23 +1100 (EST)
Date: Tue, 29 Jan 2008 10:26:11 -0600
From: Scott Wood <scottwood@freescale.com>
To: "Bryan O'Donoghue" <bodonoghue@codehermit.ie>
Subject: Re: PATCH[1/1] 8xx: Add clock-frequency to .dts brg entries
Message-ID: <20080129162611.GA4599@ld0162-tx32.am.freescale.net>
References: <1201485191.5537.55.camel@neuromancer.mindspace>
	<20080128155012.GA27054@ld0162-tx32.am.freescale.net>
	<1201564520.3912.29.camel@neuromancer.mindspace>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1201564520.3912.29.camel@neuromancer.mindspace>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 28, 2008 at 11:55:20PM +0000, Bryan O'Donoghue wrote:
> You mean that arch/powerpc/boot/mpc8xx.c mpc8xx_set_clocks is supposed
> to be adding this field ? 

Yes.  Or u-boot, if you're not using the bootwrapper/cuImage.

> I see arch/powerpc/boot/wrapper.a has a reference to the function but -
> and this time I've checked all documentation - there's no mention of how
> to use this library at all... it _looks_ to me like this isn't being
> linked in any way.
> 
> It for sure is nowhere in the uImage - and I've taken the preferred
> route of making a uImage with .dtb - genreated from adder875-uboot.dts

In that case, u-boot needs to add that property.

> dtc -O -o adder875-uboot.dtb arch/powerpc/boot/dts/adder875-uboot.dtb

You'll want to use the -p option to add some extra space for u-boot to
use.

> cpm_uart depends on "fsl,cpm-brg" and a field called "clock-frequency"
> 
> as I understand it that's
> 
> fsl,cpm-brg
> 	|_clock-frequency
> 
> whereas mpc8xx_set_clocks seems to add
> 
> /soc/cpm/brg
> 	|_clock-frequency

The fsl,cpm-brg refers to the compatible property, not the node name.

> mpc866ads.dts - also has a "fsl,cpm-brg" => clock-frequency entry in 
> 
> linux/arch/powerpc/boot/dts/mpc866ads.dts - and to me this looks like
> the correct approach for get_brgfreq to function properly...

And it's zero, meaning that you still need u-boot or the bootwrapper to
fill in the correct value.  The only difference is whether there's a
placeholder property -- they used to be required by older u-boots, but
are no longer necessary.

-Scott

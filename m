Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [67.192.77.34])
	by ozlabs.org (Postfix) with ESMTP id 65A8ADDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 07:20:05 +1100 (EST)
Subject: Re: PATCH[1/1] 8xx: Add clock-frequency to .dts brg entries
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080129162611.GA4599@ld0162-tx32.am.freescale.net>
References: <1201485191.5537.55.camel@neuromancer.mindspace>
	<20080128155012.GA27054@ld0162-tx32.am.freescale.net>
	<1201564520.3912.29.camel@neuromancer.mindspace>
	<20080129162611.GA4599@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Tue, 29 Jan 2008 20:18:46 +0000
Message-Id: <1201637926.3565.18.camel@neuromancer.mindspace>
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

On Tue, 2008-01-29 at 10:26 -0600, Scott Wood wrote:
> On Mon, Jan 28, 2008 at 11:55:20PM +0000, Bryan O'Donoghue wrote:
> > You mean that arch/powerpc/boot/mpc8xx.c mpc8xx_set_clocks is supposed
> > to be adding this field ? 
> 
> Yes.  Or u-boot, if you're not using the bootwrapper/cuImage.

Indeed - I have some patches to send to the u-boot mailing list to cover
manipulation of the "fsl,cpm-brg" "clock-frequency" entry.

The previously sent patch will allow Linux to print stuff out the UART
will the default brgclk - from a uImage and is the field that a future
u-boot patchset would want to manipulate in order to tell Linux about
the brgclk it should have.

I should be a bit clearer about that...

> 
> > I see arch/powerpc/boot/wrapper.a has a reference to the function but -
> > and this time I've checked all documentation - there's no mention of how
> > to use this library at all... it _looks_ to me like this isn't being
> > linked in any way.
> > 
> > It for sure is nowhere in the uImage - and I've taken the preferred
> > route of making a uImage with .dtb - genreated from adder875-uboot.dts
> 
> In that case, u-boot needs to add that property.

See above.

> > dtc -O -o adder875-uboot.dtb arch/powerpc/boot/dts/adder875-uboot.dtb
> 
> You'll want to use the -p option to add some extra space for u-boot to
> use.

Interesting - the u-boot end of this patch is something I'm still
messing about with ... but, the addition of the default brgclk to the
Linux dts is a useful addition - and AFAICT will be needed to allow a
bootloader to manipulate the dts so that Linux will get the right
brgclk.

> > cpm_uart depends on "fsl,cpm-brg" and a field called "clock-frequency"
> > 
> > as I understand it that's
> > 
> > fsl,cpm-brg
> > 	|_clock-frequency
> > 
> > whereas mpc8xx_set_clocks seems to add
> > 
> > /soc/cpm/brg
> > 	|_clock-frequency
> 
> The fsl,cpm-brg refers to the compatible property, not the node name.

Indeed and the get_brgclk does a find_compatible() lookup of some
sort... so I think that means this is the right field to add to allow a
bootloader to manipulate the brgclk ... it's what the other stuff in
u-boot for the mpc8xxx stuff does, so it follows to do the same thing
for 8xx too.

> > mpc866ads.dts - also has a "fsl,cpm-brg" => clock-frequency entry in 
> > 
> > linux/arch/powerpc/boot/dts/mpc866ads.dts - and to me this looks like
> > the correct approach for get_brgfreq to function properly...
> 
> And it's zero, meaning that you still need u-boot or the bootwrapper to
> fill in the correct value.

Indeed - I'm hoping I won't have too much trouble getting those patches
applied...

Return-Path: <SRS0=un/q=TS=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 48462DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 02:36:45 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/5] [POWERPC] Add Canyonlands DTS
Date: Fri, 29 Feb 2008 16:36:29 +0100
References: <1203800881-13837-1-git-send-email-sr@denx.de>
	<20080229091120.1611ec56@zod.rchland.ibm.com>
In-Reply-To: <20080229091120.1611ec56@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802291636.29759.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 February 2008, Josh Boyer wrote:
> On Sat, 23 Feb 2008 22:08:01 +0100
>
> Stefan Roese <sr@denx.de> wrote:
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > ---
> > And now the I2C device-types are removed. Sorry for the mail-flood.
> >
> >  arch/powerpc/boot/dts/canyonlands.dts |  393
> > +++++++++++++++++++++++++++++++++ 1 files changed, 393 insertions(+), 0
> > deletions(-)
> >  create mode 100644 arch/powerpc/boot/dts/canyonlands.dts
> >
> > diff --git a/arch/powerpc/boot/dts/canyonlands.dts
> > b/arch/powerpc/boot/dts/canyonlands.dts new file mode 100644
> > index 0000000..2aee74c
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/canyonlands.dts
>
> [snip]
>
> > +		MAL0: mcmal {
> > +			compatible = "ibm,mcmal-460ex", "ibm,mcmal2";
> > +			dcr-reg = <180 62>;
> > +			num-tx-chans = <2>;
> > +			num-rx-chans = <10>;
> > +			#address-cells = <0>;
> > +			#size-cells = <0>;
> > +			interrupt-parent = <&UIC2>;
> > +			interrupts = <	/*TXEOB*/ 6 4
> > +					/*RXEOB*/ 7 4
> > +					/*SERR*/  3 4
>
> This is odd.  I have MAL SERR listed twice in the spec I have.  This
> assignment is there, and there's also one to UIC1 IRQ 0.  Error in my
> spec, or are both actually tied to the same interrupt line?

Must be an error in the preliminary spec. I have the engineering docs from 
AMCC and here UIC1 IRQ0 is the external IRQ 2, which is used for PCI. So this 
is still wrong in the current dts version. I'll send an updated version 
probably tomorrow.

> > +					/*TXDE*/  4 4
> > +					/*RXDE*/  5 4>;
> > +		};
> >
> > +			UART0: serial@ef600300 {
> > +				device_type = "serial";
> > +				compatible = "ns16550";
> > +				reg = <ef600300 8>;
> > +				virtual-reg = <ef600300>;
> > +				clock-frequency = <0>; /* Filled in by U-Boot */
> > +				current-speed = <0>; /* Filled in by U-Boot */
> > +				interrupt-parent = <&UIC1>;
> > +				interrupts = <1 4>;
>
> Should this be <2 4> or is the spec I have wrong?

Again, your documentation is incorrect. Took me 1/2 a day to figure this out 
myself.

Best regards,
Stefan

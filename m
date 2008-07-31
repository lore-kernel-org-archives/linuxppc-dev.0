Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807311211x43f54cf2h85c597562dfbb185@mail.gmail.com>
Date: Thu, 31 Jul 2008 15:11:55 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <48920C1A.7010605@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4889EFFE.2070201@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com> <20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com> <20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com> <48920C1A.7010605@freescale.com>
Cc: Linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/31/08, Scott Wood <scottwood@freescale.com> wrote:
> Timur Tabi wrote:
>
> > Grant Likely wrote:
> >
> >
> > > No it doesn't, it depends on the register interface to decide
> > > compatibility.  Clock interface is part of that.
> > >
> >
> > I don't think so.  The interface for programming the clock registers is
> > identical on all 8[356]xx parts.  The only thing that matters is what
> specific
> > values to put in the FDR and DFSR registers to get a desired I2C bus
> speed.
> >
>
>  If it affects the values you need to write to the registers to achieve a
> given result, how is it not a difference in the register interface?
>
>
> > I propose the property "clock-frequency", like this:
> >
> >                i2c@3000 {
> >                        #address-cells = <1>;
> >                        #size-cells = <0>;
> >                        cell-index = <0>;
> >                        compatible = "fsl-i2c";
> >                        reg = <0x3000 0x100>;
> >                        interrupts = <14 0x8>;
> >                        interrupt-parent = <&ipic>;
> >                        dfsrr;
> >                        clock-frequency = <0xblablabla>;  <-- added by
> U-Boot
> >                };
> >
>
>  A clock-frequency property is OK, and is in line with what we do in other
> types of nodes.  However, in the long run it might be nice to introduce some
> sort of clock binding where, for example, the i2c node can point to a clock
> elsewhere in the device tree as an input clock.
>
>  That way, less knowledge is required by the firmware to poke values all
> over the place, and it also allows one to describe situations where the
> frequency of the input clock can change (such as in low-power modes).

		PowerPC,5200@0 {
			timebase-frequency = <0>;	/* From Bootloader  */
			bus-frequency = <0>;		/* From Bootloader  */
			clock-frequency = <0>;		/* From Bootloader  */
		};

The mpc5200 code already has mpc52xx_find_ipb_freq() to get it.

I should grep before suggesting things.

-- 
Jon Smirl
jonsmirl@gmail.com

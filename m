Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE004.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 91D1EDDF87
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 00:41:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] [V2] powerpc: Xilinx: add dts file for ML507 board
Date: Tue, 8 Jul 2008 08:41:11 -0600
In-Reply-To: <20080708031641.GA1549@yookeroo.seuss>
References: <20080707180508.4E2CBE8081@mail72-dub.bigfish.com>
	<20080708031641.GA1549@yookeroo.seuss>
From: John Linn <John.Linn@xilinx.com>
To: "David Gibson" <david@gibson.dropbear.id.au>
Message-ID: <20080708144112.6C49B1CC8073@mail66-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the comments David.  =


> -----Original Message-----
> From: David Gibson [mailto:david@gibson.dropbear.id.au]
> Sent: Monday, July 07, 2008 9:17 PM
> To: John Linn
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] [V2] powerpc: Xilinx: add dts file for ML507
board
> =

> On Mon, Jul 07, 2008 at 11:04:59AM -0700, John Linn wrote:
> > This new file adds support for the ML507 board which
> > has a Virtex 5 FXT FPGA with a 440.
> >
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> > ---
> > V2
> > 	Converted to dts-v1 format.
> > 	Changed to match a newer reference design.
> >
> >  arch/powerpc/boot/dts/virtex440-ml507.dts |  296
+++++++++++++++++++++++++++++
> >  1 files changed, 296 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/powerpc/boot/dts/virtex440-ml507.dts
> >
> > diff --git a/arch/powerpc/boot/dts/virtex440-ml507.dts
b/arch/powerpc/boot/dts/virtex440-ml507.dts
> > new file mode 100644
> > index 0000000..d10a993
> > --- /dev/null
> > +++ b/arch/powerpc/boot/dts/virtex440-ml507.dts
> > @@ -0,0 +1,296 @@
> > +/*
> > + * This file supports the Xilinx ML507 board with the 440
processor.
> > + * A reference design for the FPGA is provided at
http://git.xilinx.com.
> > + *
> > + * (C) Copyright 2008 Xilinx, Inc.
> > + *
> > + * This file is licensed under the terms of the GNU General Public
License
> > + * version 2. This program is licensed "as is" without any warranty
of any
> > + * kind, whether express or implied.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +	#address-cells =3D <1>;
> > +	#size-cells =3D <1>;
> > +	compatible =3D "xlnx,virtex440";
> > +	dcr-parent =3D <&ppc440_0>;
> > +	model =3D "testing";
> > +	DDR2_SDRAM: memory@0 {
> > +		device_type =3D "memory";
> > +		reg =3D < 0 0x10000000 >;
> > +	} ;
> > +	chosen {
> > +		bootargs =3D "console=3DttyS0 ip=3Don root=3D/dev/ram";
> =

> Bootargs like this should not typically go in the dts file.
> =


My understanding is the bootloader would also fill these in.
With the FGPA, a bootloader is not used many times so that's the =

reason we have put it into the dts file.

> > +		linux,stdout-path =3D "/plb@0/serial@83e00000";
> > +	} ;
> > +	cpus {
> > +		#address-cells =3D <1>;
> > +		#cpus =3D <1>;
> > +		#size-cells =3D <0>;
> > +		ppc440_0: cpu@0 {
> > +			clock-frequency =3D "";
> =

> Presumably this is supposed to be filled in by the bootloader.  But in
> any case it shouldn't be a string.
> =


I think this was my screw-up as it should have the same value as the
timebase. =

Interesting, it's not being used for anything that stops the system from
working.

> [snip]
> > +			DMA0: sdma@80 {
> > +				compatible =3D "xlnx,ll-dma-1.00.a";
> > +				dcr-reg =3D < 0x80 0x11 >;
> > +				interrupt-parent =3D <&xps_intc_0>;
> > +				interrupts =3D < 9 2 0xa 2 >;
> > +			} ;
> =

> Putting devices under the cpu node is certainly... atypical.  It's not
> obviously wrong, for a dcr device like this, but we probably want a
> little more discussion before establishing a convention like this.
> =


We had this discussion somewhat in a earlier message, 6/23 adding
virtex5 =

Powerpc 440 support, and Stephen answered with the following which still
seems
applicable.

>From Stephenn:

In Virtex 5 FX, the processor block (as represented in all the processor
design tools) is actually a processor block, plus a crossbar switch,
plus dma blocks.  I think there's a tradeoff between modeling this
independently, or modeling it as an FPGA user sees it.  From the
perspective of the FPGA user, this is the way the system looks (although
I agree that it's odd).   What would be even better, is if the processor
block was modeled as a DTS I could write by hand, and to include it into
the generated DTS.  (Another good use for grafting of device trees...)


> --
> David Gibson			| I'll have my music baroque, and my
code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT
_the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

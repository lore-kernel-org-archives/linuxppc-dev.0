Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id E5FEDDDE04
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Apr 2007 01:14:05 +1000 (EST)
Message-ID: <3d1001c776cb$e157de85$0a154e40@exch011.intermedia.net>
Content-Type: text/plain;
	charset="utf-8"
MIME-Version: 1.0
From: "Leonid" <Leonid@a-k-a.net>
Subject: RE: Using Linux 2.6.19 with Xilinx ML405
Date: Wed, 4 Apr 2007 08:15:15 -0700
To: "Peter Korsgaard" <jacmet@sunsite.dk>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Take a look in 2.6.20 kernel - it's said to be supporting uartlite - u =
can port it back to 2.6.19.

-----Original Message-----
From: "Peter Korsgaard" <jacmet@sunsite.dk>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Sent: 4/4/07 6:33 AM
Subject: Re: Using Linux 2.6.19 with Xilinx ML405

>>>>> "PM" =3D=3D Peter Mendham <petermendham@computing.dundee.ac.uk> =
writes:

Hi,

PM> Brilliant!  Thanks.  The code your patch produces expects there to
PM> be an 8250 compatible UART around.  What happens if I only have a
PM> UARTlite?  What do I need to fill in to a platform_device
PM> structure for a UARTlite?

Something like:

static struct resource myboarduartlite_resources[] =3D {
	[0] =3D {
		.start  =3D 0xa1000003,
		.end    =3D 0xa1000012,
		.flags  =3D IORESOURCE_MEM,
	},
	[1] =3D {
		.start	=3D 2,
		.end	=3D 2,
		.flags	=3D IORESOURCE_IRQ,
	},
};

static struct platform_device myboard_uartlite =3D {
	.name			=3D "uartlite",
	.id			=3D 0,
	.num_resources		=3D ARRAY_SIZE(myboarduartlite_resources),
	.resource		=3D myboarduartlite_resources,
};

static struct platform_device *myboard_devices[] __initdata =3D {
	..
	&myboard_uartlite,
        ..
};

static int __init
myboard_platform_add_devices(void)
{
	return platform_add_devices(myboard_devices,
                ARRAY_SIZE(myboard_devices));

}
arch_initcall(myboard_platform_add_devices);

Notice the +3 for the base address as the registers are accessed using
8bit I/O.

PM> I have just moved to 2.6.20 kernel in the hope of using the
PM> mainline uartlite driver - was this a stupid thing to do?

Not if you ask me ;)

PM> Do you know if I can use it for early serial in the same way as an
PM> 8250?

Unfortunately not. I started working on some patches for this some
months ago, but got stalled doing other stuff. I doubt it will get
integrated before the move to arch/powerpc.

--=20
Bye, Peter Korsgaard
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 22594DE11E
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 09:14:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: of_serial vs legacy serial support with powerpc arch on 405
Date: Tue, 11 Mar 2008 15:14:45 -0700
In-Reply-To: <20080311170255.4866e51a@zod.rchland.ibm.com>
References: <20080311150430.153AD3D8066@mail134-sin.bigfish.com>
	<20080311170255.4866e51a@zod.rchland.ibm.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>, "John Linn" <linnj@xilinx.com>
Message-Id: <20080311221442.986F719B004D@mail119-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Josh,

Specifically, we're trying to get console on of_serial, but there
doesn't seem to be any code to register a console, except in
legacy_serial?  But legacy_serial doesn't implement the offsets
necessary for the Xilinx uart16550 cores.  Does it seem reasonable to
add code to of_serial.c to register consoles, or is there something else
we're missing here?

Steve

> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of =
Josh
Boyer
> Sent: Tuesday, March 11, 2008 3:03 PM
> To: John Linn
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: of_serial vs legacy serial support with powerpc arch on
405
>=20
> On Tue, 11 Mar 2008 09:04:27 -0600
> "John Linn" <John.Linn@xilinx.com> wrote:
>=20
> > I've searched and found some threads, but it's still not clear to
me.
> > I'm working on 405 with powerpc and trying to get UART550 working.
>=20
> Walnut works.  So do Halakeau and Kilauea.  Is your serial port
> significantly different from those?
>=20
> > I know that I need speed, freq, and reg-shift properties in the
device
> > tree and I have found patches for of_serial.c.
>=20
> Patches for of_serial.c for what?
>=20
> > I still don't understand when to use of_serial.c
(SERIAL_OF_PLATFORM) vs
> > the legacy support for serial ports.  Is there any docs that I'm not
> > finding that I should read?
>=20
> There are no docs.  At one time, of_serial was declared as the one
true
> serial driver, but these days either will do.  The benefit of
> legacy_serial is that output is enabled earlier in the boot.
>=20
> > I don't see a way to configure in the legacy support, but I'm using
> > SERIAL_OF and having problems. I don't see the console getting
enabled
> > even though it found the serial port driver.
>=20
> You need to have CONFIG_PPC_UDBG_16550 set to bring in legacy_serial.
>=20
> josh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

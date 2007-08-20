Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 19E57DDF26
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 03:50:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx Virtex4 FX PPC
Date: Mon, 20 Aug 2007 10:50:00 -0700
In-Reply-To: <1187630817.6336.34.camel@PisteOff>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Robert Woodworth" <rwoodworth@securics.com>,
	"Josh Boyer" <jwboyer@jdub.homelinux.org>
Message-Id: <20070820175008.9A4AA670056@mail113-blu.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Note that you should pick one or the other and be consistent.

If you have MATH_EMULATION
in the kernel and use code compiled partly with and partly without
soft-fp,
then you get really strange errors, because (I believe) the soft-fp uses
a different mechanism for emulating the floating point register files
than
the kernel  (I suppose you'll also see the same thing in a system with
floating
point unit and a mixed-up compilation as well).

Steve

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> =20
> [mailto:linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@oz
labs.org] On Behalf Of Robert Woodworth
> Sent: Monday, August 20, 2007 10:27 AM
> To: Josh Boyer
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Xilinx Virtex4 FX PPC
>=20
> On Mon, 2007-08-20 at 11:35 -0500, Josh Boyer wrote:
> > On Mon, 20 Aug 2007 10:00:54 -0600
> > Robert Woodworth <rwoodworth@securics.com> wrote:
> >=20
> > > Problem 2:  Build my own rootfs.
> > > If I try to build my own programs (busybox and bash at=20
> this point) with
> > > shared libc using the same glibc from my toolchain, I get=20
> an "Illegal
> > > instruction" error.  Is my glibc not compatible with my=20
> Xilinx PPC 405??
> > >=20
> > >=20
> > > If I try to build a rootfs with debian ppc packages I=20
> have the same
> > > "Illegal instruction" error.
> > >=20
> > >=20
> > >=20
> > > Question 1:
> > > Do I need a special glibc for the Xilinx PPC 405???? =20
> > > Does a normal PPC glibc have more "advanced" instructions=20
> compiled in
> > > that will not work on a Xilinx PPC 405??
> >=20
> > Make sure you're building glibc with soft-fp, or make sure you have
> > CONFIG_MATH_EMULATION enabled in your kernel.  The PPC 405=20
> doesn't have
> > an FPU.
> >=20
> > josh
>=20
>=20
> CONFIG_MATH_EMULATION fixed it!!
>=20
>=20
>=20
> What are the opinions out there?=20
> Kernel fp or glibc soft-fp??
>=20
> I don't have a need for floating point in my final application anyway.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

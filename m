Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8E94CDE1FA
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 04:31:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/7] bootwrapper: Add a firmware-independent "raw" target.
Date: Fri, 14 Dec 2007 09:31:31 -0800
In-Reply-To: <f7eb0ae3da29213720e6b0049deca335@bga.com>
References: <20071213234221.B0BC27D0054@mail142-sin.bigfish.com>
	<f7eb0ae3da29213720e6b0049deca335@bga.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Milton Miller" <miltonm@bga.com>
Message-Id: <20071214172953.BC577F90059@mail151-sin.bigfish.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Milton Miller [mailto:miltonm@bga.com]=20
> Sent: Friday, December 14, 2007 12:06 AM
> To: Stephen Neuendorffer
> Cc: ppcdev; Grant Likely
> Subject: Re: [PATCH 1/7] bootwrapper: Add a=20
> firmware-independent "raw" target.
>=20
> On Fri Dec 14 10:43:27 EST 2007,  Stephen Neuendorffer wrote:
>=20
> > From: Grant Likely <grant.likely at secretlab.ca>
> >
> > This target produces a flat binary rather than an ELF file,
> > fixes the entry point at the beginning of the image, and takes
> > a complete device tree with no fixups needed.
> >
> > The device tree must have labels on /#address-cells, the timebase
> > frequency, and the memory size.
> >
> > Signed-off-by: Grant Likely <grant.likely at secretlab.ca>
> > ---
>=20
>=20
> You indicated in the intro in 0/ that this was not ready, and you=20
> didn't include your own s-o-b, but you did not put any statements to=20
> that effect in the header.  The intro is not copied into patchwork,=20
> which maintainers often use when deciding what to push.

Sorry... Still trying to figure out the process.

> Now on to why this should not be merged:
>=20
> In addition to the above, it changes the build rules.  It tries to=20
> change wrapper to assemble the .dtb into a .o from a .S file, but=20
> doesn't set any flags to force the assembler into the right mode.  In=20
> contrast the linker is controlled by the .lds linker script.
>=20
> In addition, the requirement for assembly labels can easily be=20
> eliminated.  As mentioned above, they are used for 3=20
> properties.  With=20
> the existing library (in 2.6.24 and earlier), call simple_malloc_init=20
> with a small bss array (like BSS_STACK does to allocate stack), and=20
> then read the properties out of the device tree.  At that point, call=20
> simple_malloc_init a second time using the found memory size.   As I=20
> said the last time this was posted, my patches to boot from kexec=20
> implemented this strategy.
>=20
> However, with the new libfdt, which is already in for-2.6.25,=20
> we should=20
> no longer need malloc() to simple read the tree.   At least that is=20
> what was advertised.

Yes, I agree, I just haven't had a chance to go back and write that code
yet...

Thanks for the comments,
Steve

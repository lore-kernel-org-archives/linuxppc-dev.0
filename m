Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail134-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 27655DDE18
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 12:28:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: current ARCH=powerpc for v2pro.
Date: Mon, 3 Dec 2007 17:28:08 -0800
In-Reply-To: <20071204004843.8B5FB1C20046@mail6-sin.bigfish.com>
References: <20071130222205.73E79A68013@mail72-blu.bigfish.com><fa686aa40711302239u56a264ddyaaad454bc00bb4dd@mail.gmail.com>
	<20071204004843.8B5FB1C20046@mail6-sin.bigfish.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20071204012811.AD70CEF004D@mail134-dub.bigfish.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hmm...  This code (from arch/ppc/boot/simple/embed_config.c) appears to
help:

	static const unsigned long line_size =3D 32;
	static const unsigned long congruence_classes =3D 256;
	unsigned long addr;
	unsigned long dccr;

	/*
	 * Invalidate the data cache if the data cache is turned off.
	 * - The 405 core does not invalidate the data cache on power-up
	 *   or reset but does turn off the data cache. We cannot assume
	 *   that the cache contents are valid.
	 * - If the data cache is turned on this must have been done by
	 *   a bootloader and we assume that the cache contents are
	 *   valid.
	 */
	__asm__("mfdccr %0": "=3Dr" (dccr));
	if (dccr =3D=3D 0) {
		for (addr =3D 0;
		     addr < (congruence_classes * line_size);
		     addr +=3D line_size) {
			__asm__("dccci 0,%0": :"b"(addr));
		}
	}

Although, I'm not sure why that should be virtex specific.

Steve=20

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> =20
> [mailto:linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@oz
> labs.org] On Behalf Of Stephen Neuendorffer
> Sent: Monday, December 03, 2007 4:49 PM
> To: Grant Likely
> Cc: linuxppc-embedded
> Subject: RE: current ARCH=3Dpowerpc for v2pro.
>=20
> I tried that, which essentially differed from what I was=20
> trying in that
> interrupts were turned off.
> It fails in the same way as before.
>=20
> I've booted ARCH=3Dppc from your tree on the exact same hardware =
design,
> and as near as I can tell, the code that runs in the kernel=20
> proper up to
> the point where I see the machine check is almost identical.
>=20
> The machine check (a trap into the Machine Check handler at 0x200)
> occurs at a nondeterministic point during the execution of=20
> memset_io in
> early_init.
>=20
> In the kernel I have, _bss_start is c02c8000, and these are the
> registers in the trap handler on two different runs of the kernel:
>=20
>     r3: c02c80cc r5: 00022874
>     r3: c02c8248 r5: 000226f4
>=20
> r3 is the current point being initialized, and r5 is the=20
> count remaining
> in the .bss.
>=20
> So, what would cause a machine check in the middle of a loop, in the
> middle of the almost the simplest code absolutely possible, and not on
> an obvious memory boundary?
>=20
> Steve
>=20
> > -----Original Message-----
> > From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> > Behalf Of Grant Likely
> > Sent: Friday, November 30, 2007 10:40 PM
> > To: Stephen Neuendorffer
> > Cc: linuxppc-embedded
> > Subject: Re: current ARCH=3Dpowerpc for v2pro.
> >=20
> > On 11/30/07, Stephen Neuendorffer=20
> > <stephen.neuendorffer@xilinx.com> wrote:
> > >
> > > Grant,
> > >
> > > I'm trying to bring up your arch/powerpc work, using a compiled in
> > > device tree.  I added this:
> > >
> > <snip>
> > >
> > > Which seems bizarre, because that code is very simple. =20
> I'm guessing
> > > that something in the memory configuration is wierd (or maybe
> > > zImage.virtex is not the right way to do this?) but I'm a=20
> > little lost
> > > where to look from here.  I also tried it with both=20
> > paulus_master and
> > > your virtex-for-2.6.24 branch.
> >=20
> >=20
> > I've got a patch that adds 'raw' image support (originally=20
> written by
> > Scott Wood) which somewhat works for booting (but not entirely; I
> > haven't had time to dig into it properly yet).  It's not suitable to
> > go into mainline yet.  I'll try to get the patch out to my tree this
> > evening... actually I've been trying to get my tree pushed out all
> > today, but other things keep coming up.  :-)
> >=20
> > <several hours after I wrote the above>
> >=20
> > Okay, I pushed my current patch set out to the master branch of my
> > linux-2.6-virtex tree.  Give it a whirl.  It's not perfect, but it
> > should be usable for booting.
> >=20
> > Cheers,
> > g.
> >=20
> > --=20
> > Grant Likely, B.Sc., P.Eng.
> > Secret Lab Technologies Ltd.
> > grant.likely@secretlab.ca
> > (403) 399-0195
> >=20
> >=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

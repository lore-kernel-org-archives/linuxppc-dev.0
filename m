Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5AE97DDFC6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 11:50:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: current ARCH=powerpc for v2pro.
Date: Mon, 3 Dec 2007 16:48:48 -0800
In-Reply-To: <fa686aa40711302239u56a264ddyaaad454bc00bb4dd@mail.gmail.com>
References: <20071130222205.73E79A68013@mail72-blu.bigfish.com>
	<fa686aa40711302239u56a264ddyaaad454bc00bb4dd@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20071204004843.8B5FB1C20046@mail6-sin.bigfish.com>
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

I tried that, which essentially differed from what I was trying in that
interrupts were turned off.
It fails in the same way as before.

I've booted ARCH=3Dppc from your tree on the exact same hardware design,
and as near as I can tell, the code that runs in the kernel proper up to
the point where I see the machine check is almost identical.

The machine check (a trap into the Machine Check handler at 0x200)
occurs at a nondeterministic point during the execution of memset_io in
early_init.

In the kernel I have, _bss_start is c02c8000, and these are the
registers in the trap handler on two different runs of the kernel:

    r3: c02c80cc r5: 00022874
    r3: c02c8248 r5: 000226f4

r3 is the current point being initialized, and r5 is the count remaining
in the .bss.

So, what would cause a machine check in the middle of a loop, in the
middle of the almost the simplest code absolutely possible, and not on
an obvious memory boundary?

Steve

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> Behalf Of Grant Likely
> Sent: Friday, November 30, 2007 10:40 PM
> To: Stephen Neuendorffer
> Cc: linuxppc-embedded
> Subject: Re: current ARCH=3Dpowerpc for v2pro.
>=20
> On 11/30/07, Stephen Neuendorffer=20
> <stephen.neuendorffer@xilinx.com> wrote:
> >
> > Grant,
> >
> > I'm trying to bring up your arch/powerpc work, using a compiled in
> > device tree.  I added this:
> >
> <snip>
> >
> > Which seems bizarre, because that code is very simple.  I'm guessing
> > that something in the memory configuration is wierd (or maybe
> > zImage.virtex is not the right way to do this?) but I'm a=20
> little lost
> > where to look from here.  I also tried it with both=20
> paulus_master and
> > your virtex-for-2.6.24 branch.
>=20
>=20
> I've got a patch that adds 'raw' image support (originally written by
> Scott Wood) which somewhat works for booting (but not entirely; I
> haven't had time to dig into it properly yet).  It's not suitable to
> go into mainline yet.  I'll try to get the patch out to my tree this
> evening... actually I've been trying to get my tree pushed out all
> today, but other things keep coming up.  :-)
>=20
> <several hours after I wrote the above>
>=20
> Okay, I pushed my current patch set out to the master branch of my
> linux-2.6-virtex tree.  Give it a whirl.  It's not perfect, but it
> should be usable for booting.
>=20
> Cheers,
> g.
>=20
> --=20
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>=20
>=20

Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 34BADDDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 04:28:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx devicetrees
Date: Wed, 28 Nov 2007 09:28:09 -0800
In-Reply-To: <474CBBDE.9010007@itee.uq.edu.au>
References: <47480CF0.7090105@dlasys.net><fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com><20071125052459.DA8B1EE805F@mail70-blu.bigfish.com><4749425C.5060207@dlasys.net><20071125181506.EE2041BA004F@mail141-cpk.bigfish.com><474CAE70.3030005@itee.uq.edu.au><20071128002835.068BE16A005D@mail198-sin.bigfish.com>
	<474CBBDE.9010007@itee.uq.edu.au>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "John Williams" <jwilliams@itee.uq.edu.au>
Message-Id: <20071128172713.AA7D835004D@mail53-sin.bigfish.com>
Cc: Michal Simek <simekm2@fel.cvut.cz>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> =20
> [mailto:linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@oz
labs.org] On Behalf Of John Williams
> Sent: Tuesday, November 27, 2007 4:53 PM
> To: Stephen Neuendorffer
> Cc: Michal Simek; linuxppc-embedded
> Subject: Re: Xilinx devicetrees
>=20
> Stephen Neuendorffer wrote:
>=20
> >>From: John Williams [mailto:jwilliams@itee.uq.edu.au]=20
>=20
> >>MicroBlaze is a highly configurable CPU in terms of its=20
> >>instruction set,=20
> >>features and so on.  To make use of this, it is essential that each=20
> >>kernel image be compiled to match the CPU configuration.  While a=20
> >>generic kernel, making use of no features (MUL, DIV, Shift,=20
> >>MSR ops etc)=20
> >>would run on any CPU, performance would be abysmal.
> >=20
> > I think the userspace is actually much more critical than=20
> the kernel for
> > most of these things (with the exception of msrset/msrclr, and the
> > barrel shifter perhaps).  Unfortunately, even if you implement an
> > alternatives-style mechanism for the kernel, you're still hosed for
> > userspace. =20
>=20
> I haven't benchmarks each option on the kernel - you are right that=20
> shift is a big one, but mul I think is also important, given=20
> that every=20
> array access generates an integer multiply,

Good point.

>=20
> Once I a big enough system, it's just unfeasible to
> > recompile everything anyway.  I think this is where=20
> autoconfig starts to
> > break down.
>=20
> I'm not sure I agree, here, given that most people building=20
> MicroBlaze=20
> systems are doing so with uClinux-dist (or PetaLinux), you=20
> can do a full=20
> rebuilt, kernel libs apps, in a couple of minutes.  Much shorter than=20
> sythnesis and P&R, that's for sure (and runtime is linear in size,=20
> unlike P&R :)

Let's not bash the P&R guys too much...  You try working on a problem
that is known to be insolvable, and where no matter how many people you
make happier, you'll always get bashed by the guy whose design no longer
meets timing. :)

> > It's not nice, I agree.  I think the key principle should be that I
> > should be able to get a system working as quickly as possible, and I
> > might optimize things later.  One thing that device trees=20
> will allow is
> > for *all* the drivers to get compiled in to the kernel, and=20
> only as a
> > late stage operation does a designer need to start throwing=20
> things away.
> > Using traps I can easily start with a 'kitchen sink'=20
> design, and start
> > discarding processor features, relying on the traps.  When I get low
> > enough down on the performance curve, I can uas an autoconfig-type
> > mechanism to regain a little of what I lost by optimizing=20
> away the trap
> > overhead.=20
>=20
> OK, but now we have a kernel dependent on *3* files - a DTS, a=20
> Kconfig.auto, and (indirectly) the bitstream itself.

The kernel might be generated from them, but it is not *dependent* on
them.  The same kernel can run on other hardware, with other dts's.  If
there was a traps mechanism (or alternatives), then it could also run on
other designs with different processor features.

> Another thing I suggested to Michal recently, perhaps we need=20
> kernel/lib/libof to store common OF / DT handling code.  Much better=20
> than duplicating it accross microblaze and PPC, and maybe=20
> other arch's=20
> would also see the light..  That would also add a claim for=20
> the DTC to=20
> go in scripts/

There's some shared code in 2.6.24-rc in drivers/of.  Now that things
are settling down in terms of bugs, I'll probably transition to pushing
a 2.6.24-rc branch soon.  However, the few brief conversations I've had
suggest that what microblaze might need or want has very little
influence until it is visible in mainline.  Once that happens, I think
it will be easy to justify putting code like libfdt and some of the
kernel of/dt code in a common place. =20

So, John: would you care to make a goal (for say 2.6.25 or 26) of
working with me to get the microblaze into mainline?  I think the
community exists to keep things maintained, but I'm guessing that it
would help to have an existing LKMLer or two take a look over the code.
Given the move towards device trees, getting someone from powerpc would
seem to be natural.  Anybody interested?

Steve

Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EA5D5DDE29
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 11:56:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ml310 kernel2.6 booting problems 
Date: Fri, 18 Jan 2008 16:35:16 -0800
In-Reply-To: <200801190011.m0J0BCtr001286@rsass-homer.uncc.edu>
References: <169c03cb0801171849i59d35893hda44a7f0c5417b58@mail.gmail.com>
	<200801190011.m0J0BCtr001286@rsass-homer.uncc.edu>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Ron Sass" <rsass@uncc.edu>,
	"Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Message-Id: <20080119003518.25AC41CF8068@mail125-dub.bigfish.com>
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


Ron,

It might be better to start with the kernel from git.xilinx.com, which
already has an ML41x option.  The current version of EDK will also
generate support for ML410 with the PCI driver, if you are still using a
2.6.10-era kernel. =20

I've refrained putting the PCI stuff on git.xilinx.com, because any
non-trivial usage of it that I've tried has generated warnings.  On top
of that, the code has some interrupt values hardcoded in the ALI
southbridge code.  Since there is no way to have this code pushed into
mainline, I'm not terribly interested in encouraging any work on it,
either.  Perhaps since there is so much interest in this code, someone
would like to get it working in ARCH=3Dpowerpc?  I'm happy to provide =
some
handholding to get someone started.

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Ron Sass
> Sent: Friday, January 18, 2008 4:11 PM
> To: Jean-Samuel Chenard
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: ml310 kernel2.6 booting problems
>=20
>=20
> Hello All,
>=20
> I have a sidewise question related to this thread.  We have
> several ML-310 and ML-410 boards.  At some point, we may need
> PCI but right now it is not urgent so I am not ready to invest
> a lot of time yet either.  I imagine that 2.6 + PCI would be
> relatively similiar for both ML-310 and ML-410...
>=20
> My question is this:  Would it make sense to have a Kernel
> configuration something like "VIRTEX_PCI" and a platforms
> "XILINX_ML4xx" / "XILINX_ML3xx" ... or create four platforms:
>=20
>   XILINX_ML300
>   XILINX_ML310
>   XILINX_ML40x
>   XILINX_ML410
>=20
> I ask now because we are working on some device drivers for
> the ML410 that may work on 40x and I wondering if I should
> introduce a new ML410 platform option...
>=20
> Ron
>=20
> > > Date: Thu, 17 Jan 2008 21:19:04 +0100
> > > From: Joachim Meyer
> > > Hmmm... I'm not really ready to invest that much time into the PCI
for ML=3D
> > -310.
> > >
------------------------------------------------------------------------
-=3D
> > -------
> > >
http://ozlabs.org/pipermail/linuxppc-embedded/2007-December/029211.html
> > >
> > > How much work would it be (approximated), and do you think I can
success =3D
> > (I'm a novice, like you know)?
> > > Would you help me (Tell me where to start & what to do)?
> >
> > Hi Joachim,
> >
> > I was also interested in getting the PCI to run on the ML-310.  I
did
> > spend an evening trying to integrate a patch sent over by Stephen
> > Neuendorffer from Xilinx.  I managed to get everything to compile
> > (basically I fixed a few missing macros and had to search a bit to
> > ensure that the memory mapping was correctly ported).
Unfortunately,
> > when I tried the new kernel, I think that I must have messed
something
> > up with the interrupt mappings (I am a newbie to PCI) and I had to
> > remove some interrupt mapping from Stephen's patch.
> >
> > In any case, my ML-310 was booting the Linux kernel, but something
was
> > not right and I did not get anymore printouts from the UART Lite.
> > Since I don't have the JTAG cable, I was stuck at this point with
> > little means to debug the system.  One day I'll spoil myself with
one
> > of those platform JTAG USB cables...
> >
> > I used Z-modem to transfer files to/from my workstation to my CF
card
> > on the ML-310 and this was an acceptable compromise.
> >
> > I'd still be interested in having the PCI bus working on the ML-310,
> > but now that I got my BEE2 booting Linux 2.6, its not such a big
> > priority for me.  Let me know if you have some success in that
> > direction.
> >
> > Regards,
> >
> > Jean-Samuel
> > -- =3D
> >
> > Integrated Microsystems Laboratory
> > McGill University, Montr=3DE9al, QC, CANADA
> > Web Page: http://chaos.ece.mcgill.ca
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

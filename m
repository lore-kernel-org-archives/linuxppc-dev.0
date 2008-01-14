Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail36-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F03AFDDF93
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Jan 2008 08:10:08 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Problem booting Linux 2.6 on Virtex-4
Date: Mon, 14 Jan 2008 13:09:52 -0800
In-Reply-To: <440abda90801141211m52bd0a3bk67014c6df2bf406c@mail.gmail.com>
References: <440abda90801132112y76f2899by4ef582c9b58fd6b6@mail.gmail.com><62D97388-4D65-4B40-A0D1-847963FF0A16@upb.de>
	<440abda90801141211m52bd0a3bk67014c6df2bf406c@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "David Baird" <dhbaird@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080114210954.AC436CF8050@mail36-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What kernel version are you targeting? Are you using arch/powerpc or =
arch/ppc?  V4 has a data cache errata, which isn't currently in mainline =
arch/powerpc.

        if((mfpvr() & 0xfffff000) =3D=3D 0x20011000) {
            /* PPC errata 213: only for Virtex-4 FX */
            __asm__("mfccr0  0\n\t"
                    "oris    0,0,0x50000000@h\n\t"
                    "mtccr0  0"
                    : : : "0");
        }

Steve

> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of David =
Baird
> Sent: Monday, January 14, 2008 12:12 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: Problem booting Linux 2.6 on Virtex-4
>=20
> On Jan 14, 2008 1:37 AM, Enno L=FCbbers <enno.luebbers@upb.de> wrote:
> > Hello David,
> >
> > Am 14.01.2008 um 06:12 schrieb David Baird:
> >
> > > I'm having trouble with getting Linux to boot farther than =
early_init.
> > > [...]
> > > So, I experimented further and discovered that different memory
> > > regions seem to be aliased on to each other every 2*32*256 bytes.
> >
> >
> > This sounds either like a wrong programming of an BRx/ORx memory
> > controller register pair (which, AFAIK, the PPC405 does not have), =
or
> > like a messed up address map in EDK. My guess is that an optimized/
> > sloppy implementation of the address decoder for some peripheral in =
an
> > EDK system could produce something like you described; or there's a
> > block RAM that's attached to a controller in the wrong way; or the
> > bank/address parameters of the DDR controller don't match the =
physical
> > setup... there's a lot that can go wrong obviously on a configurable
> > SoC.
>=20
> What has been confusing me is that I am unable to reproduce the
> problem in real mode.  I can only reproduce the problem in virtual
> mode.  This leads me to believe, perhaps mistakenly, that the hardware
> is implemented okay.  OTOH, neither can I see anything wrong with the
> software.
>=20
> > Can you be more specific about your hardware platform? Is this a
> > reference design? What board are you using?
>=20
> I am currently testing code on the ML403 evaluation board.  I used the
> Base System Builder in EDK to create the hardware design and DDR SDRAM
> is being used as the main RAM starting at address 0x00000000 and also
> with OCM BRAM mapped at the very end of the address space (so that
> 0xfffffffc can contain code to execute on startup).
>=20
> I am now trying to experiment with the hardware and see if I can find
> a hardware reference design.  I will let you know what I figure out.
>=20
> -David
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

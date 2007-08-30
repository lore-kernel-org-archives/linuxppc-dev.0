Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 19966DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Aug 2007 02:07:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx Virtex boot (And MPMC)
Date: Thu, 30 Aug 2007 09:07:21 -0700
In-Reply-To: <1188485072.8717.42.camel@PisteOff>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Robert Woodworth" <rwoodworth@securics.com>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20070830160733.A8FDC39808B@mail11-fra.bigfish.com>
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


The MPMC would almost certainly be a better option here...

Steve

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> =20
> [mailto:linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@oz
labs.org] On Behalf Of Robert Woodworth
> Sent: Thursday, August 30, 2007 7:45 AM
> To: Grant Likely
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Xilinx Virtex boot
>=20
> On Wed, 2007-08-29 at 18:29 -0600, Grant Likely wrote:
> > On 8/29/07, Robert Woodworth <rwoodworth@securics.com> wrote:
> > > I'm trying to port Linux to a new Virtex Platform.  The=20
> kernel will not
> > > uncompress, I get the following on the console:
> > >
> > > loaded at:     00400000 004FB19C
> > > board data at: 004F9120 004F919C
> > > relocated to:  00404054 004040D0
> > > zimage at:     00404E50 004F8409
> > > avail ram:     004FC000 04000000
> > >
> > > Linux/PPC load: console=3DttyUL root=3D/dev/xsa2
> > > Uncompressing Linux...
> > > zlib_inflateInit2 returned 00506530
> > > exit
> > >
> > > Any ideas what causes this error??
> > > Is something mis-configured on my EDK project?
> > >
> >=20
> > Possibly, do you know that EDK has your ram is configured correctly
> > (ie. have you run a memory test application)?
>=20
> Yes, I ran the sample memory test application that EDK builds
> automatically.  It ran fine.
>=20
> The fact that the above prints on the console, tells me that the
> zImage.elf is getting loaded at the correct start location=20
> and that its
> partly executing.
>=20
> What is the return code that I'm seeing??  I have been unable=20
> to figure
> that out from the source yet.
>=20
>=20
> > >
> > > I have 64MB DDR on the OPB *not* the PLB.
> > > Is that a problem??
> >=20
> > It shouldn't be the problem, but why are you doing that?
>=20
> We are building an image-processing application inside the FPGA.  The
> application is very memory intensive.  I have been told that the PPC
> always has priority on the PLB and that if I want to have my=20
> FPGA module
> have priority on memory, that I should place the memory and my FPGA
> module on the OPB.  Yes, this can significantly slow down the PPC, but
> in my case the PPC is only used for UI and networking.
>=20
> I will actually build in *two* OPBs one for the memory + my module and
> the second for the other peripherals.=20
>=20
>=20
> Woody.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

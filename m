Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail175-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BB31ADDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 08:56:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx devicetrees
Date: Mon, 26 Nov 2007 13:55:18 -0800
In-Reply-To: <474B37C9.8020405@dlasystems.com>
References: <47480CF0.7090105@dlasys.net>	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>	<47493D4F.4070605@dlasys.net><fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com><4749FD5E.7000408@dlasys.net>
	<20071125235855.95B9999804D@mail138-cpk.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333F0A58E4@XMBIL132.northgrum.com>
	<474B37C9.8020405@dlasystems.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "David H. Lynch Jr." <dhlii@dlasystems.com>,
	"Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
Message-Id: <20071126215615.73F4B1138066@mail175-dub.bigfish.com>
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

=20

> -----Original Message-----
> From: David H. Lynch Jr. [mailto:dhlii@dlasystems.com]=20
> Sent: Monday, November 26, 2007 1:17 PM
> To: Koss, Mike (Mission Systems)
> Cc: Stephen Neuendorffer; Grant Likely; linuxppc-embedded
> Subject: Re: Xilinx devicetrees
>=20
> Koss, Mike (Mission Systems) wrote:
> > Time for my $.02, since I am heavily weighting my future=20
> designs on the
> > use of the device trees. :) (and b/c I don't check my work=20
> e-mail from
> > home ;P)
> >
> > ________________________________
> >
> > From: Stephen Neuendorffer [mailto:stephen.neuendorffer@xilinx.com]=20
> > Sent: Sunday, November 25, 2007 6:59 PM
> > To: David H. Lynch Jr.; Grant Likely; linuxppc-embedded
> > Subject: RE: Xilinx devicetrees
> >
> >
>=20
> >
> > SN> I don't understand the 'burden on software developers'.=20
>  The code to
> > do this will just be standard code. =20
>     I got 16K of RAM for my boot loader and that 16K has to=20
> do alot more
> than just manage device trees.
>     I think we have 2K left. In that I have to fit scripting, and
> ethernet, so where am I supposed to fit the standard code ?
>     If the devicetree is say at the end of the bit file I can probably
> copy it to ram and pass a pointer to linux in maybe a couple=20
> of hundred
> bytes.
>     If I have to do much more it ain't happening.

Personally, It sounds like you're trying to do to much...  The only
thing that that code really needs to do is to find the 'real' boot code:
Maybe Uboot stored in flash? :)  I'm not naive enough to suggest that I
understand all the constraints of your system, but it is another
solution.

> > The worst that one can say is:
> > SN> 1) I need several KB additional non volatile storage.  Given the
> > size of the FPGA bitstream, this can't be a huge constraint.
> >  =20
>        Several KB is NOT happening. The bitstream is in=20
> flash. Flash is
> not a limited reasorce for  us.
>        FPGA cells, and BRAM are precious as gold. The more we use the
> less our clients have.

Device tree should probably be stored in flash, in your case....

> >
> > SN> Certainly..  But in a sense, these are all intermediate=20
> files on the
> > path to the image on the board.
>     Unless we are going to teach linux to read and interpret=20
> .bit files
> while loading, then devicetrees are intermediate in an entirely
> different sense.
>     The hardware works fine regardless of whether their is a=20
> devicetree.
> But Linux may not boot.

I think this philosphy really minimized the value of software...  The
hardware doesn't work unless the software that comes with it *also*
works. :)

>      My objective is to get alot of software - linux, GHS, and
> standalone apps, to all load - from a single executables, accross
> multiple different bit images on several different (though=20
> deliberately
> similar) products. My Linux kernel needs to work regardless=20
> of the Pico
> card and regardless of the bit image, as done my GHS kernel, and ....
> And I need to do that in a severly resource constrained environment.
>     I would hope that should make sense of my harping about
> version/capabilities registers. If I have maybe 10 possible=20
> peices of IP
> that may/maynot be present in a given FPGA and I am trying to
> dynamically configure - Linux/GHS/... to adapt to whatever it=20
> encounters
> and work as long as it is a viable combination. At best=20
> devicetrees are
> an extremly complex way of solving that - while version=20
> registers are a
> trivial way.

It sounds like the real problem that you have is that even if you get
device trees working for Linux, you still have the same problem for GHS,
so from your perspective "device trees don't help"

Steve

Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A3974DEDF8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 May 2008 02:13:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: arch/powerpc, Xilinx, and mainline kernel support
Date: Fri, 23 May 2008 09:13:14 -0700
In-reply-to: <EDAE140DF1B2FC42B5867C22CA0B333FFA5C22@XMBIL132.northgrum.com>
References: <EDAE140DF1B2FC42B5867C22CA0B333FFA5C0B@XMBIL132.northgrum.com>
	<fa686aa40805161526ie184ae6m29a3fc78d6676720@mail.gmail.com>
	<20080516223422.C02A26B006F@mail34-dub.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333FFA5C22@XMBIL132.northgrum.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080523161316.7627978062@mail63-va3.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Grant, could you post explicit instructions about how to build the
simpleImage?  I tried it too and couldn't get the makefile rules to
match my dts.

Mike, Supporting mpmc2 for memory access only is pretty straightforward,
but supporting the temac/sdma connections is more problematic,
particularly since we have no plans to update the plb_temac driver for
ARCH=3Dpowerpc.

Steve

> -----Original Message-----
> From: Koss, Mike (Mission Systems) [mailto:mike.koss@ngc.com]
> Sent: Friday, May 23, 2008 8:09 AM
> To: Stephen Neuendorffer; Grant Likely
> Cc: linuxppc-embedded@ozlabs.org
> Subject: RE: arch/powerpc, Xilinx, and mainline kernel support
> =

> So yesterday, we got a chance to checkout Linus' main (2.26.26-rc3)
and
> it appears to not have all the necessary updates to build for the
> Generic Xilinx Virtex either.
> =

> For now, I've decided to work from the Xilinx git-tree.
> =

> We also gave the EDK bsp->dts generator a spin, and I have a comment
on
> it: documentation. It would be nice to have some kind of simple README
> that explains what it is and what it supports. The current README
talks
> about using the old python script. I fired up the bsp against my EDK
9.1
> MPMC(2) based system and it bombed out when it reached the MPMC2
> definition. So I dug through the tcl and found it that it was only
> supporting the MPMC3.
> =

> I'm still working on my EDK 9.2 MPMC3 system, so I can't check to see
if
> that works or not, yet.
> =

> -- Mike
> =

> -----Original Message-----
> From: Stephen Neuendorffer [mailto:stephen.neuendorffer@xilinx.com]
> Sent: Friday, May 16, 2008 6:34 PM
> To: Grant Likely; Koss, Mike (Mission Systems)
> Cc: linuxppc-embedded@ozlabs.org
> Subject: RE: arch/powerpc, Xilinx, and mainline kernel support
> =

> =

> =

> > -----Original Message-----
> > From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
> [mailto:linuxppc-embedded-
> > bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Grant
> Likely
> > Sent: Friday, May 16, 2008 3:27 PM
> > To: Koss, Mike (Mission Systems)
> > Cc: linuxppc-embedded@ozlabs.org
> > Subject: Re: arch/powerpc, Xilinx, and mainline kernel support
> >
> > On Fri, May 16, 2008 at 4:06 PM, Koss, Mike (Mission Systems)
> > <mike.koss@ngc.com> wrote:
> > > Is there any reason why the mainline 2.6.25.3 (and from what I
could
> see .4)
> > > is missing the files to build for the Xilinx Virtex platform?
> > >
> > > Or in other words, I tried to build from 2.6.25.3 for the Xilinx
> Virtex
> > > under arch/powerpc (because arch/ppc actually crashes when once
apps
> start
> > > to run) and it failed when trying to actually create the zImage. I
> hopped
> > > over to Xilinx's git server and noticed a bunch of missing entries
> in the
> > > boot/Makefile and source code to actually support the complete
image
> build
> > > for a Xilinx Virtex PPC405.
> > >
> > > When is the Xilinx Virtex support going to be mainline official? I
> need to
> > > be able to grab a stable kernel and work from there rather than
> using the
> > > latest -rc that Xilinx is hosting on their git server.
> >
> > Working on it.  Biggest problem is getting the device drivers in
> > shape.  However, other than Ethernet support, current arch/powerpc
> > (head of Linus' tree, not 2.6.25) should work for building virtex
> > kernels.
> =

> Mike,
> =

> What is your objection to using what is in the git tree, because it is
> based on 24-rc8 and not 25, or something more fundamental?
> =

> Steve
> =

> =

> This email and any attachments are intended for the sole use of the
> named recipient(s) and contain(s) confidential information that may be
> proprietary, privileged or copyrighted under applicable law. If you
are
> not the intended recipient, do not read, copy, or forward this email
> message or any attachments. Delete this email message and any
> attachments immediately.
> =

> =



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

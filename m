Return-Path: <mike.koss@ngc.com>
Received: from xmrm0101.northgrum.com (xmrm0101.northgrum.com
	[155.104.240.104]) by ozlabs.org (Postfix) with ESMTP id 3E7EBDE074
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 May 2008 03:13:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: arch/powerpc, Xilinx, and mainline kernel support
Date: Fri, 23 May 2008 12:13:21 -0500
Message-ID: <EDAE140DF1B2FC42B5867C22CA0B333FFA5C23@XMBIL132.northgrum.com>
In-Reply-To: <20080523165213.C4798191004D@mail152-sin.bigfish.com>
References: <EDAE140DF1B2FC42B5867C22CA0B333FFA5C0B@XMBIL132.northgrum.com><fa686aa40805161526ie184ae6m29a3fc78d6676720@mail.gmail.com><20080516223422.C02A26B006F@mail34-dub.bigfish.com>
	<EDAE140DF1B2FC42B5867C22CA0B333FFA5C22@XMBIL132.northgrum.com>
	<20080523165213.C4798191004D@mail152-sin.bigfish.com>
From: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>
To: "John Linn" <John.Linn@xilinx.com>,
	"Stephen Neuendorffer" <stephenn@xilinx.com>,
	"Grant Likely" <grant.likely@secretlab.ca>
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

Yeah, I wasn't saying "hey! We need to support old/deprecated cores!".
Rather I was stating that it would be nice to know which cores are
supported currently: SystemACE, MPMC3/4, XPS_LL_TEMAC, SDMA, etc. Just
so this sort of thing doesn't happen again to the next person who tries
it. If I get time this weekend, I may try and extract that information
from the tcl and post a patch for the README.

-----Original Message-----
From: John Linn [mailto:John.Linn@xilinx.com]=20
Sent: Friday, May 23, 2008 12:52 PM
To: Koss, Mike (Mission Systems); Stephen Neuendorffer; Grant Likely
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: arch/powerpc, Xilinx, and mainline kernel support

Hi Mike,

Thanks for the input, sounds right to me, we'll put it on the list of
things to do.

In general we will be testing our work on the current version of the
Xilinx tools and not maintaining them for all versions of the Xilinx
tools, but we need a way to spell that out cleanly.

Thanks,
John

-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of Koss, Mike (Mission Systems)
Sent: Friday, May 23, 2008 9:09 AM
To: Stephen Neuendorffer; Grant Likely
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: arch/powerpc, Xilinx, and mainline kernel support

So yesterday, we got a chance to checkout Linus' main (2.26.26-rc3) and
it appears to not have all the necessary updates to build for the
Generic Xilinx Virtex either.

For now, I've decided to work from the Xilinx git-tree.

We also gave the EDK bsp->dts generator a spin, and I have a comment on
it: documentation. It would be nice to have some kind of simple README
that explains what it is and what it supports. The current README talks
about using the old python script. I fired up the bsp against my EDK 9.1
MPMC(2) based system and it bombed out when it reached the MPMC2
definition. So I dug through the tcl and found it that it was only
supporting the MPMC3.

I'm still working on my EDK 9.2 MPMC3 system, so I can't check to see if
that works or not, yet.

-- Mike

-----Original Message-----
From: Stephen Neuendorffer [mailto:stephen.neuendorffer@xilinx.com]
Sent: Friday, May 16, 2008 6:34 PM
To: Grant Likely; Koss, Mike (Mission Systems)
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: arch/powerpc, Xilinx, and mainline kernel support



> -----Original Message-----
> From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+stephen=3Dneuendorffer.name@ozlabs.org] On Behalf Of Grant
Likely
> Sent: Friday, May 16, 2008 3:27 PM
> To: Koss, Mike (Mission Systems)
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: arch/powerpc, Xilinx, and mainline kernel support
>=20
> On Fri, May 16, 2008 at 4:06 PM, Koss, Mike (Mission Systems)=20
> <mike.koss@ngc.com> wrote:
> > Is there any reason why the mainline 2.6.25.3 (and from what I could
see .4)
> > is missing the files to build for the Xilinx Virtex platform?
> >
> > Or in other words, I tried to build from 2.6.25.3 for the Xilinx
Virtex
> > under arch/powerpc (because arch/ppc actually crashes when once apps
start
> > to run) and it failed when trying to actually create the zImage. I
hopped
> > over to Xilinx's git server and noticed a bunch of missing entries
in the
> > boot/Makefile and source code to actually support the complete image
build
> > for a Xilinx Virtex PPC405.
> >
> > When is the Xilinx Virtex support going to be mainline official? I
need to
> > be able to grab a stable kernel and work from there rather than
using the
> > latest -rc that Xilinx is hosting on their git server.
>=20
> Working on it.  Biggest problem is getting the device drivers in=20
> shape.  However, other than Ethernet support, current arch/powerpc=20
> (head of Linus' tree, not 2.6.25) should work for building virtex=20
> kernels.

Mike,

What is your objection to using what is in the git tree, because it is
based on 24-rc8 and not 25, or something more fundamental?

Steve


This email and any attachments are intended for the sole use of the
named recipient(s) and contain(s) confidential information that may be
proprietary, privileged or copyrighted under applicable law. If you are
not the intended recipient, do not read, copy, or forward this email
message or any attachments. Delete this email message and any
attachments immediately.


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the
named recipient(s) and contain(s) confidential information that may be
proprietary, privileged or copyrighted under applicable law. If you are
not the intended recipient, do not read, copy, or forward this email
message or any attachments. Delete this email message and any
attachments immediately.

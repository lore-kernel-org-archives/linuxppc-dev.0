Return-Path: <john.bonesio@xilinx.com>
Received: from outbound3-red-R.bigfish.com (outbound-red.frontbridge.com
	[216.148.222.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 22A1367A3F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 03:04:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Ethernet driver for Linux kernel 2.6 running on ML403
Date: Thu, 14 Sep 2006 09:40:53 -0700
Message-ID: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA645@XSJ-EXCHVS1.xlnx.xilinx.com>
From: "John Bonesio" <john.bonesio@xilinx.com>
To: "Keith J Outwater" <kjoutwater@raytheon.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I just saw this thread. The next version of EDK 8.2.2 will have a temac
v3.00a driver for linux 2.6. Our plan is to begin our code freeze stage
tomorrow. If people really need the driver right away, and can't wait a
few weeks for the release, I could possibly provide a patch (or use some
other distribution method) for the driver.
=20
Here at Xilinx, we have been in talks about having our drivers more
readily available in the open source repositories. As far as I know,
everyone seems to think that this would be a good thing for us. Right
now the plan is to have a 3rd party check our drivers into the main
repository as we have limited resources here. (Basically we're up to our
eyeballs in work right now.)

I do know that Xilinx would rather play a principle role in developing
and maintaining these open source drivers, rather than having a separate
group go off and implement a separate set.

<< Same complaints apply for Xilinx drivers in the U-Boot bootloader.
It is proving very difficult to get Xilinx code into U-Boot which means
BSPs that use the code are hard to get submitted as well.>>

I've only touched on U-Boot a little bit. Have any thoughts on how to
make this easier?

<< The Xilinx approach of overwriting the source tree just feels wrong,
and
no one seems to want to do it that way.>>

I am in the group that has control over how this is done. What would you
propose be done different? Keep in mind that we are trying to support a
process where someone builds a hardware design and the later changes it
with new peripherals or perhaps makes minor tweaks. We want to make the
updating of the Linux kernel to reflect these hardware changes easy for
people.

Having the ability to make rapid hardware changes, I think, is a bit
different from what most folks are used to.

Cheers,

- John

-----Original Message-----
From: linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org] On
Behalf Of Keith J Outwater
Sent: Thursday, September 14, 2006 9:48 AM
To: linuxppc-embedded@ozlabs.org
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403

Grant,
You bring up excellent points, and I am having to deal with these
issues in my 2.4.x kernel and U-Boot ports to VirtexII Pro FPGAs
as well.

> On 9/14/06, Michael Galassi <mgalassi@c-cor.com> wrote:
> > It is also worth noting that as released in MVL pro 4.0.1 it only
> > supports hard_temac 1.00.a and plb_temac 2.00.a, both of which are
> > tagged as deprecated in the current version (8.2.01i) of Xilinx's
> > EDK. The current version of {plb,hard}_temac (3.00.a) goes to great
> > lengths to break compatibility with older versions.  This will
> > presumably be fixed next month when it is rumored that wonderful new
> > things will come from Xilinx.  In the mean-time it is possible,
though
> > neither simple, nor fun, to create Virtex4 designs with the older
IP.

I think the general case is that Xilinx IP will be constantly evolving,=20
and
Xilinx driver code, when released under the GPL, will appear
sporadically.
Maybe it's best to resign ourselves to the fact that this situation
probably won't change, and then try to deal with it in a way that does
not depend so heavily on Xilinx drivers.

>=20
> So what direction do we (as the community) want to go for supporting
> Xilinx IP in the Linux kernel?

I don't know about anyone else, but running Linux on Virtex FPGAs is
something I simply have to be able to do.  With or without Xilinx
drivers, I think the kernel needs to support Xilinx hardware.

>=20
> IIRC, Xilinx intends to get drivers submitted into mainline.  (Based
> on their cross-platform driver support code).  It is unknown which and
> how many drivers for different IP versions will be submitted.

That's part of the problem: we seem to get support for some
IP cores, but not all.  Xilinx takes a piecemeal approach
to releasing drivers under the GPL.

>=20
> However, the xilinx driver code is verbose and does not match well
> with the rest of the Linux code base.  (due to the cross platform
> support)  Plus, the Xilinx tool work flow is geared towards the EDK
> tool overwriting the driver code in the kernel tree with code for the
> generated design.  In which case, does it even make sense to accept
> Xilinx drivers into the Linux tree when they are just going to get
> overwritten by the toolchain anyway?  Unfortunately, regenerating
> drivers has it's own problems considering that the license on the
> generated code is not GPL compatible at the moment.

Same complaints apply for Xilinx drivers in the U-Boot bootloader.
It is proving very difficult to get Xilinx code into U-Boot which means
BSPs that use the code are hard to get submitted as well.

The Xilinx approach of overwriting the source tree just feels wrong, and
no one seems to want to do it that way.

>=20
> If we reject the Xilinx driver code, then we either have to do without
> Xilinx support in mainline, or we need to write new drivers that
> address the above issues (support multiple IP versions, etc).  The
> Xilinx support in mainline right now does not use any Xilinx code.
> (Xilinx PIC and UART).
>=20
> Thoughts?

As painful as it may be, maybe we just write drivers from scratch and
try to track changes in the IP.

Regards,
Keith Outwater
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

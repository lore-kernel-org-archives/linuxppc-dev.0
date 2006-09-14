Return-Path: <john.bonesio@xilinx.com>
Received: from outbound1-red-R.bigfish.com (outbound-red.frontbridge.com
	[216.148.222.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 209A467B56
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 03:52:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Ethernet driver for Linux kernel 2.6 running on ML403
Date: Thu, 14 Sep 2006 10:52:16 -0700
Message-ID: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA6FA@XSJ-EXCHVS1.xlnx.xilinx.com>
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

More comments below...

-----Original Message-----
From: linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org] On
Behalf Of Keith J Outwater
Sent: Thursday, September 14, 2006 11:36 AM
To: linuxppc-embedded@ozlabs.org
Subject: RE: Ethernet driver for Linux kernel 2.6 running on ML403

> Hi,
>=20
> I just saw this thread. The next version of EDK 8.2.2 will have a
temac
> v3.00a driver for linux 2.6. Our plan is to begin our code freeze
stage
> tomorrow. If people really need the driver right away, and can't wait
a
> few weeks for the release, I could possibly provide a patch (or use
some
> other distribution method) for the driver.
>=20
> Here at Xilinx, we have been in talks about having our drivers more
> readily available in the open source repositories. As far as I know,
> everyone seems to think that this would be a good thing for us. Right
> now the plan is to have a 3rd party check our drivers into the main
> repository as we have limited resources here. (Basically we're up to
our
> eyeballs in work right now.)

I know that MontaVista is you preferred Linux partner - if they do the
released, then we have to wait for them.  If individual designers can
get the driver sources, you can bet it will make it's way into the
mainline kernel.

>=20
> I do know that Xilinx would rather play a principle role in developing
> and maintaining these open source drivers, rather than having a
separate
> group go off and implement a separate set.

You may end up having to serve multiple customer bases then, to keep
things from forking.  The are lots of us who want to have lots of
fine-grained control over our source trees and the way in which we do=20
builds.

[John]
One thing that may help you, is that you can clear out the 'target_dir'
setting in xps. That will let you generate the BSP and then simply copy
over the files you need.

>=20
> << Same complaints apply for Xilinx drivers in the U-Boot bootloader.
> It is proving very difficult to get Xilinx code into U-Boot which
means
> BSPs that use the code are hard to get submitted as well.>>
>=20
> I've only touched on U-Boot a little bit. Have any thoughts on how to
> make this easier?

My perspective on this is that of a hardware designer who also develops
code.  I understand that is a good thing from the Xilinx point of view
to make it as easy as possible for designers to develop designs using
EDK with automatic BSP generation.  It's great for
doing stand alone (no OS) designs or to get "instant gratification"
as in "gee, I just booted Linux!" (a la Xilinx XAPP765).
When you do that, though, invariably
you end up having to make decisions that constrain how the design flow
works for the user and then it's hard for the user to deviate from that=20
flow.
For example, the idea of having a user auto-generate source code for a
BSP
that overwrites the bootloader or kernel source tree.  The problem
is that it's hard to "take the training wheels off" if I want or need
to have a stable source base of if I want to use the mainline kernel
or the mainline bootloader (U-Boot).  What if the source code bases
for the kernel or bootloader get re-arranged?

What I'd really like to have is "out of the box"
kernel support for all the
primary peripheral devices like communications and interface stuff
and U-Boot support for those devices as well.  I don't want to
have to generate BSPs and overwrite the source trees.

[John]
See my comment above.

The whole licensing thing is another issue.  As I stated to someone
else at Xilinx: These are just drivers, not the crown jewels. GPL it
all and make it easier for designers to incorporate the code into
open source projects.  Dual license if you have customers who have
to have things locked up.

[John]
I believe this is our intention going forward.

For U-Boot, I'm getting push-back from the maintainer on the
size and "verbosity" of the code.  Sounds like this might be an
issue for the kernel as well.

>=20
> << The Xilinx approach of overwriting the source tree just feels
wrong,
> and
> no one seems to want to do it that way.>>
>=20
> I am in the group that has control over how this is done. What would
you
> propose be done different? Keep in mind that we are trying to support
a
> process where someone builds a hardware design and the later changes
it
> with new peripherals or perhaps makes minor tweaks. We want to make
the
> updating of the Linux kernel to reflect these hardware changes easy
for
> people.

A noble goal, and clearly the right thing to do from a user-success
point
of view, but do the hardware peripherals (i.e. the IP cores) change that

much?
See my comment below: Can you create a system that allows software
drivers
to verify that they (the drivers) are compatible with a particular IP
version?  For the novice user, the "full auto" system probably works
fine, but for (some, at least) experienced users, it tends to be an
additional layer or complexity (or opacity) that would be nice to get
rid
of.

>=20
> Having the ability to make rapid hardware changes, I think, is a bit
> different from what most folks are used to.

I agree.  I think we all need to agree how best to manage the
driver code so that as IP versions change, the drivers can be properly
matched to the IP.  Also, as more and more people port Linux to their
Virtex designs, we can (hopefully) expect more "out of the box"
support for Xilinx hardware.  That's basically the situation you have
with more conventional peripheral devices.

[John]
Yep, we'd like this too.

I don't think that there are any "version" registers in the Xilinx=20
IP cores that a driver could check to determine compatibility.  That
would be very cheap to implement in hardware and you could then
develop more universal drivers.

[John]
We've examined doing this in the past, and gotten some push back due to
the use of bram or other resources. Conceptually, it's a great idea, I
just don't know if this is likely to happen any time soon.

>=20
> Cheers,
>=20
> - John
>=20
> -----Original Message-----
> From: linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+jbonesio=3Dxilinx.com@ozlabs.org] On
> Behalf Of Keith J Outwater
> Sent: Thursday, September 14, 2006 9:48 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
>=20
> Grant,
> You bring up excellent points, and I am having to deal with these
> issues in my 2.4.x kernel and U-Boot ports to VirtexII Pro FPGAs
> as well.
>=20
> > On 9/14/06, Michael Galassi <mgalassi@c-cor.com> wrote:
> > > It is also worth noting that as released in MVL pro 4.0.1 it only
> > > supports hard_temac 1.00.a and plb_temac 2.00.a, both of which are
> > > tagged as deprecated in the current version (8.2.01i) of Xilinx's
> > > EDK. The current version of {plb,hard}_temac (3.00.a) goes to
great
> > > lengths to break compatibility with older versions.  This will
> > > presumably be fixed next month when it is rumored that wonderful
new
> > > things will come from Xilinx.  In the mean-time it is possible,
> though
> > > neither simple, nor fun, to create Virtex4 designs with the older
> IP.
>=20
> I think the general case is that Xilinx IP will be constantly
evolving,=20
> and
> Xilinx driver code, when released under the GPL, will appear
> sporadically.
> Maybe it's best to resign ourselves to the fact that this situation
> probably won't change, and then try to deal with it in a way that does
> not depend so heavily on Xilinx drivers.
>=20
> >=20
> > So what direction do we (as the community) want to go for supporting
> > Xilinx IP in the Linux kernel?
>=20
> I don't know about anyone else, but running Linux on Virtex FPGAs is
> something I simply have to be able to do.  With or without Xilinx
> drivers, I think the kernel needs to support Xilinx hardware.
>=20
> >=20
> > IIRC, Xilinx intends to get drivers submitted into mainline.  (Based
> > on their cross-platform driver support code).  It is unknown which
and
> > how many drivers for different IP versions will be submitted.
>=20
> That's part of the problem: we seem to get support for some
> IP cores, but not all.  Xilinx takes a piecemeal approach
> to releasing drivers under the GPL.
>=20
> >=20
> > However, the xilinx driver code is verbose and does not match well
> > with the rest of the Linux code base.  (due to the cross platform
> > support)  Plus, the Xilinx tool work flow is geared towards the EDK
> > tool overwriting the driver code in the kernel tree with code for
the
> > generated design.  In which case, does it even make sense to accept
> > Xilinx drivers into the Linux tree when they are just going to get
> > overwritten by the toolchain anyway?  Unfortunately, regenerating
> > drivers has it's own problems considering that the license on the
> > generated code is not GPL compatible at the moment.
>=20
> Same complaints apply for Xilinx drivers in the U-Boot bootloader.
> It is proving very difficult to get Xilinx code into U-Boot which
means
> BSPs that use the code are hard to get submitted as well.
>=20
> The Xilinx approach of overwriting the source tree just feels wrong,
and
> no one seems to want to do it that way.
>=20
> >=20
> > If we reject the Xilinx driver code, then we either have to do
without
> > Xilinx support in mainline, or we need to write new drivers that
> > address the above issues (support multiple IP versions, etc).  The
> > Xilinx support in mainline right now does not use any Xilinx code.
> > (Xilinx PIC and UART).
> >=20
> > Thoughts?
>=20
> As painful as it may be, maybe we just write drivers from scratch and
> try to track changes in the IP.
>=20
> Regards,
> Keith Outwater
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

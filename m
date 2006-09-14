Return-Path: <kjoutwater@raytheon.com>
Received: from tus-mailout1.raytheon.com (tus-mailout1.raytheon.com
	[199.46.245.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tus-mailout1.raytheon.com",
	Issuer "Entrust.net Secure Server Certification Authority" (not
	verified)) by ozlabs.org (Postfix) with ESMTP id 04AA567B59
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 03:36:25 +1000 (EST)
Received: from dmoutt00.directory.ray.com (dmoutt00.directory.ray.com
	[147.25.154.125])
	by tus-mailout1.raytheon.com (Switch-3.2.4/Switch-3.2.4) with ESMTP id
	k8EHaIdP019546
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Sep 2006 17:36:19 GMT
Received: from dmsmtpt00.directory.ray.com (dmsmtpt00.directory.ray.com
	[147.25.154.118])
	by dmoutt00.directory.ray.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id
	k8EHaJ3i013140
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 17:36:20 GMT
Received: from tu2-msg04.rsc.raytheon.com (tu2-msg04.RSC.RAYTHEON.COM
	[147.24.232.105])
	by dmsmtpt00.directory.ray.com (8.12.11/8.12.11) with ESMTP id
	k8EHaHad028372
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 17:36:17 GMT
In-Reply-To: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA645@XSJ-EXCHVS1.xlnx.xilinx.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: RE: Ethernet driver for Linux kernel 2.6 running on ML403
From: Keith J Outwater <kjoutwater@raytheon.com>
Message-ID: <OF1385C39A.BEB9B9E6-ON072571E9.005DAC98-072571E9.0060ABAE@mck.us.ray.com>
Date: Thu, 14 Sep 2006 10:36:11 -0700
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Hi,
> 
> I just saw this thread. The next version of EDK 8.2.2 will have a temac
> v3.00a driver for linux 2.6. Our plan is to begin our code freeze stage
> tomorrow. If people really need the driver right away, and can't wait a
> few weeks for the release, I could possibly provide a patch (or use some
> other distribution method) for the driver.
> 
> Here at Xilinx, we have been in talks about having our drivers more
> readily available in the open source repositories. As far as I know,
> everyone seems to think that this would be a good thing for us. Right
> now the plan is to have a 3rd party check our drivers into the main
> repository as we have limited resources here. (Basically we're up to our
> eyeballs in work right now.)

I know that MontaVista is you preferred Linux partner - if they do the
released, then we have to wait for them.  If individual designers can
get the driver sources, you can bet it will make it's way into the
mainline kernel.

> 
> I do know that Xilinx would rather play a principle role in developing
> and maintaining these open source drivers, rather than having a separate
> group go off and implement a separate set.

You may end up having to serve multiple customer bases then, to keep
things from forking.  The are lots of us who want to have lots of
fine-grained control over our source trees and the way in which we do 
builds.

> 
> << Same complaints apply for Xilinx drivers in the U-Boot bootloader.
> It is proving very difficult to get Xilinx code into U-Boot which means
> BSPs that use the code are hard to get submitted as well.>>
> 
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
works for the user and then it's hard for the user to deviate from that 
flow.
For example, the idea of having a user auto-generate source code for a BSP
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

The whole licensing thing is another issue.  As I stated to someone
else at Xilinx: These are just drivers, not the crown jewels. GPL it
all and make it easier for designers to incorporate the code into
open source projects.  Dual license if you have customers who have
to have things locked up.

For U-Boot, I'm getting push-back from the maintainer on the
size and "verbosity" of the code.  Sounds like this might be an
issue for the kernel as well.

> 
> << The Xilinx approach of overwriting the source tree just feels wrong,
> and
> no one seems to want to do it that way.>>
> 
> I am in the group that has control over how this is done. What would you
> propose be done different? Keep in mind that we are trying to support a
> process where someone builds a hardware design and the later changes it
> with new peripherals or perhaps makes minor tweaks. We want to make the
> updating of the Linux kernel to reflect these hardware changes easy for
> people.

A noble goal, and clearly the right thing to do from a user-success point
of view, but do the hardware peripherals (i.e. the IP cores) change that 
much?
See my comment below: Can you create a system that allows software drivers
to verify that they (the drivers) are compatible with a particular IP
version?  For the novice user, the "full auto" system probably works
fine, but for (some, at least) experienced users, it tends to be an
additional layer or complexity (or opacity) that would be nice to get rid
of.

> 
> Having the ability to make rapid hardware changes, I think, is a bit
> different from what most folks are used to.

I agree.  I think we all need to agree how best to manage the
driver code so that as IP versions change, the drivers can be properly
matched to the IP.  Also, as more and more people port Linux to their
Virtex designs, we can (hopefully) expect more "out of the box"
support for Xilinx hardware.  That's basically the situation you have
with more conventional peripheral devices.

I don't think that there are any "version" registers in the Xilinx 
IP cores that a driver could check to determine compatibility.  That
would be very cheap to implement in hardware and you could then
develop more universal drivers.

> 
> Cheers,
> 
> - John
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+jbonesio=xilinx.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+jbonesio=xilinx.com@ozlabs.org] On
> Behalf Of Keith J Outwater
> Sent: Thursday, September 14, 2006 9:48 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
> 
> Grant,
> You bring up excellent points, and I am having to deal with these
> issues in my 2.4.x kernel and U-Boot ports to VirtexII Pro FPGAs
> as well.
> 
> > On 9/14/06, Michael Galassi <mgalassi@c-cor.com> wrote:
> > > It is also worth noting that as released in MVL pro 4.0.1 it only
> > > supports hard_temac 1.00.a and plb_temac 2.00.a, both of which are
> > > tagged as deprecated in the current version (8.2.01i) of Xilinx's
> > > EDK. The current version of {plb,hard}_temac (3.00.a) goes to great
> > > lengths to break compatibility with older versions.  This will
> > > presumably be fixed next month when it is rumored that wonderful new
> > > things will come from Xilinx.  In the mean-time it is possible,
> though
> > > neither simple, nor fun, to create Virtex4 designs with the older
> IP.
> 
> I think the general case is that Xilinx IP will be constantly evolving, 
> and
> Xilinx driver code, when released under the GPL, will appear
> sporadically.
> Maybe it's best to resign ourselves to the fact that this situation
> probably won't change, and then try to deal with it in a way that does
> not depend so heavily on Xilinx drivers.
> 
> > 
> > So what direction do we (as the community) want to go for supporting
> > Xilinx IP in the Linux kernel?
> 
> I don't know about anyone else, but running Linux on Virtex FPGAs is
> something I simply have to be able to do.  With or without Xilinx
> drivers, I think the kernel needs to support Xilinx hardware.
> 
> > 
> > IIRC, Xilinx intends to get drivers submitted into mainline.  (Based
> > on their cross-platform driver support code).  It is unknown which and
> > how many drivers for different IP versions will be submitted.
> 
> That's part of the problem: we seem to get support for some
> IP cores, but not all.  Xilinx takes a piecemeal approach
> to releasing drivers under the GPL.
> 
> > 
> > However, the xilinx driver code is verbose and does not match well
> > with the rest of the Linux code base.  (due to the cross platform
> > support)  Plus, the Xilinx tool work flow is geared towards the EDK
> > tool overwriting the driver code in the kernel tree with code for the
> > generated design.  In which case, does it even make sense to accept
> > Xilinx drivers into the Linux tree when they are just going to get
> > overwritten by the toolchain anyway?  Unfortunately, regenerating
> > drivers has it's own problems considering that the license on the
> > generated code is not GPL compatible at the moment.
> 
> Same complaints apply for Xilinx drivers in the U-Boot bootloader.
> It is proving very difficult to get Xilinx code into U-Boot which means
> BSPs that use the code are hard to get submitted as well.
> 
> The Xilinx approach of overwriting the source tree just feels wrong, and
> no one seems to want to do it that way.
> 
> > 
> > If we reject the Xilinx driver code, then we either have to do without
> > Xilinx support in mainline, or we need to write new drivers that
> > address the above issues (support multiple IP versions, etc).  The
> > Xilinx support in mainline right now does not use any Xilinx code.
> > (Xilinx PIC and UART).
> > 
> > Thoughts?
> 
> As painful as it may be, maybe we just write drivers from scratch and
> try to track changes in the IP.
> 
> Regards,
> Keith Outwater
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

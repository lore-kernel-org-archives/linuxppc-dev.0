Return-Path: <kjoutwater@raytheon.com>
Received: from tus-mailout1.raytheon.com (tus-mailout1.raytheon.com
	[199.46.245.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tus-mailout1.raytheon.com",
	Issuer "Entrust.net Secure Server Certification Authority" (not
	verified)) by ozlabs.org (Postfix) with ESMTP id AC76D67B22
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 01:48:10 +1000 (EST)
Received: from dmoutt00.directory.ray.com (dmoutt00.directory.ray.com
	[147.25.154.125])
	by tus-mailout1.raytheon.com (Switch-3.2.4/Switch-3.2.4) with ESMTP id
	k8EFlu59008348
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Sep 2006 15:48:02 GMT
Received: from dmsmtpt00.directory.ray.com (dmsmtpt00.directory.ray.com
	[147.25.154.118])
	by dmoutt00.directory.ray.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id
	k8EFlwa9021852
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 15:48:04 GMT
Received: from tu2-msg04.rsc.raytheon.com (tu2-msg04.RSC.RAYTHEON.COM
	[147.24.232.105])
	by dmsmtpt00.directory.ray.com (8.12.11/8.12.11) with ESMTP id
	k8EFlqvf014636
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 15:47:53 GMT
In-Reply-To: <528646bc0609140734j2f7b008fy815f221677c5ac74@mail.gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
From: Keith J Outwater <kjoutwater@raytheon.com>
Message-ID: <OF4E2E74F4.771A25A6-ON072571E9.00554898-072571E9.0056BF13@mck.us.ray.com>
Date: Thu, 14 Sep 2006 08:47:47 -0700
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
> > things will come from Xilinx.  In the mean-time it is possible, though
> > neither simple, nor fun, to create Virtex4 designs with the older IP.

I think the general case is that Xilinx IP will be constantly evolving, 
and
Xilinx driver code, when released under the GPL, will appear sporadically.
Maybe it's best to resign ourselves to the fact that this situation
probably won't change, and then try to deal with it in a way that does
not depend so heavily on Xilinx drivers.

> 
> So what direction do we (as the community) want to go for supporting
> Xilinx IP in the Linux kernel?

I don't know about anyone else, but running Linux on Virtex FPGAs is
something I simply have to be able to do.  With or without Xilinx
drivers, I think the kernel needs to support Xilinx hardware.

> 
> IIRC, Xilinx intends to get drivers submitted into mainline.  (Based
> on their cross-platform driver support code).  It is unknown which and
> how many drivers for different IP versions will be submitted.

That's part of the problem: we seem to get support for some
IP cores, but not all.  Xilinx takes a piecemeal approach
to releasing drivers under the GPL.

> 
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

> 
> If we reject the Xilinx driver code, then we either have to do without
> Xilinx support in mainline, or we need to write new drivers that
> address the above issues (support multiple IP versions, etc).  The
> Xilinx support in mainline right now does not use any Xilinx code.
> (Xilinx PIC and UART).
> 
> Thoughts?

As painful as it may be, maybe we just write drivers from scratch and
try to track changes in the IP.

Regards,
Keith Outwater

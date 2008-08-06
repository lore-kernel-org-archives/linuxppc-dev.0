Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from WA4EHSOBE005.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id E124FDDF40
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 04:02:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: hang w/ppc6xx_defconfig related to 'simple-bus' compatible
Date: Wed, 6 Aug 2008 11:02:17 -0700
In-Reply-To: <20080806173547.GD3138@ld0162-tx32.am.freescale.net>
References: <F2163BC0-08A2-4C17-AAE7-C37BD0CA66EA@kernel.crashing.org><20080806134128.GA9533@secretlab.ca>
	<20080806173547.GD3138@ld0162-tx32.am.freescale.net>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Scott Wood" <scottwood@freescale.com>,
	<grant.likely@secretlab.ca>
Message-ID: <20080806180206.35FAB718066@mail214-wa4.bigfish.com>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The problem (in my case) is that the legacy-serial driver doesn't accept
all of the 16550 configurations accepted by the regular ns16550 driver.
The problem is not related to simple-bus, but only became visible when
simple-bus bindings are used because the legacy-serial driver
specifically looks for an ns16550 node contained by a simple-bus.

Most likely the hpcn_defconfig disables the legacy-serial driver
altogether.

Steve

> -----Original Message-----
> From: linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of Scott
Wood
> Sent: Wednesday, August 06, 2008 10:36 AM
> To: grant.likely@secretlab.ca
> Cc: ppc-dev list
> Subject: Re: hang w/ppc6xx_defconfig related to 'simple-bus'
compatible
> =

> On Wed, Aug 06, 2008 at 07:41:28AM -0600, Grant Likely wrote:
> > On Tue, Aug 05, 2008 at 08:21:31AM -0500, Kumar Gala wrote:
> > > I'm trying to get the ppc6xx_defconfig booting on any 8641
(74xx/e600)
> > > system.  If I remove the 'simple-bus' compatible from the soc node
in
> > > the .dts it works.  Otherwise it hangs at but and looks to be
crashed in
> > > the serial driver due to accessing memory at 0.
> > >
> > > I've tried the same .dts (w/'simple-bus') using the
> > > mpc8641_hpcn_defconfig and things work.
> >
> > The Xilinx folks hit something similar.  ns16550 nodes get matched
if
> > the parent claims simple-bus.  If extra stuff needs to be done to
use
> > that port, then bad things happen.
> =

> If extra stuff needs to be done, it shouldn't claim to be a
simple-bus.
> =

> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound1-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1168067C3B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 12:39:39 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Virtex device tree generator proof of concept
Date: Wed, 6 Dec 2006 16:19:41 -0800
Message-ID: <977C41F842E66D4CB2E41332313B615002F764BB@XSJ-EXCHVS1.xlnx.xilinx.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"linuxppc-dev list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yes please, send me your patches.
done.

> > I'm curious if you've heard of anyone using device trees=20
> other than at=20
> > boot time: for instance, using an incomplete device tree blob to=20
> > represent components discovered at runtime?  It looks like=20
> it should=20
> > be possible to rip out alot of the code from=20
> kernel/powerpc/prom.c in=20
> > recent kernels to parse incomplete device trees, too... =20
> Any thoughts?
>=20
> Possible, but there are probably better ways do deal with=20
> those; like just allocating and registering a platform=20
> device; or adding nodes to the existing tree.  If you're able=20
> to probe a device, then do you need to describe it with a=20
> device tree fragment?
>=20
> What scenario are you thinking about?

In an FPGA, even platform-bus devices don't necessarily exist at
processor boot time, and
they might change during the life of a system.
As you suggest, I plan to simply add the correct devices to the platform
bus at the correct time,
and I'm also trying to abstract the code that creates the platform
devices (which probably
should be part of a basic kernel device) from the information about
which devices actually exist.
There are probably other ways of doing this (for instance, automatically
generating the code for
a kernel module which adds devices to the platform bus), but a device
tree fragment=20
doesn't seem like too bad a way of doing it.

Steve

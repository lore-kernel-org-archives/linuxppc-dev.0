Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id A434EDDE09
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Sep 2007 05:34:53 +1000 (EST)
From: Rob Landley <rob@landley.net>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] qemu platform, v2
Date: Sat, 22 Sep 2007 14:16:20 -0500
References: <boot-8-00.miltonm@bga.com> <qemu-8-01.miltonm@bga.com>
	<20070922095546.GA14185@lst.de>
In-Reply-To: <20070922095546.GA14185@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709221416.21580.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 22 September 2007 4:55:46 am Christoph Hellwig wrote:
> On Fri, Sep 21, 2007 at 06:08:31PM -0500, Milton Miller wrote:
> > Here is the second rev of patches to boot a arch powerpc kernel on
> > qemu with the prep architecture.
>
> So if this is supposed to be prep why do you need additional kernel
> support?  And if you really needed why isn't it under platforms/prep?

The device tree provided by qemu's open hackware violates some of the 
assumptions the Linux kernel is making?  (Although things like "the cpu cache 
size is zero" are, technically speaking, probably correct. :)

There are three different problems here:

1) porting prep from arch=ppc to arch=powerpc so you can build it on an arch 
that also supports make headers_install.

2) PowerPC uses a device tree supplied by the hardware to identify the 
available hardware, even for stuff living on PCI busses which it could 
theoretically probe for but doesn't.

3) The PPC firmware qemu comes with ("Open Hackware") sucks rocks, is hard to 
modify, isn't quite being maintained.  As mentioned above, the device tree it 
passes in (including "prep residual data" from which more nodes in the device 
tree can be constructed, and here my understanding goes all fuzzy) does not 
make for a happy Linux kernel.

Proposed solutions to all this involve various combinations of creating a 
target platform aimed directly at qemu and not pretending to be prep at all 
(so it doesn't have to parse residual data), creating our own boot rom image 
out of some of the wrapper code the linux kernel's already got and feeding 
that to qemu instead of using open hackware at all, hard wiring a device tree 
into the kernel and not looking at the one open hackware passes in...)

I'd be following this more closely if compiling a device tree didn't currently 
require an external utility (dtc or some such) that doesn't come with the 
Linux kernel.  No other target platform I've built kernels for requires such 
an environmental dependency.  (This is a problem both for hardwiring the 
device tree into the kernel and for building a new boot rom from the linux 
kernel's ppc boot wrapper that would contain such a device tree to feed to 
the kernel.)

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.

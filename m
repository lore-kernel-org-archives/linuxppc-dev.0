Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id A91E4DDEE2
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 05:47:02 +1000 (EST)
Date: Wed, 8 Aug 2007 19:46:05 -0000
To: "Scott Wood" <scottwood@freescale.com>,
	"Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Subject: Re: pci in arch/powerpc vs arch/ppc
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Message-ID: <twig.1186602365.9125@inaccessnetworks.com>
In-Reply-To: <46BA1560.7090703@freescale.com>
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix> <op.twqvg3i0nhx3hy@phoenix>,
	<op.twqvg3i0nhx3hy@phoenix>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> said:

> Alexandros Kostopoulos wrote:
> > I've noticed the following: In function pci_process_bridge_OF_ranges, 
> > when  parsing the ranges for MEM and I/O space, the res->start for mem 
> > is  correctly set to ranges[na+2], which is the cpu address in the 
> > ranges  property. However, in I/O related code, res->start is set to 
> > ranges[2],  which is in the PCI address field of the ranges property 
> > (and in my case  is 0, as is also for the mpc8272ads case as well). 
> > Thus, the res->start of  the I/O of the bridge is 0, which leads to the 
> > first device with I/O space  (a davicom ethernet device) been also 
> > assigned a I/O region starting at 0.  Finally, the dmfe (davicom 
> > ethernet driver over PCI) fails with "dmfe: I/O  base is zero". So, is 
> > the implementation of pci_process_bridge_OF_ranges  correct ? shouldn't 
> > res->start = ranges[na+2] for I/O as well?
> 
> Ideally, yes -- but currently IO-space resources are relative to the 
> start of the primary bus's IO-space.
> 
> As a workaround, try not setting the primary flag when calling 
> pci_process_bridge_OF_ranges.  Note that this means that any legacy I/O 
> ports that may exist on cards you plug in (such as VGA cards) will not 
> be found.
> 
> The proper solution is probably to refuse pre-existing BARs that are 
> lower than PCIBIOS_MIN_IO, and/or provide a flag to tell the PCI layer 
> to completely ignore pre-existing BARs.

I was referring to the allocation of primary bus' IO space based on the 
device tree. I understand that IO-space resources are relative to the start 
of the primary bus' IO space. But I think the primary bus IO space allocation 
itself is broken. Let me explain with an example:

In mpc8272ads.dts, the ranges property for pci is:

ranges = <42000000 0 80000000 80000000 0 20000000
          02000000 0 a0000000 a0000000 0 20000000
          01000000 0 00000000 f6000000 0 02000000>;

The third obviously corresponds to IO space. So, shouldn't the res->start for 
the host bridge be set to f6000000 ? Because, currently, based on what I've 
described in my previous mail, it gets set to 0. It seems to me like a matter 
of incorrect parsing of the device tree from pci_process_bridge_OF_ranges() 
for IO space. Or am I missing something else here, and it should actually be 
0?

thanks

Alex

> 
> -Scott
> 



-- 

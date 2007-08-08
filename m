Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D2E8DDED6
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 05:11:42 +1000 (EST)
Message-ID: <46BA1560.7090703@freescale.com>
Date: Wed, 08 Aug 2007 14:11:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
Subject: Re: pci in arch/powerpc vs arch/ppc
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix> <op.twqvg3i0nhx3hy@phoenix>
In-Reply-To: <op.twqvg3i0nhx3hy@phoenix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexandros Kostopoulos wrote:
> I've noticed the following: In function pci_process_bridge_OF_ranges, 
> when  parsing the ranges for MEM and I/O space, the res->start for mem 
> is  correctly set to ranges[na+2], which is the cpu address in the 
> ranges  property. However, in I/O related code, res->start is set to 
> ranges[2],  which is in the PCI address field of the ranges property 
> (and in my case  is 0, as is also for the mpc8272ads case as well). 
> Thus, the res->start of  the I/O of the bridge is 0, which leads to the 
> first device with I/O space  (a davicom ethernet device) been also 
> assigned a I/O region starting at 0.  Finally, the dmfe (davicom 
> ethernet driver over PCI) fails with "dmfe: I/O  base is zero". So, is 
> the implementation of pci_process_bridge_OF_ranges  correct ? shouldn't 
> res->start = ranges[na+2] for I/O as well?

Ideally, yes -- but currently IO-space resources are relative to the 
start of the primary bus's IO-space.

As a workaround, try not setting the primary flag when calling 
pci_process_bridge_OF_ranges.  Note that this means that any legacy I/O 
ports that may exist on cards you plug in (such as VGA cards) will not 
be found.

The proper solution is probably to refuse pre-existing BARs that are 
lower than PCIBIOS_MIN_IO, and/or provide a flag to tell the PCI layer 
to completely ignore pre-existing BARs.

-Scott

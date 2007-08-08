Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E4ABDDE47
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 08:55:59 +1000 (EST)
Subject: Re: pci in arch/powerpc vs arch/ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexandros Kostopoulos <akostop@inaccessnetworks.com>
In-Reply-To: <op.twqvg3i0nhx3hy@phoenix>
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix>  <op.twqvg3i0nhx3hy@phoenix>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 08:55:47 +1000
Message-Id: <1186613748.938.205.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-08-08 at 17:21 +0300, Alexandros Kostopoulos wrote:
> I've noticed the following: In function pci_process_bridge_OF_ranges, when  
> parsing the ranges for MEM and I/O space, the res->start for mem is  
> correctly set to ranges[na+2], which is the cpu address in the ranges  
> property. However, in I/O related code, res->start is set to ranges[2],  
> which is in the PCI address field of the ranges property (and in my case  
> is 0, as is also for the mpc8272ads case as well). Thus, the res->start of  
> the I/O of the bridge is 0, which leads to the first device with I/O space  
> (a davicom ethernet device) been also assigned a I/O region starting at 0.  
> Finally, the dmfe (davicom ethernet driver over PCI) fails with "dmfe: I/O  
> base is zero". So, is the implementation of pci_process_bridge_OF_ranges  
> correct ? shouldn't res->start = ranges[na+2] for I/O as well?

The current code indeed assumes that IO space of a PCI host bridges starts
at 0 local always. We "fixed" that in the 64 bits variant but not the 32 bits
one (yet...).

Note that if we're going to fix it, we probably also need to change various
bits of resource fixup code as well that makes that assumption.

Might be worth trying making more of that stuff common between 32 and 64
bits (I hear the noise of people trying to get me merge the pci code .. :-)

Ben.

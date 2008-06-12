Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 63C6BDEB5D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jun 2008 08:14:34 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K6v3v-0003uh-1R
	for linuxppc-embedded@ozlabs.org; Thu, 12 Jun 2008 15:14:31 -0700
Message-ID: <17810852.post@talk.nabble.com>
Date: Thu, 12 Jun 2008 15:14:31 -0700 (PDT)
From: Trevor Anderson <tanderson@vmetro.com>
To: linuxppc-embedded@ozlabs.org
Subject: Correct way to adjust PCI resource allocations?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I'm hoping somebody can tell me the correct way to change the memory
resources allocated to particular PCI buses/devices at startup?

I'm developing a card (MPC8641D, 2.6.25 kernel) that includes a PCI/X-VMEBus
bridge, and the driver requires that it have a chunk of [prefetchable] PCI
memory space available to it. There is nothing on the chip that says so: it
has a single BAR that covers its configuration registers, but nothing else.

So: I need a way to declare an additional memory requirement for this
particular device that will wend its way back through the chain of PCIe and
PCIX buses to the root.

So far I've been using a platform-specific "pcibios_fixup_resources"
function that simply writes-in my new requirement, in conjunction with
"ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC", as a new resource entry in the
device's pci_device structure. And this has been working well, so far. But
I've discovered that fitting an XMC/PMC card to my board mucks things up -
the resource allocations fail. The XMC/PMC card appears on the same PCI/X
bus as the VME bridge. 

This leads me to think I've not been using the correct method all along, but
happened to hit lucky until now.

What is the right way to do this?
Is pcibios_fixup_resources even meant to do something like this?

Any help gratefully welcomed.

Cheers,

- Trevor Anderson <tanderson@vmetro.com>

-- 
View this message in context: http://www.nabble.com/Correct-way-to-adjust-PCI-resource-allocations--tp17810852p17810852.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

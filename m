Message-ID: <3C3CAB76.5050703@humboldt.co.uk>
Date: Wed, 09 Jan 2002 20:43:34 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ISA DMA take 2
References: <0201092018.AA22752@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

> Adrian Cox <adrian@humboldt.co.uk> wrote:
>>I have two CT69030 VGA chips on the same PCI bus, but I only enable
>>their PCI memory mapped regions, and never use the legacy VGA addresses.
>
> Ahh, I didn't know you could disable legacy VGA address decoding.


You don't need to. You just have to make sure that no legacy VGA address
ever appears on the PCI bus for the device to respond to.

This is quite easy - references by the PowerPC to addresses 0xa0000 to
0xfffff will go to RAM, not to PCI. If buffers for bus-mastering
peripherals are never allocated in that range, then those addresses will
never appear on the PCI bus.

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

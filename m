Message-ID: <3C3C8B7E.4020406@humboldt.co.uk>
Date: Wed, 09 Jan 2002 18:27:10 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ISA DMA take 2
References: <0201091753.AA22414@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:


> As I understand it, you also have to have no I/O hole in the mapping of the
> bottom 16 MB of memory onto PCI, right? As I understand it, Linux/PPC is a sane
> PPC OS and treats all PPC memory as normal, without any special treatment for
> 0xA0000-0xFFFFF, so your DMA buffer could legitimately end up in that region
> and if your memory map has an I/O hole you would be screwed, right? And of
> course main memory on PCI at 0 with no I/O hole means you can't have video on
> the same PCI bus... !@#$ing pee sea legacy :(


I have two CT69030 VGA chips on the same PCI bus, but I only enable
their PCI memory mapped regions, and never use the legacy VGA addresses.

Linux on this board doesn't hand out memory in the 0xa0000 to 0xfffff
region as DMA buffers, because that range is part of the kernel text
segment.  Linux on i386 explicity removes that range from the memory
map, and for completeness I should probably ensure that those pages are
marked reserved in case a minimal kernel comes below the 1MB barrier.

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

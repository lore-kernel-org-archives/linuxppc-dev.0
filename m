Date: Thu, 20 Dec 01 08:42:49 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0112201642.AA25515@ivan.Harhan.ORG>
To: adrian@humboldt.co.uk, d.mueller@elsoft.ch
Subject: Re: ISA DMA
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox <adrian@humboldt.co.uk> wrote:

> Via686a. As I understand it, 32-bit DMA uses the DMA_HI_PAGE_x registers
> from 0x487 to 0x48a, and the Via manual doesn't claim to have any
> registers in that range.

It is also my understanding that VT82C686/A/B offers 24-bit DMA addressing
only.

On the Adirondack I plan to use the floppy disk controller (the only ISA DMA
user) in non-DMA mode only. I hope Linux can do that. The memory map we've
adopted does not have memory at PCI address 0 at all, so 24-bit DMA means no
DMA at all rather than bottom 16 MB only. It is really too late to change the
memory map now, it would be so much pain that I would much rather settle for
using non-DMA mode only for floppies.

> The only 32-bit DMA southbridge I've
> encountered is the Winbond chip on the Sandpoint, and that chip doesn't
> have UDMA66, USB, and audio.

Acer Labs 1543 has it according to its manual (see the latter for where the
registers are, I don't remember).

We have that bridge on the K2. Ironically, there we don't have a floppy disk
port, so we have good ISA DMA on the board where we don't need it but don't
have it on a board where we do...

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

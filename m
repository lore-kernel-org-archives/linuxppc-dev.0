Message-ID: <3C21B464.4030509@humboldt.co.uk>
Date: Thu, 20 Dec 2001 09:50:28 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ISA DMA
References: <3C206A41.1080501@humboldt.co.uk> <3C21A301.2080204@elsoft.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Müller (ELSOFT AG) wrote:


> Seems like you are facing the same problem as i do. But IIRC i think you
> have to adjust the code in include/asm/dma.h (and possibly other places)
> as well (at least in 2.4.14, not sure about the later kernels).


The main problem I can see is that the code always writes to the
DMA_HI_PAGE_x registers, irrespective of whether they actually exist.
This should be harmless, as nothing else is mapped to those locations.


> What south bridge do you use? Some of the newer ones offer 32bit
> addressing capability for DMA.


Via686a. As I understand it, 32-bit DMA uses the DMA_HI_PAGE_x registers
from 0x487 to 0x48a, and the Via manual doesn't claim to have any
registers in that range. The only 32-bit DMA southbridge I've
encountered is the Winbond chip on the Sandpoint, and that chip doesn't
have UDMA66, USB, and audio.


--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

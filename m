Date: Mon, 10 Mar 2003 07:12:17 -0700
From: Matt Porter <porter@cox.net>
To: jeff.boyd@att.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 36 bit DMA address on IBM 440 PPC
Message-ID: <20030310071217.A22215@home.com>
References: <200303101316.HAA25661@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200303101316.HAA25661@lists.linuxppc.org>; from jeff.boyd@att.net on Mon, Mar 10, 2003 at 01:15:57PM +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Mar 10, 2003 at 01:15:57PM +0000, jeff.boyd@att.net wrote:
>
> I am having a problem doing PCI/memory DMA on the IBM 440 PPC because it has a
> 36 bit DMA address to/from the PCI bus (3_8000_0000), but the resource
> structure uses an unsigned long (which is a 32 bit quantity for gcc) to
> store 'physical/bus/dma' address. There is a kludge to get proper page table
> entries, which is to remap the 32 bit quatities into their 36 bit counterparts
> and then sending them on to __ioremap which takes a (36 bit) physical address
> input. This of course is no help to DMA, which wants not cpu (virtual) address,
> but physical (translated) address. I have done a similar kludge, making the 32
> to 36 bit translation into a function which a driver doing DMA can use.
> However, it seems to me that the real answer here is to change the resource
> definition to use a phys_addr_t rather than an unsigned long, for start/end.
> Does anyone know if this change has been made anywhere, or if it is being
> planned?

Maybe in 2.5/2.6. I was promised that resources would become 64-bit on
_all_ platforms in 2.5 but it hasn't happened yet.  I will have to beat
on the people that were working on that.  Of course, that's only one
piece required to properly handle I/O >4GB on a 32-bit platform.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

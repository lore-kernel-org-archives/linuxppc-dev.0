Date: Thu, 15 May 2003 14:13:38 +0200
From: Magnus Damm <damm@opensource.se>
To: ppc339@vtnet.ca
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: address translation
Message-Id: <20030515141338.0a69f4bf.damm@opensource.se>
In-Reply-To: <200305150729.36436.ppc339@vtnet.ca>
References: <200305150729.36436.ppc339@vtnet.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It sounds like you have some kind of memory mapped hardware like
an IDE device or a UART that in the PC world would be accessed
with in/out instructions. These instructions are mapped to a set
of macros/inline functions on a PC running Linux.
Once upon a time (I'm not sure how it works today) Linux for PowerPC
implemented all these in/out functions/macros using memory access to
a memory area could be mapped to one ore more physical addresses.

I don't think it is possible to remap individual bytes, you have to
stick with mapping one page at a time. And I think the in/out space
is limited to 64KBytes, and that gives you a maximum of 16 devices
if you use a pagesize of 4KByte.

I think the PCMCIA layer should be pretty flexible when it comes to
allocating addresses, maybe you could have a look at that.

/ magnus

On Thu, 15 May 2003 07:29:36 -0400
Trevor Woerner <ppc339@vtnet.ca> wrote:

>
> I want to setup a mapping so that when anything tries to read/write the
> 16 bytes at 0x1f0 - 0x1ff the actual physical memory that gets accessed
> is 0xf7000000 - 0xf700000f.
>
> I can't figure out what I need to call to get this done.
>
> ioremap() is the exact opposite of what I want.
>
> remap_page_range() comes very close but aligns everything to the page
> boundary. In other words, after I do the mapping with either 0x1f0 or
> 0x0 as the virtual address, accessing 0x1f0 gives me 0xf70001f0 instead
> of 0xf7000000. I don't want *page* translation, I need
> *address-for-address* translation (if such a thing is possible). I
> tried setting the physical address to 0xf7000000 - 0x1f0 but that
> didn't work (I didn't think it would :-)
>
> I think resetting _IO_BASE is just another page translation trick.
>
> I also tried using io_block_mapping(), which I use in my platform io
> setup routine, but the MMU crashed with one of those '###A' reports.
>
> any suggestions, please?
>
>         Trevor
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Subject: Re: address translation
From: Gary Thomas <gary@mlbassoc.com>
To: ppc339@vtnet.ca
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200305150729.36436.ppc339@vtnet.ca>
References: <200305150729.36436.ppc339@vtnet.ca>
Content-Type: text/plain
Message-Id: <1052999180.1568.129.camel@hermes>
Mime-Version: 1.0
Date: 15 May 2003 05:46:20 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-05-15 at 05:29, Trevor Woerner wrote:
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

The memory management on the PowerPC does not have this capability.

I'd suggest rethinking how you are looking at this problem.
  * What is it that wants access to this specific range of physical
    memory in such a way?
Perhaps a specialized device driver would be a better choice.

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

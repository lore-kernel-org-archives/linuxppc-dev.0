Content-Type: text/plain;
  charset="us-ascii"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: address translation
Date: Thu, 15 May 2003 07:29:36 -0400
MIME-Version: 1.0
Message-Id: <200305150729.36436.ppc339@vtnet.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I want to setup a mapping so that when anything tries to read/write the
16 bytes at 0x1f0 - 0x1ff the actual physical memory that gets accessed
is 0xf7000000 - 0xf700000f.

I can't figure out what I need to call to get this done.

ioremap() is the exact opposite of what I want.

remap_page_range() comes very close but aligns everything to the page
boundary. In other words, after I do the mapping with either 0x1f0 or
0x0 as the virtual address, accessing 0x1f0 gives me 0xf70001f0 instead
of 0xf7000000. I don't want *page* translation, I need
*address-for-address* translation (if such a thing is possible). I
tried setting the physical address to 0xf7000000 - 0x1f0 but that
didn't work (I didn't think it would :-)

I think resetting _IO_BASE is just another page translation trick.

I also tried using io_block_mapping(), which I use in my platform io
setup routine, but the MMU crashed with one of those '###A' reports.

any suggestions, please?

        Trevor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

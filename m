Reply-To: <litterio@pyxsys.net>
From: "Francis Litterio" <litterio@pyxsys.net>
To: "'linuxppc-embedded'" <linuxppc-embedded@lists.linuxppc.org>
Cc: <matthias.fuchs@esd-electronics.com>
Subject: RE: simple access to mem mapped peripheral
Date: Thu, 4 Oct 2001 11:34:01 -0400
Message-ID: <000401c14ce9$fec3cba0$4500f98c@EMMAROSE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3BBC34D9.B60D1BC9@esd-electronics.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthias Fuchs wrote:

> thanks. mmap is working fine for my problem ! I wonder why
> lseek'ing and reading does not work.

Because in linux/drivers/char/mem.c the function memory_lseek(), which
implements the lseek() system call for /dev/mem, does not call
remap_page_range(), but function mmap_mem(), which implements the mmap()
system call for /dev/mem, does call remap_page_range().

remap_page_range() is a kernel function that builds virtual memory page
table entries for physical pages.  In this case, the physical pages are
your device memory that is mapped into RAM by the PCI bus.

Without the PTEs for those physical pages, attempts to read from those
pages (e.g., via lseek() and read()) will segfault just as if you had
dereferenced a pointer that does not point to a valid page in your user
address space.
--
Francis Litterio
Software Engineer
Pyxsys Corproration
litterio@pyxsys.net
978-371-9115 x131


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

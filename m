Message-ID: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6D068@renexch3.rennes.thmulti.com>
From: Fillod Stephane <stephane.fillod@thomson.net>
To: "'Bob White'" <bwhite@perigee.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: DPRAM driver on 440gp
Date: Tue, 11 May 2004 11:15:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Given that the physical address has already been mapped, via
>ioremap64(), do I need remap_page_range()?  Does anyone have any ideas
>on what the mmap file_op for this driver would look like?  Do I even
>need mmap() or should I just use an ioctl to return the pointer I've
>already got to the user?

The ioctl won't do because the virtual address returned by the ioremap64
is not valid in process context. You could remap it through mmap file_op,
but why bother?
Rem: reading ioremap64 and drivers/char/mem.c is very instructive.

Since you're accessing your DPRAM guarded/uncached, you may simply
map it both in kernel with ioremap64 and in userland with mmap64
of /dev/mem.

For more information, search the archive (or DENX PPC FAQ) on userland
mapping of physical memory.


Regards,
Stephane

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

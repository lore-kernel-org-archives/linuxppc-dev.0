Message-ID: <3844D94A.18E9C52C@fadata.bg>
Date: Wed, 01 Dec 1999 10:16:10 +0200
From: Momchil Velikov <velco@fadata.bg>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: Stephen Edie <sedie@terraplex.com>, linuxppc-dev@lists.linuxppc.org,
        yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: Frame buffer / mmap() weirdness
References: <Pine.GSO.4.10.9912010822250.16291-100000@dandelion.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
> 
> On Tue, 30 Nov 1999, Stephen Edie wrote:
> > Furthermore, it makes most sense that mmap() should take care of page
> > alignment issues for me so that the address returned by mmap() always
> > points to the data at [lseek(h, 0, SEEK_SET)].  This is not technically
> > difficult to implement, right?

This behavior is mandated by POSIX:
   "   pa = mmap( addr, len, prot, flags, fildes, off)
    The mmap() function establishes a mapping between the address space of
    the process at an address pa for len bytes for memory object represented
    by the file descriptor fildes at offset off for len bytes".
So, if pa[0] != [lseek(fildes, off, SEEK_SET], etc., the mmap()
implementation is clearly buggy or at least non-compliant.

> I think it will make munmap() more difficult to implement. Furthermore I see no
> provisions for this in the current mmap() code. And it will break backwards
> compatibility.

Don't know for mmap(), but it seems the only change to munmap() is
to clear the appropriate number of low-order bits in its first argument
( addr & 0xfffff000 for 32-bit machines with 4k page size).

Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

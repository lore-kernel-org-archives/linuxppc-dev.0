Message-ID: <38450059.BF0F99DF@fadata.bg>
Date: Wed, 01 Dec 1999 13:02:49 +0200
From: Momchil Velikov <velco@fadata.bg>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Stephen Edie <sedie@terraplex.com>, linuxppc-dev@lists.linuxppc.org,
        yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: Frame buffer / mmap() weirdness
References: <Pine.HPX.4.10.9912011047380.10294-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
> 
>         Hi,
> 
> > > Don't know for mmap(), but it seems the only change to munmap() is
> > > to clear the appropriate number of low-order bits in its first argument
> > > ( addr & 0xfffff000 for 32-bit machines with 4k page size).
> >
> > You are right. Since I guess the other mmap()s in the kernel are POSIX
> > compliant, I feel silly now.
> 
> I probably have missed something but recent 2.3.xx kernels apparently
> prohibit performing mmap at non page aligned offsets since
> arch/${ARCH}/kernel/somefile.c constains sys_mmap which calls (rather
> directly) mm/mmap.c{do_mmap} where
> 
>         if (off & ~PAGE_MASK)
>                 return -EINVAL;
> 
> so does Posix the offset value passed to mmap to be restricted  ?
> 
>         Gabriel.

The POSIX I have (POSIX 1003.1b-1993) allows the implementation
to require the off parameter to be a multiple of the page size.
But:
   "NOTE: It is expected that a later amendment of this standard will
    disallow the implementation from imposing the restriction on the 
    alignment of the off and addr arguments".
Anyway, whatever is the offset it is still required that
    pa[i] == [lseek(fildes, off+i, SEEK_SET)] for each i : 0 <= i < len
after a successful
    pa = mmap( addr, len, prot, flags, fildes, off)

Frankly speaking, I can't imagine why addresses returned by mmap()
have to be page aligned. If the frame buffer at address range
[a, a+off) is to be mapped at [b, b+off), just map the range
  [a & ~PAGE_MASK, (a + off + PAGE_SIZE - 1) & ~PAGE_SIZE)
to
  [b & ~PAGE_MASK, (b + off + PAGE_SIZE - 1) & ~PAGE_SIZE)
and give the user the value b. Upon munmap() mask the lower
bits of the address and you'll get the actual start address
of the mapping. Note that this can be implemented in the
library even if the kernel imposes restrictions on the
alignment of the addr and off parameters.
Also, the standard explicitly allows the end of the *actual* mapping
to be page aligned, but it does not *explicitly forbid* the
start of the *actual* mapping to be page aligned :-)

Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

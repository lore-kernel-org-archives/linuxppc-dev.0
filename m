Date: Wed, 1 Dec 1999 14:02:17 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Momchil Velikov <velco@fadata.bg>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Stephen Edie <sedie@terraplex.com>, linuxppc-dev@lists.linuxppc.org,
        yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: Frame buffer / mmap() weirdness
In-Reply-To: <38450059.BF0F99DF@fadata.bg>
Message-ID: <Pine.HPX.4.10.9912011342440.10294-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 1 Dec 1999, Momchil Velikov wrote:

> The POSIX I have (POSIX 1003.1b-1993) allows the implementation
> to require the off parameter to be a multiple of the page size.
> But:
>    "NOTE: It is expected that a later amendment of this standard will
>     disallow the implementation from imposing the restriction on the 
>     alignment of the off and addr arguments".
> Anyway, whatever is the offset it is still required that
>     pa[i] == [lseek(fildes, off+i, SEEK_SET)] for each i : 0 <= i < len
> after a successful
>     pa = mmap( addr, len, prot, flags, fildes, off)
> 
> Frankly speaking, I can't imagine why addresses returned by mmap()
> have to be page aligned. If the frame buffer at address range
> [a, a+off) is to be mapped at [b, b+off), just map the range
>   [a & ~PAGE_MASK, (a + off + PAGE_SIZE - 1) & ~PAGE_SIZE)
> to
>   [b & ~PAGE_MASK, (b + off + PAGE_SIZE - 1) & ~PAGE_SIZE)

Some PAGE_SIZE are actually PAGE_MASK in this snippet...

> and give the user the value b. Upon munmap() mask the lower
> bits of the address and you'll get the actual start address
> of the mapping. Note that this can be implemented in the
> library even if the kernel imposes restrictions on the
> alignment of the addr and off parameters.

You can do anything when mapping a file privately (although being block
aligned certainly helps), not when mapping hardware or a file with write
sharing. At least the low order bits of a and b have to be the same
(that's only a problem when using MAP_FIXED).

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

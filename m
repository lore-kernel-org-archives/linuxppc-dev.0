Date: Wed, 1 Dec 1999 10:54:04 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Momchil Velikov <velco@fadata.bg>, Stephen Edie <sedie@terraplex.com>,
        linuxppc-dev@lists.linuxppc.org,
        yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: Frame buffer / mmap() weirdness
In-Reply-To: <Pine.GSO.4.10.9912011012361.16291-100000@dandelion.sonytel.be>
Message-ID: <Pine.HPX.4.10.9912011047380.10294-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




	Hi, 

> > Don't know for mmap(), but it seems the only change to munmap() is
> > to clear the appropriate number of low-order bits in its first argument
> > ( addr & 0xfffff000 for 32-bit machines with 4k page size).
> 
> You are right. Since I guess the other mmap()s in the kernel are POSIX
> compliant, I feel silly now.

I probably have missed something but recent 2.3.xx kernels apparently
prohibit performing mmap at non page aligned offsets since
arch/${ARCH}/kernel/somefile.c constains sys_mmap which calls (rather
directly) mm/mmap.c{do_mmap} where

        if (off & ~PAGE_MASK)
                return -EINVAL;

so does Posix the offset value passed to mmap to be restricted  ? 

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

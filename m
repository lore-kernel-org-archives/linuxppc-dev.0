Date: Wed, 1 Dec 1999 10:13:13 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Momchil Velikov <velco@fadata.bg>
cc: Stephen Edie <sedie@terraplex.com>, linuxppc-dev@lists.linuxppc.org,
        yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: Frame buffer / mmap() weirdness
In-Reply-To: <3844D94A.18E9C52C@fadata.bg>
Message-ID: <Pine.GSO.4.10.9912011012361.16291-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 1 Dec 1999, Momchil Velikov wrote:
> Geert Uytterhoeven wrote:
> > On Tue, 30 Nov 1999, Stephen Edie wrote:
> > > Furthermore, it makes most sense that mmap() should take care of page
> > > alignment issues for me so that the address returned by mmap() always
> > > points to the data at [lseek(h, 0, SEEK_SET)].  This is not technically
> > > difficult to implement, right?
> 
> This behavior is mandated by POSIX:
>    "   pa = mmap( addr, len, prot, flags, fildes, off)
>     The mmap() function establishes a mapping between the address space of
>     the process at an address pa for len bytes for memory object represented
>     by the file descriptor fildes at offset off for len bytes".
> So, if pa[0] != [lseek(fildes, off, SEEK_SET], etc., the mmap()
> implementation is clearly buggy or at least non-compliant.

Hmmm...

> > I think it will make munmap() more difficult to implement. Furthermore I see no
> > provisions for this in the current mmap() code. And it will break backwards
> > compatibility.
> 
> Don't know for mmap(), but it seems the only change to munmap() is
> to clear the appropriate number of low-order bits in its first argument
> ( addr & 0xfffff000 for 32-bit machines with 4k page size).

You are right. Since I guess the other mmap()s in the kernel are POSIX
compliant, I feel silly now.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

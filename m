Date: Wed, 1 Dec 1999 08:28:26 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Stephen Edie <sedie@terraplex.com>
cc: linuxppc-dev@lists.linuxppc.org, yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: Frame buffer / mmap() weirdness
In-Reply-To: <Pine.LNX.4.10.9911301528200.7062-100000@newhope.terraplex.com>
Message-ID: <Pine.GSO.4.10.9912010822250.16291-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 30 Nov 1999, Stephen Edie wrote:
> According to fbset, it's at:  0x8a008900
> 
> I don't want to map /dev/mem if that's what you are talking about.  

I did meant /dev/fb0, but I indeed incorrectly wrote `address & 0xfffff000',
while I meant `0' (offsets are relative to the start of the frame buffer
memory).

> So I am assuming that mmap() will start mapping from the first page that
> he frame buffer occupies...  So I need to add the following to what

Yes.

> mmap() returns in order to get a valid pointer:
> 
> PAGE_ROUND_UP(phys_address) - phys_address

Yes.

> (PAGE_ROUND_UP is assumed to return the beginning of the page that starts
> at or after the specified address)
> 
> This doesn't entirely make sense.  Just now I tested the program and it
> doesn't require re-alignment as I mention above.
> 
> (I'm thinking now that it only occurs in 32 bit color mode??)

That's possible: on some hardware, the start address of the frame buffer
depends on the color depth.

> Furthermore, it makes most sense that mmap() should take care of page
> alignment issues for me so that the address returned by mmap() always
> points to the data at [lseek(h, 0, SEEK_SET)].  This is not technically
> difficult to implement, right?

I think it will make munmap() more difficult to implement. Furthermore I see no
provisions for this in the current mmap() code. And it will break backwards
compatibility.

> On Tue, 30 Nov 1999, Geert Uytterhoeven wrote:
> > Perhaps the frame buffer memory is not aligned on a page boundary? What does
> > `fbset --info' say about the address?
> > 
> > If it's not aligned to a page boundary, the application has to mmap()
> > (address & 0xfffff000) and add (address & 0x00000fff) to the start address of
> > the returned region. Make sure to increase the size you pass to mmap(), so the
> > whole frame buffer memory is covered and size is a multiple of the page size.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

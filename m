Date: Tue, 30 Nov 1999 22:19:11 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Stephen Edie <sedie@terraplex.com>
cc: linuxppc-dev@lists.linuxppc.org, yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: Frame buffer / mmap() weirdness
In-Reply-To: <Pine.LNX.4.10.9911301456090.6524-100000@newhope.terraplex.com>
Message-ID: <Pine.LNX.4.05.9911302216440.389-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 30 Nov 1999, Stephen Edie wrote:
> I have been noticing some strange behavior while working with Linux frame
> buffer devices on PPC.  Perhaps I am just doing something stupid.  I open
> the frame buffer using:
> 
> fbdev_handle = open("/dev/fb0", O_RDWR);
> 
> I can draw to the frame buffer using:
> 
> lseek(fbdev_handle, 0, SEEK_SET);
> write(fbdev_handle, pixmap, size);
> 
> This part works fine.  What causes problems is attempting to memory map
> the frame buffer using:
> 
> address = mmap(0, screen.height * screen.stride * screen.bpp / 8,
>                PROT_READ | PROT_WRITE, MAP_SHARED, fbdev_handle, 0);
> 
> When doing this, address[0] points outside of the video memory and
> strangely enough, address[512] points to the first pixel in memory!  So if
> I do the following, everything works as expected:
> 
> address = (char *)(mmap(0, screen.height * screen.stride * screen.bpp / 8
>                         + 512, PROT_READ | PROT_WRITE, MAP_SHARED,
>                         fbdev_handle, 0)) + 512;
> 
> I don't think this is right!  Is this a kernel bug in the frame buffer
> driver code?  (This is being tested using OFFB by the way)  Is there
> something weird going on here with page alignment or something?

Perhaps the frame buffer memory is not aligned on a page boundary? What does
`fbset --info' say about the address?

If it's not aligned to a page boundary, the application has to mmap()
(address & 0xfffff000) and add (address & 0x00000fff) to the start address of
the returned region. Make sure to increase the size you pass to mmap(), so the
whole frame buffer memory is covered and size is a multiple of the page size.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

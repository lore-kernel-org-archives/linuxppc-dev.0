Date: Wed, 16 Dec 1998 11:42:37 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Jeff Rugen <jrugen@primenet.com>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        Gabriel Paubert <paubert@iram.es>, Cort Dougan <cort@cs.nmt.edu>
Subject: Re: ioremap and related
In-Reply-To: <Pine.BSI.3.96.981214065216.24602A-100000@usr04.primenet.com>
Message-ID: <Pine.LNX.4.03.9812161135520.11635-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 14 Dec 1998, Jeff Rugen wrote:
> I have a few questions related to the ioremap function and some related
> ones.
> 
> First, is ioremap the kernel equivalent of using mmap?  I'm working on the

Yes. ioremap() takes a physical address and size, and maps that block into
kernel space.

> clgenfb device for LinuxPPC on a Motorola Powerstack, and I'm currently
> thinking my problems are coming from setting up the framebuffer memory and
> PCI stuff.  I have the source for Xbh, and it uses mmap() to map the I/O
> registers, video memory, and PCI memory (not sure what the third is for, but
> I have a question related to that below).
> 
> Now, in the clgenfb driver, it doesn't seem to like me using ioremap to set
> up the registers for the Cirrus chip -- if I hard-code the registers to be
> relative to 0x80000000, everything works fine (this is the memory location
> mmaped in in Xbh server), but if I use ioremap, it doesn't work.
> (By working, I mean it sets the video mode and sets/reads the color
> registers... not working means I get a panic when starting to
> initizliaze the hardware and can't detect the video memory size). 
> 
> However, it seems I get a little farther if I ioremap video memory (mmapped
> from 0xC0000000 in Xbh) than if I don't -- though the program crashes in
> either case.  I'm also trying to use other framebuffer devices as reference,
> but I'm not as familiar with them.
> 
> In addition, when I use ioremap for video memory, I get the following memory
> locations in pointers:
> video_phys = 0xc0000000, video_base = 0xc8000000
> where video_phys is the physical address and video_base is the ioremapped.

OK.

> However, when I use phys_to_virt and virt_to_phys, I get strange values
> (maybe its related to how much actual memory I have -- 96MB -- some bits may
> not be decoded.)
> phys_to_virt(video_phys) = 0x80000000
> virt_to_phys(video_base) = 0x08000000
> 
> I expected the same numbers as above, but don't completely understand how
> the functions work yet.

phys_to_virt() and virt_to_phys() don't work that well on MMIO. I was told
they're for real memory only.

That's why most frame buffer devices remember both the physical address (as
passed to ioremap()) and the virtual address (as returned by ioremap()).

> Finally, in Xbh, they do the following code with PCI stuff -- but I don't
> really know what they're doing and was wondering if someone could explain it
> in a sentence or two and indicate a good reference to look at to understand
> it better (online if possible).  An equivalent that you would use in kernel
> code would be cool too, but I don't expect that.  ;-)
> 
> #define PCI_BASE   ((volatile unsigned long *) 0x80808000)

These are accesses to the PCI configuration space, using PReP style memory
mapped accesses (as explained in the PCI specs and any good book about PCI).
Gabriel can tell you more for sure.

> pcibase = (char *) mmap(..., PCI_BASE);  /* Just to show that its mmaped */
> gd->pci04 = 0x03000000;   /* enable memory and I/O accesses */
> gd->pci10 = 0x00000000;
> *(pcibase + 1) = gd->pci04;    /* 0x80808004 = gd->pci04? */
> *(pcibase + 4) = gd->pci10;    /* 0x80808010 = gd->pci10? */

pci04 is the PCI_COMMAND register. Writing 0x03000000 to it makes the Cirrus
Logic chip listen to accesses to its memory and I/O spaces.

pci10 is PCI_BASE_ADDRESS_0, the register that defines where the base address
of the first memory space is located. Hmm, writing 0 to it puts it at address
zero. Weird... On my CHRP box, all PCI memory spaces are located at addresses
0xc0000000 and up. PReP is different. Gabriel? Cort?

More info in <linux/pci.h>

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

Date: Fri, 18 Dec 1998 13:29:29 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
Reply-To: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Jeff Rugen <jrugen@primenet.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        Cort Dougan <cort@cs.nmt.edu>
Subject: Re: ioremap and related
In-Reply-To: <Pine.LNX.4.03.9812161135520.11635-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.HPP.3.96.981218122416.12103E-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 16 Dec 1998, Geert Uytterhoeven wrote:

> 
> On Mon, 14 Dec 1998, Jeff Rugen wrote:
> > I have a few questions related to the ioremap function and some related
> > ones.
> > 
> > First, is ioremap the kernel equivalent of using mmap?  I'm working on the
> 
> Yes. ioremap() takes a physical address and size, and maps that block into
> kernel space.

That's a problem for PreP machines, where the contents of the PCI base
address registers are offsetted by the brige. Something has to be done
about it, but I have no clear idea of how to do it. Maybe the simplest
thing would be to put the processor physical address at which it appears
in the pci_device structure, that's a simple hack to pcibios_fixup.

Then I don't have to touch ioremap ! (Well I want to change ioremap
anywway it so that if you use it to access a legacy ISA device, it will
add isa_mem_base to the address before mapping). And also that it won't
allocate kernel vm if the area is already mapped with a BAT... 

Comments, criticism (but not flames) and especially better ideas
welcome...

> 
> > clgenfb device for LinuxPPC on a Motorola Powerstack, and I'm currently
> > thinking my problems are coming from setting up the framebuffer memory and
> > PCI stuff.  I have the source for Xbh, and it uses mmap() to map the I/O
> > registers, video memory, and PCI memory (not sure what the third is for, but
> > I have a question related to that below).
> > 
> > Now, in the clgenfb driver, it doesn't seem to like me using ioremap to set
> > up the registers for the Cirrus chip -- if I hard-code the registers to be
> > relative to 0x80000000, everything works fine (this is the memory location
> > mmaped in in Xbh server), but if I use ioremap, it doesn't work.
> > (By working, I mean it sets the video mode and sets/reads the color
> > registers... not working means I get a panic when starting to
> > initizliaze the hardware and can't detect the video memory size). 

The registers in the I/O area should be accessed with in[bwl]/out[bwl], or
am I missing something ? 

> > 
> > However, it seems I get a little farther if I ioremap video memory (mmapped
> > from 0xC0000000 in Xbh) than if I don't -- though the program crashes in
> > either case.  I'm also trying to use other framebuffer devices as reference,
> > but I'm not as familiar with them.
> > 
> > In addition, when I use ioremap for video memory, I get the following memory
> > locations in pointers:
> > video_phys = 0xc0000000, video_base = 0xc8000000
> > where video_phys is the physical address and video_base is the ioremapped.
> 
> OK.

Reasonable, but read below. 
> 
> > However, when I use phys_to_virt and virt_to_phys, I get strange values
> > (maybe its related to how much actual memory I have -- 96MB -- some bits may
> > not be decoded.)
> > phys_to_virt(video_phys) = 0x80000000
> > virt_to_phys(video_base) = 0x08000000
> > 
> > I expected the same numbers as above, but don't completely understand how
> > the functions work yet.
> 
> phys_to_virt() and virt_to_phys() don't work that well on MMIO. I was told
> they're for real memory only.

Indeed. 

> That's why most frame buffer devices remember both the physical address (as
> passed to ioremap()) and the virtual address (as returned by ioremap()).
> 
> > Finally, in Xbh, they do the following code with PCI stuff -- but I don't
> > really know what they're doing and was wondering if someone could explain it
> > in a sentence or two and indicate a good reference to look at to understand
> > it better (online if possible).  An equivalent that you would use in kernel
> > code would be cool too, but I don't expect that.  ;-)
> > 
> > #define PCI_BASE   ((volatile unsigned long *) 0x80808000)
> 
> These are accesses to the PCI configuration space, using PReP style memory
> mapped accesses (as explained in the PCI specs and any good book about PCI).
> Gabriel can tell you more for sure.

Well, my boards don't support this config access method. Which is probably
deprecated since it is very limited (only bus 0, so no bridges). It is
explained in the MPC105 manual (and MPC106 also AFAIR), available on
Motorola's website. 

> 
> > pcibase = (char *) mmap(..., PCI_BASE);  /* Just to show that its mmaped */
> > gd->pci04 = 0x03000000;   /* enable memory and I/O accesses */
> > gd->pci10 = 0x00000000;
> > *(pcibase + 1) = gd->pci04;    /* 0x80808004 = gd->pci04? */
> > *(pcibase + 4) = gd->pci10;    /* 0x80808010 = gd->pci10? */
> 
> pci04 is the PCI_COMMAND register. Writing 0x03000000 to it makes the Cirrus
> Logic chip listen to accesses to its memory and I/O spaces.
> 
> pci10 is PCI_BASE_ADDRESS_0, the register that defines where the base address
> of the first memory space is located. Hmm, writing 0 to it puts it at address
> zero. Weird... On my CHRP box, all PCI memory spaces are located at addresses
> 0xc0000000 and up. PReP is different. Gabriel? Cort?

Yeah, but on PreP the MMIO addresses are offset by 0xc0000000 by the host
bridge, so that if this register is set to 0, the processor has to
generate physical address 0xc0000000 to access it, so you have to ioremap
at 0xc0000000 (unless we modify ioremap, but I'm still wondering as to
what the right way to do it is, as said earlier).

Howvever, setting it to zero is bad for at least 2 reasons:

- it may conflict with some ISA devices, making them inaccessible because
of the subtractive decoding nature of the PCI<->ISA bridge.

- PCI specifications 2.1 state that setting a base address register to 0 
disables the corresponding decoder. Many devices are buggy in this
respect however.

	Greetings,
	Gabriel.



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

Date: Mon, 14 Dec 1998 07:13:24 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: ioremap and related
Message-ID: <Pine.BSI.3.96.981214065216.24602A-100000@usr04.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a few questions related to the ioremap function and some related
ones.

First, is ioremap the kernel equivalent of using mmap?  I'm working on the
clgenfb device for LinuxPPC on a Motorola Powerstack, and I'm currently
thinking my problems are coming from setting up the framebuffer memory and
PCI stuff.  I have the source for Xbh, and it uses mmap() to map the I/O
registers, video memory, and PCI memory (not sure what the third is for, but
I have a question related to that below).

Now, in the clgenfb driver, it doesn't seem to like me using ioremap to set
up the registers for the Cirrus chip -- if I hard-code the registers to be
relative to 0x80000000, everything works fine (this is the memory location
mmaped in in Xbh server), but if I use ioremap, it doesn't work.
(By working, I mean it sets the video mode and sets/reads the color
registers... not working means I get a panic when starting to
initizliaze the hardware and can't detect the video memory size). 

However, it seems I get a little farther if I ioremap video memory (mmapped
from 0xC0000000 in Xbh) than if I don't -- though the program crashes in
either case.  I'm also trying to use other framebuffer devices as reference,
but I'm not as familiar with them.

In addition, when I use ioremap for video memory, I get the following memory
locations in pointers:
video_phys = 0xc0000000, video_base = 0xc8000000
where video_phys is the physical address and video_base is the ioremapped.
However, when I use phys_to_virt and virt_to_phys, I get strange values
(maybe its related to how much actual memory I have -- 96MB -- some bits may
not be decoded.)
phys_to_virt(video_phys) = 0x80000000
virt_to_phys(video_base) = 0x08000000

I expected the same numbers as above, but don't completely understand how
the functions work yet.

Finally, in Xbh, they do the following code with PCI stuff -- but I don't
really know what they're doing and was wondering if someone could explain it
in a sentence or two and indicate a good reference to look at to understand
it better (online if possible).  An equivalent that you would use in kernel
code would be cool too, but I don't expect that.  ;-)

#define PCI_BASE   ((volatile unsigned long *) 0x80808000)
pcibase = (char *) mmap(..., PCI_BASE);  /* Just to show that its mmaped */
gd->pci04 = 0x03000000;   /* enable memory and I/O accesses */
gd->pci10 = 0x00000000;
*(pcibase + 1) = gd->pci04;    /* 0x80808004 = gd->pci04? */
*(pcibase + 4) = gd->pci10;    /* 0x80808010 = gd->pci10? */

Thanks for any help.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

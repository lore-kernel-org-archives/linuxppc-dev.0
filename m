Date: Mon, 28 Dec 1998 11:35:33 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: fbcon + X Server + Cirrus/Powerstack
In-Reply-To: <Pine.LNX.4.02.9812271407390.378-100000@cassiopeia.home>
Message-ID: <Pine.BSI.3.96.981228111730.13388A-100000@usr05.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 27 Dec 1998, Geert Uytterhoeven wrote:
> I suspect the address of the frame buffer in struct fb_fix_screeninfo. It must
> be the _physical_ address of the frame buffer. If this is wrong, the X server
> will map the wrong piece of memory space.
> 
> What does `fbset --info' say?
> 

mode "name"
    # H: 31.250 kHz, V: 59.524 Hz
    geometry 640 480 640 1440 8
    timings 40000 32 32 33 10 96 2
    hsync high
    vsync high
endmode

Frame buffer device information:
    Name        : `CLgen'
    Address     : 0x08000000
    Size        : 2097152
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 640
    MMIO Address: 0x80000000
    MMIO Size   : 65536
    Acceleration: None

I think you're right in that the physical address is wrong, but from what I
can tell, for the console to work it has to be what it says (0x08000000).

I'm using the following code to give you an idea how the address is being
generated.

fb_info->fbmem = ioremap(0xC0000000, board_size);  /* returns 0xC8000000 */
fb_info->fbmem_phys = virt_to_phys((unsigned char *)fb_info->fbmem);

I'll explain the 2nd line in a moment, which sets fbmem_phys to 0x08000000
as listed in the fbset --info output.

In clgen_encode_fix(), the code does the following (I didn't change this
from what it does now)

fix->smem_start     = (char*)_info->fbmem_phys;

Then in fbgen_set_disp() the code does the following:

display->screen_base = phys_to_virt((unsigned long)fix.smem_start);

This sets display->screen_base == fb_info->fbmem.

When I had some test code to write directly to video memory in the driver, I
could only put pixels on the screen if I wrote to the block of memory
pointed to by the result of the ioremap call.

It seems Troy Benjegerdes had a problem with getting the matrox (?)
framebuffer to work with something as well, but I don't remember if that was
as a module or if it was with the X server (my tweaked clgenfb doesn't work
as a module, and I'm thinking it may be related to the physical address
above, but I haven't experimented as a module recently).

Could the problem be that ioremap doesn't return the same address as passed
into it?  It seems I remember seeing a comment or some documentation that
indicated it was supposed to...

> When using the console, can you read and write to /dev/fb0? With
> 
>     dd if=/dev/fb0 /tmp/screendump
> 
> you can create a screendump.
> 
>     dd if=/tmp/screendump of=/dev/fb0
> 
> should restore the dump.

This works correctly.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

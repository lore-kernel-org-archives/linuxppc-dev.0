Date: Mon, 28 Dec 1998 19:52:08 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Jeff Rugen <jrugen@primenet.com>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: fbcon + X Server + Cirrus/Powerstack
In-Reply-To: <Pine.BSI.3.96.981228111730.13388A-100000@usr05.primenet.com>
Message-ID: <Pine.LNX.4.03.9812281946552.1425-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 28 Dec 1998, Jeff Rugen wrote:
> On Sun, 27 Dec 1998, Geert Uytterhoeven wrote:
> > I suspect the address of the frame buffer in struct fb_fix_screeninfo. It must
> > be the _physical_ address of the frame buffer. If this is wrong, the X server
> > will map the wrong piece of memory space.
> 
> I think you're right in that the physical address is wrong, but from what I
> can tell, for the console to work it has to be what it says (0x08000000).
> 
> I'm using the following code to give you an idea how the address is being
> generated.
> 
> fb_info->fbmem = ioremap(0xC0000000, board_size);  /* returns 0xC8000000 */
> fb_info->fbmem_phys = virt_to_phys((unsigned char *)fb_info->fbmem);

Try

    fb_info->fbmem_phys = 0xC0000000;

instead, i.e. use the address you passed to ioremap()[*].

> I'll explain the 2nd line in a moment, which sets fbmem_phys to 0x08000000
> as listed in the fbset --info output.
> 
> In clgen_encode_fix(), the code does the following (I didn't change this
> from what it does now)
> 
> fix->smem_start     = (char*)_info->fbmem_phys;
> 
> Then in fbgen_set_disp() the code does the following:
> 
> display->screen_base = phys_to_virt((unsigned long)fix.smem_start);
> 
> This sets display->screen_base == fb_info->fbmem.

Which is correct.

> When I had some test code to write directly to video memory in the driver, I
> could only put pixels on the screen if I wrote to the block of memory
> pointed to by the result of the ioremap call.

That's normal: before you can access video memory, you have to map it with
ioremap().

> Could the problem be that ioremap doesn't return the same address as passed
> into it?  It seems I remember seeing a comment or some documentation that
> indicated it was supposed to...

It's normal that ioremap() doesn't return the same address as pased to it: it's
input is a _physical_ address, while it's output is a _virtual_ kernel address.

There seem to be problems with the phyiscal to virtual mapping and vice versa,
i.e. virt_to_phys(phys_to_virt(x)) and phys_to_virt(virt_to_phys(x)) are not
always x.

If `phys_to_virt(0xC0000000)' returns fb_info->fbmem again, [*] should work.

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

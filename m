Date: Fri, 18 Dec 1998 07:11:29 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: Gabriel Paubert <paubert@iram.es>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        Cort Dougan <cort@cs.nmt.edu>
Subject: Re: ioremap and related
In-Reply-To: <Pine.HPP.3.96.981218122416.12103E-100000@gra-ux1.iram.es>
Message-ID: <Pine.BSI.3.96.981218070058.2404A-100000@usr07.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 18 Dec 1998, Gabriel Paubert wrote:

> > > Now, in the clgenfb driver, it doesn't seem to like me using ioremap to set
> > > up the registers for the Cirrus chip -- if I hard-code the registers to be
> > > relative to 0x80000000, everything works fine (this is the memory location
> > > mmaped in in Xbh server), but if I use ioremap, it doesn't work.
> > > (By working, I mean it sets the video mode and sets/reads the color
> > > registers... not working means I get a panic when starting to
> > > initizliaze the hardware and can't detect the video memory size). 
> 
> The registers in the I/O area should be accessed with in[bwl]/out[bwl], or
> am I missing something ? 

I've gotten this working to some extent (on my computer anyway) so I'm
mainly looking for understanding.  I'm using in[bw]/out[bw] to access the
registers in the I/O area.  What's confusing is I have to ioremap the memory
map area (at 0xC0000000) but I don't have to ioremap the I/O area (at
0x80000000).  I don't understand why though.

For that matter, once I ioremap the memory map area, I have to use
virt_to_phys() to convert it to a memory location that I save to give back
to the framebuffer code, just because the framebuffer code uses
phys_to_virt() to convert it back to a value it can use.  None of the other
framebuffer drivers need to do this, so it feels like a hack.

<snip>

> > pci10 is PCI_BASE_ADDRESS_0, the register that defines where the base address
> > of the first memory space is located. Hmm, writing 0 to it puts it at address
> > zero. Weird... On my CHRP box, all PCI memory spaces are located at addresses
> > 0xc0000000 and up. PReP is different. Gabriel? Cort?
> 
> Yeah, but on PreP the MMIO addresses are offset by 0xc0000000 by the host
> bridge, so that if this register is set to 0, the processor has to
> generate physical address 0xc0000000 to access it, so you have to ioremap
> at 0xc0000000 (unless we modify ioremap, but I'm still wondering as to
> what the right way to do it is, as said earlier).
> 
> Howvever, setting it to zero is bad for at least 2 reasons:
> 
> - it may conflict with some ISA devices, making them inaccessible because
> of the subtractive decoding nature of the PCI<->ISA bridge.
> 
> - PCI specifications 2.1 state that setting a base address register to 0 
> disables the corresponding decoder. Many devices are buggy in this
> respect however.
> 

I'm currently using pcibios_(write|read)_config_dword to do the above.  In
the PCI structure, base_address[0] is already set to 0 however, so possibly
I don't need to touch pci10 -- which may make the code work on more machines
if I understand the rest of what was said :-)

Would it be worth my posting the snippet of code that sets up the memory
locations of the I/O registers and memory map and enables PCI access to
both?

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

Date: Fri, 22 Oct 1999 04:41:57 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, cort@ppc.kernel.org
Subject: Re: need Open PIC infos (and more)
In-Reply-To: <19991016191421.027499@smtp.calvacom.fr>
Message-ID: <Pine.HPX.4.10.9910191154540.18326-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Sat, 16 Oct 1999, Benjamin Herrenschmidt wrote:

> 
> Hi !
> 
> I'm working on support for new UMA machines (beginning with iBook). I
> have already figured out a lot of things and am now coding a very
> preliminary support (I'm not sure yet the PMU99 will work out of the box
> or not, but it looks similar to the old PMU from an interface point of view).

Great (and sorry for the delay in answering).

> However, the new Apple ASICs contains an Open PIC interrupt controller
> (advertised as beeing a "chrp,open-pic" controller). After looking at the
> various docs I have and a quick search on Altavista, I couldn't find any
> relevant documentation on the chip.
> There's already some OpenPIC support in the kernel, but I'll have to
> change it a little bit since, for example, Apple hardware is not a good
> place to search for a 8259 master ;)

I don't know on which board the 8259 is a master of the OpenPIC. On CHRP
boards and Motorola with Raven or Hawk chipsets, the 8259 is the slave 
connected on interrupt 0 of the OpenPIC. If you don't have a 8259 on this
input of the OpenPIC then input 0 behaves like any other input and you'll
have to program it as edge/level as per the specification. 

> I'd like some docs in order to have better understanding of the chip.

I have a copy of the pdf which once was on AMD's site. I'm not sure it's
there anymore since the Athlon uses an Intel's like APIC (arghhh!, where
'A' does not mean advanced as some would believe, but Awkward IMNSHO).

Besides this, look for documentation in the Motorola Computer Group 
website about the boards with Raven and Hawk chipsets, for example the
programmer's guide for MVME2600 and MVME2400 (v2?00*pg*.pdf). The
description is more complete than in openpic.pdf, although there are still
bits which can be toggled and are not documented. 

Note that on my machines with OpenPIC I have modified the 8259
interrupt handler to better coexist with the openpic: I have defined
another class of interrupts (struct hw_interrupt_type cascaded_i8259_pic) 
to handle the case of a 8259 behind an OpenPIC in a cleaner way.

I also have a few remarks about 8259 interrupt handling introduced in
2.2.12:

a) the previous code worked perfectly AFAICT, was it changed for any
   compelling reason (more on this in point d below) ? 

b) reading the IRR (masked by the IMR to avoid calling disabled
   interrupts) will work for level triggered interrupt but not necessary
   for edge triggered ISA interrupts because the current code never sets
   the corresponding ISR bit AFAICT. If you read any 8259 documentation, 
   you will find that the edge detection logic is reset only when the ISR
   bit is set (i.e wit a poll command or an interrupt acknowledge cycle):
   this causes a problem if a device generates edge triggered interrupt
   with a low going pulse. 

   Guess what, that's exactly what the standard parallel port does since
   the IRQ line follows the ACK signal from the interface (and also what a
   number of ISA boards do from what I saw on a scope a few years ago);
   this might result in interrupt storms (I can't test it right now but
   will be able soon, just some time to find this damn connector and to
   trigger interrupts).

c) I'm not totally convinced that the are no subtle coherency problems
   with ISA DMA tranfers to main memory: when are the ISA DMA buffers
   flushed in the bridge ? The device who has finished might raise the
   interrupt request while the data is still in the PCI<->ISA bridge, then
   a PCI interrupt acknowledge or a poll command must flush the buffers
   for coherency reasons, I'm not sure only reading the IRR will have the
   same effect (this depends on bridge design details and bugs in this
   area would not be surprising).
   
d) there are actually 2 ways to read the 8259 interrupt vector: use the
   poll method as previously done (although a careful reading of the 8259
   spec shows that the high bit says whether an interrupt is present or
   not: no need to perform additional checks for spurious interrupts) or
   performing an access to the address which translates the access into 
   a PCI interrupt acknowledge cycle. MPC105/106.../GG2/Raven/Hawk
   also support this method, so why not use it ? I've used both and they
   work fine for me, of course I'm not sure that they will work perfectly
   for everybody. 

 
Note that I always rated the 8259 as the worst ever designed chip
(especially if you factor in the complexity/functionality ratio)..., until
Intel succeeded in surpassing themselves with the IO-APIC :-)

> Anyone knows if such a doc exist ? Apparently, if the register map is not
> completely bogus, the current code returns an OpenPIC versio 1.2, and the
> timer freq is 0x80000000 (ouch !).

The version number looks correct, but are you sure of the timer frequency
address ?  0x80000000 is the power up value of all the vector/priority
registers while the power up value of the timer frequency is 0, so this
looks suspiscious.

 
> Side note: the Keylargo IC contains the open-pic and the SCC cells at the
> exact same location as Hydra, things don't change so much ;) But the new
> chip contains a lot new things.
> 
> The Uni-North is a rather weird beast. It appears in the device tree as 4
> devices on the root level:
> 
>  /uni-n (the memory controller part)
>  /pci
>     /agp stuffs
>     /ATI
>  /pci
>     /mac-io (KeyLargo is here)
>     /usb
>     (/slots ?)
>  /pci
>     /ethernet
>     (/firewire on some machines)
> 
> All 3 "pci" nodes corresponding apparently to the various internal
> busses: the AGP, the ethernet/firewire, and the mac-io/usb, I beleive the
> external pci is on the mac-io/usb part).

It must be on same (sub)part as the key-largo (otherwise you would need 2
PCI buses, which means even more pins...).

> The annoying thing is that all the 3 pci nodes have the same bus number.
> (devices below those have various non-conflicting device number) but all
> 3 has different pairs of registers to access config space. This makes the
> config access code a bit weird since it has to lookup the OF node of the
> device in the device tree, get the parent "pci" node, etc... but It
> should work this way.

Oh well, as long as the RTAS handles this properly... 
And why make things simple when they can be made awkward ? 

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

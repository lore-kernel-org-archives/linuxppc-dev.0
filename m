In-Reply-To: <Pine.HPX.4.10.9910191154540.18326-100000@gra-ux1.iram.es>
Date: Fri, 22 Oct 1999 10:55:10 +0200
To: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: need Open PIC infos (and more)
Message-Id: <19991022105510.004059@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 22, 1999, Gabriel Paubert <paubert@iram.es> wrote:

>I don't know on which board the 8259 is a master of the OpenPIC. On CHRP
>boards and Motorola with Raven or Hawk chipsets, the 8259 is the slave 
>connected on interrupt 0 of the OpenPIC. If you don't have a 8259 on this
>input of the OpenPIC then input 0 behaves like any other input and you'll
>have to program it as edge/level as per the specification. 

That's what I figured out. One problem I have is that I don't know which
interrupts are level and which are edge triggered (looks like this
information is not in the device tree, or not where I looked for it).
Also, the initialisation code of the OpenPIC hangs when trying to
initialize interrupt 48. The PIC tells it has 64 interrupts (it's a 1.2
OpenPIC revision, I correctly get the MacOS-initialised NMI on interrupt
55 when pressing cmd-power). I didn't look in more details yet (that's
why I was asking for the doc ;)

>I have a copy of the pdf which once was on AMD's site. I'm not sure it's
>there anymore since the Athlon uses an Intel's like APIC (arghhh!, where
>'A' does not mean advanced as some would believe, but Awkward IMNSHO).

I didn't find anything on the AMD site, but Douglas Godfey sent it to me.

>Besides this, look for documentation in the Motorola Computer Group 
>website about the boards with Raven and Hawk chipsets, for example the
>programmer's guide for MVME2600 and MVME2400 (v2?00*pg*.pdf). The
>description is more complete than in openpic.pdf, although there are still
>bits which can be toggled and are not documented. 

I'll look into those, thanks.

>Note that on my machines with OpenPIC I have modified the 8259
>interrupt handler to better coexist with the openpic: I have defined
>another class of interrupts (struct hw_interrupt_type cascaded_i8259_pic) 
>to handle the case of a 8259 behind an OpenPIC in a cleaner way.

Are those in your MVME patches ? (Could you remind me the URL ?)

>The version number looks correct, but are you sure of the timer frequency
>address ?  0x80000000 is the power up value of all the vector/priority
>registers while the power up value of the timer frequency is 0, so this
>looks suspiscious.

That what the current code returns, but I'll do some xmon hacking this
week end to figure this out. Since the open-pic is inside Apple's ASIC,
it's possible that they actually changed the register layout, moved the
interrupt vectors down and removed the timer (this may also explain why
the init code hangs). Also, they do have a separate timer node in the
device tree (different from the openpic node and from the VIA node, but
still inside the Keylargo ASIC).

>It must be on same (sub)part as the key-largo (otherwise you would need 2
>PCI buses, which means even more pins...).

Yes, I think so too, but I'll have to check this on an iMac or a G4 (the
iBook doesn't have any other PCI chip).

>Oh well, as long as the RTAS handles this properly... 

But with BootX, we don't have RTAS ! (I didn't manage to rip off MacOS
RTAS instance). That's one of the reason I think BootX is not a good idea
for newworld machines. Once I've finished this support, I plan to do some
new booter work, basically with something based on miBoot for old-world
buggy OF machines and install CDs, and an OF booter for all of us. I
already have tons of ideas, I just lack time ;)

>And why make things simple when they can be made awkward ? 

;)

Ok, back to code now...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

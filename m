Date: Fri, 22 Oct 1999 14:42:43 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: need Open PIC infos (and more)
In-Reply-To: <19991022105510.004059@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.9910221123110.21757-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Fri, 22 Oct 1999, Benjamin Herrenschmidt wrote:

> On Fri, Oct 22, 1999, Gabriel Paubert <paubert@iram.es> wrote:
> 
> >I don't know on which board the 8259 is a master of the OpenPIC. On CHRP
> >boards and Motorola with Raven or Hawk chipsets, the 8259 is the slave 
> >connected on interrupt 0 of the OpenPIC. If you don't have a 8259 on this
> >input of the OpenPIC then input 0 behaves like any other input and you'll
> >have to program it as edge/level as per the specification. 
> 
> That's what I figured out. One problem I have is that I don't know which
> interrupts are level and which are edge triggered (looks like this
> information is not in the device tree, or not where I looked for it).

It should be somewhere, how do  your interrupt cells look like ? (one or 2
entries) Otherwise maybe the firmware sets them corectly and you don't
have to change them.

> Also, the initialisation code of the OpenPIC hangs when trying to
> initialize interrupt 48. The PIC tells it has 64 interrupts (it's a 1.2
> OpenPIC revision, I correctly get the MacOS-initialised NMI on interrupt
> 55 when pressing cmd-power). I didn't look in more details yet (that's
> why I was asking for the doc ;)

I thought that this was specified in the interrupt property of each device
and of the parent bus node but I can't find the reference right now. I'm
no more using OF (unfortunately) and the one I had on my machines was
truly awful (there was no pci interrupt routing information AFAIR, no
RTAS, the entry for the interrupt controller was mpic@1f when it should
have been mpic@0, etc...)

> >Note that on my machines with OpenPIC I have modified the 8259
> >interrupt handler to better coexist with the openpic: I have defined
> >another class of interrupts (struct hw_interrupt_type cascaded_i8259_pic) 
> >to handle the case of a 8259 behind an OpenPIC in a cleaner way.
> 
> Are those in your MVME patches ? (Could you remind me the URL ?)

Yes, they are there (along with other things): 

	ftp://vlab1.iram.es/linux-2.2/*patch*

> That what the current code returns, but I'll do some xmon hacking this
> week end to figure this out. Since the open-pic is inside Apple's ASIC,
> it's possible that they actually changed the register layout, moved the
> interrupt vectors down and removed the timer (this may also explain why
> the init code hangs). Also, they do have a separate timer node in the
> device tree (different from the openpic node and from the VIA node, but
> still inside the Keylargo ASIC).

Then they can't claim it's chrp,openpic of anything similar...

> But with BootX, we don't have RTAS ! (I didn't manage to rip off MacOS
> RTAS instance). That's one of the reason I think BootX is not a good idea
> for newworld machines. Once I've finished this support, I plan to do some
> new booter work, basically with something based on miBoot for old-world
> buggy OF machines and install CDs, and an OF booter for all of us. I
> already have tons of ideas, I just lack time ;)

I lack time too. And I've never used a Mac. Still planning to buy a PB...

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

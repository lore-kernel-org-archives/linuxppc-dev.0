Message-Id: <199901131910.LAA28570@saul9.u.washington.edu>
From: a sun <asun@saul9.u.washington.edu>
To: "David A. Gatwood" <marsmail@globegate.utm.edu>
Subject: Re: Porting to NuBus PowerMacs
Date: Tue, 12 Jan 1999 14:31:03 -0600 (CST)
cc: linuxppc-dev@lists.linuxppc.org, bh40@calva.net
In-Reply-To: <19990112162631.B29622@dirkpitt.solsoft.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



[David Gatwood wrote:]

    It's a lot harder than this, unfortunately.  The NuBus machines'
    memory isn't contiguous. Thus, code would have to be written and/or
    obtained to find out what memory is available in the machine and where
    that memory is located in RAM.  That's going to be a nasty problem
    unless some code is pulled from the MkLinux booter.  I'd expect that
    to also require a substantial number of changes to the way memory is
    handled in linux, but I could be wrong.

erk. i hadn't thought about that. from looking at the ppc mm code
though, it looks like it should be able to handle chunks of
memory. the m68k and the apus code certainly look like they can handle
being passed chunks of addresses/sizes. hopefully, it shouldn't be too
bad...

so, ben, i guess i'll also need memory addresses/sizes as well. after
perusing the m68k code, i think that's the only thing that i forgot to
tell you about. this will essentially make bootx report essentially
the same information as the m68k boot loader.

    Beyond that, it will also require changes to irq.c to handle the
    interrupt controller and a lot of code for DMA, if that's desired (I
    don't think it's even remotely similar, AFAICT).  Of course, that
    stuff can be obtained from Mach, but it'll be a lot of work.  

well, my "oh so clever plan" is actually to use the gestalt
information to mock up something that i pass to the m68k interrupt
routines. presto! no more uglification of irq.c. given the
similarities between the apus stuff and the nubus powermac stuff, i'm
actually turning the nubus powermacs into a variant of apus for now. a
lot of my fiddling actually ends up making some minor changes to the
m68k code and calling that instead. 

for now, i'm conveniently ignoring the dma stuff, but it looks like
modifying the mac68k devices will actually prove to be more useful
than dealing with the the standard pci powermac stuff. 

    Oh, and the i/o base address is different, which may or may not be
    a problem, and supporting certain pieces of hardware (which will
    remain nameless) will also require speed penalties (this is the
    other reason MkLinux is slower than LinuxPPC...).

heh. am i correct in assuming then that just using memory barriers
just won't cut it for a certain device that seems to have a bunch of
delay()'s sprinkled throughout it? strangely, this same piece of
hardware seems to be necessary to get the newer tech g3 extension and
the mklinux booter happy... any insights there?


-a
asun@u.washington.edu

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

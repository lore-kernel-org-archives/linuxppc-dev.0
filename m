Date: Wed, 7 Apr 1999 12:24:35 +0200
To: linuxppc-dev@lists.linuxppc.org
CC: a sun <asun@saul9.u.washington.edu>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Resurrecting mkLinux
Message-Id: <19990407122435.017707@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 7, 1999, a sun <asun@saul9.u.washington.edu> wrote:

>once a working boot loader is done, it actually shouldn't be too
>difficult to get things working. the hairiest part will probably be
>the tweaking that head.S needs. however, the apus code actually
>fiddles with the exception table and copies its virttophys constant
>into a specific memory location. i think we should be able to do
>something similar with the nubus powermac code as well to deal with
>memory holes if need be.

I think I'll finally have to dive into this now ;-)

So basically, I'll keep BootX behaviour similar, but the device-tree
pointer in the boot-infos will be 0, and I'll add a couple of fields
(machine ID and memory ranges extracted from MacOS nanokernel). I'll make
sure the internal video is located at 1MB phys instead of 0.

Just a question: Where should I place the kernel ? Current BootX copies
the kernel pages at 0 (physical). Should I do the same with a hole in the
kernel, should I do the same without a hole (overriding video memory: the
screen will display garbage during boot), or should I put the kernel in
the first large enough physically contiguous piece of memory I find and
let it relocate itself ?

BootX can do any kind of relocation quite easily before entering the
kernel, the little "bootstrap" that I run when switching to supervisor
and before entering the kernel will, after disabling the MMU, execute a
list of page copy operations, this list is pre-built by BootX, and so can
easily be adapted to make the necessary hole.

What is the APUS bootloader doing ? (Will it load the kernel at a fixed
address ?)

For those who didn't follow earlier discussions, there are actually two
problems with the memory mappings:

 - The on-board video uses the in-RAM framebuffer at either 0 or 1Mb
(physical). I know how to change it from 0 to 1Mb if MacOS sets it to 0.

 - The memory banks are generally not physically contiguous. Depending on
the motherboard and the organisation and population of the SIMM slots
(each SIMM bank resides at a fixed address, and I think on-board soldered
RAM lives at 0).

I'm working on BootX now (still those problems with boards still doing
DMA while the kernel is beeing copied), I'll try to find some time to put
some basic code for NuBus this week. Stay tuned.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Date: Tue, 12 Jan 1999 14:31:03 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Hubert Figuiere <Hubert.Figuiere@solsoft.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Porting to NuBus PowerMacs
In-Reply-To: <19990112162631.B29622@dirkpitt.solsoft.fr>
Message-ID: <Pine.LNX.3.96.990112141237.3746A-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 12 Jan 1999, Hubert Figuiere wrote:

> I'd like to know what would be the complexity of porting LinuxPPC
> to NuBus PowerMacs ?
> 
> Here are my thoughts:
> 
> -we have BootX. So we can BootX LinuxPPC. We just need to build a
>  fake OpenFirmware device tree for BootX so he can pass it the
>  kernel
> 
> -we have the source of the Mach MicroKernel, hence we have enough
>  to rewrite the specification to rewrite drivers for LinuxPPC.
>  Some components and drivers may directly come from Linux Mac68k.

It's a lot harder than this, unfortunately.  The NuBus machines' memory
isn't contiguous.  Thus, code would have to be written and/or obtained to
find out what memory is available in the machine and where that memory is
located in RAM.  That's going to be a nasty problem unless some code is
pulled from the MkLinux booter.  I'd expect that to also require a
substantial number of changes to the way memory is handled in linux, but I
could be wrong.

Beyond that, it will also require changes to irq.c to handle the interrupt
controller and a lot of code for DMA, if that's desired (I don't think
it's even remotely similar, AFAICT).  Of course, that stuff can be
obtained from Mach, but it'll be a lot of work.  Oh, and the i/o base
address is different, which may or may not be a problem, and supporting
certain pieces of hardware (which will remain nameless) will also require
speed penalties (this is the other reason MkLinux is slower than
LinuxPPC...).


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624

-----BEGIN GEEK CODE BLOCK-----
Version 3.1
GCS/CC/FA/H/L/MC/M/MU/PA/TW d-@ s:>- a-- C++ ++>$ UBLAS*++ ++>$
P+?>$ L++ +>$ !E--- W++ +>$ N++(++ +)>++ +$ !o? K-? !w--- !O
M++>$ !V-- PS+>$ !PE- Y+>$ PGP+>$ t++ +>$ 5+>++ ++$ !X- !R tv+>$
b++>$ !DI !D- G++(++ +)>$ e>++ ++ h--! r--- !y-
------END GEEK CODE BLOCK------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

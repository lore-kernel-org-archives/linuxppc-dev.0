Message-Id: <200003041016.LAA00502@piglet.grunz.lu>
Date: Sat, 4 Mar 2000 11:16:19 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PCI I/O address problems on B&W G3
To: tas@mindspring.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04220801b4daa2e26f84@[10.0.0.42]>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tim,

A few more details on this issue (I've already responded to a later
mail in this thread, but I'm still struggling with my 3-weeks
800-message backlog ;-)

On  24 Feb, this message from Timothy A. Seufert echoed through cyberspace:
> I'm having a problem with the assignment of I/O addresses to devices.
> Multiple PCI devices end with the same I/O port address base,
> presumably because OF didn't fully initialize them.  I am using
> Michael Lanner's PCI patch (applied to kernel 2.2.15-pre5 from cvs a
> while back).  After reading the patch, it looks like it only tries to
> correct base addresses for being behind a bridge, so I don't think it
> is either helping or hurting.

My patch corrects base addresses because the _host_ bridge isn't
address-transparent for IO regions. Memory regions are always
untranslated, and PCI-to-PCI bridges in Macs (as far as I've read
Apple's doc) don't do any address translation.

I've made the patch because I use a PCI IDE controller, and I was
annoyed by the fact that the PMac IDE code applies that translation for
PCI IO addresses in it's IO access macros. I think this translation
should be handled by PCI fixup code. Plus, you sometimes don't even
have a single translation, if you have multiple host bridges (that's
the case as well for UNI-North machines, even though all buses are PCI
0).

> So it would seem to me that we need some kind of a scheme for
> allocating I/O port base addresses if OF didn't do it.  I'm vaguely
> familiar with the concepts behind PCI address space allocation,
> having looked at it from the hardware design POV a while back, but
> I'm not familiar enough with the kernel code yet to tackle this
> problem (or to even be sure that I'm on the right track here).

That should be handled by the new, 2.3 PCI code with dynamic resurce
allocation. I've just discovered that part, however, and am not at all
familiar with it. I'm RTFS'ing...

> PCI: Correcting IOaddress 0 on device 01:18, now fe000001.
> PCI: Enabling I/O for device 01:18
> PCI: setting IRQ 25 on device 01:20.
> PCI: Correcting IOaddress 0 on device 01:20, now fe000001.
> PCI: Correcting IOaddress 0 on device 01:21, now fe000001.
> PCI: setting IRQ 28 on device 01:30.

This is OF not initialising the IO spaces, and my patch not checking
for unassigned IO regions.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

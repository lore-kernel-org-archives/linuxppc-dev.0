Message-Id: <200003090658.HAA00456@piglet.grunz.lu>
Date: Thu, 9 Mar 2000 07:58:03 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Grabbing an Interrupt for a Brain-dead PCI Device
To: geert@linux-m68k.org
cc: grant@borg.umn.edu, mmporter@home.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.05.10003082011320.8208-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   8 Mar, this message from Geert Uytterhoeven echoed through cyberspace:
>> Also, regarding memory address space resources, is there a routine I can
>> call that says "Assign this card some resource space because it hasn't
>> been assigned one yet"?
>
> Yes there is, somewhere in drivers/pci/. I don't know yet whether it works.

I doubt it will work on a PowerMac; see what the resource 'checking'
code finds as parent resources (r is a mem resource, pr is its parent
resource):

Mar  9 07:24:29 piglet kernel:    Resources: r.start=f2000400, r.end=f200043f,
pr.start=00000000, pr.end=ffffffff.

As far as I can tell, parent resource would be the memory region held
by the parent bridge, out of which this region was allocated. A bit
huge, this region, isn't it?

Then again, Apple's host bridges might not conform entirely to the PCI
spec in the way they advertise their resources available for
assignment...

Those with the PCI spec at hand out there, is there such a thing as
resource registers in bridges (be it P2P or host) that inform about
what is available to devices behind this particular bridge?

Maybe there's another job for the fixup code...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

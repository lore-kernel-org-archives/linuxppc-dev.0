Date: Thu, 9 Mar 2000 13:52:03 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Michel Lanners <mlan@cpu.lu>
cc: geert@linux-m68k.org, grant@borg.umn.edu, mmporter@home.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Grabbing an Interrupt for a Brain-dead PCI Device
In-Reply-To: <200003090658.HAA00456@piglet.grunz.lu>
Message-ID: <Pine.HPX.4.10.10003091341310.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> I doubt it will work on a PowerMac; see what the resource 'checking'
> code finds as parent resources (r is a mem resource, pr is its parent
> resource):
>
> Mar  9 07:24:29 piglet kernel:    Resources: r.start=f2000400, r.end=f200043f,
> pr.start=00000000, pr.end=ffffffff.
>
> As far as I can tell, parent resource would be the memory region held
> by the parent bridge, out of which this region was allocated. A bit
> huge, this region, isn't it?

Indeed...

> Then again, Apple's host bridges might not conform entirely to the PCI
> spec in the way they advertise their resources available for
> assignment...

They probably do, at least OF should get it right in the range properties
of every bus (that's what I have on a very buggy OF for PreP Motorola
boards):

ranges                   01000000 00000000 00000000 80000000 00010000
                         01000000 00000000 01000000 81000000 3e800000
                         02000000 00000000 00000000 c0000000 3c000000
			 c172616e 67657386 0005c32c

the first 2 lines indicate how the I/O space is mapped from the processor
and the 3rd the PCI memory  space. The last line is junk...

> Those with the PCI spec at hand out there, is there such a thing as
> resource registers in bridges (be it P2P or host) that inform about
> what is available to devices behind this particular bridge?

P2P do have them, host bridges do not have them although they often have
chip specific registers which allow t ochoose between several options or
to program where the I/O space.

> Maybe there's another job for the fixup code...

Indeed, actually /proc/iomem on Intel includes even the RAM ! What is
needed is to include one hierarchy level to define the physical addresses
which the bridge forward to PCI (I started a patch but never finished it).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

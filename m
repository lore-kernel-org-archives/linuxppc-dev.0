Date: Fri, 24 Mar 2000 16:56:14 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003241443040.21215-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.HPX.4.10.10003241456491.14656-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Michael Schmitz wrote:

> > Don't touch the resources which correspond to assigned PCI bus addresses
> > because they correspond to the address ranges to which chip decoders
> > respond. Lying in this area makes dynamic allocation and hotplugging
> > impossible by giving the resource allocator the impression that some area
> > is free. Rather attach asubtree to the already existing device resources.
>
> So it's perfectly legal for resources within the same device to overlap?
> WTF does X not tolerate this and disables the overlapping one?

It may be legal if the internal decoders are prioritized and the priority
is the right one (which it should if the firmware has set it up this way).
I don't consider it good practice though, especially when it saves only
minute amounts of address space. X should tolerate this in any case
however, it should admit that it is not always smarter than the firmware.

> I'm not sure adding subtrees will help - I guess X might go ahead and
> disable the main resources anyway. Will the subtree resources remain
> accessible in that case?

Yes, but then I have given up on trying to understand X :-( Oh and the
case I had was somewhat different, since base registers never overlap,
only that a single base registers defined several independant areas.
What I was suggesting is that if you need it you should add a subtree to
the vram area with for example (that's completely made-up for my S3 and
I did not even look at the reference, so the offsets night be wrong):

f8000000-fbffffff: S3 Inc. 86c764/765 [Trio32/64/64V+]
  f8000000-f8ffffff: Little endian VRAM aperture
  f9000000-f9ffffff: Big endian VRAM aperture

and perhaps even another line with MMIO registers if applicable. Only the
first line would appear in lspci, but you could get all the info from cat
/proc/iomem.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

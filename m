Date: Thu, 2 Nov 2000 17:16:39 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Todd Inglett <tinglett@vnet.ibm.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Yet another RS6k whipped!
In-Reply-To: <3A018ED0.AEAA1B40@vnet.ibm.com>
Message-ID: <Pine.HPX.4.10.10011021702490.15431-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2 Nov 2000, Todd Inglett wrote:

> Gabriel Paubert wrote:
>
> > Ok, there were a few bugs with Openpic on PreP: some functions were marked
> > __chrp while openpic support is a completely orthogonal issue. Yours seems
> > to work, however, which source tree are you using ?  (I'm still basing
> > everything on kernel.org).
>
> I may still have trouble here.  My code was based on a test8 kernel that
> Tom snagged.  I hope I can reproduce it in test10 :).
>
> > Besides this, it's fairly close to what I do on my MVME boxes: the
> > firmware puts them in PreP mode and I reorganize them as CHRP. This forces
> > me to reorganize all the PCI space (but the code has not been with bridges
> > and will probably fail). You have open firmware, which is hopefully more
> > flexible than PPCBUG which I have to use.
>
> This is exactly what I want to do.  Any big pitfalls you can recall?
> Guess I need to have a look at your patch.  I'm assuming you have a
> Grackle.

No, I have Raven/Falcon or Hawk from Motorola computer group. But I
configure them almost exactly like an MPC106 (aka Grackle):

- same range for PCI/ISA I/O space (0xfe?????? IIRC)
- same range for ISA memory (0xfd?????? IIRC)
(if it's not like this, it's the other way around).

Big pitfalls, not many, but beware that you can't debug anything while you
reconfigure and that everything moves under your feet (even the adress of
the serial port).

Take any kernel and apply the patches from vlab1.iram.es, the important
code (the bootloader which does all the reconfiguration) will appear in
the arch/ppc/prepboot directory. With OF it might be more complex however
(you probably have to do all OF calls before switching the mode, I suspect
that OF won't like the NVRAM going somewhere else why you read the device
tree). I have code for this but it is largely untested (I have an older
board which I can switch between OF and PPCBUG, but the OF is so buggy).

As I said, the code does not handle PCI<->PCI bridges proprly. But the
allocation algorithm can be made to work with bridges, I just did not
have the hardware.

This algorithm is somewhat different from the default one used in the
linux kernel: it sorts by size before allocating which makes the
allocation more compact (an optimization valid only at boot time) and it
consolidates free space at one end of the address range which is what I
need for large windows on the VME bus.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Fri, 14 Sep 2001 18:00:16 -0400 (EDT)
Message-Id: <200109142200.f8EM0Ga467859@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: grave@ipno.in2p3.fr
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: mvme5100 hawk configuration problem ?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Xavier Grave writes:

> I have two board with a 2.4.10 kernel (bk tree) :
> on the mvme2303 cat /proc/iomem gives :
> c0000000-feffffff : PCI host bridge
> effeef80-effeefff : Digital Equipment Corporation DECchip 21140 [FasterNet]
> effef000-effeffff : Tundra Semiconductor Corp. CA91C042 [Universe]
> fc000000-fc03ffff : Motorola Raven
> on the mvme5100 cat /proc/iomem gives :
> 00000000-ffffffff : <BAD>

That line looks very wrong. I have it on a Force PowerCore 6750 (VME),
and I think it screws up PCI resource allocation. My iomem:

00000000-ffffffff : <BAD>
  3ff00000-3fffffff : foo
  40000000-7fffffff : foo
  bfffec00-bfffefff : Digital Equipment Corporation DECchip 21142/43
    bfffec00-bfffefff : tulip
  bffff000-bfffffff : Tundra Semiconductor Corp. CA91C042 [Universe]

Ugh, I also have the problem for ioports:

00000000-ffffffff : <BAD>
  000002f8-000002ff : serial(set)
  000003f8-000003ff : serial(set)
  00bfef00-00bfef7f : Digital Equipment Corporation DECchip 21142/43
    00bfef00-00bfef7f : tulip
  00bfefc0-00bfefcf : Symphony Labs SL82c105
  00bfefd0-00bfefdf : Symphony Labs SL82c105
  00bfefe4-00bfefe7 : Symphony Labs SL82c105
  00bfefe8-00bfefef : Symphony Labs SL82c105
  00bfeff4-00bfeff7 : Symphony Labs SL82c105
  00bfeff8-00bfefff : Symphony Labs SL82c105
  00bff000-00bfffff : Tundra Semiconductor Corp. CA91C042 [Universe]

Check a plain x86 PC for proper resource usage.

> I have written a module driver for the vme chip real-time and non-real-time
> (it is very inspired from the one from
> Gabriel Paubert), the modules load without problem on the mvme 2303 but not
> on the mvme5100 ?

Gee, why don't we have a driver for this damn chip in the main kernel?
It seems that just about everybody gets stuck cobbling together some
sort of hack for VME, usually with that damn Tundra Universe chip.

> Any idea of the problem ? I will have a look on the mvme5100_setup.c and
> mvme5100_pci.c files.

I think you are looking in the right place.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

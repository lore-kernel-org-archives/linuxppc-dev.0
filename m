Message-Id: <200009190556.HAA00805@piglet.grunz.lu>
Date: Tue, 19 Sep 2000 07:56:26 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
To: paulus@linuxcare.com.au
cc: geert@linux-m68k.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <14790.58502.25252.825448@argo.linuxcare.com.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul,

On  19 Sep, this message from Paul Mackerras echoed through cyberspace:
> What I am intending to do is to map the I/O space of all the PCI host
> bridges in consecutive areas beginning at some address such as
> 0xff000000, with some amount of space such as 64kB or 1MB per bridge,
> whatever is appropriate.  Then we adjust the I/O port numbers in the
> pci_dev structures by adding on host_bridge_nr * space_per_bridge.  As
> a side effect, isa_io_base (which is really pci_io_base) becomes a
> constant.

Good idea. Keep in mind however, that not all bridges reserve the same
amount of space for IO. So you either need to cope with that, or chose
smaller, fixed-size regions, and be prepared to squeeze all devices into
that space. Which shouldn't be a problem, since I can't see why someone
would want to access something larger than a few bytes via IO...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

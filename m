Message-ID: <3BC73FDB.8E6F6672@we.mediaone.net>
Date: Fri, 12 Oct 2001 12:09:15 -0700
From: Dan Taylor <danieltaylor@we.mediaone.net>
Reply-To: danieltaylor@acm.org
MIME-Version: 1.0
To: Kevin Fry <kevin@carts.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI support
References: <3BC7388E.CEBF1416@carts.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The code would have to be added in one or two places.  First, update
the PCI code in .../linux/arch/ppc/kernel; your hardware may be like
a sandpoint, but could be chrp.  If, as I suspect, the PowerSPAN is
NOT a transparent PCI-PCI bridge, you will also need to modify the
.../linux/drivers/pci/pci.c code that handles child busses.  I usually
put an "else if" inside the "for" loop after "pcibios_fixup_bus()".
That way the existing code handles any transparent bridges, then I can
specify an implementation-dependent bridge, either by bus & device, by
checking checking the vendor and device IDs, or both.  You have to do
all of the same things that the transparent bridge does, so just copy,
paste, and edit the code inside that "if".  You need to have the kernel
code done first, since that will have the config cycle handling and
memory/io space mapping.

Kevin Fry wrote:
>
> I'm trying to setup a PCI bridge on our 8260 board here, and was
> wondering if a driver exists for the Tundra Powerspan. We're using Hard
> Hat Linux 2.0 JE
>
> If I write my own drivers, where would the board-specific PCI routines
> go in the kernel code? I found the function prototypes in linux/pci.h,
> but couldn't find any pci code itself.  Does HHL 2.0 JE support PCI?
>
> Thanks!
> Kevin Fry
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

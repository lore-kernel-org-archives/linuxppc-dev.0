From: Paul Mackerras <paulus@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org, "David W. Patmore" <dwp@bluesteelnet.com>
Subject: Re: G4 + Linux + PCI device + x86 driver = 0
Date: Mon, 15 Nov 1999 10:50:24 +1100
Content-Type: text/plain
References: <NDBBKOPFGLPEGICBJFDIAEDMCCAA.dwp@bluesteelnet.com>
MIME-Version: 1.0
Message-Id: <99111510562201.03543@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 14 Nov 1999, David W. Patmore wrote:

> The original x86 (Redhat 6.0) driver uses virt_to_bus() to get the address
> to write to.  In LinuxPPC, that function is not available (not in name
> table).  I guess that I'm supposed to use ioremap(), but that doesn't seem
> to do it for me either.

virt_to_bus is an extern inline function in <asm/io.h>, so you should be
able to use it.  What undefined symbols do you get when you try?  (Note
that you have to compile with at least -O2 otherwise gcc doesn't do inline
functions.)

If you want to access the device register within your driver, ioremap is
what you want, though, rather than virt_to_bus.  You would use virt_to_bus
to translate the virtual address of some kernel memory into a bus address
to program into a DMA controller.

> The outcome of running this code is:  pci base address (0x80890000),
> remapped (0xC8271000), data (0xFFFFFFFF).  The data is a status word which I
> expect to be not
> all "F"s.

Most likely the device doesn't have PCI memory space accesses enabled, as
Ryuichi pointed out.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

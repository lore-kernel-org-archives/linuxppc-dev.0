Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18107.59976.91379.154249@cargo.ozlabs.ibm.com>
Date: Fri, 10 Aug 2007 14:32:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Subject: Re: pci in arch/powerpc vs arch/ppc
In-Reply-To: <twig.1186602365.9125@inaccessnetworks.com>
References: <op.twhnwi18nhx3hy@phoenix>
	<20070803201036.GA18229@ld0162-tx32.am.freescale.net>
	<F081E320-CFF9-497C-87D5-50E2E5C15A24@kernel.crashing.org>
	<op.twol4cixnhx3hy@phoenix> <46B88DAC.70005@freescale.com>
	<op.twqn4vtsnhx3hy@phoenix> <op.twqvg3i0nhx3hy@phoenix>
	<twig.1186602365.9125@inaccessnetworks.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alexandros Kostopoulos writes:

> In mpc8272ads.dts, the ranges property for pci is:
> 
> ranges = <42000000 0 80000000 80000000 0 20000000
>           02000000 0 a0000000 a0000000 0 20000000
>           01000000 0 00000000 f6000000 0 02000000>;
> 
> The third obviously corresponds to IO space. So, shouldn't the res->start for 
> the host bridge be set to f6000000 ? Because, currently, based on what I've 

No.  The "addresses" in the resource structs for PCI I/O space are
basically PCI I/O port numbers (with a bit of a swizzle for host
bridges other than the primary bridge), whereas the "addresses" in
resource structs for PCI memory space are actually host physical
addresses.

This difference is reflected in the difference between inb() and
readb(); inb() adds pci_io_base on to the port number, which comes
directly from the resource struct.  In contrast, to use readb, you
get the PCI memory space address from the resource struct and pass
that through ioremap to get the cookie (actually the kernel virtual
address) to pass to readb, which doesn't add anything to it before
dereferencing it.

For host bridges other than the primary bridge, we add an offset to
the start/end values in the resource structs in
pcibios_fixup_resources so inb/outb work as expected.

> described in my previous mail, it gets set to 0. It seems to me like a matter 
> of incorrect parsing of the device tree from pci_process_bridge_OF_ranges() 
> for IO space. Or am I missing something else here, and it should actually be 
> 0?

It should actually be zero.  What you have is a disagreement between
the firmware writer (who thinks 0 is a perfectly valid I/O port
address assignment) and the driver writer (who thinks 0 isn't valid).

Paul.

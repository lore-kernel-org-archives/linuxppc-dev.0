From: "Ron Bianco" <ronb@junction.net>
To: "LinuxPPClist" <linuxppc-embedded@lists.linuxppc.org>
Subject: query on ppc/kernel/head.S for generic 8240
Date: Tue, 18 Jul 2000 12:08:12 -0700
Message-ID: <000101bff0eb$84c50b30$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm working on a kernel for our custom 8240 board, starting with MontaVista's Sandpoint
config.
The only config changes I've done so far are the SCSI and Ethernet driver choices.
Attempting to remove the mac keyboard causes linking problems I don't want to deal with
right now.
And as I don't have a UART I'll have to do a special console driver at some point, but for
now I modified printk() to just put the strings into a large buffer that I can monitor
with the JTAG debugger.

I'm concentrating on the kernel itself at the moment so I can use it to help me verify
that the PCI SCSI and Ethernet chips are working OK, so I can get the Rev B version of the
board into the fabrication pipeline, and then continue with further software dev.

When I first started looking at the Linux kernel code, I thought the loader/decompressor
portion might do some required initialization before decompressing, loading and starting
the kernel.   Thanks to Dan Malek for pointing out that one could concentrate on the
kernel itself with no worries.

So, since I'm ignoring the loader/decompressor and will have a custom loader,  I changed:

KERNELLOAD in file:  arch/ppc/Makefile from C0000000 to 00000000
PAGE_OFFSET and therefore KERNELBASE in file:  include/asm-ppc/page.h from C0000000 to
00000000

Would this break anything?  Is this sufficient?

In file:   arch/ppc/kernel/head.S,  I'm wondering if can branch directly to   start_here:
as I don't see anything useful in the code before that for my purposes?  All I have to do
is make sure the stack pointer is set to some innocuous place first?

Is there an advantage to using the residual data mechanism?  i.e. to create a version that
matches my hardware?
Or is this strictly for the pmac or some specific BootROM?

Thanks, Ron

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <3960B92B.6CB96DE5@lucent.com>
Date: Mon, 03 Jul 2000 11:02:51 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: Kwansuk Kim <kskim@neowave.co.kr>
Subject: Re: -Ttext  for Kernel
References: <NEBBKFENMLEDKDHMEHPJGENHCAAA.kskim@neowave.co.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kwansuk Kim wrote:
> I saw the makefile then I found that one of the link options for the kernel is '-Ttext 0xc000 0000'.
>
> I know it means linker links the objects from address 0xc000 0000. I
> think it should be 0x0000 0000, because the kernel is decompressed
> from address 0x0000 0000 > and the headers are used exception handler
> (e.g. 0x100 is used for reset)

The kernel is linked at VIRTUAL address 0xC0000000, but is expected
to be loaded at PHYSICAL address 0x00000000. The decompression function
runs with the MMU disabled, and should place the decompressed kernel
at address 0x00000000 and then jump to address 0x00000000 (but it starts
with 3 nop-s, so address 0x0000000C is OK). The kernel must be loaded at
physical address 0 because that is where the hardware exception vectors
are located; that is also where most platforms put the start of RAM.

	Note: Linux refers to "virtual" addresses, while the PowerPC
	documentation refers to "effective" addresses. With the MMU
	enabled these are the same. The CPU core always uses effective
	addresses; with the MMU disabled, effective=physical and
	virtual addresses cannot be used. Whenever an exception causes
	the CPU to go into real mode (MMU disabled), Linux re-enables
	the MMU as soon as possible so it can use its virtual addresses.

The initial startup-of the kernel is in head.S, and it takes into
account the fact that it is entered with the MMU disabled. It performs
some initial initialization and then configures the MMU to map
virtual address 0xC0000000 to physical 0x00000000 and enables the MMU
(it's really more complicated, but that is the essence).

This behavior is dictated by the necessity to permit different
platforms to use different boot ROMs -- all share the property that
the boot ROMs do not use the MMU and the boot ROM starts at physical
address 0xFFF00100 where the hardware starts after a reset.


> Should I change the address to 0x0000 0000 or do something else?

I would not change it, because if you do then all of the available
pre-compiled Linux programs won't work on your system. Moreover,
you are unlikely to find each and every place where the kernel code
implicitly assumes it is linked at virtual address 0xC0000000; there
are many.


> But, after that machine check exception is appeared, because IP is
> 0xc000 XXXX. (which I do not use.)

You may not use such an IP, but Linux sure does. Remember that this
IP is a VIRTUAL address. It physically corresponds to physical address
0x0000XXXX. If your system does not have valid RAM there you will have
great difficulty using Linux. At a guess, assuming your system does
have valid RAM there, this machine check is probably unrelated to the
link and/or load address of Linux; it is probably attempting to
reference some non-existant I/O device.


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

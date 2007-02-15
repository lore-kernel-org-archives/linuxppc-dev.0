Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id 38942DDECE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Feb 2007 02:55:07 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RE: How can I boot a program from flash on ML403?
Date: Thu, 15 Feb 2007 07:55:05 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3CB05893@ehost011-3.exch011.intermedia.net>
In-Reply-To: <000001c750d0$9e609d60$10b2a8c0@lorenzulm>
References: <mailman.120.1171370674.21008.linuxppc-embedded@ozlabs.org>
	<000001c74fa0$ce627870$10b2a8c0@lorenzulm>
	<406A31B117F2734987636D6CCC93EE3CF9D7A1@ehost011-3.exch011.intermedia.net>
	<000001c750d0$9e609d60$10b2a8c0@lorenzulm>
From: "Leonid" <Leonid@a-k-a.net>
To: "Lorenz Kolb" <linuxppcemb@lkmail.de>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday, February 14, 2007 11:12 PM Lorenz Kolb
> > I use the same scheme (called 3-stage boot) but I don't see what is
dirty
> > about it. For testing/debugging you even can load u-boot directly
into
> > memory using XMD. Of course, image must be compiled to run from
memory,=20
> > not flash.

> actually I call it dirty as SREC is a quite stupid format (for a=20
> bootloader,
> as it has to be decoded first) and so the loader wastes a lot of time
at
> least for productive use we do not want this three stage boot.
[Leonid] When I use "3-stage boot" name I actually don't mean that SREC
format used in production. This is too slow indeed. Here how it works
for me:
- u-boot is ALWAYS compiled to run directly from RAM. You can place it
on flash using JTAG or u-boot itself on later stage (see below).
Compilation results include binary (for flash burning), ELF and SREC
files.
- Early boot (tiny BRAM based program) wakes up, checks whether u-boot
presents on the flash (can be different criteria) or wait for some input
or read some config to know where pick up u-boot from. If it's on the
flash already, early boot copies u-boot to RAM and launches it,
otherwise waits for SREC file to be sent via serial interface, copies it
into RAM and starts.
- u-boot does the rest of job (linux boot, etc...). On this stage you
can use u-boot to program u-boot image (compiled to run from RAM) onto
the flash for next reboot.

This scheme works perfectly for ARM, Xilinx and actually is a good
choice for any architecture where CPU itself fetches boot code from boot
location into memory (ARM) or code can reside in RAM from the very
beginning (FPGA with soft/hard CPU cores). In traditional approach (with
relocation) u-boot kind of contains both functionalities which probably
best choice for traditional PPC boards. =20

> Actually my partner and I even fitted an u-boot directly into BRAM (if
it > is loaded via XMD),=20
[Leonid] I also use XMD but load u-boot ELF directly to RAM. Early boot
is not used in this setup and this is quickest and most convenient way
for debug.

Best Regards,

Leonid.

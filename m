Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3ABA6144.CF8D07C1@sthoward.com>
Date: Thu, 22 Mar 2001 12:32:04 -0800
From: Scott Howard <scott@sthoward.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EST SBC8260
References: <3ABA21C9.4090003@timesys.com> <3ABA33FA.4FD3B2B0@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The EST monitor ('VisionWare') has the ability to download images via
TFTP, either directly to RAM or to a file in its on-board flash file
system.

The catch is that the image has to be in EST's 'BDX' format. ELF files
can be converted to BDX using EST's 'convert' utility. Your EST
salesperson or FAE should be able to get you a copy of this program.

I was also able to load and boot a Linux kernel from the on-board
monitor. When building the kernel, you need to use the command 'make
vmlinux'. 'make zImage' creates an ELF file where the compressed kernel
image does not appear in the file's program header, and thus it will not
convert properly into BDX format. If you are using a RAM disk as your
root filesystem, then the RAM disk image also needs to be converted to
BDX format so it can be downloaded as well.

The last detail is that the kernel uses a value for the IMMR register
that is different from that set up by visionWare, and it loads at
address 0 which is protected by the visionWare monitor; so some minor
mods are necessary to the boot code to load at some other address,
re-write the IMMR, relocate to zero and then continue with the remainder
of the boot process.

Scott

Dan Malek wrote:
>
> Michael E Crowe wrote:
>
> > .... In order to put a linux kernel
> > onto this board, do I have to also purchase a JTAG from WindRiver like
> > the VisionProbe or is the monitor that resides on the board enough to
> > get PPCBoot working on it?
>
> The early boards I used didn't have much of a monitor, so I always
> used JTAG.
>
> The main problem is the Wind tools assume the monitor is in the on-board
> flash, and the SIMM is a flash disk.  If you power up the board, the
> monitor will re-write the SIMM into something it understands, so you
> can't put code out there and expect it to survive (at least with the
> recent versions I have seen).  If you can convince the on-board monitor
> the flash the local part, well, you get one chance at PPCBoot :-).
>
> Buy an Abatron BDI2000.  You can use it for lots of things, including
> programming/debugging PPCBoot and the Linux kernel once you get to
> that point.  It's worth every penny if you place any value on your
> time.
>
>         -- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

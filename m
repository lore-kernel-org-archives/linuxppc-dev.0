Date: Wed, 26 Jul 2000 19:14:08 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Josh Huber <huber@mclx.com>
cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: xf4 hang on mach64
In-Reply-To: <20000726092449.A404@mclx.com>
Message-ID: <Pine.LNX.4.10.10007261913470.29908-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Has anyone had any luck with Ani's drivers for the Mach64 chipset?  If
> you have, could you send me your XF86Config?  I'm getting the
> following kind of output:
>
> (II) ATI: ATI driver (version 5.3.5) for chipsets: ati, ativga
> (--) Chipset ATI Mach64 3D Rage LT Pro (PCI) found
> Found a Mach64 on a PowerPC
> (WW) ****INVALID MEM ALLOCATION**** b: 0x82000000 e: 0x82ffffff correcting
> own
>         [0] -1  0x82fff000 - 0x82ffffff (0x1000) MXB
>         [1] -1  0x00000400 - 0x000004ff (0x100) IXB

With a 2.2. kernel ?? There's a PCI conflict that is 'fixed' by XFree86 by
way of unmapping the conflicting resource which happens to be either the
framebuffer or the memory mapped registers. The practical upshot of this
is that the kernel fbdev driver, attempting to set the color registers,
accesses the unmapped region and dies.

A 2.3 or 2.4 kernel with PCI resource conflict resolution should fix this.
I don't recall whether I ever sent a patch for 2.2.x to this list, but if
you remap the conflicting PCI resource to another non overlapping region,
and update the oftree and kernel PCI tree data accordingly at the start of
atyfb_probe, the problem should go away. Guessing a correct address for
the remapping without PCI resource management is a bit of a hazard.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

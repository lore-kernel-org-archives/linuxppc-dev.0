Date: Sat, 20 Jan 2001 07:35:35 -0700
From: Matt Porter <mporter@mvista.com>
To: S?bastien C?t? <scote1@matrox.com>
Cc: Matt Porter <mporter@mvista.com>,
        LinuxPPC-embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: initrd problems
Message-ID: <20010120073535.A15536@beef.az.mvista.com>
References: <3A671191.A0254C18@matrox.com> <3A676DC6.FD21D5D8@matrox.com> <20010118130139.A5256@cx258813-a.chnd1.az.home.com> <3A6877E3.AA2238C2@matrox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A6877E3.AA2238C2@matrox.com>; from scote1@matrox.com on Fri, Jan 19, 2001 at 12:22:43PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jan 19, 2001 at 12:22:43PM -0500, S?bastien C?t? wrote:
> Matt Porter wrote:
> > > I was also wondering if I loaded the kernel correctly.  I put my
> > > zImage+initrd (zvmlinux.initrd) at address 0 of ram.  Since I compiled
> > > the kernel with debug symbols, it takes a few Megs... Could it be too
> > > large for it's own good?  Maybe somebody knows about the answer to that
> > > one!
> >
> > What does the bootloader show when it relocates the zImage and initrd?
> > How about a progress dump so we have something to help you with?  You
> > make some comments about not using a special bootloader then say
> > you are loading a zImage (from the Sandpoint port) which does have
> > a relocating bootloader.  This smells like a custom board port where
> > you've gutted or dropped a bootloader and don't have the r3-r6 set
> > up correctly for entry into arch/ppc/kernel/head.S.  Are you really
> > just dropping vmlinux at address 0?  Details details...
>
> I'll try to see what happens when the image is moved now that I know
> this might be the problem, but my stupid debugger isn't friendly at all
> and it's very difficult to do so.

Get a BDI2000, http://www.abatron.ch

> I tought the image wouldn't be moved if I placed it a address 0.  I copy
> my zvmlinux.initrd at this address so I tought it wouldn't be used.
> This is indeed a custom board and I'm really just dropping vmlinux at
> address 0.

This doesn't make a bit of sense.  Either you are placing a
zvmlinux.initrd image which contains a relocating bootloader at 0 or
you are placing the uncompressed vmlinux kernel at 0.  Which is it?

> I also found out that the values of initrd_start and initrd_end aren't
> valid when assigned from r4 and r5, so something must be overwriting
> these values (intrd_end is smaller than initrd_start)

The initrd will be overwritten by kernel data structures if you don't
relocate it to a safe place.  If your r4/initrd_start and r5/initrd_end
reflect that place then (with Mark's patch to the stock Sandpoint
code) the kernel ramdisk/initrd driver will be able to find the image.

> What's the use for r3?  I read it's board identification but I don't
> really care if my board isn't identified correctly (for now at least).
> A looked for documentation about this but couldn't find any (the booting
> process of linux on a PowerPc seems to be terribly undocumented)

The kernel entry state for various platforms is fully documented in
arch/ppc/kernel/head.S.  It's of no use to your custom board port.

I've done this many times for custom board ports.  Have your JTAG
probe configure the memory controller.  You then simply drop
your vmlinux at physical 0.  Take your separate initrd image and
drop it at a safe place like 0x800000.  Use the JTAG probe to set
r4 to 0x800000 and r5 to 0x800000 + (<initrd_size> - 1).  Go at
0 and you'll boot then root from your initrd.

Put it all in a script for your JTAG probe or do it right and modify
the spruceboot or pmonboot bootloaders from linuxppc_2_5 and do it
right the first time.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

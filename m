Date: Thu, 18 Jan 2001 13:01:40 -0700
From: Matt Porter <mporter@mvista.com>
To: Sébastien Côté <scote1@matrox.com>
Cc: LinuxPPC-embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: initrd problems
Message-ID: <20010118130139.A5256@cx258813-a.chnd1.az.home.com>
References: <3A671191.A0254C18@matrox.com> <3A676DC6.FD21D5D8@matrox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3A676DC6.FD21D5D8@matrox.com>; from scote1@matrox.com on Thu, Jan 18, 2001 at 05:27:18PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jan 18, 2001 at 05:27:18PM -0500, Sébastien Côté wrote:
>
> I finally figured out a small part of the problem...  My initrd_start
> was overwritten (to 0) by the function start_kernel in init/main.c :

<snip>

> I don't really understand this function... Why would my initrd be
> overwritten?!?  Anyways, I commented it out to see what would happen.

Because it's in the wrong place and the kernel is walking all over
it.  Usually because a bootloader couldn't handle relocating the
image to a safe place.

<snip>

> sb is NULL.  Damn..  What now?  Is it possible that my initrd has been
> erased like the kernel told me?  What else could it be?

Yes.

> I was also wondering if I loaded the kernel correctly.  I put my
> zImage+initrd (zvmlinux.initrd) at address 0 of ram.  Since I compiled
> the kernel with debug symbols, it takes a few Megs... Could it be too
> large for it's own good?  Maybe somebody knows about the answer to that
> one!

What does the bootloader show when it relocates the zImage and initrd?
How about a progress dump so we have something to help you with?  You
make some comments about not using a special bootloader then say
you are loading a zImage (from the Sandpoint port) which does have
a relocating bootloader.  This smells like a custom board port where
you've gutted or dropped a bootloader and don't have the r3-r6 set
up correctly for entry into arch/ppc/kernel/head.S.  Are you really
just dropping vmlinux at address 0?  Details details...

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

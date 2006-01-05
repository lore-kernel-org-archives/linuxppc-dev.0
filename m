Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 242BB689AC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jan 2006 00:59:25 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 5 Jan 2006 13:59:14 +0000
References: <1136414679.3463.10.camel@nighteyes.site>
	<200601050905.57377.david.jander@protonic.nl>
In-Reply-To: <200601050905.57377.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200601051359.15018.arnd@arndb.de>
Cc: David Jander <david.jander@protonic.nl>
Subject: Re: powerpc vs ppc build
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 05 January 2006 08:05, David Jander wrote:
> Looks to me like ppc and ppc64 are deprecated and "phased out" in favour of 
> powerpc.

ppc64 is no more in 2.6.15, building the kernel on a ppc64 system
will automatically use ARCH=powerpc.

> If you look at the contents of both the include/asm-ppc and  
> include/asm-powerpc directories over the last revisions for example, you'll 
> see files moving from asm-ppc to asm-powerpc. Now, they are in a kind of flux 
> still, so you'll probably find yourself doing silly things like "ln -s 
> include/asm-powerpc/* include/asm-ppc/" to keep things working and compiling
> nicely.

That should never be needed. You should always be able to do both

$ make ARCH=ppc randomconfig O=../obdir1 && make ARCH=ppc O=../obdir2

and

$ make ARCH=powerpc randomconfig O=../objdir2 && make ARCH=powerpc O=../obdir2

and build successfully with that. If it doesn't, report a bug.

> I do hope this is over soon.

I fear it might take a somewhat longer time. AFAICS, the idea is to
remove all platforms from ppc, one at a time, as soon as they are
working well enough with ARCH=powerpc or are known to be unmaintained.
At that point, the arch/ppc/ tree can be removed completely.

The catch is that this needs work from each platform maintainer that
wants his hardware to be supported in future kernels (or at least the
information that he/she doesn't care if it gets removed).

> On Wednesday 04 January 2006 23:44, Jeff Angielski wrote:
> > Is there a summary of the differences between the ppc and powerpc builds
> > for the 2.6 kernels?  Or something describing what the community, in
> > general, is trying to fix/address with the different schemes - besides
> > the merging of ppc and ppc64?

I'm only a ppc64 person, so I don't know the state that the current
51 platform types from arch/ppc/Kconfig or any of the out-of-tree
ones are in, but if you are maintaining one of them that does not yet
work with ARCH=powerpc, I suggest you do the following:

1. If the platform is not already based on open firmware or the equivalent
flat device tree representation, build a device tree for it, using the
specification from http://ozlabs.org/~dgibson/dtc/ (you need to use
git to check out the repository).

2. See if there is already a platform type for your hardware present
in arch/powerpc. Note that a powerpc platform is a lot more generic
than a ppc machine type, so you almost never need to add a new one here.
E.g. every board based on a 4xx should be able to use the same platform
type. 
The rule is that enabling support for some hardware should never force
you to disable support for other hardware.

3. Move over all device drivers that are still missing in powerpc.
Make sure that the drivers don't contain any hardcoded assumptions
about your hardware that may be different for other board. I/O
addresses and such stuff should come from the device tree. Moreover,
the driver should not touch any I/O if someone loads it on a board
that does not have the device.

4. Submit a patch series to linuxppc-dev that integrates your changes,
following Documentation/SubmittingPatches, and mark your arch/ppc code
as deprecated with a deadline saying at what time it will be removed
(or remove it right away with another patch).

	Arnd <><

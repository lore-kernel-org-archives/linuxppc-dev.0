Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0826567C7E
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:30:38 +1100 (EST)
Subject: Re: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Winiecki <stevewin@us.ibm.com>
In-Reply-To: <OF3E950149.B4C8024A-ON8725721A.006D325F-8525721A.007259AD@us.ibm.com>
References: <OF3E950149.B4C8024A-ON8725721A.006D325F-8525721A.007259AD@us.ibm.com>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:30:25 +1100
Message-Id: <1162506625.10630.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> What exactly is the intent of PPC_MULTIPLATFORM - the current desc
> states "Generic desktop/server/laptop" - which doesn't exactly scream
> 'embedded' to me either.  I guess I saw embedded6xx as a 'catch-all'
> for everything else.

It's historical. It was the good old prep/chrp/pmac option, meaning that
more than one board support can be built in the same kernel. I've made
the policy decision with ARCH=powerpc that we should now make that
mandatory for new boards (of course provided the CPUs are of the same
family) since, as Sascha rightfully pointed out, it costs nothing and
keeps things cleaner.

Thus I'm all about getting rid of the option :)

> I might be missing something - but when you removed EMBEDDED6xx from
> powerpc/Kconfig in patch 8, and removed MPC7448HPC2 from
> embedded6xx/Kconfig in patch 6 - where did you move the MPC7448HPC2
> config section to?  Is your thought that it will depend on
> PPC_MULTIPLATFORM now as well?

Board support are just boolean options depending on their CPU family
choice. That's the goal at least. I'm sure we are due for some Kconfig
cleanup to make that more visible :) We should probably split the
Kconfig into separate files for the various CPU families containing the
platforms for these families.

> This may be slightly off topic - but one other thing I have noticed
> that the new boot wrapper script supports specific 'types' of zImage
> files associated w/ 'MUTIPLATFORMS' (PSERIES, CHRP, PREP etc.) and
> uImage - which is what I think the majority of 'embedded' platforms
> will use by defining CONFIG_DEFAULT_UIMAGE.

That is not totally clear since they have non-compatible board info.

>   For IBM boards with PIBS just 'normal' zImage ELF files get loaded -
> I'm not sure if there should be another type defined/supported for
> boards which don't fit necessarily into a PSERIES/CHRP/PREP definition
> and also don't use uboot - CONFIG_DEFAULT_ZIMAGE? 
> 

Ask Paulus about the naming but pSeries is just "normal" in the sense
that it's "booted from a real OF" support.

The problem is despite the ability to do those nice multiplatform kernel
images, we still have bootloader incompatibilities. Thus we want to move
those to the zImage wrapper which can produce, from an already built
vmlinux binary, any zImage that can be supported for a given firmware
interface.

In the long run, we hope that firmwares will finally get their gears
together and use either a real OF entry point or a direct flat
device-tree entry point, which means that a single zImage (the "normal
one as you call it) will be able to boot everything.

There's also a glitch with real OF zImages due to the fact that IBM
pSeries OF requires a Notes section forcing OF into real mode while
Apple OF is allergic to that (it will crash badly) so we need to keep a
separate zImage for PowerMac. However, the vmlinux are the same so if
you use something like yaboot, the same vmlinux cna be booted on all
those machines.

Ben.

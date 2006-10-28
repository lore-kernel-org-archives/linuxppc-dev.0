Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D8BBC67C1B
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 15:13:31 +1000 (EST)
Subject: EFIKA vs. CHRP platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>, Matt Sealey <matt@genesi-usa.com>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 15:13:15 +1000
Message-Id: <1162012395.25682.121.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi folks !

I've been thinking about this for a while, it's been nagging me... I
think we are doing a mistake with the Efika board (in fact, we did it
with Pegasos too).

It should just not use the CHRP platform, but instead, be a platform of
its own, part of the multiplatform support of arch/powerpc.

There are several reasons leading to that conclusion, but basically, I
can summarize it that way:

The whole _chrp_type thing is just a bad duplication of the existing
platform support. It's there for historical reasons, but we shouldn't
grow on it...

It basically ends up saying something like:

	platform (chrp) {
		if (pegasos)
			do_pegasos_stuff()
		else if (efika)
			do_efika_stuff()
		else if (motorola)
			do_motorola_stuff()
		....
		do_a_bit_of_common_stuff();
	}

Which really makes me think why do we bother making all this in platform
chrp and not have instead

	platform (pegasos) {
		do_pegasos_stuff();
		do_common_stuff(); <-- that is really common, like rtas
	}
	platform (efika) {
		do_efika_stuff();
		do_common_stuff();
	}

etc...

Basically, things like RTAS-PCI, or the various races of PCI host bridge
should just be "sysdev" code (library of devices) that are common to all
platforms and selected for compilation via "select" primitives be the
respective platforms.

There is simply no point in keeping this pseudo-generic-chrp thing, it
doesn't help, it only confuse things. right now, CHRP has to build-in
pegasos marvell bits, tomorrow, it will need some mpc52xx bits as well,
at the end of the day, why do we impose those to somebody who wants to
build a kernel for a small memory footprint old CHRP box ? So we might
end up having selectable sub-platform options at compile time ? That is
just duplicating what the platform mecanism does already.

So if we have bits in CHRP that we think might be needed by platform
efika, then we cut them out into a sysdev or lib of their own and have
CHRP and Efika "select" them.

The whole OF thing is not a reason for CHRP. PowerMacs have OF and
aren't CHRP, and we are getting more and more device-trees (wether they
are provided by a real OF interface or not is totally irrelevant to the
kernel structure) in all sorts of embedded platforms, that doesn't make
them CHRP...

In fact, we could almost think as the wole arch/powerpc is what oculd
have been CHRP nowadays... platform/chrp is support of legacy hardware
that followed precisely the old spec and HW set. Your board is different
enough from that to justify it's own platform code.

So here is your todo list:

 - change your device_type at the root of the device-tree, it's not chrp
anymore. Put whtever you want as long as you can identify your board.

 - do a platform efika. As for the location of it in the kernel source
tree, well, we have embedded6xx which is a bad name for "misc6xx". It's
pretty much a grab bag for platform code that doesn't need to spawn more
than one or two files. Feel free to create a separate platform dir if
your really want to but I doubt it's necessary. Maybe paulus can propose
a new name for "various" boards that fit in a single file... I would be
happy to move briq out of chrp too in fact. And pegasos :)

 - you can define a CONFIG_PPC_MPC52xx if you want. It would be selected
by the platform code and would include the various "base" drivers for
any MPC52xx board. That would maek the transition from arch/ppc easier
as well. Typically, that would typically include the PIC code. Maybe
bits of Bestcomm too.

 - I'm not sure using RTAS for PCI config space is a very good idea.
We'll need native mpc52xx_pci.c anyway, so we can juse use it for Efika
as well instead of taking the massive overhead of RTAS calls on PCI
config space accesses.

Cheers,
Ben

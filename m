Return-Path: <markus.westergren@biologigrand.ac>
Received: from www.biologigrand.ac (licentiaten.umea.hsb.se [212.32.155.2])
	by ozlabs.org (Postfix) with ESMTP id E1CF667A79
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Feb 2005 21:37:52 +1100 (EST)
Date: Mon, 21 Feb 2005 11:37:51 +0100 (CET)
From: Markus Westergren <markus.westergren@biologigrand.ac>
To: Chris Hallinan <clh@net1plus.com>
In-Reply-To: <20050220141840.GC4565@net1plus.com>
Message-ID: <Pine.LNX.4.50.0502211135340.3336-100000@220a.licentiaten.umea.hsb.se>
References: <Pine.LNX.4.50.0502201034520.25626-100000@220a.licentiaten.umea.hsb.se>
	<20050220141840.GC4565@net1plus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Markus Westergren <markus.westergren@biologigrand.ac>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Cross-compile kernel modules
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, 20 Feb 2005, Chris Hallinan wrote:

> On Sun, Feb 20, 2005 at 10:49:50AM +0100, Markus Westergren wrote:
> > Hi,
> >
> > I'm trying to get loadable kernel modules support on a Adder development board.
> > The kernel is cross-compiled on an regular PC and boots fine but I can't insert
> > any modules into the running kernel, all I get is undefined reference for all
> > functions called by the module. I use the kernel module utilities (insmod,
> > lsmod, modprobe) supplied by BusyBox to manage the modules on the Adder board.
>
> You don't give many details, but in general the above should
> work, assuming you have properly built and configured your
> kernel, modules and root file system.
>
> > What am I doning wrong? Do I need to perform any aditional steps when
>
> Yes. You need to make sure your modules are built from the same
> kernel source tree, with the same configuration as the kernel you
> are booting.  Then you need to install those modules on your
> target's root file system.
>
> In general, you must do a 'make modules' followed by a 'make
> modules_install' with INSTALL_MOD_PATH pointing to your target's
> root file system.  The details depend on how you've built your
> rootfs and your cross-development setup.  I usually mount my
> rootfs image on a loop device somewhere, and point
> INSTALL_MOD_PATH to it.
>
> > cross-compiling kernel modules? My cross-compile toolchain have no depmod so I
>
> Fix your development environment.
>
> > have no modules.dep file. But I only need it if a module depend on other
> > modules, right?
>
> modprobe depends on modules.dep.  You can run depmod on your
> target assuming you have the depmod binary for your architecture
> on your target file system.
>
> Regards,
>
> Chris
>
> >
> > /Markus
> >
> > -----------------
> > Markus Westergren
> > Biologigrand 17
> > 907 32 Umea
> > SWEDEN
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
Thanks for your reply. I got it to work by upgrading my version of BusyBox to
1.00. Had 1.00-pre3 before which is really old.

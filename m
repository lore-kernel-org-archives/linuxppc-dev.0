Return-Path: <clh@net1plus.com>
Received: from mxsf02.cluster1.charter.net (mxsf02.cluster1.charter.net
	[209.225.28.202]) by ozlabs.org (Postfix) with ESMTP id 6841167A6E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Feb 2005 01:58:23 +1100 (EST)
Received: from mxip09.cluster1.charter.net (mxip09a.cluster1.charter.net
	[209.225.28.139])
	by mxsf02.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id
	j1KEINBt026857
	for <linuxppc-embedded@ozlabs.org>; Sun, 20 Feb 2005 09:18:24 -0500
Date: Sun, 20 Feb 2005 09:18:40 -0500
From: Chris Hallinan <clh@net1plus.com>
To: Markus Westergren <markus.westergren@biologigrand.ac>
Message-ID: <20050220141840.GC4565@net1plus.com>
References: <Pine.LNX.4.50.0502201034520.25626-100000@220a.licentiaten.umea.hsb.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.50.0502201034520.25626-100000@220a.licentiaten.umea.hsb.se>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Cross-compile kernel modules
Reply-To: clh@net1plus.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Feb 20, 2005 at 10:49:50AM +0100, Markus Westergren wrote:
> Hi,
> 
> I'm trying to get loadable kernel modules support on a Adder development board.
> The kernel is cross-compiled on an regular PC and boots fine but I can't insert
> any modules into the running kernel, all I get is undefined reference for all
> functions called by the module. I use the kernel module utilities (insmod,
> lsmod, modprobe) supplied by BusyBox to manage the modules on the Adder board.

You don't give many details, but in general the above should
work, assuming you have properly built and configured your
kernel, modules and root file system.

> What am I doning wrong? Do I need to perform any aditional steps when

Yes. You need to make sure your modules are built from the same
kernel source tree, with the same configuration as the kernel you
are booting.  Then you need to install those modules on your
target's root file system.

In general, you must do a 'make modules' followed by a 'make
modules_install' with INSTALL_MOD_PATH pointing to your target's
root file system.  The details depend on how you've built your
rootfs and your cross-development setup.  I usually mount my
rootfs image on a loop device somewhere, and point
INSTALL_MOD_PATH to it.

> cross-compiling kernel modules? My cross-compile toolchain have no depmod so I

Fix your development environment.

> have no modules.dep file. But I only need it if a module depend on other
> modules, right?

modprobe depends on modules.dep.  You can run depmod on your
target assuming you have the depmod binary for your architecture
on your target file system.

Regards,

Chris

> 
> /Markus
> 
> -----------------
> Markus Westergren
> Biologigrand 17
> 907 32 Umea
> SWEDEN
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

-- 

Chris Hallinan
clh at net1plus d0t com - via mutt/Linux
----------------------------------

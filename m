Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 044DCDE9DB
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 06:20:06 +1100 (EST)
Subject: Re: [PATCH] powerpc: remove CHRP and PMAC support from defconfigs,
	fix Kconfigs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <ed82fe3e0810080828r115b3e85laf08e8d1e47faf42@mail.gmail.com>
References: <1222449586-14622-1-git-send-email-timur@freescale.com>
	<ed82fe3e0810080828r115b3e85laf08e8d1e47faf42@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 09 Oct 2008 06:19:56 +1100
Message-Id: <1223493596.8157.80.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-08 at 10:28 -0500, Timur Tabi wrote:
> On Fri, Sep 26, 2008 at 12:19 PM, Timur Tabi <timur@freescale.com> wrote:
> > The Kconfig files for PowerPC CHRP and PMAC support had "default=y" for some
> > Kconfig options, and this caused support for CHRP and PMAC platforms to be
> > enabled incorrectly for several platforms.  Fix the Kconfigs and the
> > affected defconfigs.
> 
> Ben,
> 
> When you applied this patch, you removed the Kconfig changes.  Without
> those, doing a "make xxx_defconfig" will just add "CONFIG_PPC_PMAC=y"
> and "CONFIG_PPC_CHRP=y" to the .config!

Hrm. Yes, I removed those changes because I want to think more about
that aspect of things.

> $ make 83xx/mpc834x_itxgp_defconfig
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/docproc
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/kxgettext.o
>   SHIPPED scripts/kconfig/zconf.tab.c
>   SHIPPED scripts/kconfig/lex.zconf.c
>   SHIPPED scripts/kconfig/zconf.hash.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> #
> # configuration written to .config
> #
> $ grep CHRP .config
> CONFIG_PPC_CHRP=y
> 
> So please apply my *original* patch.

yeah well, there's a consistency problem. If we remove default for these
we should remove default for all.

The bug I think is in your original patch in fact to just remove those
from .config rather than explicitely set them to "not set".

I'm not going to remove the applied patch to avoid rebasing, it's
harmless to keep it in, please send another one that does the above.

Ben.

 

Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id B991CDDEEA
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 18:08:08 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 02/10] powerpc: Move CONFIG_PPC64 into CPU selection
Date: Tue, 12 Jun 2007 10:08:01 +0200
References: <20070611232824.489103547@arndb.de>
	<20070611233353.734704855@arndb.de>
	<18030.15937.699275.958545@cargo.ozlabs.ibm.com>
In-Reply-To: <18030.15937.699275.958545@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Message-Id: <200706121008.01661.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 June 2007, Paul Mackerras wrote:
> > Currently, PPC64 is a top level configuration option in
> > arch/powerpc/Kconfig, which is somewhat unconventional.
>=20
> It makes a lot of sense to me to have 32 vs. 64 bits as a high level
> binary selector that conditions the things that follow. =A0I don't think
> it makes sense to push it down into the CPU selection menu.

Can you eleborate, other than stating the exact opposite of what
my comment said?

I don't mind removing this patch from the series, but I'd like to
understand the reason. I've always thought of the top-level option
as a temporary ugly hack that should eventually go away ;-)

Other than subjective feelings, my reasons for this patch were:

* No other architecture I have seen uses bool options in the top-level
  menu, so it would be more consistant to move it to the cpu type
  selection menu.

* we have six (depending on how you count) PPC CPU families
  supported by Linux (4xx, 6xx, 8xx, e200, e500, ppc64), each
  of them incompatible with the others, meaning that you can run
  common user space but not a common kernel. Having the list in
  as the first Kconfig choice seems logical to me, because
  all other options more or less depend on these.

* The only major difference between ppc64 and the others is the
  object format of the kernel binary. My impression when playing
  with the cpu selection menu was that we have a lot more stuff
  depending on 6xx than on ppc64.

* Given the choice between the equivalent

> config PPC64
> 	bool
>
> choice
> 	depends on !PPC64
> config 4xx
> config 6xx
> config 8xx
> config E200
> config E500
> endchoice

and

> choice
> config PPC64
> config 4xx
> config 6xx
> config 8xx
> config E200
> config E500
> endchoice

I find the latter easier to understand regarding further options
depending on each of them in the individual platforms, e.g. each
of the platforms/foo/Kconfig files depends on exactly one of these
six options.=20

	Arnd <><

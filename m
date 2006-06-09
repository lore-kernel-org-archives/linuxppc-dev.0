Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB85067C52
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 08:11:38 +1000 (EST)
Subject: Re: [PATCH 3/10 v2] Add MPC8641 HPCN PCI and PCI-Express files.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1FojYV-0004O8-L0@jdl.com>
References: <1149803866.23938.280.camel@cashmere.sps.mot.com>
	<1149827596.12687.53.camel@localhost.localdomain>
	<E1FojYV-0004O8-L0@jdl.com>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 08:11:22 +1000
Message-Id: <1149891083.12687.72.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-09 at 11:09 -0500, Jon Loeliger wrote:
> So, like, the other day Benjamin Herrenschmidt mumbled:
> > On Thu, 2006-06-08 at 16:57 -0500, Jon Loeliger wrote:
> > > Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
> > > Signed-off-by: Wei Zhang <Wei.Zhang@freescale.com>
> > > Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
> > > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> > 
> > There are various things in this code that duplicate names used by other
> > platforms and thus makes the board unsuitable for use in a common
> > kernel. That needs to be fixed. Try avoiding too generic names. Also,
> > PCI Express shall be named "pcie" and not "pex" :)
> > 
> > I don't have time at the moment to go too deep in the details here.
> > 
> > Ben.
> 
> I will also prefix some routines with mpc86xx_ to avoid
> the generic names problems.  But I'm not sure which other
> platforms you expect this one kernel image to run on.
> Specifically, this pcie code is very similar to the 8548
> family, but not exactly the same.

It's a policy. On powerpc, MULTIPLATFORM will be the default. One can
build an image that boots a powermac, a pseries and your machines. The
user doesn't _have_ to but the possibility is there. Might be useful in
the long run for embedded distros. It also force us into staying clean
and that's a good thing in general.

> My understanding is that we are shooting for a single 86xx
> family kernel image here, with this 8641 HPCN platform being
> the first such port.
>
> I will s/pex/pcie/g and rename files accordingly.

There is no compelling reason to prevent a true multiplatform kernel
since it's not a different enough CPU (like 4xx or 8xx would be), thus
it shall be in the common config. That's something that we need to fix
about Kumar couple of initial ports to arch/powerpc too.

Ben

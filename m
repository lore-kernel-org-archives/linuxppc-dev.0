Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6EB7AB70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 10 Oct 2010 18:36:02 +1100 (EST)
Subject: Re: Pegasos i8042 broken again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: pacman@kosh.dhis.org
In-Reply-To: <20101010013755.1697.qmail@kosh.dhis.org>
References: <20101010013755.1697.qmail@kosh.dhis.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 10 Oct 2010 18:35:47 +1100
Message-ID: <1286696147.2463.499.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-10-09 at 20:37 -0500, pacman@kosh.dhis.org wrote:
> Pegasos has no keyboard again. I blame commit
> 540c6c392f01887dcc96bef0a41e63e6c1334f01, which tries to find i8042 IRQs in
> the device-tree but doesn't fall back to the old hardcoded 1 and 12 in all
> failure cases.
> 
> Specifically, the case where the device-tree contains nothing matching
> pnpPNP,303 or pnpPNP,f03 doesn't seem to be handled well. It sort of falls
> through to the old code, but leaves the IRQs set to 0.
> 
> The last time something like this happened, I submitted a patch:
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2007-July/039988.html
> which got committed, but afterward I was scolded for working around a bug
> instead of fixing it in nvramrc.
> 
> This time I just won't send my workaround patch, at least until it's decided
> that the kernel should be made to understand the device-tree as is.
> 
> If it's decided instead that the firmware should be patched... well I just
> don't feel comfortable inventing my own patch for nvramrc, since it's written
> in a language I don't know and presumably could brick the machine if I get it
> wrong. Also I'm not even sure what the kernel is expecting to find there. 

Those things really suck. They absolutely refuse to fix their FW for
reasons I never quite managed to figure out.

At this stage, I'd say the best is to add yet another pegasos workaround
in prom_init that adds the missing compatible property.

Cheers,
Ben.

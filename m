Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5AC2B67BCF
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 13:29:38 +1100 (EST)
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20061211201055.21031c9b.kim.phillips@freescale.com>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>
	<1165648490.1103.117.camel@localhost.localdomain>
	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>
	<20061211155155.26868ca6.kim.phillips@freescale.com>
	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>
	<20061211201055.21031c9b.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 13:29:30 +1100
Message-Id: <1165890570.11914.5.camel@localhost.localdomain>
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


> how else is platform_probe going to find the right match? 
> it's either that, or adding _probe()s for each platform.

Well, either you want all freescale boards have one platform.
in which case you write one ppc_md() structure, call it
mpc83xx_fslboards or something like that, and have a probe routine that
test for all matches, or create as many ppc_md structures as you have
boards each with it's own probe().

The point here is that other developpers making their own mpc83xx based
boards will not want to use your ppc_md. They will have differences and
those differences will be handled in their board support code via
different hooks in ppc_md.

It's goot if you provide them "generic" things they can use in mpc83xx.c
for areas where they don't differ from the freescale reference
implementations, but don't make the fsl board support code try to match
on everything that has a mpc83xx in it !

Thus, make sure that your DTs for the fsl boards have clear
identification (via the model or compatible property at the root of the
tree is the usual way of doing so) and have a ppc_md or several, as you
like, match specifically those boards. Also, make that ppc_md live in a
different file that doesn't have to be compiled along with the generic
mpc83xx code.

That way, embedded developpers have the choice of either building a
multiplatform kernel that supports their board -and- fsl ones, or a
tailored kernel for their board that doesn't include the fsl specific
stuff, all depending on config options.

Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4047F67BAC
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 09:46:41 +1100 (EST)
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <457F300F.7000203@freescale.com>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>
	<1165648490.1103.117.camel@localhost.localdomain>
	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>
	<20061211155155.26868ca6.kim.phillips@freescale.com>
	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>
	<20061211201055.21031c9b.kim.phillips@freescale.com>
	<1165890570.11914.5.camel@localhost.localdomain>
	<457F1F6E.4020502@freescale.com>
	<E8320867-EDC5-42F9-81EE-E66B6D216ADA@kernel.crashing.org>
	<457F300F.7000203@freescale.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 09:46:35 +1100
Message-Id: <1165963595.11914.101.camel@localhost.localdomain>
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

On Tue, 2006-12-12 at 16:41 -0600, Scott Wood wrote:
> Kumar Gala wrote:
> > On Dec 12, 2006, at 3:30 PM, Scott Wood wrote:
> >> They *may* not want to (and they certainly shouldn't be forced to),  but
> >> some may not want to define a new ppc_md (or modify a probe function)
> >> for every new board if all of the differences are encapsulated in the
> >> device tree.  I thought one of the main goals of having a device  tree is
> >> that if it's done right, the kernel need not know about every single
> >> model of board, just the different components that a device tree can
> >> specify.
> > 
> > That's true, and if that's the case you'd just set your "model" to  
> > match an existing supported ppc_md.
> 
> Having an 831x explicitly claim to be an 834x is just a tad icky...

Indeed, but "compatible" doesn't mean exact match and can be a list. In
fact, it should probably be the other way around, that is 834x claim to
be compatible with 831x... something like:

 "834x\0831x\083xx" (with appropriate board name appended of course).

> And an 83xx-generic machine description does not stop them from doing 
> so.  "Generic" does not mean "universal".  It means "there's nothing 
> special about this board".  If you need board-specific code in the 
> kernel, then don't label it generic.

As long as you are careful enough so that your "generic" ppc_md. doesn't
try to match everything with a 83xx in it :-0

Ben.

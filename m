Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4A07DDE24
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 08:53:05 +1100 (EST)
Subject: Re: [RFC/PATCH 5/14] powerpc: Fix 440/440A machine check handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071128213445.GA29962@lixom.net>
References: <1195625777.579001.269266058699.qpush@grosgo>
	<20071121061714.0AB82DEAF1@ozlabs.org>
	<20071121071240.141d2917@weaponx>
	<1195674530.6970.86.camel@pasglop> <20071121135109.73b9e98f@weaponx>
	<1195675525.6970.100.camel@pasglop> <20071128213445.GA29962@lixom.net>
Content-Type: text/plain
Date: Thu, 29 Nov 2007 08:52:39 +1100
Message-Id: <1196286759.13230.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-11-28 at 15:34 -0600, Olof Johansson wrote:
> On Thu, Nov 22, 2007 at 07:05:25AM +1100, Benjamin Herrenschmidt
> wrote:
> > 
> > On Wed, 2007-11-21 at 13:51 -0600, Josh Boyer wrote:
> > > > Hrm... it's per processor, not per board. I didn't feel like
> digging
> > > > which board uses which processor and go fixup all the ppc_md's
> > > 
> > > Sounds like something a generic function could probe for from the
> DTS.
> > > I'll look at doing something here when I start making 44x
> > > multiplatform
> > > (soon).
> > 
> > Well... we already probe the CPU type.... from cputable.
> > 
> > So if there was a place to put that, it would be the cputable.
> 
> It could make sense to have _both_ platform (ppc_md) and cputable
> functions, since some info is likely to be core-specific, other might
> be board/chipset/SoC-specific.

Yup. I need to look into it. We would call ppc_md. first and define
3 result codes: one for faulting, one for returning (fixed up) and one
for passing along (to the per-cpu code).

In fact, in theory we would need to also handle L1 parity errors on 970
now that I think of it...

Ben.

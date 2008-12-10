Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1083DDFCE
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 10:38:05 +1100 (EST)
Subject: Re: [RFC/PATCH 1/2] powerpc: Rework usage of
	_PAGE_COHERENT/NO_CACHE/GUARDED
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0812101416350.28806@t2.domain.actdsltmp>
References: <20081210055136.63D5FDDF5C@ozlabs.org>
	<Pine.LNX.4.64.0812101107350.28806@t2.domain.actdsltmp>
	<1228941726.22413.98.camel@pasglop>
	<Pine.LNX.4.64.0812101416350.28806@t2.domain.actdsltmp>
Content-Type: text/plain
Date: Thu, 11 Dec 2008 10:35:55 +1100
Message-Id: <1228952156.22413.101.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> In the code that does the mapping.  It's a lot cheaper to figure out if
> _PAGE_COHERENT is needed once per mapping instead of per page per fault.

What do you mean by "code that does the mapping" ?

The OR'ing or AND'ing out of one bit is pretty cheap regardless, so "a
lot cheaper" is very relative ;-) In the hash code, I doubt the
difference is even measurable.

> It sounds like getting it right is a lot more complicated than just one
> instruction.  No M bit for non-SMP, except for some 74xx, or if a MPC107
> bridge is used, which should be determined at runtime.  And does the MPC107
> thing apply to all pages or just those PCI memory behind the bridge?  Or
> DMA?

It should really only apply to DMA, that is all RAM pages.

> > Well, because we need it set on non SMP on some 74xx.. maybe we can
> > have it set in PAGE_BASE only if CONFIG_SMP and CONFIG_6xx ?
> 
> That's what I was thinking, set it in page base for SMP and other instances
> when we know it's necessary at compile time.  If/when there is a runtime
> check, then it would be lot easier to put that check in the code that made
> the mapping instead of the miss handler.

What do you mean by "the code that made the mapping" ? I still don't get
it.

> It's rather new so I bet X servers that use it aren't widely deployed yet.

If at all :-)

> commit 45aec1ae72fc592f231e9e73ed9ed4d10cfbc0b5
> Author: venkatesh.pallipadi@intel.com <venkatesh.pallipadi@intel.com>
> Date:   Tue Mar 18 17:00:22 2008 -0700
> 
>      x86: PAT export resource_wc in pci sysfs
> 
> Patch title is somewhat misleading, as it doesn't touch any x86 specific
> code.  And people complain when I used booke instead of fsl-booke...  like
> I want to make it any easier to have patches ignored.

Hehe,

Cheers,
Ben.

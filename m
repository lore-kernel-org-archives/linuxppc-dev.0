Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B2ED9DDF51
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 07:44:18 +1100 (EST)
Subject: Re: [RFC/PATCH 1/2] powerpc: Rework usage of
	_PAGE_COHERENT/NO_CACHE/GUARDED
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0812101107350.28806@t2.domain.actdsltmp>
References: <20081210055136.63D5FDDF5C@ozlabs.org>
	<Pine.LNX.4.64.0812101107350.28806@t2.domain.actdsltmp>
Content-Type: text/plain
Date: Thu, 11 Dec 2008 07:42:06 +1100
Message-Id: <1228941726.22413.98.camel@pasglop>
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

On Wed, 2008-12-10 at 11:33 -0800, Trent Piepho wrote:
> On Wed, 10 Dec 2008, Benjamin Herrenschmidt wrote:
> > This changes the logic so that instead, the PTE now contains
> > _PAGE_COHERENT for all normal RAM pages tha have I = 0. The hash
> > code clears it if the feature bit is not set.
> 
> Why not check the feature bit when the PTE is made and unset _PAGE_COHERENT
> at that point?  In fact, could you do something like:

Not sure what you mean. Inside set_pte_at ? Well, the one line of asm is
going to be in the noise in the hash code, I'm just flipping an existing
condition. I like the PTE to represent whether it's supposed to be a
coherent page.

> #if defined(CONFIG_SMP) || ....
> #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
> #else
> #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED)
> #endif

Not sure what your condition above is supposed to be but the whole thing
with the MPC107 bridge etc... should _NOT_ be a config option, that's
bogus, it should all be runtime detected.

Right now we have a problem because the CPU feature fixups are done
wayyyy too early on ppc32 so it's pretty much impossible to whack the
feature bit from the platform code but I intend to fix that at some 

I've been told that setting M on non-SMP will slows things down.  But
> couldn't you just change _PAGE_BASE on non-SMP instead of clearning it in
> the miss handler?

Well, because we need it set on non SMP on some 74xx.. maybe we can
have it set in PAGE_BASE only if CONFIG_SMP and CONFIG_6xx ?

I'm also not sure about some other upcoming SMP BookE processors that
may require M for DMA cache coherency.

> I have a patch to remove this IORESOURCE_PREFETCH hack.  The current kernel
> creates two files, resourceN and resourceN_wc, for prefetchable BARs to
> allow the user to choose what mode to use.

Ah ? That's new ? I missed it. Has X been updated to use them ? If not,
keep the hack for a little while more :-)

> Though I want to be able to map PCI resources as cached too.  I'm not sure
> what a good way to add that is.  Yet another resource file?  The first
> proposal for allowing WC mappings was to add support for ioctl() on sysfs
> attributes.  Then one could use ioctl() after opening the resource file to
> specify what mode to map it with.  No one liked ioctl(), but clearly the
> current method doesn't scale well to all 32 combinations of the WIMGE bits.

True. Dunno what the right approach is at this stage, best to discuss
this on linux-pci.

Cheers.
Ben.

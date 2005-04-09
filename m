Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C21E267B1A
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 09:44:47 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1113064594.4636.28.camel@localhost.localdomain>
References: <1112594783.26086.22.camel@gaston>
	<1113064594.4636.28.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 09:37:10 +1000
Message-Id: <1113089830.9518.444.camel@gaston>
Mime-Version: 1.0
Cc: fedora-ppc@lists.infradead.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: iBook G3 owners
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-04-09 at 17:36 +0100, David Woodhouse wrote:
> On Mon, 2005-04-04 at 16:06 +1000, Benjamin Herrenschmidt wrote:
> > There have been various reports of issues with sleep among others on
> > iBook G3 equiped with the 750FX processor. Also, the cpufreq code on
> > these so far didn't change the CPU voltage, which limited the actual
> > power saving at low frequency.
> 
> Sleep hasn't worked properly on my PowerBook G4 since I applied your
> first pair of patches. The current behaviour seems to be that short
> periods of sleep appear to work OK, but a fairly random death happens
> after a longer sleep. Last time it was ohci_hcd complaining of an
> uninitialised spinlock.
> 
> I'm half inclined to suspect RAM isn't being refreshed properly -- but
> most of the kernel text still seems to be there and it manages to oops
> and panic OK, so perhaps it's just that the dcache isn't correctly
> disabled, or isn't correctly flushed when we enable it again?

That kind of sleep is usually related to cache flush issues ... the
setup of RAM auto refresh isn't under kernel code control, it's entirely
done by the chipset when entering sleep state.

What is strange however is that none of these 2 patches have _any_
effect on your machine model. Can you confirm that's indeed the patches
you were talking about ? 

ppc32-750-errata-fix.diff
ppc32-pmac-sleep-fix.diff

> I'll rebuild the Fedora kernel without any of the patches to eliminate
> the possibility that it's caused by some other change.

Make sure you have the 2 cpufreq related patches though, there are
issues with CPU voltage possibly not correct on wakeup that can cause
similar problems.

Ben.

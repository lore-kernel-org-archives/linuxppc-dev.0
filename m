Return-Path: <SRS0+eddb50138459d8849ad9+594+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2095F67B2C
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Apr 2005 02:37:09 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1112594783.26086.22.camel@gaston>
References: <1112594783.26086.22.camel@gaston>
Content-Type: text/plain
Date: Sat, 09 Apr 2005 17:36:34 +0100
Message-Id: <1113064594.4636.28.camel@localhost.localdomain>
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

On Mon, 2005-04-04 at 16:06 +1000, Benjamin Herrenschmidt wrote:
> There have been various reports of issues with sleep among others on
> iBook G3 equiped with the 750FX processor. Also, the cpufreq code on
> these so far didn't change the CPU voltage, which limited the actual
> power saving at low frequency.

Sleep hasn't worked properly on my PowerBook G4 since I applied your
first pair of patches. The current behaviour seems to be that short
periods of sleep appear to work OK, but a fairly random death happens
after a longer sleep. Last time it was ohci_hcd complaining of an
uninitialised spinlock.

I'm half inclined to suspect RAM isn't being refreshed properly -- but
most of the kernel text still seems to be there and it manages to oops
and panic OK, so perhaps it's just that the dcache isn't correctly
disabled, or isn't correctly flushed when we enable it again?

I'll rebuild the Fedora kernel without any of the patches to eliminate
the possibility that it's caused by some other change.

-- 
dwmw2

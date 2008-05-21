Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33092DE440
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 01:43:06 +1000 (EST)
Subject: Re: [patch 2/2] powerpc: optimise smp_wmb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20080521153420.GG8897@wotan.suse.de>
References: <20080521141056.GC8897@wotan.suse.de>
	<20080521141231.GD8897@wotan.suse.de>
	<1211383592.8297.195.camel@pasglop>
	<20080521153420.GG8897@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 21 May 2008 11:43:00 -0400
Message-Id: <1211384580.8297.199.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-05-21 at 17:34 +0200, Nick Piggin wrote:
> On Wed, May 21, 2008 at 11:26:32AM -0400, Benjamin Herrenschmidt wrote:
> > 
> > On Wed, 2008-05-21 at 16:12 +0200, Nick Piggin wrote:
> > > lwsync is the recommended method of store/store ordering on caching enabled
> > > memory. For those subarchs which have lwsync, use it rather than eieio for
> > > smp_wmb.
> > 
> > Yuck... existence of lwsync depends on the processor at boot time...
> 
> Not according to the __stringify(LWSYNC) that I just removed. At least,
> presumably it is always present on 64 bit processors, and 32 bit ones
> will be no worse off as they'll continue just using eieio.

No, it doesn't exist on power3, but it degrades into a sync

Ben.

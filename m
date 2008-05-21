Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 17970DE039
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 02:01:52 +1000 (EST)
Date: Wed, 21 May 2008 18:01:46 +0200
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 2/2] powerpc: optimise smp_wmb
Message-ID: <20080521160146.GI8897@wotan.suse.de>
References: <20080521141056.GC8897@wotan.suse.de>
	<20080521141231.GD8897@wotan.suse.de>
	<1211383592.8297.195.camel@pasglop>
	<20080521153420.GG8897@wotan.suse.de>
	<1211384580.8297.199.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1211384580.8297.199.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 11:43:00AM -0400, Benjamin Herrenschmidt wrote:
> 
> On Wed, 2008-05-21 at 17:34 +0200, Nick Piggin wrote:
> > On Wed, May 21, 2008 at 11:26:32AM -0400, Benjamin Herrenschmidt wrote:
> > > 
> > > On Wed, 2008-05-21 at 16:12 +0200, Nick Piggin wrote:
> > > > lwsync is the recommended method of store/store ordering on caching enabled
> > > > memory. For those subarchs which have lwsync, use it rather than eieio for
> > > > smp_wmb.
> > > 
> > > Yuck... existence of lwsync depends on the processor at boot time...
> > 
> > Not according to the __stringify(LWSYNC) that I just removed. At least,
> > presumably it is always present on 64 bit processors, and 32 bit ones
> > will be no worse off as they'll continue just using eieio.
> 
> No, it doesn't exist on power3, but it degrades into a sync

Oh, the instruction does exist, but it degrades to a sync so
actually turns out to be slower than eieio?

I think it would be a good idea just to take the hit on power3.
>From memory, I measured lwsync is 5 times faster than eieio on
a dual G5. This was on a simple microbenchmark that made use of
smp_wmb for store ordering, but it did not involve any IO access
(which presumably would disadvantage eieio further).

Given the G5 speedup, I'd be surprised if there is not an improvment
on POWER4 and 5 as well, although no idea about POWER6 or cell...

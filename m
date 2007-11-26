Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B37DDDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 08:23:57 +1100 (EST)
Date: Tue, 27 Nov 2007 00:22:49 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC/PATCH] powerpc: Move CPM command handling into the cpm
	drivers
Message-ID: <20071127002249.612f4ff6@kernel.crashing.org>
In-Reply-To: <20071126162446.GA4408@loki.buserror.net>
References: <4745BB5F.6060002@scram.de>
	<fa686aa40711221036n6438c252lde71cffdaff97ea9@mail.gmail.com>
	<20071123005121.4d38d877@kernel.crashing.org>
	<20071126162446.GA4408@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 26 Nov 2007 10:24:46 -0600
Scott Wood wrote:

> On Fri, Nov 23, 2007 at 12:51:21AM +0300, Vitaly Bordug wrote:
> > Even that might be not enough - we may have simultaneous call of
> > this func in non-smp case...
> 
> Do you really think that every piece of code that uses spinlocks in
> the kernel is broken on non-SMP?
> 
No. I think spinlock is not universal save thing in such cases. See below.

> > I was thinking of some kind of refcount, so one that is going to
> > issue CPM command, must do say pq_cpmp_get() and another driver
> > won't be able to mangle with cpcr while it's not done with previous
> > request.
> 
> How on earth are you going to effect mutual exclusion using reference
> counting?
> 

perhaps I was not clear enough. That was a rough idea how to handle the whole thing,
not just cpm_cr_cmd. This cpm command is a corner case, but there can be other actions
that may confuse CPM being triggered simultaneously or overlapping. This is part of much bigger
problem, and I was intended to have a look what people think about that.
-- 
Sincerely, Vitaly

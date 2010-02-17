Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 59F91B7CFB
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 23:12:41 +1100 (EST)
Subject: Re: [PATCH 6/6] powerpc: Use lwsync for acquire barrier if CPU
	supports it
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20100217104153.GA7952@laptop>
References: <20100210105728.GA3399@kryten> <20100210110236.GB3399@kryten>
	<20100210110306.GC3399@kryten> <20100210110406.GD3399@kryten>
	<20100210110719.GE3399@kryten> <20100210111025.GF3399@kryten>
	<20100211070914.GB6735@laptop> <20100217094314.GC24270@kryten>
	<20100217104153.GA7952@laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Feb 2010 23:12:34 +1100
Message-ID: <1266408754.16346.280.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Yes I suppose the branch can be executed "non speculatively" before the 
> lwsync is completed. Wheras the larx/stcwx will have to complete before
> the branch outcome can be known. I suppose probably not worthwhile
> avoiding the full IO sync by adding yet more crap to make this work.
> 
> Thanks for putting my mind to rest though :)
> 
> I'd still be interested to know how expensive the full sync is when you
> have a lot of IOs in flight.
> 
> Question, are you going to do the hint and isync->lwsync thing for
> userspace as well? Too bad the kernel doesn't export synchronisation
> primitives to userspace...

We'd love to.... the vdso inherits from all the dynamic patching
features of the kernel and more...

It's really a matter of getting glibc to grok it, and doing so
efficiently (ie, not just having a function point in glibc, might be a
good use of the IFUNC stuff).

Cheers,
Ben.

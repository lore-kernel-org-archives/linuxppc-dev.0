Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EA8AFDDFB4
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 11:38:27 +1000 (EST)
Date: Mon, 26 May 2008 03:38:22 +0200
From: Nick Piggin <npiggin@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 1/2] powerpc: rmb fix
Message-ID: <20080526013822.GB30840@wotan.suse.de>
References: <20080521141056.GC8897@wotan.suse.de>
	<1211383623.8297.197.camel@pasglop>
	<20080521153247.GF8897@wotan.suse.de>
	<18486.10385.934128.122054@cargo.ozlabs.ibm.com>
	<20080523044052.GA13071@wotan.suse.de>
	<18486.19905.421960.700640@cargo.ozlabs.ibm.com>
	<20080523054846.GA4520@wotan.suse.de>
	<18486.26325.220602.226442@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18486.26325.220602.226442@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 23, 2008 at 04:40:21PM +1000, Paul Mackerras wrote:
> Nick Piggin writes:
> 
> > Anyway, even if there were zero, then the point is still that you
> > implement that API, so you should either strongly order your
> > __raw_ and _relaxed then you can weaken your rmb, or you have to
> > strengthen your rmb to match your weak read ops.
> > 
> > Saying it doesn't matter because there are no drivers is likely to
> > cause more headaches in future...
> 
> Well, it seems that rmb is used in several ways:
> 
> (1) to order reads from normal memory w.r.t. each other
> (2) to order readl et al. w.r.t. reads from normal memory
> (3) to order readl_relaxed et al. w.r.t. reads from normal memory
> 
> and I want to get a feeling for how prevalent each type of use is.
> 
> Now, the instances of (1) can presumably be converted to smb_rmb().

Right.


> The instances of (2) aren't necessary on powerpc because readl
> etc. are fully synchronous -- but that mightn't be true on other
> platforms.a

Yes... this is one place where a dedicated io_rmb() etc will
help on powerpc (as per my other proposal).


>  And for the instances of (3), powerpc needs to use sync,
> as you say.
> 
> If the instances of (2) have to stay, then I would rather try to work
> out some way that rmb doesn't have to be a sync, or at least doesn't
> always have to be a sync.  And that might mean redefining the meaning
> of rmb so that the instances of (3) have to be changed to something
> else.  Since (3) seems to be rarer than (2), it would presumably be
> (3) that we would change rather than (2).

That would be nice, but the problem is that if you weaken anything,
then technically you need to audit everything. And if you audit
everything anyway, you may as well retain existing semantics of rmb,
and introduce a new primitive, io_rmb... this is the reasoning I
use when I think the ia64 guys went the wrong way by weakening
wmb and introducing mmiowb.

Would the io_*mb() proposal suit you? It should also be able to
improve your IO write/write and read/write write/read performance
too.

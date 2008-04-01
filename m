Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id CFFF7DDF51
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 15:21:22 +1000 (EST)
Date: Mon, 31 Mar 2008 22:21:21 -0700 (PDT)
Message-Id: <20080331.222121.264093711.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [patch 06/24] lmb: add lmb_alloc_nid()
From: David Miller <davem@davemloft.net>
In-Reply-To: <18417.46834.753849.815163@cargo.ozlabs.ibm.com>
References: <200803282121.m2SLLBso010683@imap1.linux-foundation.org>
	<18417.46834.753849.815163@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, tglx@linutronix.de,
	mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Tue, 1 Apr 2008 15:15:46 +1100

> akpm@linux-foundation.org writes:
> 
> > From: David Miller <davem@davemloft.net>
> > 
> > A variant of lmb_alloc() that tries to allocate memory on a specified NUMA
> > node 'nid' but falls back to normal lmb_alloc() if that fails.
> 
> ...
> 
> > +static u64 __init lmb_alloc_nid_unreserved(u64 start, u64 end,
> > +					   u64 size, u64 align)
> > +{
> > +	u64 base;
> > +	long j;
> > +
> > +	base = lmb_align_down((end - size), align);
> > +	while (start <= base &&
> > +	       ((j = lmb_overlaps_region(&lmb.reserved, base, size)) >= 0))
> > +		base = lmb_align_down(lmb.reserved.region[j].base - size,
> > +				      align);
> 
> How do we know that lmb.reserved.region[j].base is >= size at this
> point?  If it isn't, then base could end up as some extremely large
> unsigned value, which would be a Bad Thing.

The same exact issue exists in the existing code, from which this is
derived, in __lmb_alloc_base().

This situation can occur any time a region is smaller than the 'size'
argument, in both functions.

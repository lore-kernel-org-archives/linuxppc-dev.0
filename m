Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18417.46834.753849.815163@cargo.ozlabs.ibm.com>
Date: Tue, 1 Apr 2008 15:15:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@linux-foundation.org
Subject: Re: [patch 06/24] lmb: add lmb_alloc_nid()
In-Reply-To: <200803282121.m2SLLBso010683@imap1.linux-foundation.org>
References: <200803282121.m2SLLBso010683@imap1.linux-foundation.org>
Cc: mingo@elte.hu, tglx@linutronix.de, davem@davemloft.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

akpm@linux-foundation.org writes:

> From: David Miller <davem@davemloft.net>
> 
> A variant of lmb_alloc() that tries to allocate memory on a specified NUMA
> node 'nid' but falls back to normal lmb_alloc() if that fails.

...

> +static u64 __init lmb_alloc_nid_unreserved(u64 start, u64 end,
> +					   u64 size, u64 align)
> +{
> +	u64 base;
> +	long j;
> +
> +	base = lmb_align_down((end - size), align);
> +	while (start <= base &&
> +	       ((j = lmb_overlaps_region(&lmb.reserved, base, size)) >= 0))
> +		base = lmb_align_down(lmb.reserved.region[j].base - size,
> +				      align);

How do we know that lmb.reserved.region[j].base is >= size at this
point?  If it isn't, then base could end up as some extremely large
unsigned value, which would be a Bad Thing.

Paul.

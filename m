Return-Path: <dave@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D70F8DE10C
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 03:30:40 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n05GSo7C003026
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 09:28:50 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n05GUaDV206314
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 09:30:36 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n05GUZdn002479
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 09:30:36 -0700
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Chandru <chandru@in.ibm.com>
In-Reply-To: <200901051919.52327.chandru@in.ibm.com>
References: <200812241325.49404.chandru@in.ibm.com>
	<18772.11376.339295.42622@cargo.ozlabs.ibm.com>
	<1230586567.19452.100.camel@nimitz>
	<200901051919.52327.chandru@in.ibm.com>
Content-Type: text/plain
Date: Mon, 05 Jan 2009 08:30:33 -0800
Message-Id: <1231173033.19452.190.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-01-05 at 19:19 +0530, Chandru wrote:
> On Tuesday 30 December 2008 03:06:07 Dave Hansen wrote:
> When booted with crashkernel=224M@32M or any memory size less than
> this, the system boots properly. The system comes up with two nodes
> (0-256M and 256M-4GB). The crashkernel memory reservation spans across
> these two nodes. The mark_reserved_regions_for_nid() in
> arch/powerpc/numa.c resizes the reserved part of the memory within it
> as... 
> 
> 	 if (end_pfn > node_ar.end_pfn)
> 		reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
> 				- (start_pfn << PAGE_SHIFT);
> 
> but the reserve_bootmem_node() in mm/bootmem.c raises the pfn value of
> end
> 
> 	end = PFN_UP(physaddr + size);
> 
> This causes end to get a value past the last page in the 0-256M node.
> The following change restricts the value of end if it exceeds the last
> pfn in a given node.

OK, I had to think about this for a good, long time.  That's bad. :)

There are two things that we're dealing with here: "active regions" and
the NODE_DATA's.  The if() you've pasted above resizes the reservation
so that it fits into the current active region.  However, as you noted,
we haven't resized it so that it fits into the NODE_DATA() that we're
looking at.  We call into the bootmem code, and BUG_ON().

The thing I don't like about this is that it might hide bugs in other
callers.  This really is a ppc-specific thing and, although what you
wrote will fix the bug on ppc, it will probably cause someone in the
future to call reserve_bootmem_node() with too large a reservation and
get a silent failure (not reserving the requested size) back.  

We really do need to go take a hard look at the whole interaction
between lmb's, node active regions, and the NUMA code some day.  It has
kinda grown to be a bit ungainly.

How about we just consult the NODE_DATA() in
mark_reserved_regions_for_nid() instead of reserve_bootmem_node()?

> --- linux-2.6.28/mm/bootmem.c.orig	2009-01-05 20:42:12.000000000 +0530
> +++ linux-2.6.28/mm/bootmem.c	2009-01-05 20:43:53.000000000 +0530
> @@ -375,10 +375,14 @@ int __init reserve_bootmem_node(pg_data_
>  				 unsigned long size, int flags)
>  {
>  	unsigned long start, end;
> +	bootmem_data_t *bdata = pgdat->bdata;
> 
>  	start = PFN_DOWN(physaddr);
>  	end = PFN_UP(physaddr + size);
> 
> +	if (end > bdata->node_low_pfn)
> +		end = bdata->node_low_pfn;
> +
>  	return mark_bootmem_node(pgdat->bdata, start, end, 1, flags);
>  }
-- Dave

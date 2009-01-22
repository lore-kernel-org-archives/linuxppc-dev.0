Return-Path: <dave@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1EFF0DDEE2
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 11:29:46 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0M0SDgj032458
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 19:28:13 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0M0Tglm163000
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 19:29:42 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0M0TgqY003035
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 19:29:42 -0500
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Chandru <chandru@in.ibm.com>
In-Reply-To: <200901191700.03580.chandru@in.ibm.com>
References: <200812241325.49404.chandru@in.ibm.com>
	<200901161746.36584.chandru@in.ibm.com>
	<1232128377.27278.69.camel@nimitz>
	<200901191700.03580.chandru@in.ibm.com>
Content-Type: text/plain
Date: Wed, 21 Jan 2009 16:29:39 -0800
Message-Id: <1232584180.27278.86.camel@nimitz>
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

On Mon, 2009-01-19 at 17:00 +0530, Chandru wrote:
> --- linux-2.6.29-rc2/arch/powerpc/mm/numa.c.orig	2009-01-19 16:14:49.000000000 +0530
> +++ linux-2.6.29-rc2/arch/powerpc/mm/numa.c	2009-01-19 16:36:38.000000000 +0530
> @@ -901,7 +901,8 @@ static void mark_reserved_regions_for_ni
>  		get_node_active_region(start_pfn, &node_ar);
>  		while (start_pfn < end_pfn &&
>  			node_ar.start_pfn < node_ar.end_pfn) {
> -			unsigned long reserve_size = size;
> +			unsigned long reserve_size = (size >> PAGE_SHIFT) <<
> +								PAGE_SHIFT;
>  			/*
>  			 * if reserved region extends past active region
>  			 * then trim size to active region
> @@ -917,7 +918,8 @@ static void mark_reserved_regions_for_ni
>  				dbg("reserve_bootmem %lx %lx nid=%d\n",
>  					physbase, reserve_size, node_ar.nid);
>  				reserve_bootmem_node(NODE_DATA(node_ar.nid),
> -						physbase, reserve_size,
> +						(start_pfn << PAGE_SHIFT),
> +						reserve_size,
>  						BOOTMEM_DEFAULT);
>  			}
>  			/*

Chandru, I don't mean to keep ragging on your patches, but I really
don't think this is right, yet.

Let's take, for instance, a 1-byte reservation.  With this code, you've
suddenly turned that into a 0-byte reservation, and that *can't* be
right.  The same thing happens if you have a reservation that spans two
pages.  If you unconditionally round it down, then you might miss the
part that spans a portion of the second page.

It needs to be rounded down like you are suggesting here, but only in
the case where we've gone over the *CURRENT* node's boundary.  This is
kinda what that "if (end_pfn > node_ar.end_pfn)" check is doing.  But,
it evidently screws it up if the overlap isn't by an entire page or
something.

Please also, for pete's sake, use masks (a la PAGE_MASK) or macros if
you're going to page-align something.  Don't shift down and up like
that.  

-- Dave

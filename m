Return-Path: <dave@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64F41474CA
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 07:03:27 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n08K1cqN030421
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 13:01:38 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n08K3FWw056952
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 13:03:17 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n08K3EFT031119
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 13:03:15 -0700
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Chandru <chandru@in.ibm.com>
In-Reply-To: <200901081559.22204.chandru@in.ibm.com>
References: <200812241325.49404.chandru@in.ibm.com>
	<200901071828.13719.chandru@in.ibm.com>
	<1231349125.23462.81.camel@nimitz>
	<200901081559.22204.chandru@in.ibm.com>
Content-Type: text/plain
Date: Thu, 08 Jan 2009 12:03:12 -0800
Message-Id: <1231444992.23462.138.camel@nimitz>
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

On Thu, 2009-01-08 at 15:59 +0530, Chandru wrote:
> @@ -898,9 +899,17 @@ static void mark_reserved_regions_for_ni
>                          * if reserved region extends past active region
>                          * then trim size to active region
>                          */
> -                       if (end_pfn > node_ar.end_pfn)
> +                       if (end_pfn > node_ar.end_pfn) {
>                                 reserve_size = (node_ar.end_pfn << PAGE_SHIFT)
>                                         - (start_pfn << PAGE_SHIFT);
> +                               /*
> +                                * resize it further if the reservation could
> +                                * cross the last page in this node
> +                                */
> +                               if (PFN_UP(physbase+reserve_size) >
> +                                                node_end_pfn)
> +                                       reserve_size -= PAGE_SIZE;
> +                       }
>                         /*

Now I'm even more confused.  Could you please send a fully changelogged
patch that describes the problem, and how this fixes it?  This just
seems like an off-by-one error, which isn't what I thought we had before
at all.

I'm also horribly confused why PFN_UP is needed here.  Is 'physbase' not
page aligned?  reserve_size looks like it *has* to be.  'end_pfn' is
always (as far as I have ever seen in the kernel) the pfn of the page
after the area we are interested in and we treat it as such in that
function.  In the case of an unaligned physbase, that wouldn't be true.

Think of the case where we have a 1-byte reservation.  start_pfn will
equal end_pfn and we won't go into that while loop at *all* and won't
reserve anything.

Does 'end_pfn' need fixing?

-- Dave

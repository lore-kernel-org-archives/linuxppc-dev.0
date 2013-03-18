Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4BEB52C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 21:41:59 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Mar 2013 20:35:35 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9485F357804A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 21:41:34 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2IASA0K9437598
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 21:28:11 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2IAf0YN016468
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 21:41:00 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, benh@kernel.crashing.org
Subject: Re: [patch 2/2] mm: use vm_unmapped_area() on powerpc architecture
In-Reply-To: <20130221230558.C201931C1B7@corp2gmr1-1.hot.corp.google.com>
References: <20130221230558.C201931C1B7@corp2gmr1-1.hot.corp.google.com>
Date: Mon, 18 Mar 2013 16:10:47 +0530
Message-ID: <87hak92dow.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, walken@google.com,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

akpm@linux-foundation.org writes:

> From: Michel Lespinasse <walken@google.com>
> Subject: mm: use vm_unmapped_area() on powerpc architecture
>
> Update the powerpc slice_get_unmapped_area function to make use of
> vm_unmapped_area() instead of implementing a brute force search.
>
> Signed-off-by: Michel Lespinasse <walken@google.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  arch/powerpc/mm/slice.c |  123 ++++++++++++++++++++++++--------------
>  1 file changed, 78 insertions(+), 45 deletions(-)
>
> diff -puN arch/powerpc/mm/slice.c~mm-use-vm_unmapped_area-on-powerpc-architecture arch/powerpc/mm/slice.c
> --- a/arch/powerpc/mm/slice.c~mm-use-vm_unmapped_area-on-powerpc-architecture
> +++ a/arch/powerpc/mm/slice.c
> @@ -237,36 +237,69 @@ static void slice_convert(struct mm_stru
>  #endif
>  }
>
> +/*
> + * Compute which slice addr is part of;
> + * set *boundary_addr to the start or end boundary of that slice
> + * (depending on 'end' parameter);
> + * return boolean indicating if the slice is marked as available in the
> + * 'available' slice_mark.
> + */
> +static bool slice_scan_available(unsigned long addr,
> +				 struct slice_mask available,
> +				 int end,
> +				 unsigned long *boundary_addr)
> +{
> +	unsigned long slice;
> +	if (addr < SLICE_LOW_TOP) {
> +		slice = GET_LOW_SLICE_INDEX(addr);
> +		*boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
> +		return !!(available.low_slices & (1u << slice));
> +	} else {
> +		slice = GET_HIGH_SLICE_INDEX(addr);
> +		*boundary_addr = (slice + end) ?
> +			((slice + end) << SLICE_HIGH_SHIFT) : SLICE_LOW_TOP;
> +		return !!(available.high_slices & (1u << slice));
> +	}
> +}


Can you clarify more on when boundary_addr is set to start of the slice
in the comment ? Also may be it would be better if we can say
slice_scan_prev_available and slice_scan_next_available and get rid of
end completely ?

I have tested with both the patches applied and the resulting kernel boots fine. 

-aneesh

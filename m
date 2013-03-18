Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D105D2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 22:13:12 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Mar 2013 16:38:56 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 09C65E0059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 16:44:09 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2IBCeCm7799266
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 16:42:40 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2IBCcmP028810
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 22:12:42 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, benh@kernel.crashing.org
Subject: Re: [patch 2/2] mm: use vm_unmapped_area() on powerpc architecture
In-Reply-To: <20130221230558.C201931C1B7@corp2gmr1-1.hot.corp.google.com>
References: <20130221230558.C201931C1B7@corp2gmr1-1.hot.corp.google.com>
Date: Mon, 18 Mar 2013 16:42:35 +0530
Message-ID: <87d2ux2c7w.fsf@linux.vnet.ibm.com>
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
> +

how about  ?

static bool slice_scan_available(unsigned long addr,
				 struct slice_mask available,
				 int end,
				 unsigned long *boundary_addr)
{
	unsigned long slice;
	if (addr < SLICE_LOW_TOP) {
		slice = GET_LOW_SLICE_INDEX(addr);
		*boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
		return !!(available.low_slices & (1u << slice));
	} else {
		slice = GET_HIGH_SLICE_INDEX(addr);
		if ((slice + end) >= SLICE_NUM_HIGH)
			/* loop back in the high slice */
			*boundary_addr = SLICE_LOW_TOP;
		else
			*boundary_addr = (slice + end) << SLICE_HIGH_SHIFT;
		return !!(available.high_slices & (1u << slice));
	}
}


-aneesh

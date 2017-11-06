Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVq1d2WWqzDrK5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:44:21 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA6AcnUo036845
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Nov 2017 05:44:18 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e2kr7ftg5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 05:44:18 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 6 Nov 2017 10:44:17 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 2/5] powerpc/64s/hash: Allow MAP_FIXED allocations to
 cross 128TB boundary
In-Reply-To: <20171106100315.29720-3-npiggin@gmail.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
 <20171106100315.29720-3-npiggin@gmail.com>
Date: Mon, 06 Nov 2017 16:14:10 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vainsn45.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> While mapping hints with a length that cross 128TB are disallowed,
> MAP_FIXED allocations that cross 128TB are allowed. These are failing
> on hash (on radix they succeed). Add an additional case for fixed
> mappings to expand the addr_limit when crossing 128TB.

Shouldn't that be fixed in radix. But i see x86 also doing this?


	if (flags & MAP_FIXED)
		return addr;

Kiril,

Is that expected?


>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/slice.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 567db541c0a1..f980397b449d 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -419,7 +419,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	/*
>  	 * Check if we need to expland slice area.
>  	 */
> -	if (unlikely(addr > mm->context.addr_limit &&
> +	if (unlikely(((addr > mm->context.addr_limit) ||
> +			(fixed && addr + len > mm->context.addr_limit)) &&
>  		     mm->context.addr_limit != TASK_SIZE)) {
>  		mm->context.addr_limit = TASK_SIZE;
>  		on_each_cpu(slice_flush_segments, mm, 1);
> -- 
> 2.15.0


-aneesh

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sRr0b2vKYzDrfR
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Sep 2016 21:16:47 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u84BCTeb081133
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 4 Sep 2016 07:16:44 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 258btxtdf2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Sep 2016 07:16:44 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 4 Sep 2016 05:16:43 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc/mm: Speed up computation of base and actual
 page size for a HPTE
In-Reply-To: <20160902115055.GC12433@fergus.ozlabs.ibm.com>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
 <20160902115055.GC12433@fergus.ozlabs.ibm.com>
Date: Sun, 04 Sep 2016 16:46:36 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mvjnrk2z.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> +/*
> + * Fill in the hpte_page_sizes[] array.
> + * We go through the mmu_psize_defs[] array looking for all the
> + * supported base/actual page size combinations.  Each combination
> + * has a unique pagesize encoding (penc) value in the low bits of
> + * the LP field of the HPTE.  For actual page sizes less than 1MB,
> + * some of the upper LP bits are used for RPN bits, meaning that
> + * we need to fill in several entries in hpte_page_sizes[].
> + */


May be can put the details of upper LP bits used for RPN here. ie, add
the below in the comment ?

		/*
		 * encoding bits per actual page size
		 *        PTE LP     actual page size
		 *    rrrr rrrz		>=8KB
		 *    rrrr rrzz		>=16KB
		 *    rrrr rzzz		>=32KB
		 *    rrrr zzzz		>=64KB
		 * .......
		 */


> +static void init_hpte_page_sizes(void)
> +{
> +	long int ap, bp;
> +	long int shift, penc;
> +
> +	for (bp = 0; bp < MMU_PAGE_COUNT; ++bp) {
> +		if (!mmu_psize_defs[bp].shift)
> +			continue;	/* not a supported page size */
> +		for (ap = bp; ap < MMU_PAGE_COUNT; ++ap) {
> +			penc = mmu_psize_defs[bp].penc[ap];
> +			if (penc == -1)
> +				continue;
> +			shift = mmu_psize_defs[ap].shift - LP_SHIFT;
> +			if (shift <= 0)
> +				continue;	/* should never happen */
> +			while (penc < (1 << LP_BITS)) {
> +				hpte_page_sizes[penc] = (ap << 4) | bp;
> +				penc += 1 << shift;
> +			}

Can you add a comment around that while loop ? ie something like.
/*
 * if we are using all LP_BITs in penc, fill the array such that we
 * replicate the ap and bp information, ignoring those bits. They will
 * be filled by rpn bits in hpte.
 */


> +		}
> +	}
> +}
> +
>  static void __init htab_init_page_sizes(void)
>  {
> +	init_hpte_page_sizes();
> +
>  	if (!debug_pagealloc_enabled()) {
>  		/*
>  		 * Pick a size for the linear mapping. Currently, we only
> -- 

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

-aneesh

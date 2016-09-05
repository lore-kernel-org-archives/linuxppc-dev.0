Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSHhW4s8yzDrht
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2016 15:04:27 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8552rcD126091
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 01:04:24 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 258c4uj69p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 01:04:24 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 4 Sep 2016 23:04:23 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc/mm: Speed up computation of base and actual
 page size for a HPTE
In-Reply-To: <20160902115055.GC12433@fergus.ozlabs.ibm.com>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
 <20160902115055.GC12433@fergus.ozlabs.ibm.com>
Date: Mon, 05 Sep 2016 10:34:16 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877farq6nj.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
> +		}
> +	}
> +}
> +

Going through this again, it is confusing . How are we differentiating
between the below penc values

 0000 000z		>=8KB (z = 1)
 0000 zzzz		>=64KB (zzzz = 0001)

Those are made up 'z' values.

-aneesh

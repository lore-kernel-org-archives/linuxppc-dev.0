Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrDkj39QGzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 19:59:57 +1000 (AEST)
Message-ID: <1461232790.26743.0.camel@ellerman.id.au>
Subject: Re: [PATCH V2 29/68] powerpc/mm: Move hugetlb and THP related pmd
 accessors to pgtable.h
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Date: Thu, 21 Apr 2016 19:59:50 +1000
In-Reply-To: <5718A328.10309@gmail.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-30-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5718A328.10309@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-04-21 at 19:53 +1000, Balbir Singh wrote:
> On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> > +static inline int pgd_huge(pgd_t pgd)
> > +{
> > +	/*
> > +	 * leaf pte for huge page
> > +	 */
> > +	return !!(pgd_val(pgd) & _PAGE_PTE);
> > +}
> > +#define pgd_huge pgd_huge
> > +
> 
> ??

#ifndef pgd_huge
#define pgd_huge(x)	0
#endif

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/hugetlb.h#n185

cheers

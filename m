Return-Path: <borntraeger@de.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 569321A2EF4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 20:18:39 +1100 (AEDT)
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EF0581400EA
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2015 20:18:37 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 25 Mar 2015 09:18:34 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2985B1B08067
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2015 09:18:58 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2P9IVEh2228524
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2015 09:18:31 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2P9IUKK012733
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2015 03:18:31 -0600
Message-ID: <55127D65.7060605@de.ibm.com>
Date: Wed, 25 Mar 2015 10:18:29 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 5/6] mm/gup: Replace ACCESS_ONCE with READ_ONCE for
 STRICT_MM_TYPECHECKS
References: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
 <1427274719-25890-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1427274719-25890-5-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=iso-8859-15
Cc: aarcange@redhat.com, aneesh.kumar@in.ibm.com, steve.capper@linaro.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 kirill.shutemov@linux.intel.com, Jason Low <jason.low2@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 25.03.2015 um 10:11 schrieb Michael Ellerman:
> If STRICT_MM_TYPECHECKS is enabled the generic gup code fails to build
> because we are using ACCESS_ONCE on non-scalar types.
> 
> Convert all uses to READ_ONCE.

There is a similar patch from Jason Low in Andrews patch.
If that happens in 4.0-rc, we probably want to merge this before 4.0.


> 
> Cc: akpm@linux-foundation.org
> Cc: kirill.shutemov@linux.intel.com
> Cc: aarcange@redhat.com
> Cc: borntraeger@de.ibm.com
> Cc: steve.capper@linaro.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  mm/gup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index a6e24e246f86..120c3adc843c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -901,7 +901,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  		 *
>  		 * for an example see gup_get_pte in arch/x86/mm/gup.c
>  		 */
> -		pte_t pte = ACCESS_ONCE(*ptep);
> +		pte_t pte = READ_ONCE(*ptep);
>  		struct page *page;
> 
>  		/*
> @@ -1191,7 +1191,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	local_irq_save(flags);
>  	pgdp = pgd_offset(mm, addr);
>  	do {
> -		pgd_t pgd = ACCESS_ONCE(*pgdp);
> +		pgd_t pgd = READ_ONCE(*pgdp);
> 
>  		next = pgd_addr_end(addr, end);
>  		if (pgd_none(pgd))
> 

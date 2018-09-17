Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DKtV02dPzF1p5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 19:04:01 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8H90II0041769
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 05:05:03 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mj7h9ckjw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 05:05:02 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 17 Sep 2018 10:03:56 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>, akpm@linux-foundation.org,
 linux-mm@kvack.org, aneesh.kumar@linux.vnet.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to handle PTE tables with non contiguous entries ?
In-Reply-To: <ddc3bb56-4da0-c093-256f-185d4a612b5c@c-s.fr>
References: <ddc3bb56-4da0-c093-256f-185d4a612b5c@c-s.fr>
Date: Mon, 17 Sep 2018 14:33:50 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87tvmoh4w9.fsf@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Hi,
>
> I'm having a hard time figuring out the best way to handle the following 
> situation:
>
> On the powerpc8xx, handling 16k size pages requires to have page tables 
> with 4 identical entries.

I assume that hugetlb page size? If so isn't that similar to FSL hugetlb
page table layout?

>
> Initially I was thinking about handling this by simply modifying 
> pte_index() which changing pte_t type in order to have one entry every 
> 16 bytes, then replicate the PTE value at *ptep, *ptep+1,*ptep+2 and 
> *ptep+3 both in set_pte_at() and pte_update().
>
> However, this doesn't work because many many places in the mm core part 
> of the kernel use loops on ptep with single ptep++ increment.
>
> Therefore did it with the following hack:
>
>   /* PTE level */
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> +typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
> +#else
>   typedef struct { pte_basic_t pte; } pte_t;
> +#endif
>
> @@ -181,7 +192,13 @@ static inline unsigned long pte_update(pte_t *p,
>          : "cc" );
>   #else /* PTE_ATOMIC_UPDATES */
>          unsigned long old = pte_val(*p);
> -       *p = __pte((old & ~clr) | set);
> +       unsigned long new = (old & ~clr) | set;
> +
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> +       p->pte = p->pte1 = p->pte2 = p->pte3 = new;
> +#else
> +       *p = __pte(new);
> +#endif
>   #endif /* !PTE_ATOMIC_UPDATES */
>
>   #ifdef CONFIG_44x
>
>
> @@ -161,7 +161,11 @@ static inline void __set_pte_at(struct mm_struct 
> *mm, unsigned long addr,
>          /* Anything else just stores the PTE normally. That covers all 
> 64-bit
>           * cases, and 32-bit non-hash with 32-bit PTEs.
>           */
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> +       ptep->pte = ptep->pte1 = ptep->pte2 = ptep->pte3 = pte_val(pte);
> +#else
>          *ptep = pte;
> +#endif
>
>
>
> But I'm not too happy with it as it means pte_t is not a single type 
> anymore so passing it from one function to the other is quite heavy.
>
>
> Would someone have an idea of an elegent way to handle that ?
>
> Thanks
> Christophe

Why would pte_update bother about updating all the 4 entries?. Can you
help me understand the issue?

-aneesh

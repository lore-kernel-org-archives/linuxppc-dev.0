Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLQpG158NzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 11:03:49 +1000 (AEST)
Message-ID: <1464915818.26773.7.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc/mm/radix: Flush page walk cache when
 freeing page table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 03 Jun 2016 11:03:38 +1000
In-Reply-To: <1464860789-3672-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1464860789-3672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1464860789-3672-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Thu, 2016-06-02 at 15:16 +0530, Aneesh Kumar K.V wrote:
> 
> 
> +/*
> + * flush the page walk cache for the address
> + */
> +void flush_tlb_pgtable(struct mmu_gather *tlb, unsigned long address)
> +{
> +       struct mm_struct *mm = tlb->mm;
> +       /*
> +        * flush the page table walk cache on freeing page table. We already
> +        * have marked the upper/higher level page table entry none by now.
> +        * So it is safe to flush PWC here.
> +        */
> +       if (!radix_enabled())
> +               return;
> +       radix__flush_tlb_mm_pwc(mm);

That means that on hash, we pay the price of a useless function call
and return. Shouldn't we put the radix_enabled() test in the caller
instead ?

Cheers,
Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN0qd1HNJzDvkq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 07:41:00 +1100 (AEDT)
Message-ID: <1479760841.10230.47.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 6/6] powerpc/mm: Batch tlb flush when invalidating
 pte entries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Nov 2016 07:40:41 +1100
In-Reply-To: <20161121183322.14585-6-aneesh.kumar@linux.vnet.ibm.com>
References: <20161121183322.14585-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161121183322.14585-6-aneesh.kumar@linux.vnet.ibm.com>
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

On Tue, 2016-11-22 at 00:03 +0530, Aneesh Kumar K.V wrote:
> +               /*
> +                * If we are trying to clear the pte, we can skip
> +                * the below sequence and batch the tlb flush. The
> +                * tlb flush batching is done by mmu gather code
> +                */
> +               if (new_pte) {
> +                       asm volatile("ptesync" : : : "memory");
> +                       psize = radix_get_mmu_psize(pg_sz);
> +                       radix__flush_tlb_page_psize(mm, addr, psize);
> +                       __radix_pte_update(ptep, 0, new_pte);
> +               }
>         } else
>                 old_pte = __radix_pte_update(ptep, clr, set);

Can you check the valid bit ? What if we are just setting a swap PTE
on top of an invalid one for example ?

Should the above case be limited to both old and new being valid ?

Cheers,
Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D2FE1A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 15:27:53 +1000 (EST)
Message-ID: <1406006862.22200.7.camel@pasglop>
Subject: Re: [PATCH] powerpc: thp: Add write barrier after updating the
 valid bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 22 Jul 2014 15:27:42 +1000
In-Reply-To: <1405435937-24115-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1405435937-24115-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-07-15 at 20:22 +0530, Aneesh Kumar K.V wrote:
> With hugepages, we store the hpte valid information in the pte page
> whose address is stored in the second half of the PMD. Use a
> write barrier to make sure that clearing pmd busy bit and updating
> hpte valid info are ordered properly.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pgtable-ppc64.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
> index eb9261024f51..558beb760062 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -394,6 +394,12 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
>  					unsigned int index, unsigned int hidx)
>  {
>  	hpte_slot_array[index] = hidx << 4 | 0x1 << 3;
> +	/*
> +	 * The hpte valid is stored in the pgtable whose address is in the
> +	 * second half of the PMD. Order this against clearing of the busy bit in
> +	 * huge pmd.
> +	 */
> +	smp_wmb();
>  }

A better place for this would be right before the last write to the PMD
(that's also clearing BUSY) in __hash_page_thp(). Basically, it's the
normal lock ordering that's missing here, nothing specific to
mark_hpte_slot_valid() but instead, any state relative to the BUSY bit
in the PMD (including the actual hash writes in update_pp etc...)

>  struct page *realmode_pfn_to_page(unsigned long pfn);

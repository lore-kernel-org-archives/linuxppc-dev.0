Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpqhT1RN0zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 13:08:08 +1000 (AEST)
Received: by mail-pa0-x230.google.com with SMTP id fs9so1676579pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 20:08:08 -0700 (PDT)
Subject: Re: [PATCH v8 20/45] powerpc/powernv: Allocate PE# in reverse order
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-21-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5715A10F.2030704@ozlabs.ru>
Date: Tue, 19 Apr 2016 13:07:59 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-21-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:44 PM, Gavin Shan wrote:
> PE number for one particular PE can be allocated dynamically or
> reserved according to the consumed M64 (64-bits prefetchable)
> segments of the PE. The M64 resources, and hence their segments
> and PE number are assigned/reserved in ascending order. The PE
> numbers are allocated dynamically in ascending order as well.
> It's not a problem as the PE numbers are reserved and then
> allocated all at once in fine order. However, it will introduce
> conflicts when PCI hotplug is supported: the PE number to be
> reserved for newly added PE might have been assigned.
>
> To resolve above conflicts, this forces the PE number to be
> allocated dynamically in reverse order. With this patch applied,
> the PE numbers are reserved in ascending order, but allocated
> dynamically in reverse order.


The patch is probably is ok, the commit log is not - I do not follow it. 
Some PEs are reserved (for what? why does the absolute PE number matter? 
put it in the commit log), that means that the corresponding bits in 
pe_alloc[] should be set so when you will be allocating PEs for a just 
plugged device, you won't pick them and you will pick free ones, and the 
order should not matter. I would think that "reservation" happens once at 
the boot time so you set "used" bits for the reserved PEs then and after 
that the dynamic allocator will skip them.


>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index f182ca7..565725b 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -144,16 +144,14 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>
>   static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
>   {
> -	unsigned long pe;
> +	unsigned long pe = phb->ioda.total_pe_num - 1;
>
> -	do {
> -		pe = find_next_zero_bit(phb->ioda.pe_alloc,
> -					phb->ioda.total_pe_num, 0);
> -		if (pe >= phb->ioda.total_pe_num)
> -			return NULL;
> -	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
> +	for (pe = phb->ioda.total_pe_num - 1; pe >= 0; pe--) {
> +		if (!test_and_set_bit(pe, phb->ioda.pe_alloc))
> +			return pnv_ioda_init_pe(phb, pe);
> +	}
>
> -	return pnv_ioda_init_pe(phb, pe);
> +	return NULL;
>   }
>
>   static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe)
>


-- 
Alexey

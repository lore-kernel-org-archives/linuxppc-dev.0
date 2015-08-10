Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54A071A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 00:39:11 +1000 (AEST)
Received: by pacgr6 with SMTP id gr6so28428365pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 07:39:09 -0700 (PDT)
Subject: Re: [PATCH v6 18/42] powerpc/powernv: Allocate PE# in deasending order
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-19-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com, panto@antoniou-consulting.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C8B786.1050702@ozlabs.ru>
Date: Tue, 11 Aug 2015 00:39:02 +1000
MIME-Version: 1.0
In-Reply-To: <1438834307-26960-19-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/2015 02:11 PM, Gavin Shan wrote:
> The available PE#, represented by a bitmap in the PHB, is allocated
> in ascending order.

Available PE# is available exactly because it is not allocated ;)

> It conflicts with the fact that M64 segments are
> assigned in same order. In order to avoid the conflict, the patch
> allocates PE# in descending order.

What kind of conflict?


>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 56b058c..1c950e8 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -161,13 +161,18 @@ static struct pnv_ioda_pe *pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>   static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
>   {
>   	unsigned long pe;
> +	unsigned long limit = phb->ioda.total_pe_num - 1;
>
>   	do {
>   		pe = find_next_zero_bit(phb->ioda.pe_alloc,
> -					phb->ioda.total_pe_num, 0);
> -		if (pe >= phb->ioda.total_pe_num)
> +					phb->ioda.total_pe_num, limit);
> +		if (pe < phb->ioda.total_pe_num &&
> +		    !test_and_set_bit(pe, phb->ioda.pe_alloc))
> +			break;
> +
> +		if (--limit >= phb->ioda.total_pe_num)
>   			return NULL;
> -	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
> +	} while (1);


Usually, if it is "while(1)", then it is "while(1){}" rather than 
"do{}while(1)" :)


>
>   	return pnv_ioda_init_pe(phb, pe);
>   }
>


-- 
Alexey

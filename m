Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 494671A006D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 23:26:17 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 07:26:14 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 38D2738C8039
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 07:26:13 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1ACQDMB23658594
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 12:26:13 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1ACQCiR027690
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 07:26:13 -0500
Received: from oc5780617838.ibm.com ([9.80.84.27])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u1ACQBuB027610
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 07:26:11 -0500
Subject: Re: [RFC PATCH kernel] powerpc/ioda: Set "read" permission when
 "write" is set
To: linuxppc-dev@lists.ozlabs.org
References: <1452573620-17979-1-git-send-email-aik@ozlabs.ru>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Message-ID: <56BB2C63.4060206@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 06:26:11 -0600
MIME-Version: 1.0
In-Reply-To: <1452573620-17979-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested-by: Douglas Miller <dougmill@linux.vnet.ibm.com>


On 01/11/2016 10:40 PM, Alexey Kardashevskiy wrote:
> Quite often drivers set only "write" permission assuming that this
> includes "read" permission as well and this works on plenty platforms.
> However IODA2 is strict about this and produces an EEH when "read"
> permission is not and reading happens.
>
> This adds a workaround in IODA code to always add the "read" bit when
> the "write" bit is set.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
>
> Ben, what was the driver which did not set "read" and caused EEH?
>
>
> ---
>   arch/powerpc/platforms/powernv/pci.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index f2dd772..c7dcae5 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -601,6 +601,9 @@ int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
>   	u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
>   	long i;
>   
> +	if (proto_tce & TCE_PCI_WRITE)
> +		proto_tce |= TCE_PCI_READ;
> +
>   	for (i = 0; i < npages; i++) {
>   		unsigned long newtce = proto_tce |
>   			((rpn + i) << tbl->it_page_shift);
> @@ -622,6 +625,9 @@ int pnv_tce_xchg(struct iommu_table *tbl, long index,
>   
>   	BUG_ON(*hpa & ~IOMMU_PAGE_MASK(tbl));
>   
> +	if (newtce & TCE_PCI_WRITE)
> +		newtce |= TCE_PCI_READ;
> +
>   	oldtce = xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
>   	*hpa = be64_to_cpu(oldtce) & ~(TCE_PCI_READ | TCE_PCI_WRITE);
>   	*direction = iommu_tce_direction(oldtce);

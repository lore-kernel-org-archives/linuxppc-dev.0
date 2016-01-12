Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 332011A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 10:07:45 +1100 (AEDT)
Message-ID: <1452640054.3262.11.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH kernel] powerpc/ioda: Set "read" permission when
 "write" is set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras
 <paulus@samba.org>
Date: Wed, 13 Jan 2016 10:07:34 +1100
In-Reply-To: <1452573620-17979-1-git-send-email-aik@ozlabs.ru>
References: <1452573620-17979-1-git-send-email-aik@ozlabs.ru>
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

On Tue, 2016-01-12 at 15:40 +1100, Alexey Kardashevskiy wrote:
> Quite often drivers set only "write" permission assuming that this
> includes "read" permission as well and this works on plenty
> platforms.
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

aacraid

Cheers,
Ben.

> 
> ---
>  arch/powerpc/platforms/powernv/pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci.c
> b/arch/powerpc/platforms/powernv/pci.c
> index f2dd772..c7dcae5 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -601,6 +601,9 @@ int pnv_tce_build(struct iommu_table *tbl, long
> index, long npages,
>  	u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
>  	long i;
>  
> +	if (proto_tce & TCE_PCI_WRITE)
> +		proto_tce |= TCE_PCI_READ;
> +
>  	for (i = 0; i < npages; i++) {
>  		unsigned long newtce = proto_tce |
>  			((rpn + i) << tbl->it_page_shift);
> @@ -622,6 +625,9 @@ int pnv_tce_xchg(struct iommu_table *tbl, long
> index,
>  
>  	BUG_ON(*hpa & ~IOMMU_PAGE_MASK(tbl));
>  
> +	if (newtce & TCE_PCI_WRITE)
> +		newtce |= TCE_PCI_READ;
> +
>  	oldtce = xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
>  	*hpa = be64_to_cpu(oldtce) & ~(TCE_PCI_READ |
> TCE_PCI_WRITE);
>  	*direction = iommu_tce_direction(oldtce);

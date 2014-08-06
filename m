Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78EC71A0367
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 16:27:16 +1000 (EST)
Message-ID: <1407306422.3073.70.camel@pasglop>
Subject: Re: [PATCH v4 11/16] powerpc/powernv: Release replaced TCE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 06 Aug 2014 16:27:02 +1000
In-Reply-To: <1406712695-9491-12-git-send-email-aik@ozlabs.ru>
References: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
 <1406712695-9491-12-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-07-30 at 19:31 +1000, Alexey Kardashevskiy wrote:
>  
>  static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
> -                        unsigned long uaddr, enum dma_data_direction direction,
> +                        unsigned long uaddr, unsigned long *old_tces,
> +                        enum dma_data_direction direction,
>                          struct dma_attrs *attrs, bool rm)
>  {
>         u64 proto_tce;
>         __be64 *tcep, *tces;
>         u64 rpn;
> +       long i;
>  
>         proto_tce = TCE_PCI_READ; // Read allowed
>  
> @@ -587,9 +589,13 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
>         tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>         rpn = __pa(uaddr) >> tbl->it_page_shift;
>  
> -       while (npages--)
> -               *(tcep++) = cpu_to_be64(proto_tce |
> -                               (rpn++ << tbl->it_page_shift));
> +       for (i = 0; i < npages; i++) {
> +               unsigned long oldtce = xchg(tcep, cpu_to_be64(proto_tce |
> +                               (rpn++ << tbl->it_page_shift)));
> +               if (old_tces)
> +                       old_tces[i] = (unsigned long) __va(oldtce);
> +               tcep++;
> +       }

xchg() is slow, please keep separate implementation for build and
set_and_get() to avoid the performance loss on normal TCE host
operations.

Cheers,
Ben.

>         pnv_tce_invalidate(tbl, tces, tcep - 1, rm);
>  
> @@ -601,8 +607,18 @@ static int pnv_tce_build_vm(struct iommu_table *tbl, long index, long npages,
>                             enum dma_data_direction direction,
>                             struct dma_attrs *attrs)
>  {
> -       return pnv_tce_build(tbl, index, npages, uaddr, direction, attrs,
> -                       false);
> +       return pnv_tce_build(tbl, index, npages, uaddr, NULL, direction,
> +                       attrs, false);
> +}
> +
> +static int pnv_tce_set_and_get_vm(struct iommu_table *tbl, long index,
> +                                 long npages,
> +                                 unsigned long uaddr, unsigned long *old_tces,
> +                                 enum dma_data_direction direction,
> +                                 struct dma_attrs *attrs)
> +{
> +       return pnv_tce_build(tbl, index, npages, uaddr, old_tces, direction,
> +                       attrs, false);
>  }
>  
>  static void pnv_tce_free(struct iommu_table *tbl, long index, long npages,
> @@ -630,6 +646,7 @@ static unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
>  
>  struct iommu_table_ops pnv_iommu_ops = {
>         .set = pnv_tce_build_vm,
> +       .set_and_get = pnv_tce_set_and_get_vm,
>         .clear = pnv_tce_free_vm,
>         .get = pnv_tce_get,

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A81151A0725
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Sep 2015 20:03:50 +1000 (AEST)
Message-ID: <1441361029.3777.2.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/powernv/pci-ioda: fix 32-bit TCE table init
 in kdump kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, Hari Bathini
 <hbathini@linux.vnet.ibm.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>, Ben
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>, Wei Yang
 <weiyang@linux.vnet.ibm.com>,  linuxppc-dev@lists.ozlabs.org
Date: Fri, 04 Sep 2015 20:03:49 +1000
In-Reply-To: <55E912E0.1000602@ozlabs.ru>
References: <20150902011123.GA47557@linux.vnet.ibm.com>
 <55E6BAAF.9090502@ozlabs.ru> <20150902153928.GB47557@linux.vnet.ibm.com>
 <1441274333.26379.4.camel@ellerman.id.au> <55E912E0.1000602@ozlabs.ru>
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

On Fri, 2015-09-04 at 13:41 +1000, Alexey Kardashevskiy wrote:
> On 09/03/2015 07:58 PM, Michael Ellerman wrote:
> > On Wed, 2015-09-02 at 08:39 -0700, Nishanth Aravamudan wrote:
> >> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> >> index 85cbc96eff6c..e51aff01a218 100644
> >> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> >> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> >> @@ -2077,10 +2077,17 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
> >>   {
> >>   	struct iommu_table *tbl = NULL;
> >>   	long rc;
> >> +	/*
> >> +	 * In memory constrained environments, e.g. kdump kernel, the
> >> +	 * DMA window can be larger than available memory, which will
> >> +	 * cause errors later.
> >> +	 */
> >> +	const __u64 window_size =
> >
> > Why is this using __u64 and not u64, it's not exported to userspace.
> >
> > It looks like pnv_pci_ioda2_create_table() uses __u64, but there's no reason
> > for that AFAICS either. And yes I did commit it so it's my fault :)
> 
> There is VFIO_IOMMU_SPAPR_TCE_CREATE ioctl which receives 
> vfio_iommu_spapr_tce_create struct from the user space and there is "__u64 
> window_size" which is passed across:
> tce_iommu_create_window()
> tce_iommu_create_table()
> pnv_pci_ioda2_create_table (via table_group->ops->create_table())
> 
> At what point should __u64 have become u64?

As soon as it was pulled out of the struct. So here:

		ret = tce_iommu_create_window(container, create.page_shift,
				create.window_size, create.levels,
				&create.start_addr);

ie, instead of:

	static long tce_iommu_create_window(struct tce_container *container,
			__u32 page_shift, __u64 window_size, __u32 levels,
			__u64 *start_addr)

this:

	static long tce_iommu_create_window(struct tce_container *container,
			u32 page_shift, u64 window_size, u32 levels,
			u64 *start_addr)


cheers

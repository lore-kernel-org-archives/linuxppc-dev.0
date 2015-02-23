Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A0491A0184
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 13:27:24 +1100 (AEDT)
In-Reply-To: <20150221190050.GA20184@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2] pseries/iommu: remove iommu device references via bus
 notifier
Message-Id: <20150223022724.7884914012C@ozlabs.org>
Date: Mon, 23 Feb 2015 13:27:24 +1100 (AEDT)
Cc: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-21-02 at 19:00:50 UTC, Nishanth Aravamudan wrote:
> On 20.02.2015 [15:31:29 +1100], Michael Ellerman wrote:
> > On Thu, 2015-02-19 at 10:41 -0800, Nishanth Aravamudan wrote:
> > > After d905c5df9aef ("PPC: POWERNV: move iommu_add_device earlier"), the
> > > refcnt on the kobject backing the IOMMU group for a PCI device is
> > > elevated by each call to pci_dma_dev_setup_pSeriesLP() (via
> > > set_iommu_table_base_and_group). When we go to dlpar a multi-function
> > > PCI device out:
> > > 
> > > 	iommu_reconfig_notifier ->
> > > 		iommu_free_table ->
> > > 			iommu_group_put
> > > 			BUG_ON(tbl->it_group)
> > > 
> > > We trip this BUG_ON, because there are still references on the table, so
> > > it is not freed. Fix this by also adding a bus notifier identical to
> > > PowerNV for pSeries.
> > 
> > Please put it somewhere common, arch/powerpc/kernel/iommu.c perhaps, and just
> > add a second machine_init_call() for pseries.
> 
> How does this look? Only compile-tested with CONFIG_IOMMU_API on/off so
> far, waiting for access to the test LPAR (should have it on Monday).

Yeah that looks better, thanks.

It probably doesn't build with CONFIG_PCI=n though, but I don't think
CONFIG_PCI=n builds anyway.

cheers

Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 276781A0D50
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 07:45:00 +1100 (AEDT)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 23 Feb 2015 13:44:58 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0C4821FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 13:36:07 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1NKirE832833576
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 13:44:53 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1NKisVs028605
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 13:44:55 -0700
Date: Mon, 23 Feb 2015 12:44:53 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] pseries/iommu: remove iommu device references via bus
 notifier
Message-ID: <20150223204453.GA39962@linux.vnet.ibm.com>
References: <20150219184103.GB13745@linux.vnet.ibm.com>
 <1424406689.11680.3.camel@ellerman.id.au>
 <20150221190050.GA20184@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150221190050.GA20184@linux.vnet.ibm.com>
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21.02.2015 [11:00:50 -0800], Nishanth Aravamudan wrote:
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
> 
> 
> After d905c5df9aef ("PPC: POWERNV: move iommu_add_device earlier"), the
> refcnt on the kobject backing the IOMMU group for a PCI device is
> elevated by each call to pci_dma_dev_setup_pSeriesLP() (via
> set_iommu_table_base_and_group). When we go to dlpar a multi-function
> PCI device out:
> 
>         iommu_reconfig_notifier ->
>                 iommu_free_table ->
>                         iommu_group_put
>                         BUG_ON(tbl->it_group)
> 
> We trip this BUG_ON, because there are still references on the table, so
> it is not freed. Fix this by moving the PowerNV bus notifier to common
> code and calling it for both PowerNV and pSeries.

Survived a remove -> add -> remove cycle, which always resulted in the
BUG_ON without the change.

> Fixes: d905c5df9aef ("PPC: POWERNV: move iommu_add_device earlier")
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Cc: stable@kernel.org (3.13+)

Tested-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

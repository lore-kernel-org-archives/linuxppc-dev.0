Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B06D1A0CEB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 05:55:34 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 23 Feb 2015 11:55:32 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 9FE743E40041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 11:55:30 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1NItMCZ54067220
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 11:55:30 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1NIst1M031666
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 11:54:57 -0700
Date: Mon, 23 Feb 2015 10:54:29 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2] pseries/iommu: remove iommu device references via bus
 notifier
Message-ID: <20150223185429.GA54252@linux.vnet.ibm.com>
References: <20150221190050.GA20184@linux.vnet.ibm.com>
 <20150223022724.7884914012C@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150223022724.7884914012C@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23.02.2015 [13:27:24 +1100], Michael Ellerman wrote:
> On Sat, 2015-21-02 at 19:00:50 UTC, Nishanth Aravamudan wrote:
> > On 20.02.2015 [15:31:29 +1100], Michael Ellerman wrote:
> > > On Thu, 2015-02-19 at 10:41 -0800, Nishanth Aravamudan wrote:
> > > > After d905c5df9aef ("PPC: POWERNV: move iommu_add_device earlier"), the
> > > > refcnt on the kobject backing the IOMMU group for a PCI device is
> > > > elevated by each call to pci_dma_dev_setup_pSeriesLP() (via
> > > > set_iommu_table_base_and_group). When we go to dlpar a multi-function
> > > > PCI device out:
> > > > 
> > > > 	iommu_reconfig_notifier ->
> > > > 		iommu_free_table ->
> > > > 			iommu_group_put
> > > > 			BUG_ON(tbl->it_group)
> > > > 
> > > > We trip this BUG_ON, because there are still references on the table, so
> > > > it is not freed. Fix this by also adding a bus notifier identical to
> > > > PowerNV for pSeries.
> > > 
> > > Please put it somewhere common, arch/powerpc/kernel/iommu.c perhaps, and just
> > > add a second machine_init_call() for pseries.
> > 
> > How does this look? Only compile-tested with CONFIG_IOMMU_API on/off so
> > far, waiting for access to the test LPAR (should have it on Monday).
> 
> Yeah that looks better, thanks.
> 
> It probably doesn't build with CONFIG_PCI=n though, but I don't think
> CONFIG_PCI=n builds anyway.

Indeed it doesn't. Started looking at CONFIG_PCI=n and immediately hit
the following:

PCI_MSI depends on PCI

PCI can be manually turned off

PSERIES (and a bunch of other platforms) select PCI_MSI

So you end up with PCI_MSI on and PCI off and the build breaks.

Should the platforms depend on PCI_MSI instead?

Per the Documentation:
"        select should be used with care. select will force
        a symbol to a value without visiting the dependencies.
        By abusing select you are able to select a symbol FOO even
        if FOO depends on BAR that is not set."

Thanks,
Nish

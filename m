Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F3DA1A0E4F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 15:31:30 +1100 (AEDT)
Message-ID: <1424406689.11680.3.camel@ellerman.id.au>
Subject: Re: [PATCH] pseries/iommu: remove iommu device references via bus
 notifier
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Fri, 20 Feb 2015 15:31:29 +1100
In-Reply-To: <20150219184103.GB13745@linux.vnet.ibm.com>
References: <20150219184103.GB13745@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-02-19 at 10:41 -0800, Nishanth Aravamudan wrote:
> After d905c5df9aef ("PPC: POWERNV: move iommu_add_device earlier"), the
> refcnt on the kobject backing the IOMMU group for a PCI device is
> elevated by each call to pci_dma_dev_setup_pSeriesLP() (via
> set_iommu_table_base_and_group). When we go to dlpar a multi-function
> PCI device out:
> 
> 	iommu_reconfig_notifier ->
> 		iommu_free_table ->
> 			iommu_group_put
> 			BUG_ON(tbl->it_group)
> 
> We trip this BUG_ON, because there are still references on the table, so
> it is not freed. Fix this by also adding a bus notifier identical to
> PowerNV for pSeries.

Please put it somewhere common, arch/powerpc/kernel/iommu.c perhaps, and just
add a second machine_init_call() for pseries.

cheers

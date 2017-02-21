Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vScCy3CjLzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 10:29:49 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LNSf5X139149
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 18:29:47 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28rq6ynwkr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 18:29:47 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 09:29:44 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0BB082CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 10:29:42 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LNTXsj45023322
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 10:29:41 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LNT9wd021207
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 10:29:09 +1100
Date: Wed, 22 Feb 2017 10:28:44 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Update iommu table base on
 ownership change
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170221024131.47753-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221024131.47753-1-aik@ozlabs.ru>
Message-Id: <20170221232844.GA8704@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 21, 2017 at 01:41:31PM +1100, Alexey Kardashevskiy wrote:
>On POWERNV platform, in order to do DMA via IOMMU (i.e. 32bit DMA in
>our case), a device needs an iommu_table pointer set via
>set_iommu_table_base().
>
>The codeflow is:
>- pnv_pci_ioda2_setup_dma_pe()
>	- pnv_pci_ioda2_setup_default_config()
>	- pnv_ioda_setup_bus_dma() [1]
>
>pnv_pci_ioda2_setup_dma_pe() creates IOMMU groups,
>pnv_pci_ioda2_setup_default_config() does default DMA setup,
>pnv_ioda_setup_bus_dma() takes a bus PE (on IODA2, all physical function
>PEs as bus PEs except NPU), walks through all underlying buses and
>devices, adds all devices to an IOMMU group and sets iommu_table.
>
>On IODA2, when VFIO is used, it takes ownership over a PE which means it
>removes all tables and creates new ones (with a possibility of sharing
>them among PEs). So when the ownership is returned from VFIO to
>the kernel, the iommu_table pointer written to a device at [1] is
>stale and needs an update.
>
>This adds an "add_to_group" parameter to pnv_ioda_setup_bus_dma()
>(in fact re-adds as it used to be there a while ago for different
>reasons) to tell the helper if a device needs to be added to
>an IOMMU group with an iommu_table update or just the latter.
>
>This calls pnv_ioda_setup_bus_dma(..., false) from
>pnv_ioda2_release_ownership() so when the ownership is restored,
>32bit DMA can work again for a device. This does the same thing
>on obtaining ownership as the iommu_table point is stale at this point
>anyway and it is safer to have NULL there.
>
>We did not hit this earlier as all tested devices in recent years were
>only using 64bit DMA; the rare exception for this is MPT3 SAS adapter
>which uses both 32bit and 64bit DMA access and it has not been tested
>with VFIO much.
>
>Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

One thing would be improved in future, which isn't relevant to
this patch if my understanding is correct enough: The TCE table for
DMA32 space created during system boot is destroyed when VFIO takes
the ownership. The same TCE table (same level, page size, window size
etc) is created and associated to the PE again. Some CPU cycles would
be saved if the original table is picked up without creating a new one.

The involved function is pnv_pci_ioda2_create_table(). Its primary work
is to allocate pages from buddy. It's usually fast if there are enough
free pages. Otherwise, it would be relatively slow. It also has the risk
to fail the allocation. I guess it's not bad to save CPU cycles in this
critical (maybe hot?) path.

Thanks,
Gavin 

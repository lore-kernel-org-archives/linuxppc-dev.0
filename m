Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSb0n3jbmzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:35:05 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LMYUoq083262
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 17:35:03 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28rpx2dh0y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 17:35:03 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 08:35:00 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DECB03578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:34:56 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LMYmqR41549862
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:34:56 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LMYNwc026971
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:34:24 +1100
Date: Wed, 22 Feb 2017 09:33:59 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel] powerpc/powernv/npu: Remove dead iommu code
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170221024020.47631-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221024020.47631-1-aik@ozlabs.ru>
Message-Id: <20170221223359.GB5151@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 21, 2017 at 01:40:20PM +1100, Alexey Kardashevskiy wrote:
>PNV_IODA_PE_DEV is only used for NPU devices (emulated PCI bridges
>representing NVLink). These are added to IOMMU groups with corresponding
>NVIDIA devices after all non-NPU PEs are setup; a special helper -
>pnv_pci_ioda_setup_iommu_api() - handles this in pnv_pci_ioda_fixup().
>
>The pnv_pci_ioda2_setup_dma_pe() helper sets up DMA for a PE. It is called
>for VFs (so it does not handle NPU case) and PCI bridges but only
>IODA1 and IODA2 types. An NPU bridge has its own type id (PNV_PHB_NPU)
>so pnv_pci_ioda2_setup_dma_pe() cannot be called on NPU and therefore
>(pe->flags & PNV_IODA_PE_DEV) is always "false".
>
>This removes not used iommu_add_device(). This should not cause any
>behavioral change.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

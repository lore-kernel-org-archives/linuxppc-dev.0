Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 85FFF14007D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 16:11:46 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 21 Apr 2014 11:41:42 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id CA7F2E0044
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 11:46:03 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3L6BbD653936292
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 11:41:37 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3L6BdVG021923
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 11:41:39 +0530
Date: Mon, 21 Apr 2014 14:11:37 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/powernc: revert part of commit d905c5df(PPC:
 POWERNV: move iommu_add_device earlier)
Message-ID: <20140421061137.GC24712@richard>
References: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1398047119-6861-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <1398051452.19682.15.camel@pasglop>
 <20140421052213.GA24712@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140421052213.GA24712@richard>
Cc: aik@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2014 at 01:22:13PM +0800, Wei Yang wrote:
>On Mon, Apr 21, 2014 at 01:37:32PM +1000, Benjamin Herrenschmidt wrote:
>>On Mon, 2014-04-21 at 10:25 +0800, Wei Yang wrote:
>>> Here is a draft call flow:
>>> 
>>> pci_device_add
>>>    pcibios_add_device
>>>       pci_dma_dev_setup
>>>          pnv_pci_dma_dev_setup
>>>             pnv_pci_ioda_dma_dev_setup
>>>                set_iommu_table_base_and_group <--- here
>>> device_add
>>> 
>>> When set_iommu_table_base_and_group() is invoked int
>>> pnv_pci_ioda_dma_dev_setup(), the dev->kobj->sd is not initialized. The
>>> dev->kobj->sd is initialized in device_add().
>>> 
>>> After applying this patch, the error
>>>     iommu_tce: 0003:05:00.0 has not been added, ret=-14
>>> is cleared.
>>> 
>>> This patch revert the change for pnv_pci_ioda_dma_dev_setup() from commit
>>> d905c5df(PPC: POWERNV: move iommu_add_device earlier).
>>
>>But in that case, is the group still set ?
>
>I think so.
>
>iommu_add_device() will be invoked when device_add() notify the pci bus.
>

Did a quick test, after applying this patch, the logic would be the same for
VF and PF hotplug, the iommu_group is created with corresponding device.

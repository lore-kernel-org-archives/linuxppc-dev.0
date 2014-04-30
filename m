Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 126AB1400A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 10:27:59 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 30 Apr 2014 10:27:58 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7C7FA2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 10:27:56 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3U06j6I53805248
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 10:06:46 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3U0Rsrk030150
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 10:27:55 +1000
Date: Wed, 30 Apr 2014 10:28:12 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: reduce multi-hit of
 iommu_add_device()
Message-ID: <20140430002812.GA13183@shangw>
References: <1398219993-6326-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <535E5924.8040503@au1.ibm.com> <20140429064955.GA5066@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140429064955.GA5066@richard>
Cc: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@au1.ibm.com>,
 gwshan@linux.vnet.ibm.com
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2014 at 02:49:55PM +0800, Wei Yang wrote:
>On Mon, Apr 28, 2014 at 11:35:32PM +1000, Alexey Kardashevskiy wrote:
>>On 04/23/2014 12:26 PM, Wei Yang wrote:

.../...

>Generally, when kernel enumerate on the pci device, following functions will
>be invoked.
>
>     pci_device_add
>        pcibios_setup_bus_device
>        ...
>        set_iommu_table_base_and_group   
>     device_add
>        ...
>        tce_iommu_bus_notifier           
>     pcibios_fixup_bus
>        pcibios_add_pci_devices
>        ...
>        pcibios_setup_bus_devices        
>
>From the call flow, we see for a normall pci device, the
>pcibios_setup_bus_device() will be invoked twice.
>
>At the bootup time, none of them succeed to setup the dma, since the PE is not
>assigned or the tbl is not set. The iommu tbl and group is setup in
>pnv_pci_ioda_setup_DMA().
>

Yes, we don't assign PE# for PCI devices until ppc_md.pcibios_fixup().
We gets IOMMU group and IOMMU group device registered in ppc_md.pcibios_fixup().

As Alexy already pointed out, "tce_iommu_bus_notifier" doesn't take effect
during system boot stage.

>This call flow maintains the same when EEH error happens on Bus PE, while the
>behavior is a little different. 
>
>     pci_device_add
>        pcibios_setup_bus_device
>        ...
>        set_iommu_table_base_and_group   <- fail, kobj->sd is not initialized
>     device_add
>        ...
>        tce_iommu_bus_notifier           <- succeed
>     pcibios_fixp_bus
>        pcibios_add_pci_devices
>        ...
>        pcibios_setup_bus_devices        <- warning, re-attach
>
>While this call flow will change a little on a VF. For a VF,
>pcibios_fixp_bus() will not be invoked. Current behavior is this.
>
>     pci_device_add
>        pcibios_setup_bus_device
>        ...
>        set_iommu_table_base_and_group   <- fail, kobj->sd is not initialized
>     device_add
>        ...
>        tce_iommu_bus_notifier           <- succeed
>

It seems that we have 2 problems here:

- For non-SRIOV case, pcibios_setup_device() is called for towice. That
  seems incorrect. We could simply remove pcibios_setup_bus_devices()
  from pcibios_fixup_bus().

- It's too early to register IOMMU group/device in pnv_pci_ioda_dma_dev_setup()
  because the sysfs entries of the PCI device aren't finalized yet. So we could
  remove all logic we have in pnv_pci_ioda_dma_dev_setup() and just purely rely
  on "tce_iommu_bus_notifier".

By the way, I never tried EEH on SRIOV PF/VFs. However, I never hit similar
issue in non-SRIOV cases.

Thanks,
Gavin

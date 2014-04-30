Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BE4E7140094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 13:28:09 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 30 Apr 2014 13:28:08 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E65DA357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 13:28:06 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3U3Rpj98388982
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 13:27:52 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3U3S58N013628
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 13:28:05 +1000
Date: Wed, 30 Apr 2014 11:28:03 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: reduce multi-hit of
 iommu_add_device()
Message-ID: <20140430032803.GB4755@richard>
References: <1398219993-6326-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <535E5924.8040503@au1.ibm.com> <20140429064955.GA5066@richard>
 <20140430002812.GA13183@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140430002812.GA13183@shangw>
Cc: linuxppc-dev@lists.ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@au1.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 30, 2014 at 10:28:12AM +1000, Gavin Shan wrote:
>
>It seems that we have 2 problems here:
>
>- For non-SRIOV case, pcibios_setup_device() is called for towice. That
>  seems incorrect. We could simply remove pcibios_setup_bus_devices()
>  from pcibios_fixup_bus().

I have thought about this solution before, but I guess this would have some
side effect on other platforms.

Well, just did a test by removing this line in pcibios_fixup_bus(), the result
is:
1. system up, thanks god.
2. no one invoke the pcibios_setup_device() at bootup time.

The reason for no one invoke the pcibios_setup_device() is: in
pcibios_add_device() it will check whether the bus is added before calling
pcibios_setup_device(). And at this time, the bus is not added.

Still wierd, why the system could be up. But one thing for sure is, no one
invoke the pcibios_setup_device() at bootup stage. So this solution may not
work.

>
>- It's too early to register IOMMU group/device in pnv_pci_ioda_dma_dev_setup()
>  because the sysfs entries of the PCI device aren't finalized yet. So we could
>  remove all logic we have in pnv_pci_ioda_dma_dev_setup() and just purely rely
>  on "tce_iommu_bus_notifier".

This would be another solution. 

One concern:

    If we want to do like this, we need to retrieve the pe information and
    get the tce32_table base in tce_iommu_bus_notifier. Hmm... looks a little
    not that nice.

>
>By the way, I never tried EEH on SRIOV PF/VFs. However, I never hit similar
>issue in non-SRIOV cases.

I have test this case on a PF with no VF enabled.

I just make the mlx4_pci_err_detected() return PCI_ERS_RESULT_NONE and do
nothing. So this will force the eeh to do a hotplug recovery.

You could have a try on your machine too.

>
>Thanks,
>Gavin

-- 
Richard Yang
Help you, Help me

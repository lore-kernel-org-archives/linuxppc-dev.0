Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B05071A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 23:07:59 +1000 (AEST)
Received: by pacti10 with SMTP id ti10so25990761pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 06:07:57 -0700 (PDT)
Subject: Re: [kernel] powerpc/iommu: Set default DMA offset in dma_dev_setup
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20150827093754.4BE371401F6@ozlabs.org>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55DF0BA8.9080805@ozlabs.ru>
Date: Thu, 27 Aug 2015 23:07:52 +1000
MIME-Version: 1.0
In-Reply-To: <20150827093754.4BE371401F6@ozlabs.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/27/2015 07:37 PM, Michael Ellerman wrote:
> On Thu, 2015-27-08 at 06:01:16 UTC, Alexey Kardashevskiy wrote:
>> "powerpc/iommu: Cleanup setting of DMA base/offset" expects that
>
> This should be:
>
> Commit e91c25111aa3 "powerpc/iommu: Cleanup setting of DMA base/offset" ...

Is not this format for reverts (which this patch is not)?

>
>> the default DMA offset is set from pnv_ioda_setup_bus_dma() which
>> is correct unless it is SRIOV where the code flow is different - at
>> the moment when pnv_ioda_setup_bus_dma() is called, there is no PE for
>> the just created VF.
>>
>> This adds missing set_dma_offset() to pnv_pci_ioda_dma_dev_setup()
>> to cover the case of SRIOV.
>>
>> Note that we still need set_dma_offset() in pnv_ioda_setup_bus_dma()
>> as at the boot time pnv_pci_ioda_dma_dev_setup() is called when no PE
>> was created yet, this happens at the PHB fixup stage.
>
> And here we should have:
>
> Fixes: e91c25111aa3 ("powerpc/iommu: Cleanup setting of DMA base/offset")
>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>
>> Makes sense to squash it to "powerpc/iommu: Cleanup setting of DMA base/offset".
>
> We don't squash things that are already in next.


imho this screams for rebase. There is no point in having broken patches in 
non merged tree, rebase is a very cheap operation.


>
> I've fixed the change log up with my comments above and your reworded
> explanation.

Thanks!

>
> cheers
>


-- 
Alexey

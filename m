Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 647892C0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 10:19:41 +1000 (EST)
Received: by pbbro8 with SMTP id ro8so10722pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2012 17:19:39 -0700 (PDT)
Message-ID: <50469A95.7050606@ozlabs.ru>
Date: Wed, 05 Sep 2012 10:19:33 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc-powernv: added tce_get callback for powernv
 platform
References: <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
 <1346744158-31190-1-git-send-email-aik@ozlabs.ru>
 <1346787702.3025.7.camel@pasglop>
In-Reply-To: <1346787702.3025.7.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/09/12 05:41, Benjamin Herrenschmidt wrote:
> On Tue, 2012-09-04 at 17:35 +1000, Alexey Kardashevskiy wrote:
>> The upcoming VFIO support requires a way to know which
>> entry in the TCE map is not empty in order to do cleanup
>> at QEMU exit/crash. This patch adds such functionality
>> to POWERNV platform code.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   arch/powerpc/platforms/powernv/pci.c |    6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index be3cfc5..61f8068 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -447,6 +447,11 @@ static void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
>>   		pnv_tce_invalidate(tbl, tces, tcep - 1);
>>   }
>>
>> +static unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
>> +{
>> +	return ((u64 *)tbl->it_base)[index - tbl->it_offset] & IOMMU_PAGE_MASK;
>> +}
>
> Why the masking here ?


Oops. No reason. Will remove.


>
> Cheers,
> Ben.
>
>>   void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>>   			       void *tce_mem, u64 tce_size,
>>   			       u64 dma_offset)
>> @@ -597,6 +602,7 @@ void __init pnv_pci_init(void)
>>   	ppc_md.pci_dma_dev_setup = pnv_pci_dma_dev_setup;
>>   	ppc_md.tce_build = pnv_tce_build;
>>   	ppc_md.tce_free = pnv_tce_free;
>> +	ppc_md.tce_get = pnv_tce_get;
>>   	ppc_md.pci_probe_mode = pnv_pci_probe_mode;
>>   	set_pci_dma_ops(&dma_iommu_ops);
>>
>
>


-- 
Alexey

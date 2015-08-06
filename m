Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7632F1A084F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 19:00:10 +1000 (AEST)
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 925391402B7
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 19:00:07 +1000 (AEST)
Received: by pacrr5 with SMTP id rr5so22868633pac.3
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Aug 2015 02:00:06 -0700 (PDT)
Subject: Re: [PATCH V2 2/6] powerpc/powernv: simplify the calculation of iov
 resource
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-3-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150806045139.GB28524@gwshan>
Cc: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C32210.9090803@ozlabs.ru>
Date: Thu, 6 Aug 2015 19:00:00 +1000
MIME-Version: 1.0
In-Reply-To: <20150806045139.GB28524@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/2015 02:51 PM, Gavin Shan wrote:
> On Wed, Aug 05, 2015 at 09:24:59AM +0800, Wei Yang wrote:
>> The alignment of IOV BAR on PowerNV platform is the total size of the IOV
>> BAR. No matter whether the IOV BAR is truncated or not, the total size
>> could be calculated by (vfs_expanded * VF size).
>>
>
> s/VF size/VF BAR size
>
> I think the changelog would be more explicit:
>
> The alignment of IOV BAR on PowerNV platform is the total size of the
> IOV BAR, no matter whether the IOV BAR is extended with number of max
> VFs or number of max PE number (256). The alignment can be calculated
> by (vfs_expaned * VF_BAR_size).



Is that really a PowerNV-specific requirement or it is valid for every 
platform (I suspect this is the case here)?


Also, what is the exact meaning of "expanded" in @vfs_expanded? It is 
either 255 (if individual VF BARs are <= 64MB) or 
roundup_pow_of_two(total_vfs) (which is something like 4 or 16). What is 
expanded here?


>
>> This patch simplifies the pnv_pci_iov_resource_alignment() by removing the
>> first case.
>>
>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>> ---
>> arch/powerpc/platforms/powernv/pci-ioda.c |   14 +++++++++-----
>> 1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 9b41dba..7192e62 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -2987,12 +2987,16 @@ static resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>> 						      int resno)
>> {
>> 	struct pci_dn *pdn = pci_get_pdn(pdev);
>> -	resource_size_t align, iov_align;
>> -
>> -	iov_align = resource_size(&pdev->resource[resno]);
>> -	if (iov_align)
>> -		return iov_align;
>> +	resource_size_t align;
>>
>> +	/*
>> +	 * On PowerNV platform, IOV BAR is mapped by M64 BAR to enable the
>> +	 * SR-IOV. While from hardware perspective, the range mapped by M64
>> +	 * BAR should be size aligned.
>> +	 *
>> +	 * This function return the total IOV BAR size if expanded or just the
>> +	 * individual size if not.
>> +	 */
>> 	align = pci_iov_resource_size(pdev, resno);
>> 	if (pdn->vfs_expanded)
>> 		return pdn->vfs_expanded * align;
>> --
>> 1.7.9.5
>>
>


-- 
Alexey

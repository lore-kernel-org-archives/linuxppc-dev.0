Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAB1D1A0257
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 14:32:37 +1000 (EST)
Received: by mail-pa0-f43.google.com with SMTP id lf10so9749821pab.30
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Jul 2014 21:32:35 -0700 (PDT)
Message-ID: <53D5D25D.90107@ozlabs.ru>
Date: Mon, 28 Jul 2014 14:32:29 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 12/18] powerpc/iommu: Fix missing permission bits in
 iommu_put_tce_user_mode()
References: <1406191691-31441-1-git-send-email-aik@ozlabs.ru>	
 <1406191691-31441-13-git-send-email-aik@ozlabs.ru>
 <1406510394.4935.35.camel@pasglop>
In-Reply-To: <1406510394.4935.35.camel@pasglop>
Content-Type: text/plain; charset=koi8-r
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/28/2014 11:19 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2014-07-24 at 18:48 +1000, Alexey Kardashevskiy wrote:
>> This adds missing permission bits to the translated TCE.
> 
> Is this a bug fix for existing stuff ? If yes, submit it separately.


There is 15/18 patch which fixes possible bug with leaking pages, and that
patch won't work until this one is applied.

Merge this one and "[PATCH v3 15/18] powerpc/iommu: Implement put_page() if
TCE had non-zero value"?




> 
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  arch/powerpc/kernel/iommu.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index 0cda2e8..5af2319 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -1088,6 +1088,7 @@ int iommu_put_tce_user_mode(struct iommu_table *tbl, unsigned long entry,
>>  		return -EFAULT;
>>  	}
>>  	hwaddr = (unsigned long) page_address(page) + offset;
>> +	hwaddr |= tce & (TCE_PCI_READ | TCE_PCI_WRITE);
>>  
>>  	ret = iommu_tce_build(tbl, entry, hwaddr, direction);
>>  	if (ret)
> 
> 


-- 
Alexey

Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA2951A001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 16:30:27 +1000 (AEST)
Received: by pabtp1 with SMTP id tp1so40507573pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 23:30:25 -0700 (PDT)
Message-ID: <5552EF78.6020301@ozlabs.ru>
Date: Wed, 13 May 2015 16:30:16 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel v10 05/34] powerpc/iommu: Always release iommu_table
 in iommu_free_table()
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-6-git-send-email-aik@ozlabs.ru>
 <20150513053337.GA479@gwshan>
In-Reply-To: <20150513053337.GA479@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/13/2015 03:33 PM, Gavin Shan wrote:
> On Tue, May 12, 2015 at 01:38:54AM +1000, Alexey Kardashevskiy wrote:
>> At the moment iommu_free_table() only releases memory if
>> the table was initialized for the platform code use, i.e. it had
>> it_map initialized (which purpose is to track DMA memory space use).
>>
>> With dynamic DMA windows, we will need to be able to release
>> iommu_table even if it was used for VFIO in which case it_map is NULL
>> so does the patch.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>> ---
>> arch/powerpc/kernel/iommu.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> index 3d47eb3..2c02d4c 100644
>> --- a/arch/powerpc/kernel/iommu.c
>> +++ b/arch/powerpc/kernel/iommu.c
>> @@ -714,8 +714,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
>> 	unsigned int order;
>>
>> 	if (!tbl || !tbl->it_map) {
>> -		printk(KERN_ERR "%s: expected TCE map for %s\n", __func__,
>> -				node_name);
>> +		kfree(tbl);
>
> I'm not sure if the "tbl" needs to be checked against NULL as kfree() already
> has the check. But it looks a bit strange to free NULL "tbl" from the code
> itself.

Yeah, looks a bit weird, agree, I'll change but in general kfree/vfree/... 
- they all check the passed pointer for NULL.



-- 
Alexey

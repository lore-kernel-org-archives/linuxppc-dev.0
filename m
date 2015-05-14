Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D566B1A03B4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 16:29:54 +1000 (AEST)
Received: by pabsx10 with SMTP id sx10so74564061pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 23:29:52 -0700 (PDT)
Message-ID: <555440D8.3060405@ozlabs.ru>
Date: Thu, 14 May 2015 16:29:44 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel v10 05/34] powerpc/iommu: Always release iommu_table
 in iommu_free_table()
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>	
 <1431358763-24371-6-git-send-email-aik@ozlabs.ru>	
 <20150513053337.GA479@gwshan> <5552EF78.6020301@ozlabs.ru>	
 <20150513145136.1a85f536@thh440s> <20150513232745.GA8158@gwshan>	
 <555409B8.3060904@ozlabs.ru> <1431571984.3625.91.camel@redhat.com>
In-Reply-To: <1431571984.3625.91.camel@redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Thomas Huth <thuth@redhat.com>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/2015 12:53 PM, Alex Williamson wrote:
> On Thu, 2015-05-14 at 12:34 +1000, Alexey Kardashevskiy wrote:
>> On 05/14/2015 09:27 AM, Gavin Shan wrote:
>>> On Wed, May 13, 2015 at 02:51:36PM +0200, Thomas Huth wrote:
>>>> On Wed, 13 May 2015 16:30:16 +1000
>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>
>>>>> On 05/13/2015 03:33 PM, Gavin Shan wrote:
>>>>>> On Tue, May 12, 2015 at 01:38:54AM +1000, Alexey Kardashevskiy wrote:
>>>>>>> At the moment iommu_free_table() only releases memory if
>>>>>>> the table was initialized for the platform code use, i.e. it had
>>>>>>> it_map initialized (which purpose is to track DMA memory space use).
>>>>>>>
>>>>>>> With dynamic DMA windows, we will need to be able to release
>>>>>>> iommu_table even if it was used for VFIO in which case it_map is NULL
>>>>>>> so does the patch.
>>>>>>>
>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>>
>>>>>> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>>>
>>>>>>> ---
>>>>>>> arch/powerpc/kernel/iommu.c | 3 +--
>>>>>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>>>>>>> index 3d47eb3..2c02d4c 100644
>>>>>>> --- a/arch/powerpc/kernel/iommu.c
>>>>>>> +++ b/arch/powerpc/kernel/iommu.c
>>>>>>> @@ -714,8 +714,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
>>>>>>> 	unsigned int order;
>>>>>>>
>>>>>>> 	if (!tbl || !tbl->it_map) {
>>>>>>> -		printk(KERN_ERR "%s: expected TCE map for %s\n", __func__,
>>>>>>> -				node_name);
>>>>>>> +		kfree(tbl);
>>>>>>
>>>>>> I'm not sure if the "tbl" needs to be checked against NULL as kfree() already
>>>>>> has the check. But it looks a bit strange to free NULL "tbl" from the code
>>>>>> itself.
>>>>>
>>>>> Yeah, looks a bit weird, agree, I'll change but in general kfree/vfree/...
>>>>> - they all check the passed pointer for NULL.
>>>>
>>>> But if tbl is NULL, the tbl->it_map check will fail, won't it? So in
>>>> this case, I think you have to keep it.
>>>>
>>>
>>> If I understood your question correctly, "tbl->it_map" won't be checked
>>> when "tbl" is NULL because the connection ("||") for the two conditions.
>>> The code can be changed to something like below if Alexey want:
>>>
>>> 	if (!tbl)
>>> 		return;
>>> 	if (!tbl->itmap)
>>> 		kfree(tbl);
>>
>> To be precise ;)
>>
>> if (!tbl->itmap) {
>> 	kfree(tbl);
>> 	return;
>> }
>
> I hope that's not your solution, it clearly segfaults with a null
> pointer de-ref if !tbl, which is apparently a concern down this path.

I meant the second "if" needs fixing. I need the first one - "if (!tbl)" - 
anyway. What did I miss?




-- 
Alexey

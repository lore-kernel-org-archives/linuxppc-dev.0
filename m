Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10AC51A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 12:11:25 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so97615151pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2015 19:11:23 -0700 (PDT)
Message-ID: <55500FC3.1040007@ozlabs.ru>
Date: Mon, 11 May 2015 12:11:15 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 26/32] powerpc/iommu: Add userspace view of
 TCE table
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-27-git-send-email-aik@ozlabs.ru>
 <20150429063113.GW32589@voom.redhat.com> <5542FA8D.2060400@ozlabs.ru>
 <20150501042319.GM24886@voom.redhat.com> <5543276D.1090708@ozlabs.ru>
 <20150505120252.GM14090@voom.redhat.com>
In-Reply-To: <20150505120252.GM14090@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/05/2015 10:02 PM, David Gibson wrote:
> On Fri, May 01, 2015 at 05:12:45PM +1000, Alexey Kardashevskiy wrote:
>> On 05/01/2015 02:23 PM, David Gibson wrote:
>>> On Fri, May 01, 2015 at 02:01:17PM +1000, Alexey Kardashevskiy wrote:
>>>> On 04/29/2015 04:31 PM, David Gibson wrote:
>>>>> On Sat, Apr 25, 2015 at 10:14:50PM +1000, Alexey Kardashevskiy wrote:
>>>>>> In order to support memory pre-registration, we need a way to track
>>>>>> the use of every registered memory region and only allow unregistration
>>>>>> if a region is not in use anymore. So we need a way to tell from what
>>>>>> region the just cleared TCE was from.
>>>>>>
>>>>>> This adds a userspace view of the TCE table into iommu_table struct.
>>>>>> It contains userspace address, one per TCE entry. The table is only
>>>>>> allocated when the ownership over an IOMMU group is taken which means
>>>>>> it is only used from outside of the powernv code (such as VFIO).
>>>>>>
>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>> ---
>>>>>> Changes:
>>>>>> v9:
>>>>>> * fixed code flow in error cases added in v8
>>>>>>
>>>>>> v8:
>>>>>> * added ENOMEM on failed vzalloc()
>>>>>> ---
>>>>>>   arch/powerpc/include/asm/iommu.h          |  6 ++++++
>>>>>>   arch/powerpc/kernel/iommu.c               | 18 ++++++++++++++++++
>>>>>>   arch/powerpc/platforms/powernv/pci-ioda.c | 22 ++++++++++++++++++++--
>>>>>>   3 files changed, 44 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
>>>>>> index 7694546..1472de3 100644
>>>>>> --- a/arch/powerpc/include/asm/iommu.h
>>>>>> +++ b/arch/powerpc/include/asm/iommu.h
>>>>>> @@ -111,9 +111,15 @@ struct iommu_table {
>>>>>>   	unsigned long *it_map;       /* A simple allocation bitmap for now */
>>>>>>   	unsigned long  it_page_shift;/* table iommu page size */
>>>>>>   	struct iommu_table_group *it_table_group;
>>>>>> +	unsigned long *it_userspace; /* userspace view of the table */
>>>>>
>>>>> A single unsigned long doesn't seem like enough.
>>>>
>>>> Why single? This is an array.
>>>
>>> As in single per page.
>>
>>
>> Sorry, I am not following you here.
>> It is per IOMMU page. MAP/UNMAP work with IOMMU pages which are fully backed
>> with either system page or a huge page.
>>
>>
>>>
>>>>> How do you know
>>>>> which process's address space this address refers to?
>>>>
>>>> It is a current task. Multiple userspaces cannot use the same container/tables.
>>>
>>> Where is that enforced?
>>
>>
>> It is accessed from VFIO DMA map/unmap which are ioctls() to a container's
>> fd which is per a process.
>
> Usually, but what enforces that.  If you open a container fd, then
> fork(), and attempt to map from both parent and child, what happens?


vfio_group_fops::open() checks if the group is already opened, and I want 
to believe open() is called from fork() for new fd so no mapping can happen 
later.


-- 
Alexey

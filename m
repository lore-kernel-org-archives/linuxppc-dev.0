Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHVRs2CCtzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 04:38:48 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v42IcHtg038760
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 May 2017 14:38:44 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a6xf6u9nr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 May 2017 14:38:43 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 3 May 2017 04:38:41 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v42IcUoo5833138
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 May 2017 04:38:38 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v42Ic0GV019693
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 May 2017 04:38:00 +1000
Subject: Re: [PATCH] powerpc/pseries hotplug: prevent the reserved mem from
 removing
To: Liu ping fan <kernelfans@gmail.com>
References: <1493278988-26169-1-git-send-email-piliu@redhat.com>
 <e07eb5d7-2c8f-1eb5-8ba5-109bb6262f12@linux.vnet.ibm.com>
 <CAFgQCTuCeCMdC-kJDXP69yoHOVG8+pPhJ5EVgyH1hdQrSWYaPA@mail.gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Pingfan Liu <piliu@redhat.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 3 May 2017 00:07:48 +0530
MIME-Version: 1.0
In-Reply-To: <CAFgQCTuCeCMdC-kJDXP69yoHOVG8+pPhJ5EVgyH1hdQrSWYaPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d8b0db80-9962-03e1-bf9b-d30d5623a0b7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Friday 28 April 2017 09:59 AM, Liu ping fan wrote:
> On Fri, Apr 28, 2017 at 2:06 AM, Hari Bathini
> <hbathini@linux.vnet.ibm.com> wrote:
>> Hi Pingfan,
>>
>>
>> On Thursday 27 April 2017 01:13 PM, Pingfan Liu wrote:
>>> E.g after fadump reserves mem regions, these regions should not be removed
>>> before fadump explicitly free them.
>>> Signed-off-by: Pingfan Liu <piliu@redhat.com>
>>> ---
>>>    arch/powerpc/platforms/pseries/hotplug-memory.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> index e104c71..201be23 100644
>>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>> @@ -346,6 +346,8 @@ static int pseries_remove_memblock(unsigned long base,
>>> unsigned int memblock_siz
>>>
>>>          if (!pfn_valid(start_pfn))
>>>                  goto out;
>>> +       if (memblock_is_reserved(base))
>>> +               return -EINVAL;
>>
>> I think memblock reserved regions are not hot removed even without this
>> patch.
>> So, can you elaborate on when/why this patch is needed?
>>
> I have not found code to prevent the reserved regions from free. Do I
> miss anything?

IIUC, during hot-remove,  while trying to offline reserved pages, it 
reports -EBUSY
thus failing to remove a lmb that has reserved memory. I was wondering 
if there would
be a case where that doesn't happen and this patch is necessary..

Thanks
Hari

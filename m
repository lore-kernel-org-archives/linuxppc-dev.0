Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sk7l9028ZzDrVg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 03:54:44 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8RHmAX7123237
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 13:54:43 -0400
Received: from e28smtp01.in.ibm.com ([125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25qsaddjrx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 13:54:42 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Tue, 27 Sep 2016 23:24:39 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DA9801258026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 23:24:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8RHsaf931195202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 23:24:36 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8RHsZqT012453
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 23:24:36 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: anton@samba.org
Subject: Re: [PATCH] Work around for enabling CONFIG_CMDLINE on ppc64le
References: <1474525245-10739-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <87d1jw8cba.fsf@concordia.ellerman.id.au>
 <57E4AC5C.5010803@linux.vnet.ibm.com>
Date: Tue, 27 Sep 2016 23:24:34 +0530
MIME-Version: 1.0
In-Reply-To: <57E4AC5C.5010803@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <57EAB25A.3040802@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Here is the link to the bug raised on launchpad.
https://bugs.launchpad.net/ubuntu/+source/gcc-5/+bug/1628207


On 09/23/2016 09:45 AM, Akshay Adiga wrote:
> Hi Michael,
>
> Anton found this bug and raised it against gcc v7.0 and a fix is 
> available
>  in upstream gcc.
>
>     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71709
>
> Currently, gcc v5.4.0  and v6.1.1 shipped with Ubuntu 16.04 and 16.10  
> respectively,
>  are hitting this problem.
>
> I have also raised bug against Ubuntu for fixing gcc for 16.04.
>
> https://bugzilla.linux.ibm.com/show_bug.cgi?id=146668
>
>
> On 09/22/2016 03:51 PM, Michael Ellerman wrote:
>> Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:
>>
>>> Observed that boot arguments (passed as CONFIG_CMDLINE)  are not being
>>> picked up by kernel while using gcc-ppc64-linux-gnu v5.4.0 and v6.1.1.
>>> While it works as expected with v5.3.1 .
>>>
>>> Found that in init/main.c in  setup_command_line() the pointers 
>>> passed to
>>> strcpy() is messed up.
>> Hi Akshay,
>>
>> Thanks for debugging this.
>>
>>> The problem goes away when compiler optimization is restricted to -O1.
>>> diff --git a/init/main.c b/init/main.c
>>> index a8a58e2..4259c42 100644
>>> --- a/init/main.c
>>> +++ b/init/main.c
>>> @@ -358,7 +358,13 @@ static inline void smp_prepare_cpus(unsigned 
>>> int maxcpus) { }
>>>    * parsing is performed in place, and we should allow a component to
>>>    * store reference of name/value for future reference.
>>>    */
>>> -static void __init setup_command_line(char *command_line)
>>> +static void __init
>>> +#ifdef CONFIG_PPC64
>>> +    #if  GCC_VERSION > 50301
>>> +        __attribute__((optimize("-O1")))
>>> +    #endif
>>> +#endif
>>> +        setup_command_line(char *command_line)
>>>   {
>>>       saved_command_line =
>>>           memblock_virt_alloc(strlen(boot_command_line) + 1, 0);
>> But I can't merge that patch.
>>
>> Our options are one or both of:
>>   - get GCC fixed and backport the fix to the compilers we care about.
>>   - blacklist the broken compiler versions.
>>
>> Is there a GCC bug filed for this?
>>
>> cheers
>>
>

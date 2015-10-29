Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1994E1A0ADA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 18:07:31 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Thu, 29 Oct 2015 12:37:27 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id ADE1B125805D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 12:37:19 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9T77LDY18808898
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 12:37:22 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9T77JAO016376
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 12:37:20 +0530
Message-ID: <5631C5A6.4040101@linux.vnet.ibm.com>
Date: Thu, 29 Oct 2015 12:37:18 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
CC: David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org,
 srikar@linux.vnet.ibm.com, acme@kernel.org, borntraeger@de.ibm.com,
 mingo@redhat.com, paulus@samba.org, scottwood@freescale.com,
 naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 1/4] perf, kvm/{x86,
 s390}: Remove dependency on uapi/kvm_perf.h
References: <1444184711-8559-1-git-send-email-hemant@linux.vnet.ibm.com>
 <5615443F.7030909@gmail.com> <561639B8.8040407@linux.vnet.ibm.com>
 <8737wuk9g6.fsf@linux.vnet.ibm.com>
In-Reply-To: <8737wuk9g6.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/29/2015 02:17 AM, Alexander Yarygin wrote:
> Hemant Kumar writes:
>
>> Hi David,
>>
>>
>> On 10/07/2015 09:41 PM, David Ahern wrote:
>>> On 10/6/15 8:25 PM, Hemant Kumar wrote:
>>>> @@ -358,7 +357,12 @@ static bool handle_end_event(struct
>>>> perf_kvm_stat *kvm,
>>>>        time_diff = sample->time - time_begin;
>>>>
>>>>        if (kvm->duration && time_diff > kvm->duration) {
>>>> -        char decode[DECODE_STR_LEN];
>>>> +        char *decode = zalloc(decode_str_len);
>>> decode can still be a stack variable even with variable length.
>>>
>> Yeah, we can do that. But, I am not sure whether its a standard way.
>>
> Well, I also vote for making them variable length arrays. I guess that
> wouldn't be a problem because the "variable" here is actually a constant
> compile time value, even if it's extern.
>
> But if people are strongly against it, as an alternative I can suggest
> to move the 'char *decode' variable to the perf_kvm_stat structure,
> allocate it once e.g. in kvm_events_report() and just write to it via
> decode_key(). If I'm not mistaken, we always write \0 trimmed strings,
> so garbage after \0 shouldn't be a problem.

I agree. We can do that. But, since this is a small change (making
the variable a constant compile time value rather than the array being
a run time value), we can do that subsequently. For now, we can go
with the current patchset.

> It's not a real problem anyway :)

Yeah.

> For s390 parts:
> Acked-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

Thanks a lot for testing and acking it. :)

>>> -----8<-----
>>>
>>>> @@ -575,7 +581,7 @@ static void show_timeofday(void)
>>>>
>>>>    static void print_result(struct perf_kvm_stat *kvm)
>>>>    {
>>>> -    char decode[DECODE_STR_LEN];
>>>> +    char *decode;
>>> and a stack variable here too.
>>>
>> Same here.
>>
>>> David
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Thanks,
Hemant Kumar

Return-Path: <yarygin@linux.vnet.ibm.com>
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3446C1A0456
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 07:47:32 +1100 (AEDT)
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <yarygin@linux.vnet.ibm.com>;
 Wed, 28 Oct 2015 20:47:27 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 527B61B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 20:47:35 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9SKlOW711731430
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 20:47:24 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9SKlNbm029635
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 14:47:24 -0600
References: <1444184711-8559-1-git-send-email-hemant@linux.vnet.ibm.com>
 <5615443F.7030909@gmail.com> <561639B8.8040407@linux.vnet.ibm.com>
From: Alexander Yarygin <yarygin@linux.vnet.ibm.com>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org,
 srikar@linux.vnet.ibm.com, yarygin@linux.vnet.ibm.com, acme@kernel.org,
 borntraeger@de.ibm.com, mingo@redhat.com, paulus@samba.org,
 scottwood@freescale.com, naveen.n.rao@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 1/4] perf, kvm/{x86,
 s390}: Remove dependency on uapi/kvm_perf.h
Message-ID: <8737wuk9g6.fsf@linux.vnet.ibm.com>
In-reply-to: <561639B8.8040407@linux.vnet.ibm.com>
Date: Wed, 28 Oct 2015 23:47:19 +0300
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hemant Kumar writes:

> Hi David,
>
>
> On 10/07/2015 09:41 PM, David Ahern wrote:
>> On 10/6/15 8:25 PM, Hemant Kumar wrote:
>>> @@ -358,7 +357,12 @@ static bool handle_end_event(struct
>>> perf_kvm_stat *kvm,
>>>       time_diff = sample->time - time_begin;
>>>
>>>       if (kvm->duration && time_diff > kvm->duration) {
>>> -        char decode[DECODE_STR_LEN];
>>> +        char *decode = zalloc(decode_str_len);
>>
>> decode can still be a stack variable even with variable length.
>>
>
> Yeah, we can do that. But, I am not sure whether its a standard way.
>

Well, I also vote for making them variable length arrays. I guess that
wouldn't be a problem because the "variable" here is actually a constant
compile time value, even if it's extern.

But if people are strongly against it, as an alternative I can suggest
to move the 'char *decode' variable to the perf_kvm_stat structure,
allocate it once e.g. in kvm_events_report() and just write to it via
decode_key(). If I'm not mistaken, we always write \0 trimmed strings,
so garbage after \0 shouldn't be a problem.

It's not a real problem anyway :)

For s390 parts:
Acked-by: Alexander Yarygin <yarygin@linux.vnet.ibm.com>

>> -----8<-----
>>
>>> @@ -575,7 +581,7 @@ static void show_timeofday(void)
>>>
>>>   static void print_result(struct perf_kvm_stat *kvm)
>>>   {
>>> -    char decode[DECODE_STR_LEN];
>>> +    char *decode;
>>
>> and a stack variable here too.
>>
>
> Same here.
>
>> David
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev

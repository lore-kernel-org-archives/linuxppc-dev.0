Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBBF41A0174
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 20:39:48 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 15:09:45 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4ACF2394004E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 15:09:42 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t989dHkR24379544
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2015 15:09:17 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t989dBAZ000301
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Oct 2015 15:09:16 +0530
Message-ID: <561639B8.8040407@linux.vnet.ibm.com>
Date: Thu, 08 Oct 2015 15:09:04 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org
CC: srikar@linux.vnet.ibm.com, yarygin@linux.vnet.ibm.com, acme@kernel.org,
 borntraeger@de.ibm.com, mingo@redhat.com, paulus@samba.org,
 scottwood@freescale.com, naveen.n.rao@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 1/4] perf, kvm/{x86,
 s390}: Remove dependency on uapi/kvm_perf.h
References: <1444184711-8559-1-git-send-email-hemant@linux.vnet.ibm.com>
 <5615443F.7030909@gmail.com>
In-Reply-To: <5615443F.7030909@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,


On 10/07/2015 09:41 PM, David Ahern wrote:
> On 10/6/15 8:25 PM, Hemant Kumar wrote:
>> @@ -358,7 +357,12 @@ static bool handle_end_event(struct 
>> perf_kvm_stat *kvm,
>>       time_diff = sample->time - time_begin;
>>
>>       if (kvm->duration && time_diff > kvm->duration) {
>> -        char decode[DECODE_STR_LEN];
>> +        char *decode = zalloc(decode_str_len);
>
> decode can still be a stack variable even with variable length.
>

Yeah, we can do that. But, I am not sure whether its a standard way.

>> +
>> +        if (!decode) {
>> +            pr_err("Not enough memory\n");
>> +            return false;
>> +        }
>>
>>           kvm->events_ops->decode_key(kvm, &event->key, decode);
>>           if (!skip_event(decode)) {
>> @@ -366,6 +370,7 @@ static bool handle_end_event(struct perf_kvm_stat 
>> *kvm,
>>                    sample->time, sample->pid, vcpu_record->vcpu_id,
>>                    decode, time_diff/1000);
>>           }
>> +        free(decode);
>>       }
>>
>>       return update_kvm_event(event, vcpu, time_diff);
>> @@ -386,7 +391,8 @@ struct vcpu_event_record *per_vcpu_record(struct 
>> thread *thread,
>
> -----8<-----
>
>> @@ -575,7 +581,7 @@ static void show_timeofday(void)
>>
>>   static void print_result(struct perf_kvm_stat *kvm)
>>   {
>> -    char decode[DECODE_STR_LEN];
>> +    char *decode;
>
> and a stack variable here too.
>

Same here.

> David
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Thanks,
Hemant Kumar

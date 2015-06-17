Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D60F1A09C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 11:26:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Wed, 17 Jun 2015 11:25:59 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 14A852BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 11:25:57 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5H1Plh139911552
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 11:25:56 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5H1PNoY029342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 11:25:24 +1000
Message-ID: <5580CC69.2090200@linux.vnet.ibm.com>
Date: Wed, 17 Jun 2015 06:54:57 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Ahern <dsahern@gmail.com>, linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, acme@kernel.org,
 mingo@kernel.org, sukadev@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org, namhyung@kernel.org,
 jolsa@kernel.org, peterz@infradead.org
Subject: Re: [RFC PATCH] perf/kvm: Guest Symbol Resolution for powerpc
References: <1434423053-2173-1-git-send-email-hemant@linux.vnet.ibm.com>
 <55803883.50504@gmail.com>
In-Reply-To: <55803883.50504@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

Thanks for the review.

On 06/16/2015 08:23 PM, David Ahern wrote:
> On 6/15/15 8:50 PM, Hemant Kumar wrote:
>> +/*
>> + * Get the instruction pointer from the tracepoint data
>> + */
>> +u64 arch__get_ip(struct perf_evsel *evsel, struct perf_sample *data)
>> +{
>> +    u64 tp_ip = data->ip;
>> +    int trap;
>> +
>> +    if (!strcmp(KVMPPC_EXIT, evsel->name)) {
>> +        trap = raw_field_value(evsel->tp_format, "trap", 
>> data->raw_data);
>> +
>> +        if (trap == HV_DECREMENTER)
>> +            tp_ip = raw_field_value(evsel->tp_format, "pc",
>> +                        data->raw_data);
>> +    }
>> +    return tp_ip;
>> +}
>
> You can tie a handler to an event; see builtin-trace.c for example 
> (evsel->handler = handler). Then have the sample handler call it (e.g, 
> see trace__process_sample). Then you don't have to check event names 
> on each pass like this and just do event based processing.
>
>> +
>> +/*
>> + * Get the HV and PR bits and accordingly, determine the cpumode
>> + */
>> +u8 arch__get_cpumode(union perf_event *event, struct perf_evsel *evsel,
>> +             struct perf_sample *data)
>> +{
>> +    unsigned long hv, pr, msr;
>> +    u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
>> +
>> +    if (strcmp(KVMPPC_EXIT, evsel->name))
>> +        goto ret;
>> +
>> +    if (data->raw_data)
>> +        msr = raw_field_value(evsel->tp_format, "msr", data->raw_data);
>> +    else
>> +        goto ret;
>> +
>> +    hv = msr & ((long unsigned)1 << (PPC_MAX - HV_BIT));
>> +    pr = msr & ((long unsigned)1 << (PPC_MAX - PR_BIT));
>> +
>> +    if (!hv && pr)
>> +        cpumode = PERF_RECORD_MISC_GUEST_USER;
>> +    else
>> +        cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
>> +ret:
>> +    return cpumode;
>> +}
>
> Why isn't that set properly kernel side when the sample is generated?
>
>

Because, this depends on the kernel tracepoint "kvm_hv:kvm_guest_exit".
perf_prepare_sample() in the kernel side sets the event->header.misc 
field to
PERF_RECORD_MISC_KERNEL through perf_misc_flags(pt_regs). In case of
tracepoints which always get hit in the host kernel context, the
perf_misc_flags() will always return PERF_RECORD_MISC_KERNEL.

IMHO we will rather have to set the cpumode in the user space for this 
tracepoint
and we can't depend on the event->header.misc field for this case.

What would you suggest?

-- 
Thanks,
Hemant Kumar

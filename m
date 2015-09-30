Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F2371A0038
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 04:14:11 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 23:44:08 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 270D6125801F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 23:43:43 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8UIE6L84129036
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 23:44:06 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8UIE56j003114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 23:44:06 +0530
Message-ID: <560C266C.9070403@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 23:44:04 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Ahern <dsahern@gmail.com>, Scott Wood <scottwood@freescale.com>
CC: Alexander Yarygin <yarygin@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org, sukadev@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, mpe@ellerman.id.au, paulus@samba.org,
 mingo@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v8 1/4] perf, kvm/{x86,
 s390}: Remove dependency on uapi/kvm_perf.h
References: <1443161838-31462-1-git-send-email-hemant@linux.vnet.ibm.com>
 <87bncm7l6z.fsf@linux.vnet.ibm.com> <56094F5D.9090805@gmail.com>
 <1443453406.32298.171.camel@freescale.com> <56095AEA.8050002@gmail.com>
In-Reply-To: <56095AEA.8050002@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/28/2015 08:51 PM, David Ahern wrote:
> On 9/28/15 9:16 AM, Scott Wood wrote:
>> On Mon, 2015-09-28 at 08:31 -0600, David Ahern wrote:
>>> On 9/28/15 7:00 AM, Alexander Yarygin wrote:
>>>>> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
>>>>> index fc1cffb..ef25fcf 100644
>>>>> --- a/tools/perf/builtin-kvm.c
>>>>> +++ b/tools/perf/builtin-kvm.c
>>>>> @@ -31,20 +31,18 @@
>>>>>    #include <math.h> 

[SNIP]

>>>>> @@ -60,7 +58,7 @@ bool exit_event_begin(struct perf_evsel *evsel,
>>>>>
>>>>>    bool kvm_entry_event(struct perf_evsel *evsel)
>>>>>    {
>>>>> - return !strcmp(evsel->name, KVM_ENTRY_TRACE);
>>>>> + return !strncmp(evsel->name, kvm_events_tp[0], 
>>>>> strlen(evsel->name));
>>>>>    }
>>>>>
>>>>>    bool exit_event_end(struct perf_evsel *evsel,
>>>
>>> I agree; don't rely on kvm_events_tp. Define KVM_ENTRY_TRACE and
>>> KVM_EXIT_TRACE like x86.
>>
>> If you mean defining them in uapi, that doesn't work for arches that 
>> have
>> multiple subarches that may have different trace events.  This patchset
>> doesn't actually implement dynamic support for the subarches, but it 
>> avoids
>> adding constants to uapi headers that only apply to one of the 
>> subarches.
>
> I don't agree on relying on kvm_events_tp[0] and [1]. If you need that 
> to be a runtime definition then change KVM_ENTRY_TRACE to const char 
> *kvm_entry_trace and s390 and other arches can have code to set 
> kvm_{entry,exit}_trace at runtime.
>

Yeah, will change them to kvm_{entry,exit}_trace, instead.

-- 
Thanks,
Hemant Kumar

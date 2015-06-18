Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ADB81A0E3B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 10:04:55 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Thu, 18 Jun 2015 10:04:53 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 13C223578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 10:04:50 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5I04d9S29688048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 10:04:48 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5I04GTs010936
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 10:04:17 +1000
Message-ID: <55820AEC.6020204@linux.vnet.ibm.com>
Date: Thu, 18 Jun 2015 05:33:56 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 paulus@samba.org, jolsa@kernel.org, dsahern@gmail.com,
 namhyung@kernel.org, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Subject: Re: [RFC PATCH] perf/kvm: Guest Symbol Resolution for powerpc
References: <1434423053-2173-1-git-send-email-hemant@linux.vnet.ibm.com>
 <20150616153808.GG10374@kernel.org>
In-Reply-To: <20150616153808.GG10374@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnaldo,

On 06/16/2015 09:08 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 16, 2015 at 08:20:53AM +0530, Hemant Kumar escreveu:
>> "perf kvm {record|report}" is used to record and report the performance
>> profile of any workload on a guest. From the host, we can collect
>> guest kernel statistics which is useful in finding out any contentions
>> in guest kernel symbols for a certain workload.
>>
>> This feature is not available on powerpc because "perf" relies on the
>> "cycles" event (a PMU event) to profile the guest. However, for powerpc,
>> this can't be used from the host because the PMUs are controlled by the
>> guest rather than the host.
>>
>> Due to this problem, we need a different approach to profile the
>> workload in the guest. There exists a tracepoint "kvm_hv:kvm_guest_exit"
>> in powerpc which is hit whenever any of the threads exit the guest
>> context. The guest instruction pointer dumped along with this
>> tracepoint data in the field "pc", can be used as guest instruction
>> pointer while postprocessing the trace data to map this IP to symbol
>> from guest.kallsyms.
>>
>> However, to have some kind of periodicity, we can't use all the kvm
>> exits, rather exits which are bound to happen in certain intervals.
>> HV_DECREMENTER Interrupt forces the threads to exit after an interval
>> of 10 ms.
>>
>> This patch makes use of the "kvm_guest_exit" tracepoint and checks the
>> exit reason for any kvm exit. If it is HV_DECREMENTER, then the
>> instruction pointer dumped along with this tracepoint is retrieved and
>> mapped with the guest kallsyms.
>>
>> This patch is a prototype asking for suggestions/comments as to whether
>> the approach is right or is there any way better than this (like using
>> a different event to profile for, etc) to profile the guest from the
>> host.
>>
>> Thank You.
>>
>> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
>> ---
>>   tools/perf/arch/powerpc/Makefile        |  1 +
>>   tools/perf/arch/powerpc/util/parse-tp.c | 55 +++++++++++++++++++++++++++++++++
>>   tools/perf/builtin-report.c             |  9 ++++++
>>   tools/perf/util/event.c                 |  7 ++++-
>>   tools/perf/util/evsel.c                 |  7 +++++
>>   tools/perf/util/evsel.h                 |  4 +++
>>   tools/perf/util/session.c               |  7 +++--
>>   7 files changed, 86 insertions(+), 4 deletions(-)
>>   create mode 100644 tools/perf/arch/powerpc/util/parse-tp.c
>>
>> diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
>> index 6f7782b..992a0d5 100644
>> --- a/tools/perf/arch/powerpc/Makefile
>> +++ b/tools/perf/arch/powerpc/Makefile
>> @@ -4,3 +4,4 @@ LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/dwarf-regs.o
>>   LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/skip-callchain-idx.o
>>   endif
>>   LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/header.o
>> +LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/parse-tp.o
>> diff --git a/tools/perf/arch/powerpc/util/parse-tp.c b/tools/perf/arch/powerpc/util/parse-tp.c
>> new file mode 100644
>> index 0000000..4c6e49c
>> --- /dev/null
>> +++ b/tools/perf/arch/powerpc/util/parse-tp.c
>> @@ -0,0 +1,55 @@
>> +#include "../../util/evsel.h"
>> +#include "../../util/trace-event.h"
>> +#include "../../util/session.h"
>> +
>> +#define KVMPPC_EXIT "kvm_hv:kvm_guest_exit"
>> +#define HV_DECREMENTER 2432
>> +#define HV_BIT 3
>> +#define PR_BIT 49
>> +#define PPC_MAX 63
>> +
>> +/*
>> + * Get the instruction pointer from the tracepoint data
>> + */
>> +u64 arch__get_ip(struct perf_evsel *evsel, struct perf_sample *data)
>> +{
>> +	u64 tp_ip = data->ip;
>> +	int trap;
>> +
>> +	if (!strcmp(KVMPPC_EXIT, evsel->name)) {
> Can't you cache this somewhere? I.e. something like
>   
> 	static int kvmppc_exit = -1;
>
> 	if (evsel->attr.type != PERF_TRACEPOINT)
> 		goto out;
>
> 	if (unlikely(kvmppc_exit == -1)) {
> 		if (strcmp(KVMPPC_EXIT, evsel->name)))
> 			goto out;
>
> 		kvmppc_exit = evsel->attr.config;
> 	} else (if kvmppc_exit != evsel->attr.config)
> 		goto out;

Will try this.

>
>> +	trap = raw_field_value(evsel->tp_format, "trap", data->raw_data);
>> +
>> +	if (trap == HV_DECREMENTER)
>> +		tp_ip = raw_field_value(evsel->tp_format, "pc",
>> +					data->raw_data);
> out:
>
>> +	return tp_ip;
>> +}
>
> Also we have:
>
> 	u64 perf_evsel__intval(struct perf_evsel *evsel,
> 			       struct perf_sample *sample, const char *name);
>
> So:
>
> 	trap = perf_evsel__intval(evsel, sample, "trap");
>
> And:
>
> 	tp_ip = perf_evsel__intval(evsel, sample, "pc");
>
> Makes it a bit shorter and allows for optimizations in how to find that
> field by name made at the evsel code.

Thanks, missed perf_evsel__intval, will use this in the next iteration.

> - Arnaldo
>
>> +
>> +/*
>> + * Get the HV and PR bits and accordingly, determine the cpumode
>> + */
>> +u8 arch__get_cpumode(union perf_event *event, struct perf_evsel *evsel,
>> +		     struct perf_sample *data)
>> +{
>> +	unsigned long hv, pr, msr;
>> +	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
>> +
>> +	if (strcmp(KVMPPC_EXIT, evsel->name))
>> +		goto ret;
>> +
>> +	if (data->raw_data)
>> +		msr = raw_field_value(evsel->tp_format, "msr", data->raw_data);
>> +	else
>> +		goto ret;
>> +
>> +	hv = msr & ((long unsigned)1 << (PPC_MAX - HV_BIT));
>> +	pr = msr & ((long unsigned)1 << (PPC_MAX - PR_BIT));
>> +
>> +	if (!hv && pr)
>> +		cpumode = PERF_RECORD_MISC_GUEST_USER;
>> +	else
>> +		cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
>> +ret:
>> +	return cpumode;
>> +}
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index 072ae8a..e3fe5d0 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -141,6 +141,13 @@ out:
>>   	return err;
>>   }
>>   
>> +u8 __weak arch__get_cpumode(union perf_event *event,
>> +			    __maybe_unused struct perf_evsel *evsel,
>> +			    __maybe_unused struct perf_sample *sample)
>> +{
>> +	return event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
>> +}
>> +
>>   static int process_sample_event(struct perf_tool *tool,
>>   				union perf_event *event,
>>   				struct perf_sample *sample,
>> @@ -155,6 +162,8 @@ static int process_sample_event(struct perf_tool *tool,
>>   	};
>>   	int ret;
>>   
>> +	al.cpumode = arch__get_cpumode(event, evsel, sample);
>> +
> Why do it here? Other tools will need this as well, no? I.e. this should

I may be wrong, but since, we are profiling a guest, I assume that other 
tools won't
be needing this except "perf kvm report", right?

> be done at perf_event__preprocess_sample(), that receives &al as a
> return location.
>
> Humm, but evsel is not passed to perf_event__preprocess_sample, argh,
> but yeah, at all perf_event__preprocess_sample() callsites the evsel is
> already resolved, so we just need to add it to
> perf_event__preprocess_sample() sig, now that we have a need for it.

Yeah, we can add evsel to the perf_event__preprocess_sample() params.

> I.e. this is like a userland fix for older kernels, right? Because
> other tools will have to do this patching too?

Yes, it should be a userland fix for older kernels (not older than 3.19, 
though
because the tracepoint we are looking for is available from that version).

>>   	if (perf_event__preprocess_sample(event, machine, &al, sample) < 0) {
>>   		pr_debug("problem processing %d event, skipping it.\n",
>>   			 event->header.type);
>> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
>> index 6c6d044..693e37c 100644
>> --- a/tools/perf/util/event.c
>> +++ b/tools/perf/util/event.c
>> @@ -824,9 +824,14 @@ int perf_event__preprocess_sample(const union perf_event *event,
>>   				  struct addr_location *al,
>>   				  struct perf_sample *sample)
>>   {
>> -	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
>>   	struct thread *thread = machine__findnew_thread(machine, sample->pid,
>>   							sample->tid);
>> +	u8 cpumode;
>> +
>> +	if (al->cpumode != PERF_RECORD_MISC_CPUMODE_UNKNOWN)
>> +		cpumode = al->cpumode;
>> +	else
>> +		cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
> I.e. here, where we should try to avoid looking at anything in 'al'.

Yes.

>
[SNIP]


Thanks a lot for the review Arnaldo.
Will try the suggestions in the next iteration.

-- 
Thanks,
Hemant Kumar

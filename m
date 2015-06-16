Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 27F761A0431
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 01:38:15 +1000 (AEST)
Date: Tue, 16 Jun 2015 12:38:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Hemant Kumar <hemant@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, mingo@kernel.org,
 sukadev@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org, namhyung@kernel.org,
 jolsa@kernel.org, peterz@infradead.org, dsahern@gmail.com
Subject: Re: [RFC PATCH] perf/kvm: Guest Symbol Resolution for powerpc
Message-ID: <20150616153808.GG10374@kernel.org>
References: <1434423053-2173-1-git-send-email-hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434423053-2173-1-git-send-email-hemant@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Tue, Jun 16, 2015 at 08:20:53AM +0530, Hemant Kumar escreveu:
> "perf kvm {record|report}" is used to record and report the performance
> profile of any workload on a guest. From the host, we can collect
> guest kernel statistics which is useful in finding out any contentions
> in guest kernel symbols for a certain workload.
> 
> This feature is not available on powerpc because "perf" relies on the
> "cycles" event (a PMU event) to profile the guest. However, for powerpc,
> this can't be used from the host because the PMUs are controlled by the
> guest rather than the host.
> 
> Due to this problem, we need a different approach to profile the
> workload in the guest. There exists a tracepoint "kvm_hv:kvm_guest_exit"
> in powerpc which is hit whenever any of the threads exit the guest
> context. The guest instruction pointer dumped along with this
> tracepoint data in the field "pc", can be used as guest instruction
> pointer while postprocessing the trace data to map this IP to symbol
> from guest.kallsyms.
> 
> However, to have some kind of periodicity, we can't use all the kvm
> exits, rather exits which are bound to happen in certain intervals.
> HV_DECREMENTER Interrupt forces the threads to exit after an interval
> of 10 ms.
> 
> This patch makes use of the "kvm_guest_exit" tracepoint and checks the
> exit reason for any kvm exit. If it is HV_DECREMENTER, then the
> instruction pointer dumped along with this tracepoint is retrieved and
> mapped with the guest kallsyms.
> 
> This patch is a prototype asking for suggestions/comments as to whether
> the approach is right or is there any way better than this (like using
> a different event to profile for, etc) to profile the guest from the
> host.
> 
> Thank You.
> 
> Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/powerpc/Makefile        |  1 +
>  tools/perf/arch/powerpc/util/parse-tp.c | 55 +++++++++++++++++++++++++++++++++
>  tools/perf/builtin-report.c             |  9 ++++++
>  tools/perf/util/event.c                 |  7 ++++-
>  tools/perf/util/evsel.c                 |  7 +++++
>  tools/perf/util/evsel.h                 |  4 +++
>  tools/perf/util/session.c               |  7 +++--
>  7 files changed, 86 insertions(+), 4 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/util/parse-tp.c
> 
> diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
> index 6f7782b..992a0d5 100644
> --- a/tools/perf/arch/powerpc/Makefile
> +++ b/tools/perf/arch/powerpc/Makefile
> @@ -4,3 +4,4 @@ LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/dwarf-regs.o
>  LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/skip-callchain-idx.o
>  endif
>  LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/header.o
> +LIB_OBJS += $(OUTPUT)arch/$(ARCH)/util/parse-tp.o
> diff --git a/tools/perf/arch/powerpc/util/parse-tp.c b/tools/perf/arch/powerpc/util/parse-tp.c
> new file mode 100644
> index 0000000..4c6e49c
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/parse-tp.c
> @@ -0,0 +1,55 @@
> +#include "../../util/evsel.h"
> +#include "../../util/trace-event.h"
> +#include "../../util/session.h"
> +
> +#define KVMPPC_EXIT "kvm_hv:kvm_guest_exit"
> +#define HV_DECREMENTER 2432
> +#define HV_BIT 3
> +#define PR_BIT 49
> +#define PPC_MAX 63
> +
> +/*
> + * Get the instruction pointer from the tracepoint data
> + */
> +u64 arch__get_ip(struct perf_evsel *evsel, struct perf_sample *data)
> +{
> +	u64 tp_ip = data->ip;
> +	int trap;
> +
> +	if (!strcmp(KVMPPC_EXIT, evsel->name)) {

Can't you cache this somewhere? I.e. something like

	static int kvmppc_exit = -1;

	if (evsel->attr.type != PERF_TRACEPOINT)
		goto out;

	if (unlikely(kvmppc_exit == -1)) {
		if (strcmp(KVMPPC_EXIT, evsel->name)))
			goto out;

		kvmppc_exit = evsel->attr.config;
	} else (if kvmppc_exit != evsel->attr.config)
		goto out;


> +	trap = raw_field_value(evsel->tp_format, "trap", data->raw_data);
> +
> +	if (trap == HV_DECREMENTER)
> +		tp_ip = raw_field_value(evsel->tp_format, "pc",
> +					data->raw_data);

out:

> +	return tp_ip;
> +}


Also we have:

	u64 perf_evsel__intval(struct perf_evsel *evsel,
			       struct perf_sample *sample, const char *name);

So:

	trap = perf_evsel__intval(evsel, sample, "trap");

And:

	tp_ip = perf_evsel__intval(evsel, sample, "pc");

Makes it a bit shorter and allows for optimizations in how to find that
field by name made at the evsel code.

- Arnaldo

> +
> +/*
> + * Get the HV and PR bits and accordingly, determine the cpumode
> + */
> +u8 arch__get_cpumode(union perf_event *event, struct perf_evsel *evsel,
> +		     struct perf_sample *data)
> +{
> +	unsigned long hv, pr, msr;
> +	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
> +
> +	if (strcmp(KVMPPC_EXIT, evsel->name))
> +		goto ret;
> +
> +	if (data->raw_data)
> +		msr = raw_field_value(evsel->tp_format, "msr", data->raw_data);
> +	else
> +		goto ret;
> +
> +	hv = msr & ((long unsigned)1 << (PPC_MAX - HV_BIT));
> +	pr = msr & ((long unsigned)1 << (PPC_MAX - PR_BIT));
> +
> +	if (!hv && pr)
> +		cpumode = PERF_RECORD_MISC_GUEST_USER;
> +	else
> +		cpumode = PERF_RECORD_MISC_GUEST_KERNEL;
> +ret:
> +	return cpumode;
> +}
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 072ae8a..e3fe5d0 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -141,6 +141,13 @@ out:
>  	return err;
>  }
>  
> +u8 __weak arch__get_cpumode(union perf_event *event,
> +			    __maybe_unused struct perf_evsel *evsel,
> +			    __maybe_unused struct perf_sample *sample)
> +{
> +	return event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
> +}
> +
>  static int process_sample_event(struct perf_tool *tool,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> @@ -155,6 +162,8 @@ static int process_sample_event(struct perf_tool *tool,
>  	};
>  	int ret;
>  
> +	al.cpumode = arch__get_cpumode(event, evsel, sample);
> +

Why do it here? Other tools will need this as well, no? I.e. this should
be done at perf_event__preprocess_sample(), that receives &al as a
return location.

Humm, but evsel is not passed to perf_event__preprocess_sample, argh,
but yeah, at all perf_event__preprocess_sample() callsites the evsel is
already resolved, so we just need to add it to
perf_event__preprocess_sample() sig, now that we have a need for it.

I.e. this is like a userland fix for older kernels, right? Because
other tools will have to do this patching too?

>  	if (perf_event__preprocess_sample(event, machine, &al, sample) < 0) {
>  		pr_debug("problem processing %d event, skipping it.\n",
>  			 event->header.type);
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 6c6d044..693e37c 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -824,9 +824,14 @@ int perf_event__preprocess_sample(const union perf_event *event,
>  				  struct addr_location *al,
>  				  struct perf_sample *sample)
>  {
> -	u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
>  	struct thread *thread = machine__findnew_thread(machine, sample->pid,
>  							sample->tid);
> +	u8 cpumode;
> +
> +	if (al->cpumode != PERF_RECORD_MISC_CPUMODE_UNKNOWN)
> +		cpumode = al->cpumode;
> +	else
> +		cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;

I.e. here, where we should try to avoid looking at anything in 'al'.

>  
>  	if (thread == NULL)
>  		return -1;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 1e90c85..aa4dd49 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1281,6 +1281,12 @@ static inline bool overflow(const void *endp, u16 max_size, const void *offset,
>  #define OVERFLOW_CHECK_u64(offset) \
>  	OVERFLOW_CHECK(offset, sizeof(u64), sizeof(u64))
>  
> +u64 __weak arch__get_ip(__maybe_unused struct perf_evsel *evsel,
> +			__maybe_unused struct perf_sample *data)
> +{
> +	return data->ip;
> +}
> +
>  int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
>  			     struct perf_sample *data)
>  {
> @@ -1454,6 +1460,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
>  		OVERFLOW_CHECK(array, data->raw_size, max_size);
>  		data->raw_data = (void *)array;
>  		array = (void *)array + data->raw_size;
> +		data->ip = arch__get_ip(evsel, data);
>  	}
>  
>  	if (type & PERF_SAMPLE_BRANCH_STACK) {
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 3862274..5c94d64 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -355,4 +355,8 @@ for ((_evsel) = list_entry((_leader)->node.next, struct perf_evsel, node); 	\
>       (_evsel) && (_evsel)->leader == (_leader);					\
>       (_evsel) = list_entry((_evsel)->node.next, struct perf_evsel, node))
>  
> +u64 arch__get_ip(struct perf_evsel *evsel, struct perf_sample *data);
> +u8 arch__get_cpumode(union perf_event *event, struct perf_evsel *evsel,
> +		     struct perf_sample *sample);
> +
>  #endif /* __PERF_EVSEL_H */
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 5f0e05a..49698cc 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -748,9 +748,10 @@ static void dump_sample(struct perf_evsel *evsel, union perf_event *event,
>  static struct machine *
>  	perf_session__find_machine_for_cpumode(struct perf_session *session,
>  					       union perf_event *event,
> -					       struct perf_sample *sample)
> +					       struct perf_sample *sample,
> +					       struct perf_evsel *evsel)
>  {
> -	const u8 cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
> +	u8 cpumode = arch__get_cpumode(event, evsel, sample);
>  	struct machine *machine;
>  
>  	if (perf_guest &&
> @@ -856,7 +857,7 @@ int perf_session__deliver_event(struct perf_session *session,
>  	evsel = perf_evlist__id2evsel(session->evlist, sample->id);
>  
>  	machine = perf_session__find_machine_for_cpumode(session, event,
> -							 sample);
> +							 sample, evsel);
>  
>  	switch (event->header.type) {
>  	case PERF_RECORD_SAMPLE:
> -- 
> 1.9.3

Return-Path: <dsahern@gmail.com>
Received: from mail-ig0-x236.google.com (mail-ig0-x236.google.com
 [IPv6:2607:f8b0:4001:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFB711A01DA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 00:53:59 +1000 (AEST)
Received: by igbsb11 with SMTP id sb11so15841439igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 07:53:57 -0700 (PDT)
Message-ID: <55803883.50504@gmail.com>
Date: Tue, 16 Jun 2015 08:53:55 -0600
From: David Ahern <dsahern@gmail.com>
MIME-Version: 1.0
To: Hemant Kumar <hemant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 acme@kernel.org, mingo@kernel.org, sukadev@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, paulus@samba.org,
 namhyung@kernel.org, jolsa@kernel.org, peterz@infradead.org
Subject: Re: [RFC PATCH] perf/kvm: Guest Symbol Resolution for powerpc
References: <1434423053-2173-1-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1434423053-2173-1-git-send-email-hemant@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/15/15 8:50 PM, Hemant Kumar wrote:
> +/*
> + * Get the instruction pointer from the tracepoint data
> + */
> +u64 arch__get_ip(struct perf_evsel *evsel, struct perf_sample *data)
> +{
> +	u64 tp_ip = data->ip;
> +	int trap;
> +
> +	if (!strcmp(KVMPPC_EXIT, evsel->name)) {
> +		trap = raw_field_value(evsel->tp_format, "trap", data->raw_data);
> +
> +		if (trap == HV_DECREMENTER)
> +			tp_ip = raw_field_value(evsel->tp_format, "pc",
> +						data->raw_data);
> +	}
> +	return tp_ip;
> +}

You can tie a handler to an event; see builtin-trace.c for example 
(evsel->handler = handler). Then have the sample handler call it (e.g, 
see trace__process_sample). Then you don't have to check event names on 
each pass like this and just do event based processing.

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

Why isn't that set properly kernel side when the sample is generated?

David

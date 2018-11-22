Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8265DC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 12:25:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B6320684
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 12:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B6320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430zDh2xqtzDqP8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 23:25:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=andrew.murray@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 430z8H1w0rzDqNf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 23:21:47 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A6D93804;
 Thu, 22 Nov 2018 04:21:45 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4B8D3F5A0;
 Thu, 22 Nov 2018 04:21:44 -0800 (PST)
Date: Thu, 22 Nov 2018 12:21:43 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 00/10] perf/core: Generalise event exclusion checking
Message-ID: <20181122122142.GI42987@e119886-lin.cambridge.arm.com>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <20181119130800.GE9761@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119130800.GE9761@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, linux-alpha@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 19, 2018 at 02:08:00PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 16, 2018 at 10:24:03AM +0000, Andrew Murray wrote:
> > Many PMU drivers do not have the capability to exclude counting events
> > that occur in specific contexts such as idle, kernel, guest, etc. These
> > drivers indicate this by returning an error in their event_init upon
> > testing the events attribute flags.
> > 
> > However this approach requires that each time a new event modifier is
> > added to perf, all the perf drivers need to be modified to indicate that
> > they don't support the attribute. This results in additional boiler-plate
> > code common to many drivers that needs to be maintained. An example of
> > this is the addition of exclude_host and exclude_guest in 2011 yet many
> > PMU drivers do not support this or indicate an error on events that make
> > use of it.
> > 
> > This patch generalises the test for exclusion and updates PMU drivers to
> > use it. This is a functional change as some PMU drivers will now correctly
> > report that they don't support certain events whereas they previously did.
> 
> Right, I like that idea, and yes, there's a lot of fail around there :/
> 
> > A longer term approach may instead be for PMU's to advertise their
> > capabilities on registration.
> 
> This I think is the better approach. We already have the
> PERF_PMU_CAP_flags that can be used to advertise various PMU
> capabilities.

OK I'll respin my series to take this approach.

> 
> Something along these lines I suppose; then every PMU that actually
> checks the flags, needs to set the flag, otherwise it'll fail.
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 53c500f0ca79..de15723ea52a 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -244,6 +244,7 @@ struct perf_event;
>  #define PERF_PMU_CAP_EXCLUSIVE			0x10
>  #define PERF_PMU_CAP_ITRACE			0x20
>  #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
> +#define PERF_PMU_CAP_EXCLUDE			0x80
>  
>  /**
>   * struct pmu - generic performance monitoring unit
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 84530ab358c3..d76b724177b9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9772,6 +9772,14 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
>  	if (ctx)
>  		perf_event_ctx_unlock(event->group_leader, ctx);
>  
> +	if (!ret) {
> +		if ((pmu->capabilities & PERF_PMU_CAP_EXCLUDE) ||
> +		    event_has_exclude_flags(event)) {
> +			event->destroy(event);
> +			ret = -EINVAL;
> +		}
> +	}
> +

I don't quite follow this logic. Should that not have been:

if (!(pmu->capabilities & PERF_PMU_CAP_EXCLUDE) &&
     event_has_exclude_flags(event)) {

Meaning that if an event has any exclude flags but the pmu doesn't
have the capability to handle them then error.

If you're happy with my proposed logic, then would it also make
sense to move this before the call to the pmu->event_init ?

Thanks,

Andrew Murray

>  	if (ret)
>  		module_put(pmu->module);
>  
> 

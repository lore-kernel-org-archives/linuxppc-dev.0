Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C70C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 13:22:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7F3206B6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 13:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7F3206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YtGw6jS3zDqLR
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 00:22:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=andrew.murray@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43YsxZ58lWzDqVJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 00:07:45 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D6621596;
 Tue,  8 Jan 2019 05:07:43 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C84953F70D;
 Tue,  8 Jan 2019 05:07:42 -0800 (PST)
Date: Tue, 8 Jan 2019 13:07:41 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 05/13] arm: perf: conditionally use
 PERF_PMU_CAP_NO_EXCLUDE
Message-ID: <20190108130740.GC56789@e119886-lin.cambridge.arm.com>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
 <1546878450-20341-6-git-send-email-andrew.murray@arm.com>
 <20190108102802.GC6808@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108102802.GC6808@hirez.programming.kicks-ass.net>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, Shawn Guo <shawnguo@kernel.org>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
 suzuki.poulose@arm.com, Sascha Hauer <s.hauer@pengutronix.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 08, 2019 at 11:28:02AM +0100, Peter Zijlstra wrote:
> On Mon, Jan 07, 2019 at 04:27:22PM +0000, Andrew Murray wrote:
> > @@ -393,9 +386,8 @@ __hw_perf_event_init(struct perf_event *event)
> >  	/*
> >  	 * Check whether we need to exclude the counter from certain modes.
> >  	 */
> > +	if (armpmu->set_event_filter &&
> > +	    armpmu->set_event_filter(hwc, &event->attr)) {
> >  		pr_debug("ARM performance counters do not support "
> >  			 "mode exclusion\n");
> >  		return -EOPNOTSUPP;
> 
> This then requires all set_event_filter() implementations to check all
> the various exclude options;

Yes but this isn't a new requirement, this hunk uses the absence of
set_event_filter to blanket indicate that no exclusion flags are supported.


> also, set_event_filter() failing then
> returns with -EOPNOTSUPP instead of the -EINVAL the CAP_NO_EXCLUDE
> generates, which is again inconsitent.

Yes, it's not ideal - but a step in the right direction. I wanted to limit
user visible changes as much as possible, where I've identified them I've
noted it in the commit log.

> 
> If I look at (the very first git-grep found me)
> armv7pmu_set_event_filter(), then I find it returning -EPERM (again
> inconsistent but irrelevant because the actual value is not preserved)
> for exclude_idle.
> 
> But it doesn't seem to check exclude_host at all for example.

Yes I found lots of examples like this across the tree whilst doing this
work. However I decided to initially start with simply removing duplicated
code as a result of adding this flag and attempting to preserve existing
functionality. I thought that if I add missing checks then the patchset
will get much bigger and be harder to merge. I would like to do this though
as another non-cross-arch series.

Can we limit this patch series to the minimal changes required to fully
use PERF_PMU_CAP_NO_EXCLUDE and then attempt to fix these existing problems
in subsequent patch sets?

Thanks,

Andrew Murray

> 
> > @@ -867,6 +859,9 @@ int armpmu_register(struct arm_pmu *pmu)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (!pmu->set_event_filter)
> > +		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
> > +
> >  	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
> >  	if (ret)
> >  		goto out_destroy;
> > -- 
> > 2.7.4
> > 

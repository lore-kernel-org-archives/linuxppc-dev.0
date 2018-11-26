Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87CAC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 14:57:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3284320663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 14:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3284320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433VQP6sGfzDqWg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 01:57:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=andrew.murray@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 433VMK1ZvvzDqWd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 01:55:07 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93788351D;
 Mon, 26 Nov 2018 06:55:06 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7A463F575;
 Mon, 26 Nov 2018 06:55:05 -0800 (PST)
Date: Mon, 26 Nov 2018 14:55:04 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 03/20] perf/core: add PERF_PMU_CAP_EXCLUDE for
 exclusion capable PMUs
Message-ID: <20181126145503.GA25271@e119886-lin.cambridge.arm.com>
References: <1543230756-15319-1-git-send-email-andrew.murray@arm.com>
 <1543230756-15319-4-git-send-email-andrew.murray@arm.com>
 <8c9003c3-ccbf-c342-024f-772d697a911b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c9003c3-ccbf-c342-024f-772d697a911b@arm.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
 Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 James Hogan <jhogan@kernel.org>, Will Deacon <will.deacon@arm.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Shawn Guo <shawnguo@kernel.org>, "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 26, 2018 at 02:10:24PM +0000, Robin Murphy wrote:
> Hi Andrew,
> 
> On 26/11/2018 11:12, Andrew Murray wrote:
> > Many PMU drivers do not have the capability to exclude counting events
> > that occur in specific contexts such as idle, kernel, guest, etc. These
> > drivers indicate this by returning an error in their event_init upon
> > testing the events attribute flags. This approach is error prone and
> > often inconsistent.
> > 
> > Let's instead allow PMU drivers to advertise their ability to exclude
> > based on context via a new capability: PERF_PMU_CAP_EXCLUDE. This
> > allows the perf core to reject requests for exclusion events where
> > there is no support in the PMU.
> > 
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >   include/linux/perf_event.h | 1 +
> >   kernel/events/core.c       | 9 +++++++++
> >   2 files changed, 10 insertions(+)
> > 
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index b2e806f..69b3d65 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -244,6 +244,7 @@ struct perf_event;
> >   #define PERF_PMU_CAP_EXCLUSIVE			0x10
> >   #define PERF_PMU_CAP_ITRACE			0x20
> >   #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
> > +#define PERF_PMU_CAP_EXCLUDE			0x80
> >   /**
> >    * struct pmu - generic performance monitoring unit
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 5a97f34..9afb33c 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9743,6 +9743,15 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
> >   	if (ctx)
> >   		perf_event_ctx_unlock(event->group_leader, ctx);
> > +	if (!ret) {
> > +		if (!(pmu->capabilities & PERF_PMU_CAP_EXCLUDE) &&
> > +				event_has_any_exclude_flag(event)) {
> 
> Technically this is a bisection-breaker, since no driver has this capability
> yet - ideally, this patch should come after all the ones introducing it to
> the relevant drivers (with the removal of the now-redundant code from the
> other drivers at the end).

Indeed. Thought it is possible to first introduce the capability, update the
relevant drivers to advertise it, then add the change to core.c and finally
remove the unnecessary error checks as a result of using the new capability.
This approach could be bisection-proof.

> 
> Alternatively, since we already have several other negative capabilities,
> unless there's a strong feeling against adding any more then it might work
> out simpler to flip it to PERF_PMU_CAP_NO_EXCLUDE, such that we only need to
> introduce the core check then directly replace the open-coded event checks
> with the capability in the appropriate drivers, and need not touch the
> exclusion-supporting ones at all.

This would certaintly be less risky and invasive (e.g. compare the number of
files touched between this v2 and the previous v1).

I'm happy with either approach.

Thanks,

Andrew Murray

> 
> Robin.
> 
> > +			if (event->destroy)
> > +				event->destroy(event);
> > +			ret = -EINVAL;
> > +		}
> > +	}
> > +
> >   	if (ret)
> >   		module_put(pmu->module);
> > 

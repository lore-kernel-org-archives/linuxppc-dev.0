Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9679C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 12:30:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D94F20684
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 12:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gN8XvJOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D94F20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430zKs215lzDqNf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 23:30:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="gN8XvJOL";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430zGN2lhbzDqNv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 23:27:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6GoQshdtTCtgMebtwlHObzPjr944dMKihJzDk8JnA+E=; b=gN8XvJOLSMf9Ga/u/ly10Llmm
 d94ZfD94B0B6/m6mCzv91TIyY3eHgeFCJL9dj5fuS93nGq7DX+i8Y/H/a3UzqrpyuLk6nLAbUoibz
 jFwPpe1WGtzIzPWssrpuIWEWzsayQsj2a9+m+cSKL3e8BQ6v8073C2AsmNS4QxtsSb8E44vmMhFcu
 au6wPlvaM6ksRF/BkswOOa1rYEsi/HVInl7A0PNOie2KYXkxJxLYQSrNnaKoKFBIZUkaZ3rktsycV
 iaKN4IdixwWgG7LgClwd5g0QSrNQ4FVwLAyV1IPpvfzP031JzYzlPfPl+O5p3oaes5Qa76i3cweT+
 2vWyx7Lvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPo4E-0001H5-NY; Thu, 22 Nov 2018 12:26:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 1753B2029FD58; Thu, 22 Nov 2018 13:26:37 +0100 (CET)
Date: Thu, 22 Nov 2018 13:26:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 00/10] perf/core: Generalise event exclusion checking
Message-ID: <20181122122637.GS2131@hirez.programming.kicks-ass.net>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <20181119130800.GE9761@hirez.programming.kicks-ass.net>
 <20181122122142.GI42987@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122122142.GI42987@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Thu, Nov 22, 2018 at 12:21:43PM +0000, Andrew Murray wrote:
> On Mon, Nov 19, 2018 at 02:08:00PM +0100, Peter Zijlstra wrote:

> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 84530ab358c3..d76b724177b9 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9772,6 +9772,14 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
> >  	if (ctx)
> >  		perf_event_ctx_unlock(event->group_leader, ctx);
> >  
> > +	if (!ret) {
> > +		if ((pmu->capabilities & PERF_PMU_CAP_EXCLUDE) ||
> > +		    event_has_exclude_flags(event)) {
> > +			event->destroy(event);
> > +			ret = -EINVAL;
> > +		}
> > +	}
> > +
> 
> I don't quite follow this logic. Should that not have been:
> 
> if (!(pmu->capabilities & PERF_PMU_CAP_EXCLUDE) &&
>      event_has_exclude_flags(event)) {
> 
> Meaning that if an event has any exclude flags but the pmu doesn't
> have the capability to handle them then error.

Uhm, yes. Brainfart on my side that.

> If you're happy with my proposed logic, then would it also make
> sense to move this before the call to the pmu->event_init ?

I'm not sure that can work; I think we need ->event_init() first such
that it can -ENOENT. Only after ->event_init() returns success can we be
certain of @pmu.

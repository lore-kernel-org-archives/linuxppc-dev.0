Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426B8C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 10:30:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F247920850
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 10:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KtPkx1Ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F247920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YpSK6p0DzDqTG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 21:30:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="KtPkx1Ci"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YpQ61HtmzDqQf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 21:28:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a3kU5k+u673a2t4p3kZsUUxiSNyKyt8voZTb8FPfGoU=; b=KtPkx1CiOsfJMDgrKwdFT06Wg
 RsxgG+HhPdWeZT2jQM2eF/RrXNalETBM4ZFaA9Xy6HS5tx8TknXTI7JkPDwPyc4ZoykiCuM6OwVDu
 c26g/Pna8g9b7AFhFeYOFo2ukav88impf1E5/f4d7VQwaZTuh7jVHc4jXGEb/Vvv3cY8ajOmEtH0y
 2SZrEjNZ2fytGuPTc+WTgg0NywS0Gj50L6jsHOpV6/GeEiuDYHSUZ9ji+/Mp027aMTj2leFSsF7+U
 G5va0gYlsmkGWKPArWaKBMWLO2kI/qb25k/EdrXhEl8oE6q22epOoF2ZUVaKJvBPvWtqywRNO3PMf
 NLCUwZRng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggoc8-0003ob-DZ; Tue, 08 Jan 2019 10:28:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 04C1D20268504; Tue,  8 Jan 2019 11:28:02 +0100 (CET)
Date: Tue, 8 Jan 2019 11:28:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v4 05/13] arm: perf: conditionally use
 PERF_PMU_CAP_NO_EXCLUDE
Message-ID: <20190108102802.GC6808@hirez.programming.kicks-ass.net>
References: <1546878450-20341-1-git-send-email-andrew.murray@arm.com>
 <1546878450-20341-6-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546878450-20341-6-git-send-email-andrew.murray@arm.com>
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

On Mon, Jan 07, 2019 at 04:27:22PM +0000, Andrew Murray wrote:
> @@ -393,9 +386,8 @@ __hw_perf_event_init(struct perf_event *event)
>  	/*
>  	 * Check whether we need to exclude the counter from certain modes.
>  	 */
> +	if (armpmu->set_event_filter &&
> +	    armpmu->set_event_filter(hwc, &event->attr)) {
>  		pr_debug("ARM performance counters do not support "
>  			 "mode exclusion\n");
>  		return -EOPNOTSUPP;

This then requires all set_event_filter() implementations to check all
the various exclude options; also, set_event_filter() failing then
returns with -EOPNOTSUPP instead of the -EINVAL the CAP_NO_EXCLUDE
generates, which is again inconsitent.

If I look at (the very first git-grep found me)
armv7pmu_set_event_filter(), then I find it returning -EPERM (again
inconsistent but irrelevant because the actual value is not preserved)
for exclude_idle.

But it doesn't seem to check exclude_host at all for example.

> @@ -867,6 +859,9 @@ int armpmu_register(struct arm_pmu *pmu)
>  	if (ret)
>  		return ret;
>  
> +	if (!pmu->set_event_filter)
> +		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
> +
>  	ret = perf_pmu_register(&pmu->pmu, pmu->name, -1);
>  	if (ret)
>  		goto out_destroy;
> -- 
> 2.7.4
> 

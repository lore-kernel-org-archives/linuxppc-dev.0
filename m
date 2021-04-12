Return-Path: <SRS0=//ir=JJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23721C433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 09:45:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8203E6120B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 09:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8203E6120B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FJkPS1dk1z3c0D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Apr 2021 19:45:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=techsingularity.net (client-ip=46.22.139.220;
 helo=outbound-smtp37.blacknight.com; envelope-from=mgorman@techsingularity.net;
 receiver=<UNKNOWN>)
X-Greylist: delayed 460 seconds by postgrey-1.36 at boromir;
 Mon, 12 Apr 2021 19:45:11 AEST
Received: from outbound-smtp37.blacknight.com (outbound-smtp37.blacknight.com
 [46.22.139.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FJkP32kc2z3004
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Apr 2021 19:45:11 +1000 (AEST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
 by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 622692302
 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 12 Apr 2021 10:37:24 +0100 (IST)
Received: (qmail 24080 invoked from network); 12 Apr 2021 09:37:24 -0000
Received: from unknown (HELO techsingularity.net)
 (mgorman@techsingularity.net@[84.203.22.4])
 by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated);
 12 Apr 2021 09:37:24 -0000
Date: Mon, 12 Apr 2021 10:37:22 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH] powerpc/smp: Add SD_SHARE_PKG_RESOURCES flag to MC
 sched-domain
Message-ID: <20210412093722.GS3697@techsingularity.net>
References: <1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com>
 <20210412062436.GB2633526@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210412062436.GB2633526@linux.vnet.ibm.com>
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Rik van Riel <riel@surriel.com>,
 LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Parth Shah <parth@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Valentin Schneider <valentin.schneider@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 12, 2021 at 11:54:36AM +0530, Srikar Dronamraju wrote:
> * Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2021-04-02 11:07:54]:
> 
> > 
> > To remedy this, this patch proposes that the LLC be moved to the MC
> > level which is a group of cores in one half of the chip.
> > 
> >       SMT (SMT4) --> MC (Hemisphere)[LLC] --> DIE
> > 
> 
> I think marking Hemisphere as a LLC in a P10 scenario is a good idea.
> 
> > While there is no cache being shared at this level, this is still the
> > level where some amount of cache-snooping takes place and it is
> > relatively faster to access the data from the caches of the cores
> > within this domain. With this change, we no longer see regressions on
> > P10 for applications which require single threaded performance.
> 
> Peter, Valentin, Vincent, Mel, etal
> 
> On architectures where we have multiple levels of cache access latencies
> within a DIE, (For example: one within the current LLC or SMT core and the
> other at MC or Hemisphere, and finally across hemispheres), do you have any
> suggestions on how we could handle the same in the core scheduler?
> 

Minimally I think it would be worth detecting when there are multiple
LLCs per node and detecting that in generic code as a static branch. In
select_idle_cpu, consider taking two passes -- first on the LLC domain
and if no idle CPU is found then taking a second pass if the search depth
allows within the node with the LLC CPUs masked out. While there would be
a latency hit because cache is not shared, it would still be a CPU local
to memory that is idle. That would potentially be beneficial on Zen*
as well without having to introduce new domains in the topology hierarchy.

-- 
Mel Gorman
SUSE Labs

Return-Path: <SRS0=zi2C=LT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34064C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 09:03:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DBB560FEB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 09:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DBB560FEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GB9yc5WCbz3bsk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jun 2021 19:03:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=valentin.schneider@arm.com; receiver=<UNKNOWN>)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4GB9y9596tz305p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jun 2021 19:02:55 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA2A731B;
 Fri, 25 Jun 2021 02:02:51 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6DE63F719;
 Fri, 25 Jun 2021 02:02:50 -0700 (PDT)
From: Valentin Schneider <valentin.schneider@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: PowerPC guest getting "BUG: scheduling while atomic" on
 linux-next-20210623 during secondary CPUs bringup
In-Reply-To: <YNWFiZii+MINhUC3@hirez.programming.kicks-ass.net>
References: <YNSq3UQTjm6HWELA@in.ibm.com>
 <20210625054608.fmwt7lxuhp7inkjx@linux.vnet.ibm.com>
 <YNWFiZii+MINhUC3@hirez.programming.kicks-ass.net>
Date: Fri, 25 Jun 2021 10:02:45 +0100
Message-ID: <87k0mi8gga.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Ingo Molnar <mingo@kernel.org>, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Bharata B Rao <bharata@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 25/06/21 09:28, Peter Zijlstra wrote:
> On Fri, Jun 25, 2021 at 11:16:08AM +0530, Srikar Dronamraju wrote:
>> Bharata,
>>
>> I think the regression is due to Commit f1a0a376ca0c ("sched/core:
>> Initialize the idle task with preemption disabled")
>
> So that extra preempt_disable() that got removed would've incremented it
> to 1 and then things would've been fine.
>
> Except.. Valentin changed things such that preempt_count() should've
> been inittialized to 1, instead of 0, but for some raisin that didn't
> stick.. what gives.
>
> So we have init_idle(p) -> init_idle_preempt_count(p) ->
> task_thread_info(p)->preempt_count = PREEMPT_DISABLED;
>
> But somehow, by the time you're running start_secondary(), that's gotten
> to be 0 again. Does DEBUG_PREEMPT give more clues?

Given the preempt_count isn't reset between hotplugs anymore, you might be
able to find the culprit with a hotplug cycle and ftrace with
trace_prempt_off and trace_preempt_on events (requires PREEMPT_TRACER
IIRC).

It's doable at boot time too, but that will mean sifting through many more
events than you'd like...

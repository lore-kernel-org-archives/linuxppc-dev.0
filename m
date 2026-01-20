Return-Path: <linuxppc-dev+bounces-16073-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB03D2ECF7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jan 2026 14:52:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dwVfZ6RnGz3c7n;
	Wed, 21 Jan 2026 01:52:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768920742;
	cv=none; b=lf2yq1r5mEiWrO+DrmF4zdCqAZwd4bqK/x30V+M3i69KuKSkxXNFJRaQJi9gh6PD06kqCvdxFMTk/okeFQ0Jx0jiACKoyC2dk9DhQ6nxaAdFNKBzDdPIlmUcGHXg2orO3t2Kj2bxRS9W6U+/OCKldpq9V7pYjnCgtzQQG6Kix8DT2meiCZTR8UmZ5+euuBmcyKmYk4eYTFU/ON8zYf5zw0kUeo0Dq1HuAppsD21dHV7xtgQk7UnRbYlMcD+TsFHPQbvE0I2MjF8iiUNzBKQStywtr93cEIPRFinYMrMj/Pmg2KYhUxPWwGVkBO53HEqwfBGRYU5ZcDf5fn5UAaf1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768920742; c=relaxed/relaxed;
	bh=Nqo2fPqbrUqfQKli7Mqidc2NiQjbgO1WJceFyXuitqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in5tCoIPOGjGXjM3hLnwlnEX6jQ+XHEeT2xuF0Nx6MorCUZ2IM8n3tJToaKVRiPmX0llKV4afPNuV1uIXT2FrKdpxwMrgCwpBTtd/bwK+3PNzk4/koUMuAnNbtl0ZBIeefmjeQSL4Z+mDCU3ZG8/nbcoDFVtbFZigXSYgl9aXtQe4r3ZglQjZwv1MbJzD7hj9jI7avJYTmBl7xpeXQB5f8kyz5nw/0/R5T++iLZLOmP+xqhKOxKCaR+lN9BdWv53hpZRJ6s1W8tsK6o4u7icCeb4+O78NymRqhaOTq1EPCJn9zP/WsGVcr0NIKQnMO156Qldd0wqAKe10WNrDeWp4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pPSOBYBt; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=pPSOBYBt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dwVfZ0rYQz3c5y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2026 01:52:22 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B2D4C429C4;
	Tue, 20 Jan 2026 14:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD110C4AF09;
	Tue, 20 Jan 2026 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768920739;
	bh=DpCSZAzTuJI/7gGOtphK/DlHzjIiahQ/22C6C32U1mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPSOBYBtcsR6iQhbXYih9Qp4HdBObVgVQWeBJdOmP5uvW3N0XpRwSuRGUWszm8Wsm
	 x7X1naATf4iHfH9+WXGmMpEbmoBIzfMBWDcjtXp2ALq+q0DiaZyE+0hf8qZzmfyuAh
	 +k54n2m4xgJ9vCgrUunkiflZvzFqqvPrajs2pQaTShpqhWcSbbMV55FcEigDfmF0b6
	 b/su04c8MKtL98toNNGznOkNtlwkGEo9U5PNysWfc/lynAGqRxUMUxxpDP98oacmK/
	 95IV+zJ4Gik2QAjU0tollXRYSthjis0U+sTqRza5ZxURR6g98HQ8t2T1QaqUfMgxNy
	 +l4xvmdsJAObg==
Date: Tue, 20 Jan 2026 15:52:16 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/15] sched/idle: Handle offlining first in idle loop
Message-ID: <aW-WoBsdb-jKDomL@localhost.localdomain>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-2-frederic@kernel.org>
 <20260119125347.GT830755@noisy.programming.kicks-ass.net>
 <aW6ccexiQaPLQcS1@pavilion.home>
 <ec1fbc52-3e72-4a0f-954c-9ecf581f9e39@amd.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec1fbc52-3e72-4a0f-954c-9ecf581f9e39@amd.com>

Le Tue, Jan 20, 2026 at 09:56:12AM +0530, K Prateek Nayak a écrit :
> Hello Frederic, Peter,
> 
> On 1/20/2026 2:34 AM, Frederic Weisbecker wrote:
> > Le Mon, Jan 19, 2026 at 01:53:47PM +0100, Peter Zijlstra a écrit :
> >> On Fri, Jan 16, 2026 at 03:51:54PM +0100, Frederic Weisbecker wrote:
> >>
> >>>  kernel/sched/idle.c | 11 ++++++-----
> >>>  1 file changed, 6 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> >>> index c174afe1dd17..35d79af3286d 100644
> >>> --- a/kernel/sched/idle.c
> >>> +++ b/kernel/sched/idle.c
> >>> @@ -260,6 +260,12 @@ static void do_idle(void)
> >>>  {
> >>>  	int cpu = smp_processor_id();
> >>>  
> >>> +	if (cpu_is_offline(cpu)) {
> >>
> >> Does it make sense to make that: if (unlikely(cpu_is_offline(cpu))) ?
> > 
> > Yes indeed!
> 
> nit. but don't we inherit it from:
> 
> #define cpu_is_offline(cpu)     unlikely(!cpu_online(cpu))
> 
> so it will end up being annotated with unlikely() no?

Ah right!

> 
> -- 
> Thanks and Regards,
> Prateek
> 

-- 
Frederic Weisbecker
SUSE Labs


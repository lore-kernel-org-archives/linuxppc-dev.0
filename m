Return-Path: <linuxppc-dev+bounces-19678-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C089EBFD38
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 11:00:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvPZX0hCZz2yhv;
	Mon, 13 Apr 2026 21:00:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776078020;
	cv=none; b=jTmLlERG/nIDLILoclt63ydkAVEDLufIIqKsTr7AXGWFJ4En3ipneHx00cR27zdWDERQcLiLa68361px4zGR33U4B7TEKBtRDYRzjzHeNoO7Zh24PUBVUFgnwY/b03Cr1U90zMywaY4OF54DUhMmBd19F6WIYENPN3EGyc4+/9wBTBP4Pf8osLVG0b6/Pd7MqpDoccINgKJH5/Am0TS1oUbzSotL+XB3yVufuExBgmdFezG3lFzP9VqdCcIHXdTfOaATig4dQPwdTj59kFDeaZ4dnqvqKvKOctCM1n5b3vKvPpBhXRKroi1kQ9ERzPfe1A5uWE3M9itC73/YZ29vmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776078020; c=relaxed/relaxed;
	bh=1/1FgjrLC/aM+8k4Qq7c5/XIztGeUYCEm+M4C68ltOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAvAkf6Gln8wipERC6oTtaaLcXH10xQve2YZP22SQ89mSi1C/tO0TTsJQFqLSIT3TuDGtFa1bXG5nSNe2KhfOsMmS7PQB9axC8OCO7O0GsVnGKBq4p8o/r1PlmHM/+O8cfu/kUyD00OSgYvT7JGpcdNeY5ydxeViHv7kw7s81Qqd/MuUbK/jok43BL8M15TEhCf31LGMM/JIMjqHL69UL3pNAXhEf2h2Dy53aTpKm+1Zg1ZdwPJYo2p2JqVjgLiu8t0iue2OVzcuBWLuF13nV8G8o3YLYwQrSGcKy4aLlRBOF3mAikXwLXaK334qthkAWvwEbEgCTfq9lvvrlmM01A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=po80zusm; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=po80zusm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvPZV62nPz2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 21:00:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0363C60172;
	Mon, 13 Apr 2026 11:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A4C116C6;
	Mon, 13 Apr 2026 11:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776078015;
	bh=sWeDGz5nVxh7zul1oYxNegopCUQGMob68LVgLTxZPrU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=po80zusm+gtU+EGSkMuJ2hqujkYkUJ1p8Kz4680dGC5/FlNAC/buMbtHK5Fg1QD7G
	 6GNXB5/XjtQ0/nECSh3SgHU4WsBsoyOzwk3XH1g1oxCSZtiWXdfdTOhY0HWWG0npeS
	 XGx+e0qTFsLrNXW0Mc1fnAQM3clczqq8PETdNtXHXNyCBugC2cmqIKJn4OWLmws47V
	 Ucnb/6DzHn350VtTVjWlgnoq5/FchzT7yYgrSh9WBjXZcPq5PT5mYz6SovfRrFXX9U
	 RH05hFoVPfKt13rRlGJ4HlRdah/1oRHBaNuUZpBILRkUlyhnjgIaOuK/y4B1s8MDNl
	 I/ahVTcgcNKiA==
Message-ID: <2dab11d1-18ca-4da4-a33e-3f2c3c4b6320@kernel.org>
Date: Mon, 13 Apr 2026 13:00:07 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] powerpc/time: Prepare to stop elapsing in
 dynticks-idle
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Juri Lelli <juri.lelli@redhat.com>, Kieran Bingham <kbingham@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mel Gorman <mgorman@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Paul E . McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Valentin Schneider <vschneid@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Xin Zhao <jackzxcui1989@163.com>,
 linux-pm@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260331131622.30505-1-frederic@kernel.org>
 <20260331131622.30505-5-frederic@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260331131622.30505-5-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 31/03/2026 à 15:16, Frederic Weisbecker a écrit :
> Currently the tick subsystem stores the idle cputime accounting in
> private fields, allowing cohabitation with architecture idle vtime
> accounting. The former is fetched on online CPUs, the latter on offline
> CPUs.
> 
> For consolidation purpose, architecture vtime accounting will continue
> to account the cputime but will make a break when the idle tick is
> stopped. The dyntick cputime accounting will then be relayed by the tick
> subsystem so that the idle cputime is still seen advancing coherently
> even when the tick isn't there to flush the idle vtime.
> 
> Prepare for that and introduce three new APIs which will be used in
> subsequent patches:
> 
> _ vtime_dynticks_start() is deemed to be called when idle enters in
>    dyntick mode. The idle cputime that elapsed so far is accumulated.
> 
> - vtime_dynticks_stop() is deemed to be called when idle exits from
>    dyntick mode. The vtime entry clocks are fast-forward to current time
>    so that idle accounting restarts elapsing from now.
> 
> - vtime_reset() is deemed to be called from dynticks idle IRQ entry to
>    fast-forward the clock to current time so that the IRQ time is still
>    accounted by vtime while nohz cputime is paused.
> 
> Also accumulated vtime won't be flushed from dyntick-idle ticks to avoid
> accounting twice the idle cputime, along with nohz accounting.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/kernel/time.c | 41 ++++++++++++++++++++++++++++++++++++++
>   include/linux/vtime.h      |  6 ++++++
>   2 files changed, 47 insertions(+)
> 

...

> diff --git a/include/linux/vtime.h b/include/linux/vtime.h
> index 336875bea767..61b94c12d7dd 100644
> --- a/include/linux/vtime.h
> +++ b/include/linux/vtime.h
> @@ -37,11 +37,17 @@ extern void vtime_account_irq(struct task_struct *tsk, unsigned int offset);
>   extern void vtime_account_softirq(struct task_struct *tsk);
>   extern void vtime_account_hardirq(struct task_struct *tsk);
>   extern void vtime_flush(struct task_struct *tsk);
> +extern void vtime_reset(void);
> +extern void vtime_dyntick_start(void);
> +extern void vtime_dyntick_stop(void);
>   #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
>   static inline void vtime_account_irq(struct task_struct *tsk, unsigned int offset) { }
>   static inline void vtime_account_softirq(struct task_struct *tsk) { }
>   static inline void vtime_account_hardirq(struct task_struct *tsk) { }
>   static inline void vtime_flush(struct task_struct *tsk) { }
> +static inline void vtime_reset(void) { }
> +static inline void vtime_dyntick_start(void) { }
> +extern inline void vtime_dyntick_stop(void) { }

You mean 'static' inline, not 'extern' ?

Christophe

>   #endif
>   
>   /*



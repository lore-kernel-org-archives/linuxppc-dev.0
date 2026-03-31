Return-Path: <linuxppc-dev+bounces-19097-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88BF109B46D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 14:00:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flVB440RVz2ybR;
	Wed, 01 Apr 2026 01:00:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774965612;
	cv=none; b=oUxfi/HyQzlaZxHtgMr8vE2Oj2ph6On4FFD4LM/RZ0PPo5qZuOwrJ9V0PwSt7OmM1mVaQqxQn/ruOQXcGUxioYmgoK5+zYXX82k3gPloiCL3W6/i1BW2auMUwuejCf7psEV2EdTbcB6NrcEiqmDjm8EOwPowsWTRvbEFmmJL4Olwc2T2JXps+tK0vTexae4lqc1tWISNg3pttEr8MaXYwNXirJH5opbC8LQoviEaVXxPro/lqbwN2LLK3ZgMki7t9HaRUCa0NpfGa2sBxzVQ0db9KRSyCTs+6VqZkEVdQI4mnvyUls1Y/dAYJZBcWzY7bxA5ocdjrqy6W2D72bRIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774965612; c=relaxed/relaxed;
	bh=wsQZ5Yhb2xoDUq/o5DpGA6YU2cTKtYzQZSP3slZjjmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkA4NG45kc+Q7iWo0fwkxFQ+kXWu86DJlVCXG2PFcBWqkrc6au7KcyaFi2jdXu/hheU7YHsUHougWNDA+0EvKew9PVJRyJ/lEijjcf3MsAkkBijyRJG9PDdmSICLPKMvCzox09z7WTqOzs4hd+lSjjRKTTASP5FvfzOOMtJl6bfpDIdHOiz9TGC3H/fiWvxE8omvl3n0GFsELJ28tok3cmSwUAdfKHaUObZV/ozDegb13OgfO0gm3s+1MIrH5SQXCGpNLfdlS0GVIdtnLxRQRfYvm7vrVSMh/M8g5Y2sGu6hvkauh+1oxXUBiUqr1inSgoNdN3Mg/0+P7Ou0knu7DQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QQ0PH/CG; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QQ0PH/CG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rafael@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flVB343cnz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 01:00:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EED296132F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 14:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0106C2BCB5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774965608;
	bh=v8oGte1nICQf3lPzs/IH7HujDZ08x8KnEuuH3pyLmXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QQ0PH/CG0dWacUziG4TNgGC3pZnU4geMh3an4vCBQT4so9mzz6OnOMW6HjZW/5pIR
	 VIK02bsYHgPtDxWO9hiZ9oCZSIuVJlHMYylbdgza8MaXjEsUWbiOFWmbL/CNJ6WWyz
	 3hW/J+jSuPKcoyoH+oyoWOnh+u8WKdnuncyzsEN2BvRxr4xNAfrFyqobe1/JDevGVK
	 bGFEB7jWDn4ZL5G6MaL2BQINbPAK6Bu5YyIG31K/V0uXmhgT+gNqvIKxR8r64uutlF
	 HForGfWlPhfy1Gi0mRpoCxwcciky2Hccat3M2CRIPCkulov95gD8wvMSRfxSrttxlk
	 3ML0Cls2uYXcQ==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-466f00535cfso3548401b6e.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 07:00:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgxIh/pzA1B2vf/e7cy/LXRsrQVT1Z50Tfi3MvRoUAq7KogkG0VupdtfiWOMoZ03aTraKIVIomJQn3wsQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzaw9o/i1S5p+UQKZxjWwhqjKCMpgnHAkNXvif4ZmrcmeSlNwaQ
	708t5A/W11qvXIQ4ABJqXVf3+hxKCOkhTo/cV6RFdv/KsOEolwHRuToQmH7or8PyuF7jtA5/Kuo
	nu28VpV/VqhxcwvKZRzxAR6/dtRi6JoM=
X-Received: by 2002:a05:6808:1493:b0:467:f3d4:fc4e with SMTP id
 5614622812f47-46a8a596197mr7405781b6e.33.1774965607378; Tue, 31 Mar 2026
 07:00:07 -0700 (PDT)
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
References: <20260331131622.30505-1-frederic@kernel.org> <20260331131622.30505-2-frederic@kernel.org>
In-Reply-To: <20260331131622.30505-2-frederic@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 31 Mar 2026 15:59:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gK3WdPhVuY-SJNJ4WK87kL3w9Q8KGBtt5RuE1AUoxdLQ@mail.gmail.com>
X-Gm-Features: AQROBzC01cSpFeB8dQHSq2PjzTVT0MM4PbeCSZP1pxl-fD4ctuT__P9I9dxaSrc
Message-ID: <CAJZ5v0gK3WdPhVuY-SJNJ4WK87kL3w9Q8KGBtt5RuE1AUoxdLQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] sched/idle: Handle offlining first in idle loop
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Kieran Bingham <kbingham@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Mel Gorman <mgorman@suse.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nicholas Piggin <npiggin@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, 
	Valentin Schneider <vschneid@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 3:16=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Offline handling happens from within the inner idle loop,
> after the beginning of dyntick cputime accounting, nohz idle
> load balancing and TIF_NEED_RESCHED polling.
>
> This is not necessary and even buggy because:
>
> * There is no dyntick handling to do. And calling tick_nohz_idle_enter()
>   messes up with the struct tick_sched reset that was performed on
>   tick_sched_timer_dying().
>
> * There is no nohz idle balancing to do.
>
> * Polling on TIF_RESCHED is irrelevant at this stage, there are no more
>   tasks allowed to run.
>
> * No need to check if need_resched() before offline handling since
>   stop_machine is done and all per-cpu kthread should be done with
>   their job.
>
> Therefore move the offline handling at the beginning of the idle loop.
> This will also ease the idle cputime unification later by not elapsing
> idle time while offline through the call to:
>
>         tick_nohz_idle_enter() -> tick_nohz_start_idle()
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>

No issues found, so

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  kernel/sched/idle.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 3681b6ad9276..521a076d8845 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -260,6 +260,14 @@ static void do_idle(void)
>  {
>         int cpu =3D smp_processor_id();
>
> +       if (cpu_is_offline(cpu)) {
> +               local_irq_disable();
> +               /* All per-CPU kernel threads should be done by now. */
> +               WARN_ON_ONCE(need_resched());
> +               cpuhp_report_idle_dead();
> +               arch_cpu_idle_dead();
> +       }
> +
>         /*
>          * Check if we need to update blocked load
>          */
> @@ -311,11 +319,6 @@ static void do_idle(void)
>                  */
>                 local_irq_disable();
>
> -               if (cpu_is_offline(cpu)) {
> -                       cpuhp_report_idle_dead();
> -                       arch_cpu_idle_dead();
> -               }
> -
>                 arch_cpu_idle_enter();
>                 rcu_nocb_flush_deferred_wakeup();
>
> --
> 2.53.0
>


Return-Path: <linuxppc-dev+bounces-16705-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF71EE6B69
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 22:35:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f786w3V29z2xpg;
	Sat, 07 Feb 2026 09:35:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770417320;
	cv=none; b=P0DV2jdkjzGNQMFCSxgvK89aamTDA1EBc6b0Rzdyl+MnhVmMnt+hII01JdirAu10fMiphXs39zpWwy4HUGNlUPcn6OuDQr1seXJAiiYmhDpxRn7iHPOY5r56/iOkgpxqQoQJv9Gr1stD6BJe1KtY2SCJ5/Hr8RIrK00wwC1E1jOm1U2vZx2FxBIcQOo233ffNm8CG/2mVJOA8s3BPakbzvr8oSibPYdj391opyXogXjGzLucGdOTsmva1R7MhfacRY7m5CkPyQDgO6W76xKNmmd1fDBcAxb73Ncpb8VKoANqR/2/k3JL0rZBoKn9O9WOgGVw//dLNkX0rgL7szlrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770417320; c=relaxed/relaxed;
	bh=TulN1oXUx7JbdxEjeZhn4fnWQQa6euApONQLi1Qqyik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3Xk7cg/kgUk/bhGF+khj60S+Zj93jJzbvlGd8zaCREoX9cOU2IvMX/7r792Nbd7UKuWgqrewiMfwtD8mMtS4BsMpcnvkL7FB/1Zu4HIGeLN0yPMFNWhzMBOcUaJlylbWmKwjWUFYaNRzfH9rymk0eZ3iw3s9pWTe3/PZxgAQxK8Rmg/dKP5phPiE2Hq95xAgDmfSNpWIdge/+IHfEeLZrI2tywt7G2/J4OD2dopjl/iQHvaEEvOGeVvcn5ICrXakrhRLFWFrEUUt7Jfjwy4SW8IlbhMt+EhW+rdrIjRNH2cCloKEXUbRhYKoW3DDbHgM3RKAjskbhOeuCmEl/83tA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R2SVvC/9; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=R2SVvC/9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f786v4qB8z2xWJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 09:35:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6F8B5600AA;
	Fri,  6 Feb 2026 22:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB67C116C6;
	Fri,  6 Feb 2026 22:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770417317;
	bh=pCN1+Vk7aDCoWI7wtIHCxSIf8mtraNIBweDErysiq/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2SVvC/9neUKjwY9SuJQZzfGdjfayUl+p9mdM5bYYOyQyUI750s7pRb3O4VmhwWvf
	 rpReglSno/G6AbwA9t6nP+/kvP8u/xyit/sw3KwGGS/ZHc7gP18inMvT7Nvjhp7wo2
	 /6sNy0nKHOunh6ramFJrLHeCvt6QsRPPUWZZsdSGiQ3CjelpYWCqi6ezYUNlXwrQOw
	 TAkX3Quvnx1lxFLNQxEmWLe5Ge6rbAIluUugpHPmsfLSeq4KedxNq4CjdA/CFUexDs
	 NHAwPdZnkXnJ1DnMnnfffHCK6wj2cojO32tXyZsM+4Ur/INBmaD0GXlZOM4u7vZFhs
	 H1hUFKRQAlfWA==
Date: Fri, 6 Feb 2026 23:35:14 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
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
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [PATCH 12/15] tick/sched: Consolidate idle time fetching APIs
Message-ID: <aYZsol2OIzMxoJXv@pavilion.home>
References: <20260206142245.58987-1-frederic@kernel.org>
 <20260206142245.58987-13-frederic@kernel.org>
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
In-Reply-To: <20260206142245.58987-13-frederic@kernel.org>

Le Fri, Feb 06, 2026 at 03:22:42PM +0100, Frederic Weisbecker a écrit :
> +static u64 get_cpu_sleep_time_us(int cpu, enum cpu_usage_stat idx,
> +				 bool compute_delta, u64 *last_update_time)
> +{
> +	ktime_t now = ktime_get();
> +	u64 res;
> +
> +	if (vtime_generic_enabled_cpu(cpu))
> +		res = kcpustat_field(idx, cpu);
> +	else
> +		res = kcpustat_field_dyntick(cpu, idx, compute_delta, now);
> +
> +	do_div(res, NSEC_PER_USEC);
> +
> +	if (last_update_time)
> +		*last_update_time = res;

Urgh, this should be *last_update_time = ktime_to_us(now)

-- 
Frederic Weisbecker
SUSE Labs


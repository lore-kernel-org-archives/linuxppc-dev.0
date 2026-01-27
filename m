Return-Path: <linuxppc-dev+bounces-16314-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C8FD2F037
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Jan 2026 14:45:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0p9W06Lzz309N;
	Wed, 28 Jan 2026 01:45:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769525134;
	cv=none; b=DuRXrB7CnEk1plD8aFM+INDOtRlEQDCAh0izfo46TGBm78qV+UQW6GvLt+IUuXOsxajR//KIZNyPfxMLcnd6VnielqosnSaD3EpfgJDaTkBaZ1MEJ/5WD+hg2tUTvpiYiNGdnXw8El+LLdNrJB/sli1j7VADlCOzKY5Hq/3900Q1nZJpy2Ax+R/MaQcdOZw09idII1gpdqQoEfmp/l7EsVl5wEWq9/a12gQuSnW+m7nV8q4iHgL8HH2H8fk4sCCNUdKUt3f8C3Ezxyus2GJSj00Qm3OdVAbpnGCX9KU6fUV8E5o/nhgzzwYqCnG5scOWwWBkHUefA+V3hn/FaLFvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769525134; c=relaxed/relaxed;
	bh=ZT2n0nSZugFte3TRA8IFPlQN20B/3iyqkX0gewzEVUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgLV7rubf8oz/kHtFrZBcdlufC2G4pcoctH7ZparNjGzmIpWKQJI6Y8aHNX5GpR9ch6acN9IOj4pXm0PYsM0GIzadR4wZoQdShMv2MZqMIMk9VuqLMQiV3j0RL99dvv8QatGz6N+UKjO2VdTe81Jf9Fvbw7utgM75E0LSSCgih309aCAodebM8t3DOkjUJfvUmxue7D/Djt4UZyyYHpS1hufDdH+6mVz46+asqhf3lllVw8OQ2rrGj0ZPnwU9I59pX7SAYFSym2pSin0F9APgVioFII3sybTzZaKDyCfttLgvdijtwZkWlAacyNJ6G647At16+HuDRiq+dkEkJB+2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k1FxynCb; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k1FxynCb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f0p9T6gvpz2xXB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2026 01:45:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D11C043965;
	Tue, 27 Jan 2026 14:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C21C116C6;
	Tue, 27 Jan 2026 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769525131;
	bh=0YGeP0O62Pc53bwcfFkz6Pdb1KEkMMpDyI0yE++MS9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k1FxynCbgFyhQaZBWbdQ3U3/gG7zvUiYTdT05s4SfRvueGwkwdMXfQ67RXYmWXNMt
	 nJcwbHtZ7igNbyW3UV297EDBMkUnggDFqkNCcRRA+vRpQtytrAnvyEHNrTU6qtdODo
	 1LbCma+SiMl2LT5ZuLyH7tZpYFN9UJ2XKhsK4xuHGPaRH8LD/O8BLUfTlNb0oHlPNi
	 O/otIJveig2kXrzcfYZMWTt5fvWceAjmmlhVGZjLExQFzzscRRARYyYJJl4ENA3zWK
	 zldlROZ0P7SlFX+FcV4aIGqzhLCTEzmtf2d26kCH+JflCjYXc+hEeq7F76jfRgZo4e
	 vcqAUDXHE61jQ==
Date: Tue, 27 Jan 2026 15:45:29 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
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
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/15] s390/time: Prepare to stop elapsing in
 dynticks-idle
Message-ID: <aXjPiZCHZ77R4awi@localhost.localdomain>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-6-frederic@kernel.org>
 <20260121121748.9719Bab-hca@linux.ibm.com>
 <aXEVM-04lj0lntMr@localhost.localdomain>
 <20260122144045.38254A3e-hca@linux.ibm.com>
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
In-Reply-To: <20260122144045.38254A3e-hca@linux.ibm.com>

Le Thu, Jan 22, 2026 at 03:40:45PM +0100, Heiko Carstens a écrit :
> On Wed, Jan 21, 2026 at 07:04:35PM +0100, Frederic Weisbecker wrote:
> > BTW here is a question for you, does the timer (as in get_cpu_timer()) still
> > decrements while in idle? I would assume not, given how lc->system_timer
> > is updated in account_idle_time_irq().
> 
> It is not decremented while in idle (or when the hypervisor schedules
> the virtual cpu away). We use the fact that the cpu timer is not
> decremented when the virtual cpu is not running vs the real
> time-of-day clock to calculate steal time.

Ok, good then!

> 
> > And another question in this same function is this :
> > 
> >     lc->steal_timer += idle->clock_idle_enter - lc->last_update_clock;
> > 
> > clock_idle_enter is updated right before halting the CPU. But when was
> > last_update_clock updated last? Could be either task switch to idle, or
> > a previous idle tick interrupt or a previous idle IRQ entry. In any case
> > I'm not sure the difference is meaningful as steal time.
> > 
> > I must be missing something.
> 
> "It has been like that forever" :) However I do agree that this doesn't seem
> to make any sense. At least with the current implementation I cannot see how
> that makes sense, since the difference of two time stamps, which do not
> include any steal time are added.
> 
> Maybe it broke by some of all the changes over the years, or it was always
> wrong, or I am missing something too.
> 
> Will investigate and address it if required. Thank you for bringing this up!

Ok, I take some relief from the fact it's not only unclear to me :-)

> 
> > > Not sure what to do with this. I thought about removing those sysfs files
> > > already in the past, since they are of very limited use; and most likely
> > > nothing in user space would miss them.
> > 
> > Perhaps but this file is a good comparison point against /proc/stat because
> > s390 vtime is much closer to measuring the actual CPU halted time than what
> > the generic nohz accounting does (which includes more idle code execution).
> 
> Yes, while comparing those files I also see an unexpected difference of
> several seconds after two days of uptime; that is before your changes.
> 
> In theory the sum of idle and iowait in /proc/stat should be the same like the
> per-cpu idle_time_us sysfs file. But there is a difference, which shouldn't be
> there as far as I can tell. Yet another thing to look into.

Yes and that's expected both before and after my changes.

* /proc/stat is the time spent between tick_nohz_idle_enter() and
  tick_nohz_idle_exit() (to simplify, because there are some pause during
  idle IRQs).

* The s390 idle sysfs file depicts more closely the time spent while the
  CPU is really idle (and not executing idle code).

Different semantics and this is why you observe different results. I guess
/proc/stat has higher values (with idle + iowait) and that is expected.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs


Return-Path: <linuxppc-dev+bounces-16020-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F263DD2ECF4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Jan 2026 22:08:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dw4NX3vT0z2xm3;
	Tue, 20 Jan 2026 09:08:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768860524;
	cv=none; b=d8FKx5grgsRs9yLQeSdnITrSJCGS3KWu5Ywf4lCVQNKnKgkLuZ/Y2DrNk3LgT7780LdfZvCpTwj5+C32Sd/6r0eRn8PBt1r86FDz5TxD8FHlJopz2Y8ChEDL8fRF8JLnyxMUTd3wfibwbFTUC25PfRWDU9qoVo7pFsihQGAZSD47WhP6xXMXP1N/3pshDde0v94hbT1AS0qbvWLL2z8XJGyTjKoYHMOxPsuOM18xftOPeW8XzyWimZCU6awoW0vPDtUAUPre19SW+/j09h9yGD6SNe5YL1sSYKlp0YI38OGxKPAvMrGpEmlZjpYdb+hes7mjoPAMJmAiasJK1cw+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768860524; c=relaxed/relaxed;
	bh=SJNq2/x5sjHSz6HiqdDHUTgFkNDziHsmNvCeQD3x6WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slb/s5/j6DJDf+EH17TVMwYQJJ48yJBp0J01sgRUS/X4myxYTseWUSCT1rtr2HOdU0EC8Z8U9nbtnJPUNhgP5EFQVVtHV+/LAhZRBMERkOcLYDFe8/mZ5QWGfLgBNd/c881tZeiW98UWUBeNcE+TsK/eU2KGkgDZBVA/d4e4MhzK2iVL6faqq4DgB24Ig7TiGfVviastXVVMS7eSCKb8hrdzJN10MNq5caMwiCkFSg0jjbLVcFhaAKJxJ/56CAqTVhxWuJwxmPQ6/v9OAQvfjKxEGH8QDZoV4KEbndNFQFCAT1s7yumTx8MQxk7+mk79WZEIGNUzthf1CFEsnYoICw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ln4zoHyb; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ln4zoHyb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dw4NW6lKyz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2026 09:08:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B431D60152;
	Mon, 19 Jan 2026 22:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FD9C116C6;
	Mon, 19 Jan 2026 22:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768860521;
	bh=Dq7zNmSBxvYzTIrpwfT5zYA1DLiTkgJDeC+0bnh2J04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ln4zoHybgtMECcMyqTx/LWGdBOdmyQ98YoneXE9EGheywR/7S8ye4vXbfT9yDYJEM
	 S5GlBxDyxN2QrdY7c7iUdriMrKmDEZBpK9EHhE1jbaNmzlOnl7z350fli+/P8io2cF
	 BlL2DPk7J60CaQUC2Km6nBry5cYb0NK5UjkImi23pySq3aKB1csMZTAtkiwI7nc68i
	 +xX9SF9/zKhiFtfJGgOYjnl4mOIthtugE+sTkgZMRaluThUrDaE53POwUX8EZ5fHui
	 cvMGnW5M89d38Q29Hn1c8PM0+KsTGcaISgLw9Zh2pdm/WWjfogFCxcUK7jWoyu3sSB
	 FeTFC8XVggahA==
Date: Mon, 19 Jan 2026 23:08:38 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH 09/15] tick/sched: Move dyntick-idle cputime accounting
 to cputime code
Message-ID: <aW6rZsjZidC6wXJS@pavilion.home>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-10-frederic@kernel.org>
 <20260119143552.GH830229@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260119143552.GH830229@noisy.programming.kicks-ass.net>

Le Mon, Jan 19, 2026 at 03:35:52PM +0100, Peter Zijlstra a écrit :
> On Fri, Jan 16, 2026 at 03:52:02PM +0100, Frederic Weisbecker wrote:
> 
> > +static void kcpustat_idle_stop(struct kernel_cpustat *kc, ktime_t now)
> >  {
> > +	u64 *cpustat = kc->cpustat;
> > +	ktime_t delta;
> > +
> > +	if (!kc->idle_elapse)
> > +		return;
> > +
> > +	delta = ktime_sub(now, kc->idle_entrytime);
> > +
> > +	write_seqcount_begin(&kc->idle_sleeptime_seq);
> > +	if (nr_iowait_cpu(smp_processor_id()) > 0)
> > +		cpustat[CPUTIME_IOWAIT] = ktime_add(cpustat[CPUTIME_IOWAIT], delta);
> > +	else
> > +		cpustat[CPUTIME_IDLE] = ktime_add(cpustat[CPUTIME_IDLE], delta);
> > +
> > +	kc->idle_entrytime = now;
> > +	kc->idle_elapse = false;
> > +	write_seqcount_end(&kc->idle_sleeptime_seq);
> >  }
> 
> I realize this is mostly code movement; but do we really want to
> preserve ktime_{sub,add}() and all that?
> 
> I mean, we killed that 32bit ktime nonsense ages ago.

Good point, this should just be u64.

Thanks!

-- 
Frederic Weisbecker
SUSE Labs


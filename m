Return-Path: <linuxppc-dev+bounces-16017-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FABD2ECE6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Jan 2026 21:35:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dw3fH6PPpz2xGF;
	Tue, 20 Jan 2026 08:35:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768858535;
	cv=none; b=G+NS2oeBC6svQChf9TN2eoN0DEAzhZ+wpRlYTt2z9vZLoJVdJqF1hTxo9w+FHGC8bLOsII2YPc+Lxr2cv4ExTnmrWwgBGigoVoXALwWFR6aJz5BMKZwzu9FcZvjrCQFRnkMSvzEiyCEXS/HFZWe+qKVctzKo4QMZpiMfjgxia/wphPhvpaMYlAG6P/o8Fir5xWoByTitG8AT0LzZn4jKyvXE+9dwwYM5BFSmy2R0J6jEdJGzfyITlD3BrChL7ekwwjOTnbcEo9xwqJ8ogFgU0D6DU9Pi/AC6v2P9XFEx5iTSvBVsA2mdmbP7Lr4/BXRaJkGs1ounGuM2Zuhrp3zbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768858535; c=relaxed/relaxed;
	bh=qDZUdLlg7ud9SDG6XgaztdpQT6xpx0vAtTEz0yLWTdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TumvrqggHqiMPhEhb2RKvVhL9fzgx1hhmcZ+Tbe9C298mj5mQgu/Q0Z0yUW5nkl8XKnAhyheR/CIgSZ+Ci1f0x9iM9nAG8O79E8zoQX+eEAP3PJUZLwylhja7Jxgo+baHmq7+n8/tBuIjqgqE+/N1DwRwp7vh996PW/eJs8OSq6jwU0gs32Wzt1y+5hKd7SKB3VFiUs3yEOsQas44RaTFQyYcD6/I04SSlnEL2BIIFUVS7941jyTu6NfY3EK2qRV9BzbT+qxmR2+MirKqPD+6iTz5Uo6nnlAiv7LQFXJ38UNcRQRCpF++24C1OsYLCOPFywMLXPDih/qK57FOWv5Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MSAIwNdQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MSAIwNdQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=frederic@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dw3fG5Dj2z2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2026 08:35:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 047A442E4D;
	Mon, 19 Jan 2026 21:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0C1C116C6;
	Mon, 19 Jan 2026 21:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768858532;
	bh=0p+D1qtaD6EK8C9QKDFoPkOIUPj6Z1i1of+RsQtd/cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSAIwNdQQpkp6oMgDpbCk+aNpAf6NI2V725snnSdP/1pmAdfS3Z0rJzX4h5DcxvFk
	 he5wkSyrVbdLVDRqeW60oboR/CVs8iv/ehVA9r3xvdBmgy+VucsNGLxHs3bUGOjD28
	 FmUsaMyToLjzkt3XEayVquD8ffomEAH717Qbbd/fRv1lL5ONzILiAlLSDK5Ns3beKx
	 Nox0RTElcLc12JWarif0zviVNfKUm5+4QlZHWp2xyULlMmJPnuQ8wl5WMeZVRinLNj
	 lJ2+BAmYoLVbh37cwBxVyrBaNv3562IluyDYvsPwtjLURINRBu+qCzcQJolzJWV2sW
	 SWlm3jQOOI5hA==
Date: Mon, 19 Jan 2026 22:35:30 +0100
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
Subject: Re: [PATCH 03/15] sched/cputime: Correctly support generic vtime
 idle time
Message-ID: <aW6johe2ZUR9l39Z@pavilion.home>
References: <20260116145208.87445-1-frederic@kernel.org>
 <20260116145208.87445-4-frederic@kernel.org>
 <20260119130222.GU830755@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260119130222.GU830755@noisy.programming.kicks-ass.net>

Le Mon, Jan 19, 2026 at 02:02:22PM +0100, Peter Zijlstra a écrit :
> On Fri, Jan 16, 2026 at 03:51:56PM +0100, Frederic Weisbecker wrote:
> 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 8ddf74e705d3..f1d07a0276a5 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -780,7 +780,7 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
> >  	ktime_t now, idle;
> >  	unsigned int seq;
> >  
> > -	if (!tick_nohz_active)
> > +	if (!tick_nohz_active || vtime_generic_enabled_cpu(cpu))
> >  		return -1;
> >  
> >  	now = ktime_get();
> 
> Is this not broken? IIUC this means that you can no longer use
> get_cpu_{idle,iowait}_time_us() the moment you have context tracking
> enabled.

It is supported again in patch 13/15. And it's not exactly breaking
bisection in the meantime because the sole user is cpufreq and cpufreq
shouldn't be relevant with nohz_full.

Ok a few subsystem rely on the resulting cpufreq API get_cpu_idle_time():

- the legacy drivers/macintosh/rack-meter.c
- drivers/scsi/lpfc/lpfc_init.c

But cpufreq provides a low-resolution version in the worst case for nohz_full
(again until 13/15).

Hmm, but you're right this is confusing. I think I should be able to fix that
in this patch.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs


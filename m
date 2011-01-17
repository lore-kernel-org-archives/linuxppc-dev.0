Return-Path: <scottwood@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71E0CB7137
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 04:33:09 +1100 (EST)
Date: Mon, 17 Jan 2011 11:32:50 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: perf: Fix frequency calculation for
	overflowing counters
Message-ID: <20110117113250.48098aaa@udp111988uds.am.freescale.net>
In-Reply-To: <20110117161742.5feb3761@kryten>
References: <20110117161742.5feb3761@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 17 Jan 2011 16:17:42 +1100
Anton Blanchard <anton@samba.org> wrote:

> 
> When profiling a benchmark that is almost 100% userspace, I noticed some
> wildly inaccurate profiles that showed almost all time spent in the kernel.
> Closer examination shows we were programming a tiny number of cycles into
> the PMU after each overflow (about ~200 away from the next overflow). This
> gets us stuck in a loop which we eventually break out of by throttling the
> PMU (there are regular throttle/unthrottle events in the log).
> 
> It looks like we aren't setting event->hw.last_period to something same
> and the frequency to period calculations in perf are going haywire. With
> the following patch we find the correct period after a few interrupts and
> stay there. I also see no more throttle events.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> diff --git a/arch/powerpc/kernel/perf_event.c b/arch/powerpc/kernel/perf_event.c
> index 5674807..ab6f6be 100644
> --- a/arch/powerpc/kernel/perf_event.c
> +++ b/arch/powerpc/kernel/perf_event.c
> @@ -1212,6 +1212,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
>  			if (left <= 0)
>  				left = period;
>  			record = 1;
> +			event->hw.last_period = event->hw.sample_period;
>  		}
>  		if (left < 0x80000000LL)
>  			val = 0x80000000LL - left;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

Does perf_event_fsl_emb.c need this as well (it has almost the same
record_and_restart code)?

-Scott

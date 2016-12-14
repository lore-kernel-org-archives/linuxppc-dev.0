Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdrYN0VhYzDvM9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 20:16:40 +1100 (AEDT)
Date: Wed, 14 Dec 2016 10:16:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [RFC 2/2] powerpc/8xx: Perf events on PPC 8xx
Message-ID: <20161214091629.GP3124@twins.programming.kicks-ass.net>
References: <cover.1481652710.git.christophe.leroy@c-s.fr>
 <8f8cb2298b929e0db5181c273b638ea6f5bf41e0.1481652710.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8f8cb2298b929e0db5181c273b638ea6f5bf41e0.1481652710.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 13, 2016 at 07:19:43PM +0100, Christophe Leroy wrote:
> +int mpc8xx_pmu_event_init(struct perf_event *event)
> +{
> +	int type = event_type(event);
> +
> +	switch (type) {
> +	case PERF_8xx_ID_CPU_CYCLES:
> +	case PERF_8xx_ID_ITLB_LOAD_MISS:
> +	case PERF_8xx_ID_DTLB_LOAD_MISS:
> +		break;
> +	case PERF_8xx_ID_HW_INSTRUCTIONS:
> +		mtspr(SPRN_CMPA, 0);

Should that not live in init_mpc8xx_pmu() ?

Afaict its a one time setup thing.

> +		break;
> +	default:
> +		return type;
> +	}
> +	return 0;
> +}
> +
> +int mpc8xx_pmu_add(struct perf_event *event, int flags)
> +{
> +	int type = event_type(event);
> +	s64 val;
> +
> +	switch (type) {
> +	case PERF_8xx_ID_CPU_CYCLES:
> +		val = get_tb();
> +		break;
> +	case PERF_8xx_ID_HW_INSTRUCTIONS:
> +		val = (instruction_counter << 16) | 0xffff;
> +		mtspr(SPRN_COUNTA, 0xffff0001);
> +		mtspr(SPRN_ICTRL, 0xc0080007);
> +		break;

So this sets up the counter and starts counting, right?

What happens if someone adds two events of this type?

Also, typical implementations would do:

	if (flags & PERF_EF_START)
		mpc8xx_pmu_start(event, flags);


> +	case PERF_8xx_ID_ITLB_LOAD_MISS:
> +		val = itlb_miss_counter;
> +		break;
> +	case PERF_8xx_ID_DTLB_LOAD_MISS:
> +		val = dtlb_miss_counter;
> +		break;
> +	default:
> +		break;
> +	}
> +	local64_set(&event->hw.prev_count, val);

Right, so aside from that INSTRUCTION event, the rest is treated like
freerunning counters which is fine.

> +	return 0;
> +}
> +
> +void mpc8xx_pmu_read(struct perf_event *event)
> +{
> +	int type = event_type(event);
> +	s64 prev, val, delta;
> +
> +	prev = local64_read(&event->hw.prev_count);
> +	switch (type) {
> +	case PERF_8xx_ID_CPU_CYCLES:
> +		val = get_tb();
> +		delta = 16 * (val - prev);
> +		break;
> +	case PERF_8xx_ID_HW_INSTRUCTIONS:
> +		mtspr(SPRN_ICTRL, 7);
> +		val = (instruction_counter << 16) | (0xffff - (mfspr(SPRN_COUNTA) >> 16));
> +		mtspr(SPRN_ICTRL, 0xc0080007);
> +		delta = val - prev;
> +		break;
> +	case PERF_8xx_ID_ITLB_LOAD_MISS:
> +		val = itlb_miss_counter;
> +		delta = val - prev;
> +		break;
> +	case PERF_8xx_ID_DTLB_LOAD_MISS:
> +		val = dtlb_miss_counter;
> +		delta = val - prev;
> +		break;
> +	default:
> +		break;
> +	}
> +	local64_set(&event->hw.prev_count, val);
> +	local64_add(delta, &event->count);
> +}

So there is one case, where we group this event with a software hrtimer
event and the hrtimer would call ::read() from interrupt context while
you're already in ::read().

This seems to suggest you still need a cmpxchg() loop to update, no?

> +void mpc8xx_pmu_del(struct perf_event *event, int flags)
> +{
> +	int type = event_type(event);
> +	s64 prev, val;
> +
> +	prev = local64_read(&event->hw.prev_count);
> +	switch (type) {
> +	case PERF_8xx_ID_HW_INSTRUCTIONS:
> +		mtspr(SPRN_ICTRL, 7);
> +		val = (instruction_counter << 16) | (0xffff - (mfspr(SPRN_COUNTA) >> 16));
> +		local64_add(val - prev, &event->count);
> +		break;
> +	case PERF_8xx_ID_CPU_CYCLES:
> +	case PERF_8xx_ID_ITLB_LOAD_MISS:
> +	case PERF_8xx_ID_DTLB_LOAD_MISS:
> +		mpc8xx_pmu_read(event);
> +		break;
> +	default:
> +		break;
> +	}

Right, so you make all del()'s imply PERF_EF_UPDATE, which is fine.

> +}
> +
> +void mpc8xx_pmu_start(struct perf_event *event, int flags)
> +{
> +}
> +
> +void mpc8xx_pmu_stop(struct perf_event *event, int flags)
> +{
> +}

So I think you can get away with doing this because the PMU doesn't do
sampling, which is what would normally start/stop already programmed
counters.

> +static struct pmu mpc8xx_pmu = {
> +	.event_init	= mpc8xx_pmu_event_init,
> +	.add		= mpc8xx_pmu_add,
> +	.del		= mpc8xx_pmu_del,
> +	.start		= mpc8xx_pmu_start,
> +	.stop		= mpc8xx_pmu_stop,
> +	.read		= mpc8xx_pmu_read,

	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT |
			  PERF_PMU_CAP_NO_NMI,

> +};
> +
> +static int init_mpc8xx_pmu(void)
> +{
> +	return perf_pmu_register(&mpc8xx_pmu, "cpu", PERF_TYPE_RAW);
> +}
> +
> +early_initcall(init_mpc8xx_pmu);

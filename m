Return-Path: <jolsa@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0DEE1A0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 23:39:57 +1000 (EST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 49477140084
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2014 23:39:57 +1000 (EST)
Date: Wed, 18 Jun 2014 15:39:37 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 1/2]: Allow architectures to skip a callchain entry
Message-ID: <20140618133937.GC9865@krava.brq.redhat.com>
References: <20140606032109.GA16600@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140606032109.GA16600@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 michael@ellerman.id.au, Ulrich.Weigand@de.ibm.com,
 Maynard Johnson <mpjohn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2014 at 08:21:09PM -0700, Sukadev Bhattiprolu wrote:

SNIP

> index 7409ac8..3f97cf2 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1288,8 +1288,10 @@ static int machine__resolve_callchain_sample(struct machine *machine,
>  {
>  	u8 cpumode = PERF_RECORD_MISC_USER;
>  	int chain_nr = min(max_stack, (int)chain->nr);
> +	enum chain_order order = callchain_param.order;
>  	int i;
>  	int err;
> +	int skip_idx;
>  
>  	callchain_cursor_reset(&callchain_cursor);
>  
> @@ -1298,14 +1300,13 @@ static int machine__resolve_callchain_sample(struct machine *machine,
>  		return 0;
>  	}
>  
> +	skip_idx = arch_skip_callchain_idx(machine, thread, chain);
> +
>  	for (i = 0; i < chain_nr; i++) {
>  		u64 ip;
>  		struct addr_location al;
>  
> -		if (callchain_param.order == ORDER_CALLEE)
> -			ip = chain->ips[i];
> -		else
> -			ip = chain->ips[chain->nr - i - 1];
> +		ip = next_callchain_ip(chain, order, i, skip_idx);

hum, I still dont see a point of adding new user
enum API (PERF_CONTEXT_IGNORE) when we can just do:

		#ifdef HAVE_SKIP_CALLCHAIN_IDX
			if (idx == skip_idx)
				continue;
		#endif

		if (callchain_param.order == ORDER_CALLEE)
			ip = chain->ips[i];
		else
			ip = chain->ips[chain->nr - i - 1];


jirka

>  
>  		if (ip >= PERF_CONTEXT_MAX) {
>  			switch (ip) {
> @@ -1318,6 +1319,8 @@ static int machine__resolve_callchain_sample(struct machine *machine,
>  			case PERF_CONTEXT_USER:
>  				cpumode = PERF_RECORD_MISC_USER;
>  				break;
> +			case PERF_CONTEXT_IGNORE:
> +				break;
>  			default:
>  				pr_debug("invalid callchain context: "
>  					 "%"PRId64"\n", (s64) ip);
> -- 
> 1.7.9.5
> 

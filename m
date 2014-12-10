Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 753371A0270
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 21:17:21 +1100 (AEDT)
Message-ID: <1418206640.9279.10.camel@ellerman.id.au>
Subject: Re: [RFC PATCH 7/8] perf probe powerpc: Use DWARF info only if
 necessary
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Date: Wed, 10 Dec 2014 21:17:20 +1100
In-Reply-To: <50dd0fedb50e3a56ff8f25c44098db3e2a2d6374.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <50dd0fedb50e3a56ff8f25c44098db3e2a2d6374.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-09 at 23:04 +0530, Naveen N. Rao wrote:
> Use symbol table lookups by default if DWARF is not necessary, since
> powerpc ABIv2 encodes local entry points in the symbol table and the
> function entry address in DWARF may not be appropriate for kprobes,
> as described here:
> https://sourceware.org/bugzilla/show_bug.cgi?id=17638

Needs a better changelog.

> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 174c22e..adcdbd2 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2382,6 +2382,14 @@ static int convert_to_probe_trace_events(struct perf_probe_event *pev,
>  		}
>  	}
>  
> +#if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2
> +	if (!perf_probe_event_need_dwarf(pev)) {
> +		ret = find_probe_trace_events_from_map(pev, tevs, max_tevs, target);
> +		if (ret > 0)
> +			return ret;	/* Found in symbol table */
> +	}
> +#endif

And should be in an arch helper, not a big powerpc wart dropped in the middle
of the generic code.

cheers

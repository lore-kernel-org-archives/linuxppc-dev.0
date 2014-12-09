Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.19.201])
 by lists.ozlabs.org (Postfix) with ESMTP id AEF6A1A0622
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 08:14:04 +1100 (AEDT)
Date: Tue, 9 Dec 2014 18:14:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 8/8] perf probe powerpc: Fixup function entry if
 using kallsyms lookup
Message-ID: <20141209211400.GB8788@kernel.org>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <e5bfde8d51546041e50699c4ed3bad8c3c1bf84f.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e5bfde8d51546041e50699c4ed3bad8c3c1bf84f.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Tue, Dec 09, 2014 at 11:04:06PM +0530, Naveen N. Rao escreveu:
> On powerpc ABIv2, if no debug-info is found and we use kallsyms,
> we need to fixup the function entry to point to the local entry point.
> Use offset of 8 since current toolchains always generate 2
> instructions (8 bytes).

Hi Michael and Ananth, may I have your Acked-by or Reviewed-by for these
patches?

The ones, like this, that are affects only ppc I'm can assume was tested
and applying it won't break other arch users, but having a/rev-by from
ppc developers should speed up this process.

Thanks,

- Arnaldo
 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/util/probe-event.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index adcdbd2..0970e2a 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2318,6 +2318,15 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
>  		}
>  		/* Add one probe point */
>  		tp->address = map->unmap_ip(map, sym->start) + pp->offset;
> +#if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2
> +		/*
> +		 * If we used kallsyms, we should fixup the function entry address here.
> +		 * ppc64le ABIv2 local entry point is currently always 2 instructions (8 bytes)
> +		 * after the global entry point. Fix this if it ever changes.
> +		 */
> +		if (!pev->uprobes && map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
> +			tp->address += 8;
> +#endif
>  		if (reloc_sym) {
>  			tp->symbol = strdup_or_goto(reloc_sym->name, nomem_out);
>  			tp->offset = tp->address - reloc_sym->addr;
> -- 
> 2.1.3

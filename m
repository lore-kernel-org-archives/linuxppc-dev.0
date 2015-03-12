Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id ACE511A04B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 07:37:15 +1100 (AEDT)
Date: Thu, 12 Mar 2015 17:37:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCHv2 8/8] perf probe powerpc: Fixup function entry if using
 kallsyms lookup
Message-ID: <20150312203711.GI3550@kernel.org>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
 <e27b74c5d94b240cb72ce0c7d6221acf758ebc8a.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e27b74c5d94b240cb72ce0c7d6221acf758ebc8a.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Dec 15, 2014 at 08:20:38PM +0530, Naveen N. Rao escreveu:
> On powerpc ABIv2, if no debug-info is found and we use kallsyms, we need
> to fixup the function entry to point to the local entry point. Use
> offset of 8 since current toolchains always generate 2 instructions (8
> bytes).
 

So perhaps we should rename ARCH_SYMBOL_HANDLING to ARCH_ABI_SYMBOL_FIXUPS?

> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Changes:
> Generalize and introduce helper to post-process trace point.
> 
>  tools/perf/arch/powerpc/util/sym-handling.c | 17 +++++++++++++++++
>  tools/perf/util/probe-event.c               |  1 +
>  tools/perf/util/probe-event.h               | 10 ++++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
> index 22fc2e6..30c8797 100644
> --- a/tools/perf/arch/powerpc/util/sym-handling.c
> +++ b/tools/perf/arch/powerpc/util/sym-handling.c
> @@ -45,3 +45,20 @@ inline bool prefer_symtab(void)
>  	return false;
>  #endif
>  }
> +
> +void arch_fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
> +			    struct probe_trace_event *tev __maybe_unused,
> +			    struct map *map __maybe_unused)
> +{
> +#if defined(_CALL_ELF) && _CALL_ELF == 2
> +	/*
> +	 * If we used kallsyms, we should fixup the function entry address here.
> +	 * ppc64 ABIv2 local entry point is currently always 2 instructions (8 bytes)
> +	 * after the global entry point. Fix this if it ever changes.
> +	 */
> +	if (!pev->uprobes && map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS) {
> +		tev->point.address += 8;
> +		tev->point.offset += 8;
> +	}
> +#endif
> +}
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index dfc3151..85f37a4 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2340,6 +2340,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
>  					strdup_or_goto(pev->args[i].type,
>  							nomem_out);
>  		}
> +		arch_fix_tev_from_maps(pev, tev, map);
>  	}
>  
>  out:
> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
> index 5f92906..335a6a4 100644
> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -147,6 +147,16 @@ extern bool prefer_symtab(void);
>  static inline bool prefer_symtab(void) { return false; };
>  #endif
>  
> +#ifdef HAVE_ARCH_SYMBOL_HANDLING
> +extern void arch_fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
> +				   struct probe_trace_event *tev __maybe_unused,
> +				   struct map *map __maybe_unused);
> +#else
> +static inline void arch_fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
> +					  struct probe_trace_event *tev __maybe_unused,
> +					  struct map *map __maybe_unused) { }
> +#endif
> +
>  /* Maximum index number of event-name postfix */
>  #define MAX_EVENT_INDEX	1024
>  
> -- 
> 2.1.3

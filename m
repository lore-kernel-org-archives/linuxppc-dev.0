Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id E4B9C1A0407
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 07:35:05 +1100 (AEDT)
Date: Thu, 12 Mar 2015 17:35:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCHv2 6/8] perf tools powerpc: Fix PPC64 ELF ABIv2 symbol
 decoding
Message-ID: <20150312203500.GH3550@kernel.org>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
 <c81364f6bd46c9ab9074fcb107fccf7de63cc56e.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c81364f6bd46c9ab9074fcb107fccf7de63cc56e.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Dec 15, 2014 at 08:20:36PM +0530, Naveen N. Rao escreveu:
> PPC64 ELF ABIv2 has a Global Entry Point (GEP) and a Local Entry Point
> (LEP). For purposes of probing, we need the LEP. Offset to the LEP is
> encoded in st_other.
> 
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Changes from previous patchset:
> Simplified logic by adding dependancy on HAVE_ARCH_SYMBOL_HANDLING. Also
> generalized arch_elf_sym_decode() to be suitable for other architectures in
> future.
> 
>  tools/perf/arch/powerpc/util/sym-handling.c | 10 ++++++++++
>  tools/perf/util/symbol-elf.c                |  2 ++
>  tools/perf/util/symbol.h                    |  6 ++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
> index 0a77825..a27bfaf 100644
> --- a/tools/perf/arch/powerpc/util/sym-handling.c
> +++ b/tools/perf/arch/powerpc/util/sym-handling.c
> @@ -1,8 +1,10 @@
>  /*
>   * Special symbol handling for PowerPC:
>   * - Handle dot symbols on ABIv1
> + * - Decode offset from Global entry point to Local entry point on ABIv2
>   *
>   * Copyright (C) 2014 Naveen N Rao, IBM Corporation.
> + * Copyright (C) 2014 Ananth N Mavinakayanahalli, IBM Corporation.
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
> @@ -26,3 +28,11 @@ int probe_function_filter(struct map *map __maybe_unused, struct symbol *sym)
>  	}
>  	return 1;
>  }
> +
> +inline void arch_elf_sym_decode(GElf_Sym *sym __maybe_unused)
> +{
> +#if defined(_CALL_ELF) && _CALL_ELF == 2
> +	if (sym && sym->st_other)
> +		sym->st_value += PPC64_LOCAL_ENTRY_OFFSET(sym->st_other);
> +#endif
> +}
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 7ac4e4c..557b63b 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -902,6 +902,8 @@ int dso__load_sym(struct dso *dso, struct map *map,
>  		    (sym.st_value & 1))
>  			--sym.st_value;
>  
> +		arch_elf_sym_decode(&sym);
> +

arch_elf_sym_adjust()? 

But this is done the right way, i.e. provide a way for arches to do
adjustments specific to their ABIs, thanks!

- Arnaldo

>  		if (dso->kernel || kmodule) {
>  			char dso_name[PATH_MAX];
>  
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 9d602e9..9e03cdf 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -294,4 +294,10 @@ int compare_proc_modules(const char *from, const char *to);
>  int setup_list(struct strlist **list, const char *list_str,
>  	       const char *list_name);
>  
> +#ifdef HAVE_ARCH_SYMBOL_HANDLING
> +extern void arch_elf_sym_decode(GElf_Sym *sym __maybe_unused);
> +#else
> +static inline void arch_elf_sym_decode(GElf_Sym *sym __maybe_unused) { }
> +#endif
> +
>  #endif /* __PERF_SYMBOL */
> -- 
> 2.1.3

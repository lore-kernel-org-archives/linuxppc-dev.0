Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdVFd1tkgzDqYs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 21:32:04 +1100 (AEDT)
Date: Wed, 8 Mar 2017 11:31:56 +0100
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar
 <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5 5/5] perf: powerpc: choose local entry point with
 kretprobes
Message-Id: <20170308113156.05692fd7a012ca3f647ed594@kernel.org>
In-Reply-To: <7445b5334673ef5404ac1d12609bad4d73d2b567.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
 <7445b5334673ef5404ac1d12609bad4d73d2b567.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  8 Mar 2017 13:56:10 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> perf now uses an offset from _text/_stext for kretprobes if the kernel
> supports it, rather than the actual function name. As such, let's choose
> the LEP for powerpc ABIv2 so as to ensure the probe gets hit. Do it only
> if the kernel supports specifying offsets with kretprobes.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

This patch is OK. And I found that most of functions in sym-handling.c
are used only when libelf is supported. (e.g. probe-event.c itself
is not built when we have no libelf)
So, for the next cleanup, this file should not be compiled without
libelf.

Thanks!

> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/sym-handling.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
> index 1030a6e504bb..39dbe512b9fc 100644
> --- a/tools/perf/arch/powerpc/util/sym-handling.c
> +++ b/tools/perf/arch/powerpc/util/sym-handling.c
> @@ -10,6 +10,7 @@
>  #include "symbol.h"
>  #include "map.h"
>  #include "probe-event.h"
> +#include "probe-file.h"
>  
>  #ifdef HAVE_LIBELF_SUPPORT
>  bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
> @@ -79,13 +80,18 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
>  	 * However, if the user specifies an offset, we fall back to using the
>  	 * GEP since all userspace applications (objdump/readelf) show function
>  	 * disassembly with offsets from the GEP.
> -	 *
> -	 * In addition, we shouldn't specify an offset for kretprobes.
>  	 */
> -	if (pev->point.offset || (!pev->uprobes && pev->point.retprobe) ||
> -	    !map || !sym)
> +	if (pev->point.offset || !map || !sym)
>  		return;
>  
> +	/* For kretprobes, add an offset only if the kernel supports it */
> +	if (!pev->uprobes && pev->point.retprobe) {
> +#ifdef HAVE_LIBELF_SUPPORT
> +		if (!kretprobe_offset_is_supported())
> +#endif
> +			return;
> +	}
> +
>  	lep_offset = PPC64_LOCAL_ENTRY_OFFSET(sym->arch_sym);
>  
>  	if (map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
> -- 
> 2.11.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

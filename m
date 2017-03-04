Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZnXw4XD1zDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Mar 2017 11:50:56 +1100 (AEDT)
Date: Sat, 4 Mar 2017 09:50:44 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ananth N
 Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 3/3] perf: powerpc: choose local entry point with
 kretprobes
Message-Id: <20170304095044.7f82f3952f34ea6e1ae93a45@kernel.org>
In-Reply-To: <9de477aa0064e0a066146be5b3629615b8957960.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
 <9de477aa0064e0a066146be5b3629615b8957960.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu,  2 Mar 2017 23:25:07 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> perf now uses an offset from _text/_stext for kretprobes if the kernel
> supports it, rather than the actual function name. As such, let's choose
> the LEP for powerpc ABIv2 so as to ensure the probe gets hit. Do it only
> if the kernel supports specifying offsets with kretprobes.

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/sym-handling.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
> index 1030a6e504bb..cc7c2697c036 100644
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
> @@ -79,11 +80,12 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
>  	 * However, if the user specifies an offset, we fall back to using the
>  	 * GEP since all userspace applications (objdump/readelf) show function
>  	 * disassembly with offsets from the GEP.
> -	 *
> -	 * In addition, we shouldn't specify an offset for kretprobes.
>  	 */
> -	if (pev->point.offset || (!pev->uprobes && pev->point.retprobe) ||
> -	    !map || !sym)
> +	if (pev->point.offset || !map || !sym)
> +		return;
> +
> +	/* For kretprobes, add an offset only if the kernel supports it */
> +	if (!pev->uprobes && pev->point.retprobe && !kretprobe_offset_is_supported())
>  		return;
>  
>  	lep_offset = PPC64_LOCAL_ENTRY_OFFSET(sym->arch_sym);
> -- 
> 2.11.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

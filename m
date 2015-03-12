Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 168601A0407
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 07:23:47 +1100 (AEDT)
Date: Thu, 12 Mar 2015 17:23:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCHv2 3/8] perf probe powerpc: Fix symbol fixup issues due to
 ELF type
Message-ID: <20150312202340.GC3550@kernel.org>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
 <a31f3cfd0841bea8e615ebd6f8f0ec5a0d1f1eaa.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a31f3cfd0841bea8e615ebd6f8f0ec5a0d1f1eaa.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Dec 15, 2014 at 08:20:33PM +0530, Naveen N. Rao escreveu:
> If using the symbol table, symbol addresses are not being fixed up
> properly, resulting in probes being placed at wrong addresses:
> 
>   # perf probe do_fork
>   Added new event:
>     probe:do_fork        (on do_fork)
> 
>   You can now use it in all perf tools, such as:
> 
> 	  perf record -e probe:do_fork -aR sleep 1
> 
>   # cat /sys/kernel/debug/tracing/kprobe_events
>   p:probe/do_fork _text+635952
>   # printf "%x" 635952
>   9b430
>   # grep do_fork /boot/System.map
>   c0000000000ab430 T .do_fork
> 
> Fix by checking for ELF type ET_DYN used by ppc64 kernels.

Sorry if this was answered already, its been a while since this was
posted/discussed... Are you completely sure this is not a problem on
!ppc?

Woudln't it be more conservative to somehow only adjust symbols for this
ET_DYN type if the arch is ppc? I.e. something like moving that
adjust_symbols logic to be arch_adjust_symbols(), provide a default and
then override it for ppc to include also ET_DYN?

Looking at the other patches...

- Arnaldo
 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/util/symbol-elf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 06fcd1b..7ac4e4c 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -683,7 +683,8 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
>  						     NULL) != NULL);
>  	} else {
>  		ss->adjust_symbols = ehdr.e_type == ET_EXEC ||
> -				     ehdr.e_type == ET_REL;
> +				     ehdr.e_type == ET_REL ||
> +				     ehdr.e_type == ET_DYN;
>  	}
>  
>  	ss->name   = strdup(name);
> -- 
> 2.1.3

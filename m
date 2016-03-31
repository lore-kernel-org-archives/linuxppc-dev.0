Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbJ2d6cS1zDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 19:43:53 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 31 Mar 2016 18:43:52 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 60C2A3578058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 19:43:48 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2V8he7C64028712
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 19:43:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2V8hFSp022457
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 19:43:16 +1100
Date: Thu, 31 Mar 2016 14:12:26 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [RFC PATCH 2/2] tools/perf: Change how probe offsets are handled
Message-ID: <20160331084226.GB17907@naverao1-tp.ibm.com>
References: <55e87f5862086492c1465d70f86b724e5029be6a.1459354581.git.naveen.n.rao@linux.vnet.ibm.com>
 <66ea9420976071558fa0c1a3a891f29f720826d0.1459354581.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <66ea9420976071558fa0c1a3a891f29f720826d0.1459354581.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/03/30 10:13PM, Naveen N Rao wrote:
> While trying to address the kallsyms perf test failure on ppc64le,
> Ananth noticed that we were not necessarily probing at the expected
> address when an offset to the function was specified.
> 
> So far, we used to treat probe point offsets as being offset from the
> LEP. However, userspace applications (objdump/readelf) always show
> disassembly and offsets from the function GEP. This is confusing to the
> user. Fix this by changing how we modify probe address with perf.
> 
> If only the function name is provided, we assume the user needs the LEP.
> Otherwise, if an offset is specified, we assume that the user knows the
> exact address to probe based on function disassembly, and so we just
> place the probe from the GEP offset.
> 
> Tested lightly. Needs more testing.
> 
> Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/sym-handling.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
> index 3e98a61..36f6eb0 100644
> --- a/tools/perf/arch/powerpc/util/sym-handling.c
> +++ b/tools/perf/arch/powerpc/util/sym-handling.c
> @@ -65,16 +65,23 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
>  			     struct probe_trace_event *tev, struct map *map,
>  			     struct symbol *sym)
>  {
> +	int lep_offset = PPC64_LOCAL_ENTRY_OFFSET(sym->elf_st_other);
> +
>  	/*
>  	 * ppc64 ABIv2 local entry point is currently always 2 instructions
> -	 * (8 bytes) after the global entry point.
> +	 * (8 bytes) after the global entry point. When probing at a function
> +	 * entry point, we normally always want the LEP since that catches calls
> +	 * to the function through both the GEP and the LEP. However, if the user
> +	 * specifies an offset, we fall back to using the GEP since all userspace
> +	 * applications (objdump/readelf) show function disassembly with offsets
> +	 * from the GEP.
>  	 */
> -	if (!pev->uprobes && map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS) {
> -		tev->point.address += PPC64LE_LEP_OFFSET;
> +	if (pev->point.offset)

This needs to be:
	if (pev->point.offset || pev->point.retprobe)
		return;

kretprobes fails otherwise.


- Naveen

> +		return;
> +
> +	if (!pev->uprobes && map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
>  		tev->point.offset += PPC64LE_LEP_OFFSET;
> -	} else if (PPC64_LOCAL_ENTRY_OFFSET(sym->elf_st_other)) {
> -		tev->point.address += PPC64_LOCAL_ENTRY_OFFSET(sym->elf_st_other);
> -		tev->point.offset += PPC64_LOCAL_ENTRY_OFFSET(sym->elf_st_other);
> -	}
> +	else if (lep_offset)
> +		tev->point.offset += lep_offset;
>  }
>  #endif
> -- 
> 2.7.4
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

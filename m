Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yZYNM5zmGzDsQ3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 23:43:31 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/8] powerpc/mm: Separate ibm,
 dynamic-memory data from DT format
In-Reply-To: <150850572658.9118.9227271506499547385.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
References: <150850568437.9118.13945089249591962212.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <150850572658.9118.9227271506499547385.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Date: Sun, 12 Nov 2017 23:43:30 +1100
Message-ID: <87vaifwtu5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nathan,

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index f83056297441..917184c13890 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -454,92 +455,93 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
...
>  
>  static int __init early_init_dt_scan_memory_ppc(unsigned long node,
>  						const char *uname,
>  						int depth, void *data)
>  {
> +	int rc;
> +
>  	if (depth == 1 &&
> -	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0)
> -		return early_init_dt_scan_drconf_memory(node);
> +	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
> +		rc = init_drmem_lmbs(node);
> +		if (!rc)
> +			early_init_dt_scan_drmem_lmbs(node);
> +
> +		return rc;
> +	}
>  	
>  	return early_init_dt_scan_memory(node, uname, depth, data);
>  }

There's one bug in here which is that you return rc as returned by
init_drmem_lmbs(). Returning non-zero from these scan routines
terminates the scan, which means if anything goes wrong in
init_drmem_lmbs() we may not call early_init_dt_scan_memory()
in which case we won't have any memory at all.

I say "may not" because it depends on the order of the nodes in the
device tree whether you hit the memory nodes or the dynamic reconfig mem
info first. And the order of the nodes in the device tree is arbitrary
so we can't rely on that.


> diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
> new file mode 100644
> index 000000000000..8ad7cf36b2c4
> --- /dev/null
> +++ b/arch/powerpc/mm/drmem.c
> @@ -0,0 +1,84 @@
...
> +
> +int __init init_drmem_lmbs(unsigned long node)
> +{
> +	struct drmem_lmb *lmb;
> +	const __be32 *prop;
> +	int prop_sz;
> +	u32 len;
> +
> +	prop = of_get_flat_dt_prop(node, "ibm,lmb-size", &len);
> +	if (!prop || len < dt_root_size_cells * sizeof(__be32))
> +		return -1;
> +
> +	drmem_info->lmb_size = dt_mem_next_cell(dt_root_size_cells, &prop);
> +
> +	prop = of_get_flat_dt_prop(node, "ibm,dynamic-memory", &len);
> +	if (!prop || len < dt_root_size_cells * sizeof(__be32))
> +		return -1;
> +
> +	drmem_info->n_lmbs = of_read_number(prop++, 1);
> +	prop_sz = drmem_info->n_lmbs * sizeof(struct of_drconf_cell)
> +		  + sizeof(__be32);
> +	if (prop_sz < len)
> +		return -1;
> +
> +	drmem_info->lmbs = alloc_bootmem(drmem_info->n_lmbs * sizeof(*lmb));
> +	if (!drmem_info->lmbs)
> +		return -1;

The bigger problem we have though is that you're trying to allocate
memory, in order to find out what memory we have :)

I suspect it works in some cases because you hit the memory@0 node first
in the device tree, and add that memory to memblock, which means
init_drmem_lmbs() *can* allocate memory, and everything's good.

But if we hit init_drmem_lmbs() first, or there's not enough space in
memory@0, then allocating memory in order to discover memory is not
going to work.

I'm not sure what the best solution is. One option would be to
statically allocate some space, so that we can discover some of the LMBs
without doing an allocation. But we wouldn't be able to guarantee that
we had enough space i nthat static allocation, so the code would need to
handle doing that and then potentially finding more LMBs later using a
dynamic alloc. So that could be a bit messy.

The other option would be for the early_init_dt_scan_drmem_lmbs() code
to still work on the device tree directly, rather than using the
drmem_info array. That would make for uglier code, but may be necessary.

cheers

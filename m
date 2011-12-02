Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2ABF5B6F64
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 12:28:56 +1100 (EST)
Message-ID: <1322789207.3729.45.camel@pasglop>
Subject: Re: [PATCH][v2] Enable CONFIG_STRICT_DEVMEM support for Powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 02 Dec 2011 12:26:47 +1100
In-Reply-To: <20111202001141.GA14860@us.ibm.com>
References: <20111202001141.GA14860@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sbest@us.ibm.com, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

And an additional comment regarding the rtas bit:

>  #ifdef CONFIG_PPC_SMLPAR
>  void arch_free_page(struct page *page, int order);
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index d5ca823..07cf2cf 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -937,6 +937,16 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
>  	return 0;
>  }
>  
> +int page_is_rtas(unsigned long pfn)
> +{
> +	unsigned long paddr = (pfn << PAGE_SHIFT);
> +
> +	if (paddr >= rtas_rmo_buf && paddr < (rtas_rmo_buf + RTAS_RMOBUF_MAX))
> +		return 1;
> +
> +	return 0;
> +}

So this only exist whenever rtas.c is compiled... but ...

> +
>  /*
>   * Call early during boot, before mem init or bootmem, to retrieve the RTAS
>   * informations from the device-tree and allocate the RMO buffer for userland
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index c781bbc..d21dbc6 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -549,3 +549,23 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
>  	hash_preload(vma->vm_mm, address, access, trap);
>  #endif /* CONFIG_PPC_STD_MMU */
>  }
> +
> +extern int page_is_rtas(unsigned long pfn);
> +
> +/*
> + * devmem_is_allowed(): check to see if /dev/mem access to a certain address
> + * is valid. The argument is a physical page number.
> + *
> + * Access has to be given to non-kernel-ram areas as well, these contain the
> + * PCI mmio resources as well as potential bios/acpi data regions.
> + */
> +int devmem_is_allowed(unsigned long pfn)
> +{
> +	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
> +		return 0;
> +	if (!page_is_ram(pfn))
> +		return 1;
> +	if (page_is_rtas(pfn))
> +		return 1;
> +	return 0;
> +}

This calls it unconditionally... you just broke the build of all !rtas
platforms. Additionally, putting an extern definition like that in a .c
file is gross at best....

Please instead, put in a header something like

#ifdef CONFIG_PPC_RTAS
extern int page_is_rtas(unsigned long pfn);
#else
static inline int page_is_rtas(unsigned long pfn) { }
#endif

And while at it, call it page_is_rtas_user_buf(); to make it clear what
we are talking about, ie, not RTAS core per-se but specifically the RMO
buffer.

Cheers,
Ben.

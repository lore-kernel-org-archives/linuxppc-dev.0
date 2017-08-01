Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMQpb0ZmbzDrDb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 05:08:54 +1000 (AEST)
Subject: Re: [PATCH v1 1/3] arch/powerpc/set_memory: Implement set_memory_xx
 routines
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <20170801112535.20765-1-bsingharora@gmail.com>
 <20170801112535.20765-2-bsingharora@gmail.com>
Cc: naveen.n.rao@linux.vnet.ibm.com
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <c0303243-e20a-a2ee-7d5c-7660c10daedc@c-s.fr>
Date: Tue, 1 Aug 2017 21:08:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170801112535.20765-2-bsingharora@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 01/08/2017 à 13:25, Balbir Singh a écrit :
> Add support for set_memory_xx routines. With the STRICT_KERNEL_RWX
> feature support we got support for changing the page permissions
> for pte ranges. This patch adds support for both radix and hash
> so that we can change their permissions via set/clear masks.
>
> A new helper is required for hash (hash__change_memory_range()
> is changed to hash__change_boot_memory_range() as it deals with
> bolted PTE's).
>
> hash__change_memory_range() works with vmalloc'ed PAGE_SIZE requests
> for permission changes. hash__change_memory_range() does not invoke
> updatepp, instead it changes the software PTE and invalidates the PTE.
>
> For radix, radix__change_memory_range() is setup to do the right
> thing for vmalloc'd addresses. It takes a new parameter to decide
> what attributes to set.
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash.h  |  6 +++
>  arch/powerpc/include/asm/book3s/64/radix.h |  6 +++
>  arch/powerpc/include/asm/set_memory.h      | 34 +++++++++++++++
>  arch/powerpc/mm/pgtable-hash64.c           | 51 ++++++++++++++++++++--
>  arch/powerpc/mm/pgtable-radix.c            | 26 ++++++------
>  arch/powerpc/mm/pgtable_64.c               | 68 ++++++++++++++++++++++++++++++
>  6 files changed, 175 insertions(+), 16 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/set_memory.h
>

[...]

> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index 0736e94..3ee4c7d 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -514,3 +514,71 @@ void mark_initmem_nx(void)
>  		hash__mark_initmem_nx();
>  }
>  #endif
> +
> +#ifdef CONFIG_ARCH_HAS_SET_MEMORY
> +/*
> + * Some of these bits are taken from arm64/mm/page_attr.c
> + */
> +static int change_memory_common(unsigned long addr, int numpages,
> +				unsigned long set, unsigned long clear)
> +{
> +	unsigned long start = addr;
> +	unsigned long size = PAGE_SIZE*numpages;
> +	unsigned long end = start + size;
> +	struct vm_struct *area;
> +
> +	if (!PAGE_ALIGNED(addr)) {
> +		start &= PAGE_MASK;
> +		end = start + size;
> +		WARN_ON_ONCE(1);
> +	}

Why not just set start = addr & PAGE_MASK, then just do 
WARN_ON_ONCE(start != addr), instead of that if ()

> +
> +	/*
> +	 * So check whether the [addr, addr + size) interval is entirely
> +	 * covered by precisely one VM area that has the VM_ALLOC flag set.
> +	 */
> +	area = find_vm_area((void *)addr);
> +	if (!area ||
> +	    end > (unsigned long)area->addr + area->size ||
> +	    !(area->flags & VM_ALLOC))
> +		return -EINVAL;
> +
> +	if (!numpages)
> +		return 0;

Shouldn't that be tested earlier ?

> +
> +	if (radix_enabled())
> +		return radix__change_memory_range(start, start + size,
> +							set, clear);
> +	else
> +		return hash__change_memory_range(start, start + size,
> +							set, clear);
> +}

The following functions should go in a place common to PPC32 and PPC64, 
otherwise they will have to be duplicated when implementing for PPC32.
Maybe the above function should also go in a common place, only the last 
part should remain in a PPC64 dedicated part. It could be called 
change_memory_range(), something like

int change_memory_range(unsigned long start, unsigned long end,
			unsigned long set, unsigned long clear)
{
	if (radix_enabled())
		return radix__change_memory_range(start, end,
						  set, clear);
	return hash__change_memory_range(start, end, set, clear);
}

Then change_memory_range() could also be implemented for PPC32 later.

> +
> +int set_memory_ro(unsigned long addr, int numpages)
> +{
> +	return change_memory_common(addr, numpages,
> +					0, _PAGE_WRITE);
> +}
> +EXPORT_SYMBOL(set_memory_ro);

Take care that _PAGE_WRITE has value 0 when _PAGE_RO instead of _PAGE_RW 
is defined (eg for the 8xx).

It would be better to use accessors like pte_wrprotect() and pte_mkwrite()

> +
> +int set_memory_rw(unsigned long addr, int numpages)
> +{
> +	return change_memory_common(addr, numpages,
> +					_PAGE_WRITE, 0);
> +}
> +EXPORT_SYMBOL(set_memory_rw);
> +
> +int set_memory_nx(unsigned long addr, int numpages)
> +{
> +	return change_memory_common(addr, numpages,
> +					0, _PAGE_EXEC);
> +}
> +EXPORT_SYMBOL(set_memory_nx);
> +
> +int set_memory_x(unsigned long addr, int numpages)
> +{
> +	return change_memory_common(addr, numpages,
> +					_PAGE_EXEC, 0);
> +}
> +EXPORT_SYMBOL(set_memory_x);
> +#endif
>

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

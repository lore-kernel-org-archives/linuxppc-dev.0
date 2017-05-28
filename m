Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbSMS2gVTzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 04:00:19 +1000 (AEST)
Subject: Re: [PATCH v1 1/8] powerpc/lib/code-patching: Enhance code patching
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <20170525033650.10891-1-bsingharora@gmail.com>
 <20170525033650.10891-2-bsingharora@gmail.com>
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 paulus@samba.org, rashmica.g@gmail.com
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <d7801b1e-6cb9-1504-03d5-8b7a0a5d04db@c-s.fr>
Date: Sun, 28 May 2017 20:00:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170525033650.10891-2-bsingharora@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/05/2017 à 05:36, Balbir Singh a écrit :
> Today our patching happens via direct copy and
> patch_instruction. The patching code is well
> contained in the sense that copying bits are limited.
>
> While considering implementation of CONFIG_STRICT_RWX,
> the first requirement is to a create another mapping
> that will allow for patching. We create the window using
> text_poke_area, allocated via get_vm_area(), which might
> be an overkill. We can do per-cpu stuff as well. The
> downside of these patches that patch_instruction is
> now synchornized using a lock. Other arches do similar
> things, but use fixmaps. The reason for not using
> fixmaps is to make use of any randomization in the
> future. The code also relies on set_pte_at and pte_clear
> to do the appropriate tlb flushing.
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/lib/code-patching.c | 88 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 84 insertions(+), 4 deletions(-)
>

[...]

> +static int kernel_map_addr(void *addr)
> +{
> +	unsigned long pfn;
>  	int err;
>
> -	__put_user_size(instr, addr, 4, err);
> +	if (is_vmalloc_addr(addr))
> +		pfn = vmalloc_to_pfn(addr);
> +	else
> +		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
> +
> +	err = map_kernel_page((unsigned long)text_poke_area->addr,
> +			(pfn << PAGE_SHIFT), _PAGE_KERNEL_RW | _PAGE_PRESENT);



Why not use PAGE_KERNEL instead of _PAGE_KERNEL_RW | _PAGE_PRESENT ?

 From asm/pte-common.h :

#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
#define _PAGE_BASE	(_PAGE_BASE_NC)
#define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)

Also, in pte-common.h, maybe the following defines could/should be 
reworked once you serie applied, shouldn't it ?

/* Protection used for kernel text. We want the debuggers to be able to
  * set breakpoints anywhere, so don't write protect the kernel text
  * on platforms where such control is possible.
  */
#if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || 
defined(CONFIG_BDI_SWITCH) ||\
	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
#define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
#else
#define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
#endif


Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

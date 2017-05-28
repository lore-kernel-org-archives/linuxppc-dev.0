Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbZ2G5mmZzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 08:15:50 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id h64so4484033pge.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 May 2017 15:15:50 -0700 (PDT)
Message-ID: <1496009710.21894.5.camel@gmail.com>
Subject: Re: [PATCH v1 1/8] powerpc/lib/code-patching: Enhance code patching
From: Balbir Singh <bsingharora@gmail.com>
To: christophe leroy <christophe.leroy@c-s.fr>,
 linuxppc-dev@lists.ozlabs.org,  mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 paulus@samba.org, rashmica.g@gmail.com
Date: Mon, 29 May 2017 08:15:10 +1000
In-Reply-To: <d7801b1e-6cb9-1504-03d5-8b7a0a5d04db@c-s.fr>
References: <20170525033650.10891-1-bsingharora@gmail.com>
 <20170525033650.10891-2-bsingharora@gmail.com>
 <d7801b1e-6cb9-1504-03d5-8b7a0a5d04db@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-05-28 at 20:00 +0200, christophe leroy wrote:
> 
> Le 25/05/2017 à 05:36, Balbir Singh a écrit :
> > Today our patching happens via direct copy and
> > patch_instruction. The patching code is well
> > contained in the sense that copying bits are limited.
> > 
> > While considering implementation of CONFIG_STRICT_RWX,
> > the first requirement is to a create another mapping
> > that will allow for patching. We create the window using
> > text_poke_area, allocated via get_vm_area(), which might
> > be an overkill. We can do per-cpu stuff as well. The
> > downside of these patches that patch_instruction is
> > now synchornized using a lock. Other arches do similar
> > things, but use fixmaps. The reason for not using
> > fixmaps is to make use of any randomization in the
> > future. The code also relies on set_pte_at and pte_clear
> > to do the appropriate tlb flushing.
> > 
> > Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> > ---
> >  arch/powerpc/lib/code-patching.c | 88 ++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 84 insertions(+), 4 deletions(-)
> > 
> 
> [...]
> 
> > +static int kernel_map_addr(void *addr)
> > +{
> > +	unsigned long pfn;
> >  	int err;
> > 
> > -	__put_user_size(instr, addr, 4, err);
> > +	if (is_vmalloc_addr(addr))
> > +		pfn = vmalloc_to_pfn(addr);
> > +	else
> > +		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
> > +
> > +	err = map_kernel_page((unsigned long)text_poke_area->addr,
> > +			(pfn << PAGE_SHIFT), _PAGE_KERNEL_RW | _PAGE_PRESENT);
> 
> 
> 
> Why not use PAGE_KERNEL instead of _PAGE_KERNEL_RW | _PAGE_PRESENT ?
>

Will do
 
>  From asm/pte-common.h :
> 
> #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
> #define _PAGE_BASE	(_PAGE_BASE_NC)
> #define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_PSIZE)
> 
> Also, in pte-common.h, maybe the following defines could/should be 
> reworked once you serie applied, shouldn't it ?
> 
> /* Protection used for kernel text. We want the debuggers to be able to
>   * set breakpoints anywhere, so don't write protect the kernel text
>   * on platforms where such control is possible.
>   */
> #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) || 
> defined(CONFIG_BDI_SWITCH) ||\
> 	defined(CONFIG_KPROBES) || defined(CONFIG_DYNAMIC_FTRACE)
> #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
> #else
> #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
> #endif

Yes, I did see them and I want to rework them.

Thanks,
Balbir Singh.

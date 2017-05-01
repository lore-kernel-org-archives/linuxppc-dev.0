Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGTh14mtwzDqLX
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 13:00:49 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id s62so2727046pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Apr 2017 20:00:49 -0700 (PDT)
Date: Mon, 1 May 2017 13:00:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/mm: Only read faulting instruction when
 necessary in do_page_fault()
Message-ID: <20170501130023.3c10e00d@roar.ozlabs.ibm.com>
In-Reply-To: <20170428061301.27B826E713@localhost.localdomain>
References: <20170428061301.27B826E713@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 28 Apr 2017 08:13:01 +0200 (CEST)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Commit a7a9dcd882a67 ("powerpc: Avoid taking a data miss on every
> userspace instruction miss") has shown that limiting the read of
> faulting instruction to likely cases improves performance.
> 
> This patch goes further into this direction by limiting the read
> of the faulting instruction to the only cases where it is definitly
> needed.
> 
> On an MPC885, with the same benchmark app as in the commit referred
> above, we see a reduction of 4000 dTLB misses (approx 3%):
> 
> Before the patch:
>  Performance counter stats for './fault 500' (10 runs):
> 
>          720495838      cpu-cycles                                                    ( +-  0.04% )
>             141769      dTLB-load-misses                                              ( +-  0.02% )
>              52722      iTLB-load-misses                                              ( +-  0.01% )
>              19611      faults                                                        ( +-  0.02% )
> 
>        5.750535176 seconds time elapsed                                          ( +-  0.16% )
> 
> With the patch:
>  Performance counter stats for './fault 500' (10 runs):
> 
>          717669123      cpu-cycles                                                    ( +-  0.02% )
>             137344      dTLB-load-misses                                              ( +-  0.03% )
>              52731      iTLB-load-misses                                              ( +-  0.01% )
>              19614      faults                                                        ( +-  0.03% )
> 
>        5.728423115 seconds time elapsed                                          ( +-  0.14% )
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: Changes 'if (cond1) if (cond2)' by 'if (cond1 && cond2)'
> 
>  In case the instruction we read has value 0, store_update_sp() will
>  return false, so it will bail out.
> 
>  This patch applies after the serie "powerpc/mm: some cleanup of do_page_fault()"
> 
>  arch/powerpc/mm/fault.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 400f2d0d42f8..2ec82a279d28 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -280,14 +280,6 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  
> -	/*
> -	 * We want to do this outside mmap_sem, because reading code around nip
> -	 * can result in fault, which will cause a deadlock when called with
> -	 * mmap_sem held
> -	 */
> -	if (is_write && is_user)
> -		__get_user(inst, (unsigned int __user *)regs->nip);
> -
>  	if (is_user)
>  		flags |= FAULT_FLAG_USER;
>  
> @@ -356,8 +348,18 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  		 * between the last mapped region and the stack will
>  		 * expand the stack rather than segfaulting.
>  		 */
> -		if (address + 2048 < uregs->gpr[1] && !store_updates_sp(inst))
> -			goto bad_area;
> +		if (address + 2048 < uregs->gpr[1] && !inst) {
> +			/*
> +			 * We want to do this outside mmap_sem, because reading
> +			 * code around nip can result in fault, which will cause
> +			 * a deadlock when called with mmap_sem held
> +			 */
> +			up_read(&mm->mmap_sem);
> +			__get_user(inst, (unsigned int __user *)regs->nip);
> +			if (!store_updates_sp(inst))
> +				goto bad_area_nosemaphore;
> +			goto retry;
> +		}

Yes, nice patch. I wonder if you can do __get_user first as non-faulting to
avoid retaking the mmap_sem and retrying? Along the lines of:

+               nip = (unsigned int __user *)regs->nip;
+               pagefault_disable();
+               if (unlikely(__get_user_inatomic(inst, nip))) {
+                       pagefault_enable();
+                       up_read(&mm->mmap_sem);
+                       if (get_user(inst, nip)) {
                           ...
                           goto retry;

The user instruction should practically always have a Linux pte, so a
fault there should be exceedingly rare, I think?

Thanks,
Nick

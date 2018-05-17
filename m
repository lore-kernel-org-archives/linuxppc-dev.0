Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40msm953CWzF284
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 23:36:57 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id i5-v6so2577468plt.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 06:36:57 -0700 (PDT)
Date: Thu, 17 May 2018 23:36:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] powerpc/mm: Only read faulting instruction when
 necessary in do_page_fault()
Message-ID: <20180517233643.4551142e@roar.ozlabs.ibm.com>
In-Reply-To: <20180517105930.71B1D6F937@po14934vm.idsi0.si.c-s.fr>
References: <20180517105930.71B1D6F937@po14934vm.idsi0.si.c-s.fr>
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

On Thu, 17 May 2018 12:59:29 +0200 (CEST)
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
>          720495838      cpu-cycles		( +-  0.04% )
>             141769      dTLB-load-misses	( +-  0.02% )
>              52722      iTLB-load-misses	( +-  0.01% )
>              19611      faults			( +-  0.02% )
> 
>        5.750535176 seconds time elapsed		( +-  0.16% )
> 
> With the patch:
>  Performance counter stats for './fault 500' (10 runs):
> 
>          717669123      cpu-cycles		( +-  0.02% )
>             137344      dTLB-load-misses	( +-  0.03% )
>              52731      iTLB-load-misses	( +-  0.01% )
>              19614      faults			( +-  0.03% )
> 
>        5.728423115 seconds time elapsed		( +-  0.14% )
> 
> The proper work of the huge stack expansion was tested with the
> following app:
> 
> int main(int argc, char **argv)
> {
> 	char buf[1024 * 1025];
> 
> 	sprintf(buf, "Hello world !\n");
> 	printf(buf);
> 
> 	exit(0);
> }
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v6: Rebased on latest powerpc/merge branch ; Using __get_user_inatomic() instead of get_user() in order
>      to move it inside the semaphored area. That removes all the complexity of the patch.
> 
>  v5: Reworked to fit after Benh do_fault improvement and rebased on top of powerpc/merge (65152902e43fef)
> 
>  v4: Rebased on top of powerpc/next (f718d426d7e42e) and doing access_ok() verification before __get_user_xxx()
> 
>  v3: Do a first try with pagefault disabled before releasing the semaphore
> 
>  v2: Changes 'if (cond1) if (cond2)' by 'if (cond1 && cond2)'
> 
>  arch/powerpc/mm/fault.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index c01d627e687a..a7d5cc76a8ce 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -72,8 +72,18 @@ static inline bool notify_page_fault(struct pt_regs *regs)
>  static bool store_updates_sp(struct pt_regs *regs)
>  {
>  	unsigned int inst;
> +	int ret;
>  
> -	if (get_user(inst, (unsigned int __user *)regs->nip))
> +	/*
> +	 * Using get_user_in_atomic() as reading code around nip can result in
> +	 * fault, which may cause a deadlock when called with mmap_sem held,
> +	 * however since we are reading the instruction that generated the DSI
> +	 * we are handling, the page is necessarily already present.
> +	 */
> +	pagefault_disable();
> +	ret = __get_user_inatomic(inst, (unsigned int __user *)regs->nip);
> +	pagefault_enable();
> +	if (ret)
>  		return false;

Problem is that the page can be removed from page tables between
taking the fault and reading the address here.

That case would be so rare that it should be fine to do a big hammer
fix like drop the mmap_sem, do a fault_in_pages_readable, and then
restart from taking the mmap_sem again.

Thanks,
Nick

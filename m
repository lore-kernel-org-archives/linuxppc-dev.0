Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qytb48kVzDqgs
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:38:15 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id j20-v6so8878036pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 07:38:15 -0700 (PDT)
Date: Wed, 23 May 2018 00:38:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 2/3] powerpc/mm: Only read faulting instruction when
 necessary in do_page_fault()
Message-ID: <20180523003801.43070ddc@roar.ozlabs.ibm.com>
In-Reply-To: <d37d9ce7b925bc254082cd664e37a062131d04b8.1526995927.git.christophe.leroy@c-s.fr>
References: <1053e5f43a2ea9a9d9abb1f45c88dffb60b9b4fc.1526995927.git.christophe.leroy@c-s.fr>
 <d37d9ce7b925bc254082cd664e37a062131d04b8.1526995927.git.christophe.leroy@c-s.fr>
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

On Tue, 22 May 2018 16:02:56 +0200 (CEST)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Commit a7a9dcd882a67 ("powerpc: Avoid taking a data miss on every
> userspace instruction miss") has shown that limiting the read of
> faulting instruction to likely cases improves performance.
> 
> This patch goes further into this direction by limiting the read
> of the faulting instruction to the only cases where it is likely
> needed.
> 
> On an MPC885, with the same benchmark app as in the commit referred
> above, we see a reduction of about 3900 dTLB misses (approx 3%):
> 
> Before the patch:
>  Performance counter stats for './fault 500' (10 runs):
> 
>          683033312      cpu-cycles                                                    ( +-  0.03% )
>             134538      dTLB-load-misses                                              ( +-  0.03% )
>              46099      iTLB-load-misses                                              ( +-  0.02% )
>              19681      faults                                                        ( +-  0.02% )
> 
>        5.389747878 seconds time elapsed                                          ( +-  0.06% )
> 
> With the patch:
> 
>  Performance counter stats for './fault 500' (10 runs):
> 
>          682112862      cpu-cycles                                                    ( +-  0.03% )
>             130619      dTLB-load-misses                                              ( +-  0.03% )
>              46073      iTLB-load-misses                                              ( +-  0.05% )
>              19681      faults                                                        ( +-  0.01% )
> 
>        5.381342641 seconds time elapsed                                          ( +-  0.07% )
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
>  v7: Following comment from Nicholas on v6 on possibility of the page getting removed from the pagetables
>      between the fault and the read, I have reworked the patch in order to do the get_user() in
>      __do_page_fault() directly in order to reduce complexity compared to version v5

This is looking better, thanks.

> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index fcbb34431da2..dc64b8e06477 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -450,9 +450,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>  	 * can result in fault, which will cause a deadlock when called with
>  	 * mmap_sem held
>  	 */
> -	if (is_write && is_user)
> -		get_user(inst, (unsigned int __user *)regs->nip);
> -
>  	if (is_user)
>  		flags |= FAULT_FLAG_USER;
>  	if (is_write)
> @@ -498,6 +495,26 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>  	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
>  		return bad_area(regs, address);
>  
> +	if (unlikely(is_write && is_user && address + 0x100000 < vma->vm_end &&
> +		     !inst)) {
> +		unsigned int __user *nip = (unsigned int __user *)regs->nip;
> +
> +		if (likely(access_ok(VERIFY_READ, nip, sizeof(inst)))) {
> +			int res;
> +
> +			pagefault_disable();
> +			res = __get_user_inatomic(inst, nip);
> +			pagefault_enable();
> +			if (unlikely(res)) {
> +				up_read(&mm->mmap_sem);
> +				res = __get_user(inst, nip);
> +				if (!res && inst)
> +					goto retry;

You're handling error here but the previous code did not?

> +				return bad_area_nosemaphore(regs, address);
> +			}
> +		}
> +	}

Would it be nicer to move all this up into bad_stack_expansion().
It would need a way to handle the retry and insn, but I think it
would still look better.

Thanks,
Nick

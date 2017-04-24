Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBLKS2rn2zDqFx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 19:15:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Only read faulting instruction when necessary
 in do_page_fault()
In-Reply-To: <20170424082832.C0E8C6EAF5@localhost.localdomain>
References: <20170424082832.C0E8C6EAF5@localhost.localdomain>
Date: Mon, 24 Apr 2017 19:15:20 +1000
Message-ID: <87d1c2rwt3.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 400f2d0d42f8..3d506589236c 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -356,8 +348,22 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  		 * between the last mapped region and the stack will
>  		 * expand the stack rather than segfaulting.
>  		 */
> -		if (address + 2048 < uregs->gpr[1] && !store_updates_sp(inst))
> -			goto bad_area;
> +		if (address + 2048 < uregs->gpr[1]) {
> +			if (!inst) {

That looks like it could lead to an infinite loop, if the instruction
that caused the fault has been overwritten with NULL by another thread.

Or did I miss something? (I only read the diff)

> +				/*
> +				 * We want to do this outside mmap_sem, because
> +				 * reading code around nip can result in fault,
> +				 * which will cause a deadlock when called with
> +				 * mmap_sem held
> +				 */
> +				up_read(&mm->mmap_sem);
> +				__get_user(inst,
> +					   (unsigned int __user *)regs->nip);
> +				if (!store_updates_sp(inst))
> +					goto bad_area_nosemaphore;
> +				goto retry;
> +			}


cheers

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLyMk1KYGzDqmj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 02:47:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: Re: [PATCH 20/25] powerpc: Handle exceptions caused by pkey violation
In-Reply-To: <1504910713-7094-29-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-29-git-send-email-linuxram@us.ibm.com>
Date: Tue, 24 Oct 2017 17:47:38 +0200
Message-ID: <874lqo4kf9.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:

> Handle Data and  Instruction exceptions caused by memory
> protection-key.
>
> The CPU will detect the key fault if the HPTE is already
> programmed with the key.
>
> However if the HPTE is not  hashed, a key fault will not
> be detected by the  hardware. The   software will detect
> pkey violation in such a case.

That seems like the wrong trade off to me.

It means every fault has to go through arch_vma_access_permitted(),
which is at least a function call in the best case, even when pkeys are
not in use, and/or the range in question is not protected by a key.

Why not instead just service the fault and let the hardware catch it?

If that access to a protected page is a bug then the process will
probably just exit, in which case who cares about the overhead of the
extra fault.

If the access is not currently allowed, but the process wants to take
the signal and do something to allow it, then is the overhead of the
extra fault going to matter vs the signal etc?

I think we should just let the hardware take a 2nd fault, unless someone
can demonstrate a workload where the cost of that is prohibitive.

Or does that not work for some reason?

> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 4797d08..a16bc43 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -391,11 +408,9 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>  		return 0;
>  
>  	if (unlikely(page_fault_is_bad(error_code))) {
> -		if (is_user) {
> -			_exception(SIGBUS, regs, BUS_OBJERR, address);
> -			return 0;
> -		}
> -		return SIGBUS;
> +		if (!is_user)
> +			return SIGBUS;
> +		return bad_page_fault_exception(regs, address, error_code);

I don't see why we want to handle the key fault here.

I know it's caught here at the moment, because it's in
DSISR_BAD_FAULT_64S, but I think now that we support keys we should
remove DSISR_KEYFAULT from DSISR_BAD_FAULT_64S.

Then we should let it fall through to further down, and handle it in
access_error().

That way eg. the page fault accounting will work as normal etc.

> @@ -492,6 +507,18 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
>  	if (unlikely(access_error(is_write, is_exec, vma)))
>  		return bad_area(regs, address);
>  
> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
> +			is_exec, 0))
> +		return __bad_area(regs, address, SEGV_PKUERR);
> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> +
> +
> +	/* handle_mm_fault() needs to know if its a instruction access
> +	 * fault.
> +	 */
> +	if (is_exec)
> +		flags |= FAULT_FLAG_INSTRUCTION;

What is this doing here? We already do that further up.

cheers

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A9421007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 13:03:22 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o6N33Ig5014499
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 22:03:19 -0500
Subject: Re: [PATCH 3/5] powerpc/mm: Fix bugs in huge page hashing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1279845704-14848-3-git-send-email-benh@kernel.crashing.org>
References: <1279845704-14848-1-git-send-email-benh@kernel.crashing.org>
	<1279845704-14848-2-git-send-email-benh@kernel.crashing.org>
	<1279845704-14848-3-git-send-email-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 23 Jul 2010 13:03:17 +1000
Message-ID: <1279854197.1970.60.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-07-23 at 10:41 +1000, Benjamin Herrenschmidt wrote:
> There's a couple of nasty bugs lurking in our huge page hashing code.
> 
> First, we don't check the access permission atomically with setting
> the _PAGE_BUSY bit, which means that the PTE value we end up using
> for the hashing might be different than the one we have checked
> the access permissions for.
> 
> We've seen cases where that leads us to try to use an invalidated
> PTE for hashing, causing all sort of "interesting" issues.
> 
> Then, we also failed to set _PAGE_DIRTY on a write access.
> 
> This fixes both, while also simplifying the code a bit.

The changeset lacks a comment about a change to the return value
when hitting _PAGE_BUSY and ...

>  	do {
>  		old_pte = pte_val(*ptep);
> -		if (old_pte & _PAGE_BUSY)
> -			goto out;
> +		/* If PTE busy, retry the access */
> +		if (unlikely(old_pte & _PAGE_BUSY))
> +			return 0;
> +		/* If PTE permissions don't match, take page fault */
> +		if (unlikely(access & ~pte_val(*ptep)))
> +			return 1;

old_pte will do just fine instead of reloading it

Thanks Michael !

I'll respin that one.

Cheers,
Ben.

> +		/* Try to lock the PTE, add ACCESSED and DIRTY if it was
> +		 * a write access */
>  		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
> +		if (access & _PAGE_RW)
> +			new_pte |= _PAGE_DIRTY;
>  	} while(old_pte != __cmpxchg_u64((unsigned long *)ptep,
>  					 old_pte, new_pte));
>  
> @@ -127,8 +127,7 @@ repeat:
>  		 */
>  		if (unlikely(slot == -2)) {
>  			*ptep = __pte(old_pte);
> -			err = -1;
> -			goto out;
> +			return -1;
>  		}
>  
>  		new_pte |= (slot << 12) & (_PAGE_F_SECOND | _PAGE_F_GIX);
> @@ -138,9 +137,5 @@ repeat:
>  	 * No need to use ldarx/stdcx here
>  	 */
>  	*ptep = __pte(new_pte & ~_PAGE_BUSY);
> -
> -	err = 0;
> -
> - out:
> -	return err;
> +	return 0;
>  }

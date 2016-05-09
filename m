Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3Hyv08MZzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 20:03:51 +1000 (AEST)
In-Reply-To: <1456446386-28619-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [1/2] powerpc/mm: Remove duplicated check in do_page_fault()
Message-Id: <3r3Hyt6KL9z9t0r@ozlabs.org>
Date: Mon,  9 May 2016 20:03:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-26-02 at 00:26:25 UTC, Gavin Shan wrote:
> When the page fault happened in user space, we need check it's
> caused by stack frame pointer update instruction and update
> local variable @flag with FAULT_FLAG_USER. Currently, the code
> has two separate check for the same condition. That's unnecessary.
> 
> This removes one of the duplicated check. No functinal changes
> introduced.

It's possible though that store_updates_sp() changes regs, and causes
user_mode(regs) to change, which would mean the second check is necessary.
That's not true with the current code, but you should mention that you confirmed
that in the change log.

> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index a67c6d7..935f386 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -294,11 +294,10 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
>  	 * can result in fault, which will cause a deadlock when called with
>  	 * mmap_sem held
>  	 */
> -	if (user_mode(regs))
> -		store_update_sp = store_updates_sp(regs);
> -
> -	if (user_mode(regs))
> +	if (user_mode(regs)) {
>  		flags |= FAULT_FLAG_USER;
> +		store_update_sp = store_updates_sp(regs);
> +	}

It doesn't really matter in this case, but it would be better to keep the
ordering of the two statements the same as before.

cheers

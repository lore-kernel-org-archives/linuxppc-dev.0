Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qWf3660PhzDq71
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Mar 2016 21:01:38 +1100 (AEDT)
In-Reply-To: <1458273681-18588-1-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: imunsie@au1.ibm.com
Subject: Re: cxl: fix setting of _PAGE_USER bit when handling page faults
Message-Id: <3qWf364wYxz9sDG@ozlabs.org>
Date: Fri, 25 Mar 2016 21:01:38 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-18-03 at 04:01:21 UTC, Andrew Donnellan wrote:
> When handling page faults, cxl_handle_page_fault() checks whether the page
> should be accessible by userspace and have its _PAGE_USER access bit set.
> _PAGE_USER should be set if the context's kernel flag isn't set, or if the
> page falls outside of kernel memory.
> 
> However, the check currently uses the wrong operator, causing it to always
> evalute to true. As such, we always set the _PAGE_USER bit, even when it
> should be restricted to the kernel.
> 
> Fix the check so that the _PAGE_USER bit is set only as intended.
> 
..
> diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
> index 9a8650b..a76cb8a 100644
> --- a/drivers/misc/cxl/fault.c
> +++ b/drivers/misc/cxl/fault.c
> @@ -152,7 +152,7 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
>  	access = _PAGE_PRESENT;
>  	if (dsisr & CXL_PSL_DSISR_An_S)
>  		access |= _PAGE_RW;
> -	if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
> +	if ((!ctx->kernel) || !(dar & (1ULL << 63)))
>  		access |= _PAGE_USER;

I think you can (should) use is_kernel_addr() for the DAR check.

I'm also slightly worried by that logic in the case of a non-kernel context.

ie. if ctx->kernel is false, we get:

	if (true || !is_kernel_addr(dar))
 		access |= _PAGE_USER;

Which means we just add _PAGE_USER for any address. What am I missing here?

cheers

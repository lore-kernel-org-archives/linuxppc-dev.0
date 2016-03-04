Return-Path: <duwe@lst.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8AD2C1A035C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 23:42:52 +1100 (AEDT)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1B55F140213
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2016 23:42:51 +1100 (AEDT)
Date: Fri, 4 Mar 2016 13:42:47 +0100
From: Torsten Duwe <duwe@lst.de>
To: Petr Mladek <pmladek@suse.com>
Cc: linuxppc-dev@ozlabs.org, Balbir Singh <bsingharora@gmail.com>,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, jeyu@redhat.com, jkosina@suse.cz,
 live-patching@vger.kernel.org, mbenes@suse.cz
Subject: Re: [PATCH][v4] livepatch/ppc: Enable livepatching on powerpc
Message-ID: <20160304124247.GA20914@lst.de>
References: <1457023921-2051-1-git-send-email-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457023921-2051-1-git-send-email-pmladek@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 03, 2016 at 05:52:01PM +0100, Petr Mladek wrote:
[...]
> index ec7f8aada697..2d5333c228f1 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -1265,6 +1271,31 @@ ftrace_call:
>  	ld	r0, LRSAVE(r1)
>  	mtlr	r0
>  
> +#ifdef CONFIG_LIVEPATCH
> +	beq+	4f		/* likely(old_NIP == new_NIP) */
> +	/*
> +	 * For a local call, restore this TOC after calling the patch function.
> +	 * For a global call, it does not matter what we restore here,
> +	 * since the global caller does its own restore right afterwards,
> +	 * anyway. Just insert a klp_return_helper frame in any case,
> +	 * so a patch function can always count on the changed stack offsets.
> +	 * The patch introduces a frame such that from the patched function
> +	 * we return back to klp_return helper. For ABI compliance r12,
> +	 * lr and LRSAVE(r1) contain the address of klp_return_helper.
> +	 * We loaded ctr with the address of the patched function earlier
> +	 */
> +	stdu	r1, -32(r1)	/* open new mini stack frame */
> +	std	r2, 24(r1)	/* save TOC now, unconditionally. */
> +	bl	5f
> +5:	mflr	r12
> +	addi	r12, r12, (klp_return_helper + 4 - .)@l
> +	std	r12, LRSAVE(r1)
> +	mtlr	r12
> +	mfctr	r12		/* allow for TOC calculation in newfunc */
> +	bctr
> +4:
> +#endif
> +
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  	stdu	r1, -112(r1)
>  .globl ftrace_graph_call
> @@ -1281,6 +1312,25 @@ _GLOBAL(ftrace_graph_stub)
>  
>  _GLOBAL(ftrace_stub)
>  	blr
> +#ifdef CONFIG_LIVEPATCH
> +/* Helper function for local calls that are becoming global
> + * due to live patching.
> + * We can't simply patch the NOP after the original call,
> + * because, depending on the consistency model, some kernel
> + * threads may still have called the original, local function
> + * *without* saving their TOC in the respective stack frame slot,
> + * so the decision is made per-thread during function return by
> + * maybe inserting a klp_return_helper frame or not.
> +*/
> +klp_return_helper:
> +	ld	r2, 24(r1)	/* restore TOC (saved by ftrace_caller) */
> +	addi r1, r1, 32		/* destroy mini stack frame */
> +	ld	r0, LRSAVE(r1)	/* get the real return address */
> +	mtlr	r0
> +	blr
> +#endif
> +
> +
>  #else
>  _GLOBAL_TOC(_mcount)
>  	/* Taken from output of objdump from lib64/glibc */

We need a caveat here, at least in the comments, even better
in some documentation, that the klp_return_helper shifts the stack layout.

This is relevant for functions with more than 8 fixed integer arguments
or for any varargs creator. As soon as the patch function is to replace
an original with arguments on the stack, the extra stack frame needs to
be accounted for.

Where shall we put this warning?

	Torsten

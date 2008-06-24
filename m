Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09F54DDFB7
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 23:48:23 +1000 (EST)
Message-Id: <19A4D5AE-DB7A-4139-88CD-26F1221A5271@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <58cb99151247b693ccb4ffd6f624cd2efddeea0e.1214271072.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 05/14] powerpc: Add new code patching routines
Date: Tue, 24 Jun 2008 08:48:14 -0500
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<58cb99151247b693ccb4ffd6f624cd2efddeea0e.1214271072.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 23, 2008, at 8:32 PM, Michael Ellerman wrote:

> This commit adds some new routines for patching code, they will be  
> used
> in a following commit.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> arch/powerpc/lib/code-patching.c    |  107 ++++++++++++++++++++++++++ 
> +++++++++
> include/asm-powerpc/code-patching.h |    8 +++
> 2 files changed, 115 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/ 
> code-patching.c
> index 430f4c1..27957c4 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -41,3 +41,110 @@ unsigned int create_branch(const unsigned int  
> *addr,
>
> 	return instruction;
> }
> +
> +unsigned int create_cond_branch(const unsigned int *addr,
> +				unsigned long target, int flags)
> +{

it would be nice to have some idea what flags is suppose to be.
>
> +	unsigned int instruction;
> +	long offset;
> +
> +	offset = target;
> +	if (! (flags & BRANCH_ABSOLUTE))
> +		offset = offset - (unsigned long)addr;
> +
> +	/* Check we can represent the target in the instruction format */
> +	if (offset < -0x8000 || offset > 0x7FFF || offset & 0x3)
> +		return 0;
> +
> +	/* Mask out the flags and target, so they don't step on each  
> other. */
> +	instruction = 0x40000000 | (flags & 0x3FF0003) | (offset & 0xFFFC);
> +
> +	return instruction;
> +}

[snip]

> +unsigned int translate_branch(const unsigned int *dest, const  
> unsigned int *src)
> +{

I'm not sure I get what this function is trying to do.

>
> +	unsigned long target;
> +
> +	target = branch_target(src);
> +
> +	if (instr_is_branch_iform(*src))
> +		return create_branch(dest, target, *src);
> +	else if (instr_is_branch_bform(*src))
> +		return create_cond_branch(dest, target, *src);
> +
> +	return 0;
> +}

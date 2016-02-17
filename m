Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 245061A033F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 21:55:47 +1100 (AEDT)
Message-ID: <1455706540.4450.2.camel@ellerman.id.au>
Subject: Re: [PATCH v8 1/8] ppc64 (le): prepare for -mprofile-kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Cc: Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>, Petr
 Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Date: Wed, 17 Feb 2016 21:55:40 +1100
In-Reply-To: <20160210174435.06578692C8@newverein.lst.de>
References: <20160210174221.EBBEC692C8@newverein.lst.de>
 <20160210174435.06578692C8@newverein.lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-10 at 17:21 +0100, Torsten Duwe wrote:

> The gcc switch -mprofile-kernel, available for ppc64 on gcc > 4.8.5,
> allows to call _mcount very early in the function, which low-level
> ASM code and code patching functions need to consider.
> Especially the link register and the parameter registers are still
> alive and not yet saved into a new stack frame.

...

> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index ac64ffd..72a1a52 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -476,17 +474,44 @@ static unsigned long stub_for_addr(Elf64_Shdr *sechdrs,
>  	return (unsigned long)&stubs[i];
>  }
>  
> +#ifdef CC_USING_MPROFILE_KERNEL
> +static int is_early_mcount_callsite(u32 *instruction)
> +{
> +	/* -mprofile-kernel sequence starting with
> +	 * mflr r0 and maybe std r0, LRSAVE(r1).
> +	 */
> +	if ((instruction[-3] == PPC_INST_MFLR &&
> +	     instruction[-2] == PPC_INST_STD_LR) ||
> +	    instruction[-2] == PPC_INST_MFLR) {
> +		/* Nothing to be done here, it's an _mcount
> +		 * call location and r2 will have to be
> +		 * restored in the _mcount function.
> +		 */
> +		return 1;
> +	}
> +	return 0;
> +}

So this logic to deal with the 2 vs 3 instruction version of the mcount
sequence is problematic.

On a kernel built with the 2 instruction version this will fault when the
function we're looking at is located at the beginning of a page. Because
instruction[-3] goes off the front of the mapping.

We can probably fix that. But it's still a bit dicey.

I'm wondering if we want to just say we only support the 2 instruction version.
Currently that means GCC 6 only, or a distro compiler with the backport of
e95d0248dace. But we could also ask GCC to backport it to 4.9 and 5.

Thoughts?

cheers

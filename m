Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id 6311D2C0094
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2012 15:25:27 +1000 (EST)
Date: Tue, 4 Sep 2012 22:25:21 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 3.5+: yaboot, Invalid memory access
In-Reply-To: <1346807308.2257.14.camel@pasglop>
Message-ID: <alpine.DEB.2.01.1209042222270.25392@trent.utfs.org>
References: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
 <alpine.DEB.2.01.1209032310220.25392@trent.utfs.org>
 <1346741491.7619.12.camel@concordia>
 <alpine.DEB.2.01.1209040223380.25392@trent.utfs.org>
 <1346807308.2257.14.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 5 Sep 2012 at 11:08, Benjamin Herrenschmidt wrote:
> Try this:
> 
> powerpc: Don't use __put_user() in patch_instruction

Perfect! With this patch applied, the machine boots again.

  Tested-by: Christian Kujau <lists@nerdbynature.de>

I sure hope that other people will benefit from this as well. I can't 
stand the thought that you guys are always putting out fixes for this ol' 
PowerBook of mine :-\

Thanks so much,
Christian.

> 
> patch_instruction() can be called very early on ppc32, when the kernel
> isn't yet running at it's linked address. That can cause the !
> is_kernel_addr() test in __put_user() to trip and call might_sleep()
> which is very bad at that point during boot.
> 
> Use a lower level function instead for now, at least until we get to
> rework ppc32 boot process to do the code patching later, like ppc64
> does.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index dd223b3..17e5b23 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -20,7 +20,7 @@ int patch_instruction(unsigned int *addr, unsigned int instr)
>  {
>  	int err;
>  
> -	err = __put_user(instr, addr);
> +	__put_user_size(instr, addr, 4, err);
>  	if (err)
>  		return err;
>  	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (addr));
> 
> 
> 

-- 
BOFH excuse #101:

Collapsed Backbone

Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429BYg3sP0zF36l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 16:23:34 +1000 (AEST)
Subject: Re: [PATCH v2] powerpc: Avoid code patching freed init sections
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 paulus@ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <20180912052058.10062-1-mikey@neuling.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <0922624b-6c6f-1afd-a9e2-cde5a9a8a1e4@c-s.fr>
Date: Wed, 12 Sep 2018 08:23:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180912052058.10062-1-mikey@neuling.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 12/09/2018 à 07:20, Michael Neuling a écrit :
> This stops us from doing code patching in init sections after they've
> been freed.
> 
> In this chain:
>    kvm_guest_init() ->
>      kvm_use_magic_page() ->
>        fault_in_pages_readable() ->
> 	 __get_user() ->
> 	   __get_user_nocheck() ->
> 	     barrier_nospec();
> 
> We have a code patching location at barrier_nospec() and
> kvm_guest_init() is an init function. This whole chain gets inlined,
> so when we free the init section (hence kvm_guest_init()), this code
> goes away and hence should no longer be patched.
> 
> We seen this as userspace memory corruption when using a memory
> checker while doing partition migration testing on powervm (this
> starts the code patching post migration via
> /sys/kernel/mobility/migration). In theory, it could also happen when
> using /sys/kernel/debug/powerpc/barrier_nospec.
> 
> With this patch there is a small change of a race if we code patch
> between the init section being freed and setting SYSTEM_RUNNING (in
> kernel_init()) but that seems like an impractical time and small
> window for any code patching to occur.
> 
> cc: stable@vger.kernel.org # 4.13+
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
> ---
> For stable I've marked this as v4.13+ since that's when we refactored
> code-patching.c but it could go back even further than that. In
> reality though, I think we can only hit this since the first
> spectre/meltdown changes.
> 
> v2:
>    Print when we skip an address
> ---
>   arch/powerpc/lib/code-patching.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 850f3b8f4d..68254e7f17 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -23,11 +23,33 @@
>   #include <asm/code-patching.h>
>   #include <asm/setup.h>
>   
> +

This blank line is not needed

> +static inline bool in_init_section(unsigned int *patch_addr)
> +{
> +	if (patch_addr < (unsigned int *)__init_begin)
> +		return false;
> +	if (patch_addr >= (unsigned int *)__init_end)
> +		return false;
> +	return true;
> +}

Can we use the existing function init_section_contains() instead of this 
new function ?

> +
> +static inline bool init_freed(void)
> +{
> +	return (system_state >= SYSTEM_RUNNING);
> +}
> +

I would call this function differently, for instance init_is_finished(), 
because as you mentionned it doesn't exactly mean that init memory is freed.

>   static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
>   			       unsigned int *patch_addr)
>   {
>   	int err;
>   
> +	/* Make sure we aren't patching a freed init section */
> +	if (in_init_section(patch_addr) && init_freed()) {

The test must be done on exec_addr, not on patch_addr, as patch_addr is 
the address where the instruction as been remapped RW for allowing its 
modification.

Also I think it should be tested the other way round, because the 
init_freed() is a simpler test which will be false most of the time once 
the system is running so it should be checked first.

> +		printk(KERN_DEBUG "Skipping init section patching addr: 0x%lx\n",

Maybe use pr_debug() instead.

> +			(unsigned long)patch_addr);

Please align second line as per Codying style.

> +		return 0;
> +	}
> +
>   	__put_user_size(instr, patch_addr, 4, err);
>   	if (err)
>   		return err;
> 

I think it would be better to put this verification in 
patch_instruction() instead, to avoid RW mapping/unmapping the 
instruction to patch when we are not going to do the patching.

Christophe

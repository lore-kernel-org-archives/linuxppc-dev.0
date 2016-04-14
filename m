Return-Path: <mbenes@suse.cz>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlzmB58rmzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 22:01:30 +1000 (AEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qlzm95Xz0z9sD9
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Apr 2016 22:01:29 +1000 (AEST)
Date: Thu, 14 Apr 2016 14:01:20 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jikos@kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH 2/5] livepatch: Allow architectures to specify an alternate
 ftrace location
In-Reply-To: <1460552003-15409-3-git-send-email-mpe@ellerman.id.au>
Message-ID: <alpine.LNX.2.00.1604141354130.10605@pobox.suse.cz>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <1460552003-15409-3-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Apr 2016, Michael Ellerman wrote:

> When livepatch tries to patch a function it takes the function address
> and asks ftrace to install the livepatch handler at that location.
> ftrace will look for an mcount call site at that exact address.
> 
> On powerpc the mcount location is not the first instruction of the
> function, and in fact it's not at a constant offset from the start of
> the function. To accommodate this add a hook which arch code can
> override to customise the behaviour.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  kernel/livepatch/core.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index d68fbf63b083..b0476bb30f92 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -298,6 +298,19 @@ unlock:
>  	rcu_read_unlock();
>  }
>  
> +/*
> + * Convert a function address into the appropriate ftrace location.
> + *
> + * Usually this is just the address of the function, but on some architectures
> + * it's more complicated so allow them to provide a custom behaviour.
> + */
> +#ifndef klp_get_ftrace_location
> +static unsigned long klp_get_ftrace_location(unsigned long faddr)
> +{
> +	return faddr;
> +}
> +#endif

Whoah, what an ugly hack :)

Note to my future self - This is what you want to do if you need a weak 
static inline function.

static inline is probably unnecessary here so __weak function would be 
enough. It would introduce powerpc-specific livepatch.c though because of 
it and this is not worth it.

>  static void klp_disable_func(struct klp_func *func)
>  {
>  	struct klp_ops *ops;
> @@ -312,8 +325,14 @@ static void klp_disable_func(struct klp_func *func)
>  		return;
>  
>  	if (list_is_singular(&ops->func_stack)) {
> +		unsigned long ftrace_loc;

This is a nit, but could you move the definition up to have them all in 
one place to be consistent with the rest of the code? The same applies to 
klp_enable_func() below.

> +
> +		ftrace_loc = klp_get_ftrace_location(func->old_addr);
> +		if (WARN_ON(!ftrace_loc))
> +			return;
> +
>  		WARN_ON(unregister_ftrace_function(&ops->fops));
> -		WARN_ON(ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0));
> +		WARN_ON(ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0));
>  
>  		list_del_rcu(&func->stack_node);
>  		list_del(&ops->node);
> @@ -338,6 +357,15 @@ static int klp_enable_func(struct klp_func *func)
>  
>  	ops = klp_find_ops(func->old_addr);
>  	if (!ops) {
> +		unsigned long ftrace_loc;

Here.

> +
> +		ftrace_loc = klp_get_ftrace_location(func->old_addr);
> +		if (!ftrace_loc) {
> +			pr_err("failed to find location for function '%s'\n",
> +				func->old_name);
> +			return -EINVAL;
> +		}
> +
>  		ops = kzalloc(sizeof(*ops), GFP_KERNEL);
>  		if (!ops)
>  			return -ENOMEM;
> @@ -352,7 +380,7 @@ static int klp_enable_func(struct klp_func *func)
>  		INIT_LIST_HEAD(&ops->func_stack);
>  		list_add_rcu(&func->stack_node, &ops->func_stack);
>  
> -		ret = ftrace_set_filter_ip(&ops->fops, func->old_addr, 0, 0);
> +		ret = ftrace_set_filter_ip(&ops->fops, ftrace_loc, 0, 0);
>  		if (ret) {
>  			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
>  			       func->old_name, ret);
> @@ -363,7 +391,7 @@ static int klp_enable_func(struct klp_func *func)
>  		if (ret) {
>  			pr_err("failed to register ftrace handler for function '%s' (%d)\n",
>  			       func->old_name, ret);
> -			ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0);
> +			ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0);
>  			goto err;
>  		}

Otherwise it is ok.

Miroslav

Return-Path: <mbenes@suse.cz>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPW3j6cZGzDqGd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 21:25:53 +1100 (AEDT)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qPW3h6gd7z9sdQ
 for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2016 21:25:52 +1100 (AEDT)
Date: Tue, 15 Mar 2016 11:25:48 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Balbir Singh <bsingharora@gmail.com>
cc: linuxppc-dev@ozlabs.org, duwe@lst.de, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 Torsten Duwe <duwe@suse.de>
Subject: Re: [PATCH][v6][RFC] livepatch/ppc: Enable livepatching on powerpc
In-Reply-To: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
Message-ID: <alpine.LNX.2.00.1603151113020.20252@pobox.suse.cz>
References: <1457506780-19556-1-git-send-email-bsingharora@gmail.com>
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

On Wed, 9 Mar 2016, Balbir Singh wrote:

> 
> The previous revision was nacked by Torsten, but compared to the alternatives
> at hand I think we should test this approach. Ideally we want all the complexity
> of live-patching in the live-patching code and not in the patch. The other option
> is to accept v4 and document the limitation to patch writers of not patching
> functions > 8 arguments or marking such functions as notrace or equivalent

So I tried to read all the relevant emails and I must admit I am quite 
lost. Unfortunately I cannot help much with powerpc part as my knowledge 
is close to zero, but from live patching perspective there are only two 
sustainable solutions (in my opinion). First, make it work transparently 
for a patch writer. So no inline asm in patched functions. Second, make it 
impossible to patch such problematic functions and document it as a 
limitation. Well, this would be sad for sure.

So I think we are on the same page. Hopefully.

One or two nits follow.

>  static void klp_disable_func(struct klp_func *func)
>  {
>  	struct klp_ops *ops;
> +	unsigned long ftrace_loc;
>  
>  	if (WARN_ON(func->state != KLP_ENABLED))
>  		return;
>  	if (WARN_ON(!func->old_addr))
>  		return;
>  
> +	ftrace_loc = klp_get_ftrace_location(func->old_addr);
> +	if (WARN_ON(!ftrace_loc))
> +		return;
> +

WARN_ON here in klp_disable_func() is reasonable, because we registered a 
stub for the function successfully, so something really wrong must 
happened...

>  	ops = klp_find_ops(func->old_addr);
>  	if (WARN_ON(!ops))
>  		return;
>  
>  	if (list_is_singular(&ops->func_stack)) {
>  		WARN_ON(unregister_ftrace_function(&ops->fops));
> -		WARN_ON(ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0));
> +		WARN_ON(ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0));
>  
>  		list_del_rcu(&func->stack_node);
>  		list_del(&ops->node);
> @@ -328,6 +345,7 @@ static void klp_disable_func(struct klp_func *func)
>  static int klp_enable_func(struct klp_func *func)
>  {
>  	struct klp_ops *ops;
> +	unsigned long ftrace_loc;
>  	int ret;
>  
>  	if (WARN_ON(!func->old_addr))
> @@ -336,6 +354,10 @@ static int klp_enable_func(struct klp_func *func)
>  	if (WARN_ON(func->state != KLP_DISABLED))
>  		return -EINVAL;
>  
> +	ftrace_loc = klp_get_ftrace_location(func->old_addr);
> +	if (WARN_ON(!ftrace_loc))
> +		return -EINVAL;
> +

But here it might be too strong. I think simple

if (!ftrace_loc) {
	pr_err("...");
	return -EINVAL;
}

would be enough I guess.

>  	ops = klp_find_ops(func->old_addr);
>  	if (!ops) {
>  		ops = kzalloc(sizeof(*ops), GFP_KERNEL);
> @@ -352,7 +374,7 @@ static int klp_enable_func(struct klp_func *func)
>  		INIT_LIST_HEAD(&ops->func_stack);
>  		list_add_rcu(&func->stack_node, &ops->func_stack);
>  
> -		ret = ftrace_set_filter_ip(&ops->fops, func->old_addr, 0, 0);
> +		ret = ftrace_set_filter_ip(&ops->fops, ftrace_loc, 0, 0);
>  		if (ret) {
>  			pr_err("failed to set ftrace filter for function '%s' (%d)\n",
>  			       func->old_name, ret);
> @@ -363,7 +385,7 @@ static int klp_enable_func(struct klp_func *func)
>  		if (ret) {
>  			pr_err("failed to register ftrace handler for function '%s' (%d)\n",
>  			       func->old_name, ret);
> -			ftrace_set_filter_ip(&ops->fops, func->old_addr, 1, 0);
> +			ftrace_set_filter_ip(&ops->fops, ftrace_loc, 1, 0);
>  			goto err;
>  		}

Thinking about it, we need ftrace_loc only in cases where we call 
ftrace_set_filter_ip() right? So we can move klp_get_ftrace_location() 
call to appropriate if branch both in klp_disable_func() and 
klp_enable_func().

Thanks,
Miroslav

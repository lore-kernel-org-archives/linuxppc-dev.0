Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id 4310AB7D15
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 16:35:31 +1100 (EST)
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by fgwmail8.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o18565eZ026567 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Mon, 8 Feb 2010 14:06:05 +0900
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o18563IP013041 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Mon, 8 Feb 2010 14:06:03 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3132C45DE52
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 14:06:03 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id F0C9A45DE4F
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 14:06:02 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D9284E38006
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 14:06:02 +0900 (JST)
Received: from m108.s.css.fujitsu.com (m108.s.css.fujitsu.com [10.249.87.108])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 88EAF1DB8040
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 14:06:02 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Restrict stack space reservation to rlimit
In-Reply-To: <18033.1265587672@neuling.org>
References: <10125.1265451732@neuling.org> <18033.1265587672@neuling.org>
Message-Id: <20100208140323.FB52.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Date: Mon,  8 Feb 2010 14:06:01 +0900 (JST)
Cc: stable@kernel.org, aeb@cwi.nl, James Morris <jmorris@namei.org>,
	miltonm@bga.com, Oleg Nesterov <oleg@redhat.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, kosaki.motohiro@jp.fujitsu.com,
	WANG Cong <xiyou.wangcong@gmail.com>,
	linux-fsdevel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

> apkm, linus: this or something like it needs to go into 2.6.33 (& 32) to
> fix 'ulimit -s'.  

"fix ulimit -s" is too cool explanation ;-)
we are not ESPer. please consider to provide what bug is exist.


> Mikey
> 
> [PATCH] Restrict stack space reservation to rlimit
> 
> When reserving stack space for a new process, make sure we're not
> attempting to allocate more than rlimit allows.
> 
> Also, reserve the same stack size independent of page size.

Why do we need page size independent stack size? It seems to have
compatibility breaking risk.


> 
> This fixes a bug unmasked by fc63cf237078c86214abcb2ee9926d8ad289da9b
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Cc: Anton Blanchard <anton@samba.org>
> Cc: stable@kernel.org
> ---
>  fs/exec.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Index: clone1/fs/exec.c
> ===================================================================
> --- clone1.orig/fs/exec.c
> +++ clone1/fs/exec.c
> @@ -554,7 +554,7 @@ static int shift_arg_pages(struct vm_are
>  	return 0;
>  }
>  
> -#define EXTRA_STACK_VM_PAGES	20	/* random */
> +#define EXTRA_STACK_VM_SIZE	81920UL	/* randomly 20 4K pages */
>  
>  /*
>   * Finalizes the stack vm_area_struct. The flags and permissions are updated,
> @@ -627,10 +627,13 @@ int setup_arg_pages(struct linux_binprm 
>  			goto out_unlock;
>  	}
>  
> +	stack_base = min(EXTRA_STACK_VM_SIZE,
> +			 current->signal->rlim[RLIMIT_STACK].rlim_cur) -
> +		PAGE_SIZE;
>  #ifdef CONFIG_STACK_GROWSUP
> -	stack_base = vma->vm_end + EXTRA_STACK_VM_PAGES * PAGE_SIZE;
> +	stack_base = vma->vm_end + stack_base;
>  #else
> -	stack_base = vma->vm_start - EXTRA_STACK_VM_PAGES * PAGE_SIZE;
> +	stack_base = vma->vm_start - stack_base;
>  #endif
>  	ret = expand_stack(vma, stack_base);
>  	if (ret)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

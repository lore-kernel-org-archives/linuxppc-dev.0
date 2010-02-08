Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id C37E9B7D1E
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 17:05:47 +1100 (EST)
Received: from m3.gw.fujitsu.co.jp ([10.0.50.73])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o1865kLp007556 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Mon, 8 Feb 2010 15:05:46 +0900
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id B148E45DE56
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 15:05:45 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3572F45DE4F
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 15:05:45 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E445B1DB8040
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 15:05:44 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.249.87.103])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7F5261DB803E
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 15:05:44 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Restrict stack space reservation to rlimit
In-Reply-To: <9729.1265607469@neuling.org>
References: <20100208141716.FB55.A69D9226@jp.fujitsu.com>
	<9729.1265607469@neuling.org>
Message-Id: <20100208145240.FB58.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Date: Mon,  8 Feb 2010 15:05:42 +0900 (JST)
Cc: stable@kernel.org, aeb@cwi.nl, Oleg Nesterov <oleg@redhat.com>,
	miltonm@bga.com, James Morris <jmorris@namei.org>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, kosaki.motohiro@jp.fujitsu.com,
	WANG Cong <xiyou.wangcong@gmail.com>,
	linux-fsdevel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > >  
> > > Hi,
> > > 
> > > > Why do we need page size independent stack size? It seems to have
> > > > compatibility breaking risk.
> > > 
> > > I don't think so. The current behaviour is clearly wrong, we dont need a
> > > 16x larger stack just because you went from a 4kB to a 64kB base page
> > > size. The user application stack usage is the same in both cases.
> > 
> > I didn't discuss which behavior is better. Michael said he want to apply
> > his patch to 2.6.32 & 2.6.33. stable tree never accept the breaking
> > compatibility patch.
> > 
> > Your answer doesn't explain why can't we wait it until next merge window.
> > 
> > btw, personally, I like page size indepent stack size. but I'm not sure
> > why making stack size independency is related to bug fix.
> 
> I tend to agree.  
> 
> Below is just the bug fix to limit the reservation size based rlimit.
> We still reserve different stack sizes based on the page size as
> before (unless we hit rlimit of course).

Thanks.

I agree your patch in almost part. but I have very few requests.


> Mikey
> 
> Restrict stack space reservation to rlimit
> 
> When reserving stack space for a new process, make sure we're not
> attempting to allocate more than rlimit allows.
> 
> This fixes a bug cause by b6a2fea39318e43fee84fa7b0b90d68bed92d2ba 
> "mm: variable length argument support" and unmasked by
> fc63cf237078c86214abcb2ee9926d8ad289da9b 
> "exec: setup_arg_pages() fails to return errors".

Your initial mail have following problem use-case. please append it
into the patch description.

	On recent ppc64 kernels, limiting the stack (using 'ulimit -s blah') is
	now more restrictive than it was before.  On 2.6.31 with 4k pages I
	could run 'ulimit -s 16; /usr/bin/test' without a problem.  Now with
	mainline, even 'ulimit -s 64; /usr/bin/test' gets killed.


> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Cc: Anton Blanchard <anton@samba.org>
> Cc: stable@kernel.org
> ---
>  fs/exec.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6-ozlabs/fs/exec.c
> ===================================================================
> --- linux-2.6-ozlabs.orig/fs/exec.c
> +++ linux-2.6-ozlabs/fs/exec.c
> @@ -627,10 +627,13 @@ int setup_arg_pages(struct linux_binprm 
>  			goto out_unlock;
>  	}
>  
> +	stack_base = min(EXTRA_STACK_VM_PAGES * PAGE_SIZE,
> +			 current->signal->rlim[RLIMIT_STACK].rlim_cur -
> +			   PAGE_SIZE);

This line is a bit unclear why "- PAGE_SIZE" is necessary.
personally, I like following likes explicit comments.

	stack_expand = EXTRA_STACK_VM_PAGES * PAGE_SIZE;
	stack_lim = ACCESS_ONCE(rlim[RLIMIT_STACK].rlim_cur);

	/* Initial stack must not cause stack overflow. */
	if (stack_expand + PAGE_SIZE > stack_lim)
		stack_expand = stack_lim - PAGE_SIZE;

note: accessing rlim_cur require ACCESS_ONCE.


Thought?


>  #ifdef CONFIG_STACK_GROWSUP
> -	stack_base = vma->vm_end + EXTRA_STACK_VM_PAGES * PAGE_SIZE;
> +	stack_base = vma->vm_end + stack_base;
>  #else
> -	stack_base = vma->vm_start - EXTRA_STACK_VM_PAGES * PAGE_SIZE;
> +	stack_base = vma->vm_start - stack_base;
>  #endif
>  	ret = expand_stack(vma, stack_base);
>  	if (ret)
> 

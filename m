Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk0FF2HxQzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 16:16:17 +1000 (AEST)
Message-ID: <1460355375.3444.6.camel@ellerman.id.au>
Subject: Ping? Re: [PATCH] sched/cpuacct: Check for NULL when using
 task_pt_regs()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>, Peter Zijlstra
 <peterz@infradead.org>,  Ingo Molnar <mingo@kernel.org>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, tglx@linutronix.de,
 efault@gmx.de, htejun@gmail.com, linux-kernel@vger.kernel.org,
 tj@kernel.org,  torvalds@linux-foundation.org, zhaolei@cn.fujitsu.com,
 yangds.fnst@cn.fujitsu.com, hpa@zytor.com, Stephen Rothwell
 <sfr@canb.auug.org.au>,  linuxppc-dev@lists.ozlabs.org
Date: Mon, 11 Apr 2016 16:16:15 +1000
In-Reply-To: <20160406215950.04bc3f0b@kryten>
References: <aa171da036b520b51c79549e9b3215d29473f19d.1458635566.git.zhaolei@cn.fujitsu.com>
 <tip-d740037fac7052e49450f6fa1454f1144a103b55@git.kernel.org>
 <20160404140312.GA28495@linux.vnet.ibm.com>
 <20160406065436.GB3078@gmail.com> <20160406203219.788ae7cf@kryten>
 <20160406110803.GI2906@worktop> <20160406215950.04bc3f0b@kryten>
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

Hi Peter/Ingo,

On Wed, 2016-04-06 at 21:59 +1000, Anton Blanchard wrote:
> Hi Peter,
> 
> > Ah, so sometihng like:
> > 
> > 	struct pt_regs *regs = task_pt_regs();
> > 	int index = CPUACCT_USAGE_SYSTEM;
> > 
> > 	if (regs && user_mode(regs))
> > 		index = CPUACCT_USAGE_USER;
> > 
> > should work, right?
> 
> Looks good, and the patch below does fix the oops for me.

Can we get this merged please? It's blocking all my boot tests.

If anyone's bothered:

Fixes: d740037fac70 ("sched/cpuacct: Split usage accounting into user_usage and sys_usage")

cheers

> task_pt_regs() can return NULL for kernel threads, so add a check.
> This fixes an oops at boot on ppc64.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> index df947e0..41f85c4 100644
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -316,12 +316,11 @@ static struct cftype files[] = {
>  void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>  {
>  	struct cpuacct *ca;
> -	int index;
> +	int index = CPUACCT_USAGE_SYSTEM;
> +	struct pt_regs *regs = task_pt_regs(tsk);
>  
> -	if (user_mode(task_pt_regs(tsk)))
> +	if (regs && user_mode(regs))
>  		index = CPUACCT_USAGE_USER;
> -	else
> -		index = CPUACCT_USAGE_SYSTEM;
>  
>  	rcu_read_lock();
>  
> 

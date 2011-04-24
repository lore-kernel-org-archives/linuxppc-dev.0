Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BD5AF1007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 24 Apr 2011 18:04:35 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id p3O84NKC004802
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Apr 2011 18:04:23 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3O84NZv2552052
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Apr 2011 18:04:23 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p3O84McJ004330
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Apr 2011 18:04:23 +1000
Date: Sun, 24 Apr 2011 13:34:15 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 3/5] powerpc, hw_breakpoints: Fix racy access to ptrace
	breakpoints
Message-ID: <20110424080414.GB1958@in.ibm.com>
References: <1302284067-7860-4-git-send-email-fweisbec@gmail.com>
	<1303478187-2367-1-git-send-email-fweisbec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303478187-2367-1-git-send-email-fweisbec@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Will Deacon <will.deacon@arm.com>,
	LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>,
	LPPC <linuxppc-dev@lists.ozlabs.org>, "v2.6.33.." <stable@kernel.org>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 22, 2011 at 03:16:27PM +0200, Frederic Weisbecker wrote:
> (resend with ppc list in cc)
> 
> While the tracer accesses ptrace breakpoints, the child task may
> concurrently exit due to a SIGKILL and thus release its breakpoints
> at the same time. We can then dereference some freed pointers.
> 
> To fix this, hold a reference on the child breakpoints before
> manipulating them.
> 
> Reported-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Prasad <prasad@linux.vnet.ibm.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: v2.6.33.. <stable@kernel.org>
> ---
>  arch/powerpc/kernel/ptrace.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 55613e3..4edeeb3 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -1591,7 +1591,10 @@ long arch_ptrace(struct task_struct *child, long request,
>  	}
> 
>  	case PTRACE_SET_DEBUGREG:
> +		if (ptrace_get_breakpoints(child) < 0)
> +			return -ESRCH;
>  		ret = ptrace_set_debugreg(child, addr, data);
> +		ptrace_put_breakpoints(child);
>  		break;
> 
>  #ifdef CONFIG_PPC64
> -- 
> 1.7.3.2
>

Hi Frederic,
	Looks fine to me.

Acked-by: K.Prasad <prasad@linux.vnet.ibm.com>

Thanks,
K.Prasad 

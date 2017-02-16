Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPRbH39Q1zDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 06:50:35 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1GJnh4H047025
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 14:50:33 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28ndpj5qnq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 14:50:32 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 17 Feb 2017 05:50:30 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 23A023578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 06:50:27 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1GJoJw333554512
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 06:50:27 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1GJnsU3030177
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 06:49:55 +1100
Date: Fri, 17 Feb 2017 01:19:35 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: kprobes: add support for KPROBES_ON_FTRACE
References: <1cc8a5580ae3a642fea137b7fe9c526402d4af33.1487098440.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170215161126.104c1db721182e1e75244125@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170215161126.104c1db721182e1e75244125@kernel.org>
Message-Id: <20170216194935.GF4515@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/02/15 04:11PM, Masami Hiramatsu wrote:
> Hi Naveen,
> 
> On Wed, 15 Feb 2017 00:28:34 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
> > index e51a045f3d3b..a8f414a0b141 100644
> > --- a/arch/powerpc/kernel/optprobes.c
> > +++ b/arch/powerpc/kernel/optprobes.c
> > @@ -70,6 +70,9 @@ static unsigned long can_optimize(struct kprobe *p)
> >  	struct instruction_op op;
> >  	unsigned long nip = 0;
> >  
> > +	if (unlikely(kprobe_ftrace(p)))
> > +		return 0;
> > +
> 
> Hmm, this should not be checked in arch-depend code, since it may duplicate
> code in each arch. Please try below.

Thanks, Masami!

> 
> Thanks,
> 
> commit 897bb304974c1b0c19a4274fea220b175b07f353
> Author: Masami Hiramatsu <mhiramat@kernel.org>
> Date:   Wed Feb 15 15:48:14 2017 +0900
> 
>     kprobes: Skip preparing optprobe if the probe is ftrace-based
>     
>     Skip preparing optprobe if the probe is ftrace-based, since
>     anyway, it must not be optimized (or already optimized by
>     ftrace).
>     
>     Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

This works for me.
Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


Regards,
Naveen


> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index ebb4dad..546a8b1 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -746,13 +746,20 @@ static void kill_optimized_kprobe(struct kprobe *p)
>  	arch_remove_optimized_kprobe(op);
>  }
> 
> +static inline
> +void __prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
> +{
> +	if (!kprobe_ftrace(p))
> +		arch_prepare_optimized_kprobe(op, p);
> +}
> +
>  /* Try to prepare optimized instructions */
>  static void prepare_optimized_kprobe(struct kprobe *p)
>  {
>  	struct optimized_kprobe *op;
> 
>  	op = container_of(p, struct optimized_kprobe, kp);
> -	arch_prepare_optimized_kprobe(op, p);
> +	__prepare_optimized_kprobe(op, p);
>  }
> 
>  /* Allocate new optimized_kprobe and try to prepare optimized instructions */
> @@ -766,7 +773,7 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
> 
>  	INIT_LIST_HEAD(&op->list);
>  	op->kp.addr = p->addr;
> -	arch_prepare_optimized_kprobe(op, p);
> +	__prepare_optimized_kprobe(op, p);
> 
>  	return &op->kp;
>  }
> 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> 

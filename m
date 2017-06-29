Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyyfw3hRczDr1n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:51:20 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TBnDqW046749
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 07:51:18 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bd0ytg4mv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 07:51:18 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 21:51:15 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5TBpE9I10813898
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:51:14 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5TBpBqx029678
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 21:51:12 +1000
Date: Thu, 29 Jun 2017 17:21:11 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 5/7] powerpc/64s: Un-blacklist system_call() from
 kprobes
References: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
 <2832438c5f54ec9bef25ffacedff52c145a53d61.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170629205525.47a7e21f@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629205525.47a7e21f@roar.ozlabs.ibm.com>
Message-Id: <20170629115111.7thfjhjty5uhnvul@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/29 08:55PM, Nicholas Piggin wrote:
> On Thu, 29 Jun 2017 16:11:08 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > It is actually safe to probe system_call() in entry_64.S, but only till
> > we unset MSR_RI. To allow this, add a new symbol system_call_exit()
> > after the mtmsrd and blacklist that. Though the mtmsrd instruction
> > itself is now whitelisted, we won't be allowed to probe on it as we
> > don't allow probing on rfi and mtmsr instructions (checked for in
> > arch_prepare_kprobe()).
> 
> Can you perhaps add a small comment to explain the label
> (and why it's safe to have after the mtmsrd). It could be
> a bit confusing to read if you don't have that detail of
> the tracer in your mind.

Ah, I see. You did ask for this previously, but I thought you were just 
asking for a comment that this is blacklisted, which can be found out by 
looking for the _ASM_NOKPROBE_SYMBOL() further below.

I will add a comment.

Thanks,
Naveen

> 
> Other than that
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> 
> > 
> > Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/entry_64.S | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index c39436706555..7a87427a67cd 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -205,6 +205,7 @@ system_call:			/* label this so stack traces look sane */
> >  	mtmsrd	r11,1
> >  #endif /* CONFIG_PPC_BOOK3E */
> >  
> > +system_call_exit:
> >  	ld	r9,TI_FLAGS(r12)
> >  	li	r11,-MAX_ERRNO
> >  	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
> > @@ -413,7 +414,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
> >  	b	.	/* prevent speculative execution */
> >  #endif
> >  _ASM_NOKPROBE_SYMBOL(system_call_common);
> > -_ASM_NOKPROBE_SYMBOL(system_call);
> > +_ASM_NOKPROBE_SYMBOL(system_call_exit);
> >  
> >  /* Save non-volatile GPRs, if not already saved. */
> >  _GLOBAL(save_nvgprs)
> 

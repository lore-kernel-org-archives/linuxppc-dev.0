Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcj5b1tkfzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 04:37:38 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4UIXmPH145047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:37:32 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2asbb786kw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 14:37:31 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 31 May 2017 04:37:29 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4UIbFTn62849254
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 04:37:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4UIanWf023729
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 04:36:50 +1000
Date: Wed, 31 May 2017 00:06:32 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/jprobes: Validate break handler invocation
 as being due to a jprobe_return()
References: <0572aa31dd57bef6f158ac97d0b666a0c545356a.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
 <d6b0691226623b3499d43dff1e31971ea46df9f9.1494871248.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170517102144.2c1ac103bbfda22589fe40de@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170517102144.2c1ac103bbfda22589fe40de@kernel.org>
Message-Id: <20170530183632.GT19390@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/05/17 10:21AM, Masami Hiramatsu wrote:
> On Mon, 15 May 2017 23:35:04 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Fix a circa 2005 FIXME by implementing a check to ensure that we
> > actually got into the jprobe break handler() due to the trap in
> > jprobe_return().
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/kprobes.c | 20 +++++++++-----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
> > index 19b053475758..1ebeb8c482db 100644
> > --- a/arch/powerpc/kernel/kprobes.c
> > +++ b/arch/powerpc/kernel/kprobes.c
> > @@ -627,25 +627,23 @@ NOKPROBE_SYMBOL(setjmp_pre_handler);
> >  
> >  void __used jprobe_return(void)
> >  {
> > -	asm volatile("trap" ::: "memory");
> > +	asm volatile("jprobe_return_trap:\n"
> > +		     "trap\n"
> > +		     ::: "memory");
> >  }
> >  NOKPROBE_SYMBOL(jprobe_return);
> >  
> > -static void __used jprobe_return_end(void)
> > -{
> > -}
> > -NOKPROBE_SYMBOL(jprobe_return_end);
> > -
> >  int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
> >  {
> >  	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> >  	unsigned long sp;
> >  
> > -	/*
> > -	 * FIXME - we should ideally be validating that we got here 'cos
> > -	 * of the "trap" in jprobe_return() above, before restoring the
> > -	 * saved regs...
> > -	 */
> > +	if (regs->nip != ppc_kallsyms_lookup_name("jprobe_return_trap")) {
> > +		WARN(1, "longjmp_break_handler NIP (0x%lx) does not match jprobe_return_trap (0x%lx)\n",
> > +				regs->nip, ppc_kallsyms_lookup_name("jprobe_return_trap"));
> > +		return 0;
> 
> If you don't handle this break, you shouldn't warn it, because
> program_check_exception() will continue to find how to handle it
> by notify_die(). IOW, please return silently, or just add a
> debug message.

The only reason this can happen is if we hit a third-party installed 
trap while executing a jprobe hook. And given that we run with premption 
disabled, I felt that this is an unlikely scenario.

The reason for adding the check was to guard against issues with looking 
up the symbol (due to some of the ABI aspects). So, I felt a WARN() 
would be good to have and to make it obvious.

I do see your point though. I'm wondering if pr_info() would be better?

Thanks for the review,
- Naveen

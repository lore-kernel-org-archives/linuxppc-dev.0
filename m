Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0006.hostedemail.com
 [216.40.44.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DFDFD1A1043
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 11:28:48 +1100 (AEDT)
Date: Tue, 8 Dec 2015 19:28:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 chuhu@redhat.com
Subject: Re: [RFC][PATCH] ppc: Implement save_stack_trace_regs()
Message-ID: <20151208192844.70fb33e6@gandalf.local.home>
In-Reply-To: <1449620422.6028.6.camel@ellerman.id.au>
References: <20151208135056.718b7668@gandalf.local.home>
 <1449620422.6028.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 09 Dec 2015 11:20:22 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> On Tue, 2015-12-08 at 13:50 -0500, Steven Rostedt wrote:
> 
> > It has come to my attention that kprobe event stack tracing does not
> > work on powerpc.  
> 
> Yep looks like you're right. I didn't realise it was separate from the regular
> stack trace stuff.
> 
> > diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
> > index ea43a347a104..0142c86801ba 100644
> > --- a/arch/powerpc/kernel/stacktrace.c
> > +++ b/arch/powerpc/kernel/stacktrace.c
> > @@ -61,3 +61,10 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
> >  	save_context_stack(trace, tsk->thread.ksp, tsk, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
> > +
> > +void
> > +save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
> > +{
> > +	save_context_stack(trace, regs->gpr[PT_R1], current, 0);  
> 
> In the kernel we would normally use just '1' here rather than 'PT_R1', but it's
> not a huge deal.
> 
> Should I take this via powerpc or do you want it to go in via tracing?
> 

You can take it. And you can replace the PT_R1 if you want. I just
noticed that it was defined, and I try to use macro names instead of
hard coded numbers. I was actually looking for a "PT_SP" :-)

-- Steve

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1CAE1A08BB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 14:30:31 +1100 (AEDT)
Message-ID: <1452483031.31943.6.camel@ellerman.id.au>
Subject: Re: [RFC][PATCH] ppc: Implement save_stack_trace_regs()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 chuhu@redhat.com
Date: Mon, 11 Jan 2016 14:30:31 +1100
In-Reply-To: <20160108175053.04e4296f@gandalf.local.home>
References: <20151208135056.718b7668@gandalf.local.home>
 <1449620422.6028.6.camel@ellerman.id.au>
 <20151208192844.70fb33e6@gandalf.local.home>
 <1449622985.6028.8.camel@ellerman.id.au>
 <20151216122419.385f1306@gandalf.local.home>
 <20160108175053.04e4296f@gandalf.local.home>
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

On Fri, 2016-01-08 at 17:50 -0500, Steven Rostedt wrote:
> On Wed, 16 Dec 2015 12:24:19 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Wed, 09 Dec 2015 12:03:05 +1100
> > Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > > > Should I take this via powerpc or do you want it to go in via tracing?
> > > >
> > > > You can take it. And you can replace the PT_R1 if you want. I just
> > > > noticed that it was defined, and I try to use macro names instead of
> > > > hard coded numbers. I was actually looking for a "PT_SP" :-)
> > >
> > > OK thanks.
> > >
> > > Looks like we actually have:
> > >
> > >   #define kernel_stack_pointer(regs) ((regs)->gpr[1])
> > >
> > > So that would be the most self documenting way to do it I guess, though I've
> > > never actually seen that macro used anywhere before :)
> >
> > Hi,
> >
> > Are you going to take this, or do you want me to?

Sorry, yep I'll take it.

I trimmed the change log a bit, final version below.

cheers


powerpc: Implement save_stack_trace_regs() to enable kprobe stack tracing

It has come to my attention that kprobe event stack tracing does not
work on powerpc. You can see with the following:

  # cd /sys/kernel/debug/tracing
  # echo stacktrace > trace_options
  # echo 'p kfree' > kprobe_events
  # echo 1 > events/kprobes/enable

Will print the following warning:
  save_stack_trace_regs() not implemented yet.

Although save_stack_trace() (which normal event stack traces use) is
implemented, save_stack_trace_regs() which kprobe events use is not.
This is a cheap attempt to implement that function.

Note, This may have issues if a task tries to get a stack trace from
another task with its regs, because it just passes in "current" to
save_context_stack(). But this does solve the issue with stack tracing
kprobe events.

Reported-by: Chunyu Hu <chuhu@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index ea43a347a104..4f24606afc3f 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -61,3 +61,10 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 	save_context_stack(trace, tsk->thread.ksp, tsk, 0);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
+
+void
+save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
+{
+	save_context_stack(trace, regs->gpr[1], current, 0);
+}
+EXPORT_SYMBOL_GPL(save_stack_trace_regs);

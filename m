Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AC7F1A117A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 23:32:52 +1100 (AEDT)
In-Reply-To: <1452483031.31943.6.camel@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Steven Rostedt <rostedt@goodmis.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: chuhu@redhat.com, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: powerpc: Implement save_stack_trace_regs() to enable kprobe stack
 tracing (was [RFC] ppc: Implement save_stack_trace_regs())
Message-Id: <20160112123252.1FC8B140B97@ozlabs.org>
Date: Tue, 12 Jan 2016 23:32:51 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-01 at 03:30:31 UTC, Michael Ellerman wrote:
> On Fri, 2016-01-08 at 17:50 -0500, Steven Rostedt wrote:
> > > Are you going to take this, or do you want me to?
>
> Sorry, yep I'll take it.
>
> I trimmed the change log a bit, final version below.
>
> powerpc: Implement save_stack_trace_regs() to enable kprobe stack tracing
>
> It has come to my attention that kprobe event stack tracing does not
> work on powerpc. You can see with the following:
>
>   # cd /sys/kernel/debug/tracing
>   # echo stacktrace > trace_options
>   # echo 'p kfree' > kprobe_events
>   # echo 1 > events/kprobes/enable
>
> Will print the following warning:
>   save_stack_trace_regs() not implemented yet.
>
> Although save_stack_trace() (which normal event stack traces use) is
> implemented, save_stack_trace_regs() which kprobe events use is not.
> This is a cheap attempt to implement that function.
>
> Note, This may have issues if a task tries to get a stack trace from
> another task with its regs, because it just passes in "current" to
> save_context_stack(). But this does solve the issue with stack tracing
> kprobe events.
>
> Reported-by: Chunyu Hu <chuhu@redhat.com>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/35de3b1aa16842214e0cd7c603

cheers

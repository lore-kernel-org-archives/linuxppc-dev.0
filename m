Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400MWd43tjzDrKY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 02:35:40 +1100 (AEDT)
Date: Mon, 12 Mar 2018 10:35:36 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20180312153536.7avozx64ku4lvd3e@treble>
References: <20180305164928.GA17953@lst.de>
 <20180308162616.yhbymodggnfzpskx@treble>
 <20180309174718.2700b29e@blackhole.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180309174718.2700b29e@blackhole.lan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 09, 2018 at 05:47:18PM +0100, Torsten Duwe wrote:
> On Thu, 8 Mar 2018 10:26:16 -0600
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > This doesn't seem to address some of my previous concerns:
> 
> You're right. That discussion quickly headed towards objtool
> and I forgot about this one paragraph with the remarks.
> 
> > - Bailing on interrupt/exception frames
> 
> That is a good question. My current code keeps unwinding as long
> as the trace looks sane. If the exception frame has a valid code
> pointer in the LR slot it will continue. Couldn't there be cases
> where this is desirable?

I thought we established in the previous discussion that this could
cause some functions to get skipped in the stack trace:

  https://lkml.kernel.org/r/20171219214652.u7qeb7fxov62ttke@treble

> Should this be configurable? Not that
> I have an idea how this situation could occur for a thread
> that is current or sleeping...

Page faults and preemption.

> Michael, Balbir: is that possible? Any Idea how to reliably detect
> an exception frame? My approach would be to look at the next return
> address and compare it to the usual suspects (i.e. collect all 
> "b ret" addresses in the EXCEPTION_COMMON macro, for BookS).

It looks like show_stack() already knows how to do this:

		/*
		 * See if this is an exception frame.
		 * We look for the "regshere" marker in the current frame.
		 */
		if (validate_sp(sp, tsk, STACK_INT_FRAME_SIZE)
		    && stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {

So you could do something similar.

> > - Function graph tracing return address conversion
> > 
> > - kretprobes return address conversion
> 
> You mean like in arch/x86/kernel/unwind_frame.c the call to
> ftrace_graph_ret_addr ?
> 
> Forgive me my directness but I don't see why these should be handled in
> arch-dependent code, other than maybe a hook, if inevitable, that calls
> back into the graph tracer / kretprobes in order to get the proper
> address,

I don't really follow, where exactly would you propose calling
ftrace_graph_ret_addr() from?

> or simply call the trace unreliable in case it finds such a
> return address.

If you're going to make livepatch incompatible with function graph
tracing, there needs to be a good justification for it (and we'd need to
make sure existing users are fine with it).

-- 
Josh

Return-Path: <jpoimboe@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z3Wqd48kJzDsPp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Dec 2017 15:00:12 +1100 (AEDT)
Date: Fri, 22 Dec 2017 22:00:07 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Torsten Duwe <duwe@lst.de>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, live-patching@vger.kernel.org
Subject: Re: [PATCH] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20171223040007.zswbkl5e2wkroz2d@treble>
References: <39bb7180-1adf-4df6-c9ba-c6f92754767f@linux.vnet.ibm.com>
 <20171212113912.GA1907@lst.de>
 <20171212140501.44vf4xcz6jhbqofd@treble>
 <20171215194009.349b04da@roar.ozlabs.ibm.com>
 <20171218025854.angid7h33gnmxsrg@treble>
 <20171218153334.618c0b66@roar.ozlabs.ibm.com>
 <20171218185622.rgoyy5doyh3gyqh5@treble>
 <20171219112833.GA8758@lst.de>
 <20171219214652.u7qeb7fxov62ttke@treble>
 <87shc4ffi1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <87shc4ffi1.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 21, 2017 at 11:10:46PM +1100, Michael Ellerman wrote:
> Josh Poimboeuf <jpoimboe@redhat.com> writes:
> 
> > On Tue, Dec 19, 2017 at 12:28:33PM +0100, Torsten Duwe wrote:
> >> On Mon, Dec 18, 2017 at 12:56:22PM -0600, Josh Poimboeuf wrote:
> >> > On Mon, Dec 18, 2017 at 03:33:34PM +1000, Nicholas Piggin wrote:
> >> > > On Sun, 17 Dec 2017 20:58:54 -0600
> >> > > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >> > > 
> >> > > > On Fri, Dec 15, 2017 at 07:40:09PM +1000, Nicholas Piggin wrote:
> >> > > > > On Tue, 12 Dec 2017 08:05:01 -0600
> >> > > > > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >> > > > >   
> >> > > > > > What about leaf functions?  If a leaf function doesn't establish a stack
> >> > > > > > frame, and it has inline asm which contains a blr to another function,
> >> > > > > > this ABI is broken.  
> >> > > > 
> >> > > > Oops, I meant to say "bl" instead of "blr".
> >> 
> >> You need to save LR, one way or the other. If gcc thinks it's a leaf function and
> >> does not do it, nor does your asm code, you'll return in an endless loop => bug.
> >
> > Ah, so the function's return path would be corrupted, and an unreliable
> > stack trace would be the least of our problems.
> 
> That's mostly true.
> 
> It is possible to save LR somewhere other than the correct stack slot,
> in which case you can return correctly but still confuse the unwinder. A
> function can hide its caller that way.
> 
> It's stupid and we should never do it, but it's not impossible.
> 
> ...
> 
> > So with your proposal, I think I'm convinced that we don't need objtool
> > for ppc64le.  Does anyone disagree?
> 
> I don't disagree, but I'd be happier if we did have objtool support.
> 
> Just because it would give us a lot more certainty that we're doing the
> right thing everywhere, including in hand-coded asm and inline asm.
> 
> It's easy to write powerpc asm such that stack traces are reliable, but
> it is *possible* to break them.

In the unlikely case where some asm code had its own custom stack
format, I guess there are two things which could go wrong:

1) bad LR:

   If LR isn't a kernel text address, the unwinder can stop the stack
   trace, WARN(), and report an error.  Although if we were _extremely_
   unlucky and a random leftover text address just happened to be in the
   LR slot, then the real function would get skipped in the stack trace.
   But even then, it's probably only going to be an asm function getting
   skipped, and we don't patch asm functions anyway, so it shouldn't
   affect livepatch.

2) bad back chain pointer:

   I'm not sure if this is even a reasonable concern.  I doubt it.  But
   if it were to happen, presumably the unwinder would abort the stack
   trace after reading the bad value.  In this case I think the "end"
   check (#4 below) would be sufficient to catch it.

So even if there were some stupid ppc asm code out there with its own
stack magic, it still sounds to me like objtool wouldn't be needed.

> > There are still a few more things that need to be looked at:
> >
> > 1) With function graph tracing enabled, is the unwinder smart enough to
> >    get the original function return address, e.g. by calling
> >    ftrace_graph_ret_addr()?
> 
> No I don't think so.
> 
> > 2) Similar question for kretprobes.
> >
> > 3) Any other issues with generated code (e.g., bpf, ftrace trampolines),
> >    runtime patching (e.g., CPU feature alternatives), kprobes, paravirt,
> >    etc, that might confuse the unwinder?
> 
> We'll have to look, I can't be sure off the top of my head.
> 
> > 4) As a sanity check, it *might* be a good idea for
> >    save_stack_trace_tsk_reliable() to ensure that it always reaches the
> >    end of the stack.  There are several ways to do that:
> >
> >    - If the syscall entry stack frame is always the same size, then the
> >      "end" would simply mean that the stack pointer is at a certain
> >      offset from the end of the task stack page.  However this might not
> >      work for kthreads and idle tasks, unless their stacks also start at
> >      the same offset.  (On x86 we actually standardized the end of stack
> >      location for all tasks, both user and kernel.)
> 
> Yeah it differs between user and kernel.
> 
> >    - If the unwinder can get to the syscall frame, it can presumably
> >      examine regs->msr to check the PR bit to ensure it got all the way
> >      to syscall entry.  But again this might only work for user tasks,
> >      depending on how kernel task stacks are set up.
> 
> That sounds like a good idea. We could possibly mark the last frame of
> kernel tasks somehow.
> 
> >    - Or a different approach would be to do error checking along the
> >      way, and reporting an error for any unexpected conditions.
> >
> >    However, given that backlink/LR corruption doesn't seem possible with
> >    this architecture, maybe #4 would be overkill.  Personally I would
> >    feel more comfortable with an "end" check and a WARN() if it doesn't
> >    reach the end.
> 
> Yeah I agree.

-- 
Josh

Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1Fyt2WTQzDsR6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:28:37 +1100 (AEDT)
Date: Tue, 19 Dec 2017 12:28:33 +0100
From: Torsten Duwe <duwe@lst.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 Jiri Kosina <jkosina@suse.cz>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] On ppc64le we HAVE_RELIABLE_STACKTRACE
Message-ID: <20171219112833.GA8758@lst.de>
References: <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
 <20171020120739.GA20306@lst.de> <1508547548.5662.2.camel@gmail.com>
 <39bb7180-1adf-4df6-c9ba-c6f92754767f@linux.vnet.ibm.com>
 <20171212113912.GA1907@lst.de> <20171212140501.44vf4xcz6jhbqofd@treble>
 <20171215194009.349b04da@roar.ozlabs.ibm.com>
 <20171218025854.angid7h33gnmxsrg@treble>
 <20171218153334.618c0b66@roar.ozlabs.ibm.com>
 <20171218185622.rgoyy5doyh3gyqh5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171218185622.rgoyy5doyh3gyqh5@treble>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 18, 2017 at 12:56:22PM -0600, Josh Poimboeuf wrote:
> On Mon, Dec 18, 2017 at 03:33:34PM +1000, Nicholas Piggin wrote:
> > On Sun, 17 Dec 2017 20:58:54 -0600
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > > On Fri, Dec 15, 2017 at 07:40:09PM +1000, Nicholas Piggin wrote:
> > > > On Tue, 12 Dec 2017 08:05:01 -0600
> > > > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > >   
> > > > > What about leaf functions?  If a leaf function doesn't establish a stack
> > > > > frame, and it has inline asm which contains a blr to another function,
> > > > > this ABI is broken.  
> > > 
> > > Oops, I meant to say "bl" instead of "blr".

You need to save LR, one way or the other. If gcc thinks it's a leaf function and
does not do it, nor does your asm code, you'll return in an endless loop => bug.

> > > > > Also, even for non-leaf functions, is it possible for GCC to insert the
> > > > > inline asm before it sets up the stack frame?  (This is an occasional
> > > > > problem on x86.)  
> > > > 
> > > > Inline asm must not have control transfer out of the statement unless
> > > > it is asm goto.  
> > > 
> > > Can inline asm have calls to other functions?
> > 
> > I don't believe so.
> 
> It's allowed on x86, I don't see why it wouldn't be allowed on powerpc.
> As you mentioned, GCC doesn't pay attention to what's inside asm("").
> 
> > > > > Also, what about hand-coded asm?  
> > > > 
> > > > Should follow the same rules if it uses the stack.  
> > > 
> > > How is that enforced?
> > 
> > It's not, AFAIK. Gcc doesn't understand what's inside asm("").
> 
> Here I was talking about .S files.

asm("") or .S ... the ABI spec is clear, and it's quite easy to follow. You
need a place to save LR before you call another function, and STDU is so
convenient to create a stack frame with a single instruction.
My impression is one would have to be very determined to break the ABI
deliberately.


> > > > > In addition to fixing the above issues, the unwinder also needs to
> > > > > detect interrupts (i.e., preemption) and page faults on the stack of a
> > > > > blocked task.  If a function were preempted before it created a stack
> > > > > frame, or if a leaf function blocked on a page fault, the stack trace
> > > > > will skip the function's caller, so such a trace will need to be
> > > > > reported to livepatch as unreliable.  
> > > > 
> > > > I don't think there is much problem there for powerpc. Stack frame
> > > > creation and function call with return pointer are each atomic.  
> > > 
> > > What if the function is interrupted before it creates the stack frame?

There should be a pt_regs that shows exactly this situation, see below.

> > Then there will be no stack frame, but you still get the caller address
> > because it's saved in LR register as part of the function call. Then
> > you get the caller's caller in its stack frame.
> 
> Ok.  So what about the interrupted function itself?  Looking at the
> powerpc version of save_context_stack(), it doesn't do anything special
> for exception frames like checking regs->nip.
> 
> Though it looks like that should be possible since show_stack() has a
> way to identify exception frames.

IIRC x86 errors out if a task was interrupted in kernel context. PPC
save_stack_trace_tsk_reliable() could do the same.

Would that be sufficient?

	Torsten

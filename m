Return-Path: <paulus@ozlabs.org>
Date: Wed, 12 May 2010 16:32:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100512063247.GC3548@drongo>
References: <20100414033555.746326035@pr> <20100414034827.GC6571@in.ibm.com>
	<20100503062330.GB19365@drongo> <20100504203302.GA3894@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100504203302.GA3894@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 05, 2010 at 02:03:03AM +0530, K.Prasad wrote:

> It is true that the breakpoint exceptions will go amiss following the
> alignment exception, and be restored when the thread single-steps due
> to other requests causing undesirable effects. (Borrowing from some of
> the discussions I had with BenH, earlier) There can be two ways of
> changing the implementation to counter it:
> 
> - To sense that the impending exception (alignment, page-fault,
>   single-step) is a successor to a hw-breakpoint exception (and that
>   restoration of debug register values is necessary), somewhere early in
>   exceptions-64s.S and jump to a common handler, say
>   do_single_step_dabr() which does a majority of
>   single_step_dabr_instruction().
> - To modify emulate_single_step() to also do a notify_die(DIE_SSTEP,...)
>   in addition to its existing code. This would invoke
>   single_step_dabr_instruction() where the breakpoints can be restored.

I thought you would change the explicit regs->msr modification in
single_step_exception() to clear_single_step(), then just make
emulate_single_step() call single_step_exception().

> I must admit that it is not clear to me when you say "doesn't return to
> the instruction" and "instruction has been changed underneath". Are you

Suppose the address at which the data breakpoint has been unmapped,
and the process has a handler for the SIGSEGV signal.  When we try to
single-step the load or store, we will get a DSI (0x300) interrupt,
call into do_page_fault, and end up sending the process a SIGSEGV.
That will invoke the signal handler, which can then do anything it
likes.  It can do a blocking system call, it can longjmp() back into
its main event, or it can return from the signal handler.  Only in the
last case will it retry the load or store, and then only if the signal
handler hasn't modified the NIP value in the signal frame.  That's
what I mean by "doesn't return to the instruction".

The instruction could be changed underneath us if the program is
multi-threaded and another thread writes another instruction to the
instruction word where the load or store is.  Or it could use mmap()
to map some other page at the address of the load or store.  Either
way we could end up with a different instruction there.

> referring to the fact that the thread which generated breakpoints hits
> could have moved out of the CPU due to a scheduler induced context
> switch (which is an apparent cause for current->thread.last_hit_ubp to
> turn stale) or is there a different source for such a change that I
> don't realise?
> 
> Given that 'last_hit_ubp' is safely ensconced inside 'thread_struct',
> the ill-effects of a possible pre-emption during a page-fault will be
> suitably handled i.e. the pending single-step exception will be
> generated on the processor to which 'current' is migrated to, and the
> breakpoint will be set on the new processor.

If we do get a context switch, e.g. as a result of a page fault, and
then switch back to the task, it looks to me like we will end up with
MSR_SE and DABR both set.  I don't suppose that will actually cause
any real problem besides double-counting the hit.

> However, the possibility that current->thread.last_hit_ubp points to a
> perf_event structure that is unregistered and freed does exist, and I
> did not foresee the risk. An arch-specific function that hooks onto
> release_bp_slot() would be required to perform the cleanup. I will
> submit modify the patch to that effect. Thanks for pointing it out.

Yes, I think we need that.

> In conjunction with what you've stated below, do you suggest that
> emulate_step() be replaced with fix_alignment() which appears to be more
> powerful at emulation (or carve out a helper function for fix_alignment()
> that does only emulation and which can be invoked here)?

Something like that eventually, but not for a first pass.

Paul.

Return-Path: <fweisbec@gmail.com>
Received: from mail-iw0-f196.google.com (mail-iw0-f196.google.com
	[209.85.223.196]) by ozlabs.org (Postfix) with ESMTP id 3F051B7D01
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 07:56:29 +1100 (EST)
Received: by iwn34 with SMTP id 34so216458iwn.15
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 13:56:27 -0700 (PDT)
Date: Tue, 16 Mar 2010 21:56:28 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/perf_events: Implement
	perf_arch_fetch_caller_regs for powerpc
Message-ID: <20100316205609.GA6822@nowhere>
References: <20100315054615.GA6245@drongo> <20100315210450.GF5082@nowhere>
	<20100316032213.GA3656@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100316032213.GA3656@drongo>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, anton@samba.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 16, 2010 at 02:22:13PM +1100, Paul Mackerras wrote:
> On Mon, Mar 15, 2010 at 10:04:54PM +0100, Frederic Weisbecker wrote:
> > On Mon, Mar 15, 2010 at 04:46:15PM +1100, Paul Mackerras wrote:
> 
> > >     14.99%            perf  [kernel.kallsyms]  [k] ._raw_spin_lock
> > >                       |
> > >                       --- ._raw_spin_lock
> > >                          |          
> > >                          |--25.00%-- .alloc_fd
> > >                          |          (nil)
> > >                          |          |          
> > >                          |          |--50.00%-- .anon_inode_getfd
> > >                          |          |          .sys_perf_event_open
> > >                          |          |          syscall_exit
> > >                          |          |          syscall
> > >                          |          |          create_counter
> > >                          |          |          __cmd_record
> > >                          |          |          run_builtin
> > >                          |          |          main
> > >                          |          |          0xfd2e704
> > >                          |          |          0xfd2e8c0
> > >                          |          |          (nil)
> > > 
> > > ... etc.
> > > 
> > > Signed-off-by: Paul Mackerras <paulus@samba.org>
> > 
> > 
> > Cool!
> 
> By the way, I notice that gcc tends to inline the tracing functions,
> which means that by going up 2 stack frames we miss some of the
> functions.  For example, for the lock:lock_acquire event, we have
> _raw_spin_lock() -> lock_acquire() -> trace_lock_acquire() ->
> perf_trace_lock_acquire() -> perf_trace_templ_lock_acquire() ->
> perf_fetch_caller_regs() -> perf_arch_fetch_caller_regs().
> 
> But in the ppc64 kernel binary I just built, gcc inlined
> trace_lock_acquire in lock_acquire, and perf_trace_templ_lock_acquire
> in perf_trace_lock_acquire.  Given that perf_fetch_caller_regs is
> explicitly inlined, going up two levels from perf_fetch_caller_regs
> gets us to _raw_spin_lock, whereas I think you intended it to get us
> to trace_lock_acquire.  I'm not sure what to do about that - any
> thoughts?



Yeah I've indeed seen this, and the problem is especially
the fact perf_trace_templ_lock_acquire may or may not be
inlined.

It is used for trace events that use the TRACE_EVENT_CLASS
thing. We define a pattern of event structure that is shared
among several events.

For example event A and event B share perf_trace_templ_foo.
Both will have a different perf_trace_blah but those
perf_trace_blah will both call the same perf_trace_templ_foo(),
in this case, it won't be inlined.

Events that don't share a pattern will have their
perf_trace_templ inlined, because there will be an exclusive 1:1
relationship between both.

The rewind of 2 is well suited for events sharing a pattern, ip
will match the right event source, and not one of its callers.

Unfortunately, the others are more unlucky.
I didn't mind much about this yet because it  had no bad effect
on lock events. Quite the opposite actually. It's not very interesting
to have lock_acquire as the event source unless you have a callchain.

If you have no callchain, you'll see a lot of such in perf report:

sym1	lock_aquire
sym2	lock_acquire
sym3	lock_acquire

What you want here is the function that called lock_acquire.

But if you have a callchain it's fine, because you have the nature
of the event (lock_aquire) and the origin as well.

That said, lock events are an exception where the mistake
has a lucky result. Other inlined events are harmed as we lose
their most important caller. So I'm going to fix that.

I can just fetch the regs from perf_trace_foo() and pass them
to perf_trace_templ_foo() and here we are.

Thanks.

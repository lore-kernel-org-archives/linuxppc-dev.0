Return-Path: <paulus@ozlabs.org>
Date: Tue, 16 Mar 2010 14:22:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] powerpc/perf_events: Implement
	perf_arch_fetch_caller_regs for powerpc
Message-ID: <20100316032213.GA3656@drongo>
References: <20100315054615.GA6245@drongo>
 <20100315210450.GF5082@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100315210450.GF5082@nowhere>
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

On Mon, Mar 15, 2010 at 10:04:54PM +0100, Frederic Weisbecker wrote:
> On Mon, Mar 15, 2010 at 04:46:15PM +1100, Paul Mackerras wrote:

> >     14.99%            perf  [kernel.kallsyms]  [k] ._raw_spin_lock
> >                       |
> >                       --- ._raw_spin_lock
> >                          |          
> >                          |--25.00%-- .alloc_fd
> >                          |          (nil)
> >                          |          |          
> >                          |          |--50.00%-- .anon_inode_getfd
> >                          |          |          .sys_perf_event_open
> >                          |          |          syscall_exit
> >                          |          |          syscall
> >                          |          |          create_counter
> >                          |          |          __cmd_record
> >                          |          |          run_builtin
> >                          |          |          main
> >                          |          |          0xfd2e704
> >                          |          |          0xfd2e8c0
> >                          |          |          (nil)
> > 
> > ... etc.
> > 
> > Signed-off-by: Paul Mackerras <paulus@samba.org>
> 
> 
> Cool!

By the way, I notice that gcc tends to inline the tracing functions,
which means that by going up 2 stack frames we miss some of the
functions.  For example, for the lock:lock_acquire event, we have
_raw_spin_lock() -> lock_acquire() -> trace_lock_acquire() ->
perf_trace_lock_acquire() -> perf_trace_templ_lock_acquire() ->
perf_fetch_caller_regs() -> perf_arch_fetch_caller_regs().

But in the ppc64 kernel binary I just built, gcc inlined
trace_lock_acquire in lock_acquire, and perf_trace_templ_lock_acquire
in perf_trace_lock_acquire.  Given that perf_fetch_caller_regs is
explicitly inlined, going up two levels from perf_fetch_caller_regs
gets us to _raw_spin_lock, whereas I think you intended it to get us
to trace_lock_acquire.  I'm not sure what to do about that - any
thoughts?

Paul.

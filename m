Return-Path: <paulus@ozlabs.org>
Date: Mon, 7 Jun 2010 21:25:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 0/5] PPC64-HWBKPT: Hardware Breakpoint interfaces - ver
	XXII
Message-ID: <20100607112559.GA2419@brick.ozlabs.ibm.com>
References: <20100528063924.GA8679@in.ibm.com>
	<20100602113316.GA17061@brick.ozlabs.ibm.com>
	<20100604065145.GA2408@in.ibm.com>
	<20100604090648.GC26154@brick.ozlabs.ibm.com>
	<20100607070351.GA3853@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100607070351.GA3853@in.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 07, 2010 at 12:33:51PM +0530, K.Prasad wrote:

> Given that 'ptrace_bps' is used only for ptrace originated breakpoints
> and that we return early i.e. before detecting extraneous interrupts
> in hw_breakpoint_handler() (as shown above) they shouldn't overlap each
> other. The following comment in hw_breakpoint_handler() explains the
> same.
> 		/*
> 		 * To prevent invocation of perf_event_bp(), we shall overload
> 		 * thread.ptrace_bps[] pointer (unused for non-ptrace
> 		 * exceptions) to flag an extraneous interrupt which must be
> 		 * skipped.
> 		 */

My point is that while we are using ptrace_bps[0] to mark a non-ptrace
breakpoint that we're single-stepping, some other process could be
ptracing this process and could get into ptrace_set_debugreg() and
would think that the process already has a ptrace breakpoint and call
modify_user_hw_breakpoint() when it should be calling
register_user_hw_breakpoint().  Or this process could die and so we
call flush_ptrace_hw_breakpoint() and it incorrectly thinks we have a
ptrace breakpoint.

If there is a reason why we can be quite sure that while we are using
current->thread.ptrace_bps[0] in this way, ptrace_set_debugreg() can
never get called with this task as the ptracee, and nor can
flush_ptrace_hw_breakpoint() get called on this task, then maybe it's
safe.  But it's not at all obviously safe.  So I'd very much rather we
just use an extra flag somewhere, that isn't used elsewhere for
anything else, so we can convince ourselves that it is all correct
without having to look at lots of different pieces of code.

There are 3 bytes of padding in struct arch_hw_breakpoint; couldn't we
use one of them as a "not really hit" flag?

Paul.

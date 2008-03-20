Return-Path: <roland@redhat.com>
Received: from QMTA09.westchester.pa.mail.comcast.net
	(qmta09.westchester.pa.mail.comcast.net [76.96.62.96])
	by ozlabs.org (Postfix) with ESMTP id 3E896DDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 18:43:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: unprivileged use of MSR_SE
In-Reply-To: Paul Mackerras's message of  Thursday,
	20 March 2008 15:10:18 +1100
	<18401.58282.992971.923754@cargo.ozlabs.ibm.com>
References: <20080320002407.D911C26F995@magilla.localdomain>
	<18401.58282.992971.923754@cargo.ozlabs.ibm.com>
Message-Id: <20080320074300.30D4026F995@magilla.localdomain>
Date: Thu, 20 Mar 2008 00:43:00 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> No and no.

Good and good!

> On ppc32 there is a sys_debug_setcontext system call that is there to
> allow a process to debug itself.  It does a setcontext and optionally
> sets the MSR_SE or MSR_BE bit.  We don't have it on ppc64 for some
> reason (we should add it).

Wacky.  I only looked in signal_64.c, so I didn't notice this.

> The only MSR bit that sigreturn copies from the signal frame back into
> the MSR is the MSR_LE (little-endian) bit.

So it is.  I looked right at that and saw something different.  It must
have been my psychic abilities trying to tell me about sys_debug_setcontext.

> > Or could sigreturn ignore the MSR_SE bit without breaking any strange user?
> 
> It already does AFAICS.

But sys_debug_setcontext doesn't.  That is, it has user semantics
(sig_dbg_op.dbg_value) that mean setting MSR_SE.  I take it you mean to
preserve that user feature.  For the issue I've been talking about that
makes it equivalent to the x86 popf case.

For example, use syscall tracing to stop at the exit from
sys_debug_setcontext (in a call with dbg->dbg_value!=0).
MSR_SE is set, as it should be.  Now using PTRACE_CONT or PTRACE_SYSCALL
will clear MSR_SE and resume, breaking the user's behavior.

For the analogous problem on x86, we keep a flag saying whether MSR_SE was
set "artificially" by ptrace or was set "for real" in the user state.  We
use a TIF bit, but whatever is optimal.  In user_enable_single_step, set
the forced-SE flag if MSR_SE was clear and don't if it was already set.
In user_disable_single_step, clear the forced-SE flag and only if it was
set, clear MSR_SE.  With that, debugger-step and user-self-step can cooexist.

> OK, I found MSR_DEBUGCHANGE, it's in ptrace.c. :)  So it only applies
> to attempts to change the MSR of a process using ptrace.  So, what you
> want is just to disallow changing MSR via PTRACE_POKEUSR or
> equivalent, then?

If there is no way like sys_debug_setcontext to set MSR_SE as proper user
state, then yes.  If it is possible for a user task to set its own MSR_SE,
then I'd like the forced-SE flag as above.  Then get_user_msr should mask
off MSR_SE when forced-SE is set, and set_user_msr should clear forced-SE
when MSR_SE is set via user_regset (ptrace).  That way user_regset calls
can fetch and restore the complete user-visible state, including the state
just after executing a sys_debug_setcontext requesting self-step.


Thanks,
Roland

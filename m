Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18476.56587.887087.503435@cargo.ozlabs.ibm.com>
Date: Fri, 16 May 2008 11:02:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Corey J Ashford <cjashfor@us.ibm.com>
Subject: Re: Feedback requested on switching the exception wrapper
	used	for	the PMU interrupt on ppc64
In-Reply-To: <OF9F7498FD.1A1E4CC2-ON8725744B.000071C8-8825744B.00026A92@us.ibm.com>
References: <18476.51426.864747.201527@cargo.ozlabs.ibm.com>
	<OF9F7498FD.1A1E4CC2-ON8725744B.000071C8-8825744B.00026A92@us.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Corey J Ashford writes:

> Thanks for the feedback.  I don't believe I need a separate flag, because
> the PMU interrupt (via the PMAO bit) will still be pending when interrupts
> are hard enabled again, and the handler will be reentered automatically.

If that were the case then we wouldn't have had the problem with
losing PMU interrupts that meant we had to change the PMU interrupt
handler from a MASKABLE_EXCEPTION to a STD_EXCEPTION.  This was in
commit 449d846dbcbf61bdf7d50a923e4791102168c292.

My understanding is that the PMU only requests an interrupt when PMAO
goes from 0 to 1 (i.e. it's edge-triggered).  If the CPU takes the
interrupt and then sets MSR.EE again (e.g. by returning from the
interrupt handler), and PMAO has not been reset to 0, then I don't
think the PMU requests another interrupt at that point.

> I discovered through some trial and error that get_paca() doesn't work
> correctly in the interrupt handler.  It appears that the value of r13 (the
> PACA pointer) is not initialized.  Perhaps r13 is a scratch register used
> by the compiler?

Weird.  It definitely should be correct.  Loading r13 is one of the
first things the interrupt entry code does, and r13 is not a scratch
register (it's normally the thread-local storage pointer).

If r13 is bogus then that's definitely a serious bug.

> Fortunately, because the soft enable flag is available in the pt_regs
> structure, and because the hard enable flag will be set to the same as the
> value of regs->msr's MSR_EE flag in the restore code, I now have this code
> in the interrupt handler:
> 
> void perfmon_pmu_int_handler(struct pt_regs *regs) {
> 
>       if (regs->softe == 0) {
>             /* disable hardware interrupts */
>             regs->msr &= ~MSR_EE;
>             return;
>       }
>       ...
> }
> 
> This code does seem to be working, but needs more testing.

I expect that after a little while you'll stop getting PMU
interrupts...

Paul.

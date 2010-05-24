Return-Path: <paulus@ozlabs.org>
Date: Mon, 24 May 2010 22:24:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 4/4] PPC64-HWBKPT: Enable hw-breakpoints while handling
	intervening signals
Message-ID: <20100524122457.GA6707@brick.ozlabs.ibm.com>
References: <20100524102614.040177456@linux.vnet.ibm.com>
	<20100524103419.GE8131@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100524103419.GE8131@in.ibm.com>
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

On Mon, May 24, 2010 at 04:04:19PM +0530, K.Prasad wrote:

> A signal delivered between a hw_breakpoint_handler() and the
> single_step_dabr_instruction() will not have the breakpoint active during
> signal handling (since breakpoint will not be restored through single-stepping
> due to absence of MSR_SE bit on the signal frame). Enable breakpoints before
> signal delivery and clear them during sigreturn() syscall.
> 
> Limitation: Nested hw-breakpoint exceptions (where second exception is raised
> inside signal context) will cause a 'double-hit' i.e. the first breakpoint
> exception will be taken twice.

I don't think this will actually cause a problem.  In the case of a
perf_event breakpoint, the semantics are trigger-after-execute, so the
first hit won't cause a trigger, and perf_event won't double-count it.
In the case of ptrace-style breakpoints, we don't single-step (it's up
to the ptracer to do the single-stepping if needed) so the problem
doesn't arise.

In fact I don't think we even need to do anything on sigreturn.  Yes,
we are changing the NIP but we are changing it to a previous value as
a result of an explicit action by the program, which is a bit
different to what signal delivery and ptrace do.

On signal delivery I was imagining that we would clear the MSR_SE bit
before saving the MSR value in the signal frame, and reinstall the
DABR value at the same time, and then essentially forget that we had
already hit the breakpoint once and just wait for it to hit again.

Paul.

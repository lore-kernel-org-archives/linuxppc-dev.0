Return-Path: <paulus@ozlabs.org>
Date: Thu, 27 May 2010 16:20:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 3/4] PPC64-HWBKPT: Handle concurrent alignment interrupts
Message-ID: <20100527062044.GB4105@drongo>
References: <20100525083055.342788418@linux.vnet.ibm.com>
	<20100525091435.GD29003@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100525091435.GD29003@in.ibm.com>
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

On Tue, May 25, 2010 at 02:44:35PM +0530, K.Prasad wrote:

> An alignment interrupt may intervene between a DSI/hw-breakpoint exception
> and the single-step exception. Enable the alignment interrupt (through
> modifications to emulate_single_step()) to notify the single-step exception
> handler for proper restoration of hw-breakpoints.
> 
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/traps.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6.ppc64_test/arch/powerpc/kernel/traps.c
> ===================================================================
> --- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/traps.c
> +++ linux-2.6.ppc64_test/arch/powerpc/kernel/traps.c
> @@ -602,7 +602,7 @@ void RunModeException(struct pt_regs *re
>  
>  void __kprobes single_step_exception(struct pt_regs *regs)
>  {
> -	regs->msr &= ~(MSR_SE | MSR_BE);  /* Turn off 'trace' bits */
> +	clear_single_step(regs);
>  
>  	if (notify_die(DIE_SSTEP, "single_step", regs, 5,
>  					5, SIGTRAP) == NOTIFY_STOP)
> @@ -621,10 +621,7 @@ void __kprobes single_step_exception(str
>   */
>  static void emulate_single_step(struct pt_regs *regs)
>  {
> -	if (single_stepping(regs)) {
> -		clear_single_step(regs);
> -		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
> -	}
> +	single_step_exception(regs);
>  }

We still need the if (single_stepping(regs)) in emulate_single_step.
We don't want to send the process a SIGTRAP every time it gets an
alignment interrupt. :)

Paul.

Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Subject: Re: [PATCH] Enable hardware breakpoint upon re-registering
In-reply-to: <20121105081527.29141.11384.stgit@aravinda>
References: <20121105081527.29141.11384.stgit@aravinda>
Date: Wed, 07 Nov 2012 07:53:26 +1100
Message-ID: <24260.1352235206@neuling.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, fweisbec@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:

> On powerpc, ptrace will disable hardware breakpoint request once the
> breakpoint is hit. It is the responsibility of the caller to set it
> again. However, when the caller sets the hardware breakpoint again
> using ptrace(PTRACE_SET_DEBUGREG, child_pid, 0, addr), the hardware
> breakpoint is not enabled.
> 
> While gdb's approach is to unregister and re-register the hardware
> breakpoint every time the breakpoint is hit - which is working fine,
> this could affect other programs trying to re-register hardware
> breakpoint without unregistering.
> 
> This patch enables hardware breakpoint if the caller is re-registering.
> 
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

Passes my tests here and I don't think it'll break existing gdb.  So FWIW

Acked-by: Michael Neuling <mikey@neuling.org>

Thanks!

> ---
>  arch/powerpc/kernel/ptrace.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 79d8e56..09371d0 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -952,6 +952,10 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
>  		arch_bp_generic_fields(data &
>  					(DABR_DATA_WRITE | DABR_DATA_READ),
>  							&attr.bp_type);
> +
> +		/* Enable breakpoint */
> +		attr.disabled = false;
> +
>  		ret =  modify_user_hw_breakpoint(bp, &attr);
>  		if (ret) {
>  			ptrace_put_breakpoints(task);
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

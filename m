Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2098DDE3C
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 10:34:29 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc: FULL_REGS on exec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20070924235244.2F3BB4D04B7@magilla.localdomain>
References: <20070924235244.2F3BB4D04B7@magilla.localdomain>
Content-Type: text/plain
Date: Tue, 25 Sep 2007 10:34:20 +1000
Message-Id: <1190680460.12382.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: David Woodhouse <dwmw2@redhat.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-09-24 at 16:52 -0700, Roland McGrath wrote:
> When PTRACE_O_TRACEEXEC is used, a ptrace call to fetch the registers at
> the PTRACE_EVENT_EXEC stop (PTRACE_PEEKUSR) will oops in CHECK_FULL_REGS.
> With recent versions, "gdb --args /bin/sh -c 'exec /bin/true'" and "run" at
> the (gdb) prompt is sufficient to produce this.  I also have written an
> isolated test case, see https://bugzilla.redhat.com/show_bug.cgi?id=301791#c15.
> 
> This change fixes the problem by clearing the low bit of pt_regs.trap in
> start_thread so that FULL_REGS is true again.  This is correct since all of
> the GPRs that "full" refers to are cleared in start_thread.

Looks good, nice catch.

> Signed-off-by: Roland McGrath <roland@redhat.com>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/kernel/process.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index e477c9d..fd799d2 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -605,6 +605,13 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
>  	regs->ccr = 0;
>  	regs->gpr[1] = sp;
>  
> +	/*
> +	 * We have just cleared all the nonvolatile GPRs, so make
> +	 * FULL_REGS(regs) return true.  This is necessary to allow
> +	 * ptrace to examine the thread immediately after exec.
> +	 */
> +	regs->trap &= ~1UL;
> +
>  #ifdef CONFIG_PPC32
>  	regs->mq = 0;
>  	regs->nip = start;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
